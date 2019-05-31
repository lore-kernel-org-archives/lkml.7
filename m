Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245B9C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC76326E7C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="VKCBl5md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfEaTmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:42:46 -0400
Received: from mail-eopbgr800050.outbound.protection.outlook.com ([40.107.80.50]:62784
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727147AbfEaTmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FJ6yIu446RimK/MgW5vUH5uXSiWWvzd5jvEPpTqqa8=;
 b=VKCBl5mdJ6HxL42+XDG6vNqGiIgKus3qoTAUI0rl78yP/S4wYKw2CiMt1KVLQpx5YlY3+gtmkWGrhG2R5LJ3/oeBbngATpMxD/v9XGqi9XMHo3YCntt93HrEikk/eEG6o7JKLGQ2jICU7WUTpq+/z7R/LfxhcWTeSB52HbJPGf8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6694.namprd05.prod.outlook.com (20.178.235.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.13; Fri, 31 May 2019 19:42:42 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 19:42:42 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH v2 08/12] x86/tlb: Privatize cpu_tlbstate
Thread-Topic: [RFC PATCH v2 08/12] x86/tlb: Privatize cpu_tlbstate
Thread-Index: AQHVF3tHJuVGo9qk1UuvNMqOR/qV8KaFk+mAgAAPJIA=
Date:   Fri, 31 May 2019 19:42:42 +0000
Message-ID: <63172D88-998F-43F1-AB6F-F4A13B90AD9D@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-9-namit@vmware.com>
 <933D5C14-5948-48FC-9379-167F59BD1FA1@amacapital.net>
In-Reply-To: <933D5C14-5948-48FC-9379-167F59BD1FA1@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 718db763-2039-4bd3-d40d-08d6e600259b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB6694;
x-ms-traffictypediagnostic: BYAPR05MB6694:
x-microsoft-antispam-prvs: <BYAPR05MB6694BD0F0882239FD9550CA6D0190@BYAPR05MB6694.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(5660300002)(6246003)(33656002)(66946007)(4744005)(99286004)(25786009)(54906003)(316002)(2906002)(66476007)(64756008)(66446008)(76116006)(73956011)(68736007)(66556008)(4326008)(7416002)(476003)(66066001)(229853002)(8936002)(14454004)(6512007)(6506007)(2616005)(8676002)(53546011)(446003)(76176011)(11346002)(486006)(81156014)(82746002)(305945005)(6436002)(186003)(6116002)(3846002)(71190400001)(26005)(71200400001)(6916009)(256004)(83716004)(6486002)(81166006)(7736002)(102836004)(478600001)(53936002)(86362001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6694;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mqmUUpG/k/iJIr0sHYo2G+dQDFHxdq+F9t/bZiAXNvx1jZOZ0jNoHrAoERBVbZ7bNdpvelhBpcrHusrAKB628RAea7BTO1KORPQfUhU5PyhTZsmBd66w+s+AY+ucXQjGwDtcMPUTR6c3hmUYiBDi06BN3d8AFb9ZRV6iw9gmD7N7d4Ou4Akt1mV4R5SqM+jXi6hjV0cHi9SD2plITiEs9xThsEtFv/DsIjyHpkxPF8BLtU8sp+aWkSg2ntbhoQIniVYxePDGAB+7rNht0TrEWmaZuZMtmBniHNUmi7zxPsp3HN9fnyjI0DzVLHtghEdgv9erMGGU6rBwGYFLPM2ldgo4bMX4JXXm5PtjDnRS0v8sV5VX496QSmzMfgfZQwhSGBkY7kQlXnkUWcaP1OSBp+WqiwMc/NVuqtuPXvbjMyk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <181ECD975D5A6B43938314CD3FF6D040@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718db763-2039-4bd3-d40d-08d6e600259b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 19:42:42.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMzEsIDIwMTksIGF0IDExOjQ4IEFNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1h
Y2FwaXRhbC5uZXQ+IHdyb3RlOg0KPiANCj4gDQo+PiBPbiBNYXkgMzAsIDIwMTksIGF0IDExOjM2
IFBNLCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+IA0KPj4gY3B1X3Rs
YnN0YXRlIGlzIG1vc3RseSBwcml2YXRlIGFuZCBvbmx5IHRoZSB2YXJpYWJsZSBpc19sYXp5IGlz
IHNoYXJlZC4NCj4+IFRoaXMgY2F1c2VzIHNvbWUgZmFsc2Utc2hhcmluZyB3aGVuIFRMQiBmbHVz
aGVzIGFyZSBwZXJmb3JtZWQuDQo+PiANCj4+IEJyZWFrIGNwdV90bGJzdGF0ZSBpbnRybyBjcHVf
dGxic3RhdGUgYW5kIGNwdV90bGJzdGF0ZV9zaGFyZWQsIGFuZCBtYXJrDQo+PiBlYWNoIG9uZSBh
Y2NvcmRpbmdseS4NCj4gDQo+IEF0IHNvbWUgcG9pbnQgd2XigJlsbCB3YW50IHRvIGRvIGEgYmV0
dGVyIGpvYiB3aXRoIG91ciBQViBmbHVzaCBjb2RlLCBhbmQgSQ0KPiBzdXNwZWN0IHdl4oCZbGwg
ZW5kIHVwIHdpdGggbW9yZSBvZiB0aGlzIHNoYXJlZCBhZ2Fpbi4NCg0KSW4gdGhlIHVzdWFsIHVz
ZS1jYXNlLCB3aGVuIHlvdSBmbHVzaCB0aGUgVExCLCB3aWxsIHlvdSB3cml0ZSBzb21ldGhpbmcg
dG8NCmNwdV90bGJzdGF0ZSB0aGF0IHNob3VsZCBiZSB2aXNpYmxlIHRvIG90aGVyIGNvcmVzPyBJ
IGRvbuKAmXQgc2VlIHdoeSwgZXZlbiBpZg0KUFYgaXMgdXNlZC4NCg0KQW55aG93LCBJIHdhcyBh
bHdheXMgdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCBQViBzaG91bGQgbm90IHB1bmlzaA0KYmFy
ZS1tZXRhbC4NCg0KVGhlIG90aGVyIG9wdGlvbiBpcyB0byB0YWtlIGNwdV90bGJzdGF0ZSBhbmQg
cmVhcnJhbmdlIGl0IHNvIHRoZSBzaGFyZWQNCnN0dWZmIHdpbGwgbm90IGJlIG5leHQgdG8gdGhl
IHByaXZhdGUuIEkganVzdCBkb27igJl0IGtub3cgaG93IHRvIGRvIGl0DQp3aXRob3V0IG1ha2lu
ZyBhbiBhc3N1bXB0aW9uIG9mIHRoZSBjYWNoZWxpbmUgc2l6ZS4=
