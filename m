Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3FFC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24E320643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jjr/kue+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HN240HUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfDVWil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:38:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59362 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729838AbfDVWik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:38:40 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3MMRNUu006296;
        Mon, 22 Apr 2019 15:38:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=l3VZ0rAvVv+TjUhzlizMrdD0BznEMRlbskYlDNXCKWw=;
 b=jjr/kue+wdDIf/uZ8W0tz/vXMy2jVRttLzbD+dznv+0yKJBK2Nr9pQS7yC1ANBuVfrFj
 r2FsLCjEADkzz3Y3ZtIZGY3BAE6WBOEeIc44/XWZxhV7mga22+ygp0YUYRUEzGrB1sAI
 v2oA3ow4epa7YkjPbqvYXK1NVP3xfIuJBWE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2s1p0f84nc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 15:38:19 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 15:38:17 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 15:38:17 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 15:38:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3VZ0rAvVv+TjUhzlizMrdD0BznEMRlbskYlDNXCKWw=;
 b=HN240HUNkpVB2mi+QYjZhkbYZEucGnXvX7Qz81mGYLOxLNkdvlqfRSlsloP8R5Q5e6bnFbXOs3X7wy863psQeyjRfuBDvAJ+nYpFXV3sC7Ko7PkfEpzILPL3tL5AfoKrGIYjo74YSPSYSwLmd7oocteGLHnCsOnv4rvto5GOZoQ=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1646.namprd15.prod.outlook.com (10.175.138.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 22:38:16 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd%10]) with mapi id 15.20.1813.017; Mon, 22 Apr
 2019 22:38:16 +0000
From:   Tao Ren <taoren@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net] net/ncsi: handle overflow when incrementing mac
 address
Thread-Topic: [PATCH net] net/ncsi: handle overflow when incrementing mac
 address
Thread-Index: AQHU+TC+3KsFoZNhvUS0KeGMn6cpeKZIuZqAgAAMJ4A=
Date:   Mon, 22 Apr 2019 22:38:16 +0000
Message-ID: <5c0d2412-9612-9933-28c7-6622b0981d1e@fb.com>
References: <20190422172754.1011894-1-taoren@fb.com>
 <20190422145443.6391eaf8@cakuba.netronome.com>
In-Reply-To: <20190422145443.6391eaf8@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:23::18)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:36a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bad9bb80-549b-4e61-7551-08d6c77335d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1646;
x-ms-traffictypediagnostic: MWHPR15MB1646:
x-microsoft-antispam-prvs: <MWHPR15MB16462DAA3CB3BDD22823B32BB2220@MWHPR15MB1646.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(51914003)(64756008)(66556008)(66476007)(66446008)(6506007)(386003)(66946007)(102836004)(86362001)(25786009)(68736007)(53546011)(46003)(8676002)(7736002)(2906002)(97736004)(6116002)(65956001)(31696002)(76176011)(4326008)(305945005)(5660300002)(73956011)(65806001)(476003)(486006)(2616005)(186003)(6246003)(256004)(14444005)(446003)(11346002)(36756003)(316002)(58126008)(64126003)(6436002)(6512007)(6486002)(14454004)(53936002)(71190400001)(8936002)(81166006)(81156014)(6916009)(229853002)(54906003)(52116002)(99286004)(65826007)(31686004)(71200400001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1646;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bMxeT4wKEn9dYHkXj6a33ZHpPVPQaWMnmQ/11Tmud22aRQlLm4jXjpZzNPmQSgD9FqQGY2yT46U7p2onBbq4TsYrlmZSgCbaWUgQXfOV8vzF/fCkGwFN80WLPy5UWL8iUAHfsiXetDm6Nyah4EohsO4uIJ96DDUyTSjvihVnagEI2NvJHjKHLsrrKicO8jPnLjv99Eb2jml1mZCzteLer3cTagWQboJdK0UEOiJ9UnfO/dfc+iPq6wjhb+BE55z+RcxOviMBcsTFud29b7cbGXCbfpytfkKceY2X+1ceZi7vvHUNQUGd8ZkeYUe6+Va5K/tgNngSj4WtwRB42woDI8HHXpnN/lH+f/8iJc7uoJrnuuZQe7n2i/Ip2Itsx7NOVtQY398fAYqqnRH+af/loUuRuSGlp2Mm/mNp+OGR47M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <112FE897A616FF49A81218B3E058D0C1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bad9bb80-549b-4e61-7551-08d6c77335d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 22:38:16.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1646
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yMi8xOSAyOjU0IFBNLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gT24gTW9uLCAyMiBB
cHIgMjAxOSAxMDoyNzo1NCAtMDcwMCwgVGFvIFJlbiB3cm90ZToNCj4+IFByZXZpb3VzbHkgQk1D
J3MgTUFDIGFkZHJlc3MgaXMgY2FsY3VsYXRlZCBieSBzaW1wbHkgYWRkaW5nIDEgdG8gdGhlDQo+
PiBsYXN0IGJ5dGUgb2YgbmV0d29yayBjb250cm9sbGVyJ3MgTUFDIGFkZHJlc3MsIGFuZCBpdCBw
cm9kdWNlcyBpbmNvcnJlY3QNCj4+IHJlc3VsdCB3aGVuIG5ldHdvcmsgY29udHJvbGxlcidzIE1B
QyBhZGRyZXNzIGVuZHMgd2l0aCAweEZGLg0KPj4gVGhlIHByb2JsZW0gaXMgZml4ZWQgYnkgZGV0
ZWN0aW5nIGludGVnZXIgb3ZlcmZsb3cgd2hlbiBpbmNyZW1lbnRpbmcgTUFDDQo+PiBhZGRyZXNz
IGFuZCBhZGRpbmcgdGhlIGNhcnJ5IGJpdCAoaWYgYW55KSB0byB0aGUgbmV4dC9sZWZ0IGJ5dGVz
IG9mIHRoZQ0KPj4gTUFDIGFkZHJlc3MuDQo+Pg0KPiANCj4gSXQnZCBiZSBnb29kIHRvIGhhdmUg
YSBGaXhlcyB0YWcsIGlmIGl0J3Mgd29ydGggZ29pbmcgdG8gdGhlIG5ldCB0cmVlLg0KDQpUaGFu
ayB5b3UgZm9yIHRoZSBxdWljayByZXZpZXcgSmFrdWIuIFN1cmUsIEkgd2lsbCB1cGRhdGUgdGhl
IHBhdGNoIGRlc2NyaXB0aW9uIHdpdGggRml4ZXMgdGFnIGFjY29yZGluZ2x5Lg0KDQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBUYW8gUmVuIDx0YW9yZW5AZmIuY29tPg0KPj4gLS0tDQo+PiAgbmV0L25jc2kv
bmNzaS1yc3AuYyB8IDEwICsrKysrKysrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9uZXQvbmNzaS9uY3Np
LXJzcC5jIGIvbmV0L25jc2kvbmNzaS1yc3AuYw0KPj4gaW5kZXggZGMwN2ZjYzc5MzhlLi5lYjQy
YmJkYjc1MDEgMTAwNjQ0DQo+PiAtLS0gYS9uZXQvbmNzaS9uY3NpLXJzcC5jDQo+PiArKysgYi9u
ZXQvbmNzaS9uY3NpLXJzcC5jDQo+PiBAQCAtNjU4LDcgKzY1OCw4IEBAIHN0YXRpYyBpbnQgbmNz
aV9yc3BfaGFuZGxlcl9vZW1fYmNtX2dtYShzdHJ1Y3QgbmNzaV9yZXF1ZXN0ICpucikNCj4+ICAJ
Y29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzICpvcHMgPSBuZGV2LT5uZXRkZXZfb3BzOw0KPj4g
IAlzdHJ1Y3QgbmNzaV9yc3Bfb2VtX3BrdCAqcnNwOw0KPj4gIAlzdHJ1Y3Qgc29ja2FkZHIgc2Fk
ZHI7DQo+PiAtCWludCByZXQgPSAwOw0KPj4gKwlpbnQgcmV0LCBvZmZzZXQ7DQo+PiArCXUxNiBj
YXJyeSA9IDE7DQo+PiAgDQo+PiAgCS8qIEdldCB0aGUgcmVzcG9uc2UgaGVhZGVyICovDQo+PiAg
CXJzcCA9IChzdHJ1Y3QgbmNzaV9yc3Bfb2VtX3BrdCAqKXNrYl9uZXR3b3JrX2hlYWRlcihuci0+
cnNwKTsNCj4+IEBAIC02NjcsNyArNjY4LDEyIEBAIHN0YXRpYyBpbnQgbmNzaV9yc3BfaGFuZGxl
cl9vZW1fYmNtX2dtYShzdHJ1Y3QgbmNzaV9yZXF1ZXN0ICpucikNCj4+ICAJbmRldi0+cHJpdl9m
bGFncyB8PSBJRkZfTElWRV9BRERSX0NIQU5HRTsNCj4+ICAJbWVtY3B5KHNhZGRyLnNhX2RhdGEs
ICZyc3AtPmRhdGFbQkNNX01BQ19BRERSX09GRlNFVF0sIEVUSF9BTEVOKTsNCj4+ICAJLyogSW5j
cmVhc2UgbWFjIGFkZHJlc3MgYnkgMSBmb3IgQk1DJ3MgYWRkcmVzcyAqLw0KPj4gLQlzYWRkci5z
YV9kYXRhW0VUSF9BTEVOIC0gMV0rKzsNCj4+ICsJb2Zmc2V0ID0gRVRIX0FMRU4gLSAxOw0KPj4g
KwlkbyB7DQo+PiArCQljYXJyeSArPSAodTgpc2FkZHIuc2FfZGF0YVtvZmZzZXRdOw0KPj4gKwkJ
c2FkZHIuc2FfZGF0YVtvZmZzZXRdID0gKGNoYXIpY2Fycnk7DQo+PiArCQljYXJyeSA9IGNhcnJ5
ID4+IDg7DQo+PiArCX0gd2hpbGUgKGNhcnJ5ICE9IDAgJiYgLS1vZmZzZXQgPj0gMCk7DQo+IA0K
PiBXZSBoYXZlIGV0aF9hZGRyX2RlYygpLCBwZXJoYXBzIGl0J2QgYmUgZ29vZCB0byBhZGQgYW4g
ZXRoX2FkZHJfaW5jKCkNCj4gZXF1aXZhbGVudD8gIChJJ20gbm90IHN1cmUgaWYgaXQnZCBoYXZl
IHRvIGJlIGluIG5ldC1uZXh0LCBpdCdzIGEgdGlueQ0KPiBmdW5jdGlvbiwgYW5kIE9LIGZvciBu
ZXQgZm9yIG15IHRhc3RlLCBidXQgSSBoYWQgYmVlbiB3cm9uZyBiZWZvcmUpLg0KDQpNYWtlIHNl
bnNlLiBJIHdpbGwgc3BsaXQgdGhlIHBhdGNoIHRvIDIgdGhlbjogMSkgYWRkIGV0aF9hZGRyX2lu
YygpIGludG8gbGludXgvZXRoZXJkZXZpY2UuaCAyKSBmaXhlcyBvdmVyZmxvdyB3aGVuIGluY3Jl
bWVudGluZyBtYWMgYWRkcmVzcyBieSBjYWxsaW5nIGV0aF9hZGRyX2luYygpIGZ1bmN0aW9uLg0K
DQo+IElmIEknbSBhbGxvd2VkIHRvIGJlIHBhcmFub2lkIEknZCBhbHNvIGFkdmlzZSBjaGVja2lu
ZyB0aGUgcmVzdWx0aW5nDQo+IE1BQyBpcyBhIHZhbGlkIGV0aGVybmV0IHVuaWNhc3QgYWRkci4N
Cj4gDQo+PiAgCXJldCA9IG9wcy0+bmRvX3NldF9tYWNfYWRkcmVzcyhuZGV2LCAmc2FkZHIpOw0K
Pj4gIAlpZiAocmV0IDwgMCkNCj4+ICAJCW5ldGRldl93YXJuKG5kZXYsICJOQ1NJOiAnV3JpdGlu
ZyBtYWMgYWRkcmVzcyB0byBkZXZpY2UgZmFpbGVkXG4iKTsNCg0KVGhhbmtzIGZvciB0aGUgc3Vn
Z2VzdGlvbi4gV2lsbCBhZGQgdGhlIGNoZWNrLg0KDQotIFRhbw0K
