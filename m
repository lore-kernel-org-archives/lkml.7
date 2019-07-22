Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7160EC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE02214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="hu00z936"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfGVKr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:47:59 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com ([40.107.6.93]:35719
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbfGVKr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:47:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D54YGq/tiEcs/+cYXMNzadzrOsdNDdViTPHWx5Z56RKpQ6LSDLvvV1maTPCUzGY/bDBw6UnqI8BhQTiawMFqo49b8uhjLbOBECa7DTa4MpCKIjOaCVaebhAXj5Hi6PzKRrNsYEd5PxpWQU9CUCWa3LBkEml8ZKYXI/45vmDyceartHVLYj68gnNv6k/j1ap+L5wcIBol9dMBzyz48b8t/V/oEPrxcdeFgTT9+hcg0Fx7TqwHUZzo/PrV/8/k0m98cIQXP2kQQPKjeZhoouudkq3QR7CxJmFGMc/vyMJx47NwMtJ6spm0bz2sdp+T4g6P63KD4W+cX4fA3cRUJsCeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sck/LJ1/3rzr5OMCa4dsg5GVJ0QsIbTlBN3M3sW41zI=;
 b=aIayjzcNMt06g3x0lxFGMHQQYTwAIe6CUedsqtupgVdnIoWc4FrJDaNUfjxozWypcWsye252X37+CPqevC/4HG6mT6hwME5RQFPqjHM2shKaQkZKFTS4O9C3bbF4tbpd/MkbcIg2OCwGfweSrlAnZMrQCG8Sb/ZOQUo3CgqO7i8pqqLIY6ZbyVtKDIdT+MXqm9r6HqVFbuYLJXfXRwbhRu5r5Bdwz+5D7hoDtKFTW6DhgVauY7HRGSoPjjtt4+uVXujD4lyJJwa3eH//VnEurDdcCO94I1nirUw9rs138l8LUdhh8OU5ZnrAl3BVkBCtW97nhoyfAtLynubt67oBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sck/LJ1/3rzr5OMCa4dsg5GVJ0QsIbTlBN3M3sW41zI=;
 b=hu00z93654wL4SdX3wpQ2sgjPTSpy7hrm5qseOQn1F+xSswtbG8PxTU/qysoXjkcaQURAPuKVD0wadTNymSpmjTKbrR+w4akSVtwgbv+hm4M52laeCoEmPjeQ+AqTgOjby58YB5NByuHr62ZGDlchSlhvDrbxus+KIExnmT+1lw=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3384.eurprd02.prod.outlook.com (52.133.10.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 10:47:55 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 10:47:55 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: power management through sysfs is only for
 GOYA
Thread-Topic: [PATCH] habanalabs: power management through sysfs is only for
 GOYA
Thread-Index: AQHVP9D1WzGQCbu9O0C5efLr3hBsn6bWde3w
Date:   Mon, 22 Jul 2019 10:47:55 +0000
Message-ID: <AM6PR0202MB3382F4DA9AB3B471AB248E99B8C40@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190721143112.26273-1-oded.gabbay@gmail.com>
In-Reply-To: <20190721143112.26273-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbf063d7-81f5-419c-2da9-08d70e920dfa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3384;
x-ms-traffictypediagnostic: AM6PR0202MB3384:
x-microsoft-antispam-prvs: <AM6PR0202MB3384FD304F980F322A754DCEB8C40@AM6PR0202MB3384.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39840400004)(136003)(189003)(199004)(81166006)(14454004)(305945005)(4744005)(7696005)(99286004)(26005)(5660300002)(6246003)(446003)(53936002)(68736007)(7736002)(11346002)(2906002)(3846002)(6116002)(81156014)(55016002)(86362001)(8936002)(9686003)(76176011)(66556008)(66066001)(66446008)(64756008)(110136005)(256004)(6436002)(102836004)(25786009)(316002)(71190400001)(33656002)(71200400001)(4326008)(476003)(76116006)(66946007)(74316002)(186003)(66476007)(478600001)(52536014)(486006)(6636002)(229853002)(8676002)(2501003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3384;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xGyGMVmiIWk4ik7Gl85U9VaBSGVqQXx1ebtbEg2lXyizJsSVkPWljBQuFLFCR04HKx/ihCB1cNwNil5UKKgIORmuFFePiY+wfpvEAEt7jlROEsuQMal2mqu7IHMMQ9YjLVlRTw4N806EM/6ltj4NUDj1vNWIY3U8rOAGZVdmPdpjC2JtZ6YgglRaZigzcrw83GoGV5aFllBXdoXqW1f88cQPGBRdpZ/zkisc2OtvEfhVRynmc/JcEorrTygFD3ZXkDA4bNEi2j5t7b2mV+tOYlx47Lb2mA1kcN1DrLzxa2CD88seLmijcWNupD0ipfO38bOSph9OVfIASR3gGvSYFVOd96mBo5tMzWY5HoND/FydgHIZaDQyux+tm3krVe8RoICAhRo5z96goR9IPHCoPrCJ2yldaTiYBcfwclDmukM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf063d7-81f5-419c-2da9-08d70e920dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 10:47:55.7948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oshpigelman@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NClNlbnQ6IFN1bmRheSwg
MjEgSnVseSAyMDE5IDE3OjMxDQoNCj4gVGhlIGFiaWxpdHkgb2Ygc2V0dGluZyBwb3dlciBtYW5h
Z2VtZW50IHByb3BlcnRpZXMgYnkgdGhlIHN5c3RlbQ0KPiBhZG1pbmlzdHJhdG9yICh0aHJvdWdo
IHN5c2ZzIHByb3BlcnRpZXMpIGlzIG9ubHkgcmVsZXZhbnQgZm9yIHRoZSBHT1lBIEFTSUMuDQo+
IFRoZXJlZm9yZSwgbW92ZSB0aGUgcmVsZXZhbnQgc3lzZnMgcHJvcGVydGllcyB0byB0aGUgR09Z
QSBzeXNmcyBzcGVjaWZpYyBmaWxlLA0KPiB0byBtYWtlIHRoZSBwcm9wZXJ0aWVzIGFwcGVhciBp
biBzeXNmcyBvbmx5IGZvciBHT1lBIGNhcmRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2RlZCBH
YWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdl
bG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0KDQoNCg==
