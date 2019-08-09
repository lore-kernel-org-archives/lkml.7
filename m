Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53326C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C0D20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405969AbfHIIjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:39:02 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:37974 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbfHIIjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:39:01 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP
 FOR linux-kernel@vger.kernel.org;
 Fri,  9 Aug 2019 08:38:50 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 9 Aug 2019 08:19:49 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 9 Aug 2019 08:19:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQdT8j14iZjWkrZsbRmXC3UVnCTtACb1LKWsisOhnIJITLQNpwZlZ6nXo4WnYdozqs9OGKxrl38YdNiV3ar+83m/KS/7WP0LxRHa0RAWUjn4aPfwgSUCMJHEcghLuXbZPj0t8G2cP4cs7BWf67Acv/rfodnqVdKwajyxojV2MiVW7RDaXetHitJgbwGX4u1AFWdCaMnuOebCv+gFmTub777zmC3i/q80k33US+fvtvJ6y9qyxL10tC0iSdAGudXdWr4SCBcb2GKCHr+KnEkr+++7H5x4xEXn7DVIQyx4E0mVJ6Bo5zAHZQfEHcy+u3YNGWecaDu+8yAGltf9z3smfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t3S9EoXANLa3sTN1u+QyIZuNBhMgaMyKkJXMS4arqM=;
 b=gueGz6PUXM8svRaqPbEN2P3mD7jKppxh4q6JKxvxlaNzoMHnmI42t01Rm9JUr7S3FO8iw4HDhanj+mIoQHUeBMsfklcfY0ocCYA5zKCoT5FCggywpN6r7++ex0q2mS0HtzyHPTF+5JaluCSuyTMXWu+fq4wX7YUZhPvVguCBXyzZKrlj+igLe4SYyYssgsa7yRtbjmd+X47Z2LFXbHHywoRqGfivImbr18RrIuAF/A5LaIg7B3CLVQQEQQAoEzNQd1zAXmXFOZaDvuhruslPuNk5K71pWz/aJ2vBV5qyIUo+ZlsfQa+qab6C7ibDhd021YoTArc7jUEwuYdv5prVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3349.namprd18.prod.outlook.com (52.132.246.91) by
 CH2PR18MB3350.namprd18.prod.outlook.com (52.132.247.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Fri, 9 Aug 2019 08:19:48 +0000
Received: from CH2PR18MB3349.namprd18.prod.outlook.com
 ([fe80::8818:7a86:93d7:561a]) by CH2PR18MB3349.namprd18.prod.outlook.com
 ([fe80::8818:7a86:93d7:561a%6]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 08:19:48 +0000
From:   Martin Wilck <Martin.Wilck@suse.com>
To:     "zhongjiang@huawei.com" <zhongjiang@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "opensource@jilayne.com" <opensource@jilayne.com>,
        "wang6495@umn.edu" <wang6495@umn.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "swinslow@gmail.com" <swinslow@gmail.com>,
        "saurav.girepunje@gmail.com" <saurav.girepunje@gmail.com>
CC:     "saurav.girepunje@hotmail.com" <saurav.girepunje@hotmail.com>
Subject: Re: [PATCH] cdrom: gdrom.c: fix a incorrect use of kstrndup()
Thread-Topic: [PATCH] cdrom: gdrom.c: fix a incorrect use of kstrndup()
Thread-Index: AQHVTos1k7RAPdethkuoMM42rbx/dw==
Date:   Fri, 9 Aug 2019 08:19:47 +0000
Message-ID: <a0f76fa8a8ffd41e9f11a86ab6309b0f426966a8.camel@suse.com>
References: <20190805184154.GA9776@saurav>
In-Reply-To: <20190805184154.GA9776@saurav>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Martin.Wilck@suse.com; 
x-originating-ip: [94.218.227.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b62de78f-ad63-4f42-d66c-08d71ca257f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CH2PR18MB3350;
x-ms-traffictypediagnostic: CH2PR18MB3350:
x-microsoft-antispam-prvs: <CH2PR18MB33500B04E7817428D3AF853CFCD60@CH2PR18MB3350.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(102836004)(476003)(3846002)(6486002)(76176011)(66476007)(6506007)(71200400001)(305945005)(26005)(6116002)(256004)(71190400001)(6512007)(7736002)(91956017)(36756003)(76116006)(316002)(66556008)(64756008)(66946007)(8676002)(25786009)(66446008)(558084003)(118296001)(4326008)(81166006)(81156014)(14454004)(446003)(5660300002)(486006)(53936002)(6246003)(6436002)(11346002)(2616005)(99286004)(2501003)(86362001)(229853002)(110136005)(7416002)(8936002)(66066001)(2201001)(2171002)(2906002)(186003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3350;H:CH2PR18MB3349.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2q9di2fTHuF60wMxmxSwwM2syG7YVfKaPaCb/V78TUZAnC8aimKCv3+AivCGxXNb7Kcc0G7/iEiv8AE/IbkuRNXcYZZOvA3D/KNvz9yfec4UYAATYGxS+OoYYwEycRPzh1bsJ0Mh2hswQalImv0Nd9K6iSoi9hpiFmckVPDVutCWosWYh9IObxmKe0av9ZwiXbQY6XtR9bWmlxulp0HscZKmzCat3cw8OWXaHBpqgSjIoMcapkHl7kYdxC6c8n9cQgf8kLLHY0zIj9Vr7tlTmYh5JWFUM/a9GGF6Zgrdpj28uq9uikO2RaZduQaf/yAF8mWwVStfzonKzbGcq+tDWegOkVmb97XuqBAcjqszGsRvTs+oWWyK5Nxklslb2jofs1xo64PBkwFuAo3JoZXUg4lOrOneXgf4ACsDiriuJnk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <69B3F0890F7DD1499F2E02CAAC941A99@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b62de78f-ad63-4f42-d66c-08d71ca257f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 08:19:48.0797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: birNOw7EH4PaqoTGev2/4C1Vh1iIZ57++ATuClDkHGAhPi2HaPNFkrVDEagmG4tHznbFiDxnK2WJu0DCdPkbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3350
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTA2IGF0IDAwOjExICswNTMwLCBTYXVyYXYgR2lyZXB1bmplIHdyb3Rl
Og0KPiBBY2NvcmRpbmcgdG8gZG9jOiAiTm90ZTogVXNlIGttZW1kdXBfbnVsKCkgaW5zdGVhZCBp
ZiB0aGUgc2l6ZQ0KPiBpcyBrbm93biBleGFjdGx5LiIgU28gd2Ugc2hvdWxkIHVzZSBrbWVtZHVw
X251bCgpIGhlcmUgaW5zdGVhZCBvZg0KPiBrc3RybmR1cCgpLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU2F1cmF2IEdpcmVwdW5qZSA8c2F1cmF2LmdpcmVwdW5qZUBnbWFpbC5jb20+DQo+IC0tLQ0K
DQpSZXZpZXdlZC1ieTogTWFydGluIFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+DQoNCg==
