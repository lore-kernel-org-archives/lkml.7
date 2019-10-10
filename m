Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13BEECE596
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D519208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbfJJKFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:05:34 -0400
Received: from mail-oln040092254024.outbound.protection.outlook.com ([40.92.254.24]:52512
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbfJJKFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8PCD5pAgBwumDjj1+jRMDOjzg60UixqazE9wILyefXbCeR8YAd8Qa8P53zxL18uo3AK24UM5yKGJc691J7W7XC4Sael68PabmLTl4UyGSVW1E9uQPNd+KokO9GEargdOShzSBd86NtxjFrypbncXzCXivCmgMOO3otTNznf/3EUApAhw18AKerA9Ki8Jq57rBT3zeu8LYWW2+b9R9wCAYB7y/eQ9Hfj6aQ5Ok3TJX754f0rlWyQZxyi1ad5HT7xD2sflqN2jYjJ90AiCKL05LCSLIWYOVXrjOM6TGCK4K7BGZh12gi1gHg3l1rmwbIkdw7dYakbgWsnI/L4HLbAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBY2rfU8x9GsavKykbvD8V4U/4HYxMPm4BM6oY8OhvA=;
 b=FDByV2gZhDP7kFCh0RK+WpM0Q0sJoPAzH6+C8rixrmoMGbjMPeF7IpBEEXywMakI61e91Hp8CCuFPM7+LFi+xIZIqmDAriCq8rsqZ9OYhqrceZOyKFzX3YGybdxEkCxLwJjiQ92bTSCCAHQNmWyybwW9IuGFMYv3WKofx8zv90lw7GtROLG1tkyQZrH3y0+xM/v8c4QMhz8UqGtRJ/81H+bf0n8ycs97Rn/ARw4TMwztZlH4qx81NhB/dRjBoXM5xlA7hBVCCJqcQRulHHBuwbAid/5Sn8CWtm+pU2FE9IlyMIJOhoTZOBOhJpIPIx0PFsCyhTCHJuRVoXTzkpBpkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (10.152.252.52) by PU1APC01HT079.eop-APC01.prod.protection.outlook.com
 (10.152.253.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16; Thu, 10 Oct
 2019 10:05:29 +0000
Received: from HK0PR02MB3780.apcprd02.prod.outlook.com (10.152.252.53) by
 PU1APC01FT018.mail.protection.outlook.com (10.152.253.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2347.16 via Frontend Transport; Thu, 10 Oct 2019 10:05:29 +0000
Received: from HK0PR02MB3780.apcprd02.prod.outlook.com
 ([fe80::78bb:a204:42e6:79b6]) by HK0PR02MB3780.apcprd02.prod.outlook.com
 ([fe80::78bb:a204:42e6:79b6%5]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 10:05:29 +0000
From:   Changwei Ge <gechangwei@live.cn>
To:     Joseph Qi <jiangqi903@gmail.com>,
        Chengguang Xu <cgxu519@mykernel.net>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ocfs2-devel] (RESEND) [PATCH] ocfs2: Fix error handling in
 ocfs2_setattr()
Thread-Topic: [Ocfs2-devel] (RESEND) [PATCH] ocfs2: Fix error handling in
 ocfs2_setattr()
Thread-Index: AQHVf1I++66a7ohIKEiKgMqm5O1YeA==
Date:   Thu, 10 Oct 2019 10:05:29 +0000
Message-ID: <HK0PR02MB378041C674F12FF50C672E05D5940@HK0PR02MB3780.apcprd02.prod.outlook.com>
References: <20191010082349.1134-1-cgxu519@mykernel.net>
 <6c6a49dd-f1e6-da3e-8481-071071c91b06@gmail.com>
In-Reply-To: <6c6a49dd-f1e6-da3e-8481-071071c91b06@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To HK0PR02MB3780.apcprd02.prod.outlook.com
 (2603:1096:203:9c::13)
x-incomingtopheadermarker: OriginalChecksum:9F2361EE09C3BE8F106668549F87DC853608D4FEA88B749C8A51A22971D9FB22;UpperCasedChecksum:86B03895905B99D4E1F63EB94055C2F4C98B234E1B314D308F69234A3613E5E4;SizeAsReceived:7698;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [tvYIOP+x9RmqPP5MxDwuOc58YwSsrd6Q]
x-microsoft-original-message-id: <4a1af4ab-6281-d734-86eb-0c147cb33965@live.cn>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT079:
x-ms-exchange-purlcount: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYSxyP6fCn9TAk9F6r0lQyMQcNsrErxJx3dZAgeDgovws963TrJtCk0hNlWzrjaFP96zSbixeWrxD/tKyZxPDcFvAZ+8l1jngeICV6bk875N1LUEqdgzaZ4lW1uKSaQtvvf52U03xplA8p12Ov/1740Y2m8LstN7JZwCR0lXlvMDn1ewl6R8k6Vkb9ZSTfbr8P2lIluDT99T1tcabX/IxN8ekQoH6NKx1p1IuLsMmMo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2836B9B33A988544AEBDC5735556471E@apcprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcbf8e8-ede6-4b8c-8009-08d74d696121
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 10:05:29.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDE5LzEwLzEwIDQ6NDkg5LiL5Y2ILCBKb3NlcGggUWkgd3JvdGU6DQo+DQo+IE9uIDE5
LzEwLzEwIDE2OjIzLCBDaGVuZ2d1YW5nIFh1IHdyb3RlOg0KPj4gU2hvdWxkIHNldCB0cmFuc2Zl
cl90b1tVU1JRVU9UQS9HUlBRVU9UQV0gdG8gTlVMTA0KPj4gb24gZXJyb3IgY2FzZSBiZWZvcmUg
anVtcCB0byBkbyBkcXB1dCgpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoZW5nZ3VhbmcgWHUg
PGNneHU1MTlAbXlrZXJuZWwubmV0Pg0KPiBMb29rcyBnb29kLg0KPg0KPiBSZXZpZXdlZC1ieTog
Sm9zZXBoIFFpIDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb20+DQoNCg0KQWxzbyBsb29rcyBz
YW5lIHRvIG1lDQoNClJldmlld2VkLWJ5OiBDaGFuZ3dlaSBHZSA8Y2hnZUBsaW51eC5hbGliYWJh
LmNvbT4NCg0KDQoNCj4+IC0tLQ0KPj4gICBmcy9vY2ZzMi9maWxlLmMgfCAyICsrDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvb2Nm
czIvZmlsZS5jIGIvZnMvb2NmczIvZmlsZS5jDQo+PiBpbmRleCAyZTk4MmRiM2UxYWUuLjUzOTM5
YmY5ZDdkMiAxMDA2NDQNCj4+IC0tLSBhL2ZzL29jZnMyL2ZpbGUuYw0KPj4gKysrIGIvZnMvb2Nm
czIvZmlsZS5jDQo+PiBAQCAtMTIzMCw2ICsxMjMwLDcgQEAgaW50IG9jZnMyX3NldGF0dHIoc3Ry
dWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgaWF0dHIgKmF0dHIpDQo+PiAgIAkJCXRyYW5zZmVy
X3RvW1VTUlFVT1RBXSA9IGRxZ2V0KHNiLCBtYWtlX2txaWRfdWlkKGF0dHItPmlhX3VpZCkpOw0K
Pj4gICAJCQlpZiAoSVNfRVJSKHRyYW5zZmVyX3RvW1VTUlFVT1RBXSkpIHsNCj4+ICAgCQkJCXN0
YXR1cyA9IFBUUl9FUlIodHJhbnNmZXJfdG9bVVNSUVVPVEFdKTsNCj4+ICsJCQkJdHJhbnNmZXJf
dG9bVVNSUVVPVEFdID0gTlVMTDsNCj4+ICAgCQkJCWdvdG8gYmFpbF91bmxvY2s7DQo+PiAgIAkJ
CX0NCj4+ICAgCQl9DQo+PiBAQCAtMTIzOSw2ICsxMjQwLDcgQEAgaW50IG9jZnMyX3NldGF0dHIo
c3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgaWF0dHIgKmF0dHIpDQo+PiAgIAkJCXRyYW5z
ZmVyX3RvW0dSUFFVT1RBXSA9IGRxZ2V0KHNiLCBtYWtlX2txaWRfZ2lkKGF0dHItPmlhX2dpZCkp
Ow0KPj4gICAJCQlpZiAoSVNfRVJSKHRyYW5zZmVyX3RvW0dSUFFVT1RBXSkpIHsNCj4+ICAgCQkJ
CXN0YXR1cyA9IFBUUl9FUlIodHJhbnNmZXJfdG9bR1JQUVVPVEFdKTsNCj4+ICsJCQkJdHJhbnNm
ZXJfdG9bR1JQUVVPVEFdID0gTlVMTDsNCj4+ICAgCQkJCWdvdG8gYmFpbF91bmxvY2s7DQo+PiAg
IAkJCX0NCj4+ICAgCQl9DQo+Pg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBPY2ZzMi1kZXZlbCBtYWlsaW5nIGxpc3QNCj4gT2NmczItZGV2ZWxA
b3NzLm9yYWNsZS5jb20NCj4gaHR0cHM6Ly9vc3Mub3JhY2xlLmNvbS9tYWlsbWFuL2xpc3RpbmZv
L29jZnMyLWRldmVsDQo=
