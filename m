Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D151C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA202166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558097282;
	bh=l7AbEK9goxA08VX2Aa/7J5Rj37vXKxOONZFzvLmB+SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W14wtnBjNmizTds/RaFfVhLtHd4HtpFsAZsQw9qeKWoOSVWs3gx7kyekOGAIrWVxE
	 V9V3VBLnK0rwl71okd6VIgDdPbM609sMX4Kt2rbnAg84sMLMOYZgogZEKnMur5tnaZ
	 8TxjUi0lyVpLhdHIq5T1luEu3A9p18Eeyqk0xpB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfEQMsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 08:48:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:34926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728287AbfEQMsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:48:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBF60AF59;
        Fri, 17 May 2019 12:47:59 +0000 (UTC)
Date:   Fri, 17 May 2019 14:47:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 4/5] proc: use down_read_killable for /proc/pid/clear_refs
Message-ID: <20190517124759.GD1825@dhcp22.suse.cz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
 <155790968147.1319.10247444846354273332.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790968147.1319.10247444846354273332.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 11:41:21, Konstantin Khlebnikov wrote:
> Replace the only unkillable mmap_sem lock in clear_refs_write.

Poor changelog again.

The change itself looks ok to me.

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  fs/proc/task_mmu.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 78bed6adc62d..7f84d1477b5b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1140,7 +1140,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  			goto out_mm;
>  		}
>  
> -		down_read(&mm->mmap_sem);
> +		if (down_read_killable(&mm->mmap_sem)) {
> +			count = -EINTR;
> +			goto out_mm;
> +		}
>  		tlb_gather_mmu(&tlb, mm, 0, -1);
>  		if (type == CLEAR_REFS_SOFT_DIRTY) {
>  			for (vma = mm->mmap; vma; vma = vma->vm_next) {

-- 
Michal Hocko
SUSE Labs
