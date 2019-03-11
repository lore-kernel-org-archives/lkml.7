Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8079E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="haFvogwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfCKKlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:41:45 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:30083
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbfCKKlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPh1j3RIgOMN9U4MQeYrhzAWxwt1dV5frmqk13pI/yw=;
 b=haFvogwMv4mwKlJrteRdz06Z0VCnK0s42WHtUj9ij1dcT4tymhPRsIJBjlbO2r+mI99A4w0B5hNpy1osy2lTSCfj1DQ7/ImZ6z1i7gi5arxt/kX2jD/qJ3Q9T3skfZqecPNUDHI/oBG/ih+pI0wkcE69bC1Ly4UbljgunplwwLE=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5235.eurprd04.prod.outlook.com (20.177.41.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 10:41:41 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 10:41:41 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] clk: imx: Allow re-parenting by default on set rate
Thread-Topic: [RFC] clk: imx: Allow re-parenting by default on set rate
Thread-Index: AQHU1McGI7U/PNQmd0+BEjFYJ+Rc/6YGQMOAgAADtAA=
Date:   Mon, 11 Mar 2019 10:41:40 +0000
Message-ID: <20190311104140.n65jvamx76rzkonr@fsr-ub1664-175>
References: <1551950425-7346-1-git-send-email-abel.vesa@nxp.com>
 <20190311102825.g7d5mmorcltxnnzf@pengutronix.de>
In-Reply-To: <20190311102825.g7d5mmorcltxnnzf@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 083f4345-1380-407b-07d8-08d6a60e25a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5235;
x-ms-traffictypediagnostic: AM0PR04MB5235:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB5235;23:F8K8odyvHgToQcAc+X8xEFyJUawdwlCaV7vCW21De?=
 =?us-ascii?Q?Ec/LPEsTfDbzhQzAdb2iEC8biOsfEQhb7xz+03c0YUdMY1o25u6w5jzqd/Qu?=
 =?us-ascii?Q?NQFfjcNd0PzAuy/1EnLBPJ3iCk83tVP9zGdSwvhuh9v5RnItbm/cLjAiCUJa?=
 =?us-ascii?Q?LI6+urwmeBFlGYvkYY85OGxYFfBPbcZRbVd+Ba9thkUcZzGj9vqiLb2l6iTj?=
 =?us-ascii?Q?ucMs0pZnwkVPQoBLtlUqW0eS6uqxL3CaMaackiOM5gshpOsf5ircQCZR+d88?=
 =?us-ascii?Q?8hPA9BVjRgFr8tRVG8QYzRKhlIw/eVRXKucQwWZF/8Tq2WPlRmvXu4g9vCZY?=
 =?us-ascii?Q?QXOdGso422epkOA9cXPjrvh1BGO3QJo6/a1sFHwHJCbV4PadZRTZGd1bpibH?=
 =?us-ascii?Q?Qe6gguzubMI3iMtqJvApZmRaWEi/xu2qpIBTHzh8C/1nMUE+C3hUcasTbg9o?=
 =?us-ascii?Q?E1ubUKmjwRelEW//507a0T0Gzw5jogf+zmsBhLXYxGMhWEoc7rp1BOA7oR+w?=
 =?us-ascii?Q?kME5hXNTdqYY5uiRQybaD9rbE/zuO0L0WbuVtkBxpDtUQHJeW0/MiCXFvPna?=
 =?us-ascii?Q?GR7+0Povl4c0JYC8CeizPg/Cby94h2bJkQkZqT2pdjRf6t5nAbCeK1qRlKo3?=
 =?us-ascii?Q?pBbJ1VaThgMEb4xiQzubKlAkJzR0F4BBq19Vqmtvm5ked9QOYcT0uRAOBw3z?=
 =?us-ascii?Q?pyaOS9tUnj5Uc4CrxwQ/G612+JeluygA8CRXFRRbd65GO/DBuaLbdYOxi7Hq?=
 =?us-ascii?Q?5Kl83C0uzbJzhpUfDn9ksJ4EWVnDSuHtWEVX3QCoZztzxTSV5nOR29k02WmI?=
 =?us-ascii?Q?jtpDXoA4u8hGZ4kluTuSKKhRi8K0md94+cAckpWwAqn2wr0LGrp/iAMfMJSm?=
 =?us-ascii?Q?oRLUDBefebwPjreJ8LK2Qg2Z9ZgeJPR3AJoczzjUCwmDih7+zMcaDwNE1rrE?=
 =?us-ascii?Q?9MFhy2IfeS35ZUyqKSimWz77xoUgfzZ/+t6BUlLx0KTVP6+p0ftimHqQCATE?=
 =?us-ascii?Q?oubDBzjFqZpDWYDeyzSeHjOQbGgektzfbgXlOnBuPgXjEICEGRbPwrxWYvAH?=
 =?us-ascii?Q?nKs88ET1xnfh9zIkALL87gExBT07QRU3xJZZo3+1d5M5P9QTWSfqc4zZt2uZ?=
 =?us-ascii?Q?DmLNxqbt4MTSOTQFrdAq8xDFkRiU7HwoXjg2djOhI2656zfbcDmChEyzbJBX?=
 =?us-ascii?Q?LoUxiU5+hA8TmQ/u/MV9WDZHKBg8xhwtMwJ+XtvV63K6z5Vt+5pEx6nFaf39?=
 =?us-ascii?Q?0IM/6GTPwxmxxh4nbQLW81xqgqzU4BNYAPBjfntGZEt7o9XAYid2nPH/Npyi?=
 =?us-ascii?Q?VegBxnsxtZSS2fwzJBe854=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB52353D5863959B138D8ED9D8F6480@AM0PR04MB5235.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(76176011)(316002)(45080400002)(71190400001)(71200400001)(6246003)(11346002)(476003)(54906003)(486006)(53936002)(8936002)(3846002)(66066001)(446003)(14454004)(6116002)(4326008)(99286004)(86362001)(186003)(44832011)(6916009)(97736004)(33716001)(966005)(6486002)(26005)(9686003)(5660300002)(105586002)(68736007)(106356001)(478600001)(6512007)(25786009)(1076003)(6306002)(229853002)(6436002)(6506007)(53546011)(256004)(102836004)(8676002)(7736002)(305945005)(81156014)(2906002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5235;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gYrHP6Iy7Rmci91nP5JA2qB09OGxasZbtALJYOclH80T3BRsArBsNYomLn6vm1hqCDrhP+GnBzdzlmlI5GjA8SmW//SOBI5rB5xdj+u3Vu5lvY5TM/SRgleb23uP3CvrtM0ZgKxlEKf2VExHtR7UM647iCSpVwmQsTqUbvcjAhPL8noko7dfnoO0ibh62Fm6Vo025tLqmCfAO+Ii4xQ7xt3/J6j8tXfsm3Sz9dw6uXwBXo0Wj4491jac+8iX94XRhYU1iDwzg6nncWT5uYXwVU3dKyCt3LnjFQrvo6ueNd8OMiv0wOv4Hpw/XwHIHMh0UJTQvdmQIkovJ55Sj9ufrYxmvqdPNhTpXKvUUPzNEm7Eqc9zsam/yRafSoe0OYt6ikBQTwGx79Hn8WHfakIEziSgGQiiiCIrv2OMPk2wvN8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E70C3BCC02B7404296141FBA214DC5C2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083f4345-1380-407b-07d8-08d6a60e25a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 10:41:40.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-03-11 11:28:25, Sascha Hauer wrote:
> Hi Abel,
>=20
> On Thu, Mar 07, 2019 at 09:20:37AM +0000, Abel Vesa wrote:
> > By default, the muxes should re-parent on set_rate.
> > This would allow the drivers to control only the leaf clock node,
> > leaving the rest to the clock driver, that way simplifying the
> > clock control.
>=20
> I am afraid of this change. Besides the rate there might be other
> reasons to choose one mux input over another, consider for example low
> power audio playback where we need one specific mux setting because it
> provides a clock which runs at low power mode.
> On the IPU on i.MX5/6 there are clocks being used as pixel clocks
> derived from different muxes. I don't think you want to pick an input
> clock just because it happens to deliver the best clock rate at that
> point in time, but really is shared with some other clock that changes
> its rate in the next moment.
>=20

> I have no concrete examples for things that break with this change, but
> I would be more confident if we change the behaviour explicitly only for
> the muxes that we have reviewed to cope with this change.
>=20

Fair enough. We could replace all the imx_clk_mux with imx_clk_mux_norepare=
nt
and after that we can independently switch the clocks that are safe (to swi=
tch)
to imx_clk_mux (which would not have the noreparent flag set).

The main idea is to simplify the clock control from drivers point of view.

The end goal here would be to only have noreparent flag set for the clocks =
that
need specific mux control.

> Sascha
>=20
> --=20
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 | https://emea01.safelinks.pro=
tection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pengutronix.de%2F&amp;data=3D02=
%7C01%7Cabel.vesa%40nxp.com%7Cde43ba7dcd774a3709df08d6a60c4d90%7C686ea1d3bc=
2b4c6fa92cd99c5c301635%7C0%7C0%7C636878969100157679&amp;sdata=3D4eU6YmuXDhH=
JZUKVKJhiRwlzq7b9XIrUfLSl2JFlRd8%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|=
