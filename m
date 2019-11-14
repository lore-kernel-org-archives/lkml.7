Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7484C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ACB206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="GH2c745B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfKNSYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:24:05 -0500
Received: from mail-eopbgr150135.outbound.protection.outlook.com ([40.107.15.135]:12935
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfKNSYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:24:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K42zpjV0PrRwlXvyGfXvTL1tbao5eb2vk0SlumGKoqtLmSCqSrSsLfQ42B4SeSqO8uInSLcNR/XwG26cIIYA2Vn/wW0nI/JpnFPpEvM+zlFAMZ6ta5b+0RnXGrL2tOUZdIJjnLIFTX95+siMpkYf8lC7h8+EpocAFcPfQ3Wo51I9nV9gm01IbtbYto6ZvLHkio28EdzltgSaHBbx+azWGdf8uUxEyz6vpkYBycahvcn8XZJqcTPSyOV8c0EyNEjJGTJRvEtBxrxk710gVPCQUrLP3QvxhkwqvkxNfNDpi9i/waNmoN20f/EWxKN+a/86s/6TZ5AlA70JmA8EAmfejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcpKYeZD2PyNhIPc3I8qTowkELZ0Ofg2GhOo1DX2x7s=;
 b=jLzsaUK0PPMPSrmAAaK0HsygK89uVIVBcUbcbFik0z206kCCRjr7ziYnUqwTQblA7k3XJzA97KIbKRF1b9l1FrBlKBwFz248pkSEcACD2ebVdlSFwL8K7FoSDUJNDYUNmTuxB/5Y9aC42MHlcwDh5TQISLlVBw52S1WlJD1ZpCk+EMTZJDJ/p7OFX09NWmVIMKQObUTqlXWKGeHQeiiK0oXaHfP1+S2RZytvROxqSf5XBqljfTik8fx6bj8B9aipeugzenzbsu3JS9PojEY4IjasOo8+sD7CX9IMCADE4GbQ0NCjzKZQzLT51qwwFjHaRJ0D45GUnBVGd4JJIHE3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcpKYeZD2PyNhIPc3I8qTowkELZ0Ofg2GhOo1DX2x7s=;
 b=GH2c745B6WbOQ/TMLvhAm3qE7HiShN7In0oEv4iFI4XongCsumQxv7dMTDoRXoyvs7xhxnFo+kH5Mn06ZLdKH9bcMVQOUA3juXUoRa2NBqaJylQyarcRNqbTVO8G4hphENL+2PtgV3wrZST1paIV8PDGKzb40GLFhdMrZKqMhms=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3383.eurprd02.prod.outlook.com (52.133.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 18:23:56 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:23:56 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] habanalabs: prevent read/write from/to the device during
 hard reset
Thread-Topic: [PATCH 4/8] habanalabs: prevent read/write from/to the device
 during hard reset
Thread-Index: AQHVmxita4K3BTtxlkKDNafyiadmvQ==
Date:   Thu, 14 Nov 2019 18:23:56 +0000
Message-ID: <20191114182346.22675-4-oshpigelman@habana.ai>
References: <20191114182346.22675-1-oshpigelman@habana.ai>
In-Reply-To: <20191114182346.22675-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:15::20) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c682d378-6d64-4b34-24c4-08d7692fcf7d
x-ms-traffictypediagnostic: AM6PR0202MB3383:
x-microsoft-antispam-prvs: <AM6PR0202MB33833051474490016CE16797B8710@AM6PR0202MB3383.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(189003)(199004)(71200400001)(6436002)(5640700003)(81166006)(26005)(478600001)(81156014)(186003)(386003)(25786009)(8936002)(14444005)(50226002)(14454004)(256004)(76176011)(6486002)(71190400001)(8676002)(102836004)(2906002)(52116002)(316002)(5660300002)(36756003)(86362001)(4326008)(66556008)(66476007)(66446008)(1361003)(6506007)(64756008)(99286004)(6512007)(7736002)(305945005)(2501003)(66946007)(446003)(1076003)(486006)(2616005)(476003)(6116002)(3846002)(11346002)(2351001)(66066001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3383;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1xhc4XkkuXC3AYANv8rstzKCBiHP6/bf3ch2azQArI2T3fTlflOkLq5Frwl3RF6Z6yfCpleIgUsJf883mvUssPCKWLxzemAfx020Y9aRx3DxxbEHmV5D/RvMO8YbizR0K5LanNQ4Y+5C7eAHV4SM0/kzmSeyFKxplt3s+bQCP/YhSQSj6SBMSPlbW0eZV9RPTVULlSyNt2viShOTP6VpgBXqAbWpm9wCgD+nByNFXB0SvkHQMwvLDTAZQCVHyKSwgHRpRbaK9DNIZC2fY70+1EXqIRTTlDwdkOKMf6hQwcJJyg92AZYrmZabesOERTY35WmHWQnoK6+3uMN//P8h5SKCh/lmO4hbJVtgnY+e4inxxHm1GnQlKCpwEu/aNlgahslXXYnbBvpzXhZ1eQT58n83bj0sNxgl93VzqfLY7P0vWpP8I8q3qpDMdsXbIsG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: c682d378-6d64-4b34-24c4-08d7692fcf7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:23:56.5057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9CcPxV//QGyf5PhzdnFybDpY0QwkUdGr9yLsGGiWMqidr6L7lpYgFBkeETTfLd4GLhueFzZISe5RF3fNQBP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hard reset we should not access the device except of necessary
reset operations because the device might be stuck or unresponsive.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/goya/goya.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 3294a6a92f75..2935e84fe7d8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4870,7 +4870,8 @@ static void goya_mmu_invalidate_cache(struct hl_devic=
e *hdev, bool is_hard,
 	u32 status, timeout_usec;
 	int rc;
=20
-	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU) ||
+		hdev->hard_reset_pending)
 		return;
=20
 	/* no need in L1 only invalidation in Goya */
@@ -4909,7 +4910,8 @@ static void goya_mmu_invalidate_cache_range(struct hl=
_device *hdev,
 	u32 status, timeout_usec, inv_data, pi;
 	int rc;
=20
-	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU) ||
+		hdev->hard_reset_pending)
 		return;
=20
 	/* no need in L1 only invalidation in Goya */
--=20
2.17.1

