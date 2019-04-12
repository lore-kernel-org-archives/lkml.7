Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5364C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE9F2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CvwCuHSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfDLHfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:35:12 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:46240 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:35:12 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 058F324E2587;
        Fri, 12 Apr 2019 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555054511; bh=NcfN+WqdKsh9W+OJkfbgdXyesiwTOONTaKELzou9GQU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CvwCuHSUAfogOeSEpnwydmeSFK9spDhYKz/rbOsN6bVlHrhLnDDFhC1qRcUUgHCCo
         0oQ2OGF4KALYVBCqjvXgNKygwjoeKViwwpKFFqax29SEiaPoO97Mb+HZv7g2zfLwk0
         QifD05jDqB40+xiHITiOedwDCuxgLOZdLRAJEImisWPKbKd9PS0Bl6SN4vNTOVfVA0
         S+y2rTmtgjHPX73/jEj9ow1MQJqllsAp3kJ291Vqx47dIebfioXqwv7/c3GGofiCEZ
         LqhiqLYdx2/8vA3JHdmeeVyYkzsAWVPHqupXAflypJHUg84fcWoM4KWQFpbEL5aGet
         34ZH/N0RFs8ZA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0B46BA009D;
        Fri, 12 Apr 2019 07:35:09 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 12 Apr 2019 00:35:08 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 12 Apr 2019 09:35:07 +0200
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Jose Abreu <jose.abreu@synopsys.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        =?iso-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        =?iso-8859-1?Q?Christoph_M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: RE: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
Thread-Topic: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
Thread-Index: AQHU6Ld2BNOIyyJamEeC//pMtZni+6YnhciAgAADZICAAAGHgIAA920AgAAfNACAACI8cIAAipiAgAALMwCAALjx8IAAYG+AgAAFvgCAAASDgIAC4/OwgABi2ACAAAQmgIAAAsSAgAmYDQCAAM6qYA==
Date:   Fri, 12 Apr 2019 07:35:05 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B4566A9@DE02WEMBXB.internal.synopsys.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
        <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
        <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
        <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
        <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
        <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
        <1554305721.1328.0@gmail.com> <1554306954.1328.1@gmail.com>
        <c863f88a-65e2-4093-7cc1-f37e4443b871@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B44985F@DE02WEMBXB.internal.synopsys.com>
        <1554488052.1193.1@gmail.com> <85c1d945-d49b-3350-6ff4-a058c5a8c1d7@arm.com>
        <1554489537.1199.0@gmail.com> <1555016970.28872.0@gmail.com>
In-Reply-To: <1555016970.28872.0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.107.19.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonidas P. Papadakos <papadakospan@gmail.com>
Date: Thu, Apr 11, 2019 at 22:09:30

>=20
> At this point I've settled on snps,txpbl =3D <0x20> by itself.
> If I increase the MTU from the default of 1500 I get a stack trace and=20
> link reset almost immediately:
> (https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__pastebin.com_raw_=
5JBtfWei&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DWHDsc6kcWAl4i96Vm5hJ_19I=
Jiuxx_p_Rzo2g-uHDKw&m=3D4VBEjla4XZR8-m8v84wV5TnhbHyIvTniApjuk2XMoS8&s=3DpiZ=
9ECO216D0lthteXLpCiOvlHwJhq-x_pBKChT274Y&e=3D)
> whether TX Checksumming is ON or OFF.

Can you please share the stacktrace here ? I can't access pastebin due to=20
corporate policy.

If it's a queue timeout then please share your "dmesg | grep -i stmmac"=20
since boot.

>=20
> That said, with the default MTU, I get better speeds when TX=20
> Checksumming is on and the PBL tweak is set.
>=20
> Is there a better option in the horizon for the near future?
> At least for the Renegade (the only board I have to test) it can serve=20
> as a temporary workaround.
> Should I make a patch to replace force_thresh_dma_mode with txbpl=20
> <0x20> for the Renegade specifically?
>=20
> In any case I would be happy to help as much as I can to figure out if=20
> it's a board specific thing, or SoC, or even an issue of the Ethernet=20
> device itself.

This is not a workaround neither an issue. It's well stablished that PBL=20
setting interferes with COE so one must choose a setting that depends on=20
FIFO size. I would like to make it automatic in the driver but I didn't=20
have the time to submit a patch yet, sorry.

Thanks,
Jose Miguel Abreu
