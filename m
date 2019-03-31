Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4371C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE0E20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqLTqCuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfCaSdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 14:33:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33608 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfCaSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 14:33:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so8999995wrp.0;
        Sun, 31 Mar 2019 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nm3kCAzbcd2k/gszqbbdi/1okg7QB3S9yEr0mE2jI58=;
        b=JqLTqCuJPhJz5QTbUQrNaPa+lBjSPUyGQwKtH9rt4efj/BTuUl3HfnKb3kUxbdyDTa
         6EIJL2jb57G7U9LgQTn0Jih2keNX6H0R8CJCCwJlUstcUxKtFYXwDA/Te65QqHyRnqFO
         bQXLPmQ8SyDry0/ug9vvsq7vCfJt50F8b7GOIz4nlaYkWPmnKKxQwz1ckbyFRpFEGt/U
         5JD2/sHw5WpbCl9rb3+xLUpBS1VwtdlC6ye827DfG5rT1wCh/jLbjPNLxa+W6WISbU5w
         o4ni/thvLYeEA0fBWdqFKoxiQwOuFgqE/fRoFu3QxB5htkbMuStdYPFHOrBuiUvd101B
         TK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nm3kCAzbcd2k/gszqbbdi/1okg7QB3S9yEr0mE2jI58=;
        b=L5U4sb8AjBQlCNnB2jLuE+GyQ+VbAi6pCTf4xrTojhNv2kyQngMrJ1uuQE3eX7P7Th
         fr7j/E6PRWS63mud//DN9h/Xh6N68YS+y5kLgT+738Y/ZVZdbw4ULL6UxykNavBLgEDd
         cn2vc3fPvCZvCtAbF7ghu65VXQSI1PpZCrAX6OMnZUS3aBA4BE3dg3rAIAOGlm+HR3pS
         zKBm78/PMueed3AbZbzDNVP7h47tXSiY7GQ6gk1aGq4SxcZU3WRKyN50AlDGQs401hm6
         CGZq4VCAXnUubFQ2yZPXeP8TQgph7lQTbqS4KppzOQrekGZX6RW9KkJL4qN8wAiTJCGh
         jeVA==
X-Gm-Message-State: APjAAAUtgaDzMWh7HXWJFg+tllD9kFhymYq2jafpFs7YbtqmZGTn9Dip
        1EJ7ing4qh7eLSydAjKZtnM=
X-Google-Smtp-Source: APXvYqwHV/EC4OjAzHZkeKRUbosXz5HEs0d/o4MrtdVvVGutpPwRnuU2AAsZt9nLoM+A6xAsbdImNg==
X-Received: by 2002:a5d:618b:: with SMTP id j11mr10630338wru.123.1554057216396;
        Sun, 31 Mar 2019 11:33:36 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id g132sm7865723wme.3.2019.03.31.11.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 11:33:35 -0700 (PDT)
Date:   Sun, 31 Mar 2019 19:33:33 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/7] fbdev: sm712fb: add 32-bit color modes, drops
 some other modes.
Message-ID: <20190331183333.kpyt2hm5iy6m5u34@debian>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-5-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322051759.15007-5-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:56PM +0800, Yifeng Li wrote:
> The modesetting in sm712fb is an ugly hack. First, all the registers
> are programmed by hardcoded register arrays, which makes it difficult
> to support different variations of color depths, refresh rates, CRT/LCD
> panel, etc of the same resolution. Second, it means the standard
> fb_find_mode() cannot be used and a confusing non-standard "vga="
> parameter is needed. Third, there's only minimum differences between
> some modes, yet around 70 lines of code and 100 registers are needed to
> be indepentently specified for each mode. Fourth, the register between
> some modes are inconsistent: the register configuration of different
> color depths in 640 x 480 modes are identical, but for 800 x 600 modes
> it's completely different. Also, some modes can drive the LCD panel
> properly yet some other modes will only show a white screen of death on
> the LCD panel. Fifth, some modes, such as 32-bit color modes, are
> supported but never listed, and some modes are listed, such as 1280x1024
> modes, but never supported by the register configuration arrays. And
> some modes are partially implemented but neither listed nor supported,
> i.e. the 8-bit color modes.
> 
> Fixing these problems requires a complete rewrite of modesetting code,
> which is well-beyond my motivation. This commit only perform a minimum
> cleanup:
> 
> 1. Remove the 320 x 240 register settings, since there are never listed
> and never actually being used. This resolution is not even supported by
> vesafb, so it's safe to assume that no one is using such hardware. Future
> developers who needs them can simply recover them from the git history.

Why are you removing existing functionality from the driver? These are
supported but were never listed so could not be used. I think you can
just add these to vesa_mode_table[] and they can be used. I have an old
CRT in India which supports 320x240 mode and can test there when I am
there next.

> 
> 2. Remove 1280x1024 modes and 8-bit color modes. They are listed but never
> supported by the register array. So it doesn't work in the beginning, and
> only gives a black screen.
> 
> 3. Add 32-bit color modes. They are supported but never listed, and are
> useful to some users.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  drivers/video/fbdev/sm712fb.c | 158 +++++++---------------------------
>  1 file changed, 31 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
> index 75d60ea63883..5e887653ef5d 100644
> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -118,25 +118,48 @@ struct vesa_mode {
>  };
>  
>  static const struct vesa_mode vesa_mode_table[] = {
> -	{"0x301", 640,  480,  8},
> -	{"0x303", 800,  600,  8},
> -	{"0x305", 1024, 768,  8},
> -	{"0x307", 1280, 1024, 8},
> -
>  	{"0x311", 640,  480,  16},
>  	{"0x314", 800,  600,  16},
>  	{"0x317", 1024, 768,  16},
> -	{"0x31A", 1280, 1024, 16},
>  
>  	{"0x312", 640,  480,  24},
>  	{"0x315", 800,  600,  24},
>  	{"0x318", 1024, 768,  24},
> -	{"0x31B", 1280, 1024, 24},
> +
> +	{"0x329", 640,  480,  32},
> +	{"0x32e", 800,  600,  32},
> +	{"0x338", 1024, 768,  32},
>  };
>  
>  /**********************************************************************
>  			 SM712 Mode table.
> - **********************************************************************/
> +
> + The modesetting in sm712fb is an ugly hack. First, all the registers
> + are programmed by hardcoded register arrays, which makes it difficult
> + to support different variations of color depths, refresh rates, CRT/LCD
> + panel, etc of the same resolution. Second, it means the standard
> + fb_find_mode() cannot be used and a confusing non-standard "vga="
> + parameter is needed. Third, there's only minimum differences between
> + some modes, yet around 70 lines of code and 100 registers are needed to
> + be indepentently specified for each mode. Fourth, the register between
> + some modes are inconsistent: the register configuration of different
> + color depths in 640 x 480 modes are identical, but for 800 x 600 modes
> + it's completely different. Also, some modes can drive the LCD panel
> + properly yet some other modes will only show a white screen of death on
> + the LCD panel. Fifth, there is a specific hack for Lemote Loongson 8089D
> + laptop, the 1024x768, 16-bit color mode was modified to drive its LCD panel
> + and changed to 1024x600, but the original mode was not preserved, so
> + 1024x768 16-bit color mode is completely unsupported. And previously,
> + some modes are listed, such as 1280x1024 modes, but never supported by
> + the register configuration arrays, so they are now removed. And some modes
> + are partially implemented but neither listed nor supported, i.e. the 8-bit
> + color modes, so they have been removed from vesa_mode_table, too.

I think this comment sounds more like a commit message instead of a
code comment. Does this improve readability?

> +
> + I'm not the original author of the code, fixing these problems requires a
> + complete rewrite of modesetting code, which is well-beyond my motivation.
> +
> + See Documentation/fb/sm712fb.txt for more information.
> +**********************************************************************/

Is this needed? Many of the commits of the driver are done by people who
are not the original author.

--
Regards
Sudip
