Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6363FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DF6223C7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YUgib2XX";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="KGeaE/dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfKSQ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:56:44 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:18988 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728573AbfKSQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:56:43 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJGtBKk011541;
        Tue, 19 Nov 2019 08:56:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=5psJY5oRd+BdV8GGSj8SFj9lpONmcHRW3/jk1UbNueg=;
 b=YUgib2XXQZDrvKhGBcWhb+DF9CxCyGp5I7ia25uAypZPY9tYGd7cHdhcyZf66RukaXXZ
 WouJolJlyhRi70nBYISQKnNTFzagXUsICXjDI48fswEGsW85Sam92V7Ki4ImivH0/lrE
 aZyyA5mAshXT8g2IIUGQlL5zq2om+xR8tcIQvX8LOzJe+Z6YDd7BydTczvEAjqsXQ8lS
 QrzMmDSBAvPH0QOnSgI8zUNfZ5lZUPbvzGuMqSy5GLGixV/6BhnOzSox2UTb2Ap2iJyo
 GkR8hBVi+epxOqAhB12IaAH0OfysMfCD5uNmvZIybgPdXH3+MYGlXU3d2z7O6Z/8FKR5 uQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wc82vjwf9-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 08:56:32 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 19 Nov
 2019 08:56:25 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Nov 2019 08:56:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQW2KKuOodPcUReL4durhQouaL6jaISx/L+FxoktVaEauT2Gf7JHubej3rWFcIIpl7RxSqjCFm4cJHpwtPlWMnLfuiF5JrOxHuXC07pkX1RswNqWY12wJqnJDueZ7V+OqpdNLFeWfO3RHLJvAXT2feAXb1kzFAlNYoiSZcJ70M7FVDxG4LSkla0qdWn7TBGrxkuvjC2nvODWWtUe7mqezJa6fWmun4070+QntGOEpEiF8m08katHbK9WyiA3B1ashpn8VJY1Podfa2eMfl+pq5udz5Le8Qb+5nT9BvImHfQMbNfhrf/ZDYzH0wxXGCp8+gIMC6RchTaNPLUtq2L56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5psJY5oRd+BdV8GGSj8SFj9lpONmcHRW3/jk1UbNueg=;
 b=EzeLDl5AEbvHm2LFshH86xwUmzxQwcbdaBLTHi3XUe0OgaQan0rE1yM4xmvQYg5GpG3YC2RzZZEM9U48XCwwRFbMoAat18bxuIpg3jBedSXTUVJ2tKEG807mSLIhz0boYTp1JJ/CA6d0te2CLE/6+fcN+9lG969dCvV4wrZeL00P/IAmA3grh8SsZU+QG7qhOuYlbKHPxpx22XF2AhcRcc66m4Cy6wYVJKar5AqFwOidxCTtVSFx9cqCCLUarfKRW/DeMxTGCX7qs7XmQu1MI7XW31ubONupxxIvl5cB5DQ5hjNdMLPMTgghqheVJEtcgUowi9GNlMxbVi3W6Ip8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5psJY5oRd+BdV8GGSj8SFj9lpONmcHRW3/jk1UbNueg=;
 b=KGeaE/dPtJ2MFGWqlrQufQuDMJnb7mfmdGM4j1eIPmxrD8Ksyw06QWuxR8JQM0uYmQgWPlleIRN+ohSqLcmhGewcEro6bEdumSAK+DD4ZY/yHDQkbnFE8Wjur2LVH5itF4isLULIBIhNisq3D3peAG+CDs0NkVSh6L5/xt0MvX4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2846.namprd18.prod.outlook.com (20.179.21.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 16:56:24 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 16:56:24 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Arnd Bergmann <arnd@arndb.de>, arm soc <arm@kernel.org>
CC:     Jan Glauber <jglauber@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        "Ganapatrao Prabhakerrao Kulkarni" <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robert Richter <rrichter@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: update Cavium ThunderX drivers
Thread-Topic: [PATCH 1/2] MAINTAINERS: update Cavium ThunderX drivers
Thread-Index: AQHVnvpGhPZ0pb7yrke8Hp6sbUjcEw==
Date:   Tue, 19 Nov 2019 16:56:24 +0000
Message-ID: <20191119165549.14570-2-rrichter@marvell.com>
References: <20191119165549.14570-1-rrichter@marvell.com>
In-Reply-To: <20191119165549.14570-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0020.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::30)
 To MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 350810f7-9800-4a29-73fa-08d76d116900
x-ms-traffictypediagnostic: MN2PR18MB2846:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2846E0E9B5834F3EDE3D8479D94C0@MN2PR18MB2846.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(186003)(6506007)(64756008)(478600001)(66446008)(386003)(6486002)(66946007)(476003)(486006)(2616005)(8676002)(6116002)(3846002)(14444005)(110136005)(54906003)(86362001)(316002)(36756003)(11346002)(99286004)(256004)(14454004)(7736002)(4326008)(305945005)(66066001)(25786009)(2906002)(81156014)(66556008)(66476007)(6436002)(102836004)(26005)(5660300002)(76176011)(52116002)(446003)(6306002)(6512007)(71200400001)(71190400001)(1076003)(50226002)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2846;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J9l69TJrYPzNaCcA9Pk44qRpqwnL6Qe6cVagEDcn/RseUMGVLfTfiJyuhFb/PasoffVj2HUGQ8/qLeEC8IUSIGsmKx5zeG8B7Xn2SFIJnpeICpmgHByquw70xnQ4piPim7a0dDXqd5uhH2Rtj5yIYYVIeF8w1/XMWrMgigbGCnrAL9coV7tvHgj5+FyVv3nnqDAQo2Znhy6H2qw6iuhXBg6s+l5XpZBy6JJtVJJBY1NTqSKPcjeqJEARZrkQ5nuk7Sc+AbMWgnRrIanpvLmzH8ktAvMFFp6OmEyvpuKDnPyLujj3sgBzUL/W10/XFK0BWQotmsoEp4ImDWbo3uTDtjuaLi9lB21lRm6uvrIQEz5M/ds9+2dxriN1V/SUZnqzAs3jnxthfDhd54g/1Y41lyzqXDY2knrkiFcfQrdsnSk5k8S4+jXEbSMWcvOzbwDd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 350810f7-9800-4a29-73fa-08d76d116900
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 16:56:24.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UmezCUSG1SkfbO50vl/EFduSdmkcIOyfvdvH4UAI8YZyzG7nzhfp2xdekMhQNRkDYUUdc1fzDqG3qPNwNia0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2846
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_05:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jglauber@marvell.com>

Remove my maintainer entries for ThunderX drivers as I'm moving on
and won't have access to ThunderX hardware anymore and add Robert.
Also remove the obsolete addresses of David Daney and Steven Hill.

Add an entry to .mailmap for my various email addresses.

Cc: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
Cc: soc@kernel.org
Signed-off-by: Jan Glauber <jglauber@marvell.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 MAINTAINERS | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb19fad370d7..2bef41729946 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3705,8 +3705,7 @@ S:	Maintained
 F:	drivers/net/wireless/ath/carl9170/
=20
 CAVIUM I2C DRIVER
-M:	Jan Glauber <jglauber@cavium.com>
-M:	David Daney <david.daney@cavium.com>
+M:	Robert Richter <rrichter@marvell.com>
 W:	http://www.cavium.com
 S:	Supported
 F:	drivers/i2c/busses/i2c-octeon*
@@ -3722,9 +3721,7 @@ S:	Supported
 F:	drivers/net/ethernet/cavium/liquidio/
=20
 CAVIUM MMC DRIVER
-M:	Jan Glauber <jglauber@cavium.com>
-M:	David Daney <david.daney@cavium.com>
-M:	Steven J. Hill <Steven.Hill@cavium.com>
+M:	Robert Richter <rrichter@marvell.com>
 W:	http://www.cavium.com
 S:	Supported
 F:	drivers/mmc/host/cavium*
@@ -5834,15 +5831,14 @@ F:	drivers/edac/highbank*
=20
 EDAC-CAVIUM OCTEON
 M:	Ralf Baechle <ralf@linux-mips.org>
-M:	David Daney <david.daney@cavium.com>
+M:	Robert Richter <rrichter@marvell.com>
 L:	linux-edac@vger.kernel.org
 L:	linux-mips@vger.kernel.org
 S:	Supported
 F:	drivers/edac/octeon_edac*
=20
 EDAC-CAVIUM THUNDERX
-M:	David Daney <david.daney@cavium.com>
-M:	Jan Glauber <jglauber@cavium.com>
+M:	Robert Richter <rrichter@marvell.com>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/edac/thunderx_edac*
@@ -12629,7 +12625,7 @@ F:	Documentation/devicetree/bindings/pci/axis,artpe=
c*
 F:	drivers/pci/controller/dwc/*artpec*
=20
 PCIE DRIVER FOR CAVIUM THUNDERX
-M:	David Daney <david.daney@cavium.com>
+M:	Robert Richter <rrichter@marvell.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
@@ -16137,7 +16133,7 @@ S:	Maintained
 F:	drivers/net/thunderbolt.c
=20
 THUNDERX GPIO DRIVER
-M:	David Daney <david.daney@cavium.com>
+M:	Robert Richter <rrichter@marvell.com>
 S:	Maintained
 F:	drivers/gpio/gpio-thunderx.c
=20
@@ -17916,7 +17912,6 @@ F:	drivers/char/xillybus/
=20
 XLP9XX I2C DRIVER
 M:	George Cherian <george.cherian@cavium.com>
-M:	Jan Glauber <jglauber@cavium.com>
 L:	linux-i2c@vger.kernel.org
 W:	http://www.cavium.com
 S:	Supported
--=20
2.20.1

