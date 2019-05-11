Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290CFC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF63F216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 18:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="KwFf4gWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEKSn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 14:43:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52454 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKSn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 14:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1557600203; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBNC7EtOtCDjHibYBSHYYIsbYXAqV5LGmbErBkoGtOE=;
        b=KwFf4gWyvN9tnu7Nr7GQ/2h2NMIIu9Zbhti/gcCvbACE/EKzmjxhpSI4kKfwCP6tbgW6c9
        osK7ecqKoGOKVPKDpmsHV5+U7KL9DUn8xRa3LszrhoLAuCidO1+BdYUK2lb5uPUvBDsKyQ
        7vm1jwnfex0gDnYwewOWM4YZS7eUCWI=
Date:   Sat, 11 May 2019 20:43:09 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] irqchip: ingenic: Drop dependency on MACH_INGENIC, use
 COMPILE_TEST
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org
Message-Id: <1557600189.1898.0@crapouillou.net>
In-Reply-To: <20190511170916.12990-1-paul@crapouillou.net>
References: <20190511170916.12990-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My bad, I'm stupid. I tested CONFIG_COMPILE_TEST on MIPS...

The driver does depend on arch-specific includes so COMPILE_TEST
cannot be used; I'll send a V2.

-Paul


Le sam. 11 mai 2019 =E0 19:09, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> Depending on MACH_INGENIC prevent us from creating a generic kernel=20
> that
> works on more than one MIPS board. Instead, we just depend on MIPS=20
> being
> set.
>=20
> On other architectures, this driver can still be built, thanks to
> COMPILE_TEST. This is used by automated tools to find bugs, for
> instance.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/irqchip/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 5438abb1baba..864dc38782e8 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -286,9 +286,9 @@ config MIPS_GIC
>  	select MIPS_CM
>=20
>  config INGENIC_IRQ
> -	bool
> -	depends on MACH_INGENIC
> -	default y
> +	bool "Ingenic JZ47xx IRQ controller driver"
> +	depends on MIPS || COMPILE_TEST
> +	default MACH_INGENIC
>=20
>  config RENESAS_H8300H_INTC
>          bool
> --
> 2.21.0.593.g511ec345e18
>=20

=

