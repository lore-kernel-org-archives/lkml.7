Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B106DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675732133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="giAIZxpb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="lFFt+EQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfEMNNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:13:23 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:34292 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730056AbfEMNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:13:22 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E21E8C0199;
        Mon, 13 May 2019 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557753192; bh=X/w4jjIfhDtxxwFm9CmAL+XLlUqFDReF5C0x1ixR4vE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=giAIZxpbsJnp5BHWdwQSeHT4cQ/ht4/oaDipfAg7MJAwWJqq6YUH7+EqPGOeXgYNR
         5jlO/4z2zx8Ecax37/zlod/7eEmtYM44K64fp0nD7fYP5YOk1FiRRWNQoP/OnKXQFW
         gWyLzgaIPalYgayJVx+3dExjJhxy9C9ZgGA9sUJBzuNIyXoZ9PyH+KImmTKuQXRm+w
         Df05MpAyyubfos30ZZAmfYlejBz7CXk4ZP53901CShPBXBHe0MzF8W1MapjWP2g7Tj
         1lvM9w9vsSdu7bKS5ofVhuX07KsSxKHccHuqRumk/05QWWmmdCnr0/IdAyM/5vWt9G
         yFhjOM7IGnx+A==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F1576A005A;
        Mon, 13 May 2019 13:13:19 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 13 May 2019 06:13:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 13 May 2019 06:13:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/w4jjIfhDtxxwFm9CmAL+XLlUqFDReF5C0x1ixR4vE=;
 b=lFFt+EQVabi+dm3ROg6KjT/EmOXTxl/XQ8Td1/diembRpYD9X3Id/9ehZmcfYZUR3GMnCJdndtQovJ9QW3wDnTHjCUuWgo2LVek21kiUWgZOELJvaz4RhueQCat4WD/ZxBmu7CFvesqmfO6BVW8k2M1OfTTE7j+jPaLwHs/OU2o=
Received: from MWHPR12MB1632.namprd12.prod.outlook.com (10.172.56.21) by
 MWHPR12MB1471.namprd12.prod.outlook.com (10.172.55.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 13:13:16 +0000
Received: from MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6]) by MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6%2]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 13:13:16 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2] ARC: fix memory nodes topology in case of highmem
 enabled
Thread-Topic: [PATCH v2] ARC: fix memory nodes topology in case of highmem
 enabled
Thread-Index: AQHU9QrXSpJDCh2Pa06BEWgWPHof5qZpMSgA
Date:   Mon, 13 May 2019 13:13:16 +0000
Message-ID: <1557753194.16604.1.camel@synopsys.com>
References: <20190417104611.13257-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20190417104611.13257-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d9f3274-f1e3-4bfd-8e6e-08d6d7a4c30d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR12MB1471;
x-ms-traffictypediagnostic: MWHPR12MB1471:
x-microsoft-antispam-prvs: <MWHPR12MB14719910573BAF22287115F0DE0F0@MWHPR12MB1471.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39850400004)(396003)(366004)(189003)(199004)(14444005)(11346002)(76176011)(6636002)(6246003)(6116002)(446003)(476003)(2906002)(6436002)(53936002)(486006)(37006003)(256004)(4326008)(36756003)(186003)(54906003)(3846002)(25786009)(6512007)(2616005)(102836004)(305945005)(6486002)(68736007)(316002)(71200400001)(71190400001)(86362001)(229853002)(7736002)(103116003)(6506007)(478600001)(91956017)(64756008)(26005)(8936002)(99286004)(66066001)(8676002)(66946007)(66556008)(81166006)(81156014)(73956011)(76116006)(66476007)(66446008)(6862004)(5660300002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR12MB1471;H:MWHPR12MB1632.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EnzAL6gi7sdT/PlzkScZZdfK2Y1vHhiVUrGGSz4B5Nkonk5bnRpL65nz1WWGIE8sAcHe1JfGQ+KJyig3d7WeQ9F9GRR8Wx2RhwsOGWaUqegTlC09RztX+RHpQAk7ZdKkaLFbaE7ow1qLdI6UxaxF9xIHRBkzJGYsnnQhcL4KQFzSXrs0frIBnsUO5DMeP5s0Ri3AqiR7aoJrTg1S46cycq56jy0SrJOyKpI3GewgRA1YlsevpCpUG1aMl40IA3jcVC9s+qIhfap9f4e5GCWwxWVFf2EaBZQLsCeH9bHFRd8OLBtVao/caaWG4skpAv5dKItyUq81skRKRIoPjdHcAtzBRldQnbtpqhKj1f6NnrHAfF5HdNtakV/yGqh3KKB9kTxoCI4S5CHhJEKlfKkKGJ1ZKAHAy1/6/8LoMxWwpcc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52AD7DEEBD41044287A0AF00A3A82F2F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9f3274-f1e3-4bfd-8e6e-08d6d7a4c30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 13:13:16.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1471
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpwaW5nLg0KDQpPbiBXZWQsIDIwMTktMDQtMTcgYXQgMTM6NDYgKzAzMDAs
IEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gVHdlYWsgZ2VuZXJpYyBub2RlIHRvcG9sb2d5IGlu
IGNhc2Ugb2YgQ09ORklHX0hJR0hNRU0gZW5hYmxlZCB0bw0KPiBwcmlvcml0aXplIGFsbG9jYXRp
b25zIGZyb20gWk9ORV9ISUdITUVNIHRvIGF2b2lkIFpPTkVfTk9STUFMDQo+IHByZXNzdXJlLg0K
PiANCj4gSGVyZSBpcyBleGFtcGxlIHdoZW4gd2UgY2FuIHNlZSBwcm9ibGVtcyBvbiBBUkMgd2l0
aCBjdXJyZW50bHkNCj4gZXhpc3RpbmcgdG9wb2xvZ3kgY29uZmlndXJhdGlvbjoNCj4gDQo+IEdl
bmVyaWMgc3RhdGVtZW50czoNCj4gIC0gKk5PVCogZXZlcnkgbWVtb3J5IGFsbG9jYXRpb24gd2hp
Y2ggY291bGQgYmUgZG9uZSBmcm9tDQo+ICAgIFpPTkVfTk9STUFMIGFsc28gY291bGQgYmUgZG9u
ZSBmcm9tIFpPTkVfSElHSE1FTS4NCj4gIC0gRXZlcnkgbWVtb3J5IGFsbG9jYXRpb24gd2hpY2gg
Y291bGQgYmUgZG9uZSBmcm9tIFpPTkVfSElHSE1FTQ0KPiAgICBhbHNvIGNvdWxkIGJlIGRvbmUg
ZnJvbSBaT05FX05PUk1BTCAoSW4gb3RoZXIgd29yZHMgWk9ORV9OT1JNQUwNCj4gICAgaXMgbW9y
ZSB1bml2ZXJzYWwgdGhhbiBaT05FX0hJR0hNRU0pDQo+IA0KPiBBUkMgc3RhdGVtZW50czoNCj4g
SW4gY2FzZSBvZiBDT05GSUdfSElHSE1FTSBlbmFibGVkIHdlIGhhdmUgMiBtZW1vcnkgbm9kZXM6
DQo+ICAtICJub2RlIDAiIGhhcyBvbmx5IFpPTkVfTk9STUFMIG1lbW9yeS4NCj4gIC0gIm5vZGUg
MSIgaGFzIG9ubHkgWk9ORV9ISUdITUVNIG1lbW9yeS4NCj4gDQo+IFN0ZXBzIHRvIHJlcHJvZHVj
ZSB0aGUgcHJvYmxlbToNCj4gMSkgTGV0J3MgdHJ5IHRvIGFsbG9jYXRlIHNvbWUgbWVtb3J5IGZy
b20gdXNlcnNwYWNlLiBJdCBjYW4gYmUNCj4gICAgYWxsb2NhdGUgZnJvbSBhbnl3aGVyZSAoWk9O
RV9ISUdITUVNL1pPTkVfTk9STUFMKS4NCj4gMikgS2VybmVsIHRyaWVzIHRvIGFsbG9jYXRlIG1l
bW9yeSBmcm9tIHRoZSBjbG9zZXN0IG1lbW9yeSBub2RlDQo+ICAgIHRvIHRoaXMgQ1BVLiBBcyB3
ZSBkb24ndCBoYXZlIE5VTUEgZW5hYmxlZCBhbmQgZG9uJ3Qgb3ZlcnJpZGUNCj4gICAgYW55IGRl
ZmluZSBmcm9tICJpbmNsdWRlL2FzbS1nZW5lcmljL3RvcG9sb2d5LmgiIHRoZSBjbG9zZXN0DQo+
ICAgIG1lbW9yeSBub2RlIHRvIGFueSBDUFUgd2lsbCBiZSAibm9kZSAwIg0KPiAzKSBPSywgd2Un
bGwgYWxsb2NhdGUgbWVtb3J5IGZyb20gIm5vZGUgMCIuIExldCdzIGNob29zZSBaT05FDQo+ICAg
IHRvIGFsbG9jYXRlIGZyb20uIFRoaXMgYWxsb2NhdGlvbiBjb3VsZCBiZSBkb25lIGZyb20gYm90
aA0KPiAgICBaT05FX0hJR0hNRU0gLyBaT05FX05PUk1BTCBpbiB0aGlzIG5vZGUuIFRoZSBhbGxv
Y2F0aW9uDQo+ICAgIHByaW9yaXR5IGJldHdlZW4gem9uZXMgaXMgWk9ORV9ISUdITUVNID4gWk9O
RV9OT1JNQUwuDQo+ICAgIFRoaXMgaXMgcHJldHR5IGxvZ2ljYWwgLSB3ZSBkb24ndCB3YW50IHdh
c3RlICp1bml2ZXJzYWwqDQo+ICAgIFpPTkVfTk9STUFMIGlmIHdlIGNhbiB1c2UgWk9ORV9ISUdI
TUVNLiBCdXQgd2UgZG9uJ3QgaGF2ZQ0KPiAgICBaT05FX0hJR0hNRU0gaW4gIm5vZGUgMCIgdGhh
dCdzIHdoeSB3ZSByb2xsYmFjayB0bw0KPiAgICBaT05FX05PUk1BTCBhbmQgYWxsb2NhdGUgbWVt
b3J5IGZyb20gaXQuDQo+IDQpIExldCdzIHRyeSB0byBhbGxvY2F0ZSBhIGxvdCBvZiBtZW1vcnkg
W21vcmUgdGhhbiB3ZSBoYXZlIGZyZWUNCj4gICAgbWVtb3J5IGluIGxvd21lbV0gZnJvbSB1c2Vy
c3BhY2UuDQo+IDUpIEtlcm5lbCBhbGxvY2F0ZXMgYXMgbXVjaCBtZW1vcnkgYXMgaXQgY2FuIGZy
b20gdGhlIGNsb3Nlc3QNCj4gICAgbWVtb3J5IG5vZGUgKCJub2RlIDAiKS4gQnV0IHRoZXJlIGlz
IG5vIGVub3VnaCBtZW1vcnkgaW4NCj4gICAgIm5vZGUgMCIuIFNvIHdlJ2xsIHJvbGxiYWNrIHRv
IGFub3RoZXIgbWVtb3J5IG5vZGUgKCJub2RlIDEiKQ0KPiAgICBhbmQgYWxsb2NhdGUgdGhlIHJl
c3Qgb2YgdGhlIGFtb3VudCBmcm9tIGl0Lg0KPiANCj4gICAgSW4gb3RoZXIgd29yZHMgd2UgaGF2
ZSBmb2xsb3dpbmcgbWVtb3J5IGxvb2t1cCBwYXRoOg0KPiAgICAgICAobm9kZSAwLCBaT05FX0hJ
R0hNRU0pIC0+DQo+ICAgIC0+IChub2RlIDAsIFpPTkVfTk9STUFMKSAgLT4NCj4gICAgLT4gKG5v
ZGUgMSwgWk9ORV9ISUdITUVNKQ0KPiANCj4gICAgTm93IHdlIGRvbid0IGhhdmUgYW55IGZyZWUg
bWVtb3J5IGluIChub2RlIDAsIFpPTkVfTk9STUFMKQ0KPiAgICBbQWN0dWFsbHkgdGhpcyBpcyBh
IHNpbXBsaWZpY2F0aW9uLCBidXQgaXQgZG9lc24ndCBtYXR0ZXINCj4gICAgaW4gdGhpcyBleGFt
cGxlXQ0KPiA2KSBPb3BzLCBzb21lIGludGVybmFsIGtlcm5lbCBtZW1vcnkgYWxsb2NhdGlvbiBo
YXBwZW4gd2hpY2gNCj4gICAgcmVxdWlyZXMgWk9ORV9OT1JNQUwuIEZvciBleGFtcGxlICJrbWFs
bG9jKHNpemUsIEdGUF9LRVJORUwpIg0KPiAgICB3YXMgY2FsbGVkLg0KPiAgICBTbyB0aGUgd2Ug
aGF2ZSBmb2xsb3dpbmcgbWVtb3J5IGxvb2t1cCBwYXRoOg0KPiAgICAobm9kZSAwLCBaT05FX05P
Uk1BTCkgLT4gKCJub2RlIDEiLCBaT05FX05PUk1BTCkNCj4gICAgVGhlcmUgaXMgbm8gZnJlZSBt
ZW1vcnkgaW4gIm5vZGUgMCIuIEFuZCB0aGVyZSBpcyBubw0KPiAgICBaT05FX05PUk1BTCBpbiAi
bm9kZSAxIi4gV2Ugb25seSBoYXZlIHNvbWUgZnJlZSBtZW1vcnkgaW4NCj4gICAgKG5vZGUgMSwg
Wk9ORV9ISUdITUVNKSBidXQgSElHSE1FTSBpc24ndCBzdWl0YWJsZSBpbiB0aGlzDQo+ICAgIGNh
c2UuDQo+IDcpIEFzIHdlIGNhbid0IGFsbG9jYXRlIG1lbW9yeSBPT00tS2lsbGVyIGlzIGludm9r
ZWQsIGV2ZW4gaWYNCj4gICAgd2UgaGF2ZSBzb21lIGZyZWUgbWVtb3J5IGluIChub2RlIDEsIFpP
TkVfSElHSE1FTSkuDQo+IA0KPiBUaGlzIHBhdGNoIHR3ZWFrcyBnZW5lcmljIG5vZGUgdG9wb2xv
Z3kgYW5kIG1hcmsgbWVtb3J5IGZyb20NCj4gIm5vZGUgMSIgYXMgdGhlIGNsb3Nlc3QgdG8gYW55
IENQVS4NCj4gDQo+IFNvIHRoZSB3ZSdsbCBoYXZlIGZvbGxvd2luZyBtZW1vcnkgbG9va3VwIHBh
dGg6DQo+ICAgICAobm9kZSAxLCBaT05FX0hJR0hNRU0pIC0+DQo+ICAtPiAobm9kZSAxLCBaT05F
X05PUk1BTCkgIC0+DQo+ICAtPiAobm9kZSAwLCBaT05FX0hJR0hNRU0pIC0+DQo+ICAtPiAobm9k
ZSAwLCBaT05FX05PUk1BTCkNCj4gSW4gY2FzZSBvZiBub2RlIGNvbmZpZ3VyYXRpb24gb24gQVJD
IHdlIG9idGFpbiB0aGUgZGVnZW5lcmF0ZSBjYXNlDQo+IG9mIHRoaXMgcGF0aDoNCj4gKG5vZGUg
MSwgWk9ORV9ISUdITUVNKSAtPiAobm9kZSAwLCBaT05FX05PUk1BTCkNCj4gDQo+IEluIHRoaXMg
Y2FzZSB3ZSBkb24ndCB3YXN0ZSAqdW5pdmVyc2FsKiBaT05FX05PUk1BTCBpZiB3ZSBjYW4gdXNl
DQo+IFpPTkVfSElHSE1FTSBzbyB3ZSBkb24ndCBmYWNlIHdpdGggdGhlIGlzc3VlIHBvaW50ZWQg
aW4gWzUtN10NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5Q
YWx0c2V2QHN5bm9wc3lzLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgdjEtPnYyOg0KPiAgKiBDaGFu
Z2VzIGluIGNvbW1pdCBtZXNzYWdlIGFuZCBjb21tZW50cyBpbiBhIGNvZGUuIE5vIGZ1bmN0aW9u
YWwNCj4gICAgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gIGFyY2gvYXJjL2luY2x1ZGUvYXNtL0ti
dWlsZCAgICAgfCAgMSAtDQo+ICBhcmNoL2FyYy9pbmNsdWRlL2FzbS90b3BvbG9neS5oIHwgMjQg
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FyYy9pbmNs
dWRlL2FzbS90b3BvbG9neS5oDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvaW5jbHVkZS9h
c20vS2J1aWxkIGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vS2J1aWxkDQo+IGluZGV4IGNhYTI3MDI2
MTUyMS4uZTY0ZTA0MzliYWZmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9pbmNsdWRlL2FzbS9L
YnVpbGQNCj4gKysrIGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vS2J1aWxkDQo+IEBAIC0xOCw3ICsx
OCw2IEBAIGdlbmVyaWMteSArPSBtc2kuaA0KPiAgZ2VuZXJpYy15ICs9IHBhcnBvcnQuaA0KPiAg
Z2VuZXJpYy15ICs9IHBlcmNwdS5oDQo+ICBnZW5lcmljLXkgKz0gcHJlZW1wdC5oDQo+IC1nZW5l
cmljLXkgKz0gdG9wb2xvZ3kuaA0KPiAgZ2VuZXJpYy15ICs9IHRyYWNlX2Nsb2NrLmgNCj4gIGdl
bmVyaWMteSArPSB1c2VyLmgNCj4gIGdlbmVyaWMteSArPSB2Z2EuaA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcmMvaW5jbHVkZS9hc20vdG9wb2xvZ3kuaCBiL2FyY2gvYXJjL2luY2x1ZGUvYXNtL3Rv
cG9sb2d5LmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5j
M2I4YWI3ZWQwMTENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL2FyYy9pbmNsdWRlL2Fz
bS90b3BvbG9neS5oDQo+IEBAIC0wLDAgKzEsMjQgQEANCj4gKyNpZm5kZWYgX0FTTV9BUkNfVE9Q
T0xPR1lfSA0KPiArI2RlZmluZSBfQVNNX0FSQ19UT1BPTE9HWV9IDQo+ICsNCj4gKy8qDQo+ICsg
KiBPbiBBUkMgKHcvbyBQQUUpIEhJR0hNRU0gYWRkcmVzc2VzIGFyZSBzbWFsbGVyICgweDAgYmFz
ZWQpIHRoYW4gYWRkcmVzc2VzIGluDQo+ICsgKiBOT1JNQUwgYWthIGxvdyBtZW1vcnkgKDB4ODAw
MF8wMDAwIGJhc2VkKS4NCj4gKyAqIFRodXMgSElHSE1FTSBvbiBBUkMgaXMgaW1wbGVtZW50ZWQg
d2l0aCBESVNDT05USUdNRU0gd2hpY2ggcmVxdWlyZXMgbXVsdGlwbGUNCj4gKyAqIG5vZGVzLiBT
byBoZXJlIGlzIG1lbW9yeSBub2RlIG1hcCBvbiBBUkM6DQo+ICsgKiAgLSBub2RlIDA6IFpPTkVf
Tk9STUFMICBtZW1vcnkgKGFsd2F5cykNCj4gKyAqICAtIG5vZGUgMTogWk9ORV9ISUdITUVNIG1l
bW9yeSAob25seSBpZiBDT05GSUdfSElHSE1FTSBpcyBlbmFibGVkKQ0KPiArICoNCj4gKyAqIElu
IGNhc2Ugb2YgQ09ORklHX0hJR0hNRU0gZW5hYmxlZCB3ZSB0d2VhayBnZW5lcmljIG5vZGUgdG9w
b2xvZ3kgYW5kIG1hcmsNCj4gKyAqIG5vZGUgMSBhcyB0aGUgY2xvc2VzdCB0byBhbGwgQ1BVcyB0
byBwcmlvcml0aXplIGFsbG9jYXRpb25zIGZyb20gWk9ORV9ISUdITUVNDQo+ICsgKiB3aGVyZSBp
dCBpcyBwb3NzaWJsZSB0byBhdm9pZCBaT05FX05PUk1BTCBwcmVzc3VyZS4NCj4gKyAqLw0KPiAr
I2lmZGVmIENPTkZJR19ISUdITUVNDQo+ICsjZGVmaW5lIGNwdV90b19ub2RlKGNwdSkJKCh2b2lk
KShjcHUpLCAxKQ0KPiArI2RlZmluZSBjcHVfdG9fbWVtKGNwdSkJCSgodm9pZCkoY3B1KSwgMSkN
Cj4gKyNkZWZpbmUgY3B1bWFza19vZl9ub2RlKG5vZGUpCSgobm9kZSkgPT0gMSA/IGNwdV9vbmxp
bmVfbWFzayA6IGNwdV9ub25lX21hc2spDQo+ICsjZW5kaWYgLyogQ09ORklHX0hJR0hNRU0gKi8N
Cj4gKw0KPiArI2luY2x1ZGUgPGFzbS1nZW5lcmljL3RvcG9sb2d5Lmg+DQo+ICsNCj4gKyNlbmRp
ZiAvKiBfQVNNX0FSQ19UT1BPTE9HWV9IICovDQotLSANCiBFdWdlbml5IFBhbHRzZXY=
