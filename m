Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6E2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B17120873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DQQfD/9x";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DQQfD/9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfJUQra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:47:30 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:15543
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbfJUQra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J64zuHWOx4EgCVB0EXqWQuVwvJWaiUGokgqOGlFcHs=;
 b=DQQfD/9x1Wk5cOP4QuPEq2jbg1peJD0owTGknc60DJGQ2oMd24ejC6VIzcpNQqLD8o6ZPx5iVcU2nSHz+2BLp3zQCM0gYyRToj/8nlDyPILJz+H1q1uJsIGWm+xgcPIdjmhjsvwBn6mZoJThE8XLvc3sEuwl2IKtqcQWNbqkhn4=
Received: from VI1PR08CA0160.eurprd08.prod.outlook.com (2603:10a6:800:d1::14)
 by DB8PR08MB4172.eurprd08.prod.outlook.com (2603:10a6:10:af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Mon, 21 Oct
 2019 16:47:23 +0000
Received: from VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by VI1PR08CA0160.outlook.office365.com
 (2603:10a6:800:d1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 16:47:23 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT028.mail.protection.outlook.com (10.152.18.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Mon, 21 Oct 2019 16:47:22 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 21 Oct 2019 16:47:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 09200a0bbc1e8812
X-CR-MTA-TID: 64aa7808
Received: from ac021f889559.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BCAA7B54-562D-48D5-967C-A88CD68B50C2.1;
        Mon, 21 Oct 2019 16:47:10 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ac021f889559.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 16:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxZ2q/T8c7sho3PVJCnqS5y55lUfVGtFW7FgUIjCxGU6lk6eIe9NgCEkbw1wScA9t2vO7m8buBND0vyAOoPakujdoU086E4SgQe/M7KWUAqW9DU8g6OtU+Jw9Wyotv33zycUpVQUHJgOuKD6JDZ8iMng70tjmNOj8uSYXPlCSRKmRZKZj6CMW493g1PiIamI75lq56nA1728itWsrHaLouKPhxPufYuHhVCr9UKjfZBZXAejioX7wnKHOinC+cTFmqGeZr8bAbqVIoY7YQC6MT/0buo00LEB3OWv4IamFncF5GbalghS1QLRRy+sMA6OT8U+sirx4b+yPEkQMH3Alw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J64zuHWOx4EgCVB0EXqWQuVwvJWaiUGokgqOGlFcHs=;
 b=O+S6ve4ahFoMosxfuUUkqTkz4/3wQPPkF5UZTtesqE0N7vB8reu5UegxdH+2H23ODiEhB3PCJwteoWzaRQBsjDWAfnQWz98AqzMP3DtlZug6b4bTwouVzwrc/24v7AsK0uK8kuLsvGrg1Hi8M7sGyUDRRHpm/FcFys5v/HjcBUkDZFU146ZyWPCPAGePzkrrQ6/dDyW9G/FTaOZ3Lv0M9AvX782Y8SImEGujj155RdoeA/BPqN1Ob1PigavfzIvXfi1LwWF2h3NTbPsxg3dZBRFx+1e0+SwPNJdALG8ea4hgqeGqYgPRVoogm5RLI38EyIYzqiIyiLMsFgRFg9H3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J64zuHWOx4EgCVB0EXqWQuVwvJWaiUGokgqOGlFcHs=;
 b=DQQfD/9x1Wk5cOP4QuPEq2jbg1peJD0owTGknc60DJGQ2oMd24ejC6VIzcpNQqLD8o6ZPx5iVcU2nSHz+2BLp3zQCM0gYyRToj/8nlDyPILJz+H1q1uJsIGWm+xgcPIdjmhjsvwBn6mZoJThE8XLvc3sEuwl2IKtqcQWNbqkhn4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3693.eurprd08.prod.outlook.com (20.178.13.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 21 Oct 2019 16:47:07 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 16:47:07 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] drm/komeda: Improve IRQ error event prints
Thread-Topic: [PATCH 0/5] drm/komeda: Improve IRQ error event prints
Thread-Index: AQHViC8s1KqImT9XXEOlhsY8a6GCNA==
Date:   Mon, 21 Oct 2019 16:47:06 +0000
Message-ID: <20191021164654.9642-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: fd6fa06c-e698-472a-d20e-08d756465819
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3693:|VI1PR08MB3693:|DB8PR08MB4172:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB417220E884418017CC0331388F690@DB8PR08MB4172.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(53754006)(199004)(189003)(6436002)(316002)(54906003)(256004)(8936002)(6512007)(14444005)(2501003)(71200400001)(5640700003)(71190400001)(50226002)(486006)(2906002)(6486002)(2616005)(44832011)(5660300002)(8676002)(476003)(305945005)(66066001)(36756003)(86362001)(25786009)(14454004)(186003)(478600001)(6506007)(386003)(102836004)(26005)(4326008)(2351001)(81156014)(1076003)(6116002)(3846002)(66946007)(81166006)(66556008)(52116002)(66476007)(7736002)(64756008)(66446008)(99286004)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3693;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Q+H/W29S9wSshMyTd5bwXyZwC32skH2JBr7WmRnO6giwOntgnsg3Tk6y3HuBOUOJ4qoeEAb9cFC9tKviONfbnh2SJxbXCq+G8yA8ltOMcQvO3XFqbEVwnt6fE4msM0lQxRSATKwYz+QFvUNXvLRQS/fkpFlGHbNpKH4alfo1FqXpLtWmKRky7AtDGbwSJL2r0eQnK9dHY6VF4XOSt7iqsybnhCB9KiIkJHaLEMfCychY76s5b5pgIy2Y4ZZBvxZh2f2v6DBHgiKIP0gaCacLe3sqPtxUORMI3mK/jgrT65BjMXcvHN5W66uRg7dm0HesqYCgIW0DthB/paaTOE1rPiONy94Y7ey4jrDYoov7ZLQr+DsO2gfDP7s3PDaF7Uthp8a4gSgQFXq+dCukbTSqUvhZUvZNU9DMqnTlf7dRYstQVvtVg021TtPQwHcDGTum
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3693
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(53754006)(199004)(189003)(6506007)(1076003)(8936002)(81166006)(99286004)(478600001)(26826003)(6486002)(8746002)(81156014)(5640700003)(50226002)(356004)(14444005)(14454004)(102836004)(50466002)(22756006)(6512007)(386003)(486006)(76130400001)(8676002)(2501003)(26005)(6862004)(476003)(66066001)(305945005)(63350400001)(186003)(4326008)(54906003)(5660300002)(2616005)(2906002)(86362001)(23756003)(6116002)(336012)(70206006)(25786009)(36906005)(70586007)(7736002)(126002)(2351001)(36756003)(47776003)(316002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4172;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: dd382067-8a03-4867-78d2-08d756464ee2
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGTMQEBigHsWSibrB0a8pkrxr5rFR0G6wy95ISm2qX2QoMvGpdUKFdPl1WKazcKVtkM2lJY3bfJd1HRZNflbYEefYjUxlLgNa6bJnaorPMs1yeg8ugLhmruWTHCQ11s7dB2ykOhdy9qc+JH5z6IstfCt1XcSU7hUQCaeUFIZlfgpCyp9WEDMXNsqTqzS19uO0OR5m12YjWMteXGoj3ZXlvjWTJFwNlymT7zS6yzS6SOyv3Ud5cKHRM2vQZ9l35a26EE7/fCVMA8GhX1Shw/wVZtrQzBYMIZKOcOGxBKBzkPQPkkWKkZY/m1npDl2hLtXwTsTomSF0OKFxeHnGhp7iazauDymbdoigqa5rXzMHPCZdKl+N1p76hEwphswtaDlMzfabuOLti32ZcXvLClZAJrS09BZ0kjwm0WVaHCAKmKBKmauTki+gXnoUORXfwjW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 16:47:22.0830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6fa06c-e698-472a-d20e-08d756465819
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is a smallish series that tries to remove some build-time
configurability in komeda and replace it with a debugfs control. Later
patches in the series add some extra functionality which I found useful
during my debugging sessions, so I figured I'd bake it in.

I've preserved the default behaviour as if CONFIG_KOMEDA_ERROR_PRINT
were enabled, so production kernels can have some feedback from the
driver when things are going south.

1: Introduce the err_verbosity debugfs node for komeda; this keeps the
   default of printing error events once per frame.
2: Drop CONFIG_KOMEDA_ERROR_PRINT since output can be disabled at
   runtime
3: Add a drm state dump on event. It's quite chatty so I left it only
   for error events; printing all that once per frame every vsync floods my
   serial terminal, so no info + state combination.
4: Add lower-severity categories to the event printer
5: Normally these events fire only once per pageflip, but sometimes it's
   useful to see them all as they come in.

These patches are overall quite tiny, and I was considering just
squashing them into one, but I opted to keep them separate for an easier
review experience; please let me know whether you prefer a single patch.
Thanks!

Mihail Atanassov (5):
  drm/komeda: Add debugfs node to control error verbosity
  drm/komeda: Remove CONFIG_KOMEDA_ERROR_PRINT
  drm/komeda: Optionally dump DRM state on interrupts
  drm/komeda: Add option to print WARN- and INFO-level IRQ events
  drm/komeda: add rate limiting disable to err_verbosity

 drivers/gpu/drm/arm/display/Kconfig           |  6 ----
 drivers/gpu/drm/arm/display/komeda/Makefile   |  5 ++--
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  4 +++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 30 +++++++++++++++----
 .../gpu/drm/arm/display/komeda/komeda_event.c | 24 ++++++++++++---
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
 6 files changed, 52 insertions(+), 19 deletions(-)

--=20
2.23.0

