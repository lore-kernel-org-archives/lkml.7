Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2472DC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCF22087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558097498;
	bh=pCPFO2CKYjVg71MaCPpDzfC5j8QTXByunWI5/YlRuLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=weUCfr7qNUNI5SvReP4XTX9C/EfcTB+lSlGJwl6DHMsqhanIi2qHV76APz8+dqDFS
	 WzKddlE35c3QHEtV10LAfMK906U41CiaBBJ1uwxLIk45kdznzg1EHVjxPA59SJds3l
	 Z70BKfSDTbRjKsEFGOAICmxeBucyKLyUj6sMdL/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfEQMvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 08:51:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:35714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728100AbfEQMvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:51:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E16BAF59;
        Fri, 17 May 2019 12:51:35 +0000 (UTC)
Date:   Fri, 17 May 2019 14:51:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] mm: use down_read_killable for locking mmap_sem in
 access_remote_vm
Message-ID: <20190517125134.GE1825@dhcp22.suse.cz>
References: <155790847881.2798.7160461383704600177.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790847881.2798.7160461383704600177.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 11:21:18, Konstantin Khlebnikov wrote:
> This function is used by ptrace and proc files like /proc/pid/cmdline and
> /proc/pid/environ. Return 0 (bytes read) if current task is killed.

Please add an explanation about why this is OK (as explained in the
follow up email).

> Mmap_sem could be locked for a long time or forever if something wrong.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory.c |    4 +++-
>  mm/nommu.c  |    3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 96f1d473c89a..2e6846d09023 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4348,7 +4348,9 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
>  	void *old_buf = buf;
>  	int write = gup_flags & FOLL_WRITE;
>  
> -	down_read(&mm->mmap_sem);
> +	if (down_read_killable(&mm->mmap_sem))
> +		return 0;
> +
>  	/* ignore errors, just check how much was successfully transferred */
>  	while (len) {
>  		int bytes, ret, offset;
> diff --git a/mm/nommu.c b/mm/nommu.c
> index b492fd1fcf9f..cad8fb34088f 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1791,7 +1791,8 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	int write = gup_flags & FOLL_WRITE;
>  
> -	down_read(&mm->mmap_sem);
> +	if (down_read_killable(&mm->mmap_sem))
> +		return 0;
>  
>  	/* the access must start within one of the target process's mappings */
>  	vma = find_vma(mm, addr);

-- 
Michal Hocko
SUSE Labs
