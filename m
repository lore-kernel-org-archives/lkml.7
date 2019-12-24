Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA94C2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA2F2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4JWDNwbN";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4JWDNwbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfLXRgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:36:41 -0500
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:23399
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfLXRej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSDvBOZ3alE2evKaNIymyI/voICFfduJ2i2E7yDy8gA=;
 b=4JWDNwbNugC314EJbSe6rNva5Ds7K5LDHFdOk1o7CW+lZKWSvct/fnBGs1M6GcOwBrOhVv7+4Sba1foim9LLgkPGGYSkFoqUa+gdlM6+X3TY/6jB8AilmTApaXFN12KZXHWuNGjXRd+fVJq/8BypHuD6+16vgOzCbeSwnL+QHl4=
Received: from VI1PR0801CA0067.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::11) by HE1PR08MB2857.eurprd08.prod.outlook.com
 (2603:10a6:7:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15; Tue, 24 Dec
 2019 17:34:34 +0000
Received: from VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR0801CA0067.outlook.office365.com
 (2603:10a6:800:7d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:34 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT020.mail.protection.outlook.com (10.152.18.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:34 +0000
Received: ("Tessian outbound 28955e0c1ca8:v40"); Tue, 24 Dec 2019 17:34:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f6da4f48f9d6bff1
X-CR-MTA-TID: 64aa7808
Received: from 3bb695b41535.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F6238562-0C3B-437C-9E06-3B289AF07FED.1;
        Tue, 24 Dec 2019 17:34:29 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3bb695b41535.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwGEDvisY5rtr6yRja3+0onKQx5C6NLO+xWBRloanV7sYgM5qTm7rOn3fxDo8w8fIV2LCnCKC9UtuBZH55+Y01aLRXuFnJb5qa/xmanI9zUxwCiGNamJe33gahsf4RIYO15tT7napwElPptQvC4X3TFhocqzE8I/ZFli7ofQ7IO8nywnYFVfd88D6ytTliW6Kh7tYFqkN/NYMfy8k4bjn5gat3GLuO8B2jfgCTCGUOP1A5Gc5BddJF6N22xt/9/zcFK7kWDfXmvZKhEZ4CDhQt/b9jMEoaOcKzSJoOzCC4hMkAUdPszw+lIsshtjc0U3rIOr+ma6j0Gsw+AgSN/tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSDvBOZ3alE2evKaNIymyI/voICFfduJ2i2E7yDy8gA=;
 b=aMIwK0Abt0L/vdI6ADaK5WX/yFoUmdU0MQ7DshS70ihBcLmqOB8htQzSf73Dgsc1PslKdIVI6hDfQPnkmY92qbNzq4xgpfLj65bjzxttSu8Asdn//gjxiLS7zKNllR8bmWsqUd+01TeyCSvvutlJFkjc7/N74lGQyULJ0SPh8ttaZinZ7Z3/vOvZUwVzVk7junI6zmbnpOjyvFmK0+GvlcpkuWa2jlwnCMR0SjleSR52NFqdwcJm7X1wB/oHY8R5uYZLJwjVt5wN7Eyv/ywULkZEV/fOfrtL+gKJmb5jJNql1Rc4Fuzb9V/ibLe3pWW8O03M2Pv865lIA4JkqTgQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSDvBOZ3alE2evKaNIymyI/voICFfduJ2i2E7yDy8gA=;
 b=4JWDNwbNugC314EJbSe6rNva5Ds7K5LDHFdOk1o7CW+lZKWSvct/fnBGs1M6GcOwBrOhVv7+4Sba1foim9LLgkPGGYSkFoqUa+gdlM6+X3TY/6jB8AilmTApaXFN12KZXHWuNGjXRd+fVJq/8BypHuD6+16vgOzCbeSwnL+QHl4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2702.eurprd08.prod.outlook.com (10.170.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 17:34:28 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:28 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/35] drm/bridge: Drop driver_private from struct
 drm_bridge
Thread-Topic: [PATCH v3 08/35] drm/bridge: Drop driver_private from struct
 drm_bridge
Thread-Index: AQHVuoBk+QcG1vdB702CoP8zCZJWpw==
Date:   Tue, 24 Dec 2019 17:34:27 +0000
Message-ID: <20191224173408.25624-9-mihail.atanassov@arm.com>
References: <20191224173408.25624-1-mihail.atanassov@arm.com>
In-Reply-To: <20191224173408.25624-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.24.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc4422c6-dfef-4c4b-f3c1-08d788978aeb
X-MS-TrafficTypeDiagnostic: VI1PR08MB2702:|VI1PR08MB2702:|HE1PR08MB2857:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB285714C2E355CB4A3EE6296D8F290@HE1PR08MB2857.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1303;OLM:1303;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(81156014)(8676002)(478600001)(36756003)(4326008)(8936002)(66446008)(64756008)(66946007)(66476007)(66556008)(26005)(186003)(44832011)(6506007)(2616005)(81166006)(71200400001)(316002)(2906002)(1076003)(6512007)(4744005)(54906003)(6916009)(6486002)(86362001)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2702;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gZXwvNI/YD84Xu9N21Kyldd5xsw3rntRy/yPOzrz49/O9zZWDrCTWzKXC3z4CpG4FitmKHXLZiW4ItCwJb03sn1J0etErcPOh88s36n4/tT4NCYC3guIpviPGA4qNItlEM6S7G5izhdOLwAr/wtl09zTSxS2vu8DbM35CGyqzFLEgpsjwhvq47YypFi4OZYXfkXZ9/dnAhN15wDWGLWRMsg1yh82oO0CdbQxRx4dcWgFMeo2elWtugxXodJxryxOZmi2Q6/bDbGgnB3M21ugnxtEVKRcgIh2DT0gJUnQHkOHLwu0juNm2voLhuxPG4AoUpeOml5Ro1/9q7jCR8dtGrS6Ntd2v3bVp/GGTRyepBXzjJkrIg/9Z6UAq6SfntinWkRybGjMlt37JnMRs66cqTlk6s6WHANk7I6PORhQBYojmscRERvCv4upkVouJAeQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2702
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(26005)(478600001)(1076003)(54906003)(4326008)(70586007)(6512007)(186003)(70206006)(356004)(2906002)(81166006)(81156014)(8936002)(8676002)(6862004)(36906005)(76130400001)(316002)(26826003)(6506007)(86362001)(6486002)(336012)(36756003)(4744005)(5660300002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB2857;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: da99b08b-483b-4ab0-c7bf-08d788978640
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cECTU0V2NEzyPqRe38IYnSr3hRuDhZ6p4V11rortQzlrSTQsN3V+o+vMpZ/kc/u/eDVRL5EkA7znmjYVLvPj1slUhHx2+1EH0Wiy/U3I4KZkTxlfxvslsF/4nswrwmQw4q/e3YHg1HKbI4oSbdP+3eLrpv7H8MMx6BrgCt6vgqtyWX6LRJ8jzK2s4OvEsFyMI6Zy0nPTqiSKHyymfqLMsjoGVneX7agBXIhYZXu+rKzCdbIm3MmtOibf5By7b/BB9mGj+Kol308JvZy976qPOV7BZx+wIisnFrLbrWFNrPpWtPoIisT6ntjwL07rU79mkwJcqWFSKSUeyvaEnwkal9PEdkA+1WLMOYoXLm+gvbHfkn/dMwzB+iQ0soL4OqeBRxeyv/0uVcNr5OSoazPl4Vy5bxsNMkmSvQQZXEij1loEkQSXwHCjQZMI5TCBdi9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:34.7302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4422c6-dfef-4c4b-f3c1-08d788978aeb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2857
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's no longer used, all drivers have been converted to an embedded
drm_bridge struct.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 include/drm/drm_bridge.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 695d0898df38..ee175a2f95e6 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -398,8 +398,6 @@ struct drm_bridge {
 	const struct drm_bridge_timings *timings;
 	/** @funcs: control functions */
 	const struct drm_bridge_funcs *funcs;
-	/** @driver_private: pointer to the bridge driver's internal context */
-	void *driver_private;
 };
=20
 void drm_bridge_add(struct drm_bridge *bridge);
--=20
2.24.0

