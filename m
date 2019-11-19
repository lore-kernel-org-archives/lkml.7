Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330A8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014DA2240E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NjiC+lBE";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="uWjv6YNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfKSTGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:06:02 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61168 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727117AbfKSTGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:06:00 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJJ5bPN026680;
        Tue, 19 Nov 2019 11:05:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=0AU9cEXKKMR5WcQ4Y2Rv6hi1hZDohvrLXr9wtR3RYpk=;
 b=NjiC+lBEtZUwPzfkVHEXZJWl4Ke6CFGnhjNSPsSLE/cBE2PjFfiBC5I3/rkUFaEXRC2O
 hhYFY95vwGUQQMOycJmKJnKS7DAOTrrHJvL1KnmZb6sw+gv/poXT5HirS2SrPejB9XLZ
 bezapt/ZmRa2IpPrKU1ePXHlLAX+JCi0Won3DOB+Dv0OrWT1O7mBNpAQ9e1rYVeN9SrR
 vClI6SZpNNGkCJRpfuerJg/j1JP6dt+SQW6hJ7QsLWF9yzn8SdghDjbzG3nbnUIz44sJ
 bQtO2NY+GmVQn/XWjBI16mk6Y9gWQkU6NbWAiw66bwpHan9A7Qa8E7QpjJv3d+FDJHgG pg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wc82vkfr9-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 11:05:51 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 19 Nov
 2019 11:05:02 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Nov 2019 11:05:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9A9cxvK7qolrHxwfqFbwCrrT3KheoNBrCy7NjG7lOG2JM+qq3lwcKUezcoklal9zt5Jhw94qlE5Ux7uYATpll1UREBCt1oa4D2V8N4grJjmwQ9ra3HqjtFkIPHestjks0vAjPdjKk0qtf0rC7iSlFB9vDL1s4KL9ISgqSQCOofa61tcv83hQRUDHyYyGAV49wizemciiK/jiit6uVkQRgGpZ1X7BHN7Dwji/Ou3bqfIlHXA13l5sBmxvzJqK7P03us6M37umyEotb/D0KDoZYe3sbV5xBq4kW2HZAE6C7MZrrSH7SW8RYapEOKvATTfSm/F6b5pGtyMKwBeBr8Q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AU9cEXKKMR5WcQ4Y2Rv6hi1hZDohvrLXr9wtR3RYpk=;
 b=QGBWLq/054yP/93Zc3DDPWTkxizQ9pAY1SFkNIraBksDa9tBCK2tNjcChCH0ElRkZyjUekagHYuwazsKv32zI00/FfMKDUGsOCpC+lbOiwXQwHPBbPjaPTW0jt557aBy01GNwzFq0TaDT+MOp5PN8a02skSWwY3dzRkVJyxqcuK8RYsob+ErwP/OT4dBNE5ZnWpi1FcfAiDzjuLRHhb1ubtcySdIxh6AgjoPV9POJeLSIdvhfhVCzhKLd8BP4iXol8OCcIm3ppGVZGeGHeCIr/KxEww8mXw05aBRzOLPs1FTNiBKDjPeI3J+EBnHp3g9ZVWy0cVJtrPU4dxZQ9QcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AU9cEXKKMR5WcQ4Y2Rv6hi1hZDohvrLXr9wtR3RYpk=;
 b=uWjv6YNYQY9bVw2iLgUoTHEFi8I1+DtW2mstpIASUJTUBMJWLucCfXipK2nDBHo8vAc0IuMbMjPVtRaJSlAwqKcClh4EuzjAi1zfRGeH/NZPP+axZsn3/S4PTa2/c+acHaTbepQ/+FUlmf69ikKPVG+b8Ew7gKALp6f68e2CMcQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2685.namprd18.prod.outlook.com (20.179.82.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 19:05:01 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 19:05:01 +0000
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
Subject: [PATCH v2 2/2] MAINTAINERS: Switch to Marvell addresses
Thread-Topic: [PATCH v2 2/2] MAINTAINERS: Switch to Marvell addresses
Thread-Index: AQHVnww+xorYfyhIz0+qcdanWvKejA==
Date:   Tue, 19 Nov 2019 19:05:01 +0000
Message-ID: <20191119190436.17875-3-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 3c25f6f4-af55-48cb-1cc8-08d76d2360ee
x-ms-traffictypediagnostic: MN2PR18MB2685:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2685CAE7617B4B53735E56A1D94C0@MN2PR18MB2685.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(189003)(199004)(256004)(54906003)(110136005)(316002)(2906002)(66476007)(3846002)(6116002)(4326008)(1076003)(64756008)(66446008)(14454004)(66946007)(5660300002)(99286004)(66066001)(478600001)(386003)(6506007)(86362001)(7736002)(305945005)(26005)(476003)(102836004)(186003)(446003)(486006)(2616005)(11346002)(66556008)(25786009)(36756003)(6512007)(6436002)(6306002)(50226002)(76176011)(8936002)(81166006)(81156014)(8676002)(52116002)(6486002)(71190400001)(71200400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2685;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PiqA0d7V+P1cdP0HOhp+z1QqskC/Zmn8j0Tyvyhxqdx2R+p7Qoa/Jvx3XbNziN/k290X8s8r9cCZjAMZJkySdBzRVgWPPe7CwCMFxBYdi6V2QLAqq26ash+4Xi7xkCkM+QpUM86HBGDhYAltTe2x9x3UPNTeygmEFYv+Ec3TZUFrtHBHLPJBGjFtuvY6bI1hxOMpXOtjQLE10U58Ng4Yg1QopgKSmqZ1CLoUP9TS6qdDBCrR6hwaOz9fHMpbPdQYCfuBlgDNMCL5trYzAStRlQzNPyRQ0oviM3pJiNSziA90Um6oAhetZUR5ZB9AITfTotNkLbx0PzF/HcsAleRnghdsD1+6FHgF3rpqQOJNUeyT2M31DSum04p4+1/dybho6tYtVmQaq5WtLcVUgVKqrNQ1QInqp0lS8XOZNKIZ74kbA/2MeSd6IOS41Nolc/SkSF4naeAlLzEU9+tW1M2EB353OoxswGR/vodYqrXU64c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c25f6f4-af55-48cb-1cc8-08d76d2360ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 19:05:01.5394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XF5axD6VPBwtuhKGNXGWNUAHajM0ayQ2ZP4LSPqUCz+TNdaUMEGwofSB26maTVqgZP8rCRwCyulE4yTGOwjoFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2685
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch all addresses from @cavium.com to @marvell.com.

On that occasion, switch also to my Marvell address for all my
Cavium/Marvell entries.

Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: George Cherian <gcherian@marvell.com>
Cc: soc@kernel.org
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 MAINTAINERS | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2bef41729946..ef169130d925 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1547,8 +1547,8 @@ S:	Maintained
 F:	arch/arm/mach-cns3xxx/
=20
 ARM/CAVIUM THUNDER NETWORK DRIVER
-M:	Sunil Goutham <sgoutham@cavium.com>
-M:	Robert Richter <rric@kernel.org>
+M:	Sunil Goutham <sgoutham@marvell.com>
+M:	Robert Richter <rrichter@marvell.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/net/ethernet/cavium/thunder/
@@ -3706,7 +3706,7 @@ F:	drivers/net/wireless/ath/carl9170/
=20
 CAVIUM I2C DRIVER
 M:	Robert Richter <rrichter@marvell.com>
-W:	http://www.cavium.com
+W:	http://www.marvell.com
 S:	Supported
 F:	drivers/i2c/busses/i2c-octeon*
 F:	drivers/i2c/busses/i2c-thunderx*
@@ -3716,25 +3716,25 @@ M:	Derek Chickles <dchickles@marvell.com>
 M:	Satanand Burla <sburla@marvell.com>
 M:	Felix Manlunas <fmanlunas@marvell.com>
 L:	netdev@vger.kernel.org
-W:	http://www.cavium.com
+W:	http://www.marvell.com
 S:	Supported
 F:	drivers/net/ethernet/cavium/liquidio/
=20
 CAVIUM MMC DRIVER
 M:	Robert Richter <rrichter@marvell.com>
-W:	http://www.cavium.com
+W:	http://www.marvell.com
 S:	Supported
 F:	drivers/mmc/host/cavium*
=20
 CAVIUM OCTEON-TX CRYPTO DRIVER
-M:	George Cherian <george.cherian@cavium.com>
+M:	George Cherian <gcherian@marvell.com>
 L:	linux-crypto@vger.kernel.org
-W:	http://www.cavium.com
+W:	http://www.marvell.com
 S:	Supported
 F:	drivers/crypto/cavium/cpt/
=20
 CAVIUM THUNDERX2 ARM64 SOC
-M:	Robert Richter <rrichter@cavium.com>
+M:	Robert Richter <rrichter@marvell.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/cavium/thunder2-99xx*
@@ -17911,9 +17911,9 @@ S:	Supported
 F:	drivers/char/xillybus/
=20
 XLP9XX I2C DRIVER
-M:	George Cherian <george.cherian@cavium.com>
+M:	George Cherian <gcherian@marvell.com>
 L:	linux-i2c@vger.kernel.org
-W:	http://www.cavium.com
+W:	http://www.marvell.com
 S:	Supported
 F:	Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
 F:	drivers/i2c/busses/i2c-xlp9xx.c
--=20
2.20.1

