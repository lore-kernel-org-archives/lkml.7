Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5629C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BB52073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W5wfEGDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfDPIBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:01:25 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:45450 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfDPIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:01:25 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 6E00F24E1EF4;
        Tue, 16 Apr 2019 01:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555401685; bh=Byw4Jlfb3vVMbYR9PZJVptEC4eG8/zB9mIfECSDHlP4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=W5wfEGDUVPqFpB+jhTqf7v1iNJa8euWLZEn3OQnSDBPdutbEQe2nXjUsLYxUlkmg3
         25BMqPmsLDPrPhEy5YszTzxV2nOURv203QE9H0FQeBkDvwbazDYjdxAqZWHrB9bkb1
         GkJQ13BCN7kRzA425KRj0qGynquC2+JaF0xcMoG2nk9h+cT0QrWEIniim7Uk7Sx/BT
         mfgSCG2rMI6/+QjDUpte2E+Pd6LJGHf1NjOfMeqgqNo0YqIW3XMgAhsislX6NLoBmB
         VpLH20db241j1T2YVx65JCVb0lVp/xaRv36SallUvf2KacJXWzzr8N7yHzsVkw6wpI
         z9dwyXuJVZb7A==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C4CE9A00AB;
        Tue, 16 Apr 2019 08:01:23 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 16 Apr 2019 01:01:23 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 16 Apr 2019 10:01:20 +0200
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Jose Abreu <jose.abreu@synopsys.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
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
Thread-Index: AQHU6Ld2BNOIyyJamEeC//pMtZni+6YnhciAgAADZICAAAGHgIAA920AgAAfNACAACI8cIAAipiAgAALMwCAALjx8IAAYG+AgAAFvgCAAASDgIAC4/OwgABi2ACAAAQmgIAAAsSAgAmYDQCAAM6qYIAAHUAAgASlj1CAAMHYgIAACYSAgADDLCA=
Date:   Tue, 16 Apr 2019 08:01:20 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B45B252@DE02WEMBXB.internal.synopsys.com>
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
        <78EB27739596EE489E55E81C33FEC33A0B4566A9@DE02WEMBXB.internal.synopsys.com>
        <1555067632.1216.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4586B2@DE02WEMBXB.internal.synopsys.com>
        <1555364715.1223.0@gmail.com> <1555366759.1223.1@gmail.com>
In-Reply-To: <1555366759.1223.1@gmail.com>
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
Date: Mon, Apr 15, 2019 at 23:19:19

>=20
> So far with iperf testing
>=20
> txpbl <0x20>
> and no-pbl-x8 gives me the best tx I've seen so far:
> 914 average, peak 933 Mbps

Cool. If you want to do more tests then the next step is to remove the=20
no-pbl-x8 and start with pbl =3D 0x1, then 0x2, 0x4, 0x8, 0x10, 0x20.=20
Without the pblx8 binding then PBL setting will be multiplied by 8.

Do not try to use PBL values different than the above because it can lead=20
to undefined behavior.

Anyway, I think the performance values you presented are good.

Thanks,
Jose Miguel Abreu
