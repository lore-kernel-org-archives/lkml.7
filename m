Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A2C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A829B214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oFHiLhAT";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oFHiLhAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbfKGLm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:42:59 -0500
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:57828
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfKGLm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTqYfVkOy0L0imb7lo5uGve4ym8KHPe/DRGzfmKfEdE=;
 b=oFHiLhATuHXJ4pf+VUshob3MZNPVG3vhIy4KqSi/ZBu1FlbDZsQghkAb4pPyUZuI33Ca5lNZlIImh3n7R4zPtSEn6RvHxMl9v2n87lutVWW3P7C++DhdACW3E2YHW5smKjzxwlI7pjBwGcRY33HXwlYqZPrOE1IpdAR8trIpwMw=
Received: from VE1PR08CA0003.eurprd08.prod.outlook.com (2603:10a6:803:104::16)
 by VI1PR0801MB1760.eurprd08.prod.outlook.com (2603:10a6:800:51::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Thu, 7 Nov
 2019 11:42:52 +0000
Received: from DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by VE1PR08CA0003.outlook.office365.com
 (2603:10a6:803:104::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 11:42:52 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT028.mail.protection.outlook.com (10.152.20.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 11:42:52 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Thu, 07 Nov 2019 11:42:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2d09edfc56120d9a
X-CR-MTA-TID: 64aa7808
Received: from cd53f9309253.2 (cr-mta-lb-1.cr-mta-net [104.47.4.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2B815624-B4A2-4DE8-AB01-ED9F2940B646.1;
        Thu, 07 Nov 2019 11:42:46 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cd53f9309253.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 07 Nov 2019 11:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvCv8Qy9nPA2WSlzbRlZse8eeQUNF1PVdkuhUGtWYcgJ1oy1wIlIok9zML5UiDCYIHVQ5FOl8RFiNWwmtf1X3Xts+CGy3dmEf+nmPVZGqzMB9w3p0iKrZHxceuYxkttrP4SzwVmktQWFr6NQ7wvYeR9WHVtZ/xh+0Mv6VdvVXGwweDweejAvjFBe2d88FcyF7bKUfD3yl7twLrkCistMQMrJgA7IoiA4ahcrnLy1+XiPNlbiLT9OcYqh+3+5IEYSX/cN3gJWN/eAxkHXKlKALFMveoJdsAPBrCZr5FKkr2xlLfhOMv5sxvnPsecrOoXoTXJxGE5iSleIIEPFoeo8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTqYfVkOy0L0imb7lo5uGve4ym8KHPe/DRGzfmKfEdE=;
 b=ha5VnTXvDEBXnIx6TKbQLbAPn7ATokpUNRbRZ7MPqRSba4ZEKehi1LXJLhLIyDU/HN8m2dHMcBC/ugKoZK52u2w8hkLqTP/7wqKv/6SEiyOTRmS+MMoiyK2FZXWZmgtO1hPUFNqnb2LuQ1mM08JMtjETof0HQTQPGkFZbTEwyuuOQv0aHFX8xEIT47rqyQaM1dpyCXZ1+Tg0VZU8QQnP47nfsjeI0hJUzQ6gfC0nrBNy+E1KXVeSTx4O98JKHxlq/RqHMqfzslFo4i5cRGjWBMBPpEG9AUD/1LB2fZNR3gogO7ZUPK8Ngjv7T5hRFd08ymFUsx/Ts2329elOIXUajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTqYfVkOy0L0imb7lo5uGve4ym8KHPe/DRGzfmKfEdE=;
 b=oFHiLhATuHXJ4pf+VUshob3MZNPVG3vhIy4KqSi/ZBu1FlbDZsQghkAb4pPyUZuI33Ca5lNZlIImh3n7R4zPtSEn6RvHxMl9v2n87lutVWW3P7C++DhdACW3E2YHW5smKjzxwlI7pjBwGcRY33HXwlYqZPrOE1IpdAR8trIpwMw=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3567.eurprd08.prod.outlook.com (20.177.58.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 11:42:44 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 11:42:44 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] drm/komeda: add rate limiting disable to err_verbosity
Thread-Topic: [PATCH v2 5/5] drm/komeda: add rate limiting disable to
 err_verbosity
Thread-Index: AQHVlWB4xMPbXmf91UG5tobxnmp6wA==
Date:   Thu, 7 Nov 2019 11:42:44 +0000
Message-ID: <20191107114155.54307-6-mihail.atanassov@arm.com>
References: <20191107114155.54307-1-mihail.atanassov@arm.com>
In-Reply-To: <20191107114155.54307-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 748dfddd-8470-4d78-0743-08d763779f6a
X-MS-TrafficTypeDiagnostic: VI1PR08MB3567:|VI1PR08MB3567:|VI1PR0801MB1760:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB176056878B736CA37183D5CD8F780@VI1PR0801MB1760.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2887;OLM:2887;
x-forefront-prvs: 0214EB3F68
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(199004)(189003)(3846002)(64756008)(6436002)(71200400001)(66446008)(66556008)(66476007)(6486002)(71190400001)(86362001)(1076003)(81156014)(99286004)(6116002)(2351001)(66946007)(256004)(14444005)(2501003)(316002)(54906003)(7736002)(66066001)(6506007)(102836004)(44832011)(76176011)(26005)(6916009)(478600001)(52116002)(8676002)(81166006)(8936002)(486006)(11346002)(2616005)(25786009)(476003)(5660300002)(50226002)(5640700003)(2906002)(6512007)(446003)(36756003)(14454004)(4326008)(386003)(186003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3567;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ETSPPIelCJKtFqw8EYNNVz8XweAK8XjOlq7RSPtbGXomf+M+rJ+KdgerpqqeoIz+2JM3ZcMnAuqWD/Y2F1EARyGOt90y8RZTUHKjkOl7mWFYFe2f+ulF15AjBd3rMKa6umH+Up+qWhmQzdPA5q8VN+ZFQp4q15CtEVP4Lcufq4nYDKAKSSeNv3dNTde6f82kiZa9uu/wtm25MdDAbsNeJ26LsdRxA9osbuKzo6lxOOT9d+xEOLWdRGkIPpVWOMyMXbb4fo/G7rWK2iJrMpMwNfUe8Ada3K7FRwuJnhm9eqr18vtJeD/W/tSyKoVGe0kNC4ByKY+wK/XxIr1akZ00oNedibFgydo5TO5t0ek4oOu1zj7T1MFaFcsLMBY5lUqpeu//M22SI8fElb391csWiGYAsxgVkij2G5Y317ga7YKmW3T3Rjgk+rohhwZdpzdo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3567
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(1110001)(339900001)(199004)(189003)(7736002)(5640700003)(305945005)(25786009)(105606002)(356004)(6512007)(126002)(476003)(2616005)(14444005)(11346002)(316002)(446003)(486006)(99286004)(6486002)(54906003)(22756006)(26826003)(478600001)(14454004)(336012)(5660300002)(70206006)(70586007)(50226002)(76176011)(102836004)(2906002)(1076003)(81156014)(2501003)(3846002)(86362001)(81166006)(6506007)(386003)(8676002)(6116002)(8746002)(2351001)(8936002)(23756003)(26005)(4326008)(66066001)(6862004)(76130400001)(50466002)(186003)(47776003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1760;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0fcbfdb2-2375-429f-5d0c-08d763779a7e
NoDisclaimer: True
X-Forefront-PRVS: 0214EB3F68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gzdAhGQJx2KW26j/AAheDx/Jx2VCRy4f9VTF6GUU640eFiTthQrPYixRxkioT84JsZprJeXlnrRHc/Y393TpqYR2xg6+wIcug1lnwauJU/eSU8HufRHsWPTfmokeVlTmQt59sObTlAfXSE/HfEMvvVAMrAEPNRS/6B9VKRZ7+ZS7SMBjK1NoixrclGCYF0ZJZPZWGfvleCdJOgvm1ESsDM/eis05HEKTtDrPQlAEEvyq86N4lAwzsyWqk06eAmkvuAFD+PCouVQAgcnGjNYdyb6yznydyK9hIXxomfszQ+yHztVVQzbb5k9IumuPNcLERE1Ya4AwJK72c/8Tl6GJCb7CaQ6QKKhUfyQMh3AnIhM/mSjxqisLb9ots+Vhk16of0jpsyMHioyWUGINZuJELBF+zw14YyZKHCLxc8fl0VM6KQukIFYm4Rkn3UTlIKZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 11:42:52.2338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 748dfddd-8470-4d78-0743-08d763779f6a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to get multiple events in a single frame/flip, so add an
option to print them all.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---

 v2: Clean up continuation line warning from checkpatch.

 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 2 ++
 drivers/gpu/drm/arm/display/komeda/komeda_event.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index d9fc9c48859a..15f52e304c08 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -224,6 +224,8 @@ struct komeda_dev {
 #define KOMEDA_DEV_PRINT_INFO_EVENTS BIT(2)
 	/* Dump DRM state on an error or warning event. */
 #define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
+	/* Disable rate limiting of event prints (normally one per commit) */
+#define KOMEDA_DEV_PRINT_DISABLE_RATELIMIT BIT(12)
 };
=20
 static inline bool
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_event.c
index 7fd624761a2b..bf269683f811 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -119,7 +119,7 @@ void komeda_print_events(struct komeda_events *evts, st=
ruct drm_device *dev)
 	/* reduce the same msg print, only print the first evt for one frame */
 	if (evts->global || is_new_frame(evts))
 		en_print =3D true;
-	if (!en_print)
+	if (!(err_verbosity & KOMEDA_DEV_PRINT_DISABLE_RATELIMIT) && !en_print)
 		return;
=20
 	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
--=20
2.23.0

