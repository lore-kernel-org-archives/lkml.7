Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03625C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C146123429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="zAuFssP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfH3R6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:58:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:35052 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727883AbfH3R6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:58:30 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7UHtSBv009835;
        Fri, 30 Aug 2019 10:58:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=wPq2JhK4pWkyO4s2bIIuksqdXDB+Xo+OZu0IFNO0jbo=;
 b=zAuFssP+PdadsMQ48xOv6f7LCPF3VQ13V9gHpu6WVtdWVlPmDU0yE+/MdAZaiTKNKLBr
 0dsA9gv4dREmmKF0MbY3MXgt5sxFMvAdUsBIXwipR/193MPOB/QyYXFG/FU8Y3PUeT9q
 /6Q2EFWq29etpbh5h+kaJqHNmUhm70yNJ9GSwAYkAdZO+emz/lUOEJXEo2/d2xaDB3SD
 f+FfSps2VgqqAP+Kl+Ukhnj2Mno9lmNLSr87QLz2HGC0u4nLAIlb/NyQizLtCdVvgidU
 0TWNgQ+E/n53ZN2njg5GOZcNNs/YVDB6AxqR9PEDbkf3SxEi9nbgLKiVq0VvUq8Ic5I4 Ng== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2uk155wp35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 10:58:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abaQr9z2jZSh2/tHpQJD6iKgcex9Bln6AOedCRScBTqzbhJ97SW3HH6Fkc1tTweEvsgGoZQ5VTUzRkkSrbAUOtZyRw4UJVbIY68q0OOUpiu8dFAbpSNuGyp+6gTzYNqf2KBm+7789eSW9RIuZ2DZkGxqc7OqkLc85zvvg2aXfRTol/H7mEqW+GycHTKDPJlywc4FrKRv7rlSRFJo0YFNPVBvidmxdcUFaFOB4cVXLY0IWE5yK3Z/P9uQxKf967878w2hREY08hLDONERYOU/RW0LjAu0uBiAc2O4N467/kkCboxc2LPP9QDksorH58US3rqqBuahUVwhh75KgK4K2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPq2JhK4pWkyO4s2bIIuksqdXDB+Xo+OZu0IFNO0jbo=;
 b=dva+MuXB9Z3cQoY2545jdw0Rji0lk3WeiB4h7ZHXeGtJOzmwUTjyUfPLTmQmk19OChKJAy8KPwQslRYJZRijpR7O1im4OBDVFNu2LjiKZNHzxyMwYuwKE/wdw7G4MqOE5QXhfdkBm6Rqs4GWKvT2n5lz4GA08VTY6tI0J7coaU/Tqrrda+Br/e9CMnEgeaUopFxSsOFidmvDJjpA4KHYQ9NqfxIVDehxQ8tXbascn882UIaMDWKKNljBm9iolL7oxbdj+MQY8q334oVjXECFHiQwC8SPoD7dSnWdRBxenjlU35QDam6p0Xx56JG7DM39GYtmNhaO3U13M2T0p77h6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB3634.namprd02.prod.outlook.com (52.132.27.154) by
 BL0PR02MB5603.namprd02.prod.outlook.com (20.177.241.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 17:58:24 +0000
Received: from BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::c9b1:7869:4f3f:713f]) by BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::c9b1:7869:4f3f:713f%6]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 17:58:23 +0000
From:   Matej Genci <matej.genci@nutanix.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: Change typecasts in vring_init()
Thread-Topic: [PATCH] virtio: Change typecasts in vring_init()
Thread-Index: AQHVXOsGnWphIXIpHkCP5ncx23ivmacTvUwAgABB5YA=
Date:   Fri, 30 Aug 2019 17:58:23 +0000
Message-ID: <41b8eb4b-0d3b-f103-9ec4-332a903612ee@nutanix.com>
References: <20190827152000.53920-1-matej.genci@nutanix.com>
 <20190830095928-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190830095928-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6880727c-a5f0-42c1-3d38-08d72d73a6cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR02MB5603;
x-ms-traffictypediagnostic: BL0PR02MB5603:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR02MB5603D513C07DE6AE9940C26DFBBD0@BL0PR02MB5603.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(52314003)(76116006)(66946007)(91956017)(66446008)(64756008)(66556008)(66476007)(4326008)(6436002)(25786009)(44832011)(99286004)(2906002)(53546011)(256004)(7736002)(6506007)(76176011)(6916009)(486006)(11346002)(8936002)(14454004)(66066001)(5660300002)(446003)(2616005)(476003)(102836004)(3846002)(53936002)(6246003)(6486002)(36756003)(229853002)(305945005)(81166006)(6512007)(6306002)(8676002)(186003)(81156014)(86362001)(26005)(6116002)(316002)(508600001)(966005)(71200400001)(31696002)(71190400001)(54906003)(31686004)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB5603;H:BL0PR02MB3634.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RTQ+yyZdi7DdaybRJzdT5EjbMiS2tydueqYF88acKICnlWAz1DadZYN/09j5ukffcUMsw9rW5HRjyr1pHuIkZopGz3KS8sd1TCsp+kJ3UUApN+kE+ZrZ9oiBwLWPKSSZuR95QjmWcq6rnNTYQYXq03ogQWptaxA6LvLlPCL3HTzFbTYmA6uFuMojoxswjNVlNbso0QT6T3Cw2h6NLjzfFrorj/J2M07NBsC/NVNpNAMHCTiDoqBlJ7bupGJcrlcqdGY+I108dzol4nBmRQJ7ASSvO23ALQhd2zqXv1GEv7PI2UIGg5JjuChWg/H5PBM7RAXMnzw8nMOEpvVd1bJRDebLU9oZrqbO1YayRjeqvR39qyyyF2hqz/gn55Ahvb48eT2x/VZbBovQ0rbiHQi6ki1Umbxg9PcWBBHoeM3S6Sk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <402C8B5B2199B14DB27B03FE3342A9EB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6880727c-a5f0-42c1-3d38-08d72d73a6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 17:58:23.7297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrPDnopIGgNhcUXnGF7W2ZMdE/Q0rZJt0ARPc0o0szJVSIyh3sXqX5O644R6ejiRxBCXpuBBsyZWqyPrbkDT4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5603
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-30_06:2019-08-29,2019-08-30 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8zMC8yMDE5IDM6MDIgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24gVHVl
LCBBdWcgMjcsIDIwMTkgYXQgMDM6MjA6NTdQTSArMDAwMCwgTWF0ZWogR2VuY2kgd3JvdGU6DQo+
PiBDb21waWxlcnMgc3VjaCBhcyBnKysgNy4zIGNvbXBsYWluIGFib3V0IGFzc2lnbmluZyB2b2lk
KiB2YXJpYWJsZSB0bw0KPj4gYSBub24tdm9pZCogdmFyaWFibGUgKGxpa2Ugc3RydWN0IHBvaW50
ZXJzKSBhbmQgcG9pbnRlciBhcml0aG1ldGljcw0KPj4gb24gdm9pZCouDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogTWF0ZWogR2VuY2kgPG1hdGVqLmdlbmNpQG51dGFuaXguY29tPg0KPj4gLS0tDQo+
PiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcmluZy5oIHwgOSArKysrKy0tLS0NCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmggYi9pbmNsdWRlL3Vh
cGkvbGludXgvdmlydGlvX3JpbmcuaA0KPj4gaW5kZXggNGM0ZTI0YzI5MWE1Li4yYzMzOWI5ZTI5
MjMgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3JpbmcuaA0KPj4g
KysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmgNCj4+IEBAIC0xNjgsMTAgKzE2
OCwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdnJpbmdfaW5pdChzdHJ1Y3QgdnJpbmcgKnZyLCB1
bnNpZ25lZCBpbnQgbnVtLCB2b2lkICpwLA0KPj4gICAJCQkgICAgICB1bnNpZ25lZCBsb25nIGFs
aWduKQ0KPj4gICB7DQo+PiAgIAl2ci0+bnVtID0gbnVtOw0KPj4gLQl2ci0+ZGVzYyA9IHA7DQo+
PiAtCXZyLT5hdmFpbCA9IHAgKyBudW0qc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjKTsNCj4+IC0J
dnItPnVzZWQgPSAodm9pZCAqKSgoKHVpbnRwdHJfdCkmdnItPmF2YWlsLT5yaW5nW251bV0gKyBz
aXplb2YoX192aXJ0aW8xNikNCj4+IC0JCSsgYWxpZ24tMSkgJiB+KGFsaWduIC0gMSkpOw0KPj4g
Kwl2ci0+ZGVzYyA9IChzdHJ1Y3QgdnJpbmdfZGVzYyAqKXA7DQo+PiArCXZyLT5hdmFpbCA9IChz
dHJ1Y3QgdnJpbmdfYXZhaWwgKikoKHVpbnRwdHJfdClwDQo+PiArCQkrIG51bSpzaXplb2Yoc3Ry
dWN0IHZyaW5nX2Rlc2MpKTsNCj4+ICsJdnItPnVzZWQgPSAoc3RydWN0IHZyaW5nX3VzZWQgKiko
KCh1aW50cHRyX3QpJnZyLT5hdmFpbC0+cmluZ1tudW1dDQo+PiArCQkrIHNpemVvZihfX3ZpcnRp
bzE2KSArIGFsaWduLTEpICYgfihhbGlnbiAtIDEpKTsNCj4+ICAgfQ0KPj4gICANCj4+ICAgc3Rh
dGljIGlubGluZSB1bnNpZ25lZCB2cmluZ19zaXplKHVuc2lnbmVkIGludCBudW0sIHVuc2lnbmVk
IGxvbmcgYWxpZ24pDQo+IA0KPiBJJ20gbm90IHJlYWxseSBpbnRlcmVzdGVkIGluIGJ1aWxkaW5n
IHdpdGggZysrLCBzb3JyeS4NCj4gQ2VudGFpbmx5IG5vdCBpZiBpdCBtYWtlcyBjb2RlIGxlc3Mg
cm9idXN0IGJ5IGZvcmNpbmcNCj4gY2FzdHMgd2hlcmUgdGhleSB3ZXJlbid0IHByZXZpb3VzbHkg
bmVjZXNzYXJ5Lg0KDQpDYW4geW91IGVsYWJvcmF0ZSBvbiBob3cgdGhlc2UgY2FzdHMgbWFrZSB0
aGUgY29kZSBsZXNzIHJvYnVzdD8NClRoZXkgYXJlbid0IG5lY2Vzc2FyeSBpbiBDIGJ1dCBJIHRo
aW5rIGJlaW5nIGV4cGxpY2l0IGNhbiBpbXByb3ZlDQpyZWFkYWJpbGl0eSBhcyBhcmd1ZWQgaW4N
Cmh0dHBzOi8vc29mdHdhcmVlbmdpbmVlcmluZy5zdGFja2V4Y2hhbmdlLmNvbS9hLzI3NTcxNA0K
DQo+IA0KPiBIb3dldmVyLCB2cmluZ19pbml0IGFuZCB2cmluZ19zaXplIGFyZSBsZWdhY3kgQVBJ
cyBhbnl3YXksDQo+IHNvIEknZCBiZSBoYXBweSB0byBhZGQgaWZuZGVmcyB0aGF0IHdpbGwgYWxs
b3cgdXNlcnNwYWNlDQo+IHNpbXBseSBoaWRlIHRoZXNlIGZ1bmN0aW9ucyBpZiBpdCBkb2VzIG5v
dCBuZWVkIHRoZW0uDQo+IA0KDQpJIGZlZWwgbGlrZSBteSBwYXRjaCBpcyBhIGhhcm1sZXNzIHdh
eSBvZiBhbGxvd2luZyB0aGlzIGhlYWRlcg0KdG8gYmUgdXNlZCBpbiBDKysgcHJvamVjdHMsIGJ1
dCBJJ20gaGFwcHkgdG8gZHJvcCBpdCBpbiBsaWV1IG9mDQp0aGUgZ3VhcmRzIGlmIHlvdSBmZWVs
IHN0cm9uZ2x5IGFib3V0IGl0Lg0KDQpUaGFua3MuDQpNYXRlag0KDQo+IA0KPj4gLS0gDQo+PiAy
LjIyLjANCj4+DQoNCg==
