Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE4CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C970524ABF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DPYTALj8";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="D/KxKyX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE3Sw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:52:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42064 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbfE3Sw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:52:28 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UIgqWN014213;
        Thu, 30 May 2019 11:51:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4lwpY0UpCkg4dF4t8bE6bT2nMZnLuatgYxY/VL5Q5NQ=;
 b=DPYTALj8/XqhbNSnYwVCbCPC65eGehOL7/B1T/v3VEEdsMS3TFbvbdyjQ5p8hyIWWwfr
 IwX903kQX/9ACyO858Q0zopzQWpGpNNukpDzKxf/0DhoR7lhZ6EiABFSqhub2oyQx/qR
 zJtyfxidJxFI9XI4nv/95ER2QdZu5xKxDGM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2stj9w8kym-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 11:51:55 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 30 May 2019 11:51:54 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 30 May 2019 11:51:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lwpY0UpCkg4dF4t8bE6bT2nMZnLuatgYxY/VL5Q5NQ=;
 b=D/KxKyX3ndrnAZMvJANHH/eZqtT7GMdarg1gu6ZtwsSP6OtuBcaYCl3HAq8HbfL2HtJGXzv8ewyo40rtNHlPFQcwh1d9EUVkYq3drgGVm9BJDmkbq36ySY6ccvbTEpE5k9pTcqe8ev7XperB/E0duELPfmWxV2mopR0kkdhls74=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1287.namprd15.prod.outlook.com (10.172.181.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Thu, 30 May 2019 18:51:53 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f%3]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 18:51:53 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
Thread-Topic: [PATCH 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
Thread-Index: AQHVFm7e3AOrc7hTMUGa4T8fWo+OPKaC2pWAgAC0sQA=
Date:   Thu, 30 May 2019 18:51:52 +0000
Message-ID: <27E78CF3-FAE7-4B6F-ABD7-77F4AE1CD633@fb.com>
References: <20190529223511.4059120-1-vijaykhemka@fb.com>
 <20190529223511.4059120-2-vijaykhemka@fb.com>
 <0a94e784-41a0-4f2d-f9f8-6b365a1e755e@roeck-us.net>
In-Reply-To: <0a94e784-41a0-4f2d-f9f8-6b365a1e755e@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:3b87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8769346-1b3f-4284-2353-08d6e52fe1ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1287;
x-ms-traffictypediagnostic: CY4PR15MB1287:
x-microsoft-antispam-prvs: <CY4PR15MB12878661FDCA1D6834A13A49DD180@CY4PR15MB1287.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(66446008)(66476007)(64756008)(66556008)(66946007)(76116006)(91956017)(73956011)(2501003)(82746002)(33656002)(11346002)(446003)(2906002)(6116002)(99286004)(68736007)(5660300002)(53936002)(186003)(76176011)(102836004)(6506007)(53546011)(25786009)(46003)(81156014)(81166006)(6436002)(83716004)(8676002)(2201001)(4326008)(8936002)(6512007)(86362001)(6246003)(7736002)(305945005)(6486002)(486006)(36756003)(2616005)(476003)(14454004)(229853002)(256004)(71190400001)(498600001)(110136005)(54906003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1287;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VHBY5wt7qSzSrGTq+nm9edr5hvpHxpBJSzyCAbxI2503XP30u2lGbDf24M5IkU8ZZtKwDysAwlpD5uQjukefHPOFMGv8GyU16A5fgC1O7UYBPCc756CIvR9m2STOHhSAZ+tJUAKPcdWLJtgWJidWZQKPhPHgUOgY6ITi7w9o9WukU7U/BQGqk8FLv37JTaZLeMT8AtLpyhiOn8tMeRal8uUHN9IvhmmL4Hr9NojbCMti8NDX1CU9x0ub46Dj6hW5jpD0g88HETKYOO6spqqzTMt+iQpOk5Pl9/3caYa6HNCq4aqdQ3wbe8MFGcJGnfTjvw/ptXRZfO3sc8fWg6o5Qrx3nd2GQ3CGWcGeqZCXHOFIcxfsAl154Wj1inKDPF05z5kL9w5jsE4pHFW2wwwZ2+6W010f7P3Q4fh0Qd5JAoY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3049E1786BD0A489B9CD348B1EE668E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8769346-1b3f-4284-2353-08d6e52fe1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 18:51:53.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vijaykhemka@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1287
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300131
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDUvMjkvMTksIDY6MDUgUE0sICJHdWVudGVyIFJvZWNrIiA8Z3JvZWNrN0BnbWFp
bC5jb20gb24gYmVoYWxmIG9mIGxpbnV4QHJvZWNrLXVzLm5ldD4gd3JvdGU6DQoNCiAgICBPbiA1
LzI5LzE5IDM6MzUgUE0sIFZpamF5IEtoZW1rYSB3cm90ZToNCiAgICA+IEFkZGVkIHN1cHBvcnQg
Zm9yIEluZmVuaW9uIFBYRTE2MTAgZHJpdmVyDQogICAgPiANCiAgICA+IFNpZ25lZC1vZmYtYnk6
IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0KICAgID4gLS0tDQogICAgPiAgIERv
Y3VtZW50YXRpb24vaHdtb24vcHhlMTYxMCB8IDg0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCiAgICA+ICAgMSBmaWxlIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKykNCiAg
ICA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vaHdtb24vcHhlMTYxMA0KICAg
ID4gDQogICAgPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9od21vbi9weGUxNjEwIGIvRG9j
dW1lbnRhdGlvbi9od21vbi9weGUxNjEwDQogICAgPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KICAg
ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5iNWM4M2VkZjAyN2ENCiAgICA+IC0tLSAvZGV2L251bGwN
CiAgICA+ICsrKyBiL0RvY3VtZW50YXRpb24vaHdtb24vcHhlMTYxMA0KICAgID4gQEAgLTAsMCAr
MSw4NCBAQA0KICAgID4gK0tlcm5lbCBkcml2ZXIgcHhlMTYxMA0KICAgID4gKz09PT09PT09PT09
PT09PT09PT09PQ0KICAgID4gKw0KICAgID4gK1N1cHBvcnRlZCBjaGlwczoNCiAgICA+ICsgICog
SW5maW5pb24gUFhFMTYxMA0KICAgID4gKyAgICBQcmVmaXg6ICdweGUxNjEwJw0KICAgID4gKyAg
ICBBZGRyZXNzZXMgc2Nhbm5lZDogLQ0KICAgID4gKyAgICBEYXRhc2hlZXQ6IERhdGFzaGVldCBp
cyBub3QgcHVibGljbHkgYXZhaWxhYmxlLg0KICAgID4gKw0KICAgID4gKyAgKiBJbmZpbmlvbiBQ
WEUxMTEwDQogICAgPiArICAgIFByZWZpeDogJ3B4ZTExMTAnDQogICAgPiArICAgIEFkZHJlc3Nl
cyBzY2FubmVkOiAtDQogICAgPiArICAgIERhdGFzaGVldDogRGF0YXNoZWV0IGlzIG5vdCBwdWJs
aWNseSBhdmFpbGFibGUuDQogICAgPiArDQogICAgPiArICAqIEluZmluaW9uIFBYTTEzMTANCiAg
ICA+ICsgICAgUHJlZml4OiAncHhtMTMxMCcNCiAgICA+ICsgICAgQWRkcmVzc2VzIHNjYW5uZWQ6
IC0NCiAgICA+ICsgICAgRGF0YXNoZWV0OiBEYXRhc2hlZXQgaXMgbm90IHB1YmxpY2x5IGF2YWls
YWJsZS4NCiAgICA+ICsNCiAgICA+ICtBdXRob3I6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FA
ZmIuY29tPg0KICAgID4gKw0KICAgID4gKw0KICAgID4gK0Rlc2NyaXB0aW9uDQogICAgPiArLS0t
LS0tLS0tLS0NCiAgICA+ICsNCiAgICA+ICtQWEUxNjEwIGlzIGEgTXVsdGktcmFpbC9NdWx0aXBo
YXNlIERpZ2l0YWwgQ29udHJvbGxlcnMgYW5kDQogICAgPiAraXQgaXMgY29tcGxpYW50IHRvIElu
dGVsIFZSMTMgREMtREMgY29udmVydGVyIHNwZWNpZmljYXRpb25zLg0KICAgID4gKw0KICAgIA0K
ICAgIEFuZCB0aGUgb3RoZXJzID8NClRoaXMgc3VwcG9ydHMgVlIxMiBhcyB3ZWxsIGFuZCBJIGRv
bid0IHNlZSB0aGlzIGNvbnRyb2xsZXIgc3VwcG9ydHMgYW55IG90aGVyIFZSIHZlcnNpb25zLg0K
ICAgIA0KICAgID4gKw0KICAgID4gK1VzYWdlIE5vdGVzDQogICAgPiArLS0tLS0tLS0tLS0NCiAg
ICA+ICsNCiAgICA+ICtUaGlzIGRyaXZlciBjYW4gYmUgZW5hYmxlZCB3aXRoIGtlcm5lbCBjb25m
aWcgQ09ORklHX1NFTlNPUlNfUFhFMTYxMA0KICAgID4gK3NldCB0byAneScgb3IgJ20nKGZvciBt
b2R1bGUpLg0KICAgID4gKw0KICAgIFRoZSBhYm92ZSBkb2VzIG5vdCByZWFsbHkgYWRkIHZhbHVl
Lg0KT2ssIEkgd2lsbCByZW1vdmUgaXQuDQogICAgDQogICAgPiArVGhpcyBkcml2ZXIgZG9lcyBu
b3QgcHJvYmUgZm9yIFBNQnVzIGRldmljZXMuIFlvdSB3aWxsIGhhdmUNCiAgICA+ICt0byBpbnN0
YW50aWF0ZSBkZXZpY2VzIGV4cGxpY2l0bHkuDQogICAgPiArDQogICAgPiArRXhhbXBsZTogdGhl
IGZvbGxvd2luZyBjb21tYW5kcyB3aWxsIGxvYWQgdGhlIGRyaXZlciBmb3IgYW4gUFhFMTYxMA0K
ICAgID4gK2F0IGFkZHJlc3MgMHg3MCBvbiBJMkMgYnVzICM0Og0KICAgID4gKw0KICAgID4gKyMg
bW9kcHJvYmUgcHhlMTYxMA0KICAgID4gKyMgZWNobyBweGUxNjEwIDB4NzAgPiAvc3lzL2J1cy9p
MmMvZGV2aWNlcy9pMmMtNC9uZXdfZGV2aWNlDQogICAgPiArDQogICAgPiArSXQgY2FuIGFsc28g
YmUgaW5zdGFudGlhdGVkIGJ5IGRlY2xhcmluZyBpbiBkZXZpY2UgdHJlZSBpZiBpdCBpcw0KICAg
ID4gK2J1aWx0IGFzIGEga2VybmVsIG5vdCBhcyBhIG1vZHVsZS4NCiAgICA+ICsNCiAgICANCiAg
ICBJIGFzc3VtZSB5b3UgbWVhbiAiYnVpbHQgaW50byB0aGUga2VybmVsIi4NCiAgICBXaHkgd291
bGQgZGV2aWNldHJlZSBiYXNlZCBpbnN0YW50aWF0aW9uIG5vdCB3b3JrIGlmIHRoZSBkcml2ZXIg
aXMgYnVpbHQNCiAgICBhcyBtb2R1bGUgPw0KV2lsbCBjb3JyZWN0IHN0YXRlbWVudCBoZXJlLg0K
ICAgIA0KICAgID4gKw0KICAgID4gK1N5c2ZzIGF0dHJpYnV0ZXMNCiAgICA+ICstLS0tLS0tLS0t
LS0tLS0tDQogICAgPiArDQogICAgPiArY3VycjFfbGFiZWwJCSJpaW4iDQogICAgPiArY3VycjFf
aW5wdXQJCU1lYXN1cmVkIGlucHV0IGN1cnJlbnQNCiAgICA+ICtjdXJyMV9hbGFybQkJQ3VycmVu
dCBoaWdoIGFsYXJtDQogICAgPiArDQogICAgPiArY3VyclsyLTRdX2xhYmVsCQkiaW91dFsxLTNd
Ig0KICAgID4gK2N1cnJbMi00XV9pbnB1dAkJTWVhc3VyZWQgb3V0cHV0IGN1cnJlbnQNCiAgICA+
ICtjdXJyWzItNF1fY3JpdAkJQ3JpdGljYWwgbWF4aW11bSBjdXJyZW50DQogICAgPiArY3Vyclsy
LTRdX2NyaXRfYWxhcm0JQ3VycmVudCBjcml0aWNhbCBoaWdoIGFsYXJtDQogICAgPiArDQogICAg
PiAraW4xX2xhYmVsCQkidmluIg0KICAgID4gK2luMV9pbnB1dAkJTWVhc3VyZWQgaW5wdXQgdm9s
dGFnZQ0KICAgID4gK2luMV9jcml0CQlDcml0aWNhbCBtYXhpbXVtIGlucHV0IHZvbHRhZ2UNCiAg
ICA+ICtpbjFfY3JpdF9hbGFybQkJSW5wdXQgdm9sdGFnZSBjcml0aWNhbCBoaWdoIGFsYXJtDQog
ICAgPiArDQogICAgPiAraW5bMi00XV9sYWJlbAkJInZvdXRbMS0zXSINCiAgICA+ICtpblsyLTRd
X2lucHV0CQlNZWFzdXJlZCBvdXRwdXQgdm9sdGFnZQ0KICAgID4gK2luWzItNF1fbGNyaXQJCUNy
aXRpY2FsIG1pbmltdW0gb3V0cHV0IHZvbHRhZ2UNCiAgICA+ICtpblsyLTRdX2xjcml0X2FsYXJt
CU91dHB1dCB2b2x0YWdlIGNyaXRpY2FsIGxvdyBhbGFybQ0KICAgID4gK2luWzItNF1fY3JpdAkJ
Q3JpdGljYWwgbWF4aW11bSBvdXRwdXQgdm9sdGFnZQ0KICAgID4gK2luWzItNF1fY3JpdF9hbGFy
bQlPdXRwdXQgdm9sdGFnZSBjcml0aWNhbCBoaWdoIGFsYXJtDQogICAgPiArDQogICAgPiArcG93
ZXIxX2xhYmVsCQkicGluIg0KICAgID4gK3Bvd2VyMV9pbnB1dAkJTWVhc3VyZWQgaW5wdXQgcG93
ZXINCiAgICA+ICtwb3dlcjFfYWxhcm0JCUlucHV0IHBvd2VyIGhpZ2ggYWxhcm0NCiAgICA+ICsN
CiAgICA+ICtwb3dlclsyLTRdX2xhYmVsCSJwb3V0WzEtM10iDQogICAgPiArcG93ZXJbMi00XV9p
bnB1dAlNZWFzdXJlZCBvdXRwdXQgcG93ZXINCiAgICA+ICsNCiAgICA+ICt0ZW1wWzEtM11faW5w
dXQJCU1lYXN1cmVkIHRlbXBlcmF0dXJlDQogICAgPiArdGVtcFsxLTNdX2NyaXQJCUNyaXRpY2Fs
IGhpZ2ggdGVtcGVyYXR1cmUNCiAgICA+ICt0ZW1wWzEtM11fY3JpdF9hbGFybQlDaGlwIHRlbXBl
cmF0dXJlIGNyaXRpY2FsIGhpZ2ggYWxhcm0NCiAgICA+ICt0ZW1wWzEtM11fbWF4CQlNYXhpbXVt
IHRlbXBlcmF0dXJlDQogICAgPiArdGVtcFsxLTNdX21heF9hbGFybQlDaGlwIHRlbXBlcmF0dXJl
IGhpZ2ggYWxhcm0NCiAgICA+IA0KICAgIA0KICAgIA0KDQo=
