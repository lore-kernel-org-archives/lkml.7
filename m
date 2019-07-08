Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_DBL_URL_LINKBAIT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12927C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3852053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BWcT5UMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfGHCBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 22:01:34 -0400
Received: from mail-eopbgr40087.outbound.protection.outlook.com ([40.107.4.87]:23524
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbfGHCBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 22:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8NAslsVhpVR0mZec3nPeL/ZMuP2qCK+2tenkOQ8UI4=;
 b=BWcT5UMg0gCNWQ2Qn7NnxPQOrMVJdi1sG3kr2uj9Emrld0x6+g49y7cJl+BYTy/62nnBgzUOtH2xWy/FtVwmY5CLTHN+A2zQGs7N+nkaB6Ym4+F+9mXES2cKA2uLMiRqIJK0h/uqDY08CGcafRqrt+dKUasdI28CaEU7c7J4BmQ=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6605.eurprd04.prod.outlook.com (20.179.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 02:01:30 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 02:01:30 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: RE: linux-next: build failure after merge of the slave-dma tree
Thread-Topic: linux-next: build failure after merge of the slave-dma tree
Thread-Index: AQHVMjqAoCw3ift/eE+RdAWMvGtRgaa75B+QgAHJvwCAAk4owA==
Date:   Mon, 8 Jul 2019 02:01:30 +0000
Message-ID: <VE1PR04MB6638DAA60BE5910113D5DE0E89F60@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190704173108.0646eef8@canb.auug.org.au>
 <VE1PR04MB6638782ADA8BFB8A17BAF19D89F40@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20190706144324.GH2911@vkoul-mobl>
In-Reply-To: <20190706144324.GH2911@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9389ec0c-d85f-4533-ce59-08d7034831bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6605;
x-ms-traffictypediagnostic: VE1PR04MB6605:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VE1PR04MB6605C1C8ECB74D729B5FDBF089F60@VE1PR04MB6605.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(76176011)(7696005)(6246003)(316002)(54906003)(305945005)(7736002)(71200400001)(71190400001)(55016002)(74316002)(73956011)(9686003)(6306002)(102836004)(53546011)(6506007)(53936002)(66446008)(8936002)(26005)(478600001)(6436002)(68736007)(229853002)(186003)(6116002)(3846002)(4326008)(66476007)(66556008)(64756008)(66946007)(76116006)(5660300002)(486006)(81156014)(476003)(33656002)(14454004)(66066001)(45080400002)(25786009)(52536014)(2906002)(966005)(256004)(11346002)(86362001)(446003)(4744005)(99286004)(6916009)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6605;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tIiKj0ZwOFFmj8fx8lfo9KStPjIuZF35zOvwLbU59mYcmhU6SOiQPesnuQVHeoxEfo4tmiENQ3xaHugtffBra0t8plmxMj0efgKWvYprmyZVq4dk3170v3z28FSb9a7DE/Fc6r3wkwSCs8JWvN7dOd0F5Dw5Q2iWXN45h0E6l0zvHN4wTzxLhz/mk9YkVh32a39KUDu4E+7C1JvqcgjpBxe1Nj5/Z8uYtOxGPCZaamAIs3IgEOXhUHaZvvWI1ALkvITMGDDSS2K2Nr9l6LVurghsEdTsp1ChkwKOx3p+u8Fjlz6NlIZNRJGkVKDOdBOGrJlkpL4dyKrRZaz1tYo4g6jGHG+I8BFHwGMepIzskMPB4v452JgRWOwJrgKefjg1arvsNbtLTZ6WlIP7KPf5z9Z7JYd4dKPR78gUpcSjBOs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9389ec0c-d85f-4533-ce59-08d7034831bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 02:01:30.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-19, 22:43, Vinod Koul <vkoul@kernel.org> wrote:
> > 	That's caused by 'of_irq_count' NOT export to global symbol, and I'm
> > curious why it has been here for so long since Zhangfei found it in
> > 2015.
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fpatch%2F7404681%2F&amp;data=3D02%7C01%7Cyibin.gon
> g%40
> >
> nxp.com%7C6172242dfadd4f71c09a08d70220bf6f%7C686ea1d3bc2b4c6fa92
> cd99c5
> >
> c301635%7C0%7C0%7C636980211986259586&amp;sdata=3DL8v%2B1o5zfgIAS
> go4qr3pu
> > cQ%2Byox1irANsvRv5ZNLlLM%3D&amp;reserved=3D0
>=20
> Yes this does not seem to be applied, perhaps Rob can explain why. But th=
is was
> not exported how did you test it?
I had no such issue because I built in fsl-edma instead of Stephen's config=
 with building module.

