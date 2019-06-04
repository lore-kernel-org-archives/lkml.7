Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CA8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AF324AE2
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="RYb6/VJG";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Y4htNwu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfFDIiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:38:51 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48180 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbfFDIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:38:51 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548ZJlG009541;
        Tue, 4 Jun 2019 01:38:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=f1Ln8uyGA2vfxUNezx/6RbRujRA2u0SVhetpsntAmUA=;
 b=RYb6/VJGHsstyRkwB/T5qSlTTzmIsel5cmekFhUb4KPM0EKHQ8jVG47iymNg2LXfErk3
 Jf7iDDq+++WjaXcc6UAVZghjO0lm2LrKZKAnhsT6d0N9iyS9fbX1oJ6/2nrCycY5Vtoj
 lXjGT/E0rNpczs3dkBKpGeIctVa80UtA3WxZYw8D4QrVK1vUhWbJSa1FiXCx0LSZIayt
 ddtNoveOQwZfAIoYQE+oqUhL1K0w0u/0auchdGs/N8KZnzvY+M2E67IAz/hwdJue4dCh
 H3qxMIxlopg1ilYqCdY/+omKVAFV8bZm588Y8mCT+n1t9lv+iWCv770sAMN++bo6aONd Qg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2sun4qtja5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jun 2019 01:38:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1Ln8uyGA2vfxUNezx/6RbRujRA2u0SVhetpsntAmUA=;
 b=Y4htNwu7VEDjnGpMtgOCUbJ1XD0O0+ehE5CARAylAd8ffif8nriFiNmTlNVhaU7+3u51ZifUp7inKc4kVPHaLbmy5rabsixBJCLpMY9jj2JLsQKNIGgGVET3aSmKenPC0OgWkhn7c1O1n4fZ+edXyQ/Bba1cbRdJe4MaBrIWIrM=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5720.namprd07.prod.outlook.com (20.178.0.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 08:38:30 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d%3]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 08:38:30 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Sekhar Nori <nsekhar@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v6 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v6 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHU73OfkVZWcW/pFU2+w3yS0nOx8KaLdD6AgAAGDlCAAASzgIAAAOkw
Date:   Tue, 4 Jun 2019 08:38:30 +0000
Message-ID: <BYAPR07MB4709B64FED6F1D274BF1E17DDD150@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1554882504-9010-1-git-send-email-pawell@cadence.com>
 <1554882504-9010-6-git-send-email-pawell@cadence.com>
 <b768bde9-d6c8-f655-aecb-d08bcb9286a6@ti.com>
 <BYAPR07MB47099815FA4691B6106F80FEDD150@BYAPR07MB4709.namprd07.prod.outlook.com>
 <f912a979-1e0c-8013-7f82-09102cb39a19@ti.com>
In-Reply-To: <f912a979-1e0c-8013-7f82-09102cb39a19@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMWYyYWFmZGItODZhNC0xMWU5LTg3NDEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDFmMmFhZmRkLTg2YTQtMTFlOS04NzQxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjcyOSIgdD0iMTMyMDQxMTExMDc3NDAyMTg1IiBoPSJtWUVsWHZWVW95R0xEY0FYT0VaUnZzem1ubXc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33a87714-3937-4992-57c4-08d6e8c8057a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5720;
x-ms-traffictypediagnostic: BYAPR07MB5720:
x-microsoft-antispam-prvs: <BYAPR07MB572083A1F425CD5773CA17AEDD150@BYAPR07MB5720.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(36092001)(316002)(3846002)(25786009)(305945005)(476003)(68736007)(86362001)(486006)(6116002)(64756008)(81166006)(11346002)(446003)(8936002)(66946007)(53546011)(66446008)(66476007)(66556008)(256004)(2906002)(4326008)(53936002)(14444005)(107886003)(6246003)(71200400001)(71190400001)(66066001)(26005)(54906003)(52536014)(55016002)(6506007)(5660300002)(76176011)(7696005)(74316002)(6436002)(102836004)(76116006)(14454004)(73956011)(478600001)(99286004)(110136005)(186003)(7416002)(2501003)(7736002)(229853002)(8676002)(81156014)(9686003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5720;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Axht3xV2JCLcfFTr7+HPJvJnT/8NZmghr2Wr7loTGldcnXGFCuv8XkjgTYRRYtMk0eEH++06lkr+2HBvkjj7sICXXE2KChs1fyGGYAWDAdOfDXGGZBQMuGXvfqmsF4bL78ijuTA64jrW6QL2nldkkM/rT/YsvPXD+rAqcVmZBFn8YkCZAtqN0n5xM2dif3a3qpJyLR8rhTpQ2QeDUvr1IiCAUpI/hmDrRWWw4qmDqbZjb0HMfm7olLvQ6zlf06xotbnn4YHnMWjngwRvLiwPChnx2ONcDAFudVbR/jvwfSDgWTBiLR0pHVq+s/TWysP3AX1Qtvuxby1gmZgpSGeIZIuxtKpGhDEi60XTfryzajIluezneYgl8h+XvXxppCmQB3ZA3iDqXkIvg9agatHE92Rn8XvpOb1BpYerdgyBf1g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a87714-3937-4992-57c4-08d6e8c8057a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 08:38:30.1361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5720
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+IE9uIDEwLzA0LzE5IDE6MTggUE0sIFBhd2VsIExhc3pjemFrIHdyb3RlOg0KPj4+PiArc3Rh
dGljIHZvaWQgY2RuczNfd2ExX3RyYXlfcmVzdG9yZV9jeWNsZV9iaXQoc3RydWN0IGNkbnMzX2Rl
dmljZSAqcHJpdl9kZXYsDQo+Pj4+ICsJCQkJCSAgICAgc3RydWN0IGNkbnMzX2VuZHBvaW50ICpw
cml2X2VwKQ0KPj4+PiArew0KPj4+PiArCWludCBkbWFfaW5kZXg7DQo+Pj4+ICsJdTMyIGRvb3Ji
ZWxsOw0KPj4+PiArDQo+Pj4+ICsJZG9vcmJlbGwgPSAhIShyZWFkbCgmcHJpdl9kZXYtPnJlZ3Mt
PmVwX2NtZCkgJiBFUF9DTURfRFJEWSk7DQo+Pj4NCj4+Pj4gKwlkbWFfaW5kZXggPSAocmVhZGwo
JnByaXZfZGV2LT5yZWdzLT5lcF90cmFkZHIpIC0NCj4+Pj4gKwkJICAgIHByaXZfZXAtPnRyYl9w
b29sX2RtYSkgLyBUUkJfU0laRTsNCj4+Pg0KPj4+IFRoaXMgZ2V0cyB1cGdyYWRlZCB0byA2NC1i
aXQgYnkgNjQtYml0IGRpdmlzaW9uIHdoZW5ldmVyIGRtYV9hZGRyX3QgaXMNCj4+PiA2NC1iaXQu
IFRoYXQgc2hvdWxkIGJlIGF2b2lkZWQuIEZvbGxvd2luZyBkaWZmIHNob3VsZCBmaXggaXQuDQo+
Pj4gQnV0IHBsZWFzZSByZXZpZXcgdGhlIGxvZ2ljIGl0c2VsZi4gWW91IGFyZSBzdWJ0cmFjdGlu
ZyBhIDY0IGJpdCBlbnRpdHkNCj4+PmZyb20gYSAzMi1iaXQgZW50aXR5LiBXaGF0IGlzIGd1YXJh
bnRlZWluZyB0aGF0IHByaXZfZXAtPnRyYl9wb29sX2RtYSBpcw0KPj4+IDMyLWJpdD8NCj4+Pg0K
Pj4+IFRoZXJlIGlzIG9uZSBtb3JlIGluc3RhbmNlIG9mIHNhbWUgaXNzdWUgaW4gY2RuczNfcmVx
dWVzdF9oYW5kbGVkKCkuDQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gU2VraGFyDQo+Pj4NCj4+PiBb
MV0NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9jZG5zMy9nYWRnZXQuYw0KPj4+IGluZGV4IGJmZDVkYmY0MGM3ZS4uZTczYjYxODUwMWZi
IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jDQo+Pj4gKysrIGIv
ZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMNCj4+PiBAQCAtNzQ5LDggKzc0OSw4IEBAIHN0YXRp
YyB2b2lkIGNkbnMzX3dhMV90cmF5X3Jlc3RvcmVfY3ljbGVfYml0KHN0cnVjdCBjZG5zM19kZXZp
Y2UgKnByaXZfZGV2LA0KPj4+IAl1MzIgZG9vcmJlbGw7DQo+Pj4NCj4+PiAJZG9vcmJlbGwgPSAh
IShyZWFkbCgmcHJpdl9kZXYtPnJlZ3MtPmVwX2NtZCkgJiBFUF9DTURfRFJEWSk7DQo+Pj4gLQlk
bWFfaW5kZXggPSAocmVhZGwoJnByaXZfZGV2LT5yZWdzLT5lcF90cmFkZHIpIC0NCj4+PiAtCQkg
ICAgcHJpdl9lcC0+dHJiX3Bvb2xfZG1hKSAvIFRSQl9TSVpFOw0KPj4+ICsJZG1hX2luZGV4ID0g
cmVhZGwoJnByaXZfZGV2LT5yZWdzLT5lcF90cmFkZHIpIC0gcHJpdl9lcC0+dHJiX3Bvb2xfZG1h
Ow0KPj4+ICsJZG1hX2luZGV4IC89IFRSQl9TSVpFOw0KPj4NCj4+IEhpIFNla2hhciwNCj4+DQo+
PiBJbiB0aGUgbmV4dCBsYXRlc3QgdmVyc2lvbiBJIGFkZGVkIHNldHRpbmcgZG1hIGFuZCBjb2hl
cmVudCBtYXNrIHRvIDMyLWJpdHMgYXMgc3VnZ2VzdGVkIGJ5IFJvZ2VyLg0KPj4gQ29udHJvbGxl
ciBjYW4gZG8gb25seSAzMi1iaXQgYWNjZXNzLg0KPg0KPkkgdGhpbmsgdGhpcyBzaG91bGQgd29y
ayBmb3Igbm93IGV4Y2VwdCBpZiBpbiBzb21lIGZ1dHVyZSB2ZXJzaW9uIG9mDQo+Y29udHJvbGxl
ciB0aGUgbGltaXRhdGlvbiBvZiAzMi1iaXQgYWNjZXNzIGlzIGZpeGVkLiBJIGd1ZXNzIHRoYXQg
bWlnaHQNCj5tZWFuIGRpZmZlcmVudCBsb2dpYyBmb3IgRE1BIGhhbmRsaW5nIGFueXdheS4NCg0K
SSBub3cgYWJvdXQgbmV3IHJlZ2lzdGVyIHRoYXQgYWxsb3dzIHRvIHNldCB0aGUgc2VnbWVudCBh
ZGRyZXNzIGFuZCBleHRlbmQgdGhlIGFkZHJlc3MgdG8gNDggYml0LCBidXQgDQppdCByYXRoZXIg
d2lsbCBub3QgYmUgdXNlZCBvbiBMaW51eC4gQnkgbWVhbnMgb2YgdGhpcyByZWdpc3RlciB3ZSBj
YW4gc2V0IHRoZSBzYW1lIHNlZ21lbnQgbWVtb3J5IGZvciANCmFsbCBhcmVhIG9mICBETUEgbWVt
b3J5LiANCkknbSBub3Qgc3VyZSBpZiBMaW51eCBhbGxvdyB0byBjb25maWd1cmUgZG1hIGFuZCBj
b2hlcmVudCBtYXNrIGluIHRoaXMgd2F5LiANCg0KQnV0IG9rLCBJIHdpbGwgYWRkIHRoaXMgZml4
Lg0KDQpQYXdlbCwNCg0KPg0KPj4gRE1BIGFkZHJlc3Mgc3BhY2Ugc2hvdWxkIGJlIGFsbG9jYXRl
ZCBmcm9tIGZpcnN0IDMyIGJpdHMgb2YgYWRkcmVzcyBzcGFjZS4gTW9zdCBzaWduaWZpY2FudCAz
Mi1iaXQNCj4+IG9mIHByaXZfZXAtPnRyYl9wb29sX2RtYSBzaG91bGQgYmUgemVyb2VkLCBzbyBJ
IGRvIG5vdCBhc3N1bWUgYW55IGlzc3VlIGluIHRoaXMgcGxhY2UuDQo+Pg0KPj4gSGF2ZSB5b3Ug
c2VlbiBhbnkgaXNzdWUgd2l0aCB0aGlzIG9uIHlvdXIgcGxhdGZvcm0gPw0KPg0KPmJ1aWxkIGZh
aWxzIHdpdGgNCj4NCj5FUlJPUjogIl9fYWVhYmlfdWxkaXZtb2QiIFtkcml2ZXJzL3VzYi9jZG5z
My9jZG5zMy5rb10gdW5kZWZpbmVkIQ0KPg0KPm9uIDMyLWJpdCBwbGF0Zm9ybXMgd2l0aCBBUk0g
TFBBRSBlbmFibGVkLiBTbyBwbGVhc2Ugcm9sbCBpbiB0aGUgZml4IEkNCj5zdWdnZXN0ZWQuDQo+
DQo+VGhhbmtzLA0KPlNla2hhcg0K
