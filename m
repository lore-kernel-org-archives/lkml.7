Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6779ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD7E21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="dfAUZsQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404998AbfJYGQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:16:24 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40663 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbfJYGQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:16:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id a67so411889ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 23:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lc0RpdRAHt+y9IBzcxMmJyB6D7ZwrHdv7LmWz7lTJqc=;
        b=dfAUZsQg4BJDe5Hhz8jT88JDPBstpgMGP7ysyUULSpkXR99QeVwXgmfv2M7H1i9b+X
         3hTpdelPQ3871iOheLF6wPVka+kq4uS5I2eE6hhsBHht/EUFOtjRJSe+7KBCswuMKYTp
         DtCFBFKnUQT+EbuZoVykN+UcekqjwZ2tB1wR5lxxjzy+avEj9AvX11JSa8knlovCJAD/
         xx+IgJ5bxyCl6aKtMZQFIcT7ZH+G7B0jR7fSBA+aCzvm6GukMBHvUWNbi5Auorqfbgo1
         bKty+3HIT7veOvCWfFFmoPzwPHuDHg4/JKKuj8OQm86vclXYVfMAcWERYHL/SGxKUM0D
         4zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lc0RpdRAHt+y9IBzcxMmJyB6D7ZwrHdv7LmWz7lTJqc=;
        b=Z4FotpELeP2T6HZjlXq4dZi14aQP0ADSta6Tqv66Mjoz8WxaRR9uOxudjI+vZ7S5yk
         oR92ER+EBBWMWggO8cOuEdy3pvXWHZ8cKoCaNkhnCzUXbr4pxUNk3kwyO/S1XWI7n0U6
         H6VyD/z4hprU4xYrcTz8WdkP8Cbfo4tdgfhmevquT4UP0PsdzDp+DxpEdXMVdZ10x2r/
         j6IMzBrUOQRCyIb/RWYZNiQA5vR5e0kYkYrWwoLHd0nnjQpGZ3g2qvQqJ1BCCu/jh78O
         Eg1gBdq0Abeu3KcUQJ+5zy4oF7S52MbqLqzI7hyZH8OwEESon0APZWZsuTPyhmG7LC7o
         pwUA==
X-Gm-Message-State: APjAAAXaUYT3yfaigb/92MIW3NvoHksElfIQX6wOwfCz4L1UGEeoOKPI
        N/+fVBqa4dAdwzm1Y9/2fegpvSFj2S84/ysykNjBQ7dUe3lciA==
X-Google-Smtp-Source: APXvYqw3fm1LXkwT4nKs8gOPNyd7bvgHAh6f9Knm6azgAdX4KLvYDuIlqCOWjJFgXqDhm2ziBZRIJfMEtnPJoC9u8CU=
X-Received: by 2002:a81:b208:: with SMTP id q8mr969628ywh.74.1571984182508;
 Thu, 24 Oct 2019 23:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <980101fbea44e14bec2354e718238742e6bc5f05.1570528975.git.michal.simek@xilinx.com>
In-Reply-To: <980101fbea44e14bec2354e718238742e6bc5f05.1570528975.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Fri, 25 Oct 2019 08:16:11 +0200
Message-ID: <CAHTX3dKuiCTcs82s+ouCHTdOj0aPKYuX7KRSk46Z36Hk1AZYUQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: defconfig: Enable devtmps and tmpfs
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        U-Boot <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 8. 10. 2019 v 12:03 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> From: Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>
>
> Currently dropbear does not run in background because devtmps and tmpfs
> is not enabled by default. Enable devtmps and tmpfs to fix this issue.
>
> Signed-off-by: Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/configs/mmu_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/conf=
igs/mmu_defconfig
> index 654edfdc7867..b3b433db89d8 100644
> --- a/arch/microblaze/configs/mmu_defconfig
> +++ b/arch/microblaze/configs/mmu_defconfig
> @@ -33,6 +33,8 @@ CONFIG_INET=3Dy
>  # CONFIG_IPV6 is not set
>  CONFIG_BRIDGE=3Dm
>  CONFIG_PCI=3Dy
> +CONFIG_DEVTMPFS=3Dy
> +CONFIG_DEVTMPFS_MOUNT=3Dy
>  CONFIG_MTD=3Dy
>  CONFIG_MTD_CFI=3Dy
>  CONFIG_MTD_CFI_INTELEXT=3Dy
> @@ -73,6 +75,7 @@ CONFIG_UIO_PDRV_GENIRQ=3Dy
>  CONFIG_UIO_DMEM_GENIRQ=3Dy
>  CONFIG_EXT2_FS=3Dy
>  # CONFIG_DNOTIFY is not set
> +CONFIG_TMPFS=3Dy
>  CONFIG_CRAMFS=3Dy
>  CONFIG_ROMFS_FS=3Dy
>  CONFIG_NFS_FS=3Dy
> --
> 2.17.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
