Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F01DC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4703421849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="gWufHkNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfGSSlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:41:15 -0400
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:25609
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728356AbfGSSlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:41:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOYP/hsXi1z+IOuhjD1EfqH6smDWwJYq5q5mbA16ur5a4H/4YzTqcnUQEAeT25/hOxiakUurCzSpZsxFKiKzu9i0OZvb0mh2rs/kYpUMROmoqcXU4z0tRLscakIegXtu4QfyDupz7hFpPEFYu4T5mF2c5fQ95WFcC+vAoMER8f4t+lgpDbgebGaBOx+pU3PbyxxRcyaOfgwzMaTmW5y5vvywzmIzUs/qN7gxYn2EA8t60ZrxZvE0FGqoTbEctyN5J/3PxOT6OYrB6W1ia4Pp/OYVWppDgEH+JnqXol7hcVqBgd21f7XkkNK8+reXSz0/n6gc4UfP5Gk6QZSjg5ws9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3psR71/Ki0Ecn1xyN6zgnx3qbKNkGvvz7zmAFeyM674=;
 b=esqXBgpxwT8+3QBlzqqRkMgbRFfqptllUZuEpLRdzWkabH/4GngVBAu2JFjddpNaCHeBPUJ1BvJ/+zduXfiv6/jm/tsPRQUs9iwawPfaTxGmPsKuuNtVGbzKjLzyGL5MS0yfUvuHzmR5fmVQXWgn8gD7T0u+iWnFlCSLsrntO3LZAfCarTSC62ymEgnNfF/4ctQGPoxBfXKo3SZQBz/bLUiJ2syMt2VwFdTVQKMmrIYa+SlNraLSlF1ZAENh3QpN3g2wKxzqecp6qQDcb1RPUNp6R3Mn8bml3L0k9GgNweBfRMqxdqL8zzTwszQhIGa5WjyGzMb8uSZHDBmmZ3BTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3psR71/Ki0Ecn1xyN6zgnx3qbKNkGvvz7zmAFeyM674=;
 b=gWufHkNL2QsV5Bb6ZfHLqS2Io9LJj+CZJfICQtlbkHCEBm0pJtRNX7Jb9ou11H1NhEFf6cz4uIYrT1zMqE4bCHheWkk1leciiMNWiW55PkjLkf81ndVI9W8Dq8dcopd7FQt+m14kAtxd8Q6ZoudP4QdO0Y2GhzxsN1vR/LBkAus=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5768.namprd05.prod.outlook.com (20.178.48.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.8; Fri, 19 Jul 2019 18:41:11 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2094.009; Fri, 19 Jul 2019
 18:41:11 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Thread-Topic: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Thread-Index: AQHVPc0s+2522G+J006mLkslhMknOKbSRkAAgAABN4A=
Date:   Fri, 19 Jul 2019 18:41:11 +0000
Message-ID: <6847D7A3-4618-4BC3-97B6-EC53F6985504@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-4-namit@vmware.com>
 <8bf005e2-7ac7-f1cf-eca1-0e152dd912a7@intel.com>
In-Reply-To: <8bf005e2-7ac7-f1cf-eca1-0e152dd912a7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19b352c7-30d0-4d45-6472-08d70c78abfc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5768;
x-ms-traffictypediagnostic: BYAPR05MB5768:
x-microsoft-antispam-prvs: <BYAPR05MB5768168C64DE7F7420A6440DD0CB0@BYAPR05MB5768.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(8676002)(6512007)(7736002)(68736007)(229853002)(14454004)(6486002)(478600001)(25786009)(6436002)(316002)(6916009)(4326008)(6116002)(3846002)(6246003)(53936002)(99286004)(86362001)(33656002)(54906003)(36756003)(446003)(256004)(14444005)(186003)(486006)(64756008)(66446008)(66946007)(66476007)(66556008)(76116006)(8936002)(81166006)(81156014)(11346002)(4744005)(2616005)(5660300002)(476003)(305945005)(7416002)(6506007)(53546011)(2906002)(76176011)(26005)(71190400001)(102836004)(66066001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5768;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XJhXWM295h7diLaiJ7K2WSNQQQEhmHQ3ASBtoiCQjHe79w4vI5XploXz/LSYPjB7wEyUXQumnJLfwjQPPSsOMuxcwrhTr1qgLOHE7V85mAu8+k1ae5K8utePGbxU8VotmPfCLijyxd1oRugfhkyf8oRLgY/cuKKWndTsul0GrYqthCrDs3PfybpYYCFl+5VRjkLYJEPCpkKXdv1PXsvhXvW0EiBaTbIH1U/WaWmRddpp22yLvj2ueYW4fNodpchBLzB1yGfdMHWb9sO0fCW6ZLxRCmond6PKzUpm9CzIJ2bAFe3wNj563rfskA3BddybbapIpe8NimYiY+FDfk40aNLEVi0xTnDjOR2i/bsG/4Kkd1yOgz6qjdiJnnI4ysslzj0/nvlqkWrtciS1oN8B1ehtwwn8ZdRBAQVDWCz3wqU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BC2B08C92A8534EBF341964ED4E4B61@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b352c7-30d0-4d45-6472-08d70c78abfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 18:41:11.5179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTksIDIwMTksIGF0IDExOjM2IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5A
aW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDcvMTgvMTkgNTo1OCBQTSwgTmFkYXYgQW1pdCB3
cm90ZToNCj4+IEBAIC04NjUsNyArODkzLDcgQEAgdm9pZCBhcmNoX3RsYmJhdGNoX2ZsdXNoKHN0
cnVjdCBhcmNoX3RsYmZsdXNoX3VubWFwX2JhdGNoICpiYXRjaCkNCj4+IAlpZiAoY3B1bWFza190
ZXN0X2NwdShjcHUsICZiYXRjaC0+Y3B1bWFzaykpIHsNCj4+IAkJbG9ja2RlcF9hc3NlcnRfaXJx
c19lbmFibGVkKCk7DQo+PiAJCWxvY2FsX2lycV9kaXNhYmxlKCk7DQo+PiAtCQlmbHVzaF90bGJf
ZnVuY19sb2NhbCgmZnVsbF9mbHVzaF90bGJfaW5mbyk7DQo+PiArCQlmbHVzaF90bGJfZnVuY19s
b2NhbCgodm9pZCAqKSZmdWxsX2ZsdXNoX3RsYl9pbmZvKTsNCj4+IAkJbG9jYWxfaXJxX2VuYWJs
ZSgpOw0KPj4gCX0NCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBzdXBlcmZsdW91cyBjaHVybi4gIElz
IGl0Pw0KDQpVbmZvcnR1bmF0ZWx5IG5vdCwgc2luY2UgZnVsbF9mbHVzaF90bGJfaW5mbyBpcyBk
ZWZpbmVkIGFzIGNvbnN0LiBXaXRob3V0IGl0DQp5b3Ugd291bGQgZ2V0Og0KDQp3YXJuaW5nOiBw
YXNzaW5nIGFyZ3VtZW50IDEgb2Yg4oCYZmx1c2hfdGxiX2Z1bmNfbG9jYWzigJkgZGlzY2FyZHMg
4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdkaXNjYXJk
ZWQtcXVhbGlmaWVyc10NCg0KQW5kIGZsdXNoX3RsYl9mdW5jX2xvY2FsKCkgc2hvdWxkIGdldCAo
dm9pZCAqKSBhcmd1bWVudCBzaW5jZSBpdCBpcyBhbHNvDQp1c2VkIGJ5IHRoZSBTTVAgaW5mcmFz
dHJ1Y3R1cmUu
