Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B69C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289DA214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="PbEtgVq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfGVKpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:45:08 -0400
Received: from mail-eopbgr60117.outbound.protection.outlook.com ([40.107.6.117]:65377
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727547AbfGVKpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxhFxNDITqLYRrJ5dp+DU3M1fS6Ru33Fb5UZGvjYsF7z/Ql8rZgH67DeK4QQpucTuIAQx2TIjUfZxg6L0naFer0NIBYe4OSs/MpD5SU7zAmQWzSfiqijDK61YlJ4iJP9HlvmyDTlFWxXXhBYCQeVjosv8naOAn3yXtgpITcko27R6VfcTOjA/poOUpG+tjOIi+rR2NONDDdCyOux+aGWZR5KU+U5kvOcJM8CW/OjrUqhhchkK4jZL+QwYmy5IuEHj9QMQIoxRXOA6KrZXygOaQ9t8WHXWqPY580XMFNd+Q4FQFIiT0fWi/JqjKhKCd2mRR9mt8ri9qRZ1mqa5yJoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2RDRqdwzh9M14I3eyKusobMQClSpkc2/afzMtWWPnU=;
 b=I9WI2NeZmP4+7laD0ep/lElnb/Mub2H8KOVKpZIdEG60BBg7UWmQheiCeOmz8Qby5azrugEBzC9BizgFgEHjyHxtjyM6VyJTMnHuUxV3qBUepWxY1EWRo8qdAVvNTFi3rn9h26ZvQHumzIDq1u2eoCL5AuOLCj6ZGx3fRHU1L6wjFJvYUbbxaENU289OSJLt3wSo49s5cMlZZmN7qe2QG/0I9vlSaaWI6hxCBa4JcfzXzBe8KjIXCilTi5n8/BR0Iw2xCJU8hbDzhXF/tS85VNMP+OEIlObLDWT5o1t7Zl75JP/+zu1gtheYfIDsAjG8b/eZSJL3mmfSMid1S68yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2RDRqdwzh9M14I3eyKusobMQClSpkc2/afzMtWWPnU=;
 b=PbEtgVq7dcn38/W4oDiWpVhzRAQM3rDGbSrbso4xqAGQc5jYxlav4k+Vthk9cSc939saMVpJ08VZNqnsXU1VbEkTElcJIrHmkizSgmLzKcemzPzmXVMIsyTZfIWU358vdZCgXC21zBkDfoMBfPDuie1Rg5fsGFc9/uvQAry0BZg=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3384.eurprd02.prod.outlook.com (52.133.10.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 10:45:05 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 10:45:05 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: don't reset device when getting VRHOT
Thread-Topic: [PATCH] habanalabs: don't reset device when getting VRHOT
Thread-Index: AQHVP9By0qv0OAUKV0miseJmCNFhg6bWdSUw
Date:   Mon, 22 Jul 2019 10:45:04 +0000
Message-ID: <AM6PR0202MB3382A444B00EAA31585022DBB8C40@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190721142733.18513-1-oded.gabbay@gmail.com>
In-Reply-To: <20190721142733.18513-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddbd15a1-046e-430b-67d5-08d70e91a849
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3384;
x-ms-traffictypediagnostic: AM6PR0202MB3384:
x-microsoft-antispam-prvs: <AM6PR0202MB3384C19E8FB7CDB2832E2F09B8C40@AM6PR0202MB3384.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39840400004)(136003)(189003)(199004)(81166006)(14454004)(305945005)(4744005)(7696005)(99286004)(26005)(5660300002)(6246003)(446003)(53936002)(68736007)(7736002)(11346002)(2906002)(3846002)(6116002)(81156014)(55016002)(86362001)(8936002)(9686003)(76176011)(66556008)(66066001)(66446008)(64756008)(110136005)(256004)(6436002)(102836004)(25786009)(316002)(71190400001)(33656002)(71200400001)(4326008)(476003)(76116006)(66946007)(74316002)(186003)(66476007)(478600001)(52536014)(486006)(6636002)(229853002)(8676002)(2501003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3384;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dpL1MRnQDwm9fdOMMYTjq/GifY42wdVwz9Su+BlHD1Eg/xrxStJRAPyhp7xRQkYNFFgIjaui35HP893OPVh07Gi4toAlrGN0M2qFIGkpw1zgzSlpA31vqmWc9d4sKArv6s8jJdsVGu1vJPzAlHN5FBdbB2oc9lw2W4ATfw2ttFwSya5blOTLvFXSPkMy6yEuK0/FYPCb1/dTFmX/FVvCf4YjtmalRFxjbV3jF8Gyaz9P5SXh9I8yhbC6nRf3z560DgOuJpSjTReTKeIgdoH2iJ3TSsmt4TsG8gWtnLtkrraLeNYphx/uAPMa6RLybpF2Lq3k5ivOvlhSEGq03aPtWe9oRW3+l0ET7vpgPLB7GlQjs0uDz2rdLXhFIUst93XO0i3k1zyAWLwYgNw78jHYvVpSA8v+VA8jfxkEi9gwkJs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbd15a1-046e-430b-67d5-08d70e91a849
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 10:45:05.1684
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
MjEgSnVseSAyMDE5IDE3OjI4DQoNCj4gVlJIT1QgZXZlbnQgZnJvbSB0aGUgRi9XIGluZGljYXRl
cyB0aGUgZGV2aWNlIGhhcyByZWFjaGVkIGEgdGVtcGVyYXR1cmUNCj4gb2YNCj4gMTAwIENlbHNp
dXMgZGVncmVlcy4gSW4gdGhpcyBjYXNlLCB0aGUgZHJpdmVyIHNob3VsZCBvbmx5IHByaW50IHRo
aXMgaW5mb3JtYXRpb24NCj4gdG8gdGhlIGtlcm5lbCBsb2cuIFRoZSBkZXZpY2Ugd2lsbCBzaHV0
ZG93biBpdHNlbGYgYXV0b21hdGljYWxseSB3aGVuDQo+IHJlYWNoaW5nIDEyNSBkZWdyZWVzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdlbG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0K
