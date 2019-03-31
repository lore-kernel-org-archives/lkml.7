Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE39DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8AB2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHxUMXhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfCaSJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 14:09:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53591 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCaSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 14:09:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so7823585wmj.3;
        Sun, 31 Mar 2019 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yl4OpcL8v/AZlGxAJDxvXiVtcrI7DkTImkhY93E7+KQ=;
        b=BHxUMXhVtv1ULsyYUKRHI041kO0HxptGdn3c4cc+sGoW6DXd1orFnJ0WAXmhgFCVoG
         e1WB/E6RrfkIXG8pNgLn1E9HQpUKzJknQKhQEkVQuLGgoRXli2T9u7DbNgUn3JyzZbXm
         txP33FSwQndr0rHvqNOVlNvnh0WfJXlfBcm3TU7qUITV7zyvXB6S2TgDt3Adip1NpkM0
         HgP35fyYA0gl7ORMC9IXReKwdMop31DcHpPNdfO0GOQfEtlGKO1JHVKpFhjuRb85N8zl
         AeFuID0AM3MWEE3rNBWximWlhzbUnCZYtb4iaTFdyH64UOpJ6QtuIRPSrUAL1VmXRZrl
         LCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yl4OpcL8v/AZlGxAJDxvXiVtcrI7DkTImkhY93E7+KQ=;
        b=UA2qmu3glVrr4ahPRK+mSDeHfrMR86vfxOk4QzuYnsF3ZdgEkcnT07kT2DSQGNP1Fm
         s3eEM+98XGddlO0+CAnvRMYd+l7wv3sm4mQ5SPdyXGQGeXxnKShAdFXXwyWlNQW01pmY
         Q/kw+lubptQFPTObng1zLSq/7rMt2fSYF39YOWKVSzkrKIG7YAHEDuIavgzdZOwg6nXc
         eiHHFR7t4uF2b/pzTcUlWR4OvAoLb3h9QHLrkWqljeE8ysgOKVOBXa7Gl4565qToDjJY
         Kc2ye5baUnQvSwN6IZRjYw8g5zmroCGilLM3YeLj1C3xa7doAsU3kjQOV4IoOG/fSYNz
         mtgw==
X-Gm-Message-State: APjAAAU2GEV/3jJhMhmgYiOUKAFEWMMj5hPwrrisBana566bykF4456F
        IxanoF79v/5EAX7kIng4VuK9gZsYuBE=
X-Google-Smtp-Source: APXvYqy2oA3pRRe5ppSTyPHIuWsf+R+1uy6Zf3TUEZ/BCTNOM7WMLpnE3hwkHuFKRDsstrV9qalxRQ==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr10115907wmb.101.1554055790755;
        Sun, 31 Mar 2019 11:09:50 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id w18sm11256009wru.24.2019.03.31.11.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 11:09:49 -0700 (PDT)
Date:   Sun, 31 Mar 2019 19:09:47 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/7] fbdev: sm712fb: support 2D acceleration on SM712
 w/ Little-Endian CPU.
Message-ID: <20190331180947.s44eznujdeucnl7f@debian>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-4-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322051759.15007-4-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:55PM +0800, Yifeng Li wrote:
> Previously, in staging/sm7xxfb (now fbdev/sm712fb), 2D acceleration
> was implemented, but after its submission, a critical bug that causes
> total system hang was discovered, as a stopgap measure, 2D ops was
> completele removed in commit 3af805735a25 ("staging: sm7xx: remove the
> buggy 2D acceleration support") and never implemented again.
> 
> It created a massive usability problem - on YeeLoong 8089, a notable
> MIPS platform which uses SM712 - even scrolling a single line of text
> on the console required an unaccelerated screen redraw, running "dmesg"
> typically takes 8-11 seconds, and absurdly, printf(), became a significant
> performance bottleneck that slows down GCC and "make", make the computer
> largely unusable.
> 
> So I decided to take a look. Most of the my actual development was done
> in 2014 in a personal out-of-tree driver, I did not mainline it because
> 2D acceleration was not working properly in 24-bit color. I discovered
> the solution in early 2019 and now it's ready to be mainlined.
> 
> This commit reimplements the 2D acceleration for sm712fb. Unlike the
> original implementation, which was messy and unnecessarily complicated
> by calling a 2D acceleration wrapper file with many unneeded functions,
> this is a minimum and (relatively) clean implementation. My tests have
> shown that running "dmesg" only takes 0.9 seconds, a performance boost
> of 950%. System hangs did not occur in my tests.

I didnot notice any performace improvement in my system. Infact, I have
never seen the performance problem that you mentioned. But, it will be
good to have the 2D feature back again.

> 
<snip>
> +	 */
> +	smtcfb_reset_accel();
> +
>  	smtc_set_timing(sfb);
> +
> +	/*
> +	 * Currently, 2D acceleration is only supported on SM712 with
> +	 * little-endian CPUs, it's disabled on Big Endian systems and SM720
> +	 * chips as a safety measure. Since I don't have monetary or hardware
> +	 * support from any company or OEMs, I don't have the hardware and
> +	 * it's completely untested. I should be also to purchase a Big Endian
> +	 * test platform and add proper support soon. I still have to spend
> +	 * 200 USD+ to purchase this piece of 1998's hardware, yikes! If you
> +	 * have a Big-Endian platform with SM7xx available for testing, please
> +	 * send an E-mail to Tom, thanks!
> +	 */

comments in the code are usually used to increase the readability, and
I dont think adding this comment adds to the readibility. I also spent
personal money to get these hardwares but that was never added to any
commit message or comment. Please remove this comment.

> +#ifdef __BIG_ENDIAN
> +	sfb->accel = false;
> +	if (accel)
> +		dev_info(&sfb->pdev->dev,
> +			"2D acceleration is unsupported on Big Endian.\n");
> +#endif
> +	if (!accel) {
> +		sfb->accel = false;
> +		dev_info(&sfb->pdev->dev,
> +			"2D acceleration is disabled by the user.\n");
> +	}
> +
> +	/* reset 2D engine after a modesetting is mandatory */
> +	smtcfb_reset_accel();

If it is a big endian, acceleration is disabled, but you are still
calling smtcfb_reset_accel() which will "enable Zoom Video Port,
2D Drawing Engine and Video Processor". Will that not create any problem
in a big endian system?

> +	smtcfb_init_accel(sfb);
>  }
>  
>  static int smtc_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
> @@ -1401,6 +1459,316 @@ static struct fb_ops smtcfb_ops = {
>  	.fb_write     = smtcfb_write,
>  };
>  
> +static int smtcfb_wait(struct smtcfb_info *fb)
> +{
> +	int i;
> +	u8 reg;
> +
> +	smtc_dprr(DPR_DE_CTRL);
> +	for (i = 0; i < 10000; i++) {
> +		reg = smtc_seqr(SCR_DE_STATUS);
> +		if ((reg & SCR_DE_STATUS_MASK) == SCR_DE_ENGINE_IDLE)
> +			return 0;
> +		udelay(1);
> +	}
> +	dev_err(&fb->pdev->dev, "2D engine hang detected!\n");
> +	return -EBUSY;
> +}
> +
> +static void
> +smtcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
> +{
> +	u32 width = rect->width, height = rect->height;
> +	u32 dx = rect->dx, dy = rect->dy;
> +	u32 color;
> +
> +	struct smtcfb_info *sfb = info->par;
> +
> +	if (unlikely(info->state != FBINFO_STATE_RUNNING))
> +		return;

Did you measure the performance difference with and without "unlikely"?
Quoting GregKH from https://lkml.org/lkml/2018/11/7/36
"don't do stuff like this unless you can actually measure the
difference".

> +
<snip>
> +		 * & HIGH with 0xffffffff (all ones, and we have already set
> +		 * that in smtcfb_init_accel). Since the color of this mono
> +		 * pattern is controlled by DPR_FG_COLOR, BITBLTing it with
> +		 * ROP_COPY is effectively a rectfill().
> +		 */
> +		smtc_dprw(DPR_FG_COLOR, color);
> +		smtc_dprw(DPR_DST_COORDS, DPR_COORDS(dx, dy));

I will need some more time to verify all these and other registers with
the datasheet and test again.

--
Regards
Sudip
