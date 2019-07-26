Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC416C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B9620838
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="gBkAyB98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfGZShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:37:16 -0400
Received: from mail-eopbgr740087.outbound.protection.outlook.com ([40.107.74.87]:60576
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfGZShQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:37:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPv+xMdB1YyL8YhMajPphGi+bS9lMz6ASqai5g14MwfxNK0e5vgty+sf/HjaHykGjTEBbbUbxG+BVvONEoMClF5NkGN4eR59QoHE2587PNwV1jgHEzuCmYrjLvBamMT3FqqUTu2GVDeKipeOww4fUlj/2IqurHiyHNh6OVBgwU6SMWa9D2zkbsprk0TRsDGqLvNdKazcNUQolU+YWecbNrWsC74yCez6PsWByUF4LST2/7vdxFNh7ni8RhLCMsm7G7W+bqS1TiA//jBD8l+PWYik21PomRcdys9DGi4Lccz5V3kyek/M1AXLWM2c1HtqzRM7MtY7wNV6JmLf+dg22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9J5UrUZa4tOMEkBAR17JOXdDuSzN76JeNaAJVHnBHc=;
 b=RWtpvv1qNmCJgoY3umu9IZcvdrB2XcGeJKdbaZBExGsiUxpHapgwkLA+USQgBKRFzkSKQYdcD8MGTSoEqE3mLzrsZqpH8AT9+T8BNbqDNMD6PKPKeLGPcKFp2hbOEKm3j+SNUcvTqNE/toph7IWkgEfLjMwUeh3feIFhpdWnDflpPPSo6AICcB1vK5X5oMHc8gPprdjNM2frUpNEXSR5ellHwoz6NdYj+iZmmNMCHVbAMLl8bjRIIclhkCPtMQNnHRojaN18VN2lffGddph6HFQu5iQdKvV1KXeql2fZS04+OHGUgmiyP9fzINSfzuOWQqTvRlrURxVF6GWaJxJSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9J5UrUZa4tOMEkBAR17JOXdDuSzN76JeNaAJVHnBHc=;
 b=gBkAyB98scssyC74Ns+vzVxPbm2YeWmn6V8tUnt1XJF+i3//thjWBgCoWa1do5brPnJaVxvh/5p7+ggz2kMpCgijxIFQAzEeMaVmEXBjC9cEwczxMrcc7TefBB+RYKGPk9+mJpMMWKgIRqLYb2lHnOGqtvJpOZOk7zYCFmTV7b4=
Received: from CY4PR05MB3494.namprd05.prod.outlook.com (10.171.246.163) by
 CY4PR05MB3288.namprd05.prod.outlook.com (10.171.247.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 18:37:11 +0000
Received: from CY4PR05MB3494.namprd05.prod.outlook.com
 ([fe80::84f3:3266:347a:26bf]) by CY4PR05MB3494.namprd05.prod.outlook.com
 ([fe80::84f3:3266:347a:26bf%4]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 18:37:11 +0000
From:   Matt Helsley <mhelsley@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 04/13] recordmcount: Rewrite error/success handling
Thread-Topic: [PATCH v3 04/13] recordmcount: Rewrite error/success handling
Thread-Index: AQHVQmOIZ4Qum/C9LEe1t5ZS+gGHcKbdLwWAgAAOeAA=
Importance: high
X-Priority: 1
Date:   Fri, 26 Jul 2019 18:37:11 +0000
Message-ID: <4F0912A7-345E-46EE-B58F-CF7E8EE2AB65@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
 <316706a0e2727af0a2639b8e90366746d7a3a84a.1563992889.git.mhelsley@vmware.com>
 <20190726134523.4e7afd55@gandalf.local.home>
In-Reply-To: <20190726134523.4e7afd55@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mhelsley@vmware.com; 
x-originating-ip: [73.25.163.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0d48aa1-eab9-4fd2-868f-08d711f84575
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR05MB3288;
x-ms-traffictypediagnostic: CY4PR05MB3288:
x-microsoft-antispam-prvs: <CY4PR05MB328842863957E7AC537F4BA4A0C00@CY4PR05MB3288.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(189003)(199004)(33656002)(76176011)(2906002)(6506007)(53936002)(8936002)(6246003)(102836004)(53546011)(66066001)(316002)(54906003)(11346002)(446003)(6436002)(4326008)(6916009)(6486002)(186003)(26005)(99286004)(476003)(486006)(68736007)(2616005)(229853002)(66446008)(66556008)(86362001)(66476007)(25786009)(3846002)(6116002)(76116006)(91956017)(66946007)(5660300002)(478600001)(81686011)(14454004)(7736002)(81156014)(6512007)(305945005)(8676002)(81166006)(36756003)(14444005)(71200400001)(71190400001)(256004)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR05MB3288;H:CY4PR05MB3494.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pDAiQEW5siQp2RIvZquJpt7TkAftKk0dnRXD6NiHNmoycQvE4yeLemEv7xqlKRaYEShedKiM5SubKna/mLRheS6mzIWr8y0RPFFw3MeufcRKm5YNwfss5xftNvuwXnkUzykwit/zYuK8n4QnWUpGk0p579xAYAYwh2RntATUQLpOjQyo/Z24Zxtld3/gNgQvPEhh2YcBLzJP/1Fa0eYh8gd30aRbDHmu42sMpqMBLxvkr9kBGRxAiMX2pT16nqOp6FcqgeWkV2JZoQTJpwO0q6m6j1tjuJN3rhQti/co/8zAIX0Teii3/TR7vthVnx/Me++xCXxp1n9gfJvAm2ljEiAbW5DcPK+YD5TA+IAjAB/DlS9yodhqlBrAw3m/v402YUHheGH0xbbJXXHM7DrxbTMPrQ8oDYbNo+NSWHAENx0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E54000B342538B4FA40C6E7185952517@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d48aa1-eab9-4fd2-868f-08d711f84575
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 18:37:11.0396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhelsley@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3288
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDI2LCAyMDE5LCBhdCAxMDo0NSBBTSwgU3RldmVuIFJvc3RlZHQgPHJvc3Rl
ZHRAZ29vZG1pcy5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAyNCBKdWwgMjAxOSAxNDowNDo1
OCAtMDcwMA0KPiBNYXR0IEhlbHNsZXkgPG1oZWxzbGV5QHZtd2FyZS5jb20+IHdyb3RlOg0KPiAN
Cj4gDQo+IEhpIE1hdHQsDQo+IA0KPiBBcyBJJ20gYXBwbHlpbmcgdGhlc2UgZm9yIHJlYWwsIEkn
bSB0YWtpbmcgYSBkZWVwZXIgbG9vayBhdCB0aGUNCj4gcGF0Y2hlcy4gVGhpcyBvbmUgSSBoYXZl
IHNvbWUgcXVlc3Rpb25zIGFib3V0Lg0KPiANCj4+IFJlY29yZG1jb3VudCB1c2VzIHNldGptcC9s
b25nam1wIHRvIG1hbmFnZSBjb250cm9sIGZsb3cgYXMNCj4+IGl0IHJlYWRzIGFuZCB0aGVuIHdy
aXRlcyB0aGUgRUxGIGZpbGUuIFRoaXMgdW51c3VhbCBjb250cm9sDQo+PiBmbG93IGlzIGhhcmQg
dG8gZm9sbG93IGFuZCBjaGVjayBpbiBhZGRpdGlvbiB0byBiZWluZyB1bmxpa2UNCj4+IGtlcm5l
bCBjb2Rpbmcgc3R5bGUuDQo+PiANCj4+IFNvIHdlIHJld3JpdGUgdGhlc2UgcGF0aHMgdG8gdXNl
IHJlZ3VsYXIgcmV0dXJuIHZhbHVlcyB0bw0KPj4gaW5kaWNhdGUgZXJyb3Ivc3VjY2Vzcy4gV2hl
biBhbiBlcnJvciBvciBwcmV2aW91c2x5LWNvbXBsZXRlZCBvYmplY3QNCj4+IGZpbGUgaXMgZm91
bmQgd2UgcmV0dXJuIGFuIGVycm9yIGNvZGUgZm9sbG93aW5nIGtlcm5lbA0KPj4gY29kaW5nIGNv
bnZlbnRpb25zIC0tIG5lZ2F0aXZlIGVycm9yIHZhbHVlcyBhbmQgMCBmb3Igc3VjY2VzcyB3aGVu
DQo+PiB3ZSdyZSBub3QgcmV0dXJuaW5nIGEgcG9pbnRlci4gV2UgcmV0dXJuIE5VTEwgZm9yIHRo
b3NlIHRoYXQgZmFpbA0KPj4gYW5kIHJldHVybiBub24tTlVMTCBwb2ludGVycyBvdGhlcndpc2Uu
DQo+PiANCj4+IE9uZSBvZGRpdHkgaXMgYWxyZWFkeV9oYXNfcmVsX21jb3VudCAtLSB0aGVyZSB3
ZSB1c2UgcG9pbnRlciBjb21wYXJpc29uDQo+PiByYXRoZXIgdGhhbiBzdHJpbmcgY29tcGFyaXNv
biB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4NCj4+IHByZXZpb3VzbHktcHJvY2Vzc2VkIG9iamVj
dCBmaWxlcyBhbmQgcmV0dXJuaW5nIHRoZSBuYW1lIG9mIGEgdGV4dA0KPj4gc2VjdGlvbi4NCj4g
DQo+IFRoaXMgaXMgZmluZSwgYnV0IGl0J3MgZ290IGEgc3RyYW5nZSBpbXBsZW1lbnRhdGlvbi4N
Cj4gDQo+IA0KPiANCj4+IGRpZmYgLS1naXQgYS9zY3JpcHRzL3JlY29yZG1jb3VudC5oIGIvc2Ny
aXB0cy9yZWNvcmRtY291bnQuaA0KPj4gaW5kZXggYzFlMWIwNGI0ODcxLi45MDlhM2U0Nzc1YzIg
MTAwNjQ0DQo+PiAtLS0gYS9zY3JpcHRzL3JlY29yZG1jb3VudC5oDQo+PiArKysgYi9zY3JpcHRz
L3JlY29yZG1jb3VudC5oDQo+PiBAQCAtMjQsNyArMjQsOSBAQA0KPj4gI3VuZGVmIG1jb3VudF9h
ZGp1c3QNCj4+ICN1bmRlZiBzaWZ0X3JlbF9tY291bnQNCj4+ICN1bmRlZiBub3BfbWNvdW50DQo+
PiArI3VuZGVmIG1pc3Npbmdfc3ltDQo+PiAjdW5kZWYgZmluZF9zZWNzeW1fbmR4DQo+PiArI3Vu
ZGVmIGFscmVhZHlfaGFzX3JlbF9tY291bnQNCj4gDQo+IFdoeSBkbyB3ZSBuZWVkIHRoZXNlIGFz
IGRlZmluZXM/IENhbid0IHlvdSBqdXN0IGhhdmUgYSBzaW5nbGU6DQo+IA0KPiBjb25zdCBjaGFy
ICphbHJlYWR5X2hhc19tY291bnQgPSAic3VjY2VzcyI7DQo+IA0KPiBpbiByZWNvcmRtY291bnQu
YyBiZWZvcmUgcmVjb3JkbWNvdW50LmggaXMgaW5jbHVkZWQ/DQo+IA0KPiBBbmQgc2FtZSBmb3Ig
bWlzc2luZ19zeW0uDQoNClllcywgdGhhdOKAmXMgYSBnb29kIHBvaW50LiBJ4oCZdmUgYmVlbiB0
cnlpbmcgdG8gc2VwYXJhdGUgdGhlIGNoYW5nZXMgdG8gdGhlIGZ1bmN0aW9ucw0KZnJvbSBtb3Zp
bmcgcGFydHMgb3V0IGJ1dCBpbiB0aGlzIGNhc2UgaXQgd291bGQgbWFrZSBqdXN0IGFzIG11Y2gg
c2Vuc2UgdG8gYWRkIHRoZW0gdG8gcmVjb3JkbWNvdW50LmMgaW4gdGhlIGZpcnN0IHBsYWNlLg0K
DQpVbHRpbWF0ZWx5LCB0aGlzIHVnbGluZXNzIGdldHMgcmVtb3ZlZCBhcyB0aGUgbmV4dCBzZXJp
ZXMgcmVtb3ZlcyByZWNvcmRtY291bnQuaCBlbnRpcmVseSBhbmQgb25lIG9mIHRoZSBzdGVwcyBp
cyBtb3ZpbmcgZmluZF9zZWNzeW1fbmR4KCkgb3V0IHdoaWxlIGVsaW1pbmF0aW5nIHRoZXNlIHJl
ZHVuZGFudCBwaWVjZXMuDQoNCj4gDQo+IEFub3RoZXIsIHByb2JhYmx5IG1vcmUgcm9idXN0IHdh
eSBvZiBkb2luZyB0aGlzLCBpcyBjaGFuZ2UNCj4gZmluZF9zZWNzeW1fbmR4KCkgdG8gcmV0dXJu
IDAgb24gc3VjY2VzcyBhbmQgLTEgb24gbWlzc2luZyBzeW1ib2wsIGFuZA0KPiBqdXN0IHBhc3Mg
YSBwb2ludGVyIGJ5IHJlZmVyZW5jZSB0byBmaWxsIHRoZSByZWNzeW0gKHdoaWNoIGRvZXNuJ3Qg
aGF2ZQ0KPiB0byBiZSBhIGNvbnN0YW50KS4NCg0KVGhhdOKAmXMgZWFzeSBlbm91Z2ggdG8gZG8g
IGFuZCAgSSBkbyBsaWtlIHNlcGFyYXRpbmcgdGhlIGVycm9yL3N1Y2Nlc3MgcmV0dXJuIGZyb20g
cmV0dXJuaW5nICB0aGUgaW5kZXguIEkgY2FuIHNlbmQgdGhhdCBvdXQgbm93IG9yIHRhY2sgaXQg
b250byB0aGUgbmV4dCBSRkMgc2VyaWVzIEnigJltIGFib3V0IHRvIHNlbmQgd2hpY2ggY29tcGxl
dGVzIHRoZSBjb252ZXJzaW9uIGlmIHRoYXTigJlzIHByZWZlcmFibGUuDQoNClllYWgsIHRoZSBv
cmlnaW5hbCBjb2RlIGFwcGxpZXMg4oCcY29uc3TigJ0gaW4gbG90cyBvZiBwbGFjZXMgLS0gSSBw
cmVzdW1lIGl04oCZcyBhbiBhdHRlbXB0IHRvIGVlayBvdXQgZXZlcnkgbGFzdCBiaXQgb2YgcGVy
Zm9ybWFuY2UgZnJvbSB0aGUgY29tcGlsZXIuDQoNCkNoZWVycywNCiAgICAgLU1hdHQ=
