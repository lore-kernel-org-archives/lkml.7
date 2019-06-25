Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E039C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B09820663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="I5VaVXau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfFYRrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:47:46 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40816 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfFYRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561484862; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EVTVbMsCSjQzsSGM7XCSUEIELSlkRRQLrdI9FXq1fYg=;
        b=I5VaVXau0WYEvLY0+ThTCn8lOoVV25LOpS4WXggxtDRrOTlkMd1je79pyQQADeqrXUuEDs
        4KVxkYs0sLV0LEQgVmb0LvE0ep2awhNb5yLGjDccUym35LLBRhSoRhcZyUcP3CQ9v1i+B9
        fero1NZR8XqCyr37PzfLE+FpxGb8NKE=
Date:   Tue, 25 Jun 2019 19:47:32 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v13 04/13] mfd: Add Ingenic TCU driver
To:     Paul Burton <paul.burton@mips.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1561484852.10069.0@crapouillou.net>
In-Reply-To: <20190625173026.dbvx44iwywnijjql@pburton-laptop>
References: <20190624225759.18299-1-paul@crapouillou.net>
        <20190624225759.18299-5-paul@crapouillou.net>
        <20190625173026.dbvx44iwywnijjql@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar. 25 juin 2019 =E0 19:30, Paul Burton <paul.burton@mips.com> a=20
=E9crit :
> Hi Paul,
>=20
> On Tue, Jun 25, 2019 at 12:57:50AM +0200, Paul Cercueil wrote:
>>  +static const struct of_device_id ingenic_tcu_of_match[] =3D {
>>  +	{ .compatible =3D "ingenic,jz4740-tcu", .data =3D &jz4740_soc_info, }=
,
>>  +	{ .compatible =3D "ingenic,jz4725b-tcu", .data =3D &jz4725b_soc_info,=
=20
>> },
>>  +	{ .compatible =3D "ingenic,jz4770-tcu", .data =3D &jz4740_soc_info, }=
,
>>  +	{ }
>>  +};
>=20
> Nit: why not order these numerically? ie. 25b, 40, 70.

They are in chronological order - the jz4725b is newer than the jz4740.

>>  +static struct regmap * __init ingenic_tcu_create_regmap(struct=20
>> device_node *np)
>>  +{
>>  +	struct resource res;
>>  +	void __iomem *base;
>>  +	struct regmap *map;
>>  +
>>  +	if (!of_match_node(ingenic_tcu_of_match, np))
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	base =3D of_io_request_and_map(np, 0, "TCU");
>>  +	if (IS_ERR(base))
>>  +		return ERR_PTR(PTR_ERR(base));
>=20
> This is equivalent to:
>=20
>     return ERR_CAST(base);

Alright - I'll fix it in a following patch if this V13 gets merged,
or in the V14 patchset.

> Apart from those:
>=20
>     Reviewed-by: Paul Burton <paul.burton@mips.com>
>=20
> Thanks,
>     Paul

=

