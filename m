Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E0DC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D1A229F5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563936866;
	bh=+x9XTiC8SrvgzL/B5yvALtYVfG2kN9dqvh21neUFOwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1hO4dwiOsnYAg5c1Exq4pWdfI0vuTjmG3YsfHCsLbgtzLtSklXWEybKkGDQXZApCE
	 +UC5cyTEHO5onj0vD0aPF493J0toNlSSmvooyKinCChOIAZliUdZapXUJdz6t35QTf
	 mKSKxYZNH1qVWPg7EPzc3oc0ZdUN5eNPpypETBYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfGXCyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfGXCyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:54:25 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C83A82253D;
        Wed, 24 Jul 2019 02:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563936864;
        bh=+x9XTiC8SrvgzL/B5yvALtYVfG2kN9dqvh21neUFOwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSO+wMqUvd/Dz/mBc9t2dMOsqecBmue4RjhieMuPhdb6E6Uwvm46YBb63k86kvOBf
         k4GoYDNA/AuB0u7vC5dt2ldHoFMiBiStW4cG6oSN0K5d8/lSPJ1QxNWPAZ7Rlid3Of
         REPsoMCJiyf1BAYeSONOuHDB7NzRc28vbSyhUBlA=
Date:   Tue, 23 Jul 2019 19:54:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] kexec: Bail out upon SIGKILL when allocating memory.
Message-ID: <20190724025422.GQ643@sol.localdomain>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biederman <ebiederm@xmission.com>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000a861f6058b2699e0@google.com>
 <000000000000c0103a058b2ba0ec@google.com>
 <993c9185-d324-2640-d061-bed2dd18b1f7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993c9185-d324-2640-d061-bed2dd18b1f7@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 07:16:18PM +0900, Tetsuo Handa wrote:
> syzbot found that a thread can stall for minutes inside kexec_load() after
> that thread was killed by SIGKILL [1]. It turned out that the reproducer
> was trying to allocate 2408MB of memory using kimage_alloc_page() from
> kimage_load_normal_segment(). Let's check for SIGKILL before doing memory
> allocation.
> 
> [1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index fd5c95f..2b25d95 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -302,6 +302,8 @@ static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
>  {
>  	struct page *pages;
>  
> +	if (fatal_signal_pending(current))
> +		return NULL;
>  	pages = alloc_pages(gfp_mask & ~__GFP_ZERO, order);
>  	if (pages) {
>  		unsigned int count, i;
> -- 
> 1.8.3.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/993c9185-d324-2640-d061-bed2dd18b1f7%40I-love.SAKURA.ne.jp.
> For more options, visit https://groups.google.com/d/optout.

What happened to this patch?  This bug is still occurring.

- Eric
