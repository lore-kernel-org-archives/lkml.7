Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DC0213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="yYQ5RRNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfCSM70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:59:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60212 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfCSM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553000363; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5gNti1iwgWA7OmzGmfCX9MLZ19j1HiI4dfTQ4uPYug=;
        b=yYQ5RRNFLOn/99ERfY2i61SGemsAtUe4NwmXItzVNfNVdQnNjy73W1eAodaCnrfsD5adL3
        nLSafz9bHLr/QeknRFayoxYl4lm45h823Xaz0WevbVDY2ILNRtGq2iwhWauJu2Gu7Bzr11
        Za91CR382ERUexyomVS/4b06htYIANM=
Date:   Tue, 19 Mar 2019 13:59:20 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 4/4] memory: jz4780_nemc: Add support for the JZ4740
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1553000360.2015.0@crapouillou.net>
In-Reply-To: <20190205035240.31410-5-paul@crapouillou.net>
References: <20190205035240.31410-1-paul@crapouillou.net>
        <20190205035240.31410-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any feedback on this patchset? Should I resend?

Thanks,
-Paul

Le mar. 5 f=E9vr. 2019 =E0 4:52, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> Add support for the JZ4740 SoC from Ingenic.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
> ---
>=20
> v2: No change
>=20
> v3: Support the JZ4740 instead of the JZ4725B (exact same=20
> functionality
>     but JZ4740 is already fully upstream)
>=20
>  drivers/memory/jz4780-nemc.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/memory/jz4780-nemc.c=20
> b/drivers/memory/jz4780-nemc.c
> index 66b8b43eaeff..f3a19b9b76ac 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -44,9 +44,14 @@
>  #define NEMC_NFCSR_NFCEn(n)	BIT((((n) - 1) << 1) + 1)
>  #define NEMC_NFCSR_TNFEn(n)	BIT(16 + (n) - 1)
>=20
> +struct jz_soc_info {
> +	u8 tas_tah_cycles_max;
> +};
> +
>  struct jz4780_nemc {
>  	spinlock_t lock;
>  	struct device *dev;
> +	const struct jz_soc_info *soc_info;
>  	void __iomem *base;
>  	struct clk *clk;
>  	uint32_t clk_period;
> @@ -202,7 +207,7 @@ static bool jz4780_nemc_configure_bank(struct=20
> jz4780_nemc *nemc,
>  	if (of_property_read_u32(node, "ingenic,nemc-tAS", &val) =3D=3D 0) {
>  		smcr &=3D ~NEMC_SMCR_TAS_MASK;
>  		cycles =3D jz4780_nemc_ns_to_cycles(nemc, val);
> -		if (cycles > 15) {
> +		if (cycles > nemc->soc_info->tas_tah_cycles_max) {
>  			dev_err(nemc->dev, "tAS %u is too high (%u cycles)\n",
>  				val, cycles);
>  			return false;
> @@ -214,7 +219,7 @@ static bool jz4780_nemc_configure_bank(struct=20
> jz4780_nemc *nemc,
>  	if (of_property_read_u32(node, "ingenic,nemc-tAH", &val) =3D=3D 0) {
>  		smcr &=3D ~NEMC_SMCR_TAH_MASK;
>  		cycles =3D jz4780_nemc_ns_to_cycles(nemc, val);
> -		if (cycles > 15) {
> +		if (cycles > nemc->soc_info->tas_tah_cycles_max) {
>  			dev_err(nemc->dev, "tAH %u is too high (%u cycles)\n",
>  				val, cycles);
>  			return false;
> @@ -278,6 +283,10 @@ static int jz4780_nemc_probe(struct=20
> platform_device *pdev)
>  	if (!nemc)
>  		return -ENOMEM;
>=20
> +	nemc->soc_info =3D device_get_match_data(dev);
> +	if (!nemc->soc_info)
> +		return -EINVAL;
> +
>  	spin_lock_init(&nemc->lock);
>  	nemc->dev =3D dev;
>=20
> @@ -370,8 +379,17 @@ static int jz4780_nemc_remove(struct=20
> platform_device *pdev)
>  	return 0;
>  }
>=20
> +static const struct jz_soc_info jz4740_soc_info =3D {
> +	.tas_tah_cycles_max =3D 7,
> +};
> +
> +static const struct jz_soc_info jz4780_soc_info =3D {
> +	.tas_tah_cycles_max =3D 15,
> +};
> +
>  static const struct of_device_id jz4780_nemc_dt_match[] =3D {
> -	{ .compatible =3D "ingenic,jz4780-nemc" },
> +	{ .compatible =3D "ingenic,jz4740-nemc", .data =3D &jz4740_soc_info, },
> +	{ .compatible =3D "ingenic,jz4780-nemc", .data =3D &jz4780_soc_info, },
>  	{},
>  };
>=20
> --
> 2.11.0
>=20
=

