Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A29CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915802190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfJTRWf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 13:22:35 -0400
Received: from mail-oln040092071064.outbound.protection.outlook.com ([40.92.71.64]:7910
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbfJTRWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:22:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLiTFYVN9kwUqrWJfdX32ZNWYFiU09DICWBUrpdDAS1bwJiMXXjOpZjcKmUHiiWhNWrcixAnufPBkVtvaZtwovHisSiWpSroDv2kaz3Ny0yjHn2sZh6uTgGI4xNNAHyKTPumcctJS2HfYeyfwFYWYer6eWjOkZyRIThOPRQ6KxLqih/EYAGrTdmVwR8xLotL1AM4spkni2KJgjEy8i4mB21SAzqidjg4AUrLF1Dt73HpjOaT3dFuehc4BxcsUWZVpKxqQ3N1HwJxJgDLv2DdMYikaTKyvTY0FnNQOumYHA8lU6ZWNFTC7Qapw7z8yDDZ2Nc/HsenPYXr7q1V7R+CiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmnm8Nw7F5FpwL4E/v80xnFG7xQV2oCDi3cYIGiH3l8=;
 b=IViSyzAlcWUar6TbIz25Pk8JWJY0SP/htCqsk3yWcLDarYX+sPtGCnBu6m8+wOiNzLJx89+dPGLavY05ePrjfh9CSyI0bQGN5PKbXCnyq0smAxrRurdO1yQpoaEq2mcD1+ritao0ZgHjaXoh3wcOaqdv/ChixAjMPVD1Jr3tVossL3L9pPJPuLaPr2CRUFkWHHtuwe+HOtWUg1Ov29ScOX3vxMq+VUNp7WAFjSET7qTd4crzyKVvAskeE65UPsLKL+tftEdpy26CTsK1EsAzq1LcL6xQ8gOHjdJMyWgJ/JzkVs94YWlIuF9S1i8yPGK4wRL2mD/rdBf7ONTRY6tDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (10.152.20.53) by DB5EUR03HT204.eop-EUR03.prod.protection.outlook.com
 (10.152.21.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15; Sun, 20 Oct
 2019 17:22:30 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com (10.152.20.54) by
 DB5EUR03FT030.mail.protection.outlook.com (10.152.20.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Sun, 20 Oct 2019 17:22:30 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247]) by AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247%6]) with mapi id 15.20.2347.028; Sun, 20 Oct 2019
 17:22:30 +0000
From:   Anatol Belski <weltling@outlook.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     "trivial@kernel.org" <trivial@kernel.org>
Subject: [PATCH] include/linux/byteorder/generic.h: fix signed/unsigned
 warnings
Thread-Topic: [PATCH] include/linux/byteorder/generic.h: fix signed/unsigned
 warnings
Thread-Index: AQHVh2rzQudqiWaARkuhjP20crUqsA==
Date:   Sun, 20 Oct 2019 17:22:30 +0000
Message-ID: <AM0PR0502MB3668B1A0EC328690DA25E9C6BA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: AM3PR03CA0054.eurprd03.prod.outlook.com
 (2603:10a6:207:5::12) To AM0PR0502MB3668.eurprd05.prod.outlook.com
 (2603:10a6:208:19::11)
x-incomingtopheadermarker: OriginalChecksum:4AD9A2D64179B1FC26103107CEE42BB475C3FDF8CF5FC05E64837A5A4E1E6ED4;UpperCasedChecksum:548BF0AFF53993A14385870947799789786C6933F5FED8B0CA148F17D96BB349;SizeAsReceived:7732;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [BWuIjoFCIraVKXtT4WOWg5iFdM9bo4L3]
x-microsoft-original-message-id: <20191020172159.18175-1-weltling@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: DB5EUR03HT204:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zPUSuJWLSert7Fh0ugTq8YgUW/14HSp8S1cvxBHCi903uURbb2Cc4xkXJ8eym/FYZv/vK8jilZcsrUPq2G6SIlFmBVwNdZk1pQ4XQzFEkJflCTSN7uWcmXTNDT0t/RAfbKODDofhzdfgV1AN7cFScNrHPdGI+cV2ivC58s1jqw7s/rSbP9ewWCAHDw1rndHs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab3d4af-0e5c-4c26-ff71-08d7558215d0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2019 17:22:30.1989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anatol Belski <anbelski@microsoft.com>

Signed-off-by: Anatol Belski <anbelski@microsoft.com>
---
 include/linux/byteorder/generic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index 4b13e0a3e15b..c9a4c96c9943 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -190,7 +190,7 @@ static inline void be64_add_cpu(__be64 *var, u64 val)
 
 static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++)
 		dst[i] = cpu_to_be32(src[i]);
@@ -198,7 +198,7 @@ static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
 
 static inline void be32_to_cpu_array(u32 *dst, const __be32 *src, size_t len)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++)
 		dst[i] = be32_to_cpu(src[i]);
-- 
2.20.1

