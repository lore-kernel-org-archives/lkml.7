Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C8DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55B0206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="QBLl96uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH0X5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:57:30 -0400
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:12159
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfH0X5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:57:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE41wjO0IeMGYxqF5hM2K0EN6hda3u4gpYt59p25Qa4DXMcKBClRa3VYXG9U5P7VRGiyW5YOT+NtydERTQy8CSatKIZIVzFXLCGyndcKC+FBVfbOcDT978l6lqbBNpRr+JZn87I+1ERir4pPPzNEMJ1SkMnJGAwzwi6fwHr5aDnd+VJb55eItr/kZXN+UHqLKTxiwdmLdYVnhwQJ4cWI/XFmXTcVpC/ThQZVB50t1lTpsWJBxq3aoz5re1FglhODuNvO17HLYOdaJzImizW2lKGcsY2LWEnNCFu710eB9cdzrxkmYF8H78J4A7AnxVvc2zcQ1J8yK218hpqvLmFmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPEBqVN+D+30aH6UEZY33Ng9mjpVGO7u0ZPJ12lzv3c=;
 b=OY6QmHl+kBLODGr1Es3sKZQv9qGZlE3MGzlmD0zsalVNFglQgcMGpUobRpJMn7zIIZNHNxfLrf6xdp2kQ5Gv80Ybkl6fL0WKZd99M8UMz2zJld8JO94/lIktZEwVk334pLvsqprSfgZP73dCU0nmwxrVWIC43zURPnlkWTFmrBC7WdJNzLmZh3ygQ2eRk1hT58nw3BHnVHwA0JY2nLus8QrdT6aAt0tpTEC4fMApOfWnD1ihgaN1O9FCSQVNp44ZBt2bhYX6vud1M/sUuZBQF0B1IRT+2QxRzt6UnOr9OUA2K3mbvlXR+/QNLq7TTIukVIwpnoLvimFPL2hBIfVPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPEBqVN+D+30aH6UEZY33Ng9mjpVGO7u0ZPJ12lzv3c=;
 b=QBLl96uZvkDkhozvntpfJMbR3ZXLri3ej1LqzEM4QaFW8apo87fk016Hs4NUehghMaDMskki4dJ7VJ8zJGmqT9ALo1B3180pgnLe+v5elgaE1Y4LoSjk2u0c+V6vZ+aJB2jyxEZVM7300bZ6nDNW+VSgUAAcQ2q+aqTWj780R8o=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4454.namprd05.prod.outlook.com (52.135.203.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.14; Tue, 27 Aug 2019 23:57:27 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d%3]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 23:57:27 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH v2 3/3] x86/mm/tlb: Avoid deferring PTI flushes on
 shootdown
Thread-Topic: [RFC PATCH v2 3/3] x86/mm/tlb: Avoid deferring PTI flushes on
 shootdown
Thread-Index: AQHVWkMMxLgBaXKXcUCwxENh24EP16cPo/6AgAAN1gA=
Date:   Tue, 27 Aug 2019 23:57:27 +0000
Message-ID: <F9CA7AFA-D54B-4458-8248-CA52584C13CD@vmware.com>
References: <20190823225248.15597-1-namit@vmware.com>
 <20190823225248.15597-4-namit@vmware.com>
 <CALCETrXjqa6pWpAgh7v-sttOwY0V2RUqQ_Vs-JQr7nFDYvrBpQ@mail.gmail.com>
In-Reply-To: <CALCETrXjqa6pWpAgh7v-sttOwY0V2RUqQ_Vs-JQr7nFDYvrBpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:6d44:2c40:29b9:7215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b0baaa7-85fb-43c1-cf47-08d72b4a507e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4454;
x-ms-traffictypediagnostic: BYAPR05MB4454:
x-microsoft-antispam-prvs: <BYAPR05MB4454E47735D94757E9C28EF8D0A00@BYAPR05MB4454.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(6116002)(11346002)(2616005)(6486002)(102836004)(53546011)(6916009)(5660300002)(186003)(6512007)(6436002)(8676002)(6506007)(476003)(446003)(486006)(14454004)(46003)(76176011)(54906003)(316002)(2906002)(86362001)(66446008)(64756008)(66556008)(66476007)(76116006)(7736002)(66946007)(71200400001)(8936002)(81156014)(478600001)(33656002)(14444005)(256004)(81166006)(4326008)(53936002)(36756003)(25786009)(71190400001)(6246003)(99286004)(305945005)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4454;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k0WUNlswwP8/q3xYtMfXkxOLgPlKRoiMaCSNt8SL2vj/8Sw0Jf3EmJVkQ6DN1l2ukbkWRrDLrJiVNQxdS1Dcvpls7hX/OQGVDVuxZui5i6BfWqoLwuu6dQxRDLxH254NEjyCT9LpcjtTUczjNeiNl4G//kO+MAE2Q/7UeV1ARXM8CmPT7EVr0PK8/WaLPaiLKRTyYMLbisJGOIDhU8eyThOjmCyJ3/7cr4P5Z4tk3TqKvB1xmD9EJH4xFH3dJYVENeIzFqP4UB4hzLjCwOuthxf0y3jZZblyyU+jwviR9nr9Ny8BZRl/ddMU3/dneIT6iZgPNN4VvudjP5Zk9cDBlxglmkYccHuj4viquIaATFCAmgLhg2iIn5R0SKl27LQR+eOqmMtYDN/SdDftKzlivsF3x4wI+oAXRo0FtmAk5LM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C549341F8167824BA566AF57FD749DDF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0baaa7-85fb-43c1-cf47-08d72b4a507e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 23:57:27.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLOXF5BTC6Pk4MvOjxJ2W87SUlXl7ilXVZDaVGFNlRMoexyx5+XWAYuBNWqE4X5G61j0oKyC1g87+SnK7m+seQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBdWcgMjcsIDIwMTksIGF0IDQ6MDcgUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgQXVnIDIzLCAyMDE5IGF0IDExOjEzIFBNIE5h
ZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gV2hlbiBhIHNob290ZG93biBp
cyBpbml0aWF0ZWQsIHRoZSBpbml0aWF0aW5nIENQVSBoYXMgY3ljbGVzIHRvIGJ1cm4gYXMNCj4+
IGl0IHdhaXRzIGZvciB0aGUgcmVzcG9uZGluZyBDUFVzIHRvIHJlY2VpdmUgdGhlIElQSSBhbmQg
YWNrbm93bGVkZ2UgaXQuDQo+PiBJbiB0aGVzZSBjeWNsZXMgaXQgaXMgYmV0dGVyIHRvIGZsdXNo
IHRoZSB1c2VyIHBhZ2UtdGFibGVzIHVzaW5nDQo+PiBJTlZQQ0lELCBpbnN0ZWFkIG9mIGRlZmVy
cmluZyB0aGUgVExCIGZsdXNoLg0KPj4gDQo+PiBUaGUgYmVzdCB3YXkgdG8gZmlndXJlIG91dCB3
aGV0aGVyIHRoZXJlIGFyZSBjeWNsZXMgdG8gYnVybiBpcyBhcmd1YWJseQ0KPj4gdG8gZXhwb3Nl
IGZyb20gdGhlIFNNUCBsYXllciB3aGVuIGFuIGFja25vd2xlZGdtZW50IGlzIHJlY2VpdmVkLg0K
Pj4gSG93ZXZlciwgdGhpcyB3b3VsZCBicmVhayBzb21lIGFic3RyYWN0aW9ucy4NCj4+IA0KPj4g
SW5zdGVhZCwgdXNlIGEgc2ltcGxlciBzb2x1dGlvbjogdGhlIGluaXRpYXRpbmcgQ1BVIG9mIGEg
VExCIHNob290ZG93bg0KPj4gd291bGQgbm90IGRlZmVyIFBUSSBmbHVzaGVzLiBJdCBpcyBub3Qg
YWx3YXlzIGEgd2luLCByZWxhdGl2ZWx5IHRvDQo+PiBkZWZlcnJpbmcgdXNlciBwYWdlLXRhYmxl
IGZsdXNoZXMsIGJ1dCBpdCBwcmV2ZW50cyBwZXJmb3JtYW5jZQ0KPj4gcmVncmVzc2lvbi4NCj4+
IA0KPj4gU2lnbmVkLW9mZi1ieTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4+IC0t
LQ0KPj4gYXJjaC94ODYvaW5jbHVkZS9hc20vdGxiZmx1c2guaCB8ICAxICsNCj4+IGFyY2gveDg2
L21tL3RsYi5jICAgICAgICAgICAgICAgfCAxMCArKysrKysrKystDQo+PiAyIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90
bGJmbHVzaC5oDQo+PiBpbmRleCBkYTU2YWEzY2NkMDcuLjA2NmIzODA0Zjg3NiAxMDA2NDQNCj4+
IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCj4+ICsrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCj4+IEBAIC01NzMsNiArNTczLDcgQEAgc3RydWN0IGZs
dXNoX3RsYl9pbmZvIHsNCj4+ICAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBpbml0aWF0
aW5nX2NwdTsNCj4+ICAgICAgICB1OCAgICAgICAgICAgICAgICAgICAgICBzdHJpZGVfc2hpZnQ7
DQo+PiAgICAgICAgdTggICAgICAgICAgICAgICAgICAgICAgZnJlZWRfdGFibGVzOw0KPj4gKyAg
ICAgICB1OCAgICAgICAgICAgICAgICAgICAgICBzaG9vdGRvd247DQo+IA0KPiBJIGZpbmQgdGhl
IG5hbWUgInNob290ZG93biIgdG8gYmUgY29uZnVzaW5nLiAgSG93IGFib3V0ICJtb3JlX3RoYW5f
b25lX2NwdeKAnT8NCg0KSSB0aGluayB0aGUgY3VycmVudCBzZW1hbnRpYyBpcyBtb3JlIG9mIOKA
nGluY2x1ZGVzIHJlbW90ZSBjcHVz4oCdLiBIb3cgYWJvdXQNCmNhbGxpbmcgaXQg4oCcbG9jYWxf
b25seeKAnSwgYW5kIG5lZ2F0aW5nIGl0cyB2YWx1ZT8=
