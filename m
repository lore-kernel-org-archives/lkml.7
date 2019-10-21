Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A564BCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D48920684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfJUJ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:27:44 -0400
Received: from mail-oln040092072056.outbound.protection.outlook.com ([40.92.72.56]:45220
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbfJUJ1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:27:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfW6pZ0bOzQbnzEgAb4uRf6pysgC/JDjqt3HAWJJM1aZ4cibuw3WlWIwGMV2d9Lwp/ROZo6SjrhUwHtrLSKR6Sy3YXGlM7W8V4ZuYJbY00UJXAgbTemx/fj9tuoV6C3FIm1+L5mIY8sJpZdvH2W3zxGY28pUi0rxlVw0CwuotIOtQEjXgb96a8s31ST23ghBRPoU7P8/egNvQmV2O/zwMy+BzDgZiud0HOle8m4TeHtwRgdC/VYmiS2PUHAQOryjlVnlEZhP4/9tpkooWS528iIojvo9ekvZJwnUZgLP0yhsimzG6vLvbqwR3JfmeEFcq7Afii5IXwsnqJMZGAKr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtPBMVbNftpZ6nUBrO+yrTcVHgHF410VY1DVy4ffhOw=;
 b=eaDIoNzdfK570ViCIqkO35CsYYYPFghAPQjw2f+K7kh895dnUX8cJYLXqtH87CaGyh+Iq3T2u52zHfwN0emcKq6O6G+KVnzJ0l2dzJ19/z9Tnw+GdTJ8tVX4DDmRbWca1+dLMRE2nFGxTRPLGW+YgiGwpQoapx7EDfMxFsdIgp5GazHHCYP0JCj1NlLG9hLnZwejqdgU7T8rwcwnTuqLMHd9stXitW+TufzunoGiHXZBWl6eguqM/W+gfA9bUi5SOTK0gKRHwSaxAcVTveOcBknUfr45Q2u+Q95Dp7kZLbqBAgfsY0ZOhJacLg/kc06ZkB2F/d+jY7UQVbS88ifacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (10.152.18.55) by VE1EUR03HT097.eop-EUR03.prod.protection.outlook.com
 (10.152.19.239) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15; Mon, 21 Oct
 2019 09:27:37 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com (10.152.18.56) by
 VE1EUR03FT047.mail.protection.outlook.com (10.152.19.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 09:27:37 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247]) by AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247%6]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 09:27:37 +0000
From:   Anatol Belski <weltling@outlook.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     "trivial@kernel.org" <trivial@kernel.org>
Subject: [PATCH v2] include/linux/byteorder/generic.h: fix signed/unsigned
 warnings
Thread-Topic: [PATCH v2] include/linux/byteorder/generic.h: fix
 signed/unsigned warnings
Thread-Index: AQHVh/HGZiHBTV97akWCLD86HLHkVQ==
Date:   Mon, 21 Oct 2019 09:27:37 +0000
Message-ID: <AM0PR0502MB366860AC878296E4E76DD223BA690@AM0PR0502MB3668.eurprd05.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: AM0PR0102CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::17) To AM0PR0502MB3668.eurprd05.prod.outlook.com
 (2603:10a6:208:19::11)
x-incomingtopheadermarker: OriginalChecksum:D877EF1D7642353E7A5376CACCB83A1A749BEF284F9F426F6843A6327A7064B1;UpperCasedChecksum:BD5A14791A0064EE7CA12312656A7CC609BC9D97CE5D59E656B759AA024CB47E;SizeAsReceived:7713;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [VLKDOylrRR8tgRlBHoPx4w1BW6R0bzr/]
x-microsoft-original-message-id: <20191021092721.27020-1-weltling@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: VE1EUR03HT097:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8AMtglFxlF9F9etE6CP8MZsMcui8zkfKEW+JvTuvOyWwJrvUXnp5savLPCAyiXNiBEEQK1aBCutyTz+kThvm1JusS0QOWY4k+JPIUqIL+W7jRHDGRpM2md3rXlQUUlwWCUrLMWhuNu7kVYQCMzx572g/VrnWK6z8KX0kxLVfysShq3HP4TNnSDUi6TvgtGU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA878AA040B43A449EB1849082732CF6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bbe7d8-9e92-4a61-ed3f-08d75608e8f8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 09:27:37.0376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5hdG9sIEJlbHNraSA8YW5iZWxza2lAbWljcm9zb2Z0LmNvbT4NCg0KVGhpcyBmaXhl
cyB0aGUgd2FybmluZ3MgbGlrZSBiZWxvdywgdGhyb3duIGJ5IEdDQw0KDQp3YXJuaW5nOiBjb21w
YXJpc29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IFwN
CuKAmGludOKAmSBhbmQg4oCYc2l6ZV904oCZIHtha2Eg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJl9
IFstV3NpZ24tY29tcGFyZV0NCiAgMTk1IHwgIGZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykNCiAg
ICAgIHwgICAgICAgICAgICAgICAgXg0KDQpTaWduZWQtb2ZmLWJ5OiBBbmF0b2wgQmVsc2tpIDxh
bmJlbHNraUBtaWNyb3NvZnQuY29tPg0KLS0tDQogaW5jbHVkZS9saW51eC9ieXRlb3JkZXIvZ2Vu
ZXJpYy5oIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYnl0ZW9yZGVyL2dlbmVyaWMu
aCBiL2luY2x1ZGUvbGludXgvYnl0ZW9yZGVyL2dlbmVyaWMuaA0KaW5kZXggNGIxM2UwYTNlMTVi
Li5jOWE0Yzk2Yzk5NDMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2J5dGVvcmRlci9nZW5l
cmljLmgNCisrKyBiL2luY2x1ZGUvbGludXgvYnl0ZW9yZGVyL2dlbmVyaWMuaA0KQEAgLTE5MCw3
ICsxOTAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYmU2NF9hZGRfY3B1KF9fYmU2NCAqdmFyLCB1
NjQgdmFsKQ0KIA0KIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfdG9fYmUzMl9hcnJheShfX2JlMzIg
KmRzdCwgY29uc3QgdTMyICpzcmMsIHNpemVfdCBsZW4pDQogew0KLQlpbnQgaTsNCisJc2l6ZV90
IGk7DQogDQogCWZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykNCiAJCWRzdFtpXSA9IGNwdV90b19i
ZTMyKHNyY1tpXSk7DQpAQCAtMTk4LDcgKzE5OCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVf
dG9fYmUzMl9hcnJheShfX2JlMzIgKmRzdCwgY29uc3QgdTMyICpzcmMsIHNpemVfdCBsZW4pDQog
DQogc3RhdGljIGlubGluZSB2b2lkIGJlMzJfdG9fY3B1X2FycmF5KHUzMiAqZHN0LCBjb25zdCBf
X2JlMzIgKnNyYywgc2l6ZV90IGxlbikNCiB7DQotCWludCBpOw0KKwlzaXplX3QgaTsNCiANCiAJ
Zm9yIChpID0gMDsgaSA8IGxlbjsgaSsrKQ0KIAkJZHN0W2ldID0gYmUzMl90b19jcHUoc3JjW2ld
KTsNCi0tIA0KMi4yMC4xDQoNCg==
