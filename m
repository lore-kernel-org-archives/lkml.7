Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295A4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E124B217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555592595;
	bh=7i74W/THEjL44nv5V7mQ6Eet4OX/8R29qm/rFnkagNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gW9DMnsgn+3fOuiTLaMeLDz7Yyob8fXk0gssLqQsF5nDlarGUpyBUeIL3T1DYiNYI
	 u0clmWYm40ccuJJMmTRIACK/wQ0MWBL50Xj5RZdo97NYj/MJSbYWqY6bfqpY/zYGN8
	 g5MmTKRZ/DlGRgTteLC3j3NKJoJuBmZCetiPidU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbfDRNDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:03:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:35612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729497AbfDRNDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:03:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25228B64C;
        Thu, 18 Apr 2019 13:03:12 +0000 (UTC)
Date:   Thu, 18 Apr 2019 15:03:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Koutny <mkoutny@suse.com>
Subject: Re: [PATCH] mm: use mm.arg_lock in get_cmdline()
Message-ID: <20190418130310.GJ6567@dhcp22.suse.cz>
References: <20190418125827.57479-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418125827.57479-1-ldufour@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal has posted the same patch few days ago http://lkml.kernel.org/r/20190417120347.15397-1-mkoutny@suse.com

On Thu 18-04-19 14:58:27, Laurent Dufour wrote:
> The commit 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end
> and env_start|end in mm_struct") introduce the spinlock arg_lock to protect
> the arg_* and env_* field of the mm_struct structure.
> 
> While reading the code, I found that this new spinlock was not used in
> get_cmdline() to protect access to these fields.
> 
> Fixing this even if there is no issue reported yet for this.
> 
> Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  mm/util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 05a464929b3e..789760c3028b 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -758,12 +758,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>  	if (!mm->arg_end)
>  		goto out_mm;	/* Shh! No looking before we're done */
>  
> -	down_read(&mm->mmap_sem);
> +	spin_lock(&mm->arg_lock);
>  	arg_start = mm->arg_start;
>  	arg_end = mm->arg_end;
>  	env_start = mm->env_start;
>  	env_end = mm->env_end;
> -	up_read(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
>  
>  	len = arg_end - arg_start;
>  
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
