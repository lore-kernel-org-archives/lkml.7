Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89D5C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6C92064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="RL529QfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfG2UTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:19:22 -0400
Received: from mail-eopbgr760050.outbound.protection.outlook.com ([40.107.76.50]:12162
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbfG2UTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:19:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTcTVFuuv621FdeymNDkfbW67ZT596hQeuiZpIU9CD6tnRPbsPSNLi1OzLk5J+gejZDQpFXNArYSTrV9U1e6HdWuEnEuVgq3x+D486ey36x4eahyMQtpBHSjZWArf2xKUtBolTn9+GFm/9Dh89vV1mWP7kvMUoD1VE2xKbUz4KIHpd9zKfXxaNHbKl0onwRI1AIj4uBE6zat0J8pI8cysbw9bDKv2XlIJLH9aizmzz/qExFhM550QBl7+Xe/5p+mqxdLpkuRQxetNagCizpxGw0DAjJ8sArY3FQyqNnBn/i7aCu2ON92LFHZb3kIAE7ajlPa0asf6/BE/0x7l1Uokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku2AX2xeHMwUAqR6QKKmykWEKrefbcCIsB7R5dfmYVM=;
 b=kbjjA5t3zxxuXMan0jQkIOCpTuGIt1eiYK29UueqicSW9bCROQmJulLgZWM8dkqn3nrK/Gfs1lvNIqIKnADMeUVFVScYwHxytUvblf1s8AhunurNZAFKRtxWTuU+S8Q/P6AlNxEeSXzXq9UpoS74M1sciH01eoAuKJTVZI5jC2gPS1QJvp+JX6CDCD725MGGHNa1Jq/afsvJDUGpdYWYqmop1byFhM9p1yh6sOFFdD+6Qak9BzlOR2A3R48nHJZZLzGoclAIIszEmLxK3wHmKYtupUDZwKWCKiqsIEW6NDNYT0qIy8Ws1kXXx3+BHAZctm00MrAQq8Zz/vKQJrCdmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku2AX2xeHMwUAqR6QKKmykWEKrefbcCIsB7R5dfmYVM=;
 b=RL529QfU/APPxAj3cWto1LcPNTAZA6OyJSJ8WTXfXQQmzRLNH9C634SZ/5SIGbhtnlUAiv/yoafWpYyhK070tVfVN+VgpALQNdnE0tDZE5OHSA32S7Srye1vD9P8QJb0EHukIDIgSgu8t1EaL67Nbxnhhv1tM0rU50pBEQlxULQ=
Received: from CY4PR05MB3494.namprd05.prod.outlook.com (10.171.246.163) by
 CY4PR05MB3223.namprd05.prod.outlook.com (10.172.155.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.11; Mon, 29 Jul 2019 20:19:19 +0000
Received: from CY4PR05MB3494.namprd05.prod.outlook.com
 ([fe80::84f3:3266:347a:26bf]) by CY4PR05MB3494.namprd05.prod.outlook.com
 ([fe80::84f3:3266:347a:26bf%4]) with mapi id 15.20.2136.010; Mon, 29 Jul 2019
 20:19:19 +0000
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 10/13] objtool: Make recordmcount into an objtool
 subcmd
Thread-Topic: [PATCH v3 10/13] objtool: Make recordmcount into an objtool
 subcmd
Thread-Index: AQHVQmOPeoJWuwCabUiE8rj942+rB6bgVLCAgAG8VQA=
Importance: high
X-Priority: 1
Date:   Mon, 29 Jul 2019 20:19:19 +0000
Message-ID: <D036FA27-FA50-445D-BEFA-1CD384A7478B@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
 <13ef7e93410f99579fa9b8a44bdd313e8300b706.1563992889.git.mhelsley@vmware.com>
 <20190728174859.v767keld5x3zylq7@treble>
In-Reply-To: <20190728174859.v767keld5x3zylq7@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mhelsley@vmware.com; 
x-originating-ip: [73.25.163.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d47c6c1d-d80b-424c-0e06-08d71462096f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR05MB3223;
x-ms-traffictypediagnostic: CY4PR05MB3223:
x-microsoft-antispam-prvs: <CY4PR05MB3223F711B1B3157781BC64C1A0DD0@CY4PR05MB3223.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(14444005)(66476007)(6916009)(486006)(64756008)(66946007)(102836004)(478600001)(86362001)(66556008)(446003)(76116006)(476003)(2616005)(11346002)(99286004)(76176011)(36756003)(316002)(5660300002)(81686011)(6506007)(7736002)(53546011)(91956017)(186003)(66446008)(26005)(71200400001)(68736007)(229853002)(3846002)(6436002)(25786009)(305945005)(2906002)(6246003)(4326008)(8936002)(33656002)(54906003)(81166006)(256004)(81156014)(6116002)(8676002)(6512007)(6486002)(66066001)(71190400001)(14454004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR05MB3223;H:CY4PR05MB3494.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zIH6aBdaETYryCokhwzrlz8+GeXpPsQUAkBKXNCYXPcpmxe9+lfVQja9fusnM3qP0ivoSwnz/tZzah9rb3tWH5ly12F5oRQzct0PQV3gTruaPuUEQ0Ws/zhxfmkmL394aJGqwOCofDao4dtgd8/6/STwmkd6pURdR0vvwczshAoWH+To/dlTUvxtD/MJkpr4f7pZjhUdXkbV2/nVdrQghgSq6WgndMdSCFs3hswRHtIljTNqo1FmWGvj1CcbytnC6YrFwkZLujeuBkTDi7EBUOlbI/FwatB36GVJDBV9YGABAA23g4PlRbcLWSY/laq3oqLxzdz8lHa6zyCsEwxqhXGy3Ea7GqkBbIFmcnfbdBT94ChgDUmYjrt89H9c5PrCoGC86MbXLMxKHjsfQNCUAGvhia99vRZm91sRDVdut30=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ABD2730C82B4C4BAD58DC5FA25BA1E8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47c6c1d-d80b-424c-0e06-08d71462096f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 20:19:19.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhelsley@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDI4LCAyMDE5LCBhdCAxMDo0OCBBTSwgSm9zaCBQb2ltYm9ldWYgPGpwb2lt
Ym9lQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBKdWwgMjQsIDIwMTkgYXQgMDI6
MDU6MDRQTSAtMDcwMCwgTWF0dCBIZWxzbGV5IHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL3Njcmlw
dHMvTWFrZWZpbGUuYnVpbGQgYi9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkDQo+PiBpbmRleCAwOGI3
MGVlOTYxNGEuLjQzNzA3NDkxMzE3YyAxMDA2NDQNCj4+IC0tLSBhL3NjcmlwdHMvTWFrZWZpbGUu
YnVpbGQNCj4+ICsrKyBiL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQNCj4+IEBAIC0xNzAsMjIgKzE3
MCwyMSBAQCBlbmRpZg0KPj4gDQo+PiBpZmRlZiBDT05GSUdfRlRSQUNFX01DT1VOVF9SRUNPUkQN
Cj4+IGlmbmRlZiBDQ19VU0lOR19SRUNPUkRfTUNPVU5UDQo+PiAtIyBjb21waWxlciB3aWxsIG5v
dCBnZW5lcmF0ZSBfX21jb3VudF9sb2MgdXNlIHJlY29yZG1jb3VudCBvciByZWNvcmRtY291bnQu
cGwNCj4+IC1pZmRlZiBCVUlMRF9DX1JFQ09SRE1DT1VOVA0KPj4gKyMgY29tcGlsZXIgd2lsbCBu
b3QgZ2VuZXJhdGUgX19tY291bnRfbG9jIHVzZSBvYmp0b29sIG1jb3VudCByZWNvcmQgb3IgcmVj
b3JkbWNvdW50LnBsDQo+IA0KPiBUaGlzIGNvbW1lbnQgY291bGQgdXNlIHNvbWUgRW5nbGlzaC1p
ZmljYXRpb24sIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gIyBUaGUgY29tcGlsZXIgZG9lc24ndCBz
dXBwb3J0IGdlbmVyYXRpb24gb2YgdGhlIF9fbWNvdW50X2xvYyBzZWN0aW9uLg0KPiAjIEdlbmVy
YXRlIGl0IG1hbnVhbGx5IHdpdGggIm9ianRvb2wgbWNvdW50IHJlY29yZCIgb3IgcmVjb3JkbWNv
dW50LnBsLg0KDQpPSywgbWFrZXMgc2Vuc2UuDQoNCj4gDQo+PiBAQCAtMjM2LDkgKzIzNSwxMCBA
QCBlbmRpZiAjIFNLSVBfU1RBQ0tfVkFMSURBVElPTg0KPj4gZW5kaWYgIyBDT05GSUdfU1RBQ0tf
VkFMSURBVElPTg0KPj4gDQo+PiAjIFJlYnVpbGQgYWxsIG9iamVjdHMgd2hlbiBvYmp0b29sIGNo
YW5nZXMsIG9yIGlzIGVuYWJsZWQvZGlzYWJsZWQuDQo+PiAtb2JqdG9vbF9kZXAgPSAkKG9ianRv
b2xfb2JqKQkJCQkJXA0KPj4gK29ianRvb2xfZGVwICs9ICQob2JqdG9vbF9vYmopCQkJCQlcDQo+
PiAJICAgICAgJCh3aWxkY2FyZCBpbmNsdWRlL2NvbmZpZy9vcmMvdW53aW5kZXIuaAkJXA0KPj4g
LQkJCSBpbmNsdWRlL2NvbmZpZy9zdGFjay92YWxpZGF0aW9uLmgpDQo+PiArCQkJIGluY2x1ZGUv
Y29uZmlnL3N0YWNrL3ZhbGlkYXRpb24uaAlcDQo+PiArCQkJIGluY2x1ZGUvY29uZmlnL2Z0cmFj
ZS9tY291bnQvcmVjb3JkLmgpDQo+IA0KPiBJIHRoaW5rIHRoZSAnKz0nIGlzbid0IG5lZWRlZCBh
cyB0aGlzIGlzIHRoZSBvbmx5IHBsYWNlIG9ianRvb2xfZGVwIGdldHMNCj4gc2V0Pw0KDQpJbmRl
ZWQuIEkgdGhpbmsgdGhpcyBpcyAgYW4gYXJ0aWZhY3Qgb2YgdGhlIHdheSBJIGluaXRpYWxseSB3
cm90ZSB0aGVzZSBjaGFuZ2VzIOKAlCBJIHRyaWVkIHRvIGVsaW1pbmF0ZSBzb21lIHJlY29yZG1j
b3VudCB2YXJpYWJsZXMgYnkgdXNpbmcgb2JqdG9vbF9kZXAgaW4gdGhlIHJlY29yZG1jb3VudCBw
b3J0aW9ucyBvZiB0aGUgTWFrZWZpbGUuIFRoZW4gSSByZWFsaXplZCB0aGUgLmNvbmZpZyB2YXJp
YWJsZSBjb21iaW5hdGlvbnMgbWVhbnQgdGhlIG1vc3QgY2xlYXJseS1jb3JyZWN0IHdheSB0byB3
cml0ZSBpdCBpcyBzdGlsbCB3aXRoIHNlcGFyYXRlIHZhcmlhYmxlcy4NCg0KV2lsbCBmaXggc28g
aXTigJlzIGNsZWFyIHRoaXMgaXMgdGhlIG9ubHkgYXNzaWdubWVudC4NCg0KQ2hlZXJzLA0KICAg
IC1NYXR0
