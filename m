Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F42CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A342166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="pEBu/sLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438110AbfJXIUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:20:42 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:33861 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfJXIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:20:42 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2019 04:20:39 EDT
IronPort-SDR: Eqg5WgOGVY+QupJv9Kgl9ZKhGqtY/1Qp5Nfhf6p0icm1KlUSllCtIn1pW2YIpQbsw8Gg1GJp8G
 AhbMPXYj6Cw4/XffAt2AMC16Bpf0QGd7H2ZLIOTKtbmKg5t9TU2D8YEN4pcnDc1sUCF3R0jAep
 AlH22WbJd+lw/IANke0gnStUEasU0mEgKY8oMz36wIYn9xGgCwzn54HKdhgvSUgrkFDB8MiIG2
 0vezZsDBSOnOI4cByR08TJYWcLA3yYFxLjfC8308eB/4wxDU7tkZJ1HuG/lJ9WjY4jYVYyKcW2
 ks8=
X-IronPort-AV: E=McAfee;i="6000,8403,9419"; a="7175570"
X-IronPort-AV: E=Sophos;i="5.68,224,1569250800"; 
   d="scan'208";a="7175570"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 24 Oct 2019 17:13:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbcOK9KDUaVVvW5d1CWnPbx9QOtcr79dT96auGPykefbPMEntOehKflOTqEy7Ayt+kIpvSJfkQbgp3fkp0zoFFwe7ZJK+eYcWnkTfsDsccmYRvqNh0dD14Az0etk4SKO8P2QAhhX9gB5z3r4lFcEsknG3BJ+UZCh8F9ofXDhtnURSYZCybRupE4xCxhL+7RR1debF3S0SKMKYQFRMAdi2Fr3DCRPZ2vq3v3NpRdZ+eL0duidHdnBw/ovqRE7B3r8syIIXJPcgULwKtl4RwggFihDoKdNRhh92/gQfZku/KKElTxxI/WnNoXF86lgiQCQz8MQ2vlln5t86OpGV1PlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8s75RSvfRe1ZZy/X+0xiJ4/86YssfLy64U+8074m5Y=;
 b=mMsK00TnXqlk0jdOlIPR1X77o7uEpckmpo033pCQCApi/9Gc+RbwK+aT33grfKrkVlj8N8QO9pE+ELaAu+Qs+SzM7djBWTshfCwadIffm+rf/5DH5mGBsyEWvOI5ztXw+VHyCTo5rHHhgYwFmoWoLVJ10qqt2eu74Oqg4dAm6+GCB9sRRugjR2Jl2diC7qwBf90kZSjGzkbZnueEND1LTuKlzYkSY6E5vMNe+y+B4kWIU6BrW3YbRKv+97ecbFhDhTKAwJwMsKJS3EqmpkglAHuxPpsjuCf6J8fPpBXX5GimMG67VltHVMp+heBzLIor2mduL0M3eEYF+eAB5YCNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8s75RSvfRe1ZZy/X+0xiJ4/86YssfLy64U+8074m5Y=;
 b=pEBu/sLaYsUrU4xpK3shZdg87kYlDcfbKsOeoC1XF1DIBrUSgkeGzsln5Yi0Uh/KnH9b4WqlZe+DvcOl1AIggBnFYdzwubqHxHfYnNE4LW1Lyvca3wWVtwzBuuyDGzxZXUKkkPaOKapvBQb/SSa2eBlucFoxeCZ+DLRvHu3iUMk=
Received: from OSBPR01MB4006.jpnprd01.prod.outlook.com (20.178.98.151) by
 OSBPR01MB2904.jpnprd01.prod.outlook.com (52.134.255.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 24 Oct 2019 08:13:25 +0000
Received: from OSBPR01MB4006.jpnprd01.prod.outlook.com
 ([fe80::312f:6595:dbaf:3997]) by OSBPR01MB4006.jpnprd01.prod.outlook.com
 ([fe80::312f:6595:dbaf:3997%6]) with mapi id 15.20.2387.021; Thu, 24 Oct 2019
 08:13:25 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     'lijiang' <lijiang@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "Thomas.Lendacky@amd.com" <Thomas.Lendacky@amd.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Thread-Topic: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Thread-Index: AQHVhM+Cbm50ENbYUECvtoh7tgD3AqdmXDyAgAFhaICAAbwmMA==
Date:   Thu, 24 Oct 2019 08:13:25 +0000
Message-ID: <OSBPR01MB4006F33096F5E0AB8B8E648D956A0@OSBPR01MB4006.jpnprd01.prod.outlook.com>
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-2-lijiang@redhat.com> <20191022083015.GB31700@zn.tnic>
 <75648e8d-4ef7-0537-618e-e4a57f0d3b9b@redhat.com>
In-Reply-To: <75648e8d-4ef7-0537-618e-e4a57f0d3b9b@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=d.hatayama@fujitsu.com; 
x-originating-ip: [114.160.30.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e83ae469-f146-4d4d-316a-08d7585a0b00
x-ms-traffictypediagnostic: OSBPR01MB2904:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <OSBPR01MB29047ABBA6C53C8692D55DAF956A0@OSBPR01MB2904.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(13464003)(189003)(199004)(99286004)(8676002)(14454004)(478600001)(81166006)(81156014)(14444005)(6116002)(2906002)(229853002)(3846002)(7416002)(966005)(256004)(25786009)(446003)(33656002)(305945005)(54906003)(55016002)(26005)(74316002)(85182001)(86362001)(102836004)(6916009)(7736002)(9686003)(6306002)(6246003)(5660300002)(71200400001)(71190400001)(316002)(76176011)(4326008)(11346002)(52536014)(186003)(476003)(7696005)(8936002)(66476007)(6436002)(66446008)(6506007)(66066001)(53546011)(76116006)(64756008)(66946007)(66556008)(486006)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB2904;H:OSBPR01MB4006.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mB2yl/t+yibZ9ceoAW51yOgatFRMMcDFAu+RlPmux3kLjouSFwbnKVO7q62lFUNH5X7uLERxk0uL5xirzzxv7P4LYQ0TiNvJPC7sMUijUf9A0DHtPE+O9dMeKp/2p44O1PO+VC6KQ+NLhyjJztvjmnDAVFVzIUYm+79tiUYN2JGyzqROx8Bb7wIRGgWIaLA3tZLQrrAdVqRKvPIMvZFnRXhAdxwC7sAlg0WMvjJQzBH7zGH+wZTD01+E2+KmrXd7w+J8tN+4kAC6UJiS9D4BV95cStufPCyk56dATUddXPVEvtI3PaLteEXOZVA/0gmuhRdX0ESItv7Q9kbOz6CxJh/4MVQg+ZNWEbZljzY5NJnB8j/wznfS6eqjJurFtItMLSN/egBEd8YrTCIvnnQoOmZG2V2hE2Sn2DvIsaQuQ8DFjdrU+TE0wuWqVYyQLNRr2rr5/w6LBCqVBUJngISHO+uNGJ+DBhnG6VKLkiyz9rw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83ae469-f146-4d4d-316a-08d7585a0b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 08:13:25.0397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++f6WXCWyhF0AG2Fu5NlhZjCpPQVzWoRXB8OXrI1ea9P6ZF9lKgBnR0xM8Ye8ecjdRzV7nmKVrlOZhVoVuqyN1a66789J0rYQLaoqSCaixE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2904
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBkb24ndCBmaW5kIHRoZSBjb3JyZXNwb25kaW5nIHBhdGNoIGluIHRoZSB2NSBwYXRjaHNldCwg
c28gSSBjb21tZW50IGhlcmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogbGludXgta2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4LWtl
cm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBsaWppYW5nDQo+IFNlbnQ6
IFdlZG5lc2RheSwgT2N0b2JlciAyMywgMjAxOSAyOjM1IFBNDQo+IFRvOiBCb3Jpc2xhdiBQZXRr
b3YgPGJwQGFsaWVuOC5kZT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHRn
bHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsNCj4gaHBhQHp5dG9yLmNvbTsgeDg2
QGtlcm5lbC5vcmc7IGJoZUByZWRoYXQuY29tOyBkeW91bmdAcmVkaGF0LmNvbTsNCj4gamdyb3Nz
QHN1c2UuY29tOyBkaG93ZWxsc0ByZWRoYXQuY29tOyBUaG9tYXMuTGVuZGFja3lAYW1kLmNvbTsN
Cj4gZWJpZWRlcm1AeG1pc3Npb24uY29tOyB2Z295YWxAcmVkaGF0LmNvbTsga2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMyB2NF0geDg2L2tkdW1wOiBh
bHdheXMgcmVzZXJ2ZSB0aGUgbG93IDFNaUIgd2hlbiB0aGUNCj4gY3Jhc2hrZXJuZWwgb3B0aW9u
IGlzIHNwZWNpZmllZA0KPiANCj4g5ZyoIDIwMTnlubQxMOaciDIy5pelIDE2OjMwLCBCb3Jpc2xh
diBQZXRrb3Yg5YaZ6YGTOg0KPiA+IFRoaXMgaWZkZWZmZXJ5IG5lZWRzIHRvIGJlIGEgZnVuY3Rp
b24gaW4ga2VybmVsL2tleGVjX2NvcmUuYyB3aGljaCBpcw0KPiA+IGNhbGxlZCBieSByZXNlcnZl
X3JlYWxfbW9kZSgpLCBpbnN0ZWFkLg0KPiANCj4gV291bGQgeW91IG1pbmQgaWYgaSBpbXByb3Zl
IHRoaXMgcGF0Y2ggYXMgZm9sbG93PyBUaGFua3MuDQo+IA0KPiBGcm9tIDU4MDRhYmVjNjIyNzk1
ODVmMzc0ZDc4YWNlMTI1MDUwNWM0NGM2YjcgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQo+IEZy
b206IExpYW5ibyBKaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPg0KPiBEYXRlOiBXZWQsIDIzIE9j
dCAyMDE5IDExOjI3OjA0ICswODAwDQo+IFN1YmplY3Q6IFtQQVRDSF0geDg2L2tkdW1wOiBhbHdh
eXMgcmVzZXJ2ZSB0aGUgbG93IDFNaUIgd2hlbiB0aGUgY3Jhc2hrZXJuZWwNCj4gIG9wdGlvbiBp
cyBzcGVjaWZpZWQNCj4gDQo+IEtkdW1wIGtlcm5lbCB3aWxsIHJldXNlIHRoZSBmaXJzdCA2NDBr
IHJlZ2lvbiBiZWNhdXNlIHRoZSByZWFsIG1vZGUNCj4gdHJhbXBvbGluZSBoYXMgdG8gd29yayBp
biB0aGlzIGFyZWEuIFdoZW4gdGhlIHZtY29yZSBpcyBkdW1wZWQsIHRoZQ0KPiBvbGQgbWVtb3J5
IGluIHRoaXMgYXJlYSBtYXkgYmUgYWNjZXNzZWQsIHRoZXJlZm9yZSwga2VybmVsIGhhcyB0bw0K
PiBjb3B5IHRoZSBjb250ZW50cyBvZiB0aGUgZmlyc3QgNjQwayBhcmVhIHRvIGEgYmFja3VwIHJl
Z2lvbiBzbyB0aGF0DQo+IGtkdW1wIGtlcm5lbCBjYW4gcmVhZCB0aGUgb2xkIG1lbW9yeSBmcm9t
IHRoZSBiYWNrdXAgYXJlYSBvZiB0aGUNCj4gZmlyc3QgNjQwayBhcmVhLCB3aGljaCBpcyBkb25l
IGluIHRoZSBwdXJnYXRvcnkoKS4NCj4gDQo+IEJ1dCwgdGhlIGN1cnJlbnQgaGFuZGxpbmcgb2Yg
Y29weWluZyB0aGUgZmlyc3QgNjQwayBhcmVhIHJ1bnMgaW50bw0KPiBwcm9ibGVtcyB3aGVuIFNN
RSBpcyBlbmFibGVkLCBrZXJuZWwgZG9lcyBub3QgcHJvcGVybHkgY29weSB0aGVzZQ0KPiBvbGQg
bWVtb3J5IHRvIHRoZSBiYWNrdXAgYXJlYSBpbiB0aGUgcHVyZ2F0b3J5KCksIHRoZXJlYnksIGtk
dW1wDQo+IGtlcm5lbCByZWFkcyBvdXQgdGhlIGVuY3J5cHRlZCBjb250ZW50cywgYmVjYXVzZSB0
aGUga2R1bXAga2VybmVsDQo+IG11c3QgYWNjZXNzIHRoZSBmaXJzdCBrZXJuZWwncyBtZW1vcnkg
d2l0aCB0aGUgZW5jcnlwdGlvbiBiaXQgc2V0DQo+IHdoZW4gU01FIGlzIGVuYWJsZWQgaW4gdGhl
IGZpcnN0IGtlcm5lbC4gUGxlYXNlIHJlZmVyIHRvIHRoaXMgbGluazoNCj4gDQo+IEJ1Z3ppbGxh
OiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNDc5Mw0KPiAN
Cj4gRmluYWxseSwgaXQgY2F1c2VzIHRoZSBmb2xsb3dpbmcgZXJyb3JzLCBhbmQgdGhlIGNyYXNo
IHRvb2wgZ2V0cw0KPiBpbnZhbGlkIHBvaW50ZXJzIHdoZW4gcGFyc2luZyB0aGUgdm1jb3JlLg0K
PiANCj4gY3Jhc2g+IGttZW0gLXN8Z3JlcCAtaSBpbnZhbGlkDQo+IGttZW06IGRtYS1rbWFsbG9j
LTUxMjogc2xhYjpmZmZmZDc3NjgwMDAxYzAwIGludmFsaWQNCj4gZnJlZXBvaW50ZXI6YTYwODZh
YzA5OWYwYzVhNA0KPiBrbWVtOiBkbWEta21hbGxvYy01MTI6IHNsYWI6ZmZmZmQ3NzY4MDAwMWMw
MCBpbnZhbGlkDQo+IGZyZWVwb2ludGVyOmE2MDg2YWMwOTlmMGM1YTQNCj4gY3Jhc2g+DQo+IA0K
PiBUbyBhdm9pZCB0aGUgYWJvdmUgZXJyb3JzLCB3aGVuIHRoZSBjcmFzaGtlcm5lbCBvcHRpb24g
aXMgc3BlY2lmaWVkLA0KPiBsZXRzIHJlc2VydmUgdGhlIHJlbWFpbmluZyBsb3cgMU1pQiBtZW1v
cnkoYWZ0ZXIgcmVzZXJ2aW5nIHJlYWwgbW9kZQ0KPiBtZW1vcnkpIHNvIHRoYXQgdGhlIGFsbG9j
YXRlZCBtZW1vcnkgZG9lcyBub3QgZmFsbCBpbnRvIHRoZSBsb3cgMU1pQg0KPiBhcmVhLCB3aGlj
aCBtYWtlcyB1cyBub3QgdG8gY29weSB0aGUgZmlyc3QgNjQwayBjb250ZW50IHRvIGEgYmFja3Vw
DQo+IHJlZ2lvbiBpbiBwdXJnYXRvcnkoKS4gVGhpcyBpbmRpY2F0ZXMgdGhhdCBpdCBkb2VzIG5v
dCBuZWVkIHRvIGJlDQo+IGluY2x1ZGVkIGluIGNyYXNoIGR1bXBzIG9yIHVzZWQgZm9yIGFueXRo
aW5nIGV4Y2VwdCB0aGUgcHJvY2Vzc29yDQo+IHRyYW1wb2xpbmVzIHRoYXQgbXVzdCBsaXZlIGlu
IHRoZSBsb3cgMU1pQi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpYW5ibyBKaWFuZyA8bGlqaWFu
Z0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gQlRXOkkgYWxzbyB0cmllZCB0byBmaXggdGhlIGFib3Zl
IHByb2JsZW0gaW4gcHVyZ2F0b3J5KCksIGJ1dCB0aGVyZQ0KPiBhcmUgdG9vIG1hbnkgcmVzdHJp
Y3RzIGluIHB1cmdhdG9yeSgpIGNvbnRleHQsIGZvciBleGFtcGxlOiBpIGNhbid0DQo+IGFsbG9j
YXRlIG5ldyBtZW1vcnkgdG8gY3JlYXRlIHRoZSBpZGVudGl0eSBtYXBwaW5nIHBhZ2UgdGFibGUg
Zm9yDQo+IFNNRSBzaXR1YXRpb24uDQo+IA0KPiBDdXJyZW50bHksIHRoZXJlIGFyZSB0d28gcGxh
Y2VzIHdoZXJlIHRoZSBmaXJzdCA2NDBrIGFyZWEgaXMgbmVlZGVkLA0KPiB0aGUgZmlyc3Qgb25l
IGlzIGluIHRoZSBmaW5kX3RyYW1wb2xpbmVfcGxhY2VtZW50KCksIGFub3RoZXIgb25lIGlzDQo+
IGluIHRoZSByZXNlcnZlX3JlYWxfbW9kZSgpLCBhbmQgdGhlaXIgY29udGVudCBkb2Vzbid0IG1h
dHRlci4NCj4gDQo+IEluIGFkZGl0aW9uLCBhbHNvIG5lZWQgdG8gY2xlYW4gYWxsIHRoZSBjb2Rl
IHJlbGF0ZWQgdG8gdGhlIGJhY2t1cA0KPiByZWdpb24gbGF0ZXIuDQo+IA0KPiAgYXJjaC94ODYv
cmVhbG1vZGUvaW5pdC5jIHwgIDIgKysNCj4gIGluY2x1ZGUvbGludXgva2V4ZWMuaCAgICB8ICAy
ICsrDQo+ICBrZXJuZWwva2V4ZWNfY29yZS5jICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9yZWFsbW9kZS9pbml0LmMgYi9hcmNoL3g4Ni9yZWFsbW9kZS9pbml0LmMNCj4gaW5kZXgg
N2RjZTM5YzhjMDM0Li4wNjRjYzc5YTAxNWQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3JlYWxt
b2RlL2luaXQuYw0KPiArKysgYi9hcmNoL3g4Ni9yZWFsbW9kZS9pbml0LmMNCj4gQEAgLTMsNiAr
Myw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21l
bWJsb2NrLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbWVtX2VuY3J5cHQuaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9rZXhlYy5oPg0KPiANCj4gICNpbmNsdWRlIDxhc20vc2V0X21lbW9yeS5oPg0KPiAg
I2luY2x1ZGUgPGFzbS9wZ3RhYmxlLmg+DQo+IEBAIC0zNCw2ICszNSw3IEBAIHZvaWQgX19pbml0
IHJlc2VydmVfcmVhbF9tb2RlKHZvaWQpDQo+IA0KPiAgCW1lbWJsb2NrX3Jlc2VydmUobWVtLCBz
aXplKTsNCj4gIAlzZXRfcmVhbF9tb2RlX21lbShtZW0pOw0KPiArCWtleGVjX3Jlc2VydmVfbG93
XzFNaUIoKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBfX2luaXQgc2V0dXBfcmVhbF9tb2Rl
KHZvaWQpDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2tleGVjLmggYi9pbmNsdWRlL2xp
bnV4L2tleGVjLmgNCj4gaW5kZXggMTc3NmViMmU0M2E0Li4zMGFjZjFkNzM4YmMgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgva2V4ZWMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2tleGVj
LmgNCj4gQEAgLTMwNiw2ICszMDYsNyBAQCBleHRlcm4gdm9pZCBfX2NyYXNoX2tleGVjKHN0cnVj
dCBwdF9yZWdzICopOw0KPiAgZXh0ZXJuIHZvaWQgY3Jhc2hfa2V4ZWMoc3RydWN0IHB0X3JlZ3Mg
Kik7DQo+ICBpbnQga2V4ZWNfc2hvdWxkX2NyYXNoKHN0cnVjdCB0YXNrX3N0cnVjdCAqKTsNCj4g
IGludCBrZXhlY19jcmFzaF9sb2FkZWQodm9pZCk7DQo+ICt2b2lkIGtleGVjX3Jlc2VydmVfbG93
XzFNaUIodm9pZCk7DQo+ICB2b2lkIGNyYXNoX3NhdmVfY3B1KHN0cnVjdCBwdF9yZWdzICpyZWdz
LCBpbnQgY3B1KTsNCj4gIGV4dGVybiBpbnQga2ltYWdlX2NyYXNoX2NvcHlfdm1jb3JlaW5mbyhz
dHJ1Y3Qga2ltYWdlICppbWFnZSk7DQo+IA0KPiBAQCAtMzk3LDYgKzM5OCw3IEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBfX2NyYXNoX2tleGVjKHN0cnVjdCBwdF9yZWdzICpyZWdzKSB7IH0NCj4gIHN0
YXRpYyBpbmxpbmUgdm9pZCBjcmFzaF9rZXhlYyhzdHJ1Y3QgcHRfcmVncyAqcmVncykgeyB9DQo+
ICBzdGF0aWMgaW5saW5lIGludCBrZXhlY19zaG91bGRfY3Jhc2goc3RydWN0IHRhc2tfc3RydWN0
ICpwKSB7IHJldHVybiAwOyB9DQo+ICBzdGF0aWMgaW5saW5lIGludCBrZXhlY19jcmFzaF9sb2Fk
ZWQodm9pZCkgeyByZXR1cm4gMDsgfQ0KPiArc3RhdGljIGlubGluZSB2b2lkIGtleGVjX3Jlc2Vy
dmVfbG93XzFNaUIodm9pZCkgeyB9DQo+ICAjZGVmaW5lIGtleGVjX2luX3Byb2dyZXNzIGZhbHNl
DQo+ICAjZW5kaWYgLyogQ09ORklHX0tFWEVDX0NPUkUgKi8NCj4gDQo+IGRpZmYgLS1naXQgYS9r
ZXJuZWwva2V4ZWNfY29yZS5jIGIva2VybmVsL2tleGVjX2NvcmUuYw0KPiBpbmRleCAxNWQ3MGE5
MGI1MGQuLjViZDg5ZjFmZWU0MiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2tleGVjX2NvcmUuYw0K
PiArKysgYi9rZXJuZWwva2V4ZWNfY29yZS5jDQo+IEBAIC0zNyw2ICszNyw3IEBADQo+ICAjaW5j
bHVkZSA8bGludXgvY29tcGlsZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9odWdldGxiLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvZnJhbWUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5o
Pg0KPiANCj4gICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9zZWN0aW9u
cy5oPg0KPiBAQCAtNzAsNiArNzEsMTggQEAgc3RydWN0IHJlc291cmNlIGNyYXNoa19sb3dfcmVz
ID0gew0KPiAgCS5kZXNjICA9IElPUkVTX0RFU0NfQ1JBU0hfS0VSTkVMDQo+ICB9Ow0KPiANCj4g
Ky8qDQo+ICsgKiBXaGVuIHRoZSBjcmFzaGtlcm5lbCBvcHRpb24gaXMgc3BlY2lmaWVkLCBvbmx5
IHVzZSB0aGUgbG93DQo+ICsgKiAxTWlCIGZvciB0aGUgcmVhbCBtb2RlIHRyYW1wb2xpbmUuDQo+
ICsgKi8NCj4gK3ZvaWQga2V4ZWNfcmVzZXJ2ZV9sb3dfMU1pQih2b2lkKQ0KPiArew0KPiArCWlm
IChzdHJzdHIoYm9vdF9jb21tYW5kX2xpbmUsICJjcmFzaGtlcm5lbD0iKSkgew0KDQpzdHJzdHIo
KSBtYXRjaGVzIGZvciBleGFtcGxlLCBBTllFWFRSQUNIQVJBQ1RFUlNjcmFzaGtlcm5lbD1BTllF
WFRSQUNIQVJBQ1RFUlMuDQoNCklzIGl0IGVub3VnaCB0byB1c2UgY21kbGluZV9maW5kX29wdGlv
bl9ib29sKCk/DQoNCj4gKwkJbWVtYmxvY2tfcmVzZXJ2ZSgwLCAxPDwyMCk7DQo+ICsJCXByX2lu
Zm8oIlJlc2VydmluZyB0aGUgbG93IDFNaUIgb2YgbWVtb3J5IGZvcg0KPiBjcmFzaGtlcm5lbFxu
Iik7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICBpbnQga2V4ZWNfc2hvdWxkX2NyYXNoKHN0cnVjdCB0
YXNrX3N0cnVjdCAqcCkNCj4gIHsNCj4gIAkvKg0KPiAtLQ0KPiAyLjE3LjENCg0K
