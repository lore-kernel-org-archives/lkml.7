Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A422C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B36F24C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="s7KH4mTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfEaS3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:29:41 -0400
Received: from mail-eopbgr730045.outbound.protection.outlook.com ([40.107.73.45]:3328
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbfEaS3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml+4CGW9kVuiZoNoI+GodxiS+dgxm/2zB0qO+0an7X8=;
 b=s7KH4mTx55RcqaF54hf3dvAr5DfrLJYNSPHPq6eHQwRtxz6STwixIBPVMHRbllpTA8Yzan3BuF6R6MB6rGyECOm16rebUPV2vELRQOniVSxl4PIrUYrCLp0E2CONeL4LbJYo+dXomJfGD03haftXFs3n9GRuMwS8dRHH7Sof7t4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4535.namprd05.prod.outlook.com (52.135.203.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.15; Fri, 31 May 2019 18:29:34 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 18:29:34 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Topic: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Index: AQHVF3tKnfrC/xKd0kyiVp6wMVDUEqaFEHMAgAB+LIA=
Date:   Fri, 31 May 2019 18:29:33 +0000
Message-ID: <82791CFA-3748-4881-9F01-53F677108FC3@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-12-namit@vmware.com>
 <20190531105758.GO2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190531105758.GO2623@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a8c63c7-717b-486f-65fa-08d6e5f5ede5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4535;
x-ms-traffictypediagnostic: BYAPR05MB4535:
x-microsoft-antispam-prvs: <BYAPR05MB453584E1EE16BA4B0B9F4A19D0190@BYAPR05MB4535.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(51444003)(189003)(478600001)(6246003)(229853002)(83716004)(7416002)(81156014)(8676002)(4326008)(2616005)(14454004)(6486002)(81166006)(76176011)(26005)(6506007)(5660300002)(53936002)(36756003)(99286004)(7736002)(6512007)(86362001)(66066001)(53546011)(102836004)(3846002)(486006)(25786009)(71190400001)(446003)(8936002)(2906002)(256004)(6116002)(66556008)(66476007)(66446008)(66946007)(73956011)(64756008)(76116006)(14444005)(476003)(11346002)(316002)(6436002)(54906003)(186003)(68736007)(82746002)(33656002)(6916009)(71200400001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4535;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zpQGgbV0b1vAiaTw6fi9DRJWRRu25B7mQ6eVM3vE5spCXhowfFG7X92Xko+cHbn4EGWqlaf+efGpB5gbFeJoJEnhY7ai6Ak2Y2uiC6W4cnNIs6Mg2CqJzcWxlFLueRe5oRsjUF3KyXRPZO/X4/7kxSL5GD6ipQ1KTvbS4/dLG8Hgy/DgzhNO10VhMuII78Fhz9a1uwXzVWUPEtuOijtDdNWvDdY5ihRzZ2zAZS/Jai3tGYfm22OT8T26WI8ZYSGzTl1AI56TndqarZq6GPWiDrDJCJY+V9kfc+fKIS13F4jYNUbz+G3ibGuI9ATxMNPlT2y3P22/pLJWvXqObKP3DRvm6+yVSDY2B5I6yFL6dI7zBOs1iAUxHsmrcnytgI5cGZoj1XbbBg9jHuXp22Wfd/xeg1pnPuu7E7wVki1Y50E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D873DB7DE46C34EBFF709B26CBA8BF2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8c63c7-717b-486f-65fa-08d6e5f5ede5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 18:29:33.9396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4535
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WyArSmFubiBIb3JuIF0NCg0KPiBPbiBNYXkgMzEsIDIwMTksIGF0IDM6NTcgQU0sIFBldGVyIFpp
amxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE1heSAz
MCwgMjAxOSBhdCAxMTozNjo0NFBNIC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gV2hlbiB3
ZSBmbHVzaCB1c2Vyc3BhY2UgbWFwcGluZ3MsIHdlIGNhbiBkZWZlciB0aGUgVExCIGZsdXNoZXMs
IGFzIGxvbmcNCj4+IHRoZSBmb2xsb3dpbmcgY29uZGl0aW9ucyBhcmUgbWV0Og0KPj4gDQo+PiAx
LiBObyB0YWJsZXMgYXJlIGZyZWVkLCBzaW5jZSBvdGhlcndpc2Ugc3BlY3VsYXRpdmUgcGFnZSB3
YWxrcyBtaWdodA0KPj4gICBjYXVzZSBtYWNoaW5lLWNoZWNrcy4NCj4+IA0KPj4gMi4gTm8gb25l
IHdvdWxkIGFjY2VzcyB1c2Vyc3BhY2UgYmVmb3JlIGZsdXNoIHRha2VzIHBsYWNlLiBTcGVjaWZp
Y2FsbHksDQo+PiAgIE5NSSBoYW5kbGVycyBhbmQga3Byb2JlcyB3b3VsZCBhdm9pZCBhY2Nlc3Np
bmcgdXNlcnNwYWNlLg0KPj4gDQo+PiBVc2UgdGhlIG5ldyBTTVAgc3VwcG9ydCB0byBleGVjdXRl
IHJlbW90ZSBmdW5jdGlvbiBjYWxscyB3aXRoIGlubGluZWQNCj4+IGRhdGEgZm9yIHRoZSBtYXR0
ZXIuIFRoZSBmdW5jdGlvbiByZW1vdGUgVExCIGZsdXNoaW5nIGZ1bmN0aW9uIHdvdWxkIGJlDQo+
PiBleGVjdXRlZCBhc3luY2hyb25vdXNseSBhbmQgdGhlIGxvY2FsIENQVSB3b3VsZCBjb250aW51
ZSBleGVjdXRpb24gYXMNCj4+IHNvb24gYXMgdGhlIElQSSB3YXMgZGVsaXZlcmVkLCBiZWZvcmUg
dGhlIGZ1bmN0aW9uIHdhcyBhY3R1YWxseQ0KPj4gZXhlY3V0ZWQuIFNpbmNlIHRsYl9mbHVzaF9p
bmZvIGlzIGNvcGllZCwgdGhlcmUgaXMgbm8gcmlzayBpdCB3b3VsZA0KPj4gY2hhbmdlIGJlZm9y
ZSB0aGUgVExCIGZsdXNoIGlzIGFjdHVhbGx5IGV4ZWN1dGVkLg0KPj4gDQo+PiBDaGFuZ2Ugbm1p
X3VhY2Nlc3Nfb2theSgpIHRvIGNoZWNrIHdoZXRoZXIgYSByZW1vdGUgVExCIGZsdXNoIGlzDQo+
PiBjdXJyZW50bHkgaW4gcHJvZ3Jlc3Mgb24gdGhpcyBDUFUgYnkgY2hlY2tpbmcgd2hldGhlciB0
aGUgYXN5bmNocm9ub3VzbHkNCj4+IGNhbGxlZCBmdW5jdGlvbiBpcyB0aGUgcmVtb3RlIFRMQiBm
bHVzaGluZyBmdW5jdGlvbi4gVGhlIGN1cnJlbnQNCj4+IGltcGxlbWVudGF0aW9uIGRpc2FsbG93
cyBhY2Nlc3MgaW4gc3VjaCBjYXNlcywgYnV0IGl0IGlzIGFsc28gcG9zc2libGUNCj4+IHRvIGZs
dXNoIHRoZSBlbnRpcmUgVExCIGluIHN1Y2ggY2FzZSBhbmQgYWxsb3cgYWNjZXNzLg0KPiANCj4g
QVJHR0gsIGJyYWluIGh1cnQuIEknbSBub3Qgc3VyZSBJIGZ1bGx5IHVuZGVyc3RhbmQgdGhpcyBv
bmUuIEhvdyBpcyBpdA0KPiBkaWZmZXJlbnQgZnJvbSB0b2RheSwgd2hlcmUgdGhlIE5NSSBjYW4g
aGl0IGluIHRoZSBtaWRkbGUgb2YgdGhlIFRMQg0KPiBpbnZhbGlkYXRpb24/DQoNCkxldOKAmXMg
YXNzdW1lIHRoYXQgYSBwYWdlIG1hcHBpbmcgaXMgcmVtb3ZlZCBzbyBhIFBURSBpcyBjaGFuZ2Vk
IGZyb20gcHJlc2VudA0KdG8gbm9uLXByZXNlbnQuIFRvZGF5LCB0aGUgcGFnZSB3b3VsZCBvbmx5
IGJlIHJlY3ljbGVkIGFmdGVyIGFsbCB0aGUgY29yZXMNCmZsdXNoZWQgdGhlaXIgVExCLiBTbyBO
TUkgaGFuZGxlcnMgYWNjZXNzaW5nIHRoZSBwYWdlIGFyZSBzYWZlIC0gdGhleSBtaWdodA0KZWl0
aGVyIGFjY2VzcyB0aGUgcHJldmlvdXNseSBtYXBwZWQgcGFnZSAod2hpY2ggc3RpbGwgaGFzIG5v
dCBiZWVuIHJldXNlZCkNCm9yIGZhdWx0LCBidXQgdGhleSBjYW5ub3QgYWNjZXNzIHRoZSB3cm9u
ZyBkYXRhLg0KDQpGb2xsb3dpbmcgdGhpcyBjaGFuZ2UgaXQgbWlnaHQgaGFwcGVuIHRoYXQgb25l
IGNvcmUgd291bGQgc3RpbGwgaGF2ZSBzdGFsZQ0KbWFwcGluZ3MgZm9yIGEgcGFnZSB0aGF0IGhh
cyBhbHJlYWR5IHJlY3ljbGVkIGZvciBhIG5ldyB1c2UgKGUuZy4sIGl0IGlzDQphbGxvY2F0ZWQg
dG8gYSBkaWZmZXJlbnQgcHJvY2VzcykuIFRoZSBjb3JlIHRoYXQgaGFzIHRoZSBzdGFsZSBtYXBw
aW5nIHdvdWxkDQpmaW5kIGl0c2VsZiBpbiB0aGUgaW50ZXJydXB0IGhhbmRsZXIuIEJ1dCB3ZSBt
dXN0IGVuc3VyZSB0aGUgTk1JIGhhbmRsZXINCmRvZXMgbm90IGFjY2VzcyB0aGlzIHBhZ2UuDQoN
Cj4gQWxzbzsgc2luY2Ugd2UncmUgbm90IHdhaXRpbmcgb24gdGhlIElQSSwgd2hhdCBwcmV2ZW50
cyB1cyBmcm9tIGZyZWVpbmcNCj4gdGhlIHVzZXIgcGFnZXMgYmVmb3JlIHRoZSByZW1vdGUgQ1BV
IGlzICdkb25lJyB3aXRoIHRoZW0/IEN1cnJlbnRseSB0aGUNCj4gc3luY2hyb25vdXMgSVBJIGlz
IGxpa2UgYSBzeW5jIHBvaW50IHdoZXJlIHdlICprbm93KiB0aGUgcmVtb3RlIENQVSBpcw0KPiBj
b21wbGV0ZWx5IGRvbmUgYWNjZXNzaW5nIHRoZSBwYWdlLg0KDQpXZSBtaWdodCBmcmVlIHRoZW0g
YmVmb3JlIHRoZSByZW1vdGUgVExCIGZsdXNoIGlzIGRvbmUsIGJ1dCBub3QgdGhhdCBvbmx5DQph
ZnRlciB0aGUgSVBJIGhhcyBiZWVuIGFja25vd2xlZGdlZCBhbmQgcmlnaHQgYmVmb3JlIHRoZSBh
Y3R1YWwgVExCIGZsdXNoDQppcyBhYm91dCB0byBzdGFydC4gU2VlIGZsdXNoX3NtcF9jYWxsX2Z1
bmN0aW9uX3F1ZXVlKCkuDQoNCiAgICAgICAgICAgICAgICBpZiAoY3NkLT5mbGFncyAmIENTRF9G
TEFHX1NZTkNIUk9OT1VTKSB7DQogICAgICAgICAgICAgICAgICAgICAgICBmdW5jKGluZm8pOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgY3NkX3VubG9jayhjc2QpOw0KICAgICAgICAgICAgICAg
IH0gZWxzZSB7DQogICAgICAgICAgICAgICAgICAgICAgICB0aGlzX2NwdV93cml0ZShhc3luY19m
dW5jX2luX3Byb2dyZXNzLCBjc2QtPmZ1bmMpOw0KICAgICAgICAgICAgICAgICAgICAgICAgY3Nk
X3VubG9jayhjc2QpOyAoKikNCiAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmMoaW5mbyk7DQoN
CiAgICANCldlIGRvIHdhaXQgZm9yIHRoZSBJUEkgdG8gYmUgcmVjZWl2ZWQgYW5kIHRoZSBlbnRy
eSBvZiB0aGUgc3BlY2lmaWMgVExCDQppbnZhbGlkYXRpb24gdG8gYmUgcHJvY2Vzc2VkLiBGb2xs
b3dpbmcgdGhlIGluc3RydWN0aW9uIHRoYXQgaXMgbWFya2VkIHdpdGgNCigqKSB0aGUgaW5pdGlh
dG9yIHRvIHRoZSBUTEIgc2hvb3Rkb3duIHdvdWxkIGJlIGFibGUgdG8gY29udGludWUsIGJ1dCBu
b3QNCmJlZm9yZS4gV2UganVzdCBkbyBub3Qgd2FpdCBmb3IgdGhlIGFjdHVhbCBmbHVzaCAoY2Fs
bGVkIGJ5IGZ1bmMoKSkgdG8gdGFrZQ0KcGxhY2UuDQoNCj4gV2hlcmUgZ2V0dGluZyBhbiBJUEkg
c3RvcHMgc3BlY3VsYXRpb24sIHNwZWN1bGF0aW9uIGFnYWluIHJlc3RhcnRzDQo+IGluc2lkZSB0
aGUgaW50ZXJydXB0IGhhbmRsZXIsIGFuZCB1bnRpbCB3ZSd2ZSBwYXNzZWQgdGhlIElOVkxQRy9N
T1YgQ1IzLA0KPiBzcGVjdWxhdGlvbiBjYW4gaGFwcGVuIG9uIHRoYXQgVExCIGVudHJ5LCBldmVu
IHRob3VnaCB3ZSd2ZSBhbHJlYWR5DQo+IGZyZWVkIGFuZCByZS11c2VkIHRoZSB1c2VyLXBhZ2Uu
DQoNCkxldOKAmXMgY29uc2lkZXIgd2hhdCB0aGUgaW1wYWN0IG9mIHN1Y2ggc3BlY3VsYXRpb24g
bWlnaHQgYmUuIFZpcnR1YWxseQ0KaW5kZXhlZCBjYWNoZXMgbWlnaHQgaGF2ZSB0aGUgd3Jvbmcg
ZGF0YS4gQnV0IHRoaXMgZGF0YSBzaG91bGQgbm90IGJlIHVzZWQNCmJlZm9yZSB0aGUgZmx1c2gs
IHNpbmNlIHdlIGFyZSBhbHJlYWR5IGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciwgYW5kIHdlDQpz
aG91bGQgYmUgYWJsZSB0byBwcmV2ZW50IGFjY2Vzc2VzIHRvIHVzZXJzcGFjZS4NCg0KQSBuZXcg
dmVjdG9yIGZvciBTcGVjdHJlLXR5cGUgYXR0YWNrcyBtaWdodCBiZSBvcGVuZWQuIGJ1dCBJIGRv
buKAmXQgc2VlIGhvdy4NCg0KQSAjTUMgbWlnaHQgYmUgY2F1c2VkLiBJIHRyaWVkIHRvIGF2b2lk
IGl0IGJ5IG5vdCBhbGxvd2luZyBmcmVlaW5nIG9mDQpwYWdlLXRhYmxlcyBpbiBzdWNoIHdheS4g
RGlkIEkgbWlzcyBzb21ldGhpbmcgZWxzZT8gU29tZSBpbnRlcmFjdGlvbiB3aXRoDQpNVFJSIGNo
YW5nZXM/IEnigJlsbCB0aGluayBhYm91dCBpdCBzb21lIG1vcmUsIGJ1dCBJIGRvbuKAmXQgc2Vl
IGhvdy4NCg0KDQo+IEFsc28sIHdoYXQgaGFwcGVucyBpZiB0aGUgVExCIGludmFsaWRhdGlvbiBJ
UEkgaXMgc3R1Y2sgYmVoaW5kIGFub3RoZXINCj4gc21wX2Z1bmN0aW9uX2NhbGwgSVBJIHRoYXQg
aXMgZG9pbmcgdXNlci1hY2Nlc3M/DQoNCkl04oCZcyBub3QgZXhhY3RseSB0aGUgSVBJIGJ1dCB0
aGUgY2FsbF9zaW5nbGVfZGF0YS4gSW4gc3VjaCBjYXNlLCBhcyBzaG93bg0KYWJvdmUsIGNzZF91
bmxvY2soKSBpcyBvbmx5IGNhbGxlZCBvbmNlIHlvdSBhcmUgYWJvdXQgdG8gc3RhcnQgaGFuZGxp
bmcNCnRoZSBzcGVjaWZpYyBUTEIgZmx1c2guDQoNCj4gDQo+IEFzIHNhaWQsLi4gYnJhaW4gaHVy
dHMuDQoNCkkgdW5kZXJzdGFuZC4gTWluZSB0b28uIFRoZSB0ZXh0Ym9vayBzYXlzIHRoYXQgd2Ug
bmVlZCB0byBmbHVzaCBhbGwgdGhlIFRMQnMNCmJlZm9yZSB3ZSBjYW4gcmVjeWNsZSB0aGUgcGFn
ZSwgYmUgZ3VhcmFudGVlZCB0aGF0IHdyaXRlLXByb3RlY3RlZCBwYWdlIHdpbGwNCm5vdCBjaGFu
Z2UsIGFuZCBzbyBvbi4gSSB0aGluayB0aGF0IHNpbmNlIHdlIHNob3VsZCBiZSBhYmxlIHRvIGd1
YXJhbnRlZQ0KdGhhdCB0aGUgdXNlcnNwYWNlIGFkZHJlc3MsIHdoaWNoIGFyZSBpbnZhbGlkYXRl
ZCwgd291bGQgbmV2ZXIgYmUgdXNlZCBieQ0KdGhlIGtlcm5lbCBiZWZvcmUgdGhlIGZsdXNoLCB3
ZSBzaG91bGQgYmUgc2FmZS4gQWZ0ZXIgdGhlIGZsdXNoLCBhbGwgdGhlDQphcnRpZmFjdCBvZiBz
cGVjdWxhdGl2ZSBjYWNoaW5nIHNob3VsZCBkaXNhcHBlYXIuDQoNCkkgbWlnaHQgYmUgd3Jvbmcs
IGFuZCBJIGRvIHF1ZXN0aW9uIG15c2VsZiwgYnV0IEkgZG9u4oCZdCBzZWUgaG93Lg0KDQo=
