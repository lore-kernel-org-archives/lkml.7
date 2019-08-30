Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E459C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CFE23405
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Bb+INQh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfH3RiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:38:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:20944 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727888AbfH3RiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:38:15 -0400
X-Greylist: delayed 679 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2019 13:38:14 EDT
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7UHP3qT029501;
        Fri, 30 Aug 2019 10:26:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=qoaOUv7QkNWJF+1OoNMctCK3JMA4sWtLp52UExdemGc=;
 b=Bb+INQh7aWGIXPKFaqYcSXbcAywOIAWHh684ko4G2Y4l57w9ZDNJ4QiiNOSLbyr6wSZX
 elJ5BMSqiBGQKY4+IvfE3ORKaGPRHh1D+SMzBXjMLHn9Zhw6giZpI4dtX7mgo5427NmZ
 wzm1UMScO5CBQhZGPmemppo8KkkhzVwRhBAnbGVDcsg2p4QnW7kHb2bIuVhTsQZnZHZU
 S9xA8AbT6HFobZ9nK2g0rNnlL5M5EvUmH+66VrkRuip9arbgtjCvprWLrUItY3is0aAC
 g0C7MxDmWpNbSuoL12G25bpkTe0TBZHDMiHk3qeqzRXISTpNlYULdoiJbkylsnhRQ1JQ mQ== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2058.outbound.protection.outlook.com [104.47.34.58])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2uk4jen495-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 10:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB7ZxrZjsD7BMWttIjvvOW6ENBYnVo9pdyLngjbUIOu+rrUoJ79VzUwv5YATJUyKLqP/oPrkuH7ZabT9Pjys1vZvdqgpZ2ZGkouxMHrpae9DgPFEc9XBqnzaQkaEIZKrkGizLyWwjl7JrT4c5mZ+Xx8o3zuqR+/fIzHkhuDmLFtQpzZdMjaP49+DCS4nuf+wAVa/AuvH1wXyK7oywe1m4P0nIsk2yQaK4MzXkkQ2fHwViAUyeiOlhdpDxdAHjG/tEhtgqdMQL6wdoV60pMNH3CnmGg9MkOo/eTBONgPQi03HbNdRYk1fncoW/hk8GukYsOdnQdV03tqq+31exZNtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoaOUv7QkNWJF+1OoNMctCK3JMA4sWtLp52UExdemGc=;
 b=G0W6SIlJh8jnaulp7dh8bo1snEVp1QyJy6uHcwxc4bMgrIwuMlPUKZUAQnDBBnDn+g2VQk42AHv/jZg0ZQ1s1qCKE2jZp6AVRcvKJZjMeJrcpc+I3lKICqy1WaAmLayNPSispy6RNQXWBtljyG5VtQAIDUZ2vof8SjeDByGhGIEW13uGExAX768qte1EABuyrzdRPPt41Enn8zU81IEEOqfesu0SuciqwiF+H44v61RP9LS/lDtniyFJTEJr2tyukYml53bYmwynzanzYeLSXlXzUs43gftfzaw3RuhMAUi9i4t+q7y/QTdIaPjuBtm4zdSe/SLYF9uGwST5TVFGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB3634.namprd02.prod.outlook.com (52.132.27.154) by
 BL0PR02MB3860.namprd02.prod.outlook.com (52.132.9.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 17:26:47 +0000
Received: from BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::c9b1:7869:4f3f:713f]) by BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::c9b1:7869:4f3f:713f%6]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 17:26:47 +0000
From:   Matej Genci <matej.genci@nutanix.com>
To:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: Change typecasts in vring_init()
Thread-Topic: [PATCH] virtio: Change typecasts in vring_init()
Thread-Index: AQHVXOsGnWphIXIpHkCP5ncx23ivmacTEcCAgADknAA=
Date:   Fri, 30 Aug 2019 17:26:47 +0000
Message-ID: <25df690f-0f0c-baf9-2a8f-392e46468b42@nutanix.com>
References: <20190827152000.53920-1-matej.genci@nutanix.com>
 <e6aa7fa1-8f41-fc55-51b2-5f0052cfb2d0@redhat.com>
In-Reply-To: <e6aa7fa1-8f41-fc55-51b2-5f0052cfb2d0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45287d94-2d6e-4f5d-fcd2-08d72d6f3c52
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR02MB3860;
x-ms-traffictypediagnostic: BL0PR02MB3860:
x-microsoft-antispam-prvs: <BL0PR02MB386020FCDC187019B475DD49FBBD0@BL0PR02MB3860.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(229853002)(86362001)(5660300002)(446003)(53936002)(186003)(26005)(305945005)(7736002)(53546011)(6506007)(71200400001)(71190400001)(102836004)(2201001)(110136005)(256004)(76176011)(14454004)(6512007)(316002)(11346002)(81166006)(508600001)(44832011)(2616005)(81156014)(6246003)(476003)(31696002)(486006)(6486002)(8676002)(6436002)(66556008)(66476007)(76116006)(66446008)(91956017)(36756003)(25786009)(3846002)(6116002)(99286004)(8936002)(2906002)(31686004)(2501003)(66066001)(66946007)(64756008)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB3860;H:BL0PR02MB3634.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IA8T7vb6LSVzNbmWRR8UkdUTcQymCn2h0drdsqT1G7RgL78vGOBQIOhJCw3Vg0rRVB06VVpdevjN550IrYgL/v7vClzsbgvCeu07o5Z5SauaNU3XuReMdEnsDZj5VE9Z3y+uFPS6o5bWnrE38208iCTadT8HtyUr2rkg3mCXLKH8IZFh0QRh4BzyDTBjHj505Uc1c5g/k5QV5ULnGuqng9/MuZvb/G8x/UaLCG/xcab9E6cZZI7JCD2Soi0iBckFJgYb73DB4ik4rJRn1soTGH/g71TBlw2RCEPyOFgAUMAruqpID4DZr2v7G2rVtnZmOUAwOkxtSUp8Ans8i3DBAzlIowPfMuGzZ7rsPEePy6p/NLZb1Yg5gqvnuoSS/idZEd0iH6IcU0/tvQ9wapUe6xBhSpeCl4XuDMcigqTpBYw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DACFA90AD637948B9C522C208AF3E22@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45287d94-2d6e-4f5d-fcd2-08d72d6f3c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 17:26:47.1206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SP9serV2JrGi5v2qa7xsFU8pQDm/fErNp2FqgCy3zi2VVAOCBS5yXJ9w+8z7pCANjruMH6hVYWhQ8c6udpcWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3860
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-30_06:2019-08-29,2019-08-30 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8zMC8yMDE5IDQ6NDggQU0sIEphc29uIFdhbmcgd3JvdGU6DQo+IA0KPiBPbiAyMDE5Lzgv
Mjcg5LiL5Y2IMTE6MjAsIE1hdGVqIEdlbmNpIHdyb3RlOg0KPj4gQ29tcGlsZXJzIHN1Y2ggYXMg
ZysrIDcuMyBjb21wbGFpbiBhYm91dCBhc3NpZ25pbmcgdm9pZCogdmFyaWFibGUgdG8NCj4+IGEg
bm9uLXZvaWQqIHZhcmlhYmxlIChsaWtlIHN0cnVjdCBwb2ludGVycykgYW5kIHBvaW50ZXIgYXJp
dGhtZXRpY3MNCj4+IG9uIHZvaWQqLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hdGVqIEdlbmNp
IDxtYXRlai5nZW5jaUBudXRhbml4LmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX3JpbmcuaCB8IDkgKysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC92aXJ0aW9fcmluZy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5n
LmgNCj4+IGluZGV4IDRjNGUyNGMyOTFhNS4uMmMzMzliOWUyOTIzIDEwMDY0NA0KPj4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmgNCj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9s
aW51eC92aXJ0aW9fcmluZy5oDQo+PiBAQCAtMTY4LDEwICsxNjgsMTEgQEAgc3RhdGljIGlubGlu
ZSB2b2lkIHZyaW5nX2luaXQoc3RydWN0IHZyaW5nICp2ciwgdW5zaWduZWQgaW50IG51bSwgdm9p
ZCAqcCwNCj4+ICAgCQkJICAgICAgdW5zaWduZWQgbG9uZyBhbGlnbikNCj4+ICAgew0KPj4gICAJ
dnItPm51bSA9IG51bTsNCj4+IC0JdnItPmRlc2MgPSBwOw0KPj4gLQl2ci0+YXZhaWwgPSBwICsg
bnVtKnNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzYyk7DQo+PiAtCXZyLT51c2VkID0gKHZvaWQgKiko
KCh1aW50cHRyX3QpJnZyLT5hdmFpbC0+cmluZ1tudW1dICsgc2l6ZW9mKF9fdmlydGlvMTYpDQo+
PiAtCQkrIGFsaWduLTEpICYgfihhbGlnbiAtIDEpKTsNCj4+ICsJdnItPmRlc2MgPSAoc3RydWN0
IHZyaW5nX2Rlc2MgKilwOw0KPj4gKwl2ci0+YXZhaWwgPSAoc3RydWN0IHZyaW5nX2F2YWlsICop
KCh1aW50cHRyX3QpcA0KPj4gKwkJKyBudW0qc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjKSk7DQo+
IA0KPiANCj4gSXQncyBiZXR0ZXIgdG8gbGV0IHRoZSBjb2RlIHBhc3MgY2hlY2twYXRoLnBsIGhl
cmUuDQo+IA0KSXQgcGFzc2VzIGZvciBtZQ0KDQotLS0tLS0tLTg8LS0tLS0tLS0NCi4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIDAwMDEtdmlydGlvLUNoYW5nZS10eXBlY2FzdHMtaW4tdnJpbmdfaW5p
dC5wYXRjaA0KdG90YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNSBsaW5lcyBjaGVja2VkDQoN
CjAwMDEtdmlydGlvLUNoYW5nZS10eXBlY2FzdHMtaW4tdnJpbmdfaW5pdC5wYXRjaCBoYXMgbm8g
b2J2aW91cyBzdHlsZSBwcm9ibGVtcyBhbmQgaXMgcmVhZHkgZm9yIHN1Ym1pc3Npb24uDQotLS0t
LS0tLTg8LS0tLS0tLS0NCg0KSXMgdGhlcmUgc29tZXRoaW5nIEknbSBtaXNzaW5nPw0KDQo+IE90
aGVyIGxvb2tzIGdvb2QuDQo+IA0KPiBUaGFua3MNCj4gDQo+IA0KPj4gKwl2ci0+dXNlZCA9IChz
dHJ1Y3QgdnJpbmdfdXNlZCAqKSgoKHVpbnRwdHJfdCkmdnItPmF2YWlsLT5yaW5nW251bV0NCj4+
ICsJCSsgc2l6ZW9mKF9fdmlydGlvMTYpICsgYWxpZ24tMSkgJiB+KGFsaWduIC0gMSkpOw0KPj4g
ICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIHZyaW5nX3NpemUodW5zaWdu
ZWQgaW50IG51bSwgdW5zaWduZWQgbG9uZyBhbGlnbikNCg0K
