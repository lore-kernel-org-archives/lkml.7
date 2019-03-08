Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35A020811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fPDMof2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCHHBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:01:54 -0500
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:54014
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfCHHBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GygDZJQlNCmISwasa7++OWh5R3kclpX9QAI9mh97dQY=;
 b=fPDMof2Gabf+qBo6aoX2XqXGlZaC9Ho1zhnjfhys1/hIk9hnbNQRaZ5t1u9qoR0fD4IYyLu5OR1NTJ8seEh1XjfDpmF2pvHn2jXTWd+J9+twfHA53+PavEtcXRltNwzK/DfkMRjdg6hU7T/AvPzNnqPIzwjRtuRgDS0wEEwN2l0=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2390.eurprd05.prod.outlook.com (10.168.75.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Fri, 8 Mar 2019 07:01:10 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%9]) with mapi id 15.20.1686.016; Fri, 8 Mar 2019
 07:01:10 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Topic: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Index: AQHU1UMLo1AIqyRPikaxzNyP0OOhK6YBTuGA
Date:   Fri, 8 Mar 2019 07:01:10 +0000
Message-ID: <20190308070107.GE32625@mtr-leonro.mtl.com>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <2c122567-d14b-7867-9230-67f570c13d15@rasmusvillemoes.dk>
 <1552003703.45180.17.camel@acm.org>
In-Reply-To: <1552003703.45180.17.camel@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0469.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::25) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a22095f-955b-4886-d6a7-08d6a393d812
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2390;
x-ms-traffictypediagnostic: DB6PR0501MB2390:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2390;23:K8DE1QwD8zibG/AJtT4EaBodoXXcrWAs3/Rxw/Y?=
 =?us-ascii?Q?Q5VA1ASRetUjigbPlAgifbSZZzeClniXu+tGot7UXUgTVx/bmPdCRhyBJF9L?=
 =?us-ascii?Q?pG41x/0dP506VizUXFyil5eAzKAGBTPRf5QktiW3is7J/N1GfuqzLTGBrKFt?=
 =?us-ascii?Q?6U1Bb8TsZGbVJCWhfcArnKa+yaXGSJcqHBZOGy83GmfQBD526pEViX+hrkIU?=
 =?us-ascii?Q?mMlMLTxOoZvgUpMgXQScmNEgDtL1I2inQZQ3S86nOS/Rf6Lni3rBoC8Kklyc?=
 =?us-ascii?Q?bUkHvOyYVDRuh0A2mmMJndKYtZ5FhufVyPsmCkhEFWRmuoeN8x11aNhVigZ0?=
 =?us-ascii?Q?4paPnsk4xsqMcTiLZHCZeA81sfYwLl9wMGhdYbyZrYw/GYSttYvW6SxGBYAW?=
 =?us-ascii?Q?OsiEnix7wKtZuazZ6MUsHyUVDbXgRCO/+h1ZLkGnccAa7RMwaIr2rnMEH6P9?=
 =?us-ascii?Q?VtoK/HsNT9/cU9mesqFLJ9eaqD7p/S++l2kV97Ed5VYbNMulMBTTK45MdT9g?=
 =?us-ascii?Q?FR7NnpTv7QWTUQGQheu8IXI0LDJ3m3ALSnoUiEAkT91tZtP4990qBQ+XVM1h?=
 =?us-ascii?Q?0XTxtOmD3xaIxvdvWQnwIQ9WYAy8Um1MPmjqCQLCpp8HP1yha/XO/70le7Wk?=
 =?us-ascii?Q?kVlvxO00KwOd+g7ErMC1xYWRfWmXXgzOWMKvDcRO4WWgDnUK4Jh3l8JB0IS/?=
 =?us-ascii?Q?Pw7tNQCm0dcx9AuRIi6Q3ERtewWeY6sTFhR9NxU+WTqUbWCU3oKulEdfc4rU?=
 =?us-ascii?Q?IL67p7GL1jGpKnmkSXDHiy7oFfCzLWCTNg+hYiKzp2O+N3VY7DYuT6hRZsWs?=
 =?us-ascii?Q?mpMBlebTFdITBl0XTJqi2Mk1FPw37Yp1KYtyfVDiJUh5Pfduxqv9O/OEKPoH?=
 =?us-ascii?Q?gFCa7E2m9Vc/zQejiCIYwsiEZ1/r1xzY5ij4T/qVCNNWgtVR0TqPFXHErYRa?=
 =?us-ascii?Q?C6vCcPkgOeVcy4IbRw5Jv3ZWp9icvYP+ptHPT4QmLxZPGjPNAFfOibKQM7bo?=
 =?us-ascii?Q?v6xpCjDhVf6yvIzTEoneZf9QqtADKdBHjiV9QKwvnRbqSr1c7YUsStC7yl0j?=
 =?us-ascii?Q?bhe/dP08ZCN8ddsr3v17PEv0r4n7xg8CTLwRnqcRv1R3GiMWH3uZU1AVgLTc?=
 =?us-ascii?Q?ji9w3Tc1jPBsoLzv90a2B7pgZNjnRHZwLBlhy4/e3UWP7v19xM8Qn4j0NsR6?=
 =?us-ascii?Q?jlCSgaGjBUv3rstqHqBvcUpXwDSffzh1Gh2Jc/5ohGu9FP9Y4E3yQi26FcDY?=
 =?us-ascii?Q?y/LX+LJJyOL/mVDWt6BxEZCt7a2wyW/I95VW2URXRA5VqDIUFMcD9BA+571x?=
 =?us-ascii?Q?4+qND8IOyokTONnQPDvZjFSYyJrvS1ksCbJG7eP7avIoH?=
x-microsoft-antispam-prvs: <DB6PR0501MB2390928FD39F56D1D747699FB04D0@DB6PR0501MB2390.eurprd05.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(386003)(6506007)(105586002)(26005)(52116002)(25786009)(5660300002)(99936001)(102836004)(106356001)(1076003)(76176011)(6916009)(7736002)(33656002)(305945005)(53546011)(4326008)(186003)(97736004)(71190400001)(71200400001)(8936002)(53936002)(93886005)(6306002)(81166006)(81156014)(6512007)(9686003)(966005)(3846002)(6116002)(68736007)(14454004)(6246003)(478600001)(229853002)(14444005)(256004)(86362001)(66066001)(6436002)(316002)(54906003)(476003)(11346002)(8676002)(486006)(6486002)(99286004)(2906002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2390;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 71lvhKXy97ATuBKgSuhongc/y7H/x2IxHFLzyFWCBFdEshThiAjOR/ry67xy/GKGCekHFqz3qtNF9hikeX2ZDccYfiyevlNHHlgJ/R5+eYaSr0H/TtZaomm1UuUCRBENFvMef+qtvGsvnTTwGbDiF1JuF4WyObsPtioxLS+HcxuMe20OxM+hyN7p7cyycS8Fi1e67Rs0vmYMBnXJXFr17dqLvm2v4XQ//FghbCPU8PX6LsBZGFDfPqetXyqFOad5ynY0r7DloPY3BVWzJOn+Jcs1EOHEkKWC0s6RDVOipt9R4jEt5eeOjXBjFT9Jv2VeM3mU3TuetztAgLhOSyK29kCmKJGZxbpMi5dCy644FeoRv3xQS4xgPiOzyzaOdxvq2CFL4wtF6nddZTsvlrpXpisRBjY1J93KRtvfGqFOaaw=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a22095f-955b-4886-d6a7-08d6a393d812
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 07:01:10.3750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2390
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2019 at 04:08:23PM -0800, Bart Van Assche wrote:
> On Thu, 2019-03-07 at 08:18 +0100, Rasmus Villemoes wrote:
> > On 07/03/2019 03.14, Bart Van Assche wrote:
> > > On 3/6/19 5:24 PM, Jason Gunthorpe wrote:
> > > > >
> > > > > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > > > > index 40b48e2133cb..8afe0c0ada6f 100644
> > > > > +++ b/include/linux/overflow.h
> > > > > @@ -202,6 +202,24 @@
> > > > >     #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
> > > > >   +/*
> > > > > + * Evaluate a >= 0 without triggering a compiler warning if the type
> > > > > of a
> > > > > + * is an unsigned type.
> > > > > + */
> > > > > +#define is_positive(a) ({                    \
> >
> > is_non_negative, please! positive means > 0. And perhaps it's better to
> > move these utility macros closer to the top of the file, together with
> > the other type/range helpers.
>
> Hi Rasmus,
>
> Thank you for the feedback. But according to what I found online opinions
> about whether or not zero is a positive number seem to vary. From
> https://en.wikipedia.org/wiki/Sign_(mathematics):

Mathematical therm for discrete numbers greater or equal to zero is
"normal numbers".

Thanks

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcghMzAAoJEORje4g2clin3fEP/Ryga+qaXDVG2UegGY8K4NRl
Rl+/Rgpm2r5QFXi3BJnOE2DLn+2NH0W9hDptOy4STRSyU7C7iCFmm2MaDqJ7itaR
kdgy+iv4SSCLgaTsrYMWvnBM/qudXKPTzXOho6twu0j69vOD4dU/TxJNnTFY8nyD
yR96MKRINbSMQYtCTVp8pUryM7pULdJ0joPg1R5mcJm7NlyennADb8YMDEfXWuCd
O9RPvnI8gno1SqYcEdfHcnCzpOYT02kQyQ4E1ZQy/g7DA3n8G76S4ZqiFkai6vZ7
IZYc5WEYfTCcF1U4sv9rXzaPAChMTdLgxJeG79+ssZKkiNhWsXxlZpnqfh16ZyP9
tAhxJQ1bv012YM/0VlHWtp4/PI0NLb/VMl0LsoKrFdPMnXS9OrhejBP7LzUt0uCC
5gFp5gtBiT5Uvqy8m5FyBQnPAkX5N9TXyT9bZzdWUhynH1btet6HwqGYsDi8G9UA
GQ2345fynt4Bprjmc6yXCioyvWUsRJOg/+ZypYxwvl9DBTk7zijcPHSl8bpaIqnU
XX/zdmXm90EmZQuZykImwDrNDOYe6hdSa9MOmdqNoILP73VMapHY0Ko6+gCFpUsI
FB48nRuEEJDPKDTmZiIUDf/8tti5vr0BZ1Lp/OOX4SNKQ93b3wT2X+cpj3WLCoOJ
DoBkwhO/gFlbSr1w9ltz
=9dvA
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
