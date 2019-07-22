Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22017C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDA0214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfGVKjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:39:17 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:54601 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbfGVKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:39:17 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Mon, 22 Jul 2019 10:39:11 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 22 Jul 2019 10:38:49 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 22 Jul 2019 10:38:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGT3tbI/TdQ8/1b0BNeh/xBuqdOh5OiFnZxvrxs54O3qN9Ui+xXl8fMda0JFtAnwp7Ut2/Q7uIzMakyPLFtOQ4cYJl+G8iy/guBam+grDEi0y52/wHmT5oux6r0ybM2YNdi+uLwp+EZCOmbt3B0smDibL4BNiswkuISN8sb4n+FEEtQ/Uztc3N4/1lo+i6kwKgA+O4sr0SuRi4vyIOLN9LiBf0moS5OL8jN99Ea9j1/PefdF/tk8DdW+9r4dwNA7Zx931UxCl1f7KdtQsSZ/LMNJPa58+Jqgv45Sn6+nyxXoW7dlYj4onvPW6pOXb6nQpgBG1aleyV4k1eNbXdcwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjvYv2xQuhBrfiJC5oMIs/A/uGCm9CVcRdLcr0pcB9s=;
 b=l0MZLS69ptxoSxB8oa1/aOAginwiSDWuHElQ+aY0IWkXReCcaJ561Y2r2+b6zIJMdLNfs+J11KlLPKI+gWnsbqoq/B893d2Cul7tOFrloAcDSQck44/U79qpP6NRHMZrYLGBY7PBtOZ0JMqgHFU5RgpmfK7fJHfIJPrXxc5yCL0mIZqET8zp7uTWOQBDeomz9GIJUwDtAPar6B43ZzxU6930BEGW/Gl91L/U8jpAbSmNOojBZ6r8JuWeFSNPcAASsrql/w/CSYEq+qkgssRbTGdgXJl2YSPNsHjnc2Ba3M16ybhS3jzpnuzHiI2BPdW2tqgyIvMfDsCVmbsuo/sxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from DM6PR18MB3401.namprd18.prod.outlook.com (10.255.174.218) by
 DM6PR18MB3146.namprd18.prod.outlook.com (10.255.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 10:38:48 +0000
Received: from DM6PR18MB3401.namprd18.prod.outlook.com
 ([fe80::1fe:35f6:faf3:78c7]) by DM6PR18MB3401.namprd18.prod.outlook.com
 ([fe80::1fe:35f6:faf3:78c7%7]) with mapi id 15.20.2073.012; Mon, 22 Jul 2019
 10:38:48 +0000
From:   Jan Beulich <JBeulich@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
CC:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
Thread-Topic: [PATCH] vsyscall: use __iter_div_u64_rem()
Thread-Index: AQHVQHXOiVUIEYK0K0OeYsFGCBwTqqbWclWA
Date:   Mon, 22 Jul 2019 10:38:48 +0000
Message-ID: <8f01be52-3235-644d-4afc-df979bfce25e@suse.com>
References: <20190710130206.1670830-1-arnd@arndb.de>
 <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
 <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
 <alpine.DEB.2.21.1907221207000.1782@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907221207000.1782@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0199.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::19) To DM6PR18MB3401.namprd18.prod.outlook.com
 (2603:10b6:5:1cc::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JBeulich@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [87.234.252.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db215d13-893f-4ecc-26c6-08d70e90c759
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR18MB3146;
x-ms-traffictypediagnostic: DM6PR18MB3146:
x-microsoft-antispam-prvs: <DM6PR18MB314656ED0040DF55DFE3FD48B3C40@DM6PR18MB3146.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(54534003)(31696002)(14454004)(81166006)(305945005)(52116002)(26005)(99286004)(5660300002)(2616005)(6246003)(53936002)(446003)(68736007)(7736002)(36756003)(11346002)(2906002)(3846002)(6116002)(81156014)(86362001)(8936002)(76176011)(6512007)(66066001)(66446008)(64756008)(110136005)(256004)(14444005)(6436002)(102836004)(25786009)(316002)(71190400001)(71200400001)(4326008)(66476007)(476003)(66946007)(6486002)(186003)(66556008)(478600001)(8676002)(54906003)(31686004)(486006)(80792005)(229853002)(53546011)(6506007)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR18MB3146;H:DM6PR18MB3401.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HXUmAMuEcNP7ffbesKOfqyleUpRCY/Z6CrgDJ5aWETDpLolUGf7rEHx1mswIv3pLzv3nwYe3nhtRqSDHaASi6KZX5R0+B35lfGLQyx7jEan2yqKjNUc6J8SlWdh8OpLWdLwsCCbEvFBYJznXb4QvWBcMCu9gB7et93YCxZrm2MfZxQwS4ooJNKNFgDcplRVZomYZXvILX/FTr3NV+cf8Fn4EDX/4NFYc1TY+Ndub3VHRT9LJU0pmSbxdNBwBvEoSuvowMj5r9VKdC2RqWpwKdvT4u05UY0bZwduHqky6LSqbbXS0FKXkqXsdx8ipdVrXcRNgd09Lh/S6ppjSzIX+r4eJpZlW9R1mcnDTTl9NhjoPHHSpaKgIRIKj9sPCezDQhKaNvgY4twZgAXd4Vb2ctn1ABwGvGiElYR3ULMlCJ8Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE4F71547DB1104090F8B9DBF80A98A2@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db215d13-893f-4ecc-26c6-08d70e90c759
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 10:38:48.0751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBeulich@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3146
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDcuMjAxOSAxMjoxMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBPbiBUaHUsIDEx
IEp1bCAyMDE5LCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiANCj4gVHJpbW1lZCBDQyBsaXN0IGFu
ZCBhZGRlZCBKYW4NCj4gDQo+PiBTZWUgYmVsb3cgZm9yIHRoZSBwYXRjaCBJIGFtIHVzaW5nIGxv
Y2FsbHkgdG8gd29yayBhcm91bmQgdGhpcy4NCj4+IFRoYXQgcGF0Y2ggaXMgcHJvYmFibHkgd3Jv
bmcsIHNvIEkgaGF2ZSBub3Qgc3VibWl0dGVkIGl0IHlldCwgYnV0IGl0DQo+PiBnaXZlcyB5b3Ug
YSBjbGVhbiBidWlsZCA7LSkNCj4+DQo+PiAgICAgICBBcm5kDQo+PiA4PC0tLQ0KPj4gU3ViamVj
dDogW1BBVENIXSB4ODY6IHBlcmNwdTogZml4IGNsYW5nIDMyLWJpdCBidWlsZA0KPj4NCj4+IGNs
YW5nIGRvZXMgbm90IGxpa2UgYW4gaW5saW5lIGFzc2VtYmx5IHdpdGggYSAiPXEiIGNvbnRyYWlu
dCBmb3INCj4+IGEgNjQtYml0IG91dHB1dDoNCj4+DQo+PiBhcmNoL3g4Ni9ldmVudHMvcGVyZl9l
dmVudC5oOjgyNDoyMTogZXJyb3I6IGludmFsaWQgb3V0cHV0IHNpemUgZm9yDQo+PiBjb25zdHJh
aW50ICc9cScNCj4+ICAgICAgICAgIHU2NCBkaXNhYmxlX21hc2sgPSBfX3RoaXNfY3B1X3JlYWQo
Y3B1X2h3X2V2ZW50cy5wZXJmX2N0cl92aXJ0X21hc2spOw0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF4NCj4+IGluY2x1ZGUvbGludXgvcGVyY3B1LWRlZnMuaDo0NDc6Mjogbm90ZTog
ZXhwYW5kZWQgZnJvbSBtYWNybyAnX190aGlzX2NwdV9yZWFkJw0KPj4gICAgICAgICAgcmF3X2Nw
dV9yZWFkKHBjcCk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCj4+ICAgICAgICAgIF4NCj4+IGluY2x1ZGUvbGludXgvcGVyY3B1LWRlZnMuaDo0MjE6Mjg6
IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ3Jhd19jcHVfcmVhZCcNCj4+ICAgI2RlZmluZSBy
YXdfY3B1X3JlYWQocGNwKQ0KPj4gX19wY3B1X3NpemVfY2FsbF9yZXR1cm4ocmF3X2NwdV9yZWFk
XywgcGNwKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+
PiBpbmNsdWRlL2xpbnV4L3BlcmNwdS1kZWZzLmg6MzIyOjIzOiBub3RlOiBleHBhbmRlZCBmcm9t
IG1hY3JvDQo+PiAnX19wY3B1X3NpemVfY2FsbF9yZXR1cm4nDQo+PiAgICAgICAgICBjYXNlIDE6
IHBzY3JfcmV0X18gPSBzdGVtIyMxKHZhcmlhYmxlKTsgYnJlYWs7ICAgICAgICAgICAgICAgICAg
XA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPj4gPHNjcmF0Y2ggc3BhY2U+
OjM1NzoxOiBub3RlOiBleHBhbmRlZCBmcm9tIGhlcmUNCj4+IHJhd19jcHVfcmVhZF8xDQo+PiBe
DQo+PiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJjcHUuaDozOTQ6MzA6IG5vdGU6IGV4cGFuZGVk
IGZyb20gbWFjcm8gJ3Jhd19jcHVfcmVhZF8xJw0KPj4gICAjZGVmaW5lIHJhd19jcHVfcmVhZF8x
KHBjcCkgICAgICAgICAgICAgcGVyY3B1X2Zyb21fb3AoLCAibW92IiwgcGNwKQ0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+PiBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9wZXJjcHUuaDoxODk6MTU6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ3BlcmNwdV9m
cm9tX29wJw0KPj4gICAgICAgICAgICAgICAgICAgICAgOiAiPXEiIChwZm9fcmV0X18pICAgICAg
ICAgICAgICAgICAgXA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+Pg0KPj4g
QWNjb3JkaW5nIHRvIHRoZSBjb21taXQgdGhhdCBpbnRyb2R1Y2VkIHRoZSAicSIgY29uc3RyYWlu
dCwgdGhpcyB3YXMNCj4+IG5lZWRlZCB0byBmaXggbWlzY29tcGlsYXRpb24sIGJ1dCBpdCBnaXZl
cyBubyBmdXJ0aGVyIGRldGFpbC4NCj4gDQo+IEphbiwgZG8geW91IGhhdmUgYW55IG1lbW9yeSB3
aHkgeW91IGFkZGVkIHRob3NlICdxJyBjb25zdHJhaW50cz8gVGhlDQo+IGNoYW5nZWxvZyBvZiAz
YzU5ODc2NmEyYmEgaXMgbm90IHJlYWxseSBoZWxwZnVsLg0KDQoicSIgd2FzIHVzZWQgaW4gdGhh
dCBjb21taXQgZXhjbHVzaXZlbHkgZm9yIGJ5dGUgc2l6ZWQgb3BlcmFuZHMsIHNpbXBseQ0KYmVj
YXVzZSB0aGF0IF9pc18gdGhlIGNvbnN0cmFpbnQgdG8gdXNlIGluIHN1Y2ggY2FzZXMuIFVzaW5n
ICJyIiBpcw0Kd3Jvbmcgb24gMzItYml0LCBhcyBpdCB3b3VsZCBpbmNsdWRlIGluYWNjZXNzaWJs
ZSBieXRlIHBvcnRpb25zIG9mICVzcCwNCiVicCwgJXNpLCBhbmQgJWRpLiBUaGlzIGlzIGhvdyBp
dCdzIGRlc2NyaWJlZCBpbiBnY2Mgc291cmNlcyAvIGRvY3M6DQoNCiAgIkFueSByZWdpc3RlciBh
Y2Nlc3NpYmxlIGFzIEBjb2Rle0B2YXJ7cn1sfS4gIEluIDMyLWJpdCBtb2RlLCBAY29kZXthfSwN
CiAgIEBjb2Rle2J9LCBAY29kZXtjfSwgYW5kIEBjb2Rle2R9OyBpbiA2NC1iaXQgbW9kZSwgYW55
IGludGVnZXIgcmVnaXN0ZXIuIg0KDQpXaGF0IEknbSBzdHJ1Z2dsaW5nIHdpdGggaXMgd2h5IGNs
YW5nIHdvdWxkIGV2YWx1YXRlIHRoYXQgYXNtKCkgaW4gdGhlDQpmaXJzdCBwbGFjZSB3aGVuIGEg
NjQtYml0IGZpZWxkIChwZXJmX2N0cl92aXJ0X21hc2spIGlzIGJlaW5nIGFjY2Vzc2VkLg0KDQpK
YW4NCg==
