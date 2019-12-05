Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77179C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEC721835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JaYoMpTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfLEDY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:24:59 -0500
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:20045
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728321AbfLEDY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:24:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ijp2ZMI/tE6FPw+b5ZxLK8/lo1hqWSHPpO2kssClRT5+8fs9lzm2VCFEnrFn1cJ/se7hIc45XWgDaJEN4F8z75fKXAIxwbcNxBJj3RjIqHNP/r3f3wW5/nVu6QQBGDZf5F9cwvEBTSYrDp8LYH9cNe4z5r674GXml+6+5jAlXB0/GsQnUDdj4vcMPQHkzaM4AMVBslUtx9jfLn/zM5DyLNtOyNX9yQ1rLFfcP8rVu8twYTTOEGJYc6JCQZxEbIvMac/2eS9nSrb5Q9pi11SUv3I2EwXPcTdEca23jf3AqNNXqaz29XAHZ4nciI3FcnvecANH6F4rDIpxBjFkbEB/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0azkcCarpinWElGDlSnRpT7MLy/rA5LqzM+H0xFK9mw=;
 b=DeBHpkmyFSLjxrTtp6O1Nlo8pCKfznIKzH7Z9zdJgQ4J/paTB/3ELlMM0dkk85BdPKiWqAsXmh4O0yvbHy5LUsq1DQ9Io3qDN7e7Q7246V2zl1VOwaiNpygXZJ+irhAYwqyZt2wS91HxU0EwNJ7aa6ZcUx2gK50pAZiBRWRRRiBjUVkLTwxuwv5gOH+2V14kHDEDIwTn1Uv/8PnZBhSpK0aT1e8bwdpWfHgZK2vdZcZlgdM5TD3vAjkpV/R1d2TsihvmADyCYBbQmllQvA77YvkTADGYXeSczgJPzaIEoZHtKp9YkDr1ttfAuSQTsvQiMmMezSqkxvwGeYFeuBHD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0azkcCarpinWElGDlSnRpT7MLy/rA5LqzM+H0xFK9mw=;
 b=JaYoMpTVtGXy/RTHLfdXmrZg1wvcbUVwbdVeHdJRSEAr6mpQqu52MpuQaCvSMnm79JKmvX2k3mAa93+uO2x6wHPCSaclcreP9pe6WY7x/OaZNFIckIIX/yp94ejQLBgZkWM02UdaOnOmuttteMcwX4Uoaz0bFNijWK8EzB3Iwmo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6163.eurprd04.prod.outlook.com (20.179.34.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 03:24:15 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 03:24:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVqPlQmY/2hS4Lz06JY3IQFRZRJKeoTIyAgAKQ8zA=
Date:   Thu, 5 Dec 2019 03:24:14 +0000
Message-ID: <AM0PR04MB448140416B9AFD18051A7E84885C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1575281525-1549-1-git-send-email-peng.fan@nxp.com>
 <1575281525-1549-3-git-send-email-peng.fan@nxp.com>
 <20191203114607.GA4171@bogus>
In-Reply-To: <20191203114607.GA4171@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2301265-8985-4e5d-68a5-08d779329af0
x-ms-traffictypediagnostic: AM0PR04MB6163:|AM0PR04MB6163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB616324D0066F18209867743D885C0@AM0PR04MB6163.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(78114003)(199004)(189003)(5660300002)(229853002)(3846002)(6436002)(6116002)(554214002)(2906002)(6246003)(6306002)(9686003)(186003)(99286004)(44832011)(7696005)(316002)(14454004)(76176011)(11346002)(54906003)(6506007)(102836004)(8676002)(81166006)(81156014)(55016002)(86362001)(26005)(8936002)(74316002)(64756008)(305945005)(7736002)(15650500001)(6916009)(4326008)(966005)(45080400002)(25786009)(478600001)(7416002)(66476007)(66556008)(66446008)(33656002)(52536014)(71200400001)(66946007)(71190400001)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6163;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkYfEUg4xyDzhxLameLYD5QG5T8UOz8hG1o9QcPGpLgIh5EpKHDcNla0Leg6X4eBEOIv8hK73ySl9GOLn5UKEC6vPWnznwRcYv9axjNYGK7qqTrbrBsY8CXV17oGoec/dy0MaPD2fbMBXLgX/Wepabnv+xtD61UWi1DVoDCeGE0hIUBofeM50nHHMzRO3a9wdJ4cCboGsLNC3633XPSPHg7MX1BE9GDynBeFWR5Izhb0CgY6oVQt+GCQgaDInqHVPEyedke/RbuUCeMMgb1DlyUwxD+rQw5bZaBduRAPt8UDt2Syzx3YqzAmoWkW0Pqjxe3LbF6ReUO25rWe79o+24FmB04O+FvRf6rvh8t3hCoitIgn+0YQgBxRCHhQsKGbJW4/el4Juk+ngToamebcZhXT4Bg2XKc0FBjJOWboJOgQCDKWVtn4fTAcHEjlTkFfcNk4ljKSDiuHpzflph2QJS70WJFNcFlclpqq4OgaEsX6QZn2UGmJ3QxuSlZzwjJdB3AekreFiPBbnvQQNhMuypLy8lDfo/DXrKOJdzXrrmA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2301265-8985-4e5d-68a5-08d779329af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 03:24:14.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Q0+BW6Ipl2pKjFVS2HymgJl00Ny5awh7o8+pIcQLha2wbkAX/eLqzWUA07GGtksinxeGWKkpW6ACVDBKmBpvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
>=20
> (+Viresh,Arnd)
>=20
> On Mon, Dec 02, 2019 at 10:14:43AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > This mailbox driver implements a mailbox which signals transmitted
> > data via an ARM smc (secure monitor call) instruction. The mailbox
> > receiver is implemented in firmware and can synchronously return data
> > when it returns execution to the non-secure world again.
> > An asynchronous receive path is not implemented.
> > This allows the usage of a mailbox to trigger firmware actions on SoCs
> > which either don't have a separate management processor or on which
> > such a core is not available. A user of this mailbox could be the SCP
> > interface.
> >
>=20
> I would like to know all the use-cases for this driver ?=20

Currently my usecase is SCMI.

Is this only for SCMI or
> will this get used with other protocols on the top. I assume the latter a=
nd
> hence it is preferred to keep this as a mailbox driver.
>=20
> I am not against this approach but the reason I ask is to avoid duplicati=
on.
> Viresh has suggested abstraction of transport from SCMI driver to enable
> other transports[1]. Couple of transports that I am aware of is this SMC/=
HVC
> and the new(still in-concept) SPCI.
>=20
> So I am looking for opinions on that approach. Please feel free to commen=
t
> here or as part of that patch.

If we want to use SMC as transports, smc mailbox or smc transports(non-mail=
box)
could be used. Both ok for me, smc transports just need write a new driver
under scmi folder.

I left the decision to you(scmi maintainer) and Jassi(mailbox maintainer),
Just hope the smc/hvc used as transports could be landed in upstream soon.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Flkml%2F5c545c2866ba075ddb44907940a1dae1d823b8a1.15750
> 19719.git.viresh.kumar%40linaro.org&amp;data=3D02%7C01%7Cpeng.fan%40n
> xp.com%7C06edb0c37371419db3cd08d777e66780%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C1%7C637109703766574454&amp;sdata=3DnInLSUu
> mwzBvl%2FcmckQkpZbJT4JAtVkzr1TSWkmz6qo%3D&amp;reserved=3D0
