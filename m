Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A6ACA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 08:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCC0214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 08:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JVA6OtBw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VdkRtINp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKCIRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 03:17:24 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:52416 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbfKCIRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 03:17:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA38FZ8b025643;
        Sun, 3 Nov 2019 01:17:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=iFpqjG1sbKdQn3l/4GtzlsP8jlO4tndO1LFxoZyDRtI=;
 b=JVA6OtBwzcxN8MxBLL5TY0lpVFbpBHo+g2fLZCSA50bkX0F+uLSOld9zcstSfSjXRAS2
 i0kia7BofW4hZf4pZVUw1bSR5rm0QFA+3RDOMYJlxFAhskIgaNbnbgdSEhbmMWki90O6
 kPbMbjl/HyVcR9OI8dbMWYdexjtadxVe/oL7hPbrb0JxYAfsl3QnCKCwTKSLAnOflnLf
 dlh4gfOEslM2AOby6CulxsBeuuFaUJlFhIRD9AUY9xVRmRuFQiMVk8Bcbbo8haAVQj+8
 EW4y2KyMVaetu2aaLjivPQUNp/LDJ6G54/TXgT5/p+Xw2rp7d6MciNXsN31bv5hddVl7 6Q== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2059.outbound.protection.outlook.com [104.47.33.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2w15cx2nsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 03 Nov 2019 01:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhqVs4Wb8A9G9DY1N6cCFGrkojs9/PQP4fpJImgmuejNPhxPSXtVzi8X9j1n7GBezzmhn8IO/CkS4R+RrgUg9LqFuUWgHbnHqVjl+ddWcvUvNTvEBptqpDTTowkXYLhZvv2QBde9NokuAtOczw16DgXBW2XXIgYDMAxUIbu9S/quQeIx1zcq3ZDoqMDdubwu0ESRxGo6k5/AE3fTb+a/TYWyQPQ7rywjevV46eJroiCikyGSCZPOCKxXKQ4XWNcD+0JeVjNXpboJ2+oYtyKFYh999533emRKxlA9L/KhZ6dm3PQXysXV+lbA0SoDKJjdCbFJuY9TB14xqZUW6+Ee/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFpqjG1sbKdQn3l/4GtzlsP8jlO4tndO1LFxoZyDRtI=;
 b=j5Oj1zbATvbK8z5h4vHb5KvUgigv63aJEbBfGaQAHYtYEr+7LCPcw0nbmAFES8Ri0QkceGnVywbhIXHzII2LfXowhjw7jVO/cof2qmr6kB6ocem/AI+3n/zeqTE2ks5BkzOdBe5M8cq3L5PGu81iND94FPk/GJE4WzD3Icey0nxnDOhqQ5AV0tpjf6tzQlr2tjrqNkYEGfR4F+C5Jzt6PWpzAETyozJJ3maEfqBDfygdUxvSV+ezYam+bcf5Ep4a8VoZx424q4Og4wMq31vHRuFIDtTWqlNPc82U8Lkyn7Tq3+9hGTBehTOalsNnZNPBIlpARNAHkvMmOJq267xt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFpqjG1sbKdQn3l/4GtzlsP8jlO4tndO1LFxoZyDRtI=;
 b=VdkRtINpfydfLZn8aFeCrI7jQYGKybHzD9z7JByqUXXbofcqyskC2yLdTXlJSDcZKeDYu2DG560IUAMr4YYzNdXzO1p0aWC/8R+Uapomb4SackDbIbWJNnZdi0vyhMfWUp2QW2oFSsumCP5nphgnvQNWZqxf5lkYzVknPzg7ACU=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5509.namprd07.prod.outlook.com (20.177.231.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Sun, 3 Nov 2019 08:17:03 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2408.016; Sun, 3 Nov 2019
 08:17:03 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when
 connected to Super-Speed host
Thread-Topic: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when
 connected to Super-Speed host
Thread-Index: AQHVjxvVqFJYSBv4q0KQRfTJbi0lwqd0c8cAgAAb1ACAAAWhgIAAAdkAgASD/LA=
Date:   Sun, 3 Nov 2019 08:17:03 +0000
Message-ID: <BYAPR07MB4709B96934FAED77689ED89EDD7C0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20191029151514.28495-1-rogerq@ti.com>
 <20191030121607.21739-1-rogerq@ti.com> <87pnide1k7.fsf@gmail.com>
 <44b07e90-a9de-ea99-25c6-dc72cf39bbe1@ti.com> <875zk5dw0m.fsf@gmail.com>
 <86a7fbc4-136f-78bb-4677-784199842c9f@ti.com>
In-Reply-To: <86a7fbc4-136f-78bb-4677-784199842c9f@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 409ed43f-5281-4034-b436-08d760363530
x-ms-traffictypediagnostic: BYAPR07MB5509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB5509467DEBA1240F9EFCA508DD7C0@BYAPR07MB5509.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(39840400004)(346002)(136003)(54534003)(36092001)(199004)(189003)(55016002)(2906002)(86362001)(81156014)(76176011)(7696005)(76116006)(478600001)(66946007)(53546011)(6506007)(4326008)(71200400001)(71190400001)(66556008)(66476007)(476003)(446003)(11346002)(99286004)(25786009)(14444005)(486006)(102836004)(14454004)(186003)(256004)(26005)(66066001)(9686003)(81166006)(305945005)(2501003)(8676002)(229853002)(8936002)(54906003)(66446008)(6116002)(6246003)(110136005)(64756008)(3846002)(316002)(74316002)(52536014)(5660300002)(7736002)(33656002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5509;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFRiCiZlBbaEKSWdOueia7QhzVMbaw+hHcFFaH6MndduwN9UImHM44w+uixwRWwiNpdP1zhOzGXy+BblN4v2G4HboNcOnTdbMVTCKYp5E7C6j4haZ7sTMv4FPGzBGrJpL++Onp5eaSfULYfFsSXcNtR5V1oQH4nn2vMYHfuE93MKH4ae0M6cLCu+eVkWBdCxc6ERZeZBJ4W2j9iCAMyo1TGAs4okC4T9wddiNIR5e7LANf7ac5sZfTL3YkFpiB6j2RZ3pVw2Rappc5EjfNwvWeuJW4MYrj4ruIuUrmbwH4nrMypf7EO/ixnM6sXpOxia+AhCBvYCRKZ3BGFq7ywgrBk58r2FYI6AxDife1Jc26gI6xsmJa2cux/g9Y6fWMV8i6JTwwaZckh99smPoXSkSupTR2mdFmPG3nQi2Li1DwBAeB8KSkvWrUdr7oMomzua2pCnlV3zeu8EsoCqEYavvA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409ed43f-5281-4034-b436-08d760363530
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 08:17:03.2699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpGYm4amWzohCY1HO57K3sbH9SGZukVuwzmxmtLMpxTC+F8SMz1b4ozbX2cDS/uTVPYG2bJLvO8WK9+wImd2FFDx5NPhwXVAiYRWBwhRThE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5509
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-03_05:2019-11-01,2019-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=872
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 clxscore=1011 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1911030089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4+DQo+PiBIaSwNCj4+DQo+PiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAdGkuY29tPiB3
cml0ZXM6DQo+Pg0KPj4+IEhpLA0KPj4+DQo+Pj4gT24gMzEvMTAvMjAxOSAxMDo1NSwgRmVsaXBl
IEJhbGJpIHdyb3RlOg0KPj4+Pg0KPj4+PiBIaSwNCj4+Pj4NCj4+Pj4gUm9nZXIgUXVhZHJvcyA8
cm9nZXJxQHRpLmNvbT4gd3JpdGVzOg0KPj4+Pg0KPj4+Pj4gVGFrZSBpbnRvIGFjY291bnQgZ2Fk
Z2V0IGRyaXZlcidzIHNwZWVkIGxpbWl0IHdoZW4gcHJvZ3JhbW1pbmcNCj4+Pj4+IGNvbnRyb2xs
ZXIgc3BlZWQuDQo+Pj4+Pg0KPj4+Pj4gRml4ZXM6IGNvbW1pdCA3NzMzZjZjMzJlMzYgKCJ1c2I6
IGNkbnMzOiBBZGQgQ2FkZW5jZSBVU0IzIERSRCBEcml2ZXIiKQ0KPj4+Pj4gU2lnbmVkLW9mZi1i
eTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQHRpLmNvbT4NCj4+Pj4+IEFja2VkLWJ5OiBQZXRlciBD
aGVuIDxwZXRlci5jaGVuQG54cC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+DQo+Pj4+PiBDaGFuZ2Vs
b2c6DQo+Pj4+PiB2Mg0KPj4+Pj4gLSBBZGQgRml4ZXMgbGluZQ0KPj4+Pj4NCj4+Pj4+ICAgIGRy
aXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLQ0KPj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMNCj4+Pj4+IGluZGV4IDQwZGFkNGU4ZDBk
Yy4uMWM3MjRjMjBkNDY4IDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvY2RuczMvZ2Fk
Z2V0LmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jDQo+Pj4+PiBAQCAt
MjMzOCw5ICsyMzM4LDM1IEBAIHN0YXRpYyBpbnQgY2RuczNfZ2FkZ2V0X3VkY19zdGFydChzdHJ1
Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LA0KPj4+Pj4gICAgew0KPj4+Pj4gICAgCXN0cnVjdCBjZG5z
M19kZXZpY2UgKnByaXZfZGV2ID0gZ2FkZ2V0X3RvX2NkbnMzX2RldmljZShnYWRnZXQpOw0KPj4+
Pj4gICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+Pj4+PiArCWVudW0gdXNiX2RldmljZV9zcGVl
ZCBtYXhfc3BlZWQgPSBkcml2ZXItPm1heF9zcGVlZDsNCj4+Pj4+DQo+Pj4+PiAgICAJc3Bpbl9s
b2NrX2lycXNhdmUoJnByaXZfZGV2LT5sb2NrLCBmbGFncyk7DQo+Pj4+PiAgICAJcHJpdl9kZXYt
PmdhZGdldF9kcml2ZXIgPSBkcml2ZXI7DQo+Pj4+PiArDQo+Pj4+PiArCS8qIGxpbWl0IHNwZWVk
IGlmIG5lY2Vzc2FyeSAqLw0KPj4+Pj4gKwltYXhfc3BlZWQgPSBtaW4oZHJpdmVyLT5tYXhfc3Bl
ZWQsIGdhZGdldC0+bWF4X3NwZWVkKTsNCj4+Pj4+ICsNCj4+Pj4+ICsJc3dpdGNoIChtYXhfc3Bl
ZWQpIHsNCj4+Pj4+ICsJY2FzZSBVU0JfU1BFRURfRlVMTDoNCj4+Pj4+ICsJCXdyaXRlbChVU0Jf
Q09ORl9TRk9SQ0VfRlMsICZwcml2X2Rldi0+cmVncy0+dXNiX2NvbmYpOw0KPj4NCj4+IHNvIHRo
aXMgZm9yY2VzIHRoZSBjb250cm9sbGVyIHRvIEZTDQo+DQo+UmlnaHQuDQo+DQo+Pg0KPj4+Pj4g
KwkJd3JpdGVsKFVTQl9DT05GX1VTQjNESVMsICZwcml2X2Rldi0+cmVncy0+dXNiX2NvbmYpOw0K
Pj4NCj4+IGFuZCB0aGlzIGRpc2Nvbm5lY3RzIGluIHN1cGVyc3BlZWQ/IFdoYXQgaXMgdGhpcyBz
dXBwb3NlZCB0byBkbz8NCj4+DQo+DQo+SXQgc2F5cyAiRGlzY29ubmVjdCBVU0IgZGV2aWNlIGlu
IFN1cGVyU3BlZWQiLg0KPg0KPldlIHdlcmUgYXNrZWQgdG8gc2V0IHRoYXQgYml0IHRvIGxpbWl0
IGl0IHRvIEhTLg0KPg0KPj4+Pj4gKwkJYnJlYWs7DQo+Pj4+PiArCWNhc2UgVVNCX1NQRUVEX0hJ
R0g6DQo+Pj4+PiArCQl3cml0ZWwoVVNCX0NPTkZfVVNCM0RJUywgJnByaXZfZGV2LT5yZWdzLT51
c2JfY29uZik7DQo+Pj4+PiArCQlicmVhazsNCj4+Pj4+ICsJY2FzZSBVU0JfU1BFRURfU1VQRVI6
DQo+Pj4+PiArCQlicmVhazsNCj4+Pj4+ICsJZGVmYXVsdDoNCj4+Pj4+ICsJCWRldl9lcnIocHJp
dl9kZXYtPmRldiwNCj4+Pj4+ICsJCQkiaW52YWxpZCBtYXhpbXVtX3NwZWVkIHBhcmFtZXRlciAl
ZFxuIiwNCj4+Pj4+ICsJCQltYXhfc3BlZWQpOw0KPj4+Pj4gKwkJLyogZmFsbCB0aHJvdWdoICov
DQo+Pj4+PiArCWNhc2UgVVNCX1NQRUVEX1VOS05PV046DQo+Pj4+PiArCQkvKiBkZWZhdWx0IHRv
IHN1cGVyc3BlZWQgKi8NCj4+Pj4+ICsJCW1heF9zcGVlZCA9IFVTQl9TUEVFRF9TVVBFUjsNCj4+
Pj4+ICsJCWJyZWFrOw0KPj4+Pj4gKwl9DQo+Pj4+DQo+Pj4+IEkgaGFkIHN1Z2dlc3RlZCBzb21l
IHNpbXBsaWZpY2F0aW9uIGZvciB0aGlzIGNhc2Ugc3RhdGVtZW50Lg0KPj4+Pg0KPj4+DQo+Pj4g
b29wcywgbG9va3MgbGlrZSBHcmVnIHBpY2tlZCB0aGlzIGFscmVhZHkuDQo+Pj4NCj4+PiBEdXJp
bmcgbW9yZSB0ZXN0cyB0b2RheSBJIGp1c3Qgb2JzZXJ2ZWQgdGhhdCB0aGlzIHBhdGNoIGNhdXNl
cw0KPj4+IHRoZSBmb2xsb3dpbmcgcmVncmVzc2lvbi4NCj4+Pg0KPj4+IENvbm5lY3QgRVZNIHRv
IFN1cGVyLVNwZWVkIGhvc3QNCj4+PiBMb2FkIGdfYXVkaW8uICh0aGlzIGVudW1lcmF0ZXMgYXMg
SFMgd2hpY2ggaXMgZmluZSkNCj4+PiB1bmxvYWQgZ19hdWRpbw0KPj4+IGxvYWQgZ196ZXJvICh0
aGlzIGVudW1lcmF0ZXMgYXQgSFMgaW5zdGVhZCBvZiBTUykuDQo+Pj4NCj4+PiBUaGlzIGlzIGJl
Y2F1c2UgdGhlIHNwZWVkIGxpbWl0IHRoYXQgd2Ugc2V0IGRvZXNuJ3QgZ2V0IGNsZWFyZWQuDQo+
Pj4NCj4+PiBOb3cgdGhlIGJpdHMgYXJlIHdyaXRlIG9ubHkgYW5kIHRoZXJlIGlzIGEgd2F5IHRv
IHVuZG8gVVNCX0NPTkZfU0ZPUkNFX0ZTDQo+Pj4gYnkgd3JpdGluZyBVU0JfQ09ORl9DRk9SQ0Vf
RlMsIGhvd2V2ZXIgdGhlcmUgaXMgbm8gY29ycmVzcG9uZGluZyBiaXQNCj4+PiB0byBjbGVhciBV
U0JfQ09ORl9VU0IzRElTLiBPbmx5IHdheSBzZWVtcyB0byBiZSBVU0JfQ0ZHX1NXUlNUIHdoaWNo
DQo+Pj4gaXMgYSBiaXQgaGFyc2ggSU1PLg0KPj4NCj4+IElzbid0IGJpdCAwIGVub3VnaD8NCj4+
DQo+PiAvKiBSZXNldCBVU0IgZGV2aWNlIGNvbmZpZ3VyYXRpb24uICovDQo+PiAjZGVmaW5lIFVT
Ql9DT05GX0NGR1JTVAkJQklUKDApDQo+DQo+UHJvYmFibHkgbm90LCBhcyBleHBsYW5hdGlvbiBv
ZiBVU0IzRElTIGJpdCBzYXlzLA0KPiJUbyBjb25uZWN0IGRpc2Nvbm5lY3RlZCBkZXZpY2UsIENQ
VSBwZXJmb3Jtcw0KPnNvZnR3YXJlIHJlc2V0IChDRkcuU1dSU1QpLiIgd2hpY2ggaXMgYml0IDcu
ICJEZXZpY2Ugc29mdHdhcmUgcmVzZXQuDQo+DQo+QnV0IEknbGwgbGV0IFBhd2VsIGNvbW1lbnQg
b24gdGhpcy4NCg0KWWVzIGl0J3MgdGhlIG9ubHkgd2F5IHRvIHJldHVybiBiYWNrIHRvIFNTIG1v
ZGUuIA0KVGhlIFVTQiBzcGVlZCBpcyBkZXRlY3RpbmcgZHVyaW5nIGNvbm5lY3RpbmcuIA0KQ0ZH
LlNXUlNUIG1ha2UgcmVjb25uZWN0LiANCg0KTWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIGFk
ZCBTUyBzdXBwb3J0IGluIGdfYXVkaW8gZnVuY3Rpb24uIA0KDQo+Pg0KPj4gQWxzbywgbm93IHRo
YXQgSSBsb29rIGF0IHRoaXMgbW9yZSBjYXJlZnVsbHksIHlvdSBzaG91bGQgbW92ZSB0aGF0IGNv
ZGUNCj4+IHRvIHVkY19zZXRfc3BlZWQoKS4NCj4+DQo+DQo+QWdyZWVkLiBJJ2xsIHJldmlzZSB0
aGUgaW1wbGVtZW50YXRpb24gdG8gbW92ZSBpdCB0byB1ZGNfc2V0X3NwZWVkKCkNCj5vbmNlIEkg
a25vdyBob3cgdG8gdW5kbyB0aGUgVVNCM0RJUy4NCj4NCj4tLQ0KPmNoZWVycywNCj4tcm9nZXIN
Cj5UZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBI
ZWxzaW5raS4NCj5ZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0Rv
bWljaWxlOiBIZWxzaW5raQ0KDQo=
