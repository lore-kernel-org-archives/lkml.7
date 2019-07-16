Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F30C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A450C2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="jg2Jmz1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbfGPAy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 20:54:29 -0400
Received: from mail-eopbgr790087.outbound.protection.outlook.com ([40.107.79.87]:10752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731879AbfGPAy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:54:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0oy0+aNPug+bpmst+HXAn1W3PlCiw/Hy926zzmPDrFqba+KtlXH4KVD55sL02sPbIXCuER5IJEYpmBxuweSVy2YFhNyqoh9dhcZCZOJhqIQdvTgc5dCFeq7ibsa2rktdbS4C948YxzdwQeZWitrKT3oBhrccTHD4wu0kATK3X74vdp6/HwnZaKPxAJzU82hAK8yO6DMkOVYN+dcx/NhRSdvtDrJt/cLep8ltaYCgVm1JVoZawGo15dac2w9fcMFyma51oY0wIo308DwNIytZLSGXQbV0IIjHBlOUHdnD9bk5wRqo4jVc5AIThnJzGvWGX3/hKTM6DsZuvKVb7ayCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0dHJw+GEWbdN3u3HVcXeqWOEfImxkiFCI9Q0YXETYQ=;
 b=hZnFVetlnh3ZqNGSZl1lZXsFq0dbYki7YMA8aiXzJ4L0ZOZKNoP3rO+oEp9AlyqSnxVcKboJqvKObbry02+x1kzGk8Di/jjTcBwU7rSbDRjGJNVFjCP1so+KC8VHHYfQfk1Mj/lQYUdocrvJZ6hs0nrZAooriNCH5c2DGEXG7ZzOTAnhkhV8HTPIkrhqoaOeZ5L2tGi/OK3FY/pbj17xYy8pVyRFmaYf3xQmuUqq0F+a1zCTe7rPM4Zg3R92hp1sf0w4i96GBG/7Ll16M5TEW0TU9/lW2gNF4Bd4VYHsNM2rInA9ttK5Dykk9ss2Ai9YzObozd9JlZxqshNEU2Nngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0dHJw+GEWbdN3u3HVcXeqWOEfImxkiFCI9Q0YXETYQ=;
 b=jg2Jmz1oyek5Czp+iGjZDCORm8JQDo1yhrCXIxnpi6GpGqTE3bv8YbCta5KbcKxMDWL54/yc5Yri3IAzaZPVok+OCaSUYAfmPYXf6bQBItAuUfgNiHuCKj/JBJb/26ymLV0j7cMClxtJkCBHLt1xMzXXeqLqP9jErA62vu9qI1k=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4648.namprd05.prod.outlook.com (52.135.233.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.10; Tue, 16 Jul 2019 00:54:26 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2094.009; Tue, 16 Jul 2019
 00:54:26 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] x86/paravirt: Drop {read,write}_cr8() hooks
Thread-Topic: [PATCH v2] x86/paravirt: Drop {read,write}_cr8() hooks
Thread-Index: AQHVOyBUFdACaHiktUycGK4yMfk9sqbL/QEAgABXOYCAABeLgA==
Date:   Tue, 16 Jul 2019 00:54:26 +0000
Message-ID: <31F573CC-4381-4C24-B8D8-6AB05D7FAA96@vmware.com>
References: <20190715151641.29210-1-andrew.cooper3@citrix.com>
 <602B4D96-E2A9-45BE-8247-4E3481ED5402@vmware.com>
 <4a7592c8-0ee8-f394-c445-4032daf74493@citrix.com>
In-Reply-To: <4a7592c8-0ee8-f394-c445-4032daf74493@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a757efc1-ed15-436c-3125-08d7098826be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4648;
x-ms-traffictypediagnostic: BYAPR05MB4648:
x-microsoft-antispam-prvs: <BYAPR05MB4648890B20C2F293DD25EDF3D0CE0@BYAPR05MB4648.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(256004)(6246003)(6486002)(6512007)(36756003)(86362001)(53936002)(8676002)(66946007)(66556008)(486006)(64756008)(66446008)(66476007)(6436002)(76116006)(81166006)(66066001)(3846002)(2906002)(446003)(476003)(6916009)(14444005)(81156014)(6506007)(2616005)(11346002)(53546011)(305945005)(7416002)(186003)(4326008)(26005)(8936002)(25786009)(68736007)(316002)(14454004)(54906003)(5660300002)(7736002)(102836004)(76176011)(71200400001)(478600001)(33656002)(229853002)(99286004)(6116002)(71190400001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4648;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u3zdPNRJ1T+1ZiRZdurqebc9YhaWFUFA0FMY8FU5eYdrORcOpmK9JG0kCbgcNno35N9CkKUVI4mb4FdDTD6V4WiVLs15orw80R+pXRamTmUlAy+eRIR1GOefcRd97a2iI0gm3GUq01v8GoqepJUuAXSrRkUQ3vizEXLGG/C7QOGOrpNr1+ziRbodM2kYQzscRXiFTArB0xn9Y/k9XrtRJaBg2qwdPbu9Kv1X3BJm3VdDy0X1m2s21S+TVdZpSPRqZAVFtcs24B3W9uxzASonlXcoJqvrb+Px5Pe0Jw4poGUXypRbScY4pVRB0JSL3320pkBASXh6fNWWpfeSUnqNig/LXG4bgtq65TVkmDBaxNfJ+wMG3ZArTuNrCrj2EXnMp9Gv1X6oWxOonvX9udRoxENKtJwuV19J0zva20v+evo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ED4C1A52CE9F047A786ED36B570FEA6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a757efc1-ed15-436c-3125-08d7098826be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 00:54:26.1798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTUsIDIwMTksIGF0IDQ6MzAgUE0sIEFuZHJldyBDb29wZXIgPGFuZHJldy5jb29w
ZXIzQGNpdHJpeC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTUvMDcvMjAxOSAxOToxNywgTmFkYXYg
QW1pdCB3cm90ZToNCj4+PiBPbiBKdWwgMTUsIDIwMTksIGF0IDg6MTYgQU0sIEFuZHJldyBDb29w
ZXIgPGFuZHJldy5jb29wZXIzQGNpdHJpeC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IFRoZXJlIGlz
IGEgbG90IG9mIGluZnJhc3RydWN0dXJlIGZvciBmdW5jdGlvbmFsaXR5IHdoaWNoIGlzIHVzZWQN
Cj4+PiBleGNsdXNpdmVseSBpbiBfX3tzYXZlLHJlc3RvcmV9X3Byb2Nlc3Nvcl9zdGF0ZSgpIG9u
IHRoZSBzdXNwZW5kL3Jlc3VtZQ0KPj4+IHBhdGguDQo+Pj4gDQo+Pj4gY3I4IGlzIGFuIGFsaWFz
IG9mIEFQSUNfVEFTS1BSSSwgYW5kIEFQSUNfVEFTS1BSSSBpcyBzYXZlZC9yZXN0b3JlZCBieQ0K
Pj4+IGxhcGljX3tzdXNwZW5kLHJlc3VtZX0oKS4gIFNhdmluZyBhbmQgcmVzdG9yaW5nIGNyOCBp
bmRlcGVuZGVudGx5IG9mIHRoZQ0KPj4+IHJlc3Qgb2YgdGhlIExvY2FsIEFQSUMgc3RhdGUgaXNu
J3QgYSBjbGV2ZXIgdGhpbmcgdG8gYmUgZG9pbmcuDQo+Pj4gDQo+Pj4gRGVsZXRlIHRoZSBzdXNw
ZW5kL3Jlc3VtZSBjcjggaGFuZGxpbmcsIHdoaWNoIHNocmlua3MgdGhlIHNpemUgb2Ygc3RydWN0
DQo+Pj4gc2F2ZWRfY29udGV4dCwgYW5kIGFsbG93cyBmb3IgdGhlIHJlbW92YWwgb2YgYm90aCBQ
Vk9QUy4NCj4+IEkgdGhpbmsgcmVtb3ZpbmcgdGhlIGludGVyZmFjZSBmb3IgQ1I4IHdyaXRlcyBp
cyBhbHNvIGdvb2QgdG8gYXZvaWQNCj4+IHBvdGVudGlhbCBjb3JyZWN0bmVzcyBpc3N1ZXMsIGFz
IHRoZSBTRE0gc2F5cyAoMTAuOC42LjEgIkludGVyYWN0aW9uIG9mIFRhc2sNCj4+IFByaW9yaXRp
ZXMgYmV0d2VlbiBDUjggYW5kIEFQSUPigJ0pOg0KPj4gDQo+PiAiT3BlcmF0aW5nIHNvZnR3YXJl
IHNob3VsZCBpbXBsZW1lbnQgZWl0aGVyIGRpcmVjdCBBUElDIFRQUiB1cGRhdGVzIG9yIENSOA0K
Pj4gc3R5bGUgVFBSIHVwZGF0ZXMgYnV0IG5vdCBtaXggdGhlbS4gU29mdHdhcmUgY2FuIHVzZSBh
IHNlcmlhbGl6aW5nDQo+PiBpbnN0cnVjdGlvbiAoZm9yIGV4YW1wbGUsIENQVUlEKSB0byBzZXJp
YWxpemUgdXBkYXRlcyBiZXR3ZWVuIE1PViBDUjggYW5kDQo+PiBzdG9yZXMgdG8gdGhlIEFQSUMu
4oCdDQo+PiANCj4+IEFuZCBuYXRpdmVfd3JpdGVfY3I4KCkgZGlkIG5vdCBldmVuIGlzc3VlIGEg
c2VyaWFsaXppbmcgaW5zdHJ1Y3Rpb24uDQo+IA0KPiBHaXZlbiBpdHMgbG9jYXRpb24sIHRoZSBv
bmUgd3JpdGVfY3I4KCkgaXMgYm91bmRlZCBieSB0d28gc2VyaWFsaXNpbmcNCj4gb3BlcmF0aW9u
cywgc28gaXMgc2FmZSBpbiBwcmFjdGljZS4NCg0KVGhhdOKAmXMgd2hhdCB0aGUg4oCccG90ZW50
aWFs4oCdIGluICJwb3RlbnRpYWwgY29ycmVjdG5lc3MgaXNzdWVz4oCdIG1lYW5zIDopDQoNCg==
