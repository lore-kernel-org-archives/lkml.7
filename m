Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141B3C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC366208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 15:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naqCNsAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfL1Pks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 10:40:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46300 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfL1Pkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 10:40:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so28703180wrl.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 07:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4w6bsun3BCKEVrzWfmPLYVkjYi7T9stUdFG1yttM1w=;
        b=naqCNsAAJqXRk1bXaQjSLk0bA5uZjvulWTKN18QSlzKo+4vX4MyJESNM8UIg7JgiiO
         S09Kd+xrgnbx9vnVG2dwevE0PaW7s6syf8h85lx9/77ILy9EQi0wCA7m7TnZX/3sfmmF
         0wvmQoytMpE8UTHLyR828Q0viN5TJfbV/w8jXcfmcdtuoMCeSxeB0cKq7K0NdykoVToR
         Dbci88sIkRnfmnMTm0lUVZbjJzRLUR7fEFYJ9vzECmrCRpS6ALKPOhlNIpR8PWYtHgs/
         pjq60qAMfKYM63mF60VbvQoa8LAGIUY8LCPTfcfX3jSgUZ7Bn7yLu6cl4mRLq7Egdt1d
         UtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4w6bsun3BCKEVrzWfmPLYVkjYi7T9stUdFG1yttM1w=;
        b=R6pWZkSIGgSS4lJbyrbYwV5zogXd+Sauippnde4zCynRd767JW/gH81fOQX5/RHlbM
         67wKZoUAFrwlXGeAJ99Ki7DXTyuX6WoDToWqFbJ+EQ0kl7g6ME4we7tN5Jaz+YtnwuVt
         zlRDNt20Zn7MgkgWqMeiwvfSiM3swqcWtuVsaN9eRIilaxD4u2z9NjYvCbq3bqHW5wvI
         MlvUkwqtOedsS7hy683HRzK3gACsOzhBXLq8Wyvbzj5F/rghcWetE/mW1a4TF85kGrB8
         gi3sxA6kLfVOksMgvFPXeVeYGZunUxd0zJPIXeTPXajSc5zcq+Pv669kZky67sMG3hf1
         WC9w==
X-Gm-Message-State: APjAAAXwS9bcLYOWBwttw2MNBbCuR4buLUq/v2tzA3TI65XFeG3ZMvRd
        cKoaUZ1tkP+I5QD2SNA/a0k=
X-Google-Smtp-Source: APXvYqy28SB3FtkvgCIo4a69wxOECpkxLmipvML1GM5jLGIQosopY4HYVMbjzcayohVXVxFe8HuBlA==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr55917549wru.65.1577547645550;
        Sat, 28 Dec 2019 07:40:45 -0800 (PST)
Received: from zhanggen-UX430UQ.lan ([95.179.219.143])
        by smtp.gmail.com with ESMTPSA id o7sm14408269wmh.11.2019.12.28.07.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Dec 2019 07:40:45 -0800 (PST)
Date:   Sat, 28 Dec 2019 23:40:39 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     bgolaszewski@baylibre.com, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] board-dm644x-evm: fix 2 missing-check bugs in
 evm_led_setup()
Message-ID: <20191228154039.GA8713@zhanggen-UX430UQ.lan>
References: <20191227023921.GA21233@zhanggen-UX430UQ>
 <20191227160142.GW25745@shell.armlinux.org.uk>
 <20191228131930.GA7214@zhanggen-UX430UQ.lan>
 <20191228134824.GX25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228134824.GX25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 01:48:24PM +0000, Russell King - ARM Linux admin wrote:
 
> This is the old everything-successful path through the code:
> 
> 	platform_device_alloc()
> 	platform_device_add_data()
> 	platform_device_add()
> 	evm_led_dev is set to the device
> 
> This is the new everything-successful path through the code:
> 
> 	platform_device_alloc()
> 	platform_device_add_data()
> 	platform_device_add()
> 	platform_device_put()
> 	evm_led_dev = NULL
Thanks for your reply. Adding a return may handle this.
	successful path:
	platform_device_alloc()
 	platform_device_add_data()
 	platform_device_add()
	return status
 	
	error path:
	platform_device_put()
 	evm_led_dev = NULL
	return status
correct?

> 
> And, specifically, the code sequence (I quote from your patch):
> 
> 	if (status)
> 		goto err;
> err:
> 
> is very stupid; it might as well not exist at all.

Well, you have to admit that the result of platform_device_alloc(),
platform_device_add_data() and platform_device_add() should be checked,
and error should be handled.

e.g., there are 124 call sites of platform_device_add_data() in Linux. Only 24
are not checked, and most of them are in arm subsystem.

Look forward to deeper discussion of this problem.

Best,
Gen
> 
> Since other code references evm_led_dev, one can assume that we do
> not want it to be NULL for the success path. So, taking all this
> together, your patch is very very wrong, and I also find it very
> worrying too.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
