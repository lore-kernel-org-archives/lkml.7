Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9E8C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8923E21841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Syv27cpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfGRGnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:43:00 -0400
Received: from mail-eopbgr80100.outbound.protection.outlook.com ([40.107.8.100]:35406
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfGRGm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzOwQSzhlL+tDMKp8DWc2COtNSxwkcnzj1j63c5I0aS8juGbYWNrNMpxKQaQpf45mnuvLMUFDkGtb8NXG2C8MFlfDtEVZMR2TsHqFb4UxYZrGNjgk72ygWiYzztFwhYS7fSz1kYWngzWMVQAGVRbOq399BR8JbwwzwGDxqlCZmV3MgOtbAetOawmohKObgZpOMHiskLCn2Oxhuk/z2JjD4kyt+MKBtTj/AK3ERXfCF6qKOkJRJXXZP9kOTByXr2vIG+n/qISpXQ0BsbgZBzpWYzSY7BuYuSfJV36m6uRO+28meUxcuDBc44ZCVr3HxrTgFhOBHyR3Kf87p39ikh18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tH4eJNjmuxkLQZ8WvfVcxitM8Q/CWLiZxfHfFxhngs=;
 b=aWlwDZL5eg7+GVxwJIvKDhxMDBSkn2mNg1si/xYmMhFWgj2297/o9FaAUMGu5GjlfGDR2zKiS7TjtWp4UI1wIV5BaEHbn4bYRftRXghwDh6V3jAFDGlW6+7zoDC1iVMuYcEYgbFOtTs8kRVYqZ0BCQgASst1dyR7T6f/8USGou43tdG0Aqkh+WMoDS1ibxjrHMtyb1FSKIoVjTN4/UjGR91337bNMNYjfzSW/UY2hErknLEwtkOzgh0N6r8lIvWTfayO4zd48QpUdcu9hc9t7XBHrMHZN+fKjIK2GkNosd/qaZlUgR//LZNVpbe4Xo4tdshUfIRMckj4Mm99WIYgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tH4eJNjmuxkLQZ8WvfVcxitM8Q/CWLiZxfHfFxhngs=;
 b=Syv27cpmfStTWf8k1I0UgFnx2Jw7sV3R/OtbBqgtEN9lM2nuY5oNXMcbv9m/zCQrevor5mMobhGzf6RVZqhTGGIH58s0TdJ4cMZqhb/ZrwTBHTNfZigZuES0Qx+B90sKITSjTJ5hqdW49oNmN/I3UsSqZiQuR1waq55bDDef7/s=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3541.eurprd02.prod.outlook.com (52.133.11.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Thu, 18 Jul 2019 06:42:56 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0%3]) with mapi id 15.20.2094.011; Thu, 18 Jul 2019
 06:42:55 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: add debug print when rejecting CS
Thread-Topic: [PATCH] habanalabs: add debug print when rejecting CS
Thread-Index: AQHVPTI5LE0qQt/MjkiqI5sFHoeq1KbP7Tfg
Date:   Thu, 18 Jul 2019 06:42:55 +0000
Message-ID: <AM6PR0202MB338230AEFAE3210F5F0B5E02B8C80@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190718062954.15283-1-oded.gabbay@gmail.com>
In-Reply-To: <20190718062954.15283-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6805f9ad-20a3-414c-fcf2-08d70b4b2a7f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR0202MB3541;
x-ms-traffictypediagnostic: AM6PR0202MB3541:
x-microsoft-antispam-prvs: <AM6PR0202MB35417EF48CF4CFF31645535FB8C80@AM6PR0202MB3541.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(136003)(396003)(346002)(189003)(199004)(66946007)(74316002)(305945005)(14454004)(5660300002)(66446008)(2906002)(11346002)(446003)(476003)(110136005)(6636002)(66556008)(7736002)(6246003)(486006)(86362001)(4326008)(66476007)(71190400001)(256004)(64756008)(66066001)(6116002)(3846002)(33656002)(52536014)(4744005)(186003)(99286004)(6506007)(68736007)(76176011)(53936002)(81156014)(8676002)(76116006)(8936002)(9686003)(81166006)(71200400001)(7696005)(55016002)(6436002)(25786009)(102836004)(229853002)(316002)(2501003)(26005)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3541;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jEPa0I4GsvjcjYt1aIBjkcTo0AlACRrAkMlmjSs8JWY+lA+zzWsETH/eJQ9v1v5VHheA/V2EJmch+LXN4P6M5F8pQTFeqWneqKCeQD3UKVQgRzBWraaEB+sMUnG20b45vpEMNE9cQpKZowYo9GsPLqMF0cxJKBczp7YV1bWyQe3QrRTQnNZam/FjEYSQF1opUhZYO332sr7CpPqvF/Pz3VdRBVZOv3JbQKcNO54t6aj4Whftcqk8/Rqc/W4GZsmYrCsBa5NzQl7G7JYz5d29X81g/TKXkpGJPuvDYCgfvBW6vFvg+NIIiwcMQlU44Am/LVyaHsu2jNYDEyTPqauQ+lbbPgoTGjTdmjwlIXX9YNCP37zFPvtp+O6MymMLncwkKQjYWQcFYNfNoPlbBl+wQadZTyln+jpmDtDAXKpCUlQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 6805f9ad-20a3-414c-fcf2-08d70b4b2a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 06:42:55.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oshpigelman@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3541
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NClNlbnQ6IFRodXJzZGF5
LCAxOCBKdWx5IDIwMTkgOTozMA0KDQo+IFdoZW4gcmVqZWN0aW5nIENTIGJlY2F1c2Ugb2YgdG9v
IG1hbnkgaW4tZmxpZ2h0IENTLCBwcmludCBhIGRlYnVnIG1lc3NhZ2UNCj4gYWJvdXQgaXQgYXMg
aXQgdXNlZnVsIHRvIGtub3cgd2hlbiB0aGUgdXNlciBpcyBkZWJ1Z2dpbmcgKGl0IGluZGljYXRl
cyBhIGJhY2stDQo+IHByZXNzdXJlIGZyb20gdGhlIGRyaXZlciBhcyB0aGUgZGV2aWNlIGlzIG5v
dCBmYXN0IGVub3VnaCB0byBjb25zdW1lIHRoZSBDUykNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9k
ZWQgR2FiYmF5IDxvZGVkLmdhYmJheUBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBPbWVyIFNo
cGlnZWxtYW4gPG9zaHBpZ2VsbWFuQGhhYmFuYS5haT4NCg==
