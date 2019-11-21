Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397CEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFDF20898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="znInJrit";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="znInJrit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUIR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:17:58 -0500
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:37447
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfKUIR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6KAgV9VNacs05IlHwdZGzekRkk3LW/r5ghdHaKNrGE=;
 b=znInJritgqwHfmdC1e/nIc6E6tu8TRC1VWdoHGR3uL1/S1kDTbfAcGwM8+sXW1qL6JdcQdYabB+NqYHPjGPp5/+o/+LRJ3K6Qnq381x2EQWw+8q2nwNzC+zMHaoS2SJorF/NHmw5p8PPATPh/xPkSbnkcTqmgF1b6zfD3CiBpVY=
Received: from VI1PR08CA0199.eurprd08.prod.outlook.com (2603:10a6:800:d2::29)
 by DB8PR08MB4010.eurprd08.prod.outlook.com (2603:10a6:10:ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 21 Nov
 2019 08:17:44 +0000
Received: from AM5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VI1PR08CA0199.outlook.office365.com
 (2603:10a6:800:d2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19 via Frontend
 Transport; Thu, 21 Nov 2019 08:17:44 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT023.mail.protection.outlook.com (10.152.16.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 08:17:43 +0000
Received: ("Tessian outbound 512f710540da:v33"); Thu, 21 Nov 2019 08:17:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 730f22fbe99feacc
X-CR-MTA-TID: 64aa7808
Received: from f395dae5f728.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E449D34A-4FF7-40D3-A9DF-9DBA5F9EB3BA.1;
        Thu, 21 Nov 2019 08:17:36 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2051.outbound.protection.outlook.com [104.47.4.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f395dae5f728.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 08:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIv5LFb116FgCsNaJ8AK9isKXnQw9lVAP4J0D3C55Z84p1BQvz4Lknu9Q7rM94o1TWQOTkY17sxmhiWhqdruN2+f3mRKKx4Jk3qjtmFrdfou2lIusH0b2cXVsVissMf7y83Qafbj/ilwTXhR2JYQZ0vs1bCUUJgn0iUKuPg7mcrcv8VXN2Uef67pt+bi6iNq4T1ff2K8TY+2zWGGrxV7s1m3gtUAopf1F9lN5lZ8SBBY6+kQUELQ7pvarXUJoPaAvnh5T9U2T8JmWpGi/3tfyFewRqv78yK0s0f2nFWABBwN+O/MLEiZkBd8KG9mlEHo8OXwQv8V3FCFy97ISYPdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6KAgV9VNacs05IlHwdZGzekRkk3LW/r5ghdHaKNrGE=;
 b=OtZ4BXfZ1U5nGDYVn9NttZUu8TzAiIieV/PWFDpnEWPD6P4H83z4PUBhvtrYJPWrRxKvS0Xux/nuvv7tMDGc0TfQ1QwVvuIxGYOlVcrNbVr6xU8N8c0pFs+mlVKCp4VVwhXomal+EIb9h549dpL0pjou/G22UIfBPBFHhjYyadsQiNIOfTzrwSK1aUwyy+itghAi3LQ8OphoorfTZd+1+TXkq8tdKWCfvGhj8oKII6tBkEYHzlke7tJO1CEo4l3FZJK3vadbiy6IKX4bYG8HvgFO7KS2H/2zKdTxyVBeUtrvVdS8roy6cRRxBpj01BTYW9NGdnWtflNQSYIHtlhPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6KAgV9VNacs05IlHwdZGzekRkk3LW/r5ghdHaKNrGE=;
 b=znInJritgqwHfmdC1e/nIc6E6tu8TRC1VWdoHGR3uL1/S1kDTbfAcGwM8+sXW1qL6JdcQdYabB+NqYHPjGPp5/+o/+LRJ3K6Qnq381x2EQWw+8q2nwNzC+zMHaoS2SJorF/NHmw5p8PPATPh/xPkSbnkcTqmgF1b6zfD3CiBpVY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4910.eurprd08.prod.outlook.com (10.255.114.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 08:17:34 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 08:17:34 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 0/2] drm/komeda: Add new product "D32" support
Thread-Topic: [PATCH v2 0/2] drm/komeda: Add new product "D32" support
Thread-Index: AQHVoEQgs9VqsrNWe0K3imLeTJdC+Q==
Date:   Thu, 21 Nov 2019 08:17:34 +0000
Message-ID: <20191121081717.29518-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bef41965-814d-40b0-dccd-08d76e5b48d7
X-MS-TrafficTypeDiagnostic: VE1PR08MB4910:|VE1PR08MB4910:|DB8PR08MB4010:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB40105A195C21A56E174415C4B34E0@DB8PR08MB4010.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3173;OLM:3173;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(136003)(39850400004)(53754006)(189003)(199004)(6116002)(3846002)(2616005)(6486002)(478600001)(86362001)(4326008)(102836004)(6636002)(71190400001)(26005)(71200400001)(54906003)(110136005)(14454004)(186003)(2501003)(6436002)(316002)(6512007)(99286004)(25786009)(2906002)(66946007)(64756008)(7736002)(66556008)(4744005)(66066001)(305945005)(1076003)(66476007)(256004)(14444005)(36756003)(52116002)(386003)(6506007)(55236004)(81166006)(81156014)(8676002)(50226002)(103116003)(66446008)(8936002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4910;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Yu5DnEVTF1yhV7q+5bi+wJg9zUWMfU09CWnPoMONrKB9DttjbnPbusRbeIjnTma1LAOodoIVPkyeMzdDN5n1I30V7hlHBAZ1uc0S8V033/E4gd/i3YpUJpBLvEBeR/GwfwwMruLhhKabFu2dU9E0z4tBjIPBM0WOxwWnbjMd4+8Tmf8kfALgOPkSTg0F75xm1GTpXjH/qcuNoFMJyYoSEPYzoPlNIOzyWGX8WQDpU+m8q9g2BJF1KjfFOrdHdG9PA2ldWnNzJcvOKAtNAYXd5m168XLzCpj3h2eTA0BpkjNG0yk9tqv0moF4chF0szet8a2/aKfaOGvzt5T6YfoCs4FPnCw3rNj9800KAEAekLpR63u9f7fToGsbb86GJyse7/PC3KNIu5SUWtzg4+ZimjomjYjjhMxlnmiDUhX/g9ehI9+AF64DHSun8MXnAksF
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4910
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(396003)(136003)(376002)(1110001)(339900001)(199004)(189003)(53754006)(70206006)(25786009)(6636002)(2906002)(14444005)(26005)(23756003)(5660300002)(356004)(2501003)(102836004)(70586007)(26826003)(76130400001)(103116003)(105606002)(6486002)(81166006)(81156014)(6506007)(386003)(47776003)(7736002)(305945005)(8936002)(66066001)(36756003)(3846002)(6116002)(1076003)(50226002)(6512007)(4744005)(86362001)(478600001)(14454004)(316002)(336012)(8746002)(2616005)(36906005)(4326008)(186003)(110136005)(22756006)(50466002)(99286004)(8676002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4010;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3e53269a-c3c5-48cf-bdb4-08d76e5b42df
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMDY3X9sDTPoEWpHRqffzhWzMo3krtGYX+ylRA65DCoNqsnTYGDlFhHNiD9Q9ByqOnUveRVX3lXt41e1gk8wH8QTSRrE1R4WOu889lOgiu1yxPsio3pAbf0B6VF8/VFDpkjlyzlb0bfI49lxP9b9sfBNQOQ7OzzmQiIo/VwVF52pjV1tg4DgMqTTLMuW1nhqO6uHRInNO65WUsuCag95GuMQWvCRY89ofNB/KjSKD3ad/bSsCDmkUfSCvvNRy3Z/KjS8MIKAj6IscGlGTuIlPmuWiaPLvqI4xAzUlhN+T6DdUK+YFIIUFNumR8m8dukxSeiUYOgEVA2xBhDapW40B0M6wXUFnNXiRSv6HucdSXNCm/+hoyyqFSfdjRxT8iE7FuOWE2MPY8cgBhjxS23p55i9tZt+VbAKEbQ8vJUek+2KX4IcrxOCGPK2W1BwwQmr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 08:17:43.8839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef41965-814d-40b0-dccd-08d76e5b48d7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This series enables new product "D32" support

v2: Rebase

james qian wang (Arm Technology China) (2):
  drm/komeda: Update the chip identify
  drm/komeda: Enable new product D32 support

 .../drm/arm/display/include/malidp_product.h  |  3 +-
 .../arm/display/komeda/d71/d71_component.c    |  2 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 70 +++++++++++++------
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 60 ++++++++--------
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 14 +---
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 10 +--
 7 files changed, 102 insertions(+), 70 deletions(-)

--
2.20.1
