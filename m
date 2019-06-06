Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E410FC28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B827C20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FUYycRgp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LrkyqAHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfFFSty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:49:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56828 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbfFFStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:49:53 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56ImYMT006422;
        Thu, 6 Jun 2019 11:49:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vMFe5i/SrFXIWMGeeB3ZoIy1NfZHjlQEJE5nkdTkgt4=;
 b=FUYycRgpRjhKDfNp7YiNt/awcHVRe2R3Did16ySi9HL6t/8c0nfEx7aiPFqv+kUGgUMg
 Ziraokxndqy7mzKuIF62IF9jmm+kZgJoVnUyLOJOcOwoVTeHyWrmA5rTPrf/YVZ7tkqH
 bSjizGnOXxpx8QEnndTqdbng58pXogXDDZc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sy1quhm7h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jun 2019 11:49:13 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 11:49:11 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 11:49:11 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 11:49:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMFe5i/SrFXIWMGeeB3ZoIy1NfZHjlQEJE5nkdTkgt4=;
 b=LrkyqAHPs7gT53Jg7oVKm/HXAqjGOZlO1csWWyjzdFucLJ0y5r5Uy2CehWm/tQD9hCuIL41sEz12AiZVIRv0wZYLAJ5T1Jt0f2KX8RahQJ/fKgIQVP76Dwzw8Q1MplrllbZitxgrMF0jiAu9e7Vs9tiL/olo7BQyMgzDtjRvTZY=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1815.namprd15.prod.outlook.com (10.174.54.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 6 Jun 2019 18:49:10 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f%3]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 18:49:10 +0000
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
Subject: Re: [PATCH v2 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
Thread-Topic: [PATCH v2 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
Thread-Index: AQHVFz02+Et6V6j2BECLwxLL8LkLiqaNkX+AgAD7uoA=
Date:   Thu, 6 Jun 2019 18:49:09 +0000
Message-ID: <27BD2580-6ADD-4389-A891-AE4AE9010E62@fb.com>
References: <20190530231159.222188-1-vijaykhemka@fb.com>
 <20190530231159.222188-2-vijaykhemka@fb.com>
 <20190605204811.GA32379@roeck-us.net>
In-Reply-To: <20190605204811.GA32379@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3607]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ce91b56-9132-4c0b-90fa-08d6eaafa94d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1815;
x-ms-traffictypediagnostic: CY4PR15MB1815:
x-microsoft-antispam-prvs: <CY4PR15MB1815416C3717B05D67063AF3DD170@CY4PR15MB1815.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(66556008)(5660300002)(478600001)(54906003)(66446008)(66476007)(64756008)(486006)(76176011)(6436002)(102836004)(6506007)(99286004)(6486002)(8676002)(91956017)(305945005)(76116006)(73956011)(46003)(7736002)(66946007)(81166006)(81156014)(68736007)(316002)(8936002)(14454004)(229853002)(11346002)(82746002)(36756003)(71200400001)(71190400001)(83716004)(476003)(86362001)(256004)(186003)(6512007)(4326008)(6116002)(25786009)(33656002)(2616005)(446003)(53936002)(6246003)(2906002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1815;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ipAm27EsBJGVZ9oR/mWYGY95IwpOpUKQkyfprAnEW9Mflui6sDiiRjn8cR8PCwJfcl4KexAs0HsRGnegWp1mYvNA8Ns9+GeDnVNDUSwOwZNOFLXC5lT+ko9/so4r7z8TovjJBvw1e70Qo/CW3Wh63Ky6wmLkxcFxvj3/IBb1iIEJpHRWJvsWEQpvYbGIHIS85ARgGR9rbB9UgXb7aAiqUe4pcCwDMsDSarBMjqdFP58poHoU7esJX1cf5D8k4h3jOc69hqOvHt0K3WqjmfjfqPcmNqJcx8vpqj/Vcd9DTnjjB0tNfuQazKWgVZmyPhmkatcVu8teX+7zSh5SGitewcHZU4NrKS3gIw83IZm3VSiobSUNv1oHwHPNBStZOONWZPd6rL8+xlkbucepmQwwDIhRs0dpmgkyJzwk171hbzo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <287AF5658E53AA4AB309BCB69E7C0105@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce91b56-9132-4c0b-90fa-08d6eaafa94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 18:49:09.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vijaykhemka@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1815
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060127
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDYvNS8xOSwgMTo0OCBQTSwgIkd1ZW50ZXIgUm9lY2siIDxncm9lY2s3QGdtYWls
LmNvbSBvbiBiZWhhbGYgb2YgbGludXhAcm9lY2stdXMubmV0PiB3cm90ZToNCg0KICAgIE9uIFRo
dSwgTWF5IDMwLCAyMDE5IGF0IDA0OjExOjU3UE0gLTA3MDAsIFZpamF5IEtoZW1rYSB3cm90ZToN
CiAgICA+IEFkZGVkIHN1cHBvcnQgZm9yIEluZmVuaW9uIFBYRTE2MTAgZHJpdmVyDQogICAgPiAN
CiAgICBBcHBsaWVkLCBhZnRlciBmaXhpbmcNCiAgICAJcy9JbmZlbmlvbi9JbmZpbmVvbi8NCiAg
ICAJcy9JbmZpbmlvbi9JbmZpbmVvbi8NClRoYW5rcw0KICAgIA0KICAgIEd1ZW50ZXINCiAgICAN
CiAgICA+IFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0K
ICAgID4gLS0tDQogICAgPiBDaGFuZ2VzIGluIHYyOg0KICAgID4gaW5jb3Jwb3JhdGVkIGFsbCB0
aGUgZmVlZGJhY2sgZnJvbSBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQogICAg
PiANCiAgICA+ICBEb2N1bWVudGF0aW9uL2h3bW9uL3B4ZTE2MTAgfCA5MCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQogICAgPiAgMSBmaWxlIGNoYW5nZWQsIDkwIGluc2Vy
dGlvbnMoKykNCiAgICA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9od21vbi9w
eGUxNjEwDQogICAgPiANCiAgICA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2h3bW9uL3B4
ZTE2MTAgYi9Eb2N1bWVudGF0aW9uL2h3bW9uL3B4ZTE2MTANCiAgICA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQogICAgPiBpbmRleCAwMDAwMDAwMDAwMDAuLjI0ODI1ZGI4NzM2Zg0KICAgID4gLS0t
IC9kZXYvbnVsbA0KICAgID4gKysrIGIvRG9jdW1lbnRhdGlvbi9od21vbi9weGUxNjEwDQogICAg
PiBAQCAtMCwwICsxLDkwIEBADQogICAgPiArS2VybmVsIGRyaXZlciBweGUxNjEwDQogICAgPiAr
PT09PT09PT09PT09PT09PT09PT09DQogICAgPiArDQogICAgPiArU3VwcG9ydGVkIGNoaXBzOg0K
ICAgID4gKyAgKiBJbmZpbmlvbiBQWEUxNjEwDQogICAgPiArICAgIFByZWZpeDogJ3B4ZTE2MTAn
DQogICAgPiArICAgIEFkZHJlc3NlcyBzY2FubmVkOiAtDQogICAgPiArICAgIERhdGFzaGVldDog
RGF0YXNoZWV0IGlzIG5vdCBwdWJsaWNseSBhdmFpbGFibGUuDQogICAgPiArDQogICAgPiArICAq
IEluZmluaW9uIFBYRTExMTANCiAgICA+ICsgICAgUHJlZml4OiAncHhlMTExMCcNCiAgICA+ICsg
ICAgQWRkcmVzc2VzIHNjYW5uZWQ6IC0NCiAgICA+ICsgICAgRGF0YXNoZWV0OiBEYXRhc2hlZXQg
aXMgbm90IHB1YmxpY2x5IGF2YWlsYWJsZS4NCiAgICA+ICsNCiAgICA+ICsgICogSW5maW5pb24g
UFhNMTMxMA0KICAgID4gKyAgICBQcmVmaXg6ICdweG0xMzEwJw0KICAgID4gKyAgICBBZGRyZXNz
ZXMgc2Nhbm5lZDogLQ0KICAgID4gKyAgICBEYXRhc2hlZXQ6IERhdGFzaGVldCBpcyBub3QgcHVi
bGljbHkgYXZhaWxhYmxlLg0KICAgID4gKw0KICAgID4gK0F1dGhvcjogVmlqYXkgS2hlbWthIDx2
aWpheWtoZW1rYUBmYi5jb20+DQogICAgPiArDQogICAgPiArDQogICAgPiArRGVzY3JpcHRpb24N
CiAgICA+ICstLS0tLS0tLS0tLQ0KICAgID4gKw0KICAgID4gK1BYRTE2MTAvUFhFMTExMCBhcmUg
TXVsdGktcmFpbC9NdWx0aXBoYXNlIERpZ2l0YWwgQ29udHJvbGxlcnMNCiAgICA+ICthbmQgY29t
cGxpYW50IHRvDQogICAgPiArCS0tIEludGVsIFZSMTMgREMtREMgY29udmVydGVyIHNwZWNpZmlj
YXRpb25zLg0KICAgID4gKwktLSBJbnRlbCBTVklEIHByb3RvY29sLg0KICAgID4gK1VzZWQgZm9y
IFZjb3JlIHBvd2VyIHJlZ3VsYXRpb24gZm9yIEludGVsIFZSMTMgYmFzZWQgbWljcm9wcm9jZXNz
b3JzDQogICAgPiArCS0tIFNlcnZlcnMsIFdvcmtzdGF0aW9ucywgYW5kIEhpZ2gtZW5kIGRlc2t0
b3BzDQogICAgPiArDQogICAgPiArUFhNMTMxMCBpcyBhIE11bHRpLXJhaWwgQ29udHJvbGxlcnMg
YW5kIGl0IGlzIGNvbXBsaWFudCB0bw0KICAgID4gKwktLSBJbnRlbCBWUjEzIERDLURDIGNvbnZl
cnRlciBzcGVjaWZpY2F0aW9ucy4NCiAgICA+ICsJLS0gSW50ZWwgU1ZJRCBwcm90b2NvbC4NCiAg
ICA+ICtVc2VkIGZvciBERFIzL0REUjQgTWVtb3J5IHBvd2VyIHJlZ3VsYXRpb24gZm9yIEludGVs
IFZSMTMgYW5kDQogICAgPiArSU1WUDggYmFzZWQgc3lzdGVtcw0KICAgID4gKw0KICAgID4gKw0K
ICAgID4gK1VzYWdlIE5vdGVzDQogICAgPiArLS0tLS0tLS0tLS0NCiAgICA+ICsNCiAgICA+ICtU
aGlzIGRyaXZlciBkb2VzIG5vdCBwcm9iZSBmb3IgUE1CdXMgZGV2aWNlcy4gWW91IHdpbGwgaGF2
ZQ0KICAgID4gK3RvIGluc3RhbnRpYXRlIGRldmljZXMgZXhwbGljaXRseS4NCiAgICA+ICsNCiAg
ICA+ICtFeGFtcGxlOiB0aGUgZm9sbG93aW5nIGNvbW1hbmRzIHdpbGwgbG9hZCB0aGUgZHJpdmVy
IGZvciBhbiBQWEUxNjEwDQogICAgPiArYXQgYWRkcmVzcyAweDcwIG9uIEkyQyBidXMgIzQ6DQog
ICAgPiArDQogICAgPiArIyBtb2Rwcm9iZSBweGUxNjEwDQogICAgPiArIyBlY2hvIHB4ZTE2MTAg
MHg3MCA+IC9zeXMvYnVzL2kyYy9kZXZpY2VzL2kyYy00L25ld19kZXZpY2UNCiAgICA+ICsNCiAg
ICA+ICtJdCBjYW4gYWxzbyBiZSBpbnN0YW50aWF0ZWQgYnkgZGVjbGFyaW5nIGluIGRldmljZSB0
cmVlDQogICAgPiArDQogICAgPiArDQogICAgPiArU3lzZnMgYXR0cmlidXRlcw0KICAgID4gKy0t
LS0tLS0tLS0tLS0tLS0NCiAgICA+ICsNCiAgICA+ICtjdXJyMV9sYWJlbAkJImlpbiINCiAgICA+
ICtjdXJyMV9pbnB1dAkJTWVhc3VyZWQgaW5wdXQgY3VycmVudA0KICAgID4gK2N1cnIxX2FsYXJt
CQlDdXJyZW50IGhpZ2ggYWxhcm0NCiAgICA+ICsNCiAgICA+ICtjdXJyWzItNF1fbGFiZWwJCSJp
b3V0WzEtM10iDQogICAgPiArY3VyclsyLTRdX2lucHV0CQlNZWFzdXJlZCBvdXRwdXQgY3VycmVu
dA0KICAgID4gK2N1cnJbMi00XV9jcml0CQlDcml0aWNhbCBtYXhpbXVtIGN1cnJlbnQNCiAgICA+
ICtjdXJyWzItNF1fY3JpdF9hbGFybQlDdXJyZW50IGNyaXRpY2FsIGhpZ2ggYWxhcm0NCiAgICA+
ICsNCiAgICA+ICtpbjFfbGFiZWwJCSJ2aW4iDQogICAgPiAraW4xX2lucHV0CQlNZWFzdXJlZCBp
bnB1dCB2b2x0YWdlDQogICAgPiAraW4xX2NyaXQJCUNyaXRpY2FsIG1heGltdW0gaW5wdXQgdm9s
dGFnZQ0KICAgID4gK2luMV9jcml0X2FsYXJtCQlJbnB1dCB2b2x0YWdlIGNyaXRpY2FsIGhpZ2gg
YWxhcm0NCiAgICA+ICsNCiAgICA+ICtpblsyLTRdX2xhYmVsCQkidm91dFsxLTNdIg0KICAgID4g
K2luWzItNF1faW5wdXQJCU1lYXN1cmVkIG91dHB1dCB2b2x0YWdlDQogICAgPiAraW5bMi00XV9s
Y3JpdAkJQ3JpdGljYWwgbWluaW11bSBvdXRwdXQgdm9sdGFnZQ0KICAgID4gK2luWzItNF1fbGNy
aXRfYWxhcm0JT3V0cHV0IHZvbHRhZ2UgY3JpdGljYWwgbG93IGFsYXJtDQogICAgPiAraW5bMi00
XV9jcml0CQlDcml0aWNhbCBtYXhpbXVtIG91dHB1dCB2b2x0YWdlDQogICAgPiAraW5bMi00XV9j
cml0X2FsYXJtCU91dHB1dCB2b2x0YWdlIGNyaXRpY2FsIGhpZ2ggYWxhcm0NCiAgICA+ICsNCiAg
ICA+ICtwb3dlcjFfbGFiZWwJCSJwaW4iDQogICAgPiArcG93ZXIxX2lucHV0CQlNZWFzdXJlZCBp
bnB1dCBwb3dlcg0KICAgID4gK3Bvd2VyMV9hbGFybQkJSW5wdXQgcG93ZXIgaGlnaCBhbGFybQ0K
ICAgID4gKw0KICAgID4gK3Bvd2VyWzItNF1fbGFiZWwJInBvdXRbMS0zXSINCiAgICA+ICtwb3dl
clsyLTRdX2lucHV0CU1lYXN1cmVkIG91dHB1dCBwb3dlcg0KICAgID4gKw0KICAgID4gK3RlbXBb
MS0zXV9pbnB1dAkJTWVhc3VyZWQgdGVtcGVyYXR1cmUNCiAgICA+ICt0ZW1wWzEtM11fY3JpdAkJ
Q3JpdGljYWwgaGlnaCB0ZW1wZXJhdHVyZQ0KICAgID4gK3RlbXBbMS0zXV9jcml0X2FsYXJtCUNo
aXAgdGVtcGVyYXR1cmUgY3JpdGljYWwgaGlnaCBhbGFybQ0KICAgID4gK3RlbXBbMS0zXV9tYXgJ
CU1heGltdW0gdGVtcGVyYXR1cmUNCiAgICA+ICt0ZW1wWzEtM11fbWF4X2FsYXJtCUNoaXAgdGVt
cGVyYXR1cmUgaGlnaCBhbGFybQ0KICAgIA0KDQo=
