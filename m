Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB4BC48BE3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA022064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VWxIqfCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfGHBWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:22:19 -0400
Received: from mail-eopbgr40087.outbound.protection.outlook.com ([40.107.4.87]:31556
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbfGHBWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2iz7yaacijSKO9oEt6QqOfXTsgWcAScl2A2PfWskYI=;
 b=VWxIqfCoYS2UlIAIyhKGnF89FU0oQN2t41sfYyAl9OG16LfOIqi06Y/SJGmaB1KH3domikHgmSfJqjzSuIT398iz+s7GTKsRYtlCvZyRHgEnoGokMqUdVO6bl68imDbF14F/P8qhOndn4WTrcGEmBTube1+HLprh4PGSgM3E+/k=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1SPR01MB0001.eurprd04.prod.outlook.com (20.179.193.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 01:22:15 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 01:22:15 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Vinod Koul <vkoul@kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: RE: linux-next: build failure after merge of the slave-dma tree
Thread-Topic: linux-next: build failure after merge of the slave-dma tree
Thread-Index: AQHVMjqAoCw3ift/eE+RdAWMvGtRgaa75B+Q
Date:   Mon, 8 Jul 2019 01:22:15 +0000
Message-ID: <VE1PR04MB6638080C43EC68EFF9F7B38A89F60@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190704173108.0646eef8@canb.auug.org.au>
In-Reply-To: <20190704173108.0646eef8@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b8f2e65-082b-43a6-81be-08d70342b625
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1SPR01MB0001;
x-ms-traffictypediagnostic: VE1SPR01MB0001:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VE1SPR01MB0001C856CA53D750DD6A59C789F60@VE1SPR01MB0001.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(53754006)(305945005)(7736002)(25786009)(68736007)(11346002)(6116002)(76176011)(74316002)(52536014)(86362001)(76116006)(71190400001)(446003)(3846002)(26005)(81166006)(81156014)(186003)(316002)(486006)(476003)(8676002)(71200400001)(7696005)(8936002)(66066001)(33656002)(64756008)(66556008)(66946007)(478600001)(73956011)(4744005)(256004)(6436002)(102836004)(66446008)(66476007)(14454004)(110136005)(966005)(9686003)(6246003)(53936002)(2906002)(4326008)(53546011)(6306002)(5660300002)(229853002)(99286004)(55016002)(54906003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1SPR01MB0001;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G/zx6QmUoHe9RxgeMcjK0WOZPJGrtI+A6dVT5G2lWMI7+1I5uNDtYmgiSG4eEMRCo0/bU26JH8W1OvqNDsUP//7Cf38hRKZ1MsArRDxUL0/RbO6807nweJBi2ysMtir8UV90BsEinasE4KKqER7iG0EGzGo1ntwR7T5rHzCvaahv2Bi+d5gPCAxkEbYMah+WnblkQJNHazZmltoFd1gbswg88LALZTft6qCE9UDnaqNSq2AGo/dBWVDifHqsfTwUfEpE+AAT61YF5mESeIUaUT2Dc2coRWih0bz5pmCFGOR5j90uC7essRh8fFfMFptSdW2nO30VAc3X3HSXhny3MfzenuzV6ZNwVr+c+Z+zGWFRE8Ot6oyGMQ6U2qLr0NukuGknGQ6GWKqtOVqUpvw2rz2IwC2Ht/4lS/y2i/M/NAM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8f2e65-082b-43a6-81be-08d70342b625
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 01:22:15.2132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1SPR01MB0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
	That's caused by 'of_irq_count' NOT export to global symbol, and I'm curio=
us why it has been
here for so long since Zhangfei found it in 2015. https://patchwork.kernel.=
org/patch/7404681/
Hi Rob,
	Is there something I miss so that Zhangfei's patch not accepted finally?

On 04-07-19, 15:31 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>=20
> After merging the slave-dma tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> ERROR: "of_irq_count" [drivers/dma/fsl-edma.ko] undefined!
>=20
> Caused by commit
>=20
>   7144afd025b2 ("dmaengine: fsl-edma: add i.mx7ulp edma2 version
> support")
>=20
> I have reverted that commit for today.
>=20
> --
> Cheers,
> Stephen Rothwell
