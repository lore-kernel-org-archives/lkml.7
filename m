Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E654C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF4520CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="zdLN6Ihj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfILLyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:54:41 -0400
Received: from mail-eopbgr150122.outbound.protection.outlook.com ([40.107.15.122]:44258
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730923AbfILLyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:54:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgYF2Ka3n393PhpS3GjdiaYCqzr6AiSZdq0TGI3u+WVty/bS/jsfgx8UzodH5J7y5bgykRkHQmtxviGcO4JIYi913VxbzKtAtdNowIDJY6jQmGUGNbx55h180ThgYX52uLNffX00bahMEQZy/sOrHG+r33yMCVsu1mYwjnMHI4ZQ7K+FJkCv2BDs0T8Qsd/mF8qp5ZFzpR2lGHVSm9ce7CcjXlro1ZhBaZk3dqZB8NRNfTsV9M8z/5gWu6/3Z6VHwasegRyHK1rTQ0HWBjJKW+QVsneh5Nnf6k9LWX5EUt+DvScnw4m/Htda7gprC0S0nAON1vwldZGRwfQJP+LiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TQA5TdfNB0yHd575pP95vTpgk3xGwDLnH4CnkUhJc0=;
 b=KLNufgISzhqigeR3uAFoVjfx6WLZoz7TUjEGI95Fu/+OvlMkRnV40auNQEYT+Zjzns9UIL5hefOvZyNzqBYmATtSeWOzc+7yeNi/0LJQNTPa9faj9y2kXvYRwMEu6PZpvxrCM7BIDj3yXcIAjoeZYv+WLYyNRZy3pWWb1s7lH9seJjpZvexk6Q44K1jDBP2Jz6FOtJ728w9/P+B7fvy+PvtJqzplbjwkZgFDEHdP/ISaZxmVsZy3XrkFWQQBRd9zBmxE8tmRDANMYqlR+i+exEQwQ6lcrjtEOOBXfYpVc1SyxKvXSRvR8NPFFr5Eu09iz3NBp/pr0nZJLBvrQMFSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TQA5TdfNB0yHd575pP95vTpgk3xGwDLnH4CnkUhJc0=;
 b=zdLN6Ihjc1UZWzGcs3TfO+FipdniYaRv5kq6pAjCJVsB2JaSh2TgKMpI3L4oG+I6kZ+8VOo9KBE8CnuhtsRcO1JnUXqeWbrGPF+NXw/033w2W9FmWr7wGoUOhA5hj7LrzLl92xBgHMO8JJpPV6bl7eyw2d5hTzUc2e2hmmSHwlU=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3660.eurprd07.prod.outlook.com (52.133.6.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.10; Thu, 12 Sep 2019 11:54:37 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::f58b:c1e9:48ca:9578]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::f58b:c1e9:48ca:9578%3]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 11:54:37 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: rseq selftests param_test.c gettid build failure
Thread-Topic: rseq selftests param_test.c gettid build failure
Thread-Index: AQHVaWDaXRX3v4Xsj0mL9y8q2kq2zA==
Date:   Thu, 12 Sep 2019 11:54:37 +0000
Message-ID: <8ee8ccd99f551b4ae78a6601f541c07948593c34.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caac8f31-f5b5-4f12-f657-08d73777fcd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3660;
x-ms-traffictypediagnostic: HE1PR0702MB3660:
x-microsoft-antispam-prvs: <HE1PR0702MB3660003CD5FAE8D974735B15B4B00@HE1PR0702MB3660.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(476003)(7736002)(66476007)(5660300002)(66946007)(36756003)(6436002)(256004)(14444005)(118296001)(6916009)(8676002)(486006)(305945005)(3846002)(6116002)(25786009)(66446008)(64756008)(4326008)(66556008)(76116006)(2616005)(102836004)(86362001)(26005)(71190400001)(4744005)(53936002)(71200400001)(186003)(6506007)(14454004)(81156014)(81166006)(2906002)(478600001)(8936002)(6486002)(2351001)(2501003)(6512007)(316002)(99286004)(5640700003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3660;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rz1GgmY7KPrssRsuJqcRVSV1QvfHaunyCXOEUJGePpuwaf+aO7TUZEfXXVL1VkySuqPaJGn6pyL1PrnsGFy+D6fx4LanOiCrB2j6O+1kOCVqjI+baJ39FketuMJmLYk/cbgoD/rEaUojfqcITAXTH+z6LGaXFglYKt5GFfRhNUbu9zZ4UBc0br5wMmBe5ZHKYDikEijBPkXO9OT8DHTS9urnYIhyqfG17pirwyVv0j2VmvIoVIeyAkaO8fAH1eVSq0vjP8kNfQre75yOXZ6auf/ujGb4rZd3vWbnJpjQ8uwpoSHKkHBIBFyWldVjUJ0q8MgBHecZBffG2NolVNYDvk3QSpTGW7EgEhJvm2F9vH/OcOASKvisQPUt4Z/pcBO0Cyq+0nEo2GP0HbD7zDy4/vshOVoPspLBYJEK53Rs4Bk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2055CAF23A8566419AFA445435212AAC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caac8f31-f5b5-4f12-f657-08d73777fcd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 11:54:37.6939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izY7m4f/WnROipJn8KW18yA30xIGMn8q6bQAZ/NkMhHUDWG7uMmL+DPV3LLC8rkTziWXbQe6HjEWsQYQXlc9qSw9nmTZ8caZRIbj3ilrrWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSwNCg0KSSdtIGdldHRpbmcgcnNlcSBzZWxmdGVzdCBidWlsZCBmYWlsdXJlIHdp
dGggZ2xpYmMgMi4zMCwgd2hpY2ggYWRkZWQNCmdldHRpZCgpOg0KDQpwYXJhbV90ZXN0LmM6MTg6
MjE6IGVycm9yOiBzdGF0aWMgZGVjbGFyYXRpb24gb2YgJ2dldHRpZCcgZm9sbG93cyBub24tDQpz
dGF0aWMgZGVjbGFyYXRpb24NCiAgIDE4IHwgc3RhdGljIGlubGluZSBwaWRfdCBnZXR0aWQodm9p
ZCkNCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICBefn5+fn4NCkluIGZpbGUgaW5jbHVkZWQg
ZnJvbSAvdXNyL2luY2x1ZGUvdW5pc3RkLmg6MTE3MCwNCiAgICAgICAgICAgICAgICAgZnJvbSBw
YXJhbV90ZXN0LmM6MTE6DQovdXNyL2luY2x1ZGUvYml0cy91bmlzdGRfZXh0Lmg6MzQ6MTY6IG5v
dGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mDQonZ2V0dGlkJyB3YXMgaGVyZQ0KICAgMzQgfCBl
eHRlcm4gX19waWRfdCBnZXR0aWQgKHZvaWQpIF9fVEhST1c7DQogICAgICB8ICAgICAgICAgICAg
ICAgIF5+fn5+fg0KDQpCUiwNClRvbW1pDQoNCg==
