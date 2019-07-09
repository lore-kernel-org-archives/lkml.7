Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EDCC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD7720656
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grVm2WAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfGIVqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:46:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36060 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:46:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so41938oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MYX+bKitIKuhlu8Fk10A4x6cbLxiCn6+G+7FkkYZdXE=;
        b=grVm2WAKocF8t+tmT/HihvCR2t3lAwyANm/vTKQtwHLAeF76RNsARgiGzwCP59QOLu
         PaGfbNymbTKDco5C5xg1Vng2+3SgRTxr2dVfLP9VtbcbzCjv8IdRu/ks6lN5+WnRXaKK
         BbWo05mX8glK1+OiwlrlsI0cnjIKa3TtlHoEY/L8mmmFE9BLQ0BAezo7o5GPlvCsTqwZ
         29TMFerSGEKQh+hJgatVzTDIN7UHNomMY2uRYeHUGgl99SqwErY57qp8u1ZlJL6JXXqr
         RccJ94fKzBKPIkAivdiAkd17FIkFYEOx4XUrKUYKnd4imOU+IwKOCaGJlxggSis/qozm
         tpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=MYX+bKitIKuhlu8Fk10A4x6cbLxiCn6+G+7FkkYZdXE=;
        b=F4XG2U/ThO479htHDv/eiXXDFg6+Xx1eB//AAJQB7kutiu7hxDYccRXIpCOC4myZ4r
         OEHJJwWUQaFwQV87klvTUAASncR1Tw9wX1bG/9tY1B0uSz5U1zlw2apuFLNQlhRuXRll
         /oYjIyso0HDS7CHPDPlLgmeJnjPBp0NtOvxMppJRQ4HuIY1GhXQXoaV5BPlBLIaE0Tbv
         Tt82PG78KdnKBuGcxMdMLDhaKcKv3e/XaLi1ve8oCPuuTT8VtL/hWgAEVTKkrteFRD+f
         Y2OVEfQL2Z2yUTcU78oEJoZ8E4vtWU8TtEo04iX+iWVSPWTMZHm6pvaOzLcSEHkPYs52
         6jSw==
X-Gm-Message-State: APjAAAWNRwOu8LybPojJHnYvqk6al8iGdLtw6e/FjLW7qpmLe0RlCqCK
        +781/8bsvDhLHg2oXuG8Dg==
X-Google-Smtp-Source: APXvYqzCdHFAKERg88yoYs2ZV/Vft2Jyh4mrZ1K3HM3dLPrEuiGyLvxGpSX8zPOMSRpPSLk1Nap9lw==
X-Received: by 2002:a9d:6853:: with SMTP id c19mr20299107oto.213.1562708765032;
        Tue, 09 Jul 2019 14:46:05 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id l5sm124032otf.53.2019.07.09.14.46.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 14:46:04 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:6c89:b9b3:d6b4:3203])
        by serve.minyard.net (Postfix) with ESMTPSA id 179C81805A4;
        Tue,  9 Jul 2019 21:46:04 +0000 (UTC)
Date:   Tue, 9 Jul 2019 16:46:02 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190709214602.GD19430@minyard.net>
Reply-To: minyard@acm.org
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 02:06:43PM -0700, Tejun Heo wrote:
> ipmi_thread() uses back-to-back schedule() to poll for command
> completion which, on some machines, can push up CPU consumption and
> heavily tax the scheduler locks leading to noticeable overall
> performance degradation.
> 
> This patch replaces schedule() with usleep_range(100, 200).  This
> allows the sensor readings to finish resonably fast and the cpu
> consumption of the kthread is kept under several percents of a core.

The IPMI thread was not really designed for sensor reading, it was
designed so that firmware updates would happen in a reasonable time
on systems without an interrupt on the IPMI interface.  This change
will degrade performance for that function.  IIRC correctly the
people who did the patch tried this and it slowed things down too
much.

I'm also a little confused because the CPU in question shouldn't
be doing anything else if the schedule() immediately returns here,
so it's not wasting CPU that could be used on another process.  Or
is it lock contention that is causing an issue on other CPUs?

IMHO, this whole thing is stupid; if you design hardware with
stupid interfaces (byte at a time, no interrupts) you should
expect to get bad performance.  But I can't control what the
hardware vendors do.  This whole thing is a carefully tuned
compromise.

So I can't really take this as-is.

-corey

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index f124a2d2bb9f..2143e3c10623 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1010,7 +1010,7 @@ static int ipmi_thread(void *data)
>  		if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
>  			; /* do nothing */
>  		else if (smi_result == SI_SM_CALL_WITH_DELAY && busy_wait)
> -			schedule();
> +			usleep_range(100, 200);
>  		else if (smi_result == SI_SM_IDLE) {
>  			if (atomic_read(&smi_info->need_watch)) {
>  				schedule_timeout_interruptible(100);
