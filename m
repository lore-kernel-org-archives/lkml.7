Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370EEC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 04:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63F320842
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 04:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="MBuW5i3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfJBEnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 00:43:05 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:50178
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbfJBEnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 00:43:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/pcdmmwV007MZ1+1Hwvl0TLkjVuofRcKym9ArL0AR0FZ3bnpURQKmS90WMr5IdyBkAofJnUZ3KhBQGe3V2YluCUIBOyE+Noe3ZPq371GmO03+p3XMW8xdM4khcSp7GhYF0rfg0PMsuaViqtlfAxNLZlnlA3LkDEzanlZNPO/5FtDSKHkNjPRFWVZuYb7SXHSPQypK6KALI2x+lYItp26WyW7na4Mnc+9caO86d1dU6TrAcaKDDiXBeRY4nX8q9ypB5ZVZrj82XocXtZLhIMxPietKSIBserFRXzGRz6UxvOprAsp2tBhHQCxd9Ee7nTd3lYv92uN5M14pEUuN+gFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00xFwGDkfgNmlC3ML5nChLpnvw2PQfd/d6p8QCfyg8U=;
 b=kGEjFwUerFNiwO4q6g+IVUdThspZYKxc+GsLZI7YnqapDEOwgm/aAVFGxSIdYoxTSE/ajvbemU2SINfT0f97Cv0P62wDz3hI4/hfpQFwJKC2eX2nAJf6cDemfHH0zcw+w0kRhabPBShb87TiW5F1i/2kx7TgptHjV1p3uR8BkI2WNKzONo4WGvz7P4Qoqk9dM0A+XfQQRjISnYIdVPEp9GOvl+A2AvXMzb8a5V4kdoDitI5dXv2G0Vasu6VqI9MibLgUSDcHZi7khOOOV7CXt2iCQmmyJeBuyoUGU8wC+ofXuKePPcNI/+t/jabTIA+LO6cxSucnJ4E35HiZsBpU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00xFwGDkfgNmlC3ML5nChLpnvw2PQfd/d6p8QCfyg8U=;
 b=MBuW5i3lfAFl+ALQCEEdbm3lIZhM7slAdOOt5vatvTKlvcOnxQAH6/w+sCXmB+1f5BoFVrQQ2ufBQ28lQjoHJ5bDbHYNUTNyhc1J71nfQLuwWJHgfeqNc+croKmg97zY71QWbQ2oTYAc5drx91LGunzpTRSnphj04SuvShmalBY=
Received: from AM6PR03MB5958.eurprd03.prod.outlook.com (10.255.122.93) by
 AM6PR03MB5576.eurprd03.prod.outlook.com (20.179.246.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 04:42:59 +0000
Received: from AM6PR03MB5958.eurprd03.prod.outlook.com
 ([fe80::21:60d7:a2a6:12f0]) by AM6PR03MB5958.eurprd03.prod.outlook.com
 ([fe80::21:60d7:a2a6:12f0%5]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 04:42:59 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Rob Herring <robh@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juergen Gross <jgross@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
Thread-Topic: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
Thread-Index: AQHVc+s0RRpCCJNN+0uv/ZIcTqnc7ac9t66AgAAHl4CAAAgUAIAACJOAgACJPACAB8m0AIAArQUA
Date:   Wed, 2 Oct 2019 04:42:59 +0000
Message-ID: <37dbe77a-72df-7556-f8e7-a73ea0f974bc@epam.com>
References: <20190925215006.12056-1-robh@kernel.org>
 <e898c025-32a7-1d2c-3501-c99556f7cdd4@arm.com>
 <1ae7f42e-bf93-b335-b543-653fae5cf49f@epam.com>
 <28440326-ed76-b014-c1b8-02125c3214b9@arm.com>
 <f63f55eb-969e-6364-5781-a227d0c04e4c@epam.com>
 <CAL_JsqKJP3itMOueZD7fGH2b6VNFrTuozW5tWyKN3uBg4gYMzA@mail.gmail.com>
 <alpine.DEB.2.21.1910011112020.20899@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.1910011112020.20899@sstabellini-ThinkPad-T480s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a796edff-d5cc-486b-94db-08d746f30060
x-ms-traffictypediagnostic: AM6PR03MB5576:
x-microsoft-antispam-prvs: <AM6PR03MB557639ED14675C7F0BFEBEE4E79C0@AM6PR03MB5576.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(54014002)(199004)(189003)(66556008)(66946007)(66446008)(80792005)(14444005)(64756008)(66066001)(6512007)(7416002)(71190400001)(53546011)(71200400001)(6506007)(6436002)(4326008)(26005)(6486002)(86362001)(476003)(91956017)(76116006)(2616005)(36756003)(11346002)(14454004)(446003)(256004)(66476007)(76176011)(8936002)(316002)(6116002)(3846002)(31686004)(6246003)(229853002)(8676002)(110136005)(81156014)(2906002)(478600001)(305945005)(54906003)(7736002)(186003)(486006)(31696002)(25786009)(5660300002)(102836004)(55236004)(99286004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB5576;H:AM6PR03MB5958.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NouSZ4w75eB1s/YAhk+VxGtSYPJ+SGtOpjUj0aIZ19hmeCPbBzw5PSVLgLJpBUy4GxSOtPef0Vg8we+1OEn2UgwExqsaJukrVlEt0oLoBKK8LNMS7dhG8WdqfihwlCVdALZd3ggP2zNQUTYU5hCM3EC0aukmiuVQXzIubJ/mW8caaCtzQ7aceVEkOEeWect5bPbtjiRTtRIMeYCUK1eUwa9Edi/7XcsNe7PJ28ySTde1CfC98DYAoy4prDi2unaj5M45oc9slQRCSTfRBZwzyfO54uMH0CXUCdCNmFNkbKSVKHQzNl4cGkJ0Culz8buon+si01x5lqqKY35/bKzX+Kkgy0ZIcAErJUROjCkt9+eFGa0vU27hwQHYGCKpAOOhEMIYG1YDa686s/8XsTzxMj+BHoxt8Je3xh3T2KRTf0o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CB3F2654A64FE4A85BF3272B77952F4@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a796edff-d5cc-486b-94db-08d746f30060
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 04:42:59.2431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYD90QzOwOz17Nw9nnn/+UEa+Aff6gAZs1+xInXTc5o/Nnbjta2w4EnlMnSvDON+0gSrWvxGW3GTLkrLkZmgeiuQfErUt4Juj5UjR7ZhKkgEglpJB7aETiaXEdv/qubJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8xOSA5OjIzIFBNLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6DQo+IE9uIFRodSwg
MjYgU2VwIDIwMTksIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4gT24gVGh1LCBTZXAgMjYsIDIwMTkg
YXQgNjoxNiBBTSBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbw0KPj4gPE9sZWtzYW5kcl9BbmRydXNo
Y2hlbmtvQGVwYW0uY29tPiB3cm90ZToNCj4+PiBPbiA5LzI2LzE5IDE6NDYgUE0sIFJvYmluIE11
cnBoeSB3cm90ZToNCj4+Pj4gT24gMjAxOS0wOS0yNiAxMToxNyBhbSwgT2xla3NhbmRyIEFuZHJ1
c2hjaGVua28gd3JvdGU6DQo+Pj4+PiBPbiA5LzI2LzE5IDEyOjQ5IFBNLCBKdWxpZW4gR3JhbGwg
d3JvdGU6DQo+Pj4+Pj4gSGkgUm9iLA0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBPbiA5LzI1LzE5
IDEwOjUwIFBNLCBSb2IgSGVycmluZyB3cm90ZToNCj4+Pj4+Pj4gQXMgdGhlIGNvbW1lbnQgc2F5
cywgdGhpcyBpc24ndCBhIERUIGJhc2VkIGRldmljZS4gb2ZfZG1hX2NvbmZpZ3VyZSgpDQo+Pj4+
Pj4+IGlzIGdvaW5nIHRvIHN0b3AgYWxsb3dpbmcgYSBOVUxMIERUIG5vZGUsIHNvIHRoaXMgbmVl
ZHMgdG8gYmUgZml4ZWQuDQo+Pj4+Pj4gQW5kIHRoaXMgY2FuJ3Qgd29yayBvbiBhcmNoIG5vdCBz
ZWxlY3RpbmcgQ09ORklHX09GIGFuZCBjYW4gc2VsZWN0DQo+Pj4+Pj4gQ09ORklHX1hFTl9HUkFO
VF9ETUFfQUxMT0MuDQo+Pj4+Pj4NCj4+Pj4+PiBXZSBhcmUgbHVja3kgZW5vdWdoIG9uIHg4NiBi
ZWNhdXNlLCBBRkFJQ1QsIGFyY2hfc2V0dXBfZG1hX29wcyBpcyBqdXN0DQo+Pj4+Pj4gYSBub3Au
DQo+Pj4+Pj4NCj4+Pj4+IE5vIGx1Y2sgaXMgbmVlZGVkIGFzIFsxXSBkb2VzIG5vdGhpbmcgZm9y
IHRob3NlIHBsYXRmb3JtcyBub3QgdXNpbmcNCj4+Pj4+IENPTkZJR19PRg0KPj4+Pj4+PiBOb3Qg
c3VyZSBleGFjdGx5IHdoYXQgc2V0dXAgYmVzaWRlcyBhcmNoX3NldHVwX2RtYV9vcHMgaXMgbmVl
ZGVkLi4uDQo+Pj4+Pj4gV2UgcHJvYmFibHkgd2FudCB0byB1cGRhdGUgZG1hX21hc2ssIGNvaGVy
ZW50X2RtYV9tYXNrIGFuZA0KPj4+Pj4+IGRtYV9wZm5fb2Zmc2V0Lg0KPj4+Pj4+DQo+Pj4+Pj4g
QWxzbywgd2hpbGUgbG9vayBhdCBvZl9jb25maWd1cmVfZG1hLCBJIG5vdGljZWQgdGhhdCB3ZSBj
b25zaWRlciB0aGUNCj4+Pj4+PiBETUEgd2lsbCBub3QgYmUgY29oZXJlbnQgZm9yIHRoZSBncmFu
dC10YWJsZS4gT2xla3NhbmRyLCBkbyB5b3Uga25vdw0KPj4+Pj4+IHdoeSB0aGV5IGNhbid0IGJl
IGNvaGVyZW50Pw0KPj4+Pj4gVGhlIG1haW4gYW5kIHRoZSBvbmx5IHJlYXNvbiB0byB1c2Ugb2Zf
Y29uZmlndXJlX2RtYSBpcyB0aGF0IGlmIHdlIGRvbid0DQo+Pj4+PiB0aGVuIHdlDQo+Pj4+PiBh
cmUgYWJvdXQgdG8gc3RheSB3aXRoIGRtYV9kdW1teV9vcHMgWzJdLiBJdCBlZmZlY3RpdmVseSBt
ZWFucyB0aGF0DQo+Pj4+PiBvcGVyYXRpb25zIG9uIGRtYS1idWZzDQo+Pj4+PiB3aWxsIGVuZCB1
cCByZXR1cm5pbmcgZXJyb3JzLCBsaWtlIFszXSwgWzRdLCB0aHVzIG5vdCBtYWtpbmcgaXQgcG9z
c2libGUNCj4+Pj4+IGZvciBYZW4gUFYgRFJNIGFuZCBETUENCj4+Pj4+IHBhcnQgb2YgZ250ZGV2
IGRyaXZlciB0byBkbyB3aGF0IHdlIG5lZWQgKGRtYS1idWZzIGluIG91ciB1c2UtY2FzZXMNCj4+
Pj4+IGFsbG93IHplcm8tY29weWluZw0KPj4+Pj4gd2hpbGUgdXNpbmcgZ3JhcGhpY3MgYnVmZmVy
cyBhbmQgbWFueSBtb3JlKS4NCj4+Pj4+DQo+Pj4+PiBJIGRpZG4ndCBmaW5kIGFueSBiZXR0ZXIg
d2F5IG9mIGFjaGlldmluZyB0aGF0LCBidXQgb2ZfY29uZmlndXJlX2RtYS4uLg0KPj4+Pj4gSWYg
dGhlcmUgaXMgYW55IGJldHRlciBzb2x1dGlvbiB3aGljaCB3aWxsIG5vdCBicmVhayB0aGUgZXhp
c3RpbmcNCj4+Pj4+IGZ1bmN0aW9uYWxpdHkgdGhlbg0KPj4+Pj4gSSB3aWxsIGRlZmluaXRlbHkg
Y2hhbmdlIHRoZSBkcml2ZXJzIHNvIHdlIGRvIG5vdCBhYnVzZSBEVCApDQo+Pj4+PiBCZWZvcmUg
dGhhdCwgcGxlYXNlIGtlZXAgaW4gbWluZCB0aGF0IG1lcmdpbmcgdGhpcyBSRkMgd2lsbCBicmVh
ayBYZW4gUFYNCj4+Pj4+IERSTSArDQo+Pj4+PiBETUEgYnVmIHN1cHBvcnQgaW4gZ250ZGV2Li4u
DQo+Pj4+PiBIb3BlIHdlIGNhbiB3b3JrIG91dCBzb21lIGFjY2VwdGFibGUgc29sdXRpb24sIHNv
IGV2ZXJ5b25lIGlzIGhhcHB5DQo+Pj4+IEFzIEkgbWVudGlvbmVkIGVsc2V3aGVyZSwgdGhlIHJl
Y2VudCBkbWEtZGlyZWN0IHJld29yayBtZWFucyB0aGF0DQo+Pj4+IGRtYV9kdW1teV9vcHMgYXJl
IG5vdyBvbmx5IGV4cGxpY2l0bHkgaW5zdGFsbGVkIGZvciB0aGUgQUNQSSBlcnJvcg0KPj4+PiBj
YXNlLCBzbyAtIG11Y2ggYXMgSSBtYXkgZGlzbGlrZSBpdCAtIHlvdSBzaG91bGQgZ2V0IHJlZ3Vs
YXINCj4+Pj4gKGRpcmVjdC9TV0lPVExCKSBvcHMgYnkgZGVmYXVsdCBhZ2Fpbi4NCj4+PiBBaCwg
bXkgYmFkLCBJIG1pc3NlZCB0aGF0IGNoYW5nZS4gU28sIGlmIG5vIGR1bW15IGRtYSBvcHMgYXJl
IHRvIGJlIHVzZWQNCj4+PiB0aGVuDQo+Pj4gSSBiZWxpZXZlIHdlIGNhbiBhcHBseSBib3RoIGNo
YW5nZXMsIGUuZy4gcmVtb3ZlIG9mX2RtYV9jb25maWd1cmUgZnJvbQ0KPj4+IGJvdGggb2YgdGhl
IGRyaXZlcnMuDQo+PiBXaGF0IGFib3V0IHRoZSBkbWEgbWFza3M/IEkgdGhpbmsgdGhlcmUncyBh
IGRlZmF1bHQgc2V0dXAsIGJ1dCBpdCBpcw0KPj4gY29uc2lkZXJlZCBhIGRyaXZlciBidWcgdG8g
bm90IHNldCBpdHMgbWFzay4geGVuX2RybV9mcm9udCBzZXRzIHRoZQ0KPj4gY29oZXJlbnRfZG1h
X21hc2sgKHdoeSBvbmx5IDMyLWJpdHMgdGhvdWdoPyksIGJ1dCBub3QgdGhlIGRtYV9tYXNrLg0K
Pj4gZ250ZGV2IGlzIGRvaW5nIG5laXRoZXIuIEkgY291bGQgY29weSBvdXQgd2hhdCBvZl9kbWFf
Y29uZmlndXJlIGRvZXMNCj4+IGJ1dCBiZXR0ZXIgZm9yIHRoZSBYZW4gZm9sa3MgdG8gZGVjaWRl
IHdoYXQgaXMgbmVlZGVkIG9yIG5vdCBhbmQgdGVzdA0KPj4gdGhlIGNoYW5nZS4gSSdtIG5vdCBz
ZXR1cCB0byB0ZXN0IGFueSBvZiB0aGlzLg0KPiBGWUkgSSBoYXZlIHNlZW4gdGhlIGlzc3VlIE9s
ZWtzYW5kciBpcyB0YWxraW5nIGFib3V0IHRvby4gSSBjb25maXJtIHRoYXQNCj4gdGhlIG9ubHkg
cmVhc29uIGZvciB0aGUgb2ZfY29uZmlndXJlX2RtYSBjYWxsIGlzIHRvIGdldCBhd2F5IGZyb20g
dGhlDQo+IGR1bW15X2RtYV9vcHMgYW5kIHVzZSB0aGUgZGVmYXVsdCBkbWFfb3BzIGluc3RlYWQu
IEkgdGhpbmsgdGhpcyBzaG91bGQNCj4gYmUgbWVudGlvbmVkIGluIHRoZSBjb21taXQgbWVzc2Fn
ZSBzbyB0aGF0IGlmIG9uZSBkYXkgdGhlIGJlaGF2aW9yDQo+IHJlZ2FyZGluZyBkdW1teV9kbWFf
b3BzIGNoYW5nZXMgb25lIG1vcmUgdGltZSwgaG9wZWZ1bGx5IHdlJ2xsIGJlIGFibGUNCj4gdG8g
ZmlndXJlIG91dCB0aGUgaXNzdWUgbW9yZSBlYXNpbHkgd2l0aCBiaXNlY3Rpb24uDQo+DQo+IElu
IHJlZ2FyZHMgdG8gdGhlIGNvaGVyZW50X2RtYV9tYXNrIGFuZCBkbWFfbWFzaywgSSBjYW4ndCBz
ZWUgd2h5IGdudGRldg0KPiB3b3VsZCBoYXZlIGFueSBkbWEgYWRkcmVzc2luZyBsaW1pdGF0aW9u
cywgc28gd2Ugc2hvdWxkIGJlIGFibGUgdG8gc2V0DQo+IGJvdGggdG8gNjQgYml0cy4gIEkgYWxz
byBjYW4ndCBzZWUgd2h5IHhlbl9kcm1fZnJvbnQgd291bGQgbGltaXQgaXQgdG8NCj4gMzIgYml0
cywgYWZ0ZXIgYWxsIHRoaXMgaXMganVzdCB0aGUgZnJvbnRlbmQsIGlmIGFueXRoaW5nIGl0IHdv
dWxkIGJlDQo+IHRoZSBiYWNrZW5kIHRoYXQgaGFzIGEgbGltaXRhdGlvbi4gU28sIHdlIHNob3Vs
ZCBiZSBhYmxlIHRvIHNldCBib3RoDQo+IGRtYV9tYXNrIGFuZCBjb2hlcmVudF9kbWFfbWFzayBp
biB4ZW5fZHJtX2Zyb250IHRvIDY0IGJpdHMuIE9sZWtzYW5kciwNCj4gY2FuIHlvdSBjb25maXJt
Pw0KSSBhbSB0b3RhbGx5IGZpbmUgd2l0aCA2NC1iaXRzIGluIGJvdGggY2FzZXMgYW5kDQphZ3Jl
ZSB3aXRoIHdoYXQgU3RlZmFubyBzYXlzLg0K
