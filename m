Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0175BC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93122196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cx6QLADb";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cx6QLADb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfJKFpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:45:41 -0400
Received: from mail-eopbgr120089.outbound.protection.outlook.com ([40.107.12.89]:60032
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfJKFpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3exUIpO43eg+isG5bikJNfuF7PWKS/F5BOA9HkurNU=;
 b=Cx6QLADbRPY5lNWIYeLS1CFys9z3izxennI/uI1nv6lRTE4zWtcb79FBftlxFjvtzd5BUjavW14AcZBcdnsGPPnitoAUmx8tFKrLt2MheaRvmj995E2jfBA1F9C6uA1y68lplQpooB+y3zY1Kt/gKahZW50lQHo/gDdvBA4WH3g=
Received: from AM6PR08CA0034.eurprd08.prod.outlook.com (2603:10a6:20b:c0::22)
 by PR2PR08MB4747.eurprd08.prod.outlook.com (2603:10a6:101:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 05:45:35 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by AM6PR08CA0034.outlook.office365.com
 (2603:10a6:20b:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 05:45:34 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:45:33 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 11 Oct 2019 05:45:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ec8458e84ace2f81
X-CR-MTA-TID: 64aa7808
Received: from 36f599f7557f.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B07F8312-C76D-4081-A373-B0BCCB85C7E3.1;
        Fri, 11 Oct 2019 05:45:23 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2055.outbound.protection.outlook.com [104.47.9.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 36f599f7557f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 05:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+4rHj7ILP5YC79spbCb4x4eKQcE+Dc90oYrPKmSPTooM+kTaWs4dPSF/l0f1oVO73mNv9mwaQevBI4PgZrBrr+XXYXmZxqRWKy0jjm/P9Q1nM6nv6A5Y7kdSxCiuO6znJ376MFzgnDzxpRH5AxJLAhNLBS0oqN0jpXrqnNeC/bcAHNkAPWkaRqkG+TJsEW8QqjbgR5AyOJAvk+LWu4kOIN8ghPeCktRIHCDY+KALSXa9qeZGGwkwHRv7qEYyakIQ6sIyJ9u8Gu2fnfsLXOcrDNpkxFHCvdF2iH9+39iKliI/SNn6a0ApYSAP6DxwWfXwCXo2/G2yTf0Bn0X3AXFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3exUIpO43eg+isG5bikJNfuF7PWKS/F5BOA9HkurNU=;
 b=OOXaMzfJXgZbPgqJmG2GrsPuIYRrI5n+e2mNwjg62aAHZJT4xHNJySZyrbTUOWn+tdj5VXex7NmH6ScAnwgpQpdVbAn4N8gNw/CRJztpz96ECHZ6OYY0eBYLfbbqKd1x9M0rhswmyNNIcByO/cUdA546A4MbwqwOKuIeJxGe4gXsRIOigg3/QwN4aoPVhlD2J7mbMJOKNrViiYRI2JgBsHs8WiNlh70UmSMjCk7VqyY0tptvoPCddP7I3tccSLKujzrhYtqrvaKn8kNK/w8HPW5xbq1uYo7fsV7C8rQmM0hMhOMLDzDysJYVtSgdVuZorzRUwSOWSj5B3A/jLk3AcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3exUIpO43eg+isG5bikJNfuF7PWKS/F5BOA9HkurNU=;
 b=Cx6QLADbRPY5lNWIYeLS1CFys9z3izxennI/uI1nv6lRTE4zWtcb79FBftlxFjvtzd5BUjavW14AcZBcdnsGPPnitoAUmx8tFKrLt2MheaRvmj995E2jfBA1F9C6uA1y68lplQpooB+y3zY1Kt/gKahZW50lQHo/gDdvBA4WH3g=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4816.eurprd08.prod.outlook.com (10.255.112.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:45:20 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:45:20 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v2 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVf/cRaSCszxE5iUaQkwz7EKs12Q==
Date:   Fri, 11 Oct 2019 05:45:19 +0000
Message-ID: <20191011054459.17984-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:2e::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 08e68f21-165a-4544-1e89-08d74e0e3bbc
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4816:|VE1PR08MB4816:|PR2PR08MB4747:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PR2PR08MB47472DC257CF28F3BA7972DEB3970@PR2PR08MB4747.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(4326008)(2201001)(2171002)(86362001)(2906002)(103116003)(36756003)(6512007)(1076003)(316002)(110136005)(81156014)(81166006)(8936002)(6436002)(54906003)(99286004)(50226002)(6306002)(305945005)(7736002)(8676002)(3846002)(6116002)(5660300002)(52116002)(6486002)(66476007)(6506007)(386003)(66556008)(966005)(66446008)(64756008)(14454004)(186003)(14444005)(256004)(26005)(102836004)(71200400001)(2616005)(476003)(486006)(66946007)(55236004)(25786009)(71190400001)(2501003)(66066001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4816;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xnvdI4j8N6+ek0kDj/6enfPQtiL80Gotqv4FKyPeI974DIYN3i7DQ0HwqENN62SkDAu4ChPkFiRGUxQYflLvoIs3eTp8Wa8Qu+NJVJ1m/nuyOiEkarlNQFF0RGfPWF03bsE8NKo1qmbd1H7lRAThL1LM7eQXKX5wAs+AkX0i8LVip1r8+edNZFrbbxVWBI2lqX2nRYp3c04hSs3rNKCMXYECOpIjm4no8BGNg0s22wOc0n66haaYAj/U6UGdo/f2StrlGu6SvGSM88bBWGoDlaucAogpP4nJRpKyZKEtV5tx90Wii3SFroQm0VtFiBr7/3kFyyRXjTF+ahEem3JfCmP5LqykGIZ3tjI12ScgmmapEFQCe+awOJau6GKFY2xqlMwkhZi5IUKvt0o/rgxQmpOxOYNgPAQ2YmeAl1CERBeMwPX4VlLWCeNOXj0bNyZK5OaejQ0W5TI0V7Av4hTWQw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4816
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(47776003)(2906002)(54906003)(356004)(81166006)(81156014)(8936002)(8746002)(8676002)(50226002)(110136005)(6306002)(6486002)(2171002)(6512007)(4326008)(2201001)(22756006)(2501003)(66066001)(86362001)(966005)(14454004)(26826003)(478600001)(25786009)(23756003)(305945005)(7736002)(36906005)(316002)(103116003)(50466002)(6116002)(3846002)(99286004)(36756003)(14444005)(1076003)(76130400001)(336012)(6506007)(386003)(102836004)(70206006)(70586007)(26005)(486006)(63350400001)(126002)(186003)(476003)(2616005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4747;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 70506e76-8f38-4749-d321-08d74e0e3368
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLJ76ljHpFBAmI+cECqZqXrvEg+xirYkBZHQEB8HMSjYeqLW1VOHgVbIWYmuruBghgvnoQFxmNw/EIXIZz/M6+jv00PwglxXbwjtxhTgWEa+3npYnDM/bHO3So219ZeNPT1l74HQLzrFhA4Eli9MUCs0zo1fLUnoymXan6amLFgXik/jXZZ1ro8LYkV+YRSOkXN84q5TVn1n9RYq7D9y3jeChIVWudIrWroASCfldtwF4BA8atHoBgJRSxK9gg5FGB/Pp/hOkI5VE4vHHlm+3cAfOMsW65Xe7kw2dhWv4xemLW4QiVuUf4Bl8UUwXA0RkDoa1h53Mb2fB04temAOKCazcb9lW3rH2ThT/g077SM5kvPc3LOJ0Pk4JGpxBLQN1QhFWcshOYy9LE0hDFUoO2EqbGe4XKuwIFBVLoqDu33OazQdko0pQ+A5Ya3lhdj9Wkr/v+TpA+Hj3MgNeZZudA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:45:33.3836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e68f21-165a-4544-1e89-08d74e0e3bbc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enable CRTC color-mgmt for komeda driver, for current komeda HW
which only supports color conversion and forward gamma for CRTC.

This series actually are regrouped from:
- drm/komeda: Enable layer/plane color-mgmt:
  https://patchwork.freedesktop.org/series/60893/

- drm/komeda: Enable CRTC color-mgmt
  https://patchwork.freedesktop.org/series/61370/

For removing the dependence on:
- https://patchwork.freedesktop.org/series/30876/

Lowry Li (Arm Technology China) (1):
  drm/komeda: Adds gamma and color-transform support for DOU-IPS

james qian wang (Arm Technology China) (3):
  drm/komeda: Add a new helper drm_color_ctm_s31_32_to_qm_n()
  drm/komeda: Add drm_lut_to_fgamma_coeffs()
  drm/komeda: Add drm_ctm_to_coeffs()

v2:
  Move the fixpoint conversion function s31_32_to_q2_12() to drm core
  as a shared helper.

 .../arm/display/komeda/d71/d71_component.c    | 24 +++++++
 .../arm/display/komeda/komeda_color_mgmt.c    | 66 +++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    | 10 ++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    |  6 ++
 drivers/gpu/drm/drm_color_mgmt.c              | 23 +++++++
 include/drm/drm_color_mgmt.h                  |  2 +
 8 files changed, 135 insertions(+), 1 deletion(-)

--
2.20.1
