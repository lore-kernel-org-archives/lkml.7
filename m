Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB5ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F85A21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="q11UJzmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394092AbfJYGQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:16:45 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38367 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbfJYGQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:16:44 -0400
Received: by mail-yb1-f194.google.com with SMTP id r68so472985ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RofhMcQZgvxx+FWIcLSQhXhgYPG84em3wmI/HQCnexI=;
        b=q11UJzmC9dgRlwJPHeZc8Wxp/x62HSW/TjNP8XhZsfGjrBcoZmWTSeTGC99OGOCZpg
         WF2dRawVZ4q1pDjiFi8+3c+zDE2/rDET8KrnmmS7yvNxUYq7Fa7nFSTiN0ZVm9zSSFNG
         clxu3Uf1nwbykJIgpAqRdJePQqf7v+kHlKT8xHxfgEYrPZshmxD0GS6RUrmaHnBtx78c
         g2u0kVwip9f9iQZDp5xjcbWOp0B/3PWg3e6AjxGy7HUgVZkMMQ9YDXygdGAc6i+EoPhm
         xvb0xhfAMBSNHKImtt5xDLKTxQvgvNDH7agInFWTOdr4MRy+fzXqAAlzmlNo1Xk41kJy
         NzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RofhMcQZgvxx+FWIcLSQhXhgYPG84em3wmI/HQCnexI=;
        b=OeBa80qcSmc7O0xt0AcqyloxOFnZEkO4HY8BrZK52hKesv+LtDeycxXgvfkoG+0TYs
         sa5gi8hgGOth7edMZfONzoMDBxuR2IZjIbMOIJjVZ3XoiJV9aS20Z3KxgPhdv06dcgb2
         /PZbvy9w0hqKQWyHOks7ES9dgztyU7TKatfqwoNNtvsxFXvu4UzkpClKCTxksSunaAT2
         c8Dj2fSt9ETbahPzePlyL7I/nSMDxySo0wDhis1zxw3sAkFp7PCe/0EAW7kx2zLW8Z8U
         kteYWC6OyFE8ZVSBb0EeM5VvJ+90MwpD1SNix+nFfR1UZL5onRDxRzt9HGhz9BGEpuQZ
         V+OQ==
X-Gm-Message-State: APjAAAUkLk3G0ZETYCMaPpsCZKCXiUfGluTVYhwRBsorCgTcSKc1Amgl
        ZIEwDZJNwr6E6RgLg+tkO1Sjeh/UJjx01SVloBxNG5KJ4ZfYtA==
X-Google-Smtp-Source: APXvYqy2uBVESrPcAxKAya40WvwJ5rFtmyE5xYk8orp2OmR8Eq7D+MQ+eq2yjLj4W1SzDZOSpU9K6eaNMUIkJbODzfY=
X-Received: by 2002:a25:ef07:: with SMTP id g7mr1506541ybd.393.1571984203652;
 Thu, 24 Oct 2019 23:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <7cc15bed9291453500502df60668c8bb396d500f.1570530202.git.michal.simek@xilinx.com>
In-Reply-To: <7cc15bed9291453500502df60668c8bb396d500f.1570530202.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Fri, 25 Oct 2019 08:16:32 +0200
Message-ID: <CAHTX3dKcF=Pu3nMyhBm+7FFZkcFm2hMmXUipvgUL+ReHt5PwAw@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Enable SPARSE_IRQ
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Mubin Sayyed <mubinusm@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 8. 10. 2019 v 12:23 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> Enabling SPARSE_IRQ to use dynamically allocated irq descriptors.
>
> Signed-off-by: Mubin Sayyed <mubinusm@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/Kconfig           | 1 +
>  arch/microblaze/include/asm/irq.h | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index c9c4be822456..a75896f18e58 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -46,6 +46,7 @@ config MICROBLAZE
>         select VIRT_TO_BUS
>         select CPU_NO_EFFICIENT_FFS
>         select MMU_GATHER_NO_RANGE if MMU
> +       select SPARSE_IRQ
>
>  # Endianness selection
>  choice
> diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/=
asm/irq.h
> index d785defeeed5..eac2fb4b3fb9 100644
> --- a/arch/microblaze/include/asm/irq.h
> +++ b/arch/microblaze/include/asm/irq.h
> @@ -9,7 +9,6 @@
>  #ifndef _ASM_MICROBLAZE_IRQ_H
>  #define _ASM_MICROBLAZE_IRQ_H
>
> -#define NR_IRQS                (32 + 1)
>  #include <asm-generic/irq.h>
>
>  struct pt_regs;
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
