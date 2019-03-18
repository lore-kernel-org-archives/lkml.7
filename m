Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE102084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lcEoU17R";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pk3lwol7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfCRRvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:51:43 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:35622 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbfCRRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:51:42 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2IHg5mk030557;
        Mon, 18 Mar 2019 10:49:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=7ZHcCmFSojdSf54bSRhDg5vb5JfYFbJRFoOCCQ+5qpw=;
 b=lcEoU17Rs5lRgcM6jShpPPnJy6QNNmGmB5SxzJ97IoPGVhXCp63nLZJlpvfMBiUekb2z
 f4JGx/lK7lDiQFlw12T8kRUYnLTk/sZl84HC6O6wgLVirOs7pDLBSWJ7Vkfc9W2TSJUG
 dVwYLDjkGCImjfa+791/OI1cbLT5OxHxMpljZrhHDMdTXsf92IVBjoFbXpNwnsKw7IbL
 lPcc3J68eY2zJnfFPCbWfMADKtWmgnb4N+pRG83ZYrvDBwBoqgViSmxhG6Zj0A24ziYI
 L8marn7Lqko9KSTOHj8CzcX27NCP5DDaUd1Bdmu15iWCej7r85qOfxP813FdyI0SXEHO TA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2054.outbound.protection.outlook.com [104.47.49.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2r8wpv96dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Mar 2019 10:49:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZHcCmFSojdSf54bSRhDg5vb5JfYFbJRFoOCCQ+5qpw=;
 b=pk3lwol7Re5FxkOSC4PF3HoCnv2Yr+d0yE31n4t0c9NnPNCwRc8jHxNUYEP5F28n56Ozl7ScCX7itTKrnzNdwtlGptTYLx+jUkS4/5O9Y3OFAAiD5m8xDvcUUR+35BhKVfCyu0KFdtqZxZehoy3weKFlO4hhM8plB/f771NjoGI=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2533.namprd07.prod.outlook.com (10.166.201.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 17:49:35 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::109:b92f:ec67:cc5c]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::109:b92f:ec67:cc5c%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 17:49:35 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>, Jan Kotas <jank@cadence.com>
Subject: RE: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in
 MDIO read/write functions.
Thread-Topic: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in
 MDIO read/write functions.
Thread-Index: AQHU3bIVpKCfblmDGkCRl74YIwcb1aYRqUaAgAAA2SA=
Date:   Mon, 18 Mar 2019 17:49:34 +0000
Message-ID: <CO2PR07MB2469EC9B8761CE1DC45D6832C1470@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20190223152540.GE10693@lunn.ch>
 <1552930948-6755-1-git-send-email-pthombar@cadence.com>
 <8098736e-d8a3-0fd9-9f51-277979aadf01@gmail.com>
In-Reply-To: <8098736e-d8a3-0fd9-9f51-277979aadf01@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0yZDIxNWE0OS00OWE2LTExZTktODRlOS0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcMmQyMTVhNGItNDlhNi0xMWU5LTg0ZTktMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSI2MTU3IiB0PSIxMzE5NzQwNDk2OTIzMDYxNjEiIGg9IlRwNmE5bEpIbXhMWlhZZEp5dGZDdWNyVy9MRT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e2d79c6-3971-4c19-1f9a-08d6abca1568
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2533;
x-ms-traffictypediagnostic: CO2PR07MB2533:
x-microsoft-antispam-prvs: <CO2PR07MB25331827B13A944EFD435783C1470@CO2PR07MB2533.namprd07.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(36092001)(13464003)(199004)(189003)(71190400001)(5660300002)(71200400001)(478600001)(3846002)(6116002)(11346002)(446003)(86362001)(6506007)(74316002)(186003)(52536014)(97736004)(102836004)(107886003)(76176011)(2501003)(256004)(14444005)(14454004)(26005)(9686003)(6246003)(68736007)(4326008)(53936002)(55016002)(7736002)(81156014)(7696005)(25786009)(8676002)(33656002)(8936002)(229853002)(305945005)(81166006)(476003)(99286004)(66066001)(2906002)(6436002)(110136005)(54906003)(486006)(106356001)(316002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2533;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KRmlqVtBNQWKzYJUhSS2WTP5zd+U5CmTIFDRDXW/DitSBQr77GLew7+sbGQ/vealS+y8xdcf1LEKm0AsDdLS5GjPzPU+AbURY55yKyXj1kA+n4AlIugYhaxS+2Yv0792F9BfO7gp6nfZixUaPkP5cZMPb/wO/YHIUm6i+mxccnRvw/PcBCpN/vhPYxBM67Qif/j06xbYcxxt0URpbL/CCOaXHxL3DL49taGO/EarX63HTKuAnA08d8WJfkypVIwnesyNXdbPV/UELQRhcE2OWBcIR4bPYiXVFnGdKZFhKp3YetNgDMkq2pFJeoTqTRACWIeYfVz1TmMczZPESER0CJT/2ZZ1sanKm3GbKKKVxAaKjPQhrY/B7RIJ9eB6bOIM9UjoY3G2xfzVN7sYiUwMdjy6Wk34E3bCgKaAym7iCB4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2d79c6-3971-4c19-1f9a-08d6abca1568
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 17:49:34.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2533
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903180131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBxdWljayByZXBseS4NCkkgYW0gc3RpbGwgd29ya2luZyBvbiBvdGhlciBwYXRj
aGVzLCBzbyBJIHRoaW5rIEkgd2lsbCBzZW5kIGFsbCBvZiB0aGVtIGluIGFub3RoZXIgc2luZ2xl
IG1haWwgY2hhaW4uDQoNClJlZ2FyZHMsDQpQYXJzaHVyYW0gVGhvbWJhcmUNCg0KPi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBn
bWFpbC5jb20+DQo+U2VudDogTW9uZGF5LCBNYXJjaCAxOCwgMjAxOSAxMToxNSBQTQ0KPlRvOiBQ
YXJzaHVyYW0gUmFqdSBUaG9tYmFyZSA8cHRob21iYXJAY2FkZW5jZS5jb20+OyBhbmRyZXdAbHVu
bi5jaA0KPkNjOiBuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb207IGRhdmVtQGRhdmVtbG9mdC5u
ZXQ7DQo+bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgaGthbGx3ZWl0MUBnbWFpbC5jb207IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+UmFmYWwgQ2llcGllbGEgPHJhZmFsY0BjYWRlbmNl
LmNvbT47IFBpb3RyIFNyb2thIDxwaW90cnNAY2FkZW5jZS5jb20+OyBKYW4NCj5Lb3RhcyA8amFu
a0BjYWRlbmNlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvM10gbmV0OiBldGhlcm5l
dDogY2FkZW5jZTogYWRkIGM0NSBQSFkgc3VwcG9ydCBpbiBNRElPDQo+cmVhZC93cml0ZSBmdW5j
dGlvbnMuDQo+DQo+RVhURVJOQUwgTUFJTA0KPg0KPg0KPk9uIDMvMTgvMTkgMTA6NDIgQU0sIFBh
cnNodXJhbSBUaG9tYmFyZSB3cm90ZToNCj4+IFNvcnJ5IGZvciBzZW5kaW5nIHRoaXMgcGF0Y2gg
YWdhaW4sIGJ1dCBJIGRpZG4ndCBzZW50IHByZXZpb3VzIGVtYWlsDQo+PiAtLWluLXJlcGx5LXRv
IGxhc3QgY29tbWVudCBvbiB2MSBvZiB0aGlzIHBhdGNoLiBTbyByZWN0aWZ5aW5nIHRoaXMNCj4+
IG1pc3Rha2UuDQo+DQo+WW91IGhhdmUgMyBwYXRjaGVzIGluIHlvdXIgc2VyaWVzLCB5b3UgbmVl
ZCB0byByZXNlbmQgYWxsIG9mIHRoZW0gZXZlbiBpZiB0aGVyZSBpcw0KPm9ubHkgb25lIHRvIHdo
aWNoIHlvdSBhcmUgbWFraW5nIGNoYW5nZXMsIHRoaXMgaXMgbm90IGRvY3VtZW50ZWQgaW4gbmV0
ZGV2LQ0KPkZBUS5yc3QgdGhvdWdoLCBsZXQncyB1cGRhdGUgdGhhdC4NCj4NCj4+DQo+PiBUaGlz
IHZlcnNpb24gMiBvZiBwYXRjaCB0byBtb2RpZnkgTURJTyByZWFkL3dyaXRlIGZ1bmN0aW9ucyB0
byBzdXBwb3J0DQo+PiBjb21tdW5pY2F0aW9uIHdpdGggQzQ1IFBIWSBpbiBDYWRlbmNlIGV0aGVy
bmV0IGNvbnRyb2xsZXIgZHJpdmVyLg0KPj4NCj4+IENoYW5nZXM6DQo+PiAJMS4gQWRkZWQgdGlt
ZW91dA0KPj4gCTIuIFJlbW92ZWQgdW51c2VkIG9wZXJhdGlvbiBtYWNybw0KPk1BQ0JfTUFOX0M0
NV9QT1NUX1JFQURfSU5DUg0KPj4NCj4+IEkgdGhvdWdodCBvZiBzdGFydGluZyB3aXRoIHJlbGF0
aXZlbHkgc21hbGxlciwgaW5kZXBlbmRhbnQgYW5kIHNpbXBsZXIgY2hhbmdlcy4NCj4+IFRoaXMg
cGF0Y2ggaXMgaW5kZXBlbmRhbnQgb2YgcGF0Y2ggc2VyaWVzIGFuZCBsb29rcyByZWxhdGl2ZWx5
DQo+PiBzdHJhaWdodCBmb3J3YXJkIHdpdGggYWltIG9mIHN1cHBvcnRpbmcgQzQ1IFBIWSBmb3Ig
c3VwcG9ydCBvZiBoaWdoIHNwZWVkDQo+UEhZJ3MuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFy
c2h1cmFtIFRob21iYXJlIDxwdGhvbWJhckBjYWRlbmNlLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYi5oICAgICAgfCAgIDE0ICsrKysrLS0NCj4+ICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jIHwgICA2MQ0KPisrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25z
KCspLCAxNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvY2FkZW5jZS9tYWNiLmgNCj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9t
YWNiLmgNCj4+IGluZGV4IGFjYzY2YTcuLmQyNWZhMDMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2IuaA0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvY2FkZW5jZS9tYWNiLmgNCj4+IEBAIC02MjksMTAgKzYyOSwxNiBAQA0KPj4gICNkZWZpbmUg
R0VNX0NMS19ESVY5NgkJCQk1DQo+Pg0KPj4gIC8qIENvbnN0YW50cyBmb3IgTUFOIHJlZ2lzdGVy
ICovDQo+PiAtI2RlZmluZSBNQUNCX01BTl9TT0YJCQkJMQ0KPj4gLSNkZWZpbmUgTUFDQl9NQU5f
V1JJVEUJCQkJMQ0KPj4gLSNkZWZpbmUgTUFDQl9NQU5fUkVBRAkJCQkyDQo+PiAtI2RlZmluZSBN
QUNCX01BTl9DT0RFCQkJCTINCj4+ICsjZGVmaW5lIE1BQ0JfTUFOX0MyMl9TT0YgICAgICAgICAg
ICAgICAgICAgICAgICAxDQo+PiArI2RlZmluZSBNQUNCX01BTl9DMjJfV1JJVEUgICAgICAgICAg
ICAgICAgICAgICAgMQ0KPj4gKyNkZWZpbmUgTUFDQl9NQU5fQzIyX1JFQUQgICAgICAgICAgICAg
ICAgICAgICAgIDINCj4+ICsjZGVmaW5lIE1BQ0JfTUFOX0MyMl9DT0RFICAgICAgICAgICAgICAg
ICAgICAgICAyDQo+PiArDQo+PiArI2RlZmluZSBNQUNCX01BTl9DNDVfU09GICAgICAgICAgICAg
ICAgICAgICAgICAgMA0KPj4gKyNkZWZpbmUgTUFDQl9NQU5fQzQ1X0FERFIgICAgICAgICAgICAg
ICAgICAgICAgIDANCj4+ICsjZGVmaW5lIE1BQ0JfTUFOX0M0NV9XUklURSAgICAgICAgICAgICAg
ICAgICAgICAxDQo+PiArI2RlZmluZSBNQUNCX01BTl9DNDVfUkVBRCAgICAgICAgICAgICAgICAg
ICAgICAgMw0KPj4gKyNkZWZpbmUgTUFDQl9NQU5fQzQ1X0NPREUgICAgICAgICAgICAgICAgICAg
ICAgIDINCj4+DQo+PiAgLyogQ2FwYWJpbGl0eSBtYXNrIGJpdHMgKi8NCj4+ICAjZGVmaW5lIE1B
Q0JfQ0FQU19JU1JfQ0xFQVJfT05fV1JJVEUJCTB4MDAwMDAwMDENCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+PiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4+IGluZGV4IGFkMDk5ZmQuLjE3MDcyZmQg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5j
DQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+PiBA
QCAtMzQ1LDExICszNDUsMzAgQEAgc3RhdGljIGludCBtYWNiX21kaW9fcmVhZChzdHJ1Y3QgbWlp
X2J1cyAqYnVzLCBpbnQNCj5taWlfaWQsIGludCByZWdudW0pDQo+PiAgCWlmIChzdGF0dXMgPCAw
KQ0KPj4gIAkJZ290byBtZGlvX3JlYWRfZXhpdDsNCj4+DQo+PiAtCW1hY2Jfd3JpdGVsKGJwLCBN
QU4sIChNQUNCX0JGKFNPRiwgTUFDQl9NQU5fU09GKQ0KPj4gLQkJCSAgICAgIHwgTUFDQl9CRihS
VywgTUFDQl9NQU5fUkVBRCkNCj4+IC0JCQkgICAgICB8IE1BQ0JfQkYoUEhZQSwgbWlpX2lkKQ0K
Pj4gLQkJCSAgICAgIHwgTUFDQl9CRihSRUdBLCByZWdudW0pDQo+PiAtCQkJICAgICAgfCBNQUNC
X0JGKENPREUsIE1BQ0JfTUFOX0NPREUpKSk7DQo+PiArCWlmIChyZWdudW0gJiBNSUlfQUREUl9D
NDUpIHsNCj4+ICsJCW1hY2Jfd3JpdGVsKGJwLCBNQU4sIChNQUNCX0JGKFNPRiwgTUFDQl9NQU5f
QzQ1X1NPRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKFJXLCBNQUNCX01BTl9DNDVfQUREUikNCj4+
ICsJCQkgICAgfCBNQUNCX0JGKFBIWUEsIG1paV9pZCkNCj4+ICsJCQkgICAgfCBNQUNCX0JGKFJF
R0EsIChyZWdudW0gPj4gMTYpICYgMHgxRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKERBVEEsIHJl
Z251bSAmIDB4RkZGRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKENPREUsIE1BQ0JfTUFOX0M0NV9D
T0RFKSkpOw0KPj4gKw0KPj4gKwkJc3RhdHVzID0gbWFjYl9tZGlvX3dhaXRfZm9yX2lkbGUoYnAp
Ow0KPj4gKwkJaWYgKHN0YXR1cyA8IDApDQo+PiArCQkJZ290byBtZGlvX3JlYWRfZXhpdDsNCj4+
ICsNCj4+ICsJCW1hY2Jfd3JpdGVsKGJwLCBNQU4sIChNQUNCX0JGKFNPRiwgTUFDQl9NQU5fQzQ1
X1NPRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKFJXLCBNQUNCX01BTl9DNDVfUkVBRCkNCj4+ICsJ
CQkgICAgfCBNQUNCX0JGKFBIWUEsIG1paV9pZCkNCj4+ICsJCQkgICAgfCBNQUNCX0JGKFJFR0Es
IChyZWdudW0gPj4gMTYpICYgMHgxRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKENPREUsIE1BQ0Jf
TUFOX0M0NV9DT0RFKSkpOw0KPj4gKwl9IGVsc2Ugew0KPj4gKwkJbWFjYl93cml0ZWwoYnAsIE1B
TiwgKE1BQ0JfQkYoU09GLCBNQUNCX01BTl9DMjJfU09GKQ0KPj4gKwkJCQl8IE1BQ0JfQkYoUlcs
IE1BQ0JfTUFOX0MyMl9SRUFEKQ0KPj4gKwkJCQl8IE1BQ0JfQkYoUEhZQSwgbWlpX2lkKQ0KPj4g
KwkJCQl8IE1BQ0JfQkYoUkVHQSwgcmVnbnVtKQ0KPj4gKwkJCQl8IE1BQ0JfQkYoQ09ERSwgTUFD
Ql9NQU5fQzIyX0NPREUpKSk7DQo+PiArCX0NCj4+DQo+PiAgCXN0YXR1cyA9IG1hY2JfbWRpb193
YWl0X2Zvcl9pZGxlKGJwKTsNCj4+ICAJaWYgKHN0YXR1cyA8IDApDQo+PiBAQCAtMzc4LDEyICsz
OTcsMzIgQEAgc3RhdGljIGludCBtYWNiX21kaW9fd3JpdGUoc3RydWN0IG1paV9idXMgKmJ1cywg
aW50DQo+bWlpX2lkLCBpbnQgcmVnbnVtLA0KPj4gIAlpZiAoc3RhdHVzIDwgMCkNCj4+ICAJCWdv
dG8gbWRpb193cml0ZV9leGl0Ow0KPj4NCj4+IC0JbWFjYl93cml0ZWwoYnAsIE1BTiwgKE1BQ0Jf
QkYoU09GLCBNQUNCX01BTl9TT0YpDQo+PiAtCQkJICAgICAgfCBNQUNCX0JGKFJXLCBNQUNCX01B
Tl9XUklURSkNCj4+IC0JCQkgICAgICB8IE1BQ0JfQkYoUEhZQSwgbWlpX2lkKQ0KPj4gLQkJCSAg
ICAgIHwgTUFDQl9CRihSRUdBLCByZWdudW0pDQo+PiAtCQkJICAgICAgfCBNQUNCX0JGKENPREUs
IE1BQ0JfTUFOX0NPREUpDQo+PiAtCQkJICAgICAgfCBNQUNCX0JGKERBVEEsIHZhbHVlKSkpOw0K
Pj4gKwlpZiAocmVnbnVtICYgTUlJX0FERFJfQzQ1KSB7DQo+PiArCQltYWNiX3dyaXRlbChicCwg
TUFOLCAoTUFDQl9CRihTT0YsIE1BQ0JfTUFOX0M0NV9TT0YpDQo+PiArCQkJICAgIHwgTUFDQl9C
RihSVywgTUFDQl9NQU5fQzQ1X0FERFIpDQo+PiArCQkJICAgIHwgTUFDQl9CRihQSFlBLCBtaWlf
aWQpDQo+PiArCQkJICAgIHwgTUFDQl9CRihSRUdBLCAocmVnbnVtID4+IDE2KSAmIDB4MUYpDQo+
PiArCQkJICAgIHwgTUFDQl9CRihEQVRBLCByZWdudW0gJiAweEZGRkYpDQo+PiArCQkJICAgIHwg
TUFDQl9CRihDT0RFLCBNQUNCX01BTl9DNDVfQ09ERSkpKTsNCj4+ICsNCj4+ICsJCXN0YXR1cyA9
IG1hY2JfbWRpb193YWl0X2Zvcl9pZGxlKGJwKTsNCj4+ICsJCWlmIChzdGF0dXMgPCAwKQ0KPj4g
KwkJCWdvdG8gbWRpb193cml0ZV9leGl0Ow0KPj4gKw0KPj4gKwkJbWFjYl93cml0ZWwoYnAsIE1B
TiwgKE1BQ0JfQkYoU09GLCBNQUNCX01BTl9DNDVfU09GKQ0KPj4gKwkJCSAgICB8IE1BQ0JfQkYo
UlcsIE1BQ0JfTUFOX0M0NV9XUklURSkNCj4+ICsJCQkgICAgfCBNQUNCX0JGKFBIWUEsIG1paV9p
ZCkNCj4+ICsJCQkgICAgfCBNQUNCX0JGKFJFR0EsIChyZWdudW0gPj4gMTYpICYgMHgxRikNCj4+
ICsJCQkgICAgfCBNQUNCX0JGKENPREUsIE1BQ0JfTUFOX0M0NV9DT0RFKQ0KPj4gKwkJCSAgICB8
IE1BQ0JfQkYoREFUQSwgdmFsdWUpKSk7DQo+PiArCX0gZWxzZSB7DQo+PiArCQltYWNiX3dyaXRl
bChicCwgTUFOLCAoTUFDQl9CRihTT0YsIE1BQ0JfTUFOX0MyMl9TT0YpDQo+PiArCQkJCXwgTUFD
Ql9CRihSVywgTUFDQl9NQU5fQzIyX1dSSVRFKQ0KPj4gKwkJCQl8IE1BQ0JfQkYoUEhZQSwgbWlp
X2lkKQ0KPj4gKwkJCQl8IE1BQ0JfQkYoUkVHQSwgcmVnbnVtKQ0KPj4gKwkJCQl8IE1BQ0JfQkYo
Q09ERSwgTUFDQl9NQU5fQzIyX0NPREUpDQo+PiArCQkJCXwgTUFDQl9CRihEQVRBLCB2YWx1ZSkp
KTsNCj4+ICsJfQ0KPj4NCj4+ICAJc3RhdHVzID0gbWFjYl9tZGlvX3dhaXRfZm9yX2lkbGUoYnAp
Ow0KPj4gIAlpZiAoc3RhdHVzIDwgMCkNCj4+DQo+DQo+DQo+LS0NCj5GbG9yaWFuDQo=
