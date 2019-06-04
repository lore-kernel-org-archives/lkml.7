Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEBAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75FF24970
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="imL/Vx2X";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hq3M9Ltk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfFDISJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:18:09 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:39314 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726637AbfFDISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:18:08 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548DmOI022592;
        Tue, 4 Jun 2019 01:17:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=SwcToT3N7mLxCqp8YjEhJdSYzrmVTizBcfP0/1w2lfQ=;
 b=imL/Vx2XcALcnufqjiZRSIRA4i5UapQiJv+b4u1hzAmPuxSJRucEu5NyvYfxY/R6TEla
 HygESELUy0FjLoyIN0nJSGmgao7kaMdS6Cbd+n1SLfO8SpyIeP41AND0Oj7fwpman1S+
 7Q8zda1z4XfOMMwQAq1Vp8Kvbp8td+LCrgLwwsmjuMU7UDqVuz4npSBnwLeY3ouQYzvb
 e/WmvaOhUqgJLEvxOiZGd7qYtpWmMt1dCR+6wPUSjfLnarLV5AqW/FY3WRADXk4s0ibe
 bG9XDyz1P363Fwvv9hUxg/cmXMZzkewQ+fKKBtKfg+34YculIDhczy+U0kmTUeNsH53s 4A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2sun4qtfv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jun 2019 01:17:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwcToT3N7mLxCqp8YjEhJdSYzrmVTizBcfP0/1w2lfQ=;
 b=hq3M9Ltk7WTiv3n3ZeMSuSE5a+ABBeoGlU3KBcROyGgTiy4PCoM8btMCThjRv8R8H/bgx9vOxvbzwJMC2FI0byQHhQM0cfGKtICQUm7z6QiA3g19Zvc7M906ME/To+lEBhXRVwPp1rkVwozPvs2SAguxEJOZ2eCplOQWAtpchtg=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5014.namprd07.prod.outlook.com (52.135.238.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 08:17:35 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d%3]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 08:17:34 +0000
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
Thread-Index: AQHU73OfkVZWcW/pFU2+w3yS0nOx8KaLdD6AgAAGDlA=
Date:   Tue, 4 Jun 2019 08:17:34 +0000
Message-ID: <BYAPR07MB47099815FA4691B6106F80FEDD150@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1554882504-9010-1-git-send-email-pawell@cadence.com>
 <1554882504-9010-6-git-send-email-pawell@cadence.com>
 <b768bde9-d6c8-f655-aecb-d08bcb9286a6@ti.com>
In-Reply-To: <b768bde9-d6c8-f655-aecb-d08bcb9286a6@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzI5OGIyNzEtODZhMS0xMWU5LTg3NDEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDMyOThiMjczLTg2YTEtMTFlOS04NzQxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTg3OSIgdD0iMTMyMDQxMDk4NTE4NDY1MTM5IiBoPSJMRDk3ZXMrdXVvZUVlZnFZRWpwQit4bUVQY1E9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e79e6975-7207-417a-6522-08d6e8c51938
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR07MB5014;
x-ms-traffictypediagnostic: BYAPR07MB5014:
x-microsoft-antispam-prvs: <BYAPR07MB5014D4754350A2BD747CFD2DDD150@BYAPR07MB5014.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(376002)(346002)(36092001)(199004)(189003)(316002)(14444005)(71200400001)(71190400001)(66066001)(11346002)(476003)(229853002)(478600001)(446003)(26005)(2906002)(2501003)(5660300002)(14454004)(486006)(186003)(6436002)(107886003)(68736007)(7696005)(8936002)(25786009)(81156014)(6116002)(6246003)(8676002)(102836004)(55016002)(256004)(7416002)(110136005)(66946007)(73956011)(66476007)(66556008)(76116006)(64756008)(66446008)(305945005)(76176011)(52536014)(7736002)(54906003)(4326008)(3846002)(81166006)(86362001)(33656002)(9686003)(53936002)(74316002)(6506007)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5014;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kl1roRTZPRY7pbv8b/OAtDAjpsvFNadTo6fJ56nPV2cXe5Me7N96fWoYsf0Q7Tcy5mnwNxjioFQHwzQFoezt/hzci3fhHDC5COuxAYEjbYrw9AsgnTRElIgYqNju+D6qtMol4AI8Sk0gPaWImCyxiPYbAlKDmkitDTaMrqslAiR+eltjtTp9hNk/RGL5ojWsfSikZARYJXGBG9z7Vb87gPwKBwr2ayPMZ4FDg5OuepkHoTE4NaM40T8CVfx5dB7xfS851tm6dyjMAO6VkSEtWK0dm5MK28oUmFbMQlEUhgRI5PsbFZZO6hR1P8d3pvmTLA5unLD5ahlERxyVb6dtm8UsMqWfLg++SuLqrLAxW6UeVQH0z+CdDXURZfRCegT4lZgvTX1vJv7S8BJ2W6lJVPlzsXEtbnTr0O5/0HEYrRU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79e6975-7207-417a-6522-08d6e8c51938
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 08:17:34.7562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5014
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPk9uIDEwLzA0LzE5IDE6MTggUE0sIFBhd2VsIExhc3pjemFrIHdyb3RlOg0KPj4gK3N0YXRp
YyB2b2lkIGNkbnMzX3dhMV90cmF5X3Jlc3RvcmVfY3ljbGVfYml0KHN0cnVjdCBjZG5zM19kZXZp
Y2UgKnByaXZfZGV2LA0KPj4gKwkJCQkJICAgICBzdHJ1Y3QgY2RuczNfZW5kcG9pbnQgKnByaXZf
ZXApDQo+PiArew0KPj4gKwlpbnQgZG1hX2luZGV4Ow0KPj4gKwl1MzIgZG9vcmJlbGw7DQo+PiAr
DQo+PiArCWRvb3JiZWxsID0gISEocmVhZGwoJnByaXZfZGV2LT5yZWdzLT5lcF9jbWQpICYgRVBf
Q01EX0RSRFkpOw0KPg0KPj4gKwlkbWFfaW5kZXggPSAocmVhZGwoJnByaXZfZGV2LT5yZWdzLT5l
cF90cmFkZHIpIC0NCj4+ICsJCSAgICBwcml2X2VwLT50cmJfcG9vbF9kbWEpIC8gVFJCX1NJWkU7
DQo+DQo+VGhpcyBnZXRzIHVwZ3JhZGVkIHRvIDY0LWJpdCBieSA2NC1iaXQgZGl2aXNpb24gd2hl
bmV2ZXIgZG1hX2FkZHJfdCBpcw0KPjY0LWJpdC4gVGhhdCBzaG91bGQgYmUgYXZvaWRlZC4gRm9s
bG93aW5nIGRpZmYgc2hvdWxkIGZpeCBpdC4NCj5CdXQgcGxlYXNlIHJldmlldyB0aGUgbG9naWMg
aXRzZWxmLiBZb3UgYXJlIHN1YnRyYWN0aW5nIGEgNjQgYml0IGVudGl0eQ0KPmZyb20gYSAzMi1i
aXQgZW50aXR5LiBXaGF0IGlzIGd1YXJhbnRlZWluZyB0aGF0IHByaXZfZXAtPnRyYl9wb29sX2Rt
YSBpcw0KPjMyLWJpdD8NCj4NCj5UaGVyZSBpcyBvbmUgbW9yZSBpbnN0YW5jZSBvZiBzYW1lIGlz
c3VlIGluIGNkbnMzX3JlcXVlc3RfaGFuZGxlZCgpLg0KPg0KPlRoYW5rcywNCj5TZWtoYXINCj4N
Cj5bMV0NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9jZG5zMy9nYWRnZXQuYw0KPmluZGV4IGJmZDVkYmY0MGM3ZS4uZTczYjYxODUwMWZiIDEw
MDY0NA0KPi0tLSBhL2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jDQo+KysrIGIvZHJpdmVycy91
c2IvY2RuczMvZ2FkZ2V0LmMNCj5AQCAtNzQ5LDggKzc0OSw4IEBAIHN0YXRpYyB2b2lkIGNkbnMz
X3dhMV90cmF5X3Jlc3RvcmVfY3ljbGVfYml0KHN0cnVjdCBjZG5zM19kZXZpY2UgKnByaXZfZGV2
LA0KPiAJdTMyIGRvb3JiZWxsOw0KPg0KPiAJZG9vcmJlbGwgPSAhIShyZWFkbCgmcHJpdl9kZXYt
PnJlZ3MtPmVwX2NtZCkgJiBFUF9DTURfRFJEWSk7DQo+LQlkbWFfaW5kZXggPSAocmVhZGwoJnBy
aXZfZGV2LT5yZWdzLT5lcF90cmFkZHIpIC0NCj4tCQkgICAgcHJpdl9lcC0+dHJiX3Bvb2xfZG1h
KSAvIFRSQl9TSVpFOw0KPisJZG1hX2luZGV4ID0gcmVhZGwoJnByaXZfZGV2LT5yZWdzLT5lcF90
cmFkZHIpIC0gcHJpdl9lcC0+dHJiX3Bvb2xfZG1hOw0KPisJZG1hX2luZGV4IC89IFRSQl9TSVpF
Ow0KDQpIaSBTZWtoYXIsDQoNCkluIHRoZSBuZXh0IGxhdGVzdCB2ZXJzaW9uIEkgYWRkZWQgc2V0
dGluZyBkbWEgYW5kIGNvaGVyZW50IG1hc2sgdG8gMzItYml0cyBhcyBzdWdnZXN0ZWQgYnkgUm9n
ZXIuIA0KQ29udHJvbGxlciBjYW4gZG8gb25seSAzMi1iaXQgYWNjZXNzLg0KDQpETUEgYWRkcmVz
cyBzcGFjZSBzaG91bGQgYmUgYWxsb2NhdGVkIGZyb20gZmlyc3QgMzIgYml0cyBvZiBhZGRyZXNz
IHNwYWNlLiBNb3N0IHNpZ25pZmljYW50IDMyLWJpdCANCm9mIHByaXZfZXAtPnRyYl9wb29sX2Rt
YSBzaG91bGQgYmUgemVyb2VkLCBzbyBJIGRvIG5vdCBhc3N1bWUgYW55IGlzc3VlIGluIHRoaXMg
cGxhY2UuDQoNCkhhdmUgeW91IHNlZW4gYW55IGlzc3VlIHdpdGggdGhpcyBvbiB5b3VyIHBsYXRm
b3JtID8NCg0KVGhhbmtzLA0KUGF3ZWwsDQo=
