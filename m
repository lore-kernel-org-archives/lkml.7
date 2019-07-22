Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351B7C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1D221955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="UdOhy4SW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfGVSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:40:19 -0400
Received: from mail-eopbgr740047.outbound.protection.outlook.com ([40.107.74.47]:34528
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728798AbfGVSkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:40:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xzs6WEiO+4Hvyx6+3L3EAZ2gcaqwnX0+hOr+m4cnQO/u0KMx7E7EcMEJVuN79+6vZOaj5iusJaZw91t5479tJgoRIcsOmkRVePXoNM4boGQnylU2EQVtnCauC1BY41JQiAMIhHqcvAH9Ec4XfwoTUbig9lXzm4TM7DbWIuerELL7OJ0LAePStPre7eO71WoDGXurr+7NUD5KPYTcYZV++ljAhbhgGGSj83OY9d4ecXooAqXgq1Ph6hb9Pe8ON+uKW1VE2MOTxBgDDsd1Gb6p6FtaJl/vNeueKv7jFhHJ3LjVir+QKG5XuHEV24wV7KEr3+IyYuFaTgeD/J9kg+WTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3LVoP3LdZKP98AUQZu0wdfQyXZxAEL9SrbdlUk93zY=;
 b=ZM5G5anVQl9k/mo+0fVO4+L+oOLj67srjG5ogZ5rZOM+mIhMj8z+F/P+Enmyx3dgnrT6qwuRG9Y/2Vt9zZDahs3DDY75gpJgwP/CBxjy5Ndmqi8fOmvW1JLOcAAQEYQSdEU+ZIdPPMdhqCrDwSsfhWYHNSAtjXFLb70E0KZYQCqn3qA19koe43dr9sqhoEbLsmqJ0HOGgjdrwSSmrNLe06/0P4ZO6MKUn69gjfQCOFkc++DE843RaIS4zLqxMsdeSyBRQtjIDLwhRv+ekFoATRFUCaYduVK8Mu14ONBIgUBTqDHcXlMKD21OdsXwigMEyDuSCweGqgJaNLgQY2aq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3LVoP3LdZKP98AUQZu0wdfQyXZxAEL9SrbdlUk93zY=;
 b=UdOhy4SWBg5OCbYVUx5XeVRH0OO7L72XRVTOuGNuO8t6yQe/oxnCLnXze7mktroV371iN2CcnjAvGRMfbdht26BlLMdUxl8dt+qN+H0u/+kXm8gm/ssN6ZLLYiyD49Ed0Cbaaihu203tiX5UUnAOL7OzYSHR148vLu+g8Y7D+HM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3943.namprd05.prod.outlook.com (52.135.195.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.10; Mon, 22 Jul 2019 18:40:16 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2115.005; Mon, 22 Jul 2019
 18:40:16 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Topic: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Index: AQHVPc0owCZu4w44l0OVUg4r6D6Gu6bW+RmAgAAESICAAADSgA==
Date:   Mon, 22 Jul 2019 18:40:16 +0000
Message-ID: <91940019-826C-4F33-904B-0767D95A5E21@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-2-namit@vmware.com>
 <20190722182159.GB6698@worktop.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907222033200.1659@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907222033200.1659@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 160c8e75-cd3d-4b64-4f16-08d70ed40a2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB3943;
x-ms-traffictypediagnostic: BYAPR05MB3943:
x-microsoft-antispam-prvs: <BYAPR05MB39435AE5D8BC4A024622A9FCD0C40@BYAPR05MB3943.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(2906002)(478600001)(6246003)(6512007)(53936002)(68736007)(86362001)(66066001)(446003)(99286004)(305945005)(256004)(8676002)(14444005)(54906003)(486006)(6436002)(316002)(25786009)(6486002)(8936002)(5660300002)(36756003)(81166006)(53546011)(7736002)(33656002)(11346002)(229853002)(2616005)(6116002)(71200400001)(71190400001)(476003)(186003)(76176011)(102836004)(66446008)(66946007)(76116006)(66476007)(64756008)(66556008)(26005)(6916009)(14454004)(4326008)(6506007)(3846002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3943;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KPvbnTSfBNkmUygxlk+EXWEtkcEiEQ5RRL26pY7Mvvtw4Ms6ixF1TZvSz52lLcP9Htl9l2ACMNIbC57vGPxTpSQkKuMaySLMiipu8jhe4HcGTazKhjdCseTa0+KEZhNWYooAnq/9yfEGRMu0ZHz7foe5mFYhVKQyiafRS/7QjJidkCD7mgbyEaCDb2YAZY+F7quPWyi9Q9CGoGfALyoZIzvQHM7mqfUF/v3LyQnPqAb70kMUP8p2UMbsgIGFu7Wj2192Z6fn9QjVZnVY8INCMKA81qN0YpVKQCQWeC4V2UC4od6YNf+Lmn2f6MLdC7yarEMvYuNwcl2GNYlFiFWUdYlY47MvudCZ/+qkfOSBqBDUH8g6rsjPjjxVOLoAaChLxjVzmHGlmjL5HxNZeft4RbDMcjqlP2I2Jins4zW0iuw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72117175D27DD741BE412547BAAC7758@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160c8e75-cd3d-4b64-4f16-08d70ed40a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 18:40:16.0431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMjIsIDIwMTksIGF0IDExOjM3IEFNLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDIyIEp1bCAyMDE5LCBQZXRlciBaaWps
c3RyYSB3cm90ZToNCj4gDQo+PiBPbiBUaHUsIEp1bCAxOCwgMjAxOSBhdCAwNTo1ODoyOVBNIC0w
NzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+ICsvKg0KPj4+ICsgKiBDYWxsIGEgZnVuY3Rpb24g
b24gYWxsIHByb2Nlc3NvcnMuICBNYXkgYmUgdXNlZCBkdXJpbmcgZWFybHkgYm9vdCB3aGlsZQ0K
Pj4+ICsgKiBlYXJseV9ib290X2lycXNfZGlzYWJsZWQgaXMgc2V0Lg0KPj4+ICsgKi8NCj4+PiAr
c3RhdGljIGlubGluZSB2b2lkIG9uX2VhY2hfY3B1KHNtcF9jYWxsX2Z1bmNfdCBmdW5jLCB2b2lk
ICppbmZvLCBpbnQgd2FpdCkNCj4+PiArew0KPj4+ICsJb25fZWFjaF9jcHVfbWFzayhjcHVfb25s
aW5lX21hc2ssIGZ1bmMsIGluZm8sIHdhaXQpOw0KPj4+ICt9DQo+PiANCj4+IEknbSB0aGlua2lu
ZyB0aGF0IG9uZSBpZiBidWdneSwgbm90aGluZyBwcm90ZWN0cyBvbmxpbmUgbWFzayBoZXJlLg0K
PiANCj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaGFzIHByZWVtcHRpb24gZGlzYWJsZWQg
YmVmb3JlIHRvdWNoaW5nDQo+IGNwdV9vbmxpbmVfbWFzayB3aGljaCBhdCBsZWFzdCBwcm90ZWN0
cyBhZ2FpbnN0IGEgQ1BVIGdvaW5nIGF3YXkgYXMgdGhhdA0KPiBwcmV2ZW50cyB0aGUgc3RvbXAg
bWFjaGluZSB0aHJlYWQgZnJvbSBnZXR0aW5nIG9uIHRoZSBDUFUuIEJ1dCBpdCdzIG5vdA0KPiBw
cm90ZWN0ZWQgYWdhaW5zdCBhIENQVSBjb21pbmcgb25saW5lIGNvbmN1cnJlbnRseS4NCg0KSSBz
dGlsbCBkb27igJl0IHVuZGVyc3RhbmQuIElmIHlvdSBjYWxsZWQgY3B1X29ubGluZV9tYXNrKCkg
YW5kIGRpZCBub3QNCmRpc2FibGUgcHJlZW1wdGlvbiBiZWZvcmUgY2FsbGluZyBpdCwgeW91IGFy
ZSBhbHJlYWR5ICh0b2RheSkgbm90IHByb3RlY3RlZA0KYWdhaW5zdCBhbm90aGVyIENQVSBjb21p
bmcgb25saW5lLiBEaXNhYmxpbmcgcHJlZW1wdGlvbiBpbiBvbl9lYWNoX2NwdSgpDQp3aWxsIG5v
dCBzb2x2ZSBpdC4NCg0K
