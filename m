Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5852AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0EA208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="AHvtHbT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfDXWao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:30:44 -0400
Received: from mail-eopbgr750111.outbound.protection.outlook.com ([40.107.75.111]:12351
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfDXWal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2rgqF+2yIsCWlJ9ujfqZGLvGASiMs9NxkGI5suwvlc=;
 b=AHvtHbT3vUs3HHT83+eI9Br4J1Qtf/jRoBD+e0xShwQU9+cZpnraYih6ynjPTjgyv62VrjFNhznVxo0ayRQyxnk9oCwOAQkftw79z3v8vPWnUgx9RD9aecYNoiV+uzlf50JbWxC30gorG9yLVNpfpooAsQtrPGvzkvu1rcAdwbc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1038.namprd22.prod.outlook.com (10.174.167.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Wed, 24 Apr 2019 22:30:38 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 22:30:38 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 03/12] mips: Combine memblock init and memory reservation
  loops
Thread-Topic: [PATCH 03/12] mips: Combine memblock init and memory reservation
  loops
Thread-Index: AQHU+u1XKngNav74/E2Y84ACscALuw==
Date:   Wed, 24 Apr 2019 22:30:38 +0000
Message-ID: <MWHPR2201MB127708440BA64024768F2B70C13C0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190423224748.3765-4-fancer.lancer@gmail.com>
In-Reply-To: <20190423224748.3765-4-fancer.lancer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0063.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::40) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5d77f17-d5a2-4b99-ceda-08d6c9047a0f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1038;
x-ms-traffictypediagnostic: MWHPR2201MB1038:
x-microsoft-antispam-prvs: <MWHPR2201MB10385362AA206D279660B0A2C13C0@MWHPR2201MB1038.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39850400004)(136003)(189003)(199004)(8676002)(7416002)(102836004)(7696005)(52116002)(4326008)(76176011)(7736002)(6506007)(54906003)(305945005)(99286004)(316002)(6246003)(386003)(53936002)(2906002)(14454004)(97736004)(25786009)(74316002)(9686003)(55016002)(478600001)(6116002)(3846002)(66556008)(256004)(66446008)(66066001)(446003)(81156014)(6436002)(26005)(6916009)(42882007)(68736007)(81166006)(73956011)(66946007)(66476007)(71190400001)(71200400001)(44832011)(52536014)(186003)(8936002)(229853002)(486006)(476003)(5660300002)(64756008)(11346002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1038;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Bl4jvxqWbds0Ue9JL0euX8hoQ+Ii6WamOqYILyURcvM3q1NMQRnYkZMEVUhJ0f12A5gS3iVAFvvyaKCYKl2VTm6XGQvQf8RRAcvSUu5VQFatOEzsxCFga1o3F7gJ7A8vwRRTXooPlSkLgTEm6iEaC/CdI8VIQrdFTBzjSgwdEben8EPHj0MXhKLjMeqtX3I3fR4Gx0/GBEpyxdUcycZ+wJTYsNlP2jqfP6OXS9DNlzFwVPwKHDACemDoMBDem/3CTtmKx1NqurIyuylBF5sM47KJ3skwxt8SoehQa6zATbMNymkj/Vcgsma2Rx+nLTgOCK4rijP/jS8cawNHVyFT82rmbF6foNchm07LDGd2y6mLypNMcqhnqorO3JuiuKBDEh2aZWFfDKqv2hcaIoJARuVhNa6b7ZCjN9NbR18afk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d77f17-d5a2-4b99-ceda-08d6c9047a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:30:38.6454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNClNlcmdlIFNlbWluIHdyb3RlOg0KPiBCZWZvcmUgYm9vdG1lbSB3YXMgY29tcGxl
dGVseSByZW1vdmVkIGZyb20gdGhlIGtlcm5lbCwgdGhlIGxhc3QgbG9vcA0KPiBpbiB0aGUgYm9v
dG1lbV9pbml0KCkgaGFkIGJlZW4gdXNlZCB0byByZXNlcnZlIHRoZSBjb3JyZXNwb25kaW5nbHkN
Cj4gbWFya2VkIHJlZ2lvbnMsIGluaXRpYWxpemUgc3BhcnNlbWVtIHNlY3Rpb25zIGFuZCB0byBm
cmVlIHRoZSBsb3cgbWVtb3J5DQo+IHBhZ2VzLCB3aGljaCB0aGVuIHdvdWxkIGJlIHVzZWQgZm9y
IGVhcmx5IG1lbW9yeSBhbGxvY2F0aW9ucy4gQWZ0ZXIgdGhlDQo+IGJvb3RtZW0gcmVtb3Zpbmcg
cGF0Y2hzZXQgaGFkIGJlZW4gbWVyZ2VkIHRoZSBsb29wIHdhcyBsZWZ0IHRvIGRvIHRoZSBmaXJz
dA0KPiB0d28gdGhpbmdzIG9ubHkuIEJ1dCBpdCBkaWRuJ3QgZG8gdGhlbSBxdWl0ZSB3ZWxsLg0K
PiANCj4gRmlyc3Qgb2YgYWxsIGl0IGxlYXZlcyB0aGUgQk9PVF9NRU1fSU5JVF9SQU0gbWVtb3J5
IHR5cGVzIHVucmVzZXJ2ZWQsDQo+IHdoaWNoIGlzIGRlZmluaXRlbHkgYnVnIChhbHRob3VnaCBp
dCBpc24ndCBub3RpY2VhYmxlIGR1ZSB0byBiZWluZyB1c2VkDQo+IGJ5IHRoZSBrZXJuZWwgcmVn
aW9uIG9ubHksIHdoaWNoIGlzIGZ1bGx5IG1hcmtlZCBhcyByZXNlcnZlZCkuIFNlY29uZGx5DQo+
IHRoZSByZXNlcnZhdGlvbiBpcyBzdXBwb3NlZCB0byBiZSBkb25lIGZvciBhbnkgbWVtb3J5IGlu
Y2x1ZGluZyB0aGUNCj4gaGlnaCBvbmUuIChJIGNvdWxkbid0IGZpZ3VyZSBvdXQgd2h5IHRoZSBo
aWdobWVtIHdhcyBpZ25vcmVkIGluIHRoZSBmaXJzdA0KPiBwbGFjZSwgc2luY2UgcGxhdGZvcm1z
IGFuZCBkdHMnIG1heSBkZWNsYXJlIGFueSBtZW1vcnkgcmVnaW9uIGZvcg0KPiByZXNlcnZhdGlv
bikgVGhpcmRseSB0aGUgcmVzZXJ2ZWRfZW5kIHZhcmlhYmxlIGhhZCBiZWVuIHVzZWQgaGVyZSB0
byBub3QNCj4gYWNjaWRlbnRhbGx5IGZyZWUgbWVtb3J5IG9jY3VwaWVkIGJ5IGtlcm5lbC4gU2lu
Y2Ugd2UgYWxyZWFkeSByZXNlcnZlZCB0aGUNCj4gY29ycmVzcG9uZGluZyByZWdpb24gaGlnaGVy
IGluIHRoaXMgbWV0aG9kIHRoZXJlIGlzIG5vIG5lZWQgaW4gdXNpbmcgdGhlDQo+IHZhcmlhYmxl
IGhlcmUgYW55bW9yZS4gRm91cnRobHkgdGhlIHNwYXJzZW1lbSBzaG91bGQgYmUgYXdhcmUgb2Yg
YWxsIHRoZQ0KPiBtZW1vcnkgdHlwZXMgaW4gdGhlIHN5c3RlbSBpbmNsdWRpbmcgdGhlIFJPTV9E
QVRBIGV2ZW4gaWYgaXQgaXMgZ29pbmcgdG8NCj4gYmUgcmVzZXJ2ZWQgZm9yIHRoZSB3aG9sZSBz
eXN0ZW0gdXB0aW1lLiBGaW5hbGx5IGFmdGVyIGFsbCB0aGVzZSBub3RlcyBhcmUNCj4gZml4ZWQg
dGhlIGxvb3Agb2YgbWVtb3J5IHJlc2VydmF0aW9uIGNhbiBiZSBmcmVlbHkgbWVyZ2VkIGludG8g
dGhlIG1lbW9yeQ0KPiBpbnN0YWxsYXRpb24gbG9vcCBhcyBpdCdzIGRvbmUgaW4gdGhpcyBwYXRj
aC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWls
LmNvbT4NCg0KQXBwbGllZCB0byBtaXBzLW5leHQuDQoNClRoYW5rcywNCiAgICBQYXVsDQoNClsg
VGhpcyBtZXNzYWdlIHdhcyBhdXRvLWdlbmVyYXRlZDsgaWYgeW91IGJlbGlldmUgYW55dGhpbmcg
aXMgaW5jb3JyZWN0DQogIHRoZW4gcGxlYXNlIGVtYWlsIHBhdWwuYnVydG9uQG1pcHMuY29tIHRv
IHJlcG9ydCBpdC4gXQ0K
