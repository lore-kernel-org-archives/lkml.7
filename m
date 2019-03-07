Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C38205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmojqXuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCGHnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:43:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53577 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:43:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id e74so8222795wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 23:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTj2kL6gR2BUHgQue6d9KsER2+uEERntAbfOzv94go8=;
        b=jmojqXuJ688L88StJJ/88Oep0no/VngJ+sF09Svw2WAVtHWJEiMWqF/J/8ywDcy9vo
         E3zZHIEvgXCBMjmY3bhSW2y+N2uDGwLVmPtqVJoNtjrRWIt0R87jHWemhgZtw2+iW+MM
         NMi9l0FR0ZvifpTI10V27XICdfkMmzS4mt9bY0e4LgR1+LFX7IU41CqOLjde+YiGL1dW
         gAerzivOJW5b/gPWZBFCgLrzt60x5MibD2Wr1+9yN7L0QwGACtWSv0+Zc1teq4taeBNi
         Ct/JIBbd4RNGdJPo61Uy2oqVrD1RDhVhHDpDp4c2k4Uo7uFSiy1ne1DYOSZrI4uWicr1
         0y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTj2kL6gR2BUHgQue6d9KsER2+uEERntAbfOzv94go8=;
        b=MATkqVlSgzCZVNERsZ5dYfqSTEdR3dYuAi53Z0auIGWfbRw7aX6iQH03MhaepJZoot
         fJnF3412MgFyVlr3MtxGzQFmYP7jBi0OCuMBA7ty6MOy3d5AE3sjAs051V7rHtokpZbw
         p5k7h/LhgsMiptz6siQxaoh/xP/CP0PyWKyTrK74n2ISo9ui53XDchPtWHcYJyxUvCCh
         se3opSaB2y2GB4ljmpRgU2BTjY3N3qOW+ywm3r0AmxWe0L9BbVKLsy88KpQrolRAHUQH
         /7tvUNEQgMHC1Ty8/m6tuwptRaBLMKXxjChcfoqk9JA9Ofaf1ulredXYF0Dg80q8IVYK
         CBfg==
X-Gm-Message-State: APjAAAWVeZmwEPPvtZXvKRqo3/S8staa94z9B1Wl0M2+UIIK/dYSfmvT
        t4ZW5oxPqReTYJzwrpYgFw6fnHj2+9Y0S78zDcc=
X-Google-Smtp-Source: APXvYqy3woSP4D1mEpiUO20j2892J7zl5JkHWLxAllR18sdkj63vaGbutBjbkXBOZzn6N9lUeZWQ9z18dO0dyOmK47k=
X-Received: by 2002:a1c:6506:: with SMTP id z6mr4621774wmb.153.1551944601356;
 Wed, 06 Mar 2019 23:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20190227165018.12911-1-andrey.z@gmail.com>
In-Reply-To: <20190227165018.12911-1-andrey.z@gmail.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Thu, 7 Mar 2019 08:43:10 +0100
Message-ID: <CAHtQpK7h=kAOJHa1K7+mzq09=nAd3XSN-FxAPkjts1WrADKnCQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: socfpga_defconfig: enable support for large block devices
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dinh,

Just a short ping on this patch - do yo think you can accept this
patch and have it merged? I'd like to know whether it is planned to be
integrated, as it might be beneficial for a lot of socfpga users...

Thanks a lot!
-- 
Regards,
Andrey.

On Wed, Feb 27, 2019 at 5:50 PM Andrey Zhizhikin <andrey.z@gmail.com> wrote:
>
> Enable CONFIG_LBDAF, which is required by ext4 fs. This option could
> handle both ext3 and ext4, with ext4 requires this option to be enabled,
> otherwise the filesystem is mounted RO mode.
>
> Since the LBDAF is enabled by default for 32-bit systems, simply
> removing the current "not set" entry enables the support.
>
> Signed-off-by: Andrey Zhizhikin <andrey.z@gmail.com>
> ---
>  arch/arm/configs/socfpga_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index 08d1b3e11d68..c96d93fb68c6 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -21,7 +21,6 @@ CONFIG_NEON=y
>  CONFIG_OPROFILE=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> -# CONFIG_LBDAF is not set
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_NET=y
>  CONFIG_PACKET=y
> --
> 2.17.1
>
