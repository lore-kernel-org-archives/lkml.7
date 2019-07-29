Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850E5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFE1206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nfAVIyvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbfG2LHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:07:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbfG2LHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J8SecCHFAYNhISRn2gyDpuWW772w3hItu/yd4iRurZs=; b=nfAVIyvwOvu5mJxYbjzOPhZdx
        uugr83y7XKK1cjiO5jGGjHsCheAhouPpGABKL/0NlIFNBX/rvxEJlhTnOnuSVsat8iR6MBWyB6JUc
        QqAso2peSPdD8xVCuYdDlNN/ejrScq524Y8WsgGyJDtn9ImNR8qI0CQGZnqpf/r8uO9jPMnFfrJe+
        XIZm006y2L5N5Dhn30XW2aXq9tS86Ct9jRgW1uiK4IrnjSmbZfedvuxrLGEAcYgFQYBMaoITo9Ztl
        yM6ZVEiwTE6BnTSErwTFei4lE0DPe6uv1eauzupGx2diDo5+dtXK19AihtiZ5m4P/ZyCGMzkfBJ72
        DktEcOZfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs3V3-0005yc-UH; Mon, 29 Jul 2019 11:07:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A051A20B51713; Mon, 29 Jul 2019 13:07:27 +0200 (CEST)
Date:   Mon, 29 Jul 2019 13:07:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] locking/mutex: Use mutex flags macro instead of hard
 code value
Message-ID: <20190729110727.GB31398@hirez.programming.kicks-ass.net>
References: <1564397578-28423-1-git-send-email-mojha@codeaurora.org>
 <1564397578-28423-2-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564397578-28423-2-git-send-email-mojha@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 04:22:58PM +0530, Mukesh Ojha wrote:
> Let's use the mutex flag macro(which got moved from mutex.c
> to linux/mutex.h in the last patch) instead of hard code
> value which was used in __mutex_owner().
> 
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>  include/linux/mutex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 79b28be..c3833ba 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -87,7 +87,7 @@ struct mutex {
>   */
>  static inline struct task_struct *__mutex_owner(struct mutex *lock)
>  {
> -	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
> +	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
>  }

I would _much_ rather move __mutex_owner() out of line, you're exposing
far too much stuff.
