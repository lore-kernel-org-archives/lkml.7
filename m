Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B409C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACEB2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nBYnjbHQ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nBYnjbHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403782AbfITPNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:13:25 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:24290
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387614AbfITPNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OYJOJuPXA6yB6I/WI2dRcfUzMgHWMkgvuo1vjf6P8g=;
 b=nBYnjbHQ1TZO0qkVsQlWxHusxKBd82ChbmJwMHdexItuVj8sssmppgG1hl50+VxV/An7qn9cpcUTqX5XLxT5ufISdhPhnMXM947pLyrXPJEByjMH4orrdDY8F96gxa0sGsymA5M+PUQ5UQ0/wlsz80remcpxyabBlWlyPL547Zo=
Received: from VI1PR08CA0227.eurprd08.prod.outlook.com (2603:10a6:802:15::36)
 by AM0PR08MB4564.eurprd08.prod.outlook.com (2603:10a6:208:12f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Fri, 20 Sep
 2019 15:13:19 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR08CA0227.outlook.office365.com
 (2603:10a6:802:15::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23 via Frontend
 Transport; Fri, 20 Sep 2019 15:13:19 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Fri, 20 Sep 2019 15:13:18 +0000
Received: ("Tessian outbound 55d20e99e8e2:v31"); Fri, 20 Sep 2019 15:13:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0cde9029c192f773
X-CR-MTA-TID: 64aa7808
Received: from 39f800606a31.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1A7B99B7-D9A7-40FC-B7A0-D593564F94C9.1;
        Fri, 20 Sep 2019 15:13:10 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 39f800606a31.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 20 Sep 2019 15:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrNo9lENFewbZKtyUyLVJp+DFeA44nNNqvT89clT55H18bnKBlFrqiBVjw3XBZ0m+QIZQxKtmE9DjRnIl4mhg/BkMt1dVu0Jo9R2ce7NROx8NFWecEPSiEAnMbh10bXf/g/IkQtGAbH557Ob/3jCvVr4ud/pZXpjEbc3bH5uBOWBBxYGhP12FBjVix7nALq/l83O9JuqJyvGWuS8BEXtALDQKfBHaJlZ8o5BYKasDY2skF/X+gwWYXbfV3JkoxjBf3bff6jc1czfzgpfAfcBKoPU8Asuo+pMzrTgfxg9berVuZWfDUz9ir6EAQROHP4i9FK/iXs63ikg47Q7HNKM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OYJOJuPXA6yB6I/WI2dRcfUzMgHWMkgvuo1vjf6P8g=;
 b=i9Qiya58VbjaOxIz+cqB5Uss4QhHy3bA81XntiqKgw2gfw9da5rFgUN9jEoag8gpYgmBZRKRux6Nhnc07IUc9Hz9vx3PO3QEWo8Bbx4a92f1atbuBNOm6sNvgGP/2+iCz+AzMPep3H5HNXdUJcf+QllwTE0o4Ankj1IC7OtpcZqYYvEjXV7FR1C0VAQemV1HhhQqOlgq3eFnmMSHLsRmGdXqMHD4sYLq3kgCNCryqirZolIEq+LxahLb0rh4a9dSTNxsx6Xg+TmJ1F/h6MpzcNSG1H+ucztoxsAAPy/L9fqE7ZiBQyuYLhq7DZBlqKnB5fZQoXqmN7X8COft/CwVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OYJOJuPXA6yB6I/WI2dRcfUzMgHWMkgvuo1vjf6P8g=;
 b=nBYnjbHQ1TZO0qkVsQlWxHusxKBd82ChbmJwMHdexItuVj8sssmppgG1hl50+VxV/An7qn9cpcUTqX5XLxT5ufISdhPhnMXM947pLyrXPJEByjMH4orrdDY8F96gxa0sGsymA5M+PUQ5UQ0/wlsz80remcpxyabBlWlyPL547Zo=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3486.eurprd08.prod.outlook.com (20.177.59.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 15:13:08 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f%7]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019
 15:13:08 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/komeda: Use IRQ_RETVAL shorthand in d71_irq_handler
Thread-Topic: [PATCH] drm/komeda: Use IRQ_RETVAL shorthand in d71_irq_handler
Thread-Index: AQHVb8XpefZcvGvZNkuWrwlyThjxiA==
Date:   Fri, 20 Sep 2019 15:13:08 +0000
Message-ID: <20190920151247.25128-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P123CA0043.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::31)
 To VI1PR08MB4078.eurprd08.prod.outlook.com (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 03c4fa0a-a7fe-47e3-7d7e-08d73ddd119f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3486;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3486:|VI1PR08MB3486:|AM0PR08MB4564:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB45645E36C9990023A78BC07C8F880@AM0PR08MB4564.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3383;OLM:3383;
x-forefront-prvs: 0166B75B74
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(189003)(478600001)(71200400001)(66066001)(476003)(256004)(486006)(25786009)(2616005)(305945005)(7736002)(5640700003)(6486002)(14444005)(36756003)(6512007)(6436002)(6916009)(71190400001)(14454004)(8676002)(81156014)(2906002)(4326008)(8936002)(2351001)(44832011)(81166006)(50226002)(4744005)(2501003)(86362001)(99286004)(316002)(6116002)(66476007)(3846002)(5660300002)(52116002)(386003)(1076003)(66446008)(102836004)(186003)(66946007)(64756008)(66556008)(54906003)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3486;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: hCQsvnu/medACvQiMwB60m5pCNXda8usqpgYu5l89Z5okjxTU2TQ4JOjBAUMq2cGqpA/XMXAE3fznJyhYacdMw3BfM2aBLzYEsjBwy+KbgVTewGXVQUzcoyhU6AAwchp4IQ45rtjicRMN1nW3B8iCK0fWOOo6QGsxyuzDlR+7bVBXGttexc1pHmcaz0qKS/lug8VX4teFbl4L6pss6dgkedoWa43IZ6mqfOgIyylnpjzGuvpAAKQJcghBH3yWbDNFtvzAeE2qoqWX9K1SUXeMi35pguLe5uU9F67YVMx4WqXC03MugkgcSMbNzt1S59ZocNa6Wg1Qs44tTs32+4H/1iENGp6pXaBpz6tn3FhsWi3UdRlIUcvdLRTKZJASDctU2noSeD18ffk9czPxrXZcAaFItT1+pcnndrQEXvgAKs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3486
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(1110001)(339900001)(189003)(199004)(5640700003)(26826003)(86362001)(66066001)(22756006)(2501003)(336012)(99286004)(478600001)(14454004)(186003)(54906003)(5660300002)(6862004)(356004)(1076003)(14444005)(36756003)(316002)(6116002)(3846002)(4744005)(50466002)(6512007)(2351001)(70206006)(8936002)(76130400001)(4326008)(8676002)(47776003)(70586007)(81156014)(81166006)(25786009)(2906002)(386003)(476003)(6506007)(102836004)(8746002)(26005)(7736002)(6486002)(50226002)(2616005)(126002)(486006)(23756003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4564;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d390d60-e8ff-4185-611f-08d73ddd0b68
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB4564;
NoDisclaimer: True
X-Forefront-PRVS: 0166B75B74
X-Microsoft-Antispam-Message-Info: JZ6ds8DARi9M0JMkB/H774nNjNm8nbmLT7JSUaUQP8iBccfkbnvG174powywGhy7g5Sl3T1R/S7xehxQdhnh8MKAMqpe559Y7rOra4FwK3M6kdwSy8zCvBxf9F9vQ9kvUIbnFR9QnVsaCzOYkcXTz4nIDz7CkVUpzpIu6z9YD0wLfSH6zIJnJ18zAnH2/j9i10ThW8FnM4K1M6oem+s2n6DluIkEw7Xso7E9VkwAXqEq9hvHHrVNsOJUeMruAl5PpnsAyghbP8d8KeiA3PjSuIlsqTgGuuJwWcVp6dt8jPL5Y2PbO8SNVlyXUuz9dq/NI9k3ldRcOTyv4R748FzVdVT1rctQNpd9T8i1xWBEHtj0FaTX+ctAKNRBrt7I/8O8VJCKu4vFSe6kjRYwwC0FkQ5Dys3jhC0fo178r+8WotU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 15:13:18.8445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c4fa0a-a7fe-47e3-7d7e-08d73ddd119f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No change in behaviour; IRQ_RETVAL is about twice as popular as
manually writing out the ternary.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index d567ab7ed314..1b42095969e7 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -195,7 +195,7 @@ d71_irq_handler(struct komeda_dev *mdev, struct komeda_=
events *evts)
 	if (gcu_status & GLB_IRQ_STATUS_PIPE1)
 		evts->pipes[1] |=3D get_pipeline_event(d71->pipes[1], gcu_status);
=20
-	return gcu_status ? IRQ_HANDLED : IRQ_NONE;
+	return IRQ_RETVAL(gcu_status);
 }
=20
 #define ENABLED_GCU_IRQS	(GCU_IRQ_CVAL0 | GCU_IRQ_CVAL1 | \
--=20
2.23.0

