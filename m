Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F7AC468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F88E20828
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kgsc629a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfGFNnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 09:43:35 -0400
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:36071
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfGFNnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 09:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2iz7yaacijSKO9oEt6QqOfXTsgWcAScl2A2PfWskYI=;
 b=kgsc629aXVixMa93vgJH60agjG2e+InwqgPhGpqybPEYyXyKxjOLHGJciceTOjQi5OnHFBpMJyUrx42Jqphgvrg1GVL35//MWMrxeNStgq9ipJaJR1N6na/bZf3SbHkqtbMWcFpzsy9Lhp1gVSTWS8QChFIwvPeHsUrYSd1gOro=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6383.eurprd04.prod.outlook.com (20.179.232.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Sat, 6 Jul 2019 13:43:31 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.2052.019; Sat, 6 Jul 2019
 13:43:31 +0000
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
Date:   Sat, 6 Jul 2019 13:43:30 +0000
Message-ID: <VE1PR04MB6638782ADA8BFB8A17BAF19D89F40@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190704173108.0646eef8@canb.auug.org.au>
In-Reply-To: <20190704173108.0646eef8@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [116.232.30.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 883d7b9e-8af1-46c7-3963-08d70217ef02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6383;
x-ms-traffictypediagnostic: VE1PR04MB6383:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VE1PR04MB6383562C6038269C62748F8389F40@VE1PR04MB6383.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 00909363D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(53754006)(256004)(74316002)(305945005)(7736002)(476003)(3846002)(229853002)(486006)(6246003)(6116002)(71200400001)(71190400001)(55016002)(9686003)(4744005)(6436002)(2906002)(6306002)(53936002)(64756008)(8676002)(52536014)(66446008)(81156014)(76116006)(8936002)(81166006)(66556008)(66476007)(66946007)(73956011)(5660300002)(86362001)(68736007)(25786009)(478600001)(966005)(4326008)(316002)(110136005)(54906003)(33656002)(99286004)(7696005)(446003)(14454004)(6506007)(186003)(66066001)(102836004)(76176011)(26005)(11346002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6383;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iWzP0QFIFiDrnFPnmSeT9X2CPM//zHBhArQjMqBQNceA6k+/vyF/WwNYiukhOmKMCjVsl7OkWq9rOrqsk9Fbf4UZqI/quta2rjmiKqx158AFIa051dkMVDBuJY82sNb+U4n27Sp8NUT4YPQfHZPbENPOS3AA6THgF3r1IHzjevoe5nbLUXadSa0Ytftv/igVJBC/jJzHB+KAULriShMVJHgQtIUyaoIKKj74owy3MfKdAOk3ZOA3H93mxAPXPy3TKwoZUDxUZZP5P3+k9COy9SnK49g9THv4pNfvJePskYokRUPR8hw5dld76xt1SaEyiuW8L2vR3b8W0F4XUBrZD3ipwoC+RYzKw5mByY5zDtyjypq+iLR3nCUJbMkv0+ntSmzqAeo0PhEb/cScwPrIZ0bf8ncGrctW04x8YSGOT/s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883d7b9e-8af1-46c7-3963-08d70217ef02
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2019 13:43:31.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6383
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
