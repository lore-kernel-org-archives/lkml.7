Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3BEC388F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A92218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ckNWgg8l";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ckNWgg8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfI3Eyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 00:54:55 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:23464
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfI3Eyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 00:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QZnQDz9b36TsgB9c9MJyvWdQprrhPmacBd5Q7k2Gek=;
 b=ckNWgg8lB+hBCo3wt0RYL5ZThciUvchVueTpSY2yOJxrNgq+rZkP4cI5G8Mfq8uW/8wMUJSfEEq8NwaohUdS97vGiiDqjFhkiJu6LxCX9p3chNVyDJXqmXvZGjUN0nk3LWnNMUOrj7rjZavUvuDcKs5f32BTTbHfzamXgu6dI6c=
Received: from VI1PR0801CA0087.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::31) by AM6PR08MB4135.eurprd08.prod.outlook.com
 (2603:10a6:20b:a9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 30 Sep
 2019 04:54:44 +0000
Received: from AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by VI1PR0801CA0087.outlook.office365.com
 (2603:10a6:800:7d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Mon, 30 Sep 2019 04:54:44 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT055.mail.protection.outlook.com (10.152.17.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 04:54:42 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Mon, 30 Sep 2019 04:54:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5c3c08a1728b2649
X-CR-MTA-TID: 64aa7808
Received: from e70aef5713ef.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1CC3D04E-17BF-4A7D-A665-C8873433BD7C.1;
        Mon, 30 Sep 2019 04:54:32 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e70aef5713ef.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 04:54:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw2TuEQfCYEUpKEiCbuRTsjTWgAqYAj/4IDgGZ3CrvDiA506bme61YQRUDqUO4JnPn/iqecOkK1ej/fVyUVAPSYULKaMzhdzj/IMaJeohZ19k9mZQXSp8L//+20mbeZ3lTKzCDZxPA3o4HdTfVLi3KSA+1exM74dJZptthyp57ZNRkWrd6egFQ8ef5kE61FRiR4Vci/WNFI5tqGbqRK7TysKT426qtBKRnN/E7TXwXZxy6dwGRE8xeLiDqxyAV3frEdNPXAgknIsfKgyQGYHdfLSKwn4KxqjQDXNrv+b0pLBl+uwnLf2+D/t8E+LYGo3RpuDI1v1zhWK0bbP0AJv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QZnQDz9b36TsgB9c9MJyvWdQprrhPmacBd5Q7k2Gek=;
 b=CVABDymTYmTdr7srz8WoV59ozLocGYBW+ByZgwQmzhSKKrejlWaBUad48Vzx88A4lDtXQ+a1ifLpgry2Q2hkRPsPBrAx4WJYMPC/kza8wy8fEdnpE9zoakLAZI7d/QOybEwwR2ridsvA2RUF9LoaqDq4kK53sh6VCCRAkrHVdhmR2+s/FDCl2mjaQvSpsmB6sXWiYz/S1uWUzdDdX1xH3NqI0TRhKE6vRyP1jZUvEOzzsfmYLh/QrSrircBlLKfyHhPuGTGYBjZv2mb+xMf8jkWHp6939L4biV2h+Kq5GFUbTlgSxyw9D6/iKgknFn7huDsOcVCrXb8lx8hG2S6CYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QZnQDz9b36TsgB9c9MJyvWdQprrhPmacBd5Q7k2Gek=;
 b=ckNWgg8lB+hBCo3wt0RYL5ZThciUvchVueTpSY2yOJxrNgq+rZkP4cI5G8Mfq8uW/8wMUJSfEEq8NwaohUdS97vGiiDqjFhkiJu6LxCX9p3chNVyDJXqmXvZGjUN0nk3LWnNMUOrj7rjZavUvuDcKs5f32BTTbHfzamXgu6dI6c=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4703.eurprd08.prod.outlook.com (10.255.27.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 04:54:29 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 04:54:29 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
Subject: [PATCH 0/3] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH 0/3] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVd0sjIemk22GyqU+XOJLEc9v6FQ==
Date:   Mon, 30 Sep 2019 04:54:28 +0000
Message-ID: <20190930045408.8053-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 07a72c96-9935-4e37-43d3-08d745624eb9
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4703:|VE1PR08MB4703:|AM6PR08MB4135:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4135A8DB83B204FB501DF3B6B3820@AM6PR08MB4135.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;OLM:4502;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39850400004)(199004)(189003)(6116002)(3846002)(103116003)(966005)(26005)(36756003)(2201001)(256004)(305945005)(71200400001)(7736002)(6486002)(55236004)(102836004)(8676002)(81156014)(2501003)(52116002)(71190400001)(66946007)(6436002)(81166006)(14454004)(64756008)(2616005)(66476007)(66556008)(86362001)(66446008)(478600001)(99286004)(6506007)(386003)(6512007)(14444005)(66066001)(8936002)(1076003)(476003)(2906002)(6306002)(316002)(486006)(4326008)(50226002)(54906003)(5660300002)(186003)(110136005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4703;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tFynB+G3m5Q0A2lZdo+nFKCHdrPJhsISADP0rqiY6I1WlBjnEGLnbT7IsrfNfYyYutB0G1Dof2Apjq5ixKKyeV56LQkmXPmSq9FRERhzHlQiQY1JuhQTG23zob7xzX1IN6OLCw3YsYq1XbHJ8I6AwVlXWJtp5XqjiVv2p7SVFVrB5GoYWfrymd1+ozHV69Zd10zlLD9rstKBh3+PiZLfq14WE/BOYuNjqdMS4ViO2S+BQzZ2v7lC6ifUzQrlPodj5ZQlGsqeyQ9Gowc7f7yhFHlpy57kesObKyI/mx7F4y532ANDEHpCohNyjgE0dLMSsAQgw1+/B/iS4RBxZRenPH2RUioK6JZNiSxFitZldZTtjHpofonS1WnMilkVV0RVt0vsB6/TAB4GrXFiu41BxOX/tbYRHGKemQ8aCTT8ZoB5TK1NerMn3kpSbf+ZkzR1K3Up8YSiOYgK2kt9FrL8uA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4703
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39850400004)(346002)(136003)(189003)(199004)(6486002)(102836004)(99286004)(54906003)(110136005)(3846002)(36906005)(316002)(81166006)(81156014)(8676002)(36756003)(6116002)(8746002)(8936002)(26005)(50226002)(6512007)(6306002)(186003)(22756006)(4326008)(86362001)(2201001)(386003)(2906002)(14444005)(6506007)(356004)(336012)(47776003)(26826003)(66066001)(103116003)(126002)(70586007)(63350400001)(476003)(2616005)(50466002)(14454004)(25786009)(305945005)(7736002)(76130400001)(5660300002)(70206006)(2501003)(478600001)(966005)(23756003)(486006)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4135;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5c4fb2f3-95f3-42cf-de47-08d745624611
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +g3uZUc5OlEbSYkLxiOP/yFjYgPBxG7Fv85MSZIDmGKol+iNrdNvJq4a+dl7EE3cZBO6lJph/vcXUvIplDg9QCXM6ojS8yikuYtwXpFW8KczVN5+ao1z/U/ybKcWvmlBP2RhxZPqljQJldyw11wTLclTW4EfitMa+nCvnDNgyD/P2ftxtTX5TT4nCPfqLpZOfEZ70qiLf0rgEOTS4v8hkHN9A1rUBtaJWHzvGKGBS/63F8jjyBp6FJ702X7brxM8LrB8ZtZXjckNM2N1ObHDLKcvxfidPPbKYgMMXHWy6Y/SUTrIfozlUxYNrVceSYara1BLO/vHTmhboQQx2y+saxQp5ENMIyNGsETk7BmbAUEYJ8RLn47+EoranuQc381wMwuBBjlTOuq/DzAM96yEQkiVSLzZiOXGQLjrZa0VmC3aiACUizpPsj6sfVFfq5p2GUowA0XrmowGZ9+lRvePnA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 04:54:42.5560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a72c96-9935-4e37-43d3-08d745624eb9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4135
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

james qian wang (Arm Technology China) (2):
  drm/komeda: Add drm_lut_to_fgamma_coeffs()
  drm/komeda: Add drm_ctm_to_coeffs()

 .../arm/display/komeda/d71/d71_component.c    | 24 ++++++
 .../arm/display/komeda/komeda_color_mgmt.c    | 79 +++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    | 10 ++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    |  6 ++
 6 files changed, 123 insertions(+), 1 deletion(-)

--
2.20.1
