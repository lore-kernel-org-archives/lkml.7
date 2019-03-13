Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84789C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C482063F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="k03hwOCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCMBDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 21:03:24 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:48261
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfCMBDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 21:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHPSJU/XM4yra3LCjA7ISzyT4r4mmuSIFSb51ZqYjfw=;
 b=k03hwOCzCV16jrfU88sbL00LCOKNJkdZkSaNpCm9N1dnHqfmdWCbyJApf103ZS1ASPtVXGZbHs0qwZ5DpzW0+7aqZAvM+zWCWwPFD6kFINFu8YbR+HowYk29hLHoEaPv/58veWGpPhbFFrHNzpoozQIlY21YMFGyp1AuomLZP0E=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.190.138) by
 AM4PR08MB0786.eurprd08.prod.outlook.com (10.164.82.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 13 Mar 2019 01:03:18 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce%4]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 01:03:18 +0000
From:   "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To:     Sudeep Holla <Sudeep.Holla@arm.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        Steve Capper <Steve.Capper@arm.com>,
        "Bin Lu (Arm Technology China)" <Bin.Lu@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Topic: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Index: AQHUz5P9ZKULSdDQbEW1h9vbYNE6xaX7KHCAgAAd14CAAQzrgIAKf6aAgAD7mAD//5MRgIAAmEsAgADYE4A=
Date:   Wed, 13 Mar 2019 01:03:18 +0000
Message-ID: <5750cfac-14a7-8eed-09f4-0d53419bea6b@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
 <20190304101205.GA1504@e107155-lin>
 <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com>
 <20190311183403.GA31062@e107155-lin>
 <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
 <CALCETrWiF5FKUTmt4jOZJxJr6B_66NFj9TaA3Tnv1uorfkwTMg@mail.gmail.com>
 <20190312120944.GB13825@e107155-lin>
In-Reply-To: <20190312120944.GB13825@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0037.apcprd03.prod.outlook.com
 (2603:1096:203:2f::25) To AM4PR08MB2929.eurprd08.prod.outlook.com
 (2603:10a6:205:c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c83c4c13-ba38-4f2a-42b0-08d6a74fadc0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB0786;
x-ms-traffictypediagnostic: AM4PR08MB0786:
x-microsoft-exchange-diagnostics: 1;AM4PR08MB0786;20:BdnkpVSfCDkpLkBV+T6J2k0rcndxex7JXa+uwH45ZBNk380ZfiQH1rO9TtxRN8v/ezTB0cjUVdR0/3MAUA/69+PwYs+MShEEu/Mh16pTmu4V+rGxDhlAN5Q2q5siQM08K18CJ05RagcF42XAeXky9j6axLrlraXVVWIS6e0Uhlk=
x-microsoft-antispam-prvs: <AM4PR08MB07869B621F2C0FC4CDB68EB7854A0@AM4PR08MB0786.eurprd08.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(136003)(376002)(40434004)(199004)(189003)(31696002)(36756003)(72206003)(478600001)(52116002)(3846002)(6116002)(256004)(14454004)(7416002)(86362001)(2616005)(55236004)(68736007)(11346002)(8936002)(106356001)(53936002)(93886005)(6512007)(81166006)(105586002)(446003)(2906002)(8676002)(110136005)(6436002)(6486002)(486006)(5660300002)(102836004)(31686004)(66066001)(14444005)(54906003)(229853002)(5024004)(25786009)(26005)(53546011)(6506007)(386003)(186003)(305945005)(7736002)(76176011)(97736004)(99286004)(316002)(476003)(6246003)(71190400001)(71200400001)(4326008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB0786;H:AM4PR08MB2929.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k7CsVhxf5HY7vdzqIrg41lC1rUfVJhf92HGfQKD5HcKnTy2yc4SQlqetE+3D7DweBede0vFABBUSFDbL8/+jzZVz4d3GUW1A6Cbm1xgEVMPpkh4DsGh51HLFVGzmG2os46WzYWEk2R5epzGbpH5yLtIVJQ7t5w6jQMb6+hKnQGAwleZgDccFuZI6pHxv7OK7Bdlnda5PdHrxfp4wivQlnRT92ezcXhmjkmBXhy9U7DOwPuqkbtNw/EPKwXXRJodETQgKL41/0BE3yQXWIJOqwhq9cSq9rnnqyuclYMm7kY3Hh71bP36JEX7LCxeniTvdbLTkioFgVbooYqy5RH3pQD1f6WbfO4AtpFMf5tuJj2oT7vqD43lhEV7jXJtQmI9URG43k2GqrUeSGHnsGdB8K/8M0kKFg1+NlqtaoTF62lo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5B417A193AEF34B962ED5DF32A4EFB2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83c4c13-ba38-4f2a-42b0-08d6a74fadc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 01:03:18.1409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS8zLzEyIDIwOjA5LCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+IE9uIE1vbiwgTWFyIDEx
LCAyMDE5IGF0IDA4OjA0OjM5UE0gLTA3MDAsIEFuZHkgTHV0b21pcnNraSB3cm90ZToNCj4+IE9u
IE1vbiwgTWFyIDExLCAyMDE5IGF0IDY6MzUgUE0gSGFpYm8gWHUgKEFybSBUZWNobm9sb2d5IENo
aW5hKQ0KPj4gPEhhaWJvLlh1QGFybS5jb20+IHdyb3RlOg0KPj4+DQo+DQo+IFsuLi5dDQo+DQo+
Pj4gRm9yIHRoZSBQVFJBQ0VfU1lTRU1VX1NJTkdMRVNURVAgcmVxdWVzdCwgcHRyYWNlIG9ubHkg
bmVlZCB0byByZXBvcnQoc2VuZA0KPj4+IFNJR1RSQVApIGF0IHRoZSBlbnRyeSBvZiBhIHN5c3Rl
bSBjYWxsLCBubyBuZWVkIHRvIHJlcG9ydCBhdCB0aGUgZXhpdCBvZiBhDQo+Pj4gc3lzdGVtIGNh
bGwuVGhhdCdzIHdoeSB0aGUgb2xkIGxvZ2ljLXtzdGVwID0gKChmbGFncyAmIChfVElGX1NJTkdM
RVNURVAgfA0KPj4+IF9USUZfU1lTQ0FMTF9FTVUpKSA9PSBfVElGX1NJTkdMRVNURVApfSBoZXJl
IHRyeSB0byBmaWx0ZXIgb3V0IHRoZSBzcGVjaWFsDQo+Pj4gY2FzZShQVFJBQ0VfU1lTRU1VX1NJ
TkdMRVNURVApLg0KPj4+DQo+Pj4gQW5vdGhlciB3YXkgdG8gbWFrZSBzdXJlIHRoZSBsb2dpYyBp
cyBmaW5lLCB5b3UgY2FuIHJ1biBzb21lIHRlc3RzIHdpdGgNCj4+PiByZXNwZWN0IHRvIGJvdGgg
bG9naWMsIGFuZCB0byBjaGVjayB3aGV0aGVyIHRoZXkgaGF2ZSB0aGUgc2FtZSBiZWhhdmlvci4N
Cj4+DQo+PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvcHRyYWNlX3N5c2NhbGwuYyBoYXMg
YSB0ZXN0IGludGVuZGVkIHRvDQo+PiBleGVyY2lzZSB0aGlzLiAgQ2FuIG9uZSBvZiB5b3UgZWl0
aGVyIGNvbmZpcm0gdGhhdCBpdCBkb2VzIGV4ZXJjaXNlIGl0DQo+PiBhbmQgdGhhdCBpdCBzdGls
bCBwYXNzZXMgb3IgY2FuIHlvdSBpbXByb3ZlIHRoZSB0ZXN0Pw0KPj4NCj4gSSBkaWQgcnVuIHRo
ZSB0ZXN0cyB3aGljaCBkaWRuJ3QgZmxhZyBhbnl0aGluZy4gSSBoYXZlbid0IGxvb2tlZCBhdCB0
aGUNCj4gZGV0YWlscyBvZiB0ZXN0IGltcGxlbWVudGF0aW9uLCBidXQgc2VlbSB0byBtaXNzIHRo
aXMgY2FzZS4gSSB3aWxsIHNlZQ0KPiB3aGF0IGNhbiBiZSBpbXByb3ZlZChpZiBpdCdzIHBvc3Np
YmxlKS4gQWxzbyBJIHRoaW5rIHNpbmdsZV9zdGVwX3N5c2NhbGwNCj4gaXMgdGhlIG9uZSBJIG5l
ZWQgdG8gbG9vayBmb3IgdGhpcyBwYXJ0aWN1bGFyIG9uZS4gQm90aCBzaW5nbGVfc3RlcF9zeXNj
YWxsDQo+IHB0cmFjZV9zeXNjYWxsIHJlcG9ydGVkIG5vIGVycm9ycy4NCj4NCj4gLS0NCj4gUmVn
YXJkcywNCj4gU3VkZWVwDQo+DQoNClNpbmNlIHB0cmFjZSgpIHN5c3RlbSBjYWxsIGRvIGhhdmUg
c28gbWFueSByZXF1ZXN0IHR5cGUsIEknbSBub3Qgc3VyZSB3aGV0aGVyIHRoZQ0KdGVzdCBjYXNl
cyBoYXZlIGNvdmVyZWQgYWxsIG9mIHRoYXQuIEJ1dCBoZXJlIHdlJ2QgYmV0dGVyIG1ha2Ugc3Vy
ZSB0aGUgUFRSQUNFX1NZU0VNVQ0KYW5kIFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUCByZXF1ZXN0
cyBhcmUgd29yayBjb3JyZWN0bHkuIE1heSBiZSB5b3UgY2FuIHZlcmlmeSB0aGVtIHdpdGgNCnRl
c3RzIGZyb20gQmluIEx1KGJpbi5sdUBhcm0uY29tKS4NCg0KUmVnYXJkcywNCkhhaWJvDQpJTVBP
UlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBh
cmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBp
bW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIg
cGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZv
cm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
