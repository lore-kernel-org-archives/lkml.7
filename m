Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAB2C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C822617B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GRpnYPs/";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Z6ZAVcsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfE3Upj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:45:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44454 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbfE3Upi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:45:38 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UKhZYC023782;
        Thu, 30 May 2019 13:44:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=M4DTDdc5EtSB4MWLN5A8sLi/yej7GFaj8nbWz7b/auM=;
 b=GRpnYPs/1g+PYzzbk1vQDseihimBmXEU53A74arUFf+IVzUCF+ALMj/TbBjgkhRWIBGY
 DelsJDuIyTk7b0fmPboxXP3hoiInuV3muhcdW2R/jbb6LZseIDvD3E89DwNvuWPi7z27
 GApr6CfdnbY+zo/a5W+RfXMuZsNGjMOFz2E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2stj9w8xyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 May 2019 13:44:43 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 May 2019 13:44:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 May 2019 13:44:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4DTDdc5EtSB4MWLN5A8sLi/yej7GFaj8nbWz7b/auM=;
 b=Z6ZAVcsntHrkW61uhP/qykrLZEk8bKMAQGYQqccKQjmTiBue4oC+DXEPjmHOiFkBD70AHInFKN3p4UWXl1Ym55vcesbsMijSVrboBx2bZqb6gKtQcd7SYlFT8VwH6j081Faj3P9RC0+z3a3q/CvYNwoOktZoJ+LVaSKYVNpxGbA=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1829.namprd15.prod.outlook.com (10.172.76.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Thu, 30 May 2019 20:44:41 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f%3]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 20:44:41 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
Thread-Topic: [PATCH 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
Thread-Index: AQHVFm7e3AOrc7hTMUGa4T8fWo+OPKaC2pWAgAC0sQCAAIQbgP//m2kA
Date:   Thu, 30 May 2019 20:44:40 +0000
Message-ID: <5E506871-5361-47CD-9BE7-A0A9708F12A7@fb.com>
References: <20190529223511.4059120-1-vijaykhemka@fb.com>
 <20190529223511.4059120-2-vijaykhemka@fb.com>
 <0a94e784-41a0-4f2d-f9f8-6b365a1e755e@roeck-us.net>
 <27E78CF3-FAE7-4B6F-ABD7-77F4AE1CD633@fb.com>
 <20190530194441.GA12310@roeck-us.net>
In-Reply-To: <20190530194441.GA12310@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:3b87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23c31084-fcb5-47c8-f44d-08d6e53fa3b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1829;
x-ms-traffictypediagnostic: CY4PR15MB1829:
x-microsoft-antispam-prvs: <CY4PR15MB1829D1C39D3D1BD53E75B3F8DD180@CY4PR15MB1829.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(39860400002)(376002)(199004)(189003)(6436002)(68736007)(4326008)(14454004)(478600001)(53936002)(66476007)(6116002)(76116006)(91956017)(66556008)(64756008)(66446008)(36756003)(6246003)(6512007)(71200400001)(25786009)(256004)(33656002)(83716004)(71190400001)(66946007)(229853002)(73956011)(82746002)(54906003)(2616005)(2906002)(102836004)(486006)(446003)(316002)(99286004)(53546011)(6506007)(6486002)(186003)(6916009)(86362001)(7736002)(46003)(8936002)(8676002)(81156014)(81166006)(5660300002)(11346002)(476003)(305945005)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1829;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iVxs0LPqMQiTM8MSEl5DXPwWZpawhGa6C4Vj0xTr++JzQM0DTKGdkDPz+x20jFHaGrfWGBeg3i8kuH0vUoEcArGTfI19SWmQW/7VF9nY4gIJdOLr7zCNzdfpu9wPj97ZbseDxQwEsjl2gzGuPti9OR5zstbZMw74oOH77E6Zr6pQq84E2xMzNTLPXPumEqKE9iWMEkYVWXQawJq9nkXWxB51LC8q4oqhdXBm7Nj01JvVUXV4MKJZQ1JaPj875J9/Cotkql4FqQOm4XpzbC0iH92UI+rfBYZkgtJlG07ZdYK9Dj7/5oTC82xmZdmG0UVbSA4SdgdonK0egrDepb5ZqEd6DxemczJruNUYp5clzjuA8KIpqBu4X5PCqH9Cpv/rgtAOVIQfW4xISn7qlxgitViGHzMwDd8ejFOMwS5rYUs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C3731AD91F76A41B1E20FA5303C1E34@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c31084-fcb5-47c8-f44d-08d6e53fa3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 20:44:40.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vijaykhemka@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1829
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300147
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDUvMzAvMTksIDEyOjQ1IFBNLCAiR3VlbnRlciBSb2VjayIgPGdyb2VjazdAZ21h
aWwuY29tIG9uIGJlaGFsZiBvZiBsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOg0KDQogICAgT24g
VGh1LCBNYXkgMzAsIDIwMTkgYXQgMDY6NTE6NTJQTSArMDAwMCwgVmlqYXkgS2hlbWthIHdyb3Rl
Og0KICAgID4gDQogICAgPiANCiAgICA+IE9uIDUvMjkvMTksIDY6MDUgUE0sICJHdWVudGVyIFJv
ZWNrIiA8Z3JvZWNrN0BnbWFpbC5jb20gb24gYmVoYWxmIG9mIGxpbnV4QHJvZWNrLXVzLm5ldD4g
d3JvdGU6DQogICAgPiANCiAgICA+ICAgICBPbiA1LzI5LzE5IDM6MzUgUE0sIFZpamF5IEtoZW1r
YSB3cm90ZToNCiAgICA+ICAgICA+IEFkZGVkIHN1cHBvcnQgZm9yIEluZmVuaW9uIFBYRTE2MTAg
ZHJpdmVyDQogICAgPiAgICAgPiANCiAgICA+ICAgICA+IFNpZ25lZC1vZmYtYnk6IFZpamF5IEto
ZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0KICAgID4gICAgID4gLS0tDQogICAgPiAgICAgPiAg
IERvY3VtZW50YXRpb24vaHdtb24vcHhlMTYxMCB8IDg0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCiAgICA+ICAgICA+ICAgMSBmaWxlIGNoYW5nZWQsIDg0IGluc2VydGlv
bnMoKykNCiAgICA+ICAgICA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vaHdt
b24vcHhlMTYxMA0KICAgID4gICAgID4gDQogICAgPiAgICAgPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9od21vbi9weGUxNjEwIGIvRG9jdW1lbnRhdGlvbi9od21vbi9weGUxNjEwDQogICAg
PiAgICAgPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KICAgID4gICAgID4gaW5kZXggMDAwMDAwMDAw
MDAwLi5iNWM4M2VkZjAyN2ENCiAgICA+ICAgICA+IC0tLSAvZGV2L251bGwNCiAgICA+ICAgICA+
ICsrKyBiL0RvY3VtZW50YXRpb24vaHdtb24vcHhlMTYxMA0KICAgID4gICAgID4gQEAgLTAsMCAr
MSw4NCBAQA0KICAgID4gICAgID4gK0tlcm5lbCBkcml2ZXIgcHhlMTYxMA0KICAgID4gICAgID4g
Kz09PT09PT09PT09PT09PT09PT09PQ0KICAgID4gICAgID4gKw0KICAgID4gICAgID4gK1N1cHBv
cnRlZCBjaGlwczoNCiAgICA+ICAgICA+ICsgICogSW5maW5pb24gUFhFMTYxMA0KICAgID4gICAg
ID4gKyAgICBQcmVmaXg6ICdweGUxNjEwJw0KICAgID4gICAgID4gKyAgICBBZGRyZXNzZXMgc2Nh
bm5lZDogLQ0KICAgID4gICAgID4gKyAgICBEYXRhc2hlZXQ6IERhdGFzaGVldCBpcyBub3QgcHVi
bGljbHkgYXZhaWxhYmxlLg0KICAgID4gICAgID4gKw0KICAgID4gICAgID4gKyAgKiBJbmZpbmlv
biBQWEUxMTEwDQogICAgPiAgICAgPiArICAgIFByZWZpeDogJ3B4ZTExMTAnDQogICAgPiAgICAg
PiArICAgIEFkZHJlc3NlcyBzY2FubmVkOiAtDQogICAgPiAgICAgPiArICAgIERhdGFzaGVldDog
RGF0YXNoZWV0IGlzIG5vdCBwdWJsaWNseSBhdmFpbGFibGUuDQogICAgPiAgICAgPiArDQogICAg
PiAgICAgPiArICAqIEluZmluaW9uIFBYTTEzMTANCiAgICA+ICAgICA+ICsgICAgUHJlZml4OiAn
cHhtMTMxMCcNCiAgICA+ICAgICA+ICsgICAgQWRkcmVzc2VzIHNjYW5uZWQ6IC0NCiAgICA+ICAg
ICA+ICsgICAgRGF0YXNoZWV0OiBEYXRhc2hlZXQgaXMgbm90IHB1YmxpY2x5IGF2YWlsYWJsZS4N
CiAgICA+ICAgICA+ICsNCiAgICA+ICAgICA+ICtBdXRob3I6IFZpamF5IEtoZW1rYSA8dmlqYXlr
aGVta2FAZmIuY29tPg0KICAgID4gICAgID4gKw0KICAgID4gICAgID4gKw0KICAgID4gICAgID4g
K0Rlc2NyaXB0aW9uDQogICAgPiAgICAgPiArLS0tLS0tLS0tLS0NCiAgICA+ICAgICA+ICsNCiAg
ICA+ICAgICA+ICtQWEUxNjEwIGlzIGEgTXVsdGktcmFpbC9NdWx0aXBoYXNlIERpZ2l0YWwgQ29u
dHJvbGxlcnMgYW5kDQogICAgPiAgICAgPiAraXQgaXMgY29tcGxpYW50IHRvIEludGVsIFZSMTMg
REMtREMgY29udmVydGVyIHNwZWNpZmljYXRpb25zLg0KICAgID4gICAgID4gKw0KICAgID4gICAg
IA0KICAgID4gICAgIEFuZCB0aGUgb3RoZXJzID8NCiAgICA+IFRoaXMgc3VwcG9ydHMgVlIxMiBh
cyB3ZWxsIGFuZCBJIGRvbid0IHNlZSB0aGlzIGNvbnRyb2xsZXIgc3VwcG9ydHMgYW55IG90aGVy
IFZSIHZlcnNpb25zLg0KICAgID4gICAgIA0KICAgIFRoZSBwb2ludCBoZXJlIGlzIHRoYXQgdGhl
cmUgaXMgbm8gZGVzY3JpcHRpb24gb2YgdGhlIG90aGVyIGNvbnRyb2xsZXJzLg0KT2ssIEkgZ2V0
IGl0LCBtYWlubHkgYWxsIDMgY29udHJvbGxlcnMgYXJlIGZyb20gc2FtZSBmYW1pbHkgb2YgSW5m
aW5lb24gY29udHJvbGxlciBidXQgSSB3aWxsIGFkZCBkZXRhaWxzIGhlcmUuDQogICAgDQogICAg
PiAgICAgPiArDQogICAgPiAgICAgPiArVXNhZ2UgTm90ZXMNCiAgICA+ICAgICA+ICstLS0tLS0t
LS0tLQ0KICAgID4gICAgID4gKw0KICAgID4gICAgID4gK1RoaXMgZHJpdmVyIGNhbiBiZSBlbmFi
bGVkIHdpdGgga2VybmVsIGNvbmZpZyBDT05GSUdfU0VOU09SU19QWEUxNjEwDQogICAgPiAgICAg
PiArc2V0IHRvICd5JyBvciAnbScoZm9yIG1vZHVsZSkuDQogICAgPiAgICAgPiArDQogICAgPiAg
ICAgVGhlIGFib3ZlIGRvZXMgbm90IHJlYWxseSBhZGQgdmFsdWUuDQogICAgPiBPaywgSSB3aWxs
IHJlbW92ZSBpdC4NCiAgICA+ICAgICANCiAgICA+ICAgICA+ICtUaGlzIGRyaXZlciBkb2VzIG5v
dCBwcm9iZSBmb3IgUE1CdXMgZGV2aWNlcy4gWW91IHdpbGwgaGF2ZQ0KICAgID4gICAgID4gK3Rv
IGluc3RhbnRpYXRlIGRldmljZXMgZXhwbGljaXRseS4NCiAgICA+ICAgICA+ICsNCiAgICA+ICAg
ICA+ICtFeGFtcGxlOiB0aGUgZm9sbG93aW5nIGNvbW1hbmRzIHdpbGwgbG9hZCB0aGUgZHJpdmVy
IGZvciBhbiBQWEUxNjEwDQogICAgPiAgICAgPiArYXQgYWRkcmVzcyAweDcwIG9uIEkyQyBidXMg
IzQ6DQogICAgPiAgICAgPiArDQogICAgPiAgICAgPiArIyBtb2Rwcm9iZSBweGUxNjEwDQogICAg
PiAgICAgPiArIyBlY2hvIHB4ZTE2MTAgMHg3MCA+IC9zeXMvYnVzL2kyYy9kZXZpY2VzL2kyYy00
L25ld19kZXZpY2UNCiAgICA+ICAgICA+ICsNCiAgICA+ICAgICA+ICtJdCBjYW4gYWxzbyBiZSBp
bnN0YW50aWF0ZWQgYnkgZGVjbGFyaW5nIGluIGRldmljZSB0cmVlIGlmIGl0IGlzDQogICAgPiAg
ICAgPiArYnVpbHQgYXMgYSBrZXJuZWwgbm90IGFzIGEgbW9kdWxlLg0KICAgID4gICAgID4gKw0K
ICAgID4gICAgIA0KICAgID4gICAgIEkgYXNzdW1lIHlvdSBtZWFuICJidWlsdCBpbnRvIHRoZSBr
ZXJuZWwiLg0KICAgID4gICAgIFdoeSB3b3VsZCBkZXZpY2V0cmVlIGJhc2VkIGluc3RhbnRpYXRp
b24gbm90IHdvcmsgaWYgdGhlIGRyaXZlciBpcyBidWlsdA0KICAgID4gICAgIGFzIG1vZHVsZSA/
DQogICAgPiBXaWxsIGNvcnJlY3Qgc3RhdGVtZW50IGhlcmUuDQogICAgPiAgICAgDQogICAgPiAg
ICAgPiArDQogICAgPiAgICAgPiArU3lzZnMgYXR0cmlidXRlcw0KICAgID4gICAgID4gKy0tLS0t
LS0tLS0tLS0tLS0NCiAgICA+ICAgICA+ICsNCiAgICA+ICAgICA+ICtjdXJyMV9sYWJlbAkJImlp
biINCiAgICA+ICAgICA+ICtjdXJyMV9pbnB1dAkJTWVhc3VyZWQgaW5wdXQgY3VycmVudA0KICAg
ID4gICAgID4gK2N1cnIxX2FsYXJtCQlDdXJyZW50IGhpZ2ggYWxhcm0NCiAgICA+ICAgICA+ICsN
CiAgICA+ICAgICA+ICtjdXJyWzItNF1fbGFiZWwJCSJpb3V0WzEtM10iDQogICAgPiAgICAgPiAr
Y3VyclsyLTRdX2lucHV0CQlNZWFzdXJlZCBvdXRwdXQgY3VycmVudA0KICAgID4gICAgID4gK2N1
cnJbMi00XV9jcml0CQlDcml0aWNhbCBtYXhpbXVtIGN1cnJlbnQNCiAgICA+ICAgICA+ICtjdXJy
WzItNF1fY3JpdF9hbGFybQlDdXJyZW50IGNyaXRpY2FsIGhpZ2ggYWxhcm0NCiAgICA+ICAgICA+
ICsNCiAgICA+ICAgICA+ICtpbjFfbGFiZWwJCSJ2aW4iDQogICAgPiAgICAgPiAraW4xX2lucHV0
CQlNZWFzdXJlZCBpbnB1dCB2b2x0YWdlDQogICAgPiAgICAgPiAraW4xX2NyaXQJCUNyaXRpY2Fs
IG1heGltdW0gaW5wdXQgdm9sdGFnZQ0KICAgID4gICAgID4gK2luMV9jcml0X2FsYXJtCQlJbnB1
dCB2b2x0YWdlIGNyaXRpY2FsIGhpZ2ggYWxhcm0NCiAgICA+ICAgICA+ICsNCiAgICA+ICAgICA+
ICtpblsyLTRdX2xhYmVsCQkidm91dFsxLTNdIg0KICAgID4gICAgID4gK2luWzItNF1faW5wdXQJ
CU1lYXN1cmVkIG91dHB1dCB2b2x0YWdlDQogICAgPiAgICAgPiAraW5bMi00XV9sY3JpdAkJQ3Jp
dGljYWwgbWluaW11bSBvdXRwdXQgdm9sdGFnZQ0KICAgID4gICAgID4gK2luWzItNF1fbGNyaXRf
YWxhcm0JT3V0cHV0IHZvbHRhZ2UgY3JpdGljYWwgbG93IGFsYXJtDQogICAgPiAgICAgPiAraW5b
Mi00XV9jcml0CQlDcml0aWNhbCBtYXhpbXVtIG91dHB1dCB2b2x0YWdlDQogICAgPiAgICAgPiAr
aW5bMi00XV9jcml0X2FsYXJtCU91dHB1dCB2b2x0YWdlIGNyaXRpY2FsIGhpZ2ggYWxhcm0NCiAg
ICA+ICAgICA+ICsNCiAgICA+ICAgICA+ICtwb3dlcjFfbGFiZWwJCSJwaW4iDQogICAgPiAgICAg
PiArcG93ZXIxX2lucHV0CQlNZWFzdXJlZCBpbnB1dCBwb3dlcg0KICAgID4gICAgID4gK3Bvd2Vy
MV9hbGFybQkJSW5wdXQgcG93ZXIgaGlnaCBhbGFybQ0KICAgID4gICAgID4gKw0KICAgID4gICAg
ID4gK3Bvd2VyWzItNF1fbGFiZWwJInBvdXRbMS0zXSINCiAgICA+ICAgICA+ICtwb3dlclsyLTRd
X2lucHV0CU1lYXN1cmVkIG91dHB1dCBwb3dlcg0KICAgID4gICAgID4gKw0KICAgID4gICAgID4g
K3RlbXBbMS0zXV9pbnB1dAkJTWVhc3VyZWQgdGVtcGVyYXR1cmUNCiAgICA+ICAgICA+ICt0ZW1w
WzEtM11fY3JpdAkJQ3JpdGljYWwgaGlnaCB0ZW1wZXJhdHVyZQ0KICAgID4gICAgID4gK3RlbXBb
MS0zXV9jcml0X2FsYXJtCUNoaXAgdGVtcGVyYXR1cmUgY3JpdGljYWwgaGlnaCBhbGFybQ0KICAg
ID4gICAgID4gK3RlbXBbMS0zXV9tYXgJCU1heGltdW0gdGVtcGVyYXR1cmUNCiAgICA+ICAgICA+
ICt0ZW1wWzEtM11fbWF4X2FsYXJtCUNoaXAgdGVtcGVyYXR1cmUgaGlnaCBhbGFybQ0KICAgID4g
ICAgID4gDQogICAgPiAgICAgDQogICAgPiAgICAgDQogICAgPiANCiAgICANCg0K
