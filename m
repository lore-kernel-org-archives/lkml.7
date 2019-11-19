Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D397C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD3222432
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UuOnTZnt";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="pqNTBjX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfKSTFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:05:55 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60042 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbfKSTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:05:55 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJJ5bP7026680;
        Tue, 19 Nov 2019 11:05:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=W9RHkD4QbEj0ogtlDLKSDCYtXQaAGWJg1eHFHRUnLHI=;
 b=UuOnTZntNMfOzQ7PD+qtgQZ2XfDEvn3qUwLIgJO8g7GK7uTKFVm3poQOOianm9CuqjKi
 x2oc7OWRMeQMU00/DSPZj5PNDmtxxl5rriPFjE/enIw6KhuOpkFcnK2AYkx6ja9jt3rh
 ETdzxDY46KLsbD8r4IiBJjSFsyfIzzZdQ5yVzuSaJWTZaci9fp7pi6DzBcHtVE/LxeNa
 RCSsLeMkQM2UfqmGN1eExSyCmVszS0cN79Za8YW+TLdc2sQnyhOU2XcGg90+Mt7a0bUT
 RT6E7viW7cgggy2K/1jgfpV64+73VXDQdWdgXYIDiV6ftJcc9a4Lmcn1SOngBG4DrDHo GQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wc82vkfr9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 11:05:43 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 19 Nov
 2019 11:05:00 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Nov 2019 11:05:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aud+tGRkYTP0OZzjvm6iwahlj5BXYc5DeuPlJpW/OBY43x9z0Lfgutf/eX4Wc2RLmOMjcFk92fdFAGe9rIFcE+aJ8TpiSZJh6VupIeQzs+lHWGvk66IsiSXlQmDaWEVpRW3mIUgsQhlDgJbQRcLxI4XVdtQ2VAL+HgO845MqAC2tTecSu/fdAdJHLTrUW31vnzja+eSj0+UlqMV8r8zVEYs3KCuao0V57LpVHv5PNk/ryho+/D9NFjY4v9InzTcIsAlrzLTpAEvLL34LzUq6gtiW39hON6sCoe3fLf4xFVrmIhjqFO06gK9a7qg9M2fkrLeX3dOb5EF3oUmCXE2Wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9RHkD4QbEj0ogtlDLKSDCYtXQaAGWJg1eHFHRUnLHI=;
 b=nrIE9Iu+1/jzHEYD15IoSZO3sfYYbMdHXQEMknyoRaE5IENQ78Fv+K2terwpis8L0gGM5cnfV2yw2dBHTud3ucVVC3v/9AkzS68ReBD/54Sqxv+jOkuKE0DGYwYfuSRCvm9Xrqx1BG8X0KsN5M4OeMpE1ryKD+4KF/qdMKMOnvUz6QOEzzn2xd90VcusZCnWcbEELzgCMs5xxZ/P+bWm2MUdCQDAS/IgTEpJ5OT+nehCTW+jtvskF8g+Ju6gM3syJ+xsXC4Dc9rT9hgqqZd0NUm3kXl3dA0ifXRs2U1vzHKHWrEOKdHhMAttsIbJmlEB9Zf3OofiHVTHrHJalT+xmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9RHkD4QbEj0ogtlDLKSDCYtXQaAGWJg1eHFHRUnLHI=;
 b=pqNTBjX4p15Euj44GLXJzNuOe73lW60UQpV+8VUJAW34E9JG6xyvVkxMOUP9gU9II/Jl466k75VnnDTGLDx+V4pUHYBDgnR6Oyw89WHSRy7iS5aWA9XUZbAZKPj4nCeCTHBQuJF9TujIElJuJ7sQu1vGztj8mhgsT8yBGS9Aovo=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2685.namprd18.prod.outlook.com (20.179.82.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 19:04:59 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 19:04:59 +0000
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
Subject: [PATCH v2 1/2] MAINTAINERS: update Cavium ThunderX drivers
Thread-Topic: [PATCH v2 1/2] MAINTAINERS: update Cavium ThunderX drivers
Thread-Index: AQHVnww9QMjryL69X0iHf/Sj40DoRw==
Date:   Tue, 19 Nov 2019 19:04:59 +0000
Message-ID: <20191119190436.17875-2-rrichter@marvell.com>
References: <20191119190436.17875-1-rrichter@marvell.com>
In-Reply-To: <20191119190436.17875-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0044.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::12) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1146eea3-981a-4865-10d8-08d76d235f6b
x-ms-traffictypediagnostic: MN2PR18MB2685:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB268593EE0C6736C01ACDB4FFD94C0@MN2PR18MB2685.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(189003)(199004)(14444005)(256004)(54906003)(110136005)(316002)(2906002)(66476007)(3846002)(6116002)(4326008)(1076003)(64756008)(66446008)(14454004)(66946007)(5660300002)(99286004)(66066001)(478600001)(386003)(6506007)(86362001)(7736002)(305945005)(26005)(476003)(102836004)(186003)(446003)(486006)(2616005)(11346002)(66556008)(25786009)(36756003)(6512007)(6436002)(6306002)(50226002)(76176011)(8936002)(81166006)(81156014)(8676002)(52116002)(6486002)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2685;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXP1Ct5Vm3AR1/N2erToYHAXUITQlfQcLIpl5FRDufuZpvYHNTMdt5lS6bmjzIM0q4uEQhQgGbgtiJ+/miW1FhoH11uXk12f4zSGqQ+XpNSYRhFaqbIuLu+tQ6wGb4y5a/gR3eUBDRzQp4rNrLF03Pam5jLih8pPMPKWok4TPocLBwC2Bea9DK+2CNlPtcnChI2q1pXjdpe0bXG07dttul/AAT/MXHJuqsnGDYOTfWccbSd8H0sjSa/VnyEymHWO0WN7gmHqU5Jsj27ht7XKd5P/ucFjvYuY4r5ReXtv8cN2mui1O9nXMO8s9pIZcpnGDecnuh5+gzXELySw0QctNzzl7zqPTkQ7yNL94NxsFJkuiaBfbuhyGnjjLGjIeOUBumwT7BxQPpKZpDMfv6PaMePh+GyB9q/LdS0uICFKIiytlCkvYpxTISmJaVhi8MBgZwRpHmICT9yjpqGyOAoIbZTggrEo5ZNl/lXEZSKI2XI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1146eea3-981a-4865-10d8-08d76d235f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 19:04:59.0848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3fjqeqZMNavYwnEUAToRIoYYVKDX9icYyC0Qj5VaN6QWv7VVxx9yDU7TMiP/yVoJ3aXpdLDeROqHc9K2i1eww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2685
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
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
 .mailmap    |  3 +++
 MAINTAINERS | 17 ++++++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/.mailmap b/.mailmap
index fd6219293057..f5a8246e36d6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -104,6 +104,9 @@ James E Wilson <wilson@specifix.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 James Hogan <jhogan@kernel.org> <james@albanarts.com>
 James Ketrenos <jketreno@io.(none)>
+Jan Glauber <jan.glauber@gmail.com> <jang@de.ibm.com>
+Jan Glauber <jan.glauber@gmail.com> <jang@linux.vnet.ibm.com>
+Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
 Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
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

