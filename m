Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E32C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7B92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="N+xv87vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF1CJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:09:55 -0400
Received: from mail-oln040092003077.outbound.protection.outlook.com ([40.92.3.77]:58697
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfF1CJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBSRqqR9+xYcdhKqjfZEDzZYFAbQ751VxdMxRtH9eZk=;
 b=N+xv87vsdxqMWlTq40Ct4AH+BDdJpuSv94kXO+abRIsCoqXR6xYFUe3bm+TMTCkGfyA1apmj88g98+8KjaJEENqoPGT5tmpGhkRsw0nGh1J/sP6mf1M6luxcunupH2PXaPvBEGH5l18QiIVxaHje3bM8IsFw/O6uAs34OutEvyyDQqg7FdVJ1GowFpwYJLS3tT1LBkLUm8efr/bFXZvJ1zdl00GLnsyKSWIBxNsRFUKpUw2mYGbNwMSQZ9I6GSFHui0x9ObbSRIK/cTuBdeGf/i7wMMdvXmoD3VPfPMCgk0g6VF6mnj7o7p9uqoh4T9jP1jY85ERdw3qoXEaLyxL+A==
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (10.152.76.51) by BL2NAM02HT069.eop-nam02.prod.protection.outlook.com
 (10.152.77.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Fri, 28 Jun
 2019 02:09:53 +0000
Received: from BYAPR02MB5704.namprd02.prod.outlook.com (10.152.76.56) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Fri, 28 Jun 2019 02:09:53 +0000
Received: from BYAPR02MB5704.namprd02.prod.outlook.com
 ([fe80::18b:f08e:21ff:fa35]) by BYAPR02MB5704.namprd02.prod.outlook.com
 ([fe80::18b:f08e:21ff:fa35%5]) with mapi id 15.20.2008.018; Fri, 28 Jun 2019
 02:09:53 +0000
From:   abhja kaanlani <unidef_rogue@live.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Effect of multidimensional arrays on the Linux kernel?
Thread-Topic: Effect of multidimensional arrays on the Linux kernel?
Thread-Index: AQHVLVaS54ldAhnrUki2ZSjI26pKcw==
Date:   Fri, 28 Jun 2019 02:09:53 +0000
Message-ID: <BYAPR02MB570463AFB1E4D5DDCB6FEA3983FC0@BYAPR02MB5704.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:73F462A6098777A76947967EE9FB2E945778A47BEA3AD5592B45FA1E0684B49D;UpperCasedChecksum:83460CAA3B7ABE2E85208B30251F91BE2284C914CAB6F6E62F5887918C2232E1;SizeAsReceived:6793;Count:41
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [OFfuDFYdGsuUSgM9wn3v5GBqwiTJvRxSBnS5IIWGzNBYRAh717PUMkYhSltWOVyt]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:BL2NAM02HT069;
x-ms-traffictypediagnostic: BL2NAM02HT069:
x-microsoft-antispam-message-info: k2Q0IhGN9y2EQsUalw9MbxQNCDfChhhtU1R28Wq9Cqa836Nl/x/lGGuGV0uqzJAtIwY3LubvIA2qwo3WfUMQTOHZR3ZBs3Yv++fm4IShLi5JZZFiNXkOA891SX1qTTiJ8ujjRjXc76FAyVj+TxLK8o5bQtc6XVNYiqUpcsGSTtqWCVH2etSJDoPlXVxEDAEv
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E5457B36459BB4E9007AD72486E7237@sct-15-20-1580-16-msonline-outlook-d54f3.templateTenant>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cee9a1-2b52-4ee2-27e8-08d6fb6db55e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 02:09:53.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW5zdGVhZCBvZiByZWFkaW5nIGJvb2tzIEkgZGVjaWRlZCB0byBzY3JldyBhcm91bmQgb24gdGhl
IGludGVybmV0IChzYWQgZmFjZSkgLCBJIGRvbuKAmXQga25vdyBtdWNoIGFib3V0IGtlcm5lbCBk
ZXZlbG9wbWVudCBidXQgSSBoYXZlIGJlZW4gd3JpdGluZyBpbiBDIGZvciBhYm91dCAxNSB5ZWFy
cw0KDQpCdXQgbGV04oCZcyBzYXkgeW91IGhhdmUgYSBkYXRhIHN0cnVjdHVyZSB0aGF0IGhvbGRz
IGluZm9ybWF0aW9uIGFib3V0IGEgaW8gc3RydWN0dXJlLCBhbmQgd2UgdGFrZSBpdCB0byAyIGFy
cmF5cyB0byAyIGRpbWVuc2lvbiwgbWFraW5nIGEgbWF0cmljZSBvciBzb21lIHNvcnQgb2YgZ3Jh
cGgNCg0KQSBmdW5jdGlvbiBvcmdhbml6ZXMgaXQgYnkgY2hhciAqZGVzY3JpcHRpb24sIGFuZCBh
biBJRCBzeXN0ZW0sIGxpa2UgUElEUywgSSBrbm93IGl04oCZbGwgY29uc3VtZSBhIGxvdCBvZiBy
YW0gYnV0IGl0IHByb3ZpZGVzIGEgbGF5ZXIgb2YgcGFyYWxsaXphdGlvbiwgYW5kIGNhbiBiZSB1
c2VkIGFzIGEgY2FjaGUNCg0KRG9lcyB0aGlzIHNvdW5kIHBsYXVzaWJsZT8NCg0KSSBoYXZlIHRv
IGdvIHJlYWQgdGhhdCBMaW51eCBrZXJuZWwgYm9vaywgbXkgaW50ZW50IHdhcyB0byByZXdyaXRl
IHRoZSBzY2hlZHVsZXIgc28gaGVyZSBJIGdvDQoNClRoYW5rIHlvdSBmb3IgcmVhZGluZw0KDQpV
bmlkZWYNCg0KU2VudCBmcm9tIG15IGlQaG9uZQ==
