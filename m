Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE602C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B775B20657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxKfaJGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCDPjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:39:39 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43145 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfCDPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:39:39 -0500
Received: by mail-io1-f66.google.com with SMTP id y6so4262588ioq.10;
        Mon, 04 Mar 2019 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qE0Zu8808ijdzE0BYmvxkSngUFssgXh8tClUyxa3sPs=;
        b=XxKfaJGuBJFgk/cdzD/2HpobQxzZr57hTbpvfh13vBE5YuF1CzL5NjGfXYEyubSy45
         mrZeA//EbvTkN/Dc/l47MzxTn0blpFiRh3HUUek9XzoSZo0oONipY3wgWQJPxf1a3JOc
         kcyDmj3yESxM27HELfXm3OvSdgldEL+ef/FqFkq9L6LZ7WoPxmHVxRREoWTWkjgJ2aZZ
         Uy1R4mLYOPh0AV/lS+Y1oL5RuwJHBheMeytrI0eF68IZm9r4/sLVBXMmkbq9h4ljPs2y
         JpmYdd4rzleV1s3KJpV6MSVDlix4/rP0huFfFs3oqrhe8E0pxWzDpiJ52SPLkWjvzRix
         w5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qE0Zu8808ijdzE0BYmvxkSngUFssgXh8tClUyxa3sPs=;
        b=UW6TecJh+U3cY88S4hrMT/+po4WstCrQR+K1WPkQZxj1qmfc7vZRn2nui8pg5JREhh
         RNvE9WUVBpre+n2NXtFdYeRGiIS7E9XWNowBGzz6pKG1reNN4hLYN9KuLUSq5gVU3Yx/
         08wfVTaSM8lvltFtXYV6GVrtTBj3EiGB4tuYhArilVPExEwPZk2MJ3dqEHhhQLhAYFlP
         zRSKbUeJqV1CAlRch2zeVsJguztwrkxBuy2A6nqKEsF3K76CE45EU29o6DGYeTtkQ0Kc
         PiXhcCnLHIvSKHYAcOSCNQwUv2LxJq479l18Gtv0J/gEwhAHYO3yCVPwJURSmdF2pwGp
         xp1g==
X-Gm-Message-State: APjAAAVzGW/Doqf47V0PSm5xRRP697+fA0euenqSaHk3rpvGQhdB4OJ9
        YjJ+hL1mw4qarY0I9/d8zgRdbXvcjpBSgI1k7Q==
X-Google-Smtp-Source: APXvYqwWnygP/CYpVoom77HVoDG4du5ty9Av0tuv/JeGLUOQ0LxSf9rbgiHm7uq2/vEea5xSyJtthzBi3q2mIa56j88=
X-Received: by 2002:a6b:6e11:: with SMTP id d17mr9864707ioh.297.1551713977983;
 Mon, 04 Mar 2019 07:39:37 -0800 (PST)
MIME-Version: 1.0
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn> <1551430616-42014-6-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1551430616-42014-6-git-send-email-wen.yang99@zte.com.cn>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 4 Mar 2019 17:39:28 +0200
Message-ID: <CAKKbWA5GkC7M9gm_HRN-4=neJKNH4JGRj1aaNsHyR7Ar54dS0A@mail.gmail.com>
Subject: Re: [PATCH 06/15] arm: npcm: fix a leaked reference by addingmissing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgene@kernel.org, krzk@kernel.org,
        linux-samsung-soc@vger.kernel.org, michal.simek@xilinx.com,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        dinguyen@kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linus.walleij@linaro.org, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        xuwei5@hisilicon.com, maxime.ripard@bootlin.com, wens@csie.org,
        catalin.marinas@arm.com, will.deacon@arm.com, horms@verge.net.au,
        magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, wang.yi59@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Avi Fishman <avifishman70@gmail.com>

Thanks

On Fri, Mar 1, 2019 at 10:57 AM Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-npcm/platsmp.c:52:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 31, but without a corresponding object release within this function.
> ./arch/arm/mach-npcm/platsmp.c:68:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 60, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> Cc: Patrick Venture <venture@google.com>
> Cc: Nancy Yuen <yuenn@google.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: openbmc@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/mach-npcm/platsmp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
> index 21633c7..fe63edc 100644
> --- a/arch/arm/mach-npcm/platsmp.c
> +++ b/arch/arm/mach-npcm/platsmp.c
> @@ -35,6 +35,7 @@ static int npcm7xx_smp_boot_secondary(unsigned int cpu,
>                 goto out;
>         }
>         gcr_base = of_iomap(gcr_np, 0);
> +       of_node_put(gcr_np);
>         if (!gcr_base) {
>                 pr_err("could not iomap gcr");
>                 ret = -ENOMEM;
> @@ -63,6 +64,7 @@ static void __init npcm7xx_smp_prepare_cpus(unsigned int max_cpus)
>                 return;
>         }
>         scu_base = of_iomap(scu_np, 0);
> +       of_node_put(scu_np);
>         if (!scu_base) {
>                 pr_err("could not iomap scu");
>                 return;
> --
> 2.9.5
>


-- 
Regards,
Avi
