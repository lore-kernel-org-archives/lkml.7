Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8042064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="vnC/uXzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfG3THe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:07:34 -0400
Received: from mail-eopbgr760137.outbound.protection.outlook.com ([40.107.76.137]:26432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727621AbfG3THe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGy9dJGcdsHFYeB+C+qutr7+mGjLlbCn9uJrHb76vSPtExMfYDFCA4mIBOIW9n37ydGOtsKzSgx/T6mV2bWPwFbOMJ1asaprx0+FAAtcMexLg1k0oBCfC1fPFDvJwcq6/K9p+WHax8UowkWeRFYICxHL6kwuXCByS1mIx9D1gdDNlLGX/SzsRSmWtMF8ZTMnPLzaGzTULz7w8y38YKkblVjg+j33V8wwHsEUqvd2WimunP/RYu2oDIJO/RTQWExKW8QNGfkbqa6ZHO9tfZVTcM195C3wmDPJfGUBWyUVV/a22cT/gO+luEFrIE01g8AmNQqlFKoUPRdIwxuu72ngWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV5yVaYeB83MLQkTP7A2qWvza+XNI4VZb9eS8p0ZUuU=;
 b=DtJQDTdY6cHiFVxvVxqK023Dnegsmyf/asQk/JSmE+fw/wBFclrCX//slZTA+qnLDidyoA5MO95pVlSzGyrBsedpSS/0rZmEmXJ5cCG++/T9QOs5eGlkdMxrzSp/QddJvWqmOgP8mcy6+/YKoYCv9pGQzDRfnAPny2twP0uhd6gXxtEsJnVFdZwXuEeYWuzT2qwf0Wg/8jbeS6xQoFycGP7TvrD+XF+jsLBxtQmbWsJDv8j0J1QHAgdyP0ZjM57TkzgAuRZ1TvKlRGGGc//3rP6DqYN0Hv11WhUVwGxg0H/iUIHZeACVw79JKNaL6U/++n4hLiW/LZy6yZcqQDbmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bayhubtech.com;dmarc=pass action=none
 header.from=bayhubtech.com;dkim=pass header.d=bayhubtech.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV5yVaYeB83MLQkTP7A2qWvza+XNI4VZb9eS8p0ZUuU=;
 b=vnC/uXzqyGJNseTDI7++TA+RZXm77Mn37uF2L+o3LbHXRmppiv7gBuStiGhU3tGnn7fqDOc/lT4dtF0OOI4RXZK9VbI8YzRrTRAfBRBeyw5N8yo3dQcDaWQIpKE2MRnVTE0XdSZJV9FMbaywipimrnZ39gEAYFrFRh5pYVNbwKA=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 19:07:31 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::cc4a:10c6:fcac:d3e0]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::cc4a:10c6:fcac:d3e0%9]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 19:07:31 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V3 1/2] mmc: sdhci: Fix O2 Host data read/write DLL lock phase
 shift issue
Thread-Topic: [PATCH V3 1/2] mmc: sdhci: Fix O2 Host data read/write DLL lock
 phase shift issue
Thread-Index: AQHVRwoJNw6NuC9tc0Wwlz+CI0GUdA==
Date:   Tue, 30 Jul 2019 19:07:30 +0000
Message-ID: <1564513648-16377-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::16) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e22db25-4685-40fb-2b7a-08d715212b9a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB1455;
x-ms-traffictypediagnostic: MWHPR16MB1455:
x-microsoft-antispam-prvs: <MWHPR16MB14557516AFC51ACD01AD46228BDC0@MWHPR16MB1455.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(136003)(39840400004)(346002)(189003)(199004)(66556008)(66476007)(6116002)(71190400001)(71200400001)(186003)(66066001)(99286004)(486006)(386003)(64756008)(6506007)(102836004)(3846002)(107886003)(66946007)(36756003)(5660300002)(6512007)(66446008)(110136005)(52116002)(54906003)(305945005)(53936002)(14454004)(6436002)(8676002)(4326008)(81166006)(2201001)(68736007)(50226002)(26005)(14444005)(2616005)(2906002)(316002)(7736002)(81156014)(256004)(8936002)(508600001)(6486002)(2501003)(476003)(86362001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1455;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6ABV6LX81D4h68vDkdtnZHEcgQSIWydb4SQDtyH0k8lMKEwZ5+qfuW3qVl24jiuXQ0kjuFjLUM0ZNzUpuRCLiB1ulu6OS8XYW+VFu2sJ4wN/Y3JGdvLtyULqjmPqFeMirh+ZAWuHLVlkUHqyfjtfoeuOvMpRPH1S/QQqhzPHHwEfmojFsqAUnwFcD5lXZ0bF+aoJUxcwuJNka5859Y791/fT9pU9x2gd9TaboxiTCt9dXOOpz6YxJr7U+MADdMSReiIP2R6fpq2W4fT61TxIa/bkQDJj4UEoEA0EtnJ9jIykVSDNcuZG2s97ha++U52iamV5qvRW5MvL2w2FV2LrAkD+I2bgM9nh91muQQohnt6vw3oKob6dW1wEIeoI8x5pgIu3DcbimLWh0Bm4STTzeRTzi5Qb2YZIIRFZctl3Xys=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e22db25-4685-40fb-2b7a-08d715212b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 19:07:30.8754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shirley.her@bayhubtech.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
---
change in V3:
 1. add more explanation in dll_recovery and execute_tuning function
 2. move dll_adjust_count to O2_host struct
 3. fix some coding style error
 4. renaming O2_PLL_WDT_CONTROL1 to O2_PLL_DLL_WDT_CONTROL1

change in V2:
 1. use usleep_range instead of udelay
 2. move dll_adjust_count to sdhci-pci-o2micro.com

change in V1:
 1. add error recovery function to relock DLL with correct phase
 2. retunign HS200 after DLL locked
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 9dc4548..186a33d 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -51,7 +51,7 @@
 #define O2_SD_VENDOR_SETTING2	0x1C8
 #define O2_SD_HW_TUNING_DISABLE	BIT(4)
=20
-#define O2_PLL_WDT_CONTROL1	0x1CC
+#define O2_PLL_DLL_WDT_CONTROL1	0x1CC
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
--=20
2.7.4

