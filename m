Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E9C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C243621670
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NQSJYUUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfH3Jkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:40:39 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:57840
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfH3Jki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:40:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQHmAzhUIAIKVF1JU6+qCn8T/PlzXY40Wxws1CW/wmI6j2I4KhGbUqiSz4ZSfpivfXT7Q1Us9jWv/5dKhcaLfdt5LZ7GUEXDleJnjdAjQhmhvvaPRXjGANboyP/GfA6YopKcoNMrTLChJctQbJdMdj7CcW4wg/dnzQyVSfdQmkf7uFbcPNszd9iitOLdIqReu0isF8jJpZmim40QL6fJDgHqL9+PH0L1AkYaBJ1j21IZDxh9xk2rlDt6fh55gC08qj/10iskcuTPWaA7DAAzrLjiw3nYK8w8n1ZX3NcZa6OEw3Wxw2+/gWA8LonPebNyFuz9G4RmFqkMlX4NZRpQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j199Et/IkZohdPhwYegKMdABIf61exT/zUjB2nb25x8=;
 b=RAA5GuVOZwEJ5KXhAuUG98E8BWq0varyHVkzTgfGMh01vx3S2FKXWudsVc8L7tF7+2UxSEeJN0u92/wVTq8RtisMUa0xCZtgI82SsJbg3onlrBkKK0xQEHuDRSvP3CnORKAVXw7CPbfX9dEyoIN0QVFebLIuJTeb+gKdNM7cviomLhC9qikAT56iHzp0DP3l4P0O/fbgl0ZP8YGextngk+mGy7nTL/+MO/PYl2/n9QtcJGeioG6kk0ivPv3ChSTi4EwGNz3sFUgC3I5H5sTYCW6rlzgP/Hsht7w6oBfRxrND9FSKQchQq0mKRXdXCewOjwvEUZ+2T6xYndmBwxMKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j199Et/IkZohdPhwYegKMdABIf61exT/zUjB2nb25x8=;
 b=NQSJYUUdoCZNMqe8jqLQmrvrhMrvBxcN9b02l8IEjjufU+qojxvnqsbI5kAmU60p3EkNhtbASSgVLfE5al2M16OfA6MprA2IhOY+b8K1o3iOyBKjytUU9wZsJJF5a4KYvnl79rt5ghiOq5jXUzF6Ir8dUMdmVkru4E9zQJXrlng=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6353.eurprd04.prod.outlook.com (20.179.252.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 09:40:34 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Fri, 30 Aug 2019
 09:40:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVXU0YJPArUxY1ok6XlIUgkri4VacTNWSAgAAFe+CAABGfAIAAAKjwgAAjQoCAAAKuIA==
Date:   Fri, 30 Aug 2019 09:40:34 +0000
Message-ID: <AM0PR04MB4481879790B4E2C3FC3554E088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
 <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
 <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
 <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190830093005.GA31297@bogus>
In-Reply-To: <20190830093005.GA31297@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4b930b5-707f-4b43-4f64-08d72d2e1b50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6353;
x-ms-traffictypediagnostic: AM0PR04MB6353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6353022ECB4C0CC61F70ABA888BD0@AM0PR04MB6353.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(53936002)(316002)(66946007)(66476007)(11346002)(6506007)(256004)(8936002)(14444005)(81166006)(6436002)(71200400001)(71190400001)(7736002)(54906003)(66446008)(64756008)(102836004)(86362001)(186003)(26005)(3846002)(4326008)(44832011)(66556008)(76176011)(476003)(486006)(76116006)(446003)(7696005)(25786009)(15650500001)(9686003)(33656002)(5660300002)(66066001)(99286004)(229853002)(305945005)(6916009)(74316002)(6116002)(8676002)(81156014)(6246003)(14454004)(2906002)(52536014)(478600001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6353;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N1i0ZlfjDSIb0aw00LHaO7LBSNAtw9P7QV/nj5m8coiHAI2KxZpBQsLZm53SJlX8+tlJ2QE/dUUAWqC0qESKFFEScHaDTN0VVdo67sSESr9wL+dLlBP/lRdY7pj5CZeaHR9Ibc36ljnTZhWmV4sahoFhIGPd+6xx8GKpiv8hzq4Ktbw7tCbtoksOfAANMfr748S8Kk0L+3w0lMkIhzQO4+J4wJXa4Sg59VYou45psr+tkl3EMbAQoylibOuDh+0A72P8drnZog6a6QjaLo4TFxg+s802wODhQ/Oi69itqsG1Um2pkOG3ja6SrJS9x0BBvip9Vv6VqQwPUi31YFaYmnluSmIKcwI+8Jo8rOfeL5m3epFFegDZ+a28XjKkt6qV+FWdnDKlwHUUAsVolB+Ihy5zvYnzDkoJGrpMSW/r4qA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b930b5-707f-4b43-4f64-08d72d2e1b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 09:40:34.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTSvnSvGdZu1f97KT8SGP8xnAwD69i05H0YOWYWGa/g0BtTyYHtT2LqJ8R9+u3MSwqEnkkKx6FLTdXDpChzc6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep

> Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the=
 ARM
> SMC/HVC mailbox
>=20
> On Fri, Aug 30, 2019 at 07:37:41AM +0000, Peng Fan wrote:
> > Hi Jassi,
> > > > I think there could be channel for TEE, and channel for Linux.
> > > > For virtualization case, there could be dedicated channel for each =
VM.
> > > >
> > > I am talking from Linux pov. Functions 0xfe and 0xff above, can't
> > > both be active at the same time, right?
> >
> > If I get your point correctly,
> > On UP, both could not be active. On SMP, tx/rx could be both active,
> > anyway this depends on secure firmware and Linux firmware design.
> >
>=20
> Just to confirm, we can't have SMC/HVC based Rx channel as there's no
> *architectural* way to achieve it. So it can be based on some interrupt f=
rom
> secure side and hence will be a *different* type of channel/controller.
>=20
> Sorry to make this point repeatedly, but juts to be absolutely clear:
> as it stands, SMC/HVC can be used only for Tx today.

Since interrupt notification was dropped in v5, I need to drop RX descripti=
on
in v6.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
