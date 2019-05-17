Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96CDC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD32A216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="q5wK0QaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfEQR5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:57:36 -0400
Received: from mail-eopbgr680072.outbound.protection.outlook.com ([40.107.68.72]:3398
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbfEQR5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfJ1f1qCesyo9VZPoLq6eXOwun65crUZfvfXFlEfK+E=;
 b=q5wK0QaLh/+XKglRd4RCI0j59oYBmyIfUoXz+DE8MxojSsAAV7ghfNxrH1m0DX/EZ4kv3fJ4dp9HiX5K4AAewPNIBegON6nfvKBK6YDDcLU0OEkYz5TYWoQZ/FjwKjLU4oJk2YoMm4D6/x2/LAw2yOKPiwxeDjZHqkQ+ZjTbrAA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6007.namprd05.prod.outlook.com (20.178.53.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.7; Fri, 17 May 2019 17:57:22 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098%7]) with mapi id 15.20.1922.002; Fri, 17 May 2019
 17:57:22 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Julien Freche <jfreche@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Jason Wang <jasowang@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/4] vmw_balloon: Compaction and shrinker support
Thread-Topic: [PATCH v4 0/4] vmw_balloon: Compaction and shrinker support
Thread-Index: AQHU+5sfw4lXp6MJj0Ov0LaKSU1Rk6ZaOUgAgBV2VACAAAPxgIAACS+A
Date:   Fri, 17 May 2019 17:57:22 +0000
Message-ID: <26FEBE86-AF49-428F-9C9F-1FA435ADCB54@vmware.com>
References: <20190425115445.20815-1-namit@vmware.com>
 <8A2D1D43-759A-4B09-B781-31E9002AE3DA@vmware.com>
 <9AD9FE33-1825-4D1A-914F-9C29DF93DC8D@vmware.com>
 <20190517172429.GA21509@kroah.com>
In-Reply-To: <20190517172429.GA21509@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e0dc56b-e90b-47e3-15c6-08d6daf11cd2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB6007;
x-ms-traffictypediagnostic: BYAPR05MB6007:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB600747377EAE958A3202486DD00B0@BYAPR05MB6007.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(33656002)(8936002)(8676002)(81166006)(81156014)(6916009)(316002)(229853002)(71190400001)(71200400001)(6436002)(6512007)(7736002)(478600001)(305945005)(83716004)(476003)(6246003)(11346002)(4326008)(2616005)(86362001)(2906002)(66066001)(486006)(3846002)(6116002)(186003)(26005)(446003)(36756003)(53936002)(68736007)(25786009)(66476007)(54906003)(14444005)(66556008)(64756008)(66446008)(6486002)(256004)(76176011)(53546011)(102836004)(6506007)(5660300002)(76116006)(73956011)(66946007)(14454004)(82746002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6007;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dNN6XgPo5hvx1UB+NfT0AYgtRI9+ZVm3HoykNJEQ7cRftnheN13qTPZxALoNjsPKdDa9ClcPTh96z9lch6BLh/cvPZWNNFWHy6kAEL7BQffUhqdtiBMARSJrxFcXB1aa8lwTxeX8ycBI8QqP/9JeWuGbo0J0cxLWDP9kJRdso5a6dVUQRxDEfi2BrFChmzqO3mHLUYAc1KT0j3RY3ZYvqovjuTAv5Rm5ivuOmqCQBA+ZmPX1I6qODYXrM0syTZat+oCco9qpFHx1/fOiUqkhZ7GvQH3ojWSyeTHr1KgPA9UfITObZDF9Mkrq/2mFZTJyArNbq4CZo3gZYmZPnGuF0Bg7LnJJie7aWlI4c8i7zPNZfFUTVZfQcJubwxw2euTlg5g72r3+rjBE/lSQdzxBoJDh9TalPGqp6POOHkT3bC0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF90EFC62CAD0944AB47C0512DCC17F0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0dc56b-e90b-47e3-15c6-08d6daf11cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 17:57:22.3448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMTcsIDIwMTksIGF0IDEwOjI0IEFNLCBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgTWF5IDE3LCAyMDE5
IGF0IDA1OjEwOjIzUE0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gT24gTWF5IDMsIDIw
MTksIGF0IDY6MjUgUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+
IA0KPj4+PiBPbiBBcHIgMjUsIDIwMTksIGF0IDQ6NTQgQU0sIE5hZGF2IEFtaXQgPG5hbWl0QHZt
d2FyZS5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gVk13YXJlIGJhbGxvb24gZW5oYW5jZW1lbnRz
OiBhZGRpbmcgc3VwcG9ydCBmb3IgbWVtb3J5IGNvbXBhY3Rpb24sDQo+Pj4+IG1lbW9yeSBzaHJp
bmtlciAodG8gcHJldmVudCBPT00pIGFuZCBzcGxpdHRpbmcgb2YgcmVmdXNlZCBwYWdlcyB0bw0K
Pj4+PiBwcmV2ZW50IHJlY3VycmluZyBpbmZsYXRpb25zLg0KPj4+PiANCj4+Pj4gUGF0Y2hlcyAx
LTI6IFN1cHBvcnQgZm9yIGNvbXBhY3Rpb24NCj4+Pj4gUGF0Y2ggMzogU3VwcG9ydCBmb3IgbWVt
b3J5IHNocmlua2VyIC0gZGlzYWJsZWQgYnkgZGVmYXVsdA0KPj4+PiBQYXRjaCA0OiBTcGxpdCBy
ZWZ1c2VkIHBhZ2VzIHRvIGltcHJvdmUgcGVyZm9ybWFuY2UNCj4+Pj4gDQo+Pj4+IHYzLT52NDoN
Cj4+Pj4gKiAiZ2V0IGFyb3VuZCB0byIgY29tbWVudCBbTWljaGFlbF0NCj4+Pj4gKiBQdXQgbGlz
dF9hZGQgdW5kZXIgcGFnZSBsb2NrIFtNaWNoYWVsXQ0KPj4+PiANCj4+Pj4gdjItPnYzOg0KPj4+
PiAqIEZpeGluZyB3cm9uZyBhcmd1bWVudCB0eXBlIChpbnQtPnNpemVfdCkgW01pY2hhZWxdDQo+
Pj4+ICogRml4aW5nIGEgY29tbWVudCAoaXQpIFtNaWNoYWVsXQ0KPj4+PiAqIFJlaW5zdGF0aW5n
IHRoZSBCVUdfT04oKSB3aGVuIHBhZ2UgaXMgbG9ja2VkIFtNaWNoYWVsXSANCj4+Pj4gDQo+Pj4+
IHYxLT52MjoNCj4+Pj4gKiBSZXR1cm4gbnVtYmVyIG9mIHBhZ2VzIGluIGxpc3QgZW5xdWV1ZS9k
ZXF1ZXVlIGludGVyZmFjZXMgW01pY2hhZWxdDQo+Pj4+ICogUmVtb3ZlZCBmaXJzdCB0d28gcGF0
Y2hlcyB3aGljaCB3ZXJlIGFscmVhZHkgbWVyZ2VkDQo+Pj4+IA0KPj4+PiBOYWRhdiBBbWl0ICg0
KToNCj4+Pj4gbW0vYmFsbG9vbl9jb21wYWN0aW9uOiBMaXN0IGludGVyZmFjZXMNCj4+Pj4gdm13
X2JhbGxvb246IENvbXBhY3Rpb24gc3VwcG9ydA0KPj4+PiB2bXdfYmFsbG9vbjogQWRkIG1lbW9y
eSBzaHJpbmtlcg0KPj4+PiB2bXdfYmFsbG9vbjogU3BsaXQgcmVmdXNlZCBwYWdlcw0KPj4+PiAN
Cj4+Pj4gZHJpdmVycy9taXNjL0tjb25maWcgICAgICAgICAgICAgICB8ICAgMSArDQo+Pj4+IGRy
aXZlcnMvbWlzYy92bXdfYmFsbG9vbi5jICAgICAgICAgfCA0ODkgKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0NCj4+Pj4gaW5jbHVkZS9saW51eC9iYWxsb29uX2NvbXBhY3Rpb24uaCB8ICAg
NCArDQo+Pj4+IG1tL2JhbGxvb25fY29tcGFjdGlvbi5jICAgICAgICAgICAgfCAxNDQgKysrKysr
LS0tDQo+Pj4+IDQgZmlsZXMgY2hhbmdlZCwgNTUzIGluc2VydGlvbnMoKyksIDg1IGRlbGV0aW9u
cygtKQ0KPj4+PiANCj4+Pj4gLS0gDQo+Pj4+IDIuMTkuMQ0KPj4+IA0KPj4+IFBpbmcuDQo+PiAN
Cj4+IFBpbmcuDQo+PiANCj4+IEdyZWcsIGRpZCBpdCBnb3QgbG9zdCBhZ2Fpbj8NCj4gDQo+IA0K
PiBJIHRob3VnaHQgeW91IG5lZWRlZCB0aGUgbW0gZGV2ZWxvcGVycyB0byBhY2sgdGhlIGZpcnN0
IHBhdGNoLCBkaWQgdGhhdA0KPiBldmVyIGhhcHBlbj8NCg0KWWVzLiBZb3Ugd2lsbCBzZWUgTWlj
aGFlbCBUc2lya2lu4oCZcyDigJxBY2tlZC1ieSIgb24gaXQuDQoNCg==
