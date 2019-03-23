Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7278C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0382218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QlWeqkle";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fCvgtNF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCWERk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:17:40 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:52818 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfCWERj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:17:39 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2N4C8s7029901;
        Fri, 22 Mar 2019 21:15:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=NSWj/Nd7BguF9lvQJkpk6c5s3pMl/Hf1RKcIvypaeVA=;
 b=QlWeqkleaOeduBIF9q6lnpOMfZKUwT/MiObZcx7qkikjoaxv2XVg9xS4LXlcfcoyU1lG
 3e5gORKF3nIpKrxu0SOHo+VOdc0uvOrj0FZ5lRAXxsLrqTNgDcGwN6zxt2jjmOs/eLJF
 vQQAWLStSQed+QmKkijd++NqxFIBR700OzoiyzKnNFP4RA4QmuDeKBQqNn/DqAKtAeVJ
 7+07J3IK2jpfkrC0Z440bO1eUajQ5MYFo7WmyD8dUjuHhML5o3GTC9Tb7RWIKb0kvJSV
 73wCR/uBgFG5cCKEfss3qDFHr0mlikcLSIu5QYVCddzZrZ9Mz+Y4SE7C2uoW48kbXYca Ww== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rddh8g0gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Mar 2019 21:15:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSWj/Nd7BguF9lvQJkpk6c5s3pMl/Hf1RKcIvypaeVA=;
 b=fCvgtNF1xfx3b0yA1uA5oI4lNJYCkY4GBnWaQvDJr2fUkj3D+0PzSBq032zGWclZx4zNfkYapDbYU7cxLHnNRwuGd2CB8G2cJnZVRAUWzp+eTnCnepgPK5pQW02IH0byIlGqR8G3NHY33Jp4z0kevbsh3pJEfF+0akv8fcZvz3Y=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2501.namprd07.prod.outlook.com (10.166.200.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Sat, 23 Mar 2019 04:15:31 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::109:b92f:ec67:cc5c]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::109:b92f:ec67:cc5c%4]) with mapi id 15.20.1709.015; Sat, 23 Mar 2019
 04:15:31 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>, Jan Kotas <jank@cadence.com>
Subject: RE: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in
 MDIO read/write functions.
Thread-Topic: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in
 MDIO read/write functions.
Thread-Index: AQHU3bIVpKCfblmDGkCRl74YIwcb1aYWJOuAgAJ8aRA=
Date:   Sat, 23 Mar 2019 04:15:31 +0000
Message-ID: <CO2PR07MB2469AA2C7083294EDC82FD87C15C0@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20190223152540.GE10693@lunn.ch>
 <1552930948-6755-1-git-send-email-pthombar@cadence.com>
 <61038e49-28b5-53e2-8b16-e95623b6eb3c@microchip.com>
In-Reply-To: <61038e49-28b5-53e2-8b16-e95623b6eb3c@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00NzhkOTNhYi00ZDIyLTExZTktODRlOS0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcNDc4ZDkzYWQtNGQyMi0xMWU5LTg0ZTktMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSI2NzYzIiB0PSIxMzE5Nzc4ODEyNDY1ODYyMzIiIGg9ImVWenNmdit3bVZkeFVvRzZUcDdmT0ZqV0hDUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33d737b4-b9a9-4d70-5a28-08d6af46306e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2501;
x-ms-traffictypediagnostic: CO2PR07MB2501:
x-microsoft-antispam-prvs: <CO2PR07MB2501E5DD51B2C540985F65E5C15C0@CO2PR07MB2501.namprd07.prod.outlook.com>
x-forefront-prvs: 0985DA2459
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39850400004)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(13464003)(36092001)(6246003)(107886003)(446003)(476003)(105586002)(11346002)(9686003)(25786009)(68736007)(55016002)(6436002)(8936002)(486006)(71190400001)(71200400001)(53936002)(256004)(76176011)(110136005)(74316002)(7696005)(106356001)(4326008)(229853002)(305945005)(54906003)(316002)(7736002)(186003)(52536014)(99286004)(102836004)(26005)(81166006)(2906002)(14454004)(478600001)(33656002)(97736004)(8676002)(66066001)(81156014)(6116002)(5660300002)(6506007)(86362001)(3846002)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2501;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tO6SYxB+mXMC2dI9K0vIt3nd2lZ5ElWyOJNwknN9FxiGPuPWJmN4/rDgHiHZZKjWExPSbfqILdNE+bRcaOPQZ8orny+3AXa0PnPC7aGsEecDyzi+jUC/HD64aB+C19X4Q/+7n9q2487MmmWnn0GkmyER71iYCLCOnYLAdx++Om/fI/4+BjlkC9UoL/NpKHF2+9ldiHVjsQnP5oVrlDnEzN2QKHjpYMn6P2xjArrFsMP0aJB0DSaXa8OxTFEIQC3FSaAK1sBBe+OOu5gHXaGas5jF+pCN8e5IdUBIF/CmOUGMuzEm/pQKlvcv193t7wkL0NQxwIIlRoE4lJs3PAwQGFAQb3ZY6BAHulRCa8H6cVOgylKj+9/Y/XXQMfzXHslhtdfufgUlHXgJLJCiZgBwhX8CKCG5Hlwpp91T4PuV0ks=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d737b4-b9a9-4d70-5a28-08d6af46306e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2019 04:15:31.3602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2501
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903230031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTmljb2xhcy5GZXJyZUBtaWNyb2No
aXAuY29tIDxOaWNvbGFzLkZlcnJlQG1pY3JvY2hpcC5jb20+DQo+U2VudDogVGh1cnNkYXksIE1h
cmNoIDIxLCAyMDE5IDc6NDMgUE0NCj5UbzogUGFyc2h1cmFtIFJhanUgVGhvbWJhcmUgPHB0aG9t
YmFyQGNhZGVuY2UuY29tPjsgYW5kcmV3QGx1bm4uY2gNCj5DYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZi5mYWluZWxsaUBnbWFpbC5jb207DQo+aGthbGx3
ZWl0MUBnbWFpbC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFJhZmFsIENpZXBp
ZWxhDQo+PHJhZmFsY0BjYWRlbmNlLmNvbT47IFBpb3RyIFNyb2thIDxwaW90cnNAY2FkZW5jZS5j
b20+OyBKYW4gS290YXMNCj48amFua0BjYWRlbmNlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENI
IHYyIDIvM10gbmV0OiBldGhlcm5ldDogY2FkZW5jZTogYWRkIGM0NSBQSFkgc3VwcG9ydCBpbiBN
RElPDQo+cmVhZC93cml0ZSBmdW5jdGlvbnMuDQo+DQo+RVhURVJOQUwgTUFJTA0KPg0KPg0KPiRz
dWJqZWN0IGxpbmUgc2hvdWxkIGJlOg0KPg0KPiJuZXQ6IG1hY2I6IEFkZCBjNDUgUEhZIHN1cHBv
cnQgaW4gTURJTyByZWFkL3dyaXRlIGZ1bmN0aW9ucyINCj4NCj4NCg0KT2ssIEkgd2lsbCBjaGFu
Z2Ugc3ViamVjdCBpbiB2MyBvZiB0aGlzIHBhdGNoLg0KDQo+T24gMTgvMDMvMjAxOSBhdCAxODo0
MiwgUGFyc2h1cmFtIFRob21iYXJlIHdyb3RlOg0KPj4gU29ycnkgZm9yIHNlbmRpbmcgdGhpcyBw
YXRjaCBhZ2FpbiwgYnV0IEkgZGlkbid0IHNlbnQgcHJldmlvdXMgZW1haWwNCj4+IC0taW4tcmVw
bHktdG8gbGFzdCBjb21tZW50IG9uIHYxIG9mIHRoaXMgcGF0Y2guIFNvIHJlY3RpZnlpbmcgdGhp
cw0KPj4gbWlzdGFrZS4NCj4+DQo+PiBUaGlzIHZlcnNpb24gMiBvZiBwYXRjaCB0byBtb2RpZnkg
TURJTyByZWFkL3dyaXRlIGZ1bmN0aW9ucyB0byBzdXBwb3J0DQo+PiBjb21tdW5pY2F0aW9uIHdp
dGggQzQ1IFBIWSBpbiBDYWRlbmNlIGV0aGVybmV0IGNvbnRyb2xsZXIgZHJpdmVyLg0KPj4NCj4+
IENoYW5nZXM6DQo+PiAJMS4gQWRkZWQgdGltZW91dA0KPj4gCTIuIFJlbW92ZWQgdW51c2VkIG9w
ZXJhdGlvbiBtYWNybw0KPk1BQ0JfTUFOX0M0NV9QT1NUX1JFQURfSU5DUg0KPj4NCj4+IEkgdGhv
dWdodCBvZiBzdGFydGluZyB3aXRoIHJlbGF0aXZlbHkgc21hbGxlciwgaW5kZXBlbmRhbnQgYW5k
IHNpbXBsZXIgY2hhbmdlcy4NCj4+IFRoaXMgcGF0Y2ggaXMgaW5kZXBlbmRhbnQgb2YgcGF0Y2gg
c2VyaWVzIGFuZCBsb29rcyByZWxhdGl2ZWx5DQo+PiBzdHJhaWdodCBmb3J3YXJkIHdpdGggYWlt
IG9mIHN1cHBvcnRpbmcgQzQ1IFBIWSBmb3Igc3VwcG9ydCBvZiBoaWdoIHNwZWVkDQo+UEhZJ3Mu
DQo+DQo+TW9zdCBvZiB0aGlzIG11c3QgZ28gYmVsb3cgdGhlICItLS0iIGxpbmUgaGVyZXVuZGVy
Li4uDQo+DQo+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFyc2h1cmFtIFRob21iYXJlIDxwdGhv
bWJhckBjYWRlbmNlLmNvbT4NCj4+IC0tLQ0KPg0KPlRoZXJlIF4uDQo+DQo+QW5kIHRoZSBjb21t
aXQgbWVzc2FnZSBiZWZvcmUgc2hvdWxkIGxvb2sgbGlrZToNCj4iDQo+TW9kaWZ5IE1ESU8gcmVh
ZC93cml0ZSBmdW5jdGlvbnMgdG8gc3VwcG9ydCBjb21tdW5pY2F0aW9uIHdpdGggQzQ1IFBIWSBp
bg0KPkNhZGVuY2UgZXRoZXJuZXQgY29udHJvbGxlciBkcml2ZXIuDQo+Ig0KPg0KDQpPay4NCg0K
Pj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2IuaCAgICAgIHwgICAxNCArKysr
Ky0tDQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMgfCAgIDYx
DQo+KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2
MCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiLmgNCj4+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvY2FkZW5jZS9tYWNiLmgNCj4+IGluZGV4IGFjYzY2YTcuLmQyNWZhMDMgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2IuaA0KPj4gKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiLmgNCj4+IEBAIC02MjksMTAgKzYyOSwxNiBAQA0K
Pj4gICAjZGVmaW5lIEdFTV9DTEtfRElWOTYJCQkJNQ0KPj4NCj4+ICAgLyogQ29uc3RhbnRzIGZv
ciBNQU4gcmVnaXN0ZXIgKi8NCj4+IC0jZGVmaW5lIE1BQ0JfTUFOX1NPRgkJCQkxDQo+PiAtI2Rl
ZmluZSBNQUNCX01BTl9XUklURQkJCQkxDQo+PiAtI2RlZmluZSBNQUNCX01BTl9SRUFECQkJCTIN
Cj4+IC0jZGVmaW5lIE1BQ0JfTUFOX0NPREUJCQkJMg0KPj4gKyNkZWZpbmUgTUFDQl9NQU5fQzIy
X1NPRiAgICAgICAgICAgICAgICAgICAgICAgIDENCj4+ICsjZGVmaW5lIE1BQ0JfTUFOX0MyMl9X
UklURSAgICAgICAgICAgICAgICAgICAgICAxDQo+PiArI2RlZmluZSBNQUNCX01BTl9DMjJfUkVB
RCAgICAgICAgICAgICAgICAgICAgICAgMg0KPj4gKyNkZWZpbmUgTUFDQl9NQU5fQzIyX0NPREUg
ICAgICAgICAgICAgICAgICAgICAgIDINCj4+ICsNCj4+ICsjZGVmaW5lIE1BQ0JfTUFOX0M0NV9T
T0YgICAgICAgICAgICAgICAgICAgICAgICAwDQo+PiArI2RlZmluZSBNQUNCX01BTl9DNDVfQURE
UiAgICAgICAgICAgICAgICAgICAgICAgMA0KPj4gKyNkZWZpbmUgTUFDQl9NQU5fQzQ1X1dSSVRF
ICAgICAgICAgICAgICAgICAgICAgIDENCj4+ICsjZGVmaW5lIE1BQ0JfTUFOX0M0NV9SRUFEICAg
ICAgICAgICAgICAgICAgICAgICAzDQo+PiArI2RlZmluZSBNQUNCX01BTl9DNDVfQ09ERSAgICAg
ICAgICAgICAgICAgICAgICAgMg0KPg0KPg0KPllvdSBjaGFuZ2VkIHRhYnMgdG8gc3BhY2VzIGhl
cmU6IHBsZWFzZSBjb25mb3JtIHRvIHByZWNlZGluZyBkcml2ZXIncyBzdHlsZSBhbmQNCj5vdGhl
ciBsaW5lcyBvZiB0aGlzIC5oIGZpbGUuDQo+DQoNCkkgd2lsbCBjaGFuZ2Ugc3BhY2VzIGJ5IHRh
Yi4NCg0KPj4NCj4+ICAgLyogQ2FwYWJpbGl0eSBtYXNrIGJpdHMgKi8NCj4+ICAgI2RlZmluZSBN
QUNCX0NBUFNfSVNSX0NMRUFSX09OX1dSSVRFCQkweDAwMDAwMDAxDQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0KPj4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+PiBpbmRleCBhZDA5OWZkLi4xNzA3MmZk
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4u
Yw0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0KPj4g
QEAgLTM0NSwxMSArMzQ1LDMwIEBAIHN0YXRpYyBpbnQgbWFjYl9tZGlvX3JlYWQoc3RydWN0IG1p
aV9idXMgKmJ1cywgaW50DQo+bWlpX2lkLCBpbnQgcmVnbnVtKQ0KPj4gICAJaWYgKHN0YXR1cyA8
IDApDQo+PiAgIAkJZ290byBtZGlvX3JlYWRfZXhpdDsNCj4+DQo+PiAtCW1hY2Jfd3JpdGVsKGJw
LCBNQU4sIChNQUNCX0JGKFNPRiwgTUFDQl9NQU5fU09GKQ0KPj4gLQkJCSAgICAgIHwgTUFDQl9C
RihSVywgTUFDQl9NQU5fUkVBRCkNCj4+IC0JCQkgICAgICB8IE1BQ0JfQkYoUEhZQSwgbWlpX2lk
KQ0KPj4gLQkJCSAgICAgIHwgTUFDQl9CRihSRUdBLCByZWdudW0pDQo+PiAtCQkJICAgICAgfCBN
QUNCX0JGKENPREUsIE1BQ0JfTUFOX0NPREUpKSk7DQo+PiArCWlmIChyZWdudW0gJiBNSUlfQURE
Ul9DNDUpIHsNCj4+ICsJCW1hY2Jfd3JpdGVsKGJwLCBNQU4sIChNQUNCX0JGKFNPRiwgTUFDQl9N
QU5fQzQ1X1NPRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKFJXLCBNQUNCX01BTl9DNDVfQUREUikN
Cj4+ICsJCQkgICAgfCBNQUNCX0JGKFBIWUEsIG1paV9pZCkNCj4+ICsJCQkgICAgfCBNQUNCX0JG
KFJFR0EsIChyZWdudW0gPj4gMTYpICYgMHgxRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKERBVEEs
IHJlZ251bSAmIDB4RkZGRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKENPREUsIE1BQ0JfTUFOX0M0
NV9DT0RFKSkpOw0KPj4gKw0KPj4gKwkJc3RhdHVzID0gbWFjYl9tZGlvX3dhaXRfZm9yX2lkbGUo
YnApOw0KPj4gKwkJaWYgKHN0YXR1cyA8IDApDQo+PiArCQkJZ290byBtZGlvX3JlYWRfZXhpdDsN
Cj4+ICsNCj4+ICsJCW1hY2Jfd3JpdGVsKGJwLCBNQU4sIChNQUNCX0JGKFNPRiwgTUFDQl9NQU5f
QzQ1X1NPRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKFJXLCBNQUNCX01BTl9DNDVfUkVBRCkNCj4+
ICsJCQkgICAgfCBNQUNCX0JGKFBIWUEsIG1paV9pZCkNCj4+ICsJCQkgICAgfCBNQUNCX0JGKFJF
R0EsIChyZWdudW0gPj4gMTYpICYgMHgxRikNCj4+ICsJCQkgICAgfCBNQUNCX0JGKENPREUsIE1B
Q0JfTUFOX0M0NV9DT0RFKSkpOw0KPj4gKwl9IGVsc2Ugew0KPj4gKwkJbWFjYl93cml0ZWwoYnAs
IE1BTiwgKE1BQ0JfQkYoU09GLCBNQUNCX01BTl9DMjJfU09GKQ0KPj4gKwkJCQl8IE1BQ0JfQkYo
UlcsIE1BQ0JfTUFOX0MyMl9SRUFEKQ0KPj4gKwkJCQl8IE1BQ0JfQkYoUEhZQSwgbWlpX2lkKQ0K
Pj4gKwkJCQl8IE1BQ0JfQkYoUkVHQSwgcmVnbnVtKQ0KPj4gKwkJCQl8IE1BQ0JfQkYoQ09ERSwg
TUFDQl9NQU5fQzIyX0NPREUpKSk7DQo+PiArCX0NCj4+DQo+PiAgIAlzdGF0dXMgPSBtYWNiX21k
aW9fd2FpdF9mb3JfaWRsZShicCk7DQo+PiAgIAlpZiAoc3RhdHVzIDwgMCkNCj4+IEBAIC0zNzgs
MTIgKzM5NywzMiBAQCBzdGF0aWMgaW50IG1hY2JfbWRpb193cml0ZShzdHJ1Y3QgbWlpX2J1cyAq
YnVzLCBpbnQNCj5taWlfaWQsIGludCByZWdudW0sDQo+PiAgIAlpZiAoc3RhdHVzIDwgMCkNCj4+
ICAgCQlnb3RvIG1kaW9fd3JpdGVfZXhpdDsNCj4+DQo+PiAtCW1hY2Jfd3JpdGVsKGJwLCBNQU4s
IChNQUNCX0JGKFNPRiwgTUFDQl9NQU5fU09GKQ0KPj4gLQkJCSAgICAgIHwgTUFDQl9CRihSVywg
TUFDQl9NQU5fV1JJVEUpDQo+PiAtCQkJICAgICAgfCBNQUNCX0JGKFBIWUEsIG1paV9pZCkNCj4+
IC0JCQkgICAgICB8IE1BQ0JfQkYoUkVHQSwgcmVnbnVtKQ0KPj4gLQkJCSAgICAgIHwgTUFDQl9C
RihDT0RFLCBNQUNCX01BTl9DT0RFKQ0KPj4gLQkJCSAgICAgIHwgTUFDQl9CRihEQVRBLCB2YWx1
ZSkpKTsNCj4+ICsJaWYgKHJlZ251bSAmIE1JSV9BRERSX0M0NSkgew0KPj4gKwkJbWFjYl93cml0
ZWwoYnAsIE1BTiwgKE1BQ0JfQkYoU09GLCBNQUNCX01BTl9DNDVfU09GKQ0KPj4gKwkJCSAgICB8
IE1BQ0JfQkYoUlcsIE1BQ0JfTUFOX0M0NV9BRERSKQ0KPj4gKwkJCSAgICB8IE1BQ0JfQkYoUEhZ
QSwgbWlpX2lkKQ0KPj4gKwkJCSAgICB8IE1BQ0JfQkYoUkVHQSwgKHJlZ251bSA+PiAxNikgJiAw
eDFGKQ0KPj4gKwkJCSAgICB8IE1BQ0JfQkYoREFUQSwgcmVnbnVtICYgMHhGRkZGKQ0KPj4gKwkJ
CSAgICB8IE1BQ0JfQkYoQ09ERSwgTUFDQl9NQU5fQzQ1X0NPREUpKSk7DQo+PiArDQo+PiArCQlz
dGF0dXMgPSBtYWNiX21kaW9fd2FpdF9mb3JfaWRsZShicCk7DQo+PiArCQlpZiAoc3RhdHVzIDwg
MCkNCj4+ICsJCQlnb3RvIG1kaW9fd3JpdGVfZXhpdDsNCj4+ICsNCj4+ICsJCW1hY2Jfd3JpdGVs
KGJwLCBNQU4sIChNQUNCX0JGKFNPRiwgTUFDQl9NQU5fQzQ1X1NPRikNCj4+ICsJCQkgICAgfCBN
QUNCX0JGKFJXLCBNQUNCX01BTl9DNDVfV1JJVEUpDQo+PiArCQkJICAgIHwgTUFDQl9CRihQSFlB
LCBtaWlfaWQpDQo+PiArCQkJICAgIHwgTUFDQl9CRihSRUdBLCAocmVnbnVtID4+IDE2KSAmIDB4
MUYpDQo+PiArCQkJICAgIHwgTUFDQl9CRihDT0RFLCBNQUNCX01BTl9DNDVfQ09ERSkNCj4+ICsJ
CQkgICAgfCBNQUNCX0JGKERBVEEsIHZhbHVlKSkpOw0KPj4gKwl9IGVsc2Ugew0KPj4gKwkJbWFj
Yl93cml0ZWwoYnAsIE1BTiwgKE1BQ0JfQkYoU09GLCBNQUNCX01BTl9DMjJfU09GKQ0KPj4gKwkJ
CQl8IE1BQ0JfQkYoUlcsIE1BQ0JfTUFOX0MyMl9XUklURSkNCj4+ICsJCQkJfCBNQUNCX0JGKFBI
WUEsIG1paV9pZCkNCj4+ICsJCQkJfCBNQUNCX0JGKFJFR0EsIHJlZ251bSkNCj4+ICsJCQkJfCBN
QUNCX0JGKENPREUsIE1BQ0JfTUFOX0MyMl9DT0RFKQ0KPj4gKwkJCQl8IE1BQ0JfQkYoREFUQSwg
dmFsdWUpKSk7DQo+PiArCX0NCj4+DQo+PiAgIAlzdGF0dXMgPSBtYWNiX21kaW9fd2FpdF9mb3Jf
aWRsZShicCk7DQo+PiAgIAlpZiAoc3RhdHVzIDwgMCkNCj4NCj5PdGhlcndpc2UgaXQgbG9va3Mg
Y29ycmVjdCB0byBtZSBvbiB0aGUgbWFjYiBwb2ludC1vZi12aWV3Lg0KPg0KPlBsZWFzZSBjb3Jy
ZWN0IHRoZSBsaXR0bGUgdGhpbmdzIG5vdGVkIGJlZm9yZSwgcmUtc2VuZCBpbmRlcGVuZGVudGx5
IGFzIGEgdjMgYW5kDQo+d2UgYWxzbyBtYWtlIHN1cmUgdGhhdCB0aGluZ3MgYXJlIGdvb2Qgb24g
dGhlIHBoeSBzaWRlLg0KPg0KDQpUaGFuayB5b3UgZm9yIGNvbW1lbnRzLiBJIHdpbGwgbWFrZSBh
Ym92ZSBtZW50aW9uZWQgY2hhbmdlcyBhbmQgcmUtc2VuZCB0aGlzIA0KcGF0Y2ggaW5kZXBlbmRl
bnRseSBhcyBhIHYzLg0KDQo+QmVzdCByZWdhcmRzLA0KPi0tDQo+Tmljb2xhcyBGZXJyZQ0KDQpS
ZWdhcmRzLA0KUGFyc2h1cmFtIFRob21iYXJlDQo=
