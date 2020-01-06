Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F9C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3FD20801
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=transsionglobal.onmicrosoft.com header.i=@transsionglobal.onmicrosoft.com header.b="E98B9ONH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgAFDAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:00:51 -0500
Received: from mail-eopbgr1310043.outbound.protection.outlook.com ([40.107.131.43]:1727
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727307AbgAFDAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:00:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BK5tv26q7ZbRKudgLyfcdxKRoeg3hPlufSdHprzF2twflUnJzu3ZM61mJq4QWi07OjU1IluteT8BcAxU9WimG3fnrlRkcQNn5U+J91ZNDMWADWSJcALypQvuedjEovG3SOrHSyjZm2Av5NMAnrYZLCHO2OeYEKYavgoU2SKXjENBd8rv0X9Ty0TI2mOlH8RO2gWonijFWInLF75Pomw1p6qW0sFEZ7s/YM9f6DTMaZ4ApAvJdCvlN6cohZBhruB8Zu28dDNJGHPZG7uDEn9Z81yvrOm/rS69JvNbWD8LRPtcv2Y/u39+7zKJp7NS3kKkM5bsRXYlZe0n7ykfw2A4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow9YkyvL7fJ/dUBHxKdNra01jd0Y/31cfYUX5m2Zapw=;
 b=FO/yY6Cn1t8D5068xpWaKcbGIEbYcFknlpW/H/rhdV5zYuFztB1dEH7eBNuPcnoeFUOQDRQMpiALB4kWwK+cl6I68K3ExKjUsD+iKtEYnq8lWdN9l2J+Gv3Iw/QLvq50XZXuZMOU0jB+HWRuM2fOgOhW9BVYESMaL6yfC7xZF/ioJgw806n3cRZqwKFKh6xu0yjJRtn1AuOxCBeWp7Z8UTxxaiolOzfuMC/2m+TeqTWpmxTyB1VcIIA85EHqDIpiEKSj0NZBMhyAtNaLUw7RuAWsKRedfvh7RfSE2ou5nSsIlNyUulfMaaqIDPnd/joGaKBlPn/oomqP5yU1eIG+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 27.115.63.14) smtp.rcpttodomain=kernel.org smtp.mailfrom=transsion.com;
 dmarc=none action=none header.from=transsion.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=transsionglobal.onmicrosoft.com;
 s=selector2-transsionglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow9YkyvL7fJ/dUBHxKdNra01jd0Y/31cfYUX5m2Zapw=;
 b=E98B9ONHAmKOlJbEVkEA9X4HZbKGeEZZ2v8BmLwvuv9V64AvM1eip72oStkoqaxxMuP+dHbQFlXLJi0EaZjnthJBTQxpM4f9MEfMt8K4Ww9CYEgVx+t2sMvwjg8GfZi2hUKVIlZwAvucFe3RV5Jwc8KeNsRudjSuXB/gtvDMMMI=
Received: from SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13) by
 SG2PR04MB3676.apcprd04.prod.outlook.com (2603:1096:4:96::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.14; Mon, 6 Jan 2020 03:00:43 +0000
Received: from PU1APC01FT056.eop-APC01.prod.protection.outlook.com
 (2a01:111:f400:7ebd::204) by SG2PR04CA0151.outlook.office365.com
 (2603:1096:4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend
 Transport; Mon, 6 Jan 2020 03:00:43 +0000
Authentication-Results: spf=fail (sender IP is 27.115.63.14)
 smtp.mailfrom=transsion.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=transsion.com;
Received-SPF: Fail (protection.outlook.com: domain of transsion.com does not
 designate 27.115.63.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=27.115.63.14; helo=mail.transsion.com;
Received: from mail.transsion.com (27.115.63.14) by
 PU1APC01FT056.mail.protection.outlook.com (10.152.253.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 03:00:42 +0000
Received: from SH-EXC-MX01.transsion.com (10.150.2.41) by
 SH-EXC-MX01.transsion.com (10.150.2.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 6 Jan 2020 11:00:31 +0800
Received: from SH-EXC-MX01.transsion.com ([fe80::a9c9:4b06:6245:846c]) by
 SH-EXC-MX01.transsion.com ([fe80::a9c9:4b06:6245:846c%13]) with mapi id
 15.01.1591.008; Mon, 6 Jan 2020 11:00:31 +0800
From:   =?utf-8?B?eGlhbnJvbmcuemhvdSjlkajlhYjojaMp?= 
        <xianrong.zhou@transsion.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        =?utf-8?B?aGFpemhvdS5zb25nKOWui+a1t+iInyk=?= 
        <haizhou.song@transsion.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        =?utf-8?B?d2FuYmluLndhbmco5rGq5LiH5paMKQ==?= 
        <wanbin.wang@transsion.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?eXVhbmppb25nLmdhbyjpq5jmuIrngq8p?= 
        <yuanjiong.gao@transsion.com>,
        =?utf-8?B?cnV4aWFuLmZlbmco5Yav5YSS5ai0KQ==?= 
        <ruxian.feng@transsion.com>, "agk@redhat.com" <agk@redhat.com>
Subject: Reply: [dm-devel] [PATCH] dm-verity: unnecessary data blocks that
 need not read hash blocks
Thread-Topic: Reply: [dm-devel] [PATCH] dm-verity: unnecessary data blocks
 that need not read hash blocks
Thread-Index: AdXEPSSOvdMQQOseTsKjLS6M4G5zpw==
Date:   Mon, 6 Jan 2020 03:00:30 +0000
Message-ID: <f6f161812916479bbe23ab7c8fe9ea32@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.150.151.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:27.115.63.14;IPV:;CTRY:CN;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(136003)(376002)(1110001)(339900001)(199004)(189003)(2906002)(85182001)(26005)(186003)(70586007)(2616005)(70206006)(24736004)(7696005)(8936002)(5660300002)(4326008)(36756003)(81156014)(108616005)(81166006)(426003)(356004)(86362001)(478600001)(316002)(336012)(54906003)(6916009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR04MB3676;H:mail.transsion.com;FPR:;SPF:Fail;LANG:en;PTR:mail.reallytek.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72fe767c-ca3c-4274-8861-08d792549e3b
X-MS-TrafficTypeDiagnostic: SG2PR04MB3676:
X-Microsoft-Antispam-PRVS: <SG2PR04MB367659E141A3DC661C4ACC05F83C0@SG2PR04MB3676.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0274272F87
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrEheryBj0w5d2THTtITcIEdlY1RmqXaBYmKN6L6Gf/kE8PZw+FRwv0TvTDeAm4sleqOvZ+sskDoh+6ept0jmlszV7nYHQh2TcRKvqqam6eIL/CARwx7BM7HStVmhh1JZXzaXvQwIOqCn5dR3pNzNfw9q/a+v5L8TQRY+itS9t01okN5nEBVYSUKJ/iK4sWOadVTpaETVpWtiDUhFZjtlBhRdlVlVUCepkOQzVc0OaPSOB4C5abw+fA6PDoEVsb3oXd6JJ0+kLI8Q9bLA8jhD651rgwt9mmWvGjOsbvIRX7iXtzGZKWjmBN7UAzr3YmPTA4T+YlrX86qAiGTqZDz2i9QfF6Hg2O1l3YX8zATvU5xRqZTNJKNrvvRvRdejsZKD0USCZLcma2YfkZ2pd4zZC+D9RyBl7Au2ERdJhENcg/wK4JceJiYeD0ZrcHERFTI
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 03:00:42.3552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fe767c-ca3c-4274-8861-08d792549e3b
X-MS-Exchange-CrossTenant-Id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2;Ip=[27.115.63.14];Helo=[mail.transsion.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBEZWMgMTYsIDIwMTkgYXQgMTA6NTA6MjZBTSAtMDgwMCwgRXJpYyBCaWdnZXJzIHdy
b3RlOg0KPiBPbiBNb24sIERlYyAxNiwgMjAxOSBhdCAwMjowMjozM0FNICswMDAwLCB4aWFucm9u
Zy56aG91KOWRqOWFiOiNoykgd3JvdGU6DQo+ID4gaGV5IEVyaWM6DQo+ID4gDQo+ID4gT24gV2Vk
LCBEZWMgMTEsIDIwMTkgYXQgMTE6MzI6NDBBTSArMDgwMCwgemhvdSB4aWFucm9uZyB3cm90ZToN
Cj4gPiA+IEZyb206ICJ4aWFucm9uZy56aG91IiA8eGlhbnJvbmcuemhvdUB0cmFuc3Npb24uY29t
Pg0KPiA+ID4gDQo+ID4gPiBJZiBjaGVja19hdF9tb3N0X29uY2UgZW5hYmxlZCwganVzdCBsaWtl
IHZlcml0eSB3b3JrIHRoZSANCj4gPiA+IHByZWZldGNoaW5nIHdvcmsgc2hvdWxkIGNoZWNrIGZv
ciBkYXRhIGJsb2NrIGJpdG1hcCBmaXJzdGx5IGJlZm9yZSANCj4gPiA+IHJlYWRpbmcgaGFzaCBi
bG9jayBhcyB3ZWxsLiBTa2lwIGJpdC1zZXQgZGF0YSBibG9ja3MgZnJvbSBib3RoIA0KPiA+ID4g
ZW5kcyBvZiBkYXRhIGJsb2NrIHJhbmdlIGJ5IHRlc3RpbmcgdGhlIHZhbGlkYXRlZCBiaXRtYXAu
IFRoaXMgY2FuIA0KPiA+ID4gcmVkdWNlIHRoZSBhbW91bnRzIG9mIGRhdGEgYmxvY2tzIHdoaWNo
IG5lZWQgdG8gcmVhZCBoYXNoIGJsb2Nrcy4NCj4gPiA+IA0KPiA+ID4gTGF1bmNoaW5nIDkxIGFw
cHMgZXZlcnkgMTVzIGFuZCByZXBlYXQgMjEgcm91bmRzIG9uIEFuZHJvaWQgUS4NCj4gPiA+IElu
IHByZWZldGNoaW5nIHdvcmsgd2UgY2FuIGxldCBvbmx5IDI2MDIvMzYwMzEyID0gMC43MiUgZGF0
YSANCj4gPiA+IGJsb2NrcyByZWFsbHkgbmVlZCB0byByZWFkIGhhc2ggYmxvY2tzLg0KPiA+ID4g
DQo+ID4gPiBCdXQgdGhlIHJlZHVjZWQgZGF0YSBibG9ja3MgcmFuZ2Ugd291bGQgYmUgZW5sYXJn
ZWQgYWdhaW4gYnkgDQo+ID4gPiBkbV92ZXJpdHlfcHJlZmV0Y2hfY2x1c3RlciBsYXRlci4NCj4g
PiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogeGlhbnJvbmcuemhvdSA8eGlhbnJvbmcuemhvdUB0
cmFuc3Npb24uY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogeXVhbmppb25nLmdhbyA8eXVhbmpp
b25nLmdhb0B0cmFuc3Npb24uY29tPg0KPiA+ID4gVGVzdGVkLWJ5OiBydXhpYW4uZmVuZyA8cnV4
aWFuLmZlbmdAdHJhbnNzaW9uLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbWQvZG0t
dmVyaXR5LXRhcmdldC5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21kL2RtLXZlcml0eS10YXJnZXQuYyANCj4gPiA+IGIvZHJpdmVycy9tZC9kbS12ZXJpdHktdGFy
Z2V0LmMgaW5kZXggNGZiMzNlNzU2MmM1Li43YjhlYjc1NGMwYjYNCj4gPiA+IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9tZC9kbS12ZXJpdHktdGFyZ2V0LmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvbWQvZG0tdmVyaXR5LXRhcmdldC5jDQo+ID4gPiBAQCAtNTgxLDYgKzU4MSwyMiBAQCBzdGF0
aWMgdm9pZCB2ZXJpdHlfcHJlZmV0Y2hfaW8oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+
ID4gIAlzdHJ1Y3QgZG1fdmVyaXR5ICp2ID0gcHctPnY7DQo+ID4gPiAgCWludCBpOw0KPiA+ID4g
IA0KPiA+ID4gKwlpZiAodi0+dmFsaWRhdGVkX2Jsb2Nrcykgew0KPiA+ID4gKwkJd2hpbGUgKHB3
LT5uX2Jsb2Nrcykgew0KPiA+ID4gKwkJCWlmICh1bmxpa2VseSghdGVzdF9iaXQocHctPmJsb2Nr
LCB2LT52YWxpZGF0ZWRfYmxvY2tzKSkpDQo+ID4gPiArCQkJCWJyZWFrOw0KPiA+ID4gKwkJCXB3
LT5ibG9jaysrOw0KPiA+ID4gKwkJCXB3LT5uX2Jsb2Nrcy0tOw0KPiA+ID4gKwkJfQ0KPiA+ID4g
KwkJd2hpbGUgKHB3LT5uX2Jsb2Nrcykgew0KPiA+ID4gKwkJCWlmICh1bmxpa2VseSghdGVzdF9i
aXQocHctPmJsb2NrICsgcHctPm5fYmxvY2tzIC0gMSwNCj4gPiA+ICsJCQkJdi0+dmFsaWRhdGVk
X2Jsb2NrcykpKQ0KPiA+ID4gKwkJCQlicmVhazsNCj4gPiA+ICsJCQlwdy0+bl9ibG9ja3MtLTsN
Cj4gPiA+ICsJCX0NCj4gPiA+ICsJCWlmICghcHctPm5fYmxvY2tzKQ0KPiA+ID4gKwkJCXJldHVy
bjsNCj4gPiA+ICsJfQ0KPiA+IA0KPiA+IFRoaXMgaXMgYSBnb29kIGlkZWEsIGJ1dCBzaG91bGRu
J3QgdGhpcyBsb2dpYyBnbyBpbg0KPiA+IHZlcml0eV9zdWJtaXRfcHJlZmV0Y2goKSBwcmlvciB0
byB0aGUgc3RydWN0IGRtX3Zlcml0eV9wcmVmZXRjaF93b3JrIA0KPiA+IGJlaW5nIGFsbG9jYXRl
ZD8gIFRoZW4gaWYgbm8gcHJlZmVjaGluZyBpcyBuZWVkZWQsIGFsbG9jYXRpbmcgYW5kIA0KPiA+
IHNjaGVkdWxpbmcgdGhlIHdvcmsgb2JqZWN0IGNhbiBiZSBza2lwcGVkLg0KPiA+IA0KPiA+IEVy
aWMsIERvIHlvdSBtZWFuIGl0IGlzIG1vcmUgc3VpdGFibGUgaW4gZG1fYnVmaW9fcHJlZmV0Y2gg
d2hpY2ggaXMgDQo+ID4gY2FsbGVkIG9uIGRpZmZlcmVudCBwYXRocyBldmVuIHRob3VnaCBwcmVm
ZWNoaW5nIGlzIGRpc2FibGVkID8NCj4gPiANCj4gDQo+IE5vLCBJJ20gdGFsa2luZyBhYm91dCB2
ZXJpdHlfc3VibWl0X3ByZWZldGNoKCkuICANCj4gdmVyaXR5X3N1Ym1pdF9wcmVmZXRjaCgpIGFs
bG9jYXRlcyBhbmQgc2NoZWR1bGVzIGEgd29yayBvYmplY3QsIHdoaWNoIGV4ZWN1dGVzIHZlcml0
eV9wcmVmZXRjaF9pbygpLg0KPiBJZiBhbGwgZGF0YSBibG9ja3MgaW4gdGhlIEkvTyByZXF1ZXN0
IHdlcmUgYWxyZWFkeSB2YWxpZGF0ZWQsIHRoZXJlJ3MgDQo+IG5vIG5lZWQgdG8gYWxsb2NhdGUg
YW5kIHNjaGVkdWxlIHRoZSBwcmVmZXRjaCB3b3JrLg0KPiANCj4gLSBFcmljDQo+IA0KDQpVbmRl
cnN0YW5kLiBUaGFua3MuDQoNCkFyZSB5b3UgcGxhbm5pbmcgdG8gc2VuZCBhIG5ldyB2ZXJzaW9u
IG9mIHRoaXMgcGF0Y2g/DQoNCi0gRXJpYw0KDQpTb3JyeSBmb3IgZGVsYXlpbmcuDQoNClllcywg
c28gSSBzaG91bGQgbW92ZSB0aGUgbW9kaWZpY2F0aW9uIGludG8gdmVyaXR5X3N1Ym1pdF9wcmVm
ZXRjaCBhbmQgcGxhY2UgaXQgYmVmb3JlIGttYWxsb2Mgd29yayBvYmplY3QuIElzIGl0IG9rPw0K
