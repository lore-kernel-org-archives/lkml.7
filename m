Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6218C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA172081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Hsler9G6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbfGYH20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:28:26 -0400
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:22400
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387738AbfGYH2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyFoXYwAQiC6Vp7jKEngYEYd/it7DcAasEXR6nY/IAg7wEgaB0nCARuR+UD2zLwgMqovOcQ1C+RYHg8Oqoj08GxD+21/GPeqLeYtjAolJTAsd23VbXQKb43XGMOrSOqG6lTXLYqMD9f0jArKBAkY+AlKpn0JQhK9CXu7joKUjB5cVyxZP04CSthWo6qCarMoFqJHupgK8sVSdFdaibG+Bc62lSOiwTfDGMyJeoxudSIPPbad8BqQiu3FCuO65mq2RbLeY6+TsNNF+lUcwPwBl0aySQ6sOIoGZZ/OASRh4woOE20WA7uxwCrN6WqxQ5/aoru1ZVr8OucsUcwxa/BExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaP8L6Iy+9MthBaY576XhaDGWOZVVpNLa0HLtbZI6Gc=;
 b=eNbi7izmUt5xFBqH1tFfPunQqQdlJDcox1ZzL4mRIfO4xn1/UoCFKZEprdSTHiYYawDEP5x9FXgn0rfA57Wkpfs2Kt1r6X5Ek1YaY3ipfa3Ck9AEUmtWP9QyDXpLbuK20wjMkGFrpwWy/g7MmwRCXRVBljP5UbqKWvTJ8iuyzcza3KkvshfdwNPrVxp/thisgNXSDPH5/tNpDGRgIMX5Eumln2nsuXt1wCbx4S3ulJU6iuEQX0Sr6PAovNfX/NDN8hmTNR3v5or2u9Q6V6F5ou4KCSC6hkDWraxByUHjrMGupYTwtn7/ixz+3xCpTYS3+YbgjStWgMn1S5QdqxBgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synaptics.com;dmarc=pass action=none
 header.from=synaptics.com;dkim=pass header.d=synaptics.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaP8L6Iy+9MthBaY576XhaDGWOZVVpNLa0HLtbZI6Gc=;
 b=Hsler9G6Al4Feuzd0gEMT86Fmp2HyoRh9toZ5BsdDM0WWVtBxWSTGuhZcXIaasgGbmhBKxp7C9MpMBQmcKj1Vm7ab7BIAqCRuGYBkWM+98Fx/A+yku4ADd9ETbqijrKu1vv7zzq7RPGiT6PN+mD4HD0UuwlREL7pDaxNLHLGRQ8=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3447.namprd03.prod.outlook.com (52.135.212.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 25 Jul 2019 07:28:23 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b1e6:c114:bea7:6763]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b1e6:c114:bea7:6763%7]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 07:28:23 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-pltfm: Use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] mmc: sdhci-pltfm: Use devm_platform_ioremap_resource()
 to simplify code
Thread-Index: AQHVQrqKas5DyjqBokmNQ+F9bjYpsw==
Date:   Thu, 25 Jul 2019 07:28:22 +0000
Message-ID: <20190725151748.1a59b1ba@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:404:28::21) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2e11b44-8344-4ac0-3727-08d710d1ac9e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3447;
x-ms-traffictypediagnostic: BYAPR03MB3447:
x-microsoft-antispam-prvs: <BYAPR03MB3447CD5DB692C9ECE4E3C731EDC10@BYAPR03MB3447.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(39860400002)(346002)(199004)(189003)(316002)(476003)(110136005)(99286004)(54906003)(2906002)(478600001)(52116002)(186003)(486006)(6486002)(8936002)(102836004)(386003)(6506007)(1076003)(66446008)(26005)(256004)(5660300002)(71200400001)(71190400001)(4744005)(66556008)(66946007)(64756008)(53936002)(9686003)(3846002)(6512007)(86362001)(7736002)(81166006)(66476007)(4326008)(6436002)(8676002)(68736007)(66066001)(14454004)(50226002)(6116002)(81156014)(305945005)(25786009)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3447;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cslel0aKcjBgZcn0fsxJOZC5Yi7758F5/eaLLQgGx3b4vAbl+/4/2PSpQOjZdv9oGw7aGfYCqMnZgie/W7TQlGEVimLad/NQa00Nopk2iB207ACAUkM0wppP5v/b791cCkVhZSdKC/zvYpXR0kWxi4dxrSPUCkKJ2lwIT04CmmgwY8HvuA3Rm98dqdPrVnUEGbF2/D3XoVYFQ+K38sFTQ8ojp1M5aUBHapIRi0/0cmC8nvojSTPo1suSgHF2+wQ80wqas3l2LHFE1KoA3N8t2o7me7NWqZQbf4Ls+zvjStcjQ7N2deVLfhB/6wiS00UA0Otqu0ssdT8jJmlwkkcgUujlxiwhV5MNkXoQ0yDE531Lo1EqveXO1DDMUXUq/U8uRuOGPAsVkA3DuVggrhFb+VAc/4iktIkEkhsgSKtuEtI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DFBD51F7FD4080428927BA250222F162@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e11b44-8344-4ac0-3727-08d710d1ac9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 07:28:22.8502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiszha@synaptics.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_platform_ioremap_resource() wraps platform_get_resource() and
devm_ioremap_resource() in a single helper, let's use that helper to
simplify the code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.=
c
index d268b3b8850a..11ecff9e998d 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -118,12 +118,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_d=
evice *pdev,
 				    size_t priv_size)
 {
 	struct sdhci_host *host;
-	struct resource *iomem;
 	void __iomem *ioaddr;
 	int irq, ret;
=20
-	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ioaddr =3D devm_ioremap_resource(&pdev->dev, iomem);
+	ioaddr =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ioaddr)) {
 		ret =3D PTR_ERR(ioaddr);
 		goto err;
--=20
2.22.0

