Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A29C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DF92087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558097158;
	bh=i3CMfF/aIsFewy+b9X8g+UyQA/hse7ha4mOnojXwLTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rWRnozWIIqetjFr/zim/iJ8L3oicjjuXtSrzpz3Xlj87Z4mlBxIs5ZQC5nDpIDMnM
	 w0TbegZXXRiGlHabtdjMElmUlWSjopLczZTY/MY34RxC6+afQSdeD3m03oME5O4plu
	 dDoSX218jNh+RQzf/T+utI4JbTP98T9oogRP2K/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfEQMp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 08:45:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:34538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728207AbfEQMp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:45:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48ECDAF59;
        Fri, 17 May 2019 12:45:56 +0000 (UTC)
Date:   Fri, 17 May 2019 14:45:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/5] proc: use down_read_killable for
 /proc/pid/smaps_rollup
Message-ID: <20190517124555.GB1825@dhcp22.suse.cz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
 <155790967469.1319.14744588086607025680.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790967469.1319.14744588086607025680.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 11:41:14, Konstantin Khlebnikov wrote:
> Ditto.

Proper changelog or simply squash those patches into a single patch if
you do not feel like copy&paste is fun

> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  fs/proc/task_mmu.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 2bf210229daf..781879a91e3b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -832,7 +832,10 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  
>  	memset(&mss, 0, sizeof(mss));
>  
> -	down_read(&mm->mmap_sem);
> +	ret = down_read_killable(&mm->mmap_sem);
> +	if (ret)
> +		goto out_put_mm;

Why not ret = -EINTR. The seq_file code seems to be handling all errors
AFAICS.

> +
>  	hold_task_mempolicy(priv);
>  
>  	for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
> @@ -849,8 +852,9 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  
>  	release_task_mempolicy(priv);
>  	up_read(&mm->mmap_sem);
> -	mmput(mm);
>  
> +out_put_mm:
> +	mmput(mm);
>  out_put_task:
>  	put_task_struct(priv->task);
>  	priv->task = NULL;

-- 
Michal Hocko
SUSE Labs
