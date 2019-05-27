Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDA1C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A26208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="0zSKHf5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfE0Rjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:39:39 -0400
Received: from mail-eopbgr820085.outbound.protection.outlook.com ([40.107.82.85]:36408
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726346AbfE0Rji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nukTWVhaXbENkuw/cFKiMLmJ38LiHA5CZU4tJI/3pc=;
 b=0zSKHf5uKdLZOAnxLIct0qxDHMh9V6C2fsyrdLZ1zLKaIHBqhnLi6/X/k6EB3+fzjB2fOeNLFBUcNTGsJ/GsFBl8tdOzAQd3XLaeln3g9jEZppTMHda3bQRUMLlhg3gGqVWZSvMemp6f9L7hF6TdMkqRyU3L+WsahciS+reIq+I=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6006.namprd05.prod.outlook.com (20.178.53.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.10; Mon, 27 May 2019 17:39:35 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.007; Mon, 27 May 2019
 17:39:35 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH 3/6] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Topic: [RFC PATCH 3/6] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Index: AQHVEtL3456yzrQkuUCZGG9Vlj1rtaZ+s9QAgACM0QA=
Date:   Mon, 27 May 2019 17:39:35 +0000
Message-ID: <57E94109-CBE8-43BA-98FF-646E8C9EE8A2@vmware.com>
References: <20190525082203.6531-1-namit@vmware.com>
 <20190525082203.6531-4-namit@vmware.com>
 <20190527091534.GS2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190527091534.GS2623@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff516cac-b04d-46e7-0bdb-08d6e2ca48e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB6006;
x-ms-traffictypediagnostic: BYAPR05MB6006:
x-microsoft-antispam-prvs: <BYAPR05MB6006271574D1B2EE48F51637D01D0@BYAPR05MB6006.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(39860400002)(346002)(199004)(189003)(2906002)(4326008)(25786009)(36756003)(99286004)(6916009)(229853002)(66066001)(86362001)(66946007)(14454004)(73956011)(66446008)(64756008)(76116006)(5660300002)(478600001)(4744005)(71190400001)(71200400001)(83716004)(66476007)(26005)(66556008)(82746002)(446003)(186003)(316002)(6246003)(8936002)(8676002)(81156014)(81166006)(33656002)(256004)(305945005)(6512007)(14444005)(486006)(6436002)(6486002)(11346002)(476003)(7736002)(2616005)(68736007)(76176011)(3846002)(54906003)(6116002)(53546011)(6506007)(53936002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6006;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9kdxRpMQqNYdBD+/qNHpQ1Hg+oIt8Dwzitr2fqw+7Vg0+hvrZQsDxU1G6nHWfekPfd0PnWPBf5c4YPo9IvCWo+iaOjrZeshb6RiJOZ3q599QriHfhXqqRYHFQLW2rgPBsUrv080+LkHexoM6iMF/JowzVAMOY2RWl7AwortD9HB/PJEzoqjQH1Ghp6Dab039VZ88gf5Jk7hlHVuZA4L8G/16sld18rOreASiwBhXrV5TCvAtRsgBhby7j37fCZiH26cV1d8eHOLW/ntwuvtsyEnf1I9ZnHl8BrwfheznU5AVl+5Q+R98JM8hxfSfu1she0fivrkbz9/HmzmSHENQnD1qlvC7ZKDitN+w2ti2E3Xmooxf+coB7QwAt2lpXQUchsWDNQceDsUKoEuts0S/S51YacRVQL39OgBLLgNdPHU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D6DF2CC2A029459073F1745B2DB2E2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff516cac-b04d-46e7-0bdb-08d6e2ca48e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 17:39:35.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMjcsIDIwMTksIGF0IDI6MTUgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPj4gKwkJLyoNCj4+ICsJCSAqIENob29zZSB0aGUgbW9z
dCBlZmZpY2llbnQgd2F5IHRvIHNlbmQgYW4gSVBJLiBOb3RlIHRoYXQgdGhlDQo+PiArCQkgKiBu
dW1iZXIgb2YgQ1BVcyBtaWdodCBiZSB6ZXJvIGR1ZSB0byBjb25jdXJyZW50IGNoYW5nZXMgdG8g
dGhlDQo+PiArCQkgKiBwcm92aWRlZCBtYXNrIG9yIGNwdV9vbmxpbmVfbWFzay4NCj4+ICsJCSAq
Lw0KPiANCj4gU2luY2Ugd2UgaGF2ZSBwcmVlbXB0aW9uIGRpc2FibGVkIGhlcmUsIEkgZG9uJ3Qg
dGhpbmsgb25saW5lIG1hc2sgY2FuDQo+IHNocmluaywgY3B1LW9mZmxpbmUgdXNlcyBzdG9wX21h
Y2hpbmUoKS4NCg0KUmlnaHQuIFNvIEnigJlsbCB1cGRhdGUgdGhlIGNvbW1lbnQsIGJ1dCBJSVVD
IHRoZSBwcm92aWRlZCBtYXNrIG1pZ2h0IHN0aWxsDQpjaGFuZ2UsIHNvIEnigJlsbCBsZWF2ZSB0
aGUgcmVzdCBvZiB0aGUgY29tbWVudCBhbmQgdGhlIGNvZGUgYXMgaXMuDQoNCj4+ICsJCWlmIChu
cl9jcHVzID09IDEpDQo+PiArCQkJYXJjaF9zZW5kX2NhbGxfZnVuY3Rpb25fc2luZ2xlX2lwaShs
YXN0X2NwdSk7DQo+PiArCQllbHNlIGlmIChsaWtlbHkobnJfY3B1cyA+IDEpKQ0KPj4gKwkJCWFy
Y2hfc2VuZF9jYWxsX2Z1bmN0aW9uX2lwaV9tYXNrKGNmZC0+Y3B1bWFza19pcGkpOw0KPj4gKwl9
DQoNCg0K
