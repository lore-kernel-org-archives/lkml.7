Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B99C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD4920820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AHecwFxj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AHecwFxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439240AbfIWKOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:14:20 -0400
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:3097
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406278AbfIWKOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo9XvHS0OLKJefPvnTrivtFQ7Xk1F+bXmjZCpLiLxuM=;
 b=AHecwFxjhGbL1Q1AHniLVbkfKQ3XeuA2tQPFaqmcggL6Ujlibda/cahoftmomCOOvLJ9FztfaBt0KvQy+buKGz6LKBc3UNTQDuehXmzxoHdWsE9mDILZiGbYvyUHQWckz6H/Bi2vyxIFRTn5ZnukxMw3ky47Or3J7VqRrgWkfvo=
Received: from VI1PR08CA0181.eurprd08.prod.outlook.com (2603:10a6:800:d2::11)
 by HE1PR08MB2826.eurprd08.prod.outlook.com (2603:10a6:7:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19; Mon, 23 Sep
 2019 10:14:15 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR08CA0181.outlook.office365.com
 (2603:10a6:800:d2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18 via Frontend
 Transport; Mon, 23 Sep 2019 10:14:14 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 10:14:13 +0000
Received: ("Tessian outbound 96594883d423:v31"); Mon, 23 Sep 2019 10:14:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 28f9ddc391ad51a0
X-CR-MTA-TID: 64aa7808
Received: from a6c42b9a4ed7.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1B60AD72-FA0C-40B9-8969-202C1731ED53.1;
        Mon, 23 Sep 2019 10:10:29 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a6c42b9a4ed7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 23 Sep 2019 10:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2sGn3HRZo2qq5GNROI7k2zR+7R8P80Pka6hZtsE7fbm79ai+wA3XMQXHqZrpNm3D77k25UOsWcy1J3TnLogcvI2Xaw9CysAoZT0N71xWlcV0vDp0joHPxWkdXvknsPoG5bPdEf8m0rYxMVVcce9DniC9p/YuqTjK/w4DzX0lRf/kPXcOVGZC5m2sxB+PUBj2kiaBMTDsCxIvKkVgRXB/XWfubMiZVUow/77HkYxldp+eH8wpDv5kgr3H9HlNkULws2oPMdDhgVczsXR9so7FKTrKYxa9lHh8+j/xwMXln0o10IUzt8sJYCwSXgIECFpDxBSs/hxMeLjd4XflRzL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo9XvHS0OLKJefPvnTrivtFQ7Xk1F+bXmjZCpLiLxuM=;
 b=DZGkBDUIEjRwIU/HmcoTkToqJogn2/9iUafbQy+Thr/BrZhDlE1V3ahmM8v2XHI/alT20cxQBelhjPL7XLc4bETCJFLLWpLuIq7IsHgIxb5PThTSObgkseKPhTfuWdE8KCiX1kKtv57m2wAcqdhMw+U29xscQYQba48sYHwMjAGFK9vOguslQz23HNHms1123rmuJPZ3/JewxYMyrR3312gk6rm5wd/zDBDH57uJM1xiOnPi7yH5DXoNHXs6j/PPgxXmZC42f/mJ4UprWS7WcB5Nt+8JEwx3cfmlRyLOCDZfXFaKhXDB1mQWOL15fLS4gantWf98vvrvwZRXFAKgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo9XvHS0OLKJefPvnTrivtFQ7Xk1F+bXmjZCpLiLxuM=;
 b=AHecwFxjhGbL1Q1AHniLVbkfKQ3XeuA2tQPFaqmcggL6Ujlibda/cahoftmomCOOvLJ9FztfaBt0KvQy+buKGz6LKBc3UNTQDuehXmzxoHdWsE9mDILZiGbYvyUHQWckz6H/Bi2vyxIFRTn5ZnukxMw3ky47Or3J7VqRrgWkfvo=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB5503.eurprd08.prod.outlook.com (52.133.246.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 10:10:26 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 10:10:26 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/komeda: Workaround for broken FLIP_COMPLETE timestamps
Thread-Topic: [PATCH v2] drm/komeda: Workaround for broken FLIP_COMPLETE
 timestamps
Thread-Index: AQHVcfceR0CHSFhcZEiwMH6z8RYyLQ==
Date:   Mon, 23 Sep 2019 10:10:26 +0000
Message-ID: <20190923101017.35114-1-mihail.atanassov@arm.com>
References: <20190919132759.18358-1-mihail.atanassov@arm.com>
In-Reply-To: <20190919132759.18358-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: AM0PR05CA0025.eurprd05.prod.outlook.com
 (2603:10a6:208:55::38) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: cb56579e-cab8-40de-886a-08d7400ec87c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB5503;
X-MS-TrafficTypeDiagnostic: VI1PR08MB5503:|VI1PR08MB5503:|HE1PR08MB2826:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB28267EA9882DB6D13B0F510A8F850@HE1PR08MB2826.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(54906003)(50226002)(6512007)(446003)(6306002)(476003)(316002)(66066001)(66556008)(99286004)(71200400001)(8936002)(2616005)(4326008)(71190400001)(11346002)(36756003)(6436002)(26005)(8676002)(486006)(6916009)(102836004)(2351001)(6486002)(76176011)(44832011)(2501003)(52116002)(5640700003)(6506007)(386003)(186003)(81166006)(81156014)(6116002)(3846002)(64756008)(66446008)(86362001)(305945005)(7736002)(66476007)(2906002)(25786009)(5660300002)(66946007)(256004)(14444005)(14454004)(478600001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5503;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: WRIR6Tf9SUBt14lle3mYAIfwKaMdd6oBgFILXQd5gwitn8FOcMP4lIJUJ01b9n+1UiK86YxbvcFzqwfgqaNEntQiSVrw5mGSfPhCm1RvbXxMyEn1n03W669sLXSAbw2IiFud3J+3pxlzo8Ky9qA7lGZxO2fYrIlp7rRUXEV+igtsyYSu2/EAZKa7WWrNLom6JieBBz/sHy3sOTvzl3S8Xup0z8wF5xtMUyi9ab0GBpnDJQFPigEbF06+lB48wOVX+M5st7SHTsly6KeBU58bQnR6gvsrn1xFkopxkhTtWj63lKal754Db1X1ryzQKxFsCXeDTMiS1WFusB8dgNZav0Ec3UuUNPnb9ZNQaUnq3zJ9rpzP4KsEidDewNbSiPjJKiRmotwIzWGO3aKCbz2S/USwIHPw9abVKuhW/0hHxZY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5503
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(2501003)(14444005)(305945005)(7736002)(6862004)(356004)(4326008)(336012)(54906003)(66066001)(23756003)(316002)(70206006)(6306002)(6116002)(70586007)(50466002)(47776003)(86362001)(6512007)(76130400001)(1076003)(50226002)(8936002)(99286004)(5640700003)(25786009)(76176011)(3846002)(26005)(36756003)(386003)(6506007)(81166006)(8676002)(102836004)(81156014)(8746002)(2906002)(11346002)(186003)(446003)(486006)(26826003)(5660300002)(478600001)(126002)(14454004)(2616005)(476003)(22756006)(63350400001)(6486002)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB2826;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 08f56c00-e7f2-4cd9-d976-08d7400e411c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:HE1PR08MB2826;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: 1VmJAPmQld2qt8MtgHk/+AW5nRU1L11G0qY8owB7rg3mxMgHeTPEueEZ/I1MKTtE5dlFNzKkGDZ2SqK/s/kT07VuXgRVpJFUMiQy+BZg2dAZUWtlpJeK0grv/iSIBLb1QKfAf9BWxnfpdx3omb4Mr7hsouPg3DkCh6ejHES/9bd8ldzFZQOUIqleFm2uJcSFQ6BBLXPwOjC6wAeha6lUXXbkVq7K5eC03RqmI1rA64fd1N7Zm6LnbYh5tRirGf5n21t/vi/fna+Az4IJxCHufLakc1mDd19ZeppgqrucJsWDXd/+MJqKbqvfmGfCpuVMknq2nEqw/+nVKFRVBg3SxPFUjOyvGeHrrx3O/wcNccoXQtCe/FdC5QO3Cop6oo8V8QKPZMNLvIGy39XoBymOehb3QK3+eiLpfvd8/EGAVrk=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 10:14:13.3058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb56579e-cab8-40de-886a-08d7400ec87c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2826
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initially turning a crtc on, drm_reset_vblank_timestamp will
set the vblank timestamp to 0 for any driver that doesn't provide
a ->get_vblank_timestamp() hook.

Unfortunately, the FLIP_COMPLETE event depends on that timestamp,
and the only way to regenerate a valid one is to have vblank
interrupts enabled and have a valid in-ISR call to
drm_crtc_handle_vblank.

Additionally, if the user doesn't request vblanks but _does_ request
FLIP_COMPLETE events, we still don't have a good timestamp: it'll be the
same stamp as the last vblank one.

Work around the issue by always enabling vblanks when the CRTC is on.
Reducing the amount of time that PL0 has to be unmasked would be nice to
fix at a later time.

Changes since v1 [https://patchwork.freedesktop.org/patch/331727/]:
 - moved drm_crtc_vblank_put call to the ->atomic_disable() hook

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 34bc73ca18bc..d06679afb228 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -489,6 +489,7 @@ komeda_crtc_atomic_enable(struct drm_crtc *crtc,
 	pm_runtime_get_sync(crtc->dev->dev);
 	komeda_crtc_prepare(to_kcrtc(crtc));
 	drm_crtc_vblank_on(crtc);
+	WARN_ON(drm_crtc_vblank_get(crtc));
 	komeda_crtc_do_flush(crtc, old);
 }
=20
@@ -581,6 +582,7 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
 		komeda_crtc_flush_and_wait_for_flip_done(kcrtc, disable_done);
 	}
=20
+	drm_crtc_vblank_put(crtc);
 	drm_crtc_vblank_off(crtc);
 	komeda_crtc_unprepare(kcrtc);
 	pm_runtime_put(crtc->dev->dev);
--=20
2.23.0

