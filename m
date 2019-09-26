Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4D1C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0861206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="tV2gii4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393180AbfIZGh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:37:56 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:29754 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388934AbfIZGhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:37:55 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8Q6Wjdl028027;
        Thu, 26 Sep 2019 02:37:26 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku6tmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 02:37:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRYZSGfppIjX55u4cuYahaRKNewKu8/uJ+v6S/RVX6p0HWDqzDZfZxy0HMXj0zi1JezWN179MzYJqdnyOrhHDG8YMmLksZYBaNhSzHx08OJH6SxQ/By84LQujh31MN1vJ4QFBH3kgLEBBNnN/vyFyG5EjYamsgRrjksSYnsQzWgwoUuKsQMoE3xvnvx6QMFOyNcrwyIfjAYhmPjJmeJfwSsSWLtqDki8Hh/PBjkgx8Img4OLQvJbWnYKzLIOOCS2S8BpH9SejsLuvTj6KBYfObfw1eiddW9/KyX3h/mFnWBrlD+XwIUT4beclMgiosDcaVms4OAkzGTHq6bKR+fnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7Al48ngK5LbGh5I1oBglufmugHCDj2MABdEpLBNy08=;
 b=KRN5z4PUlN968z81rQgXFE5gzq5ylAa7YNBExJKx1aIL5Y5Nc9dyO0RLRyeTal7I3ThGet3czvNqEL60/FmegtvkYKIOZq1/lyvpMxW0qXSjEpC4Ti0aq9YvTGnZDPSQTi2dz0eOugeIwUSVy17dGd1KtDrnQwfrXJB1Fq5dfLQCbiD2ai0+mPYov/z+Kv/1tud12VA9GPm4zImwfQkIj+VKUm2NoySCEYlbZr2Msn/wKDQZrzqbOJzvRF7o0fWsUMdi70SnR/YDXm89lLirJ/oa+rZXzxuKB1uQhH4SkPC0HcSAYseJoLFxCMBi5s2mYGZThHSbmhwYbWcJvhn3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7Al48ngK5LbGh5I1oBglufmugHCDj2MABdEpLBNy08=;
 b=tV2gii4KNfXRd6cr35n4Hh2S1e4y/qV0vXtArVYONS1ydyha41PMuklNyR3YgGeISsnoBJwvKiTqFTE65WUoPs7NzSN+dnKwfSzb/IhV6Ohfg1AzujurOS79RQdyn/Jv3M1vVo/vLVG1dm6iqkJp57ssfIsYaPdbPqJqyGyxL5g=
Received: from MN2PR03MB5200.namprd03.prod.outlook.com (10.186.144.199) by
 MN2PR03MB5165.namprd03.prod.outlook.com (10.186.145.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 06:37:24 +0000
Received: from MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::ec7e:6072:f008:1406]) by MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::ec7e:6072:f008:1406%3]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 06:37:24 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "aford173@gmail.com" <aford173@gmail.com>,
        "philipp.puschmann@emlix.com" <philipp.puschmann@emlix.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "fugang.duan@nxp.com" <fugang.duan@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
Thread-Topic: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
Thread-Index: AQHVc7Pyon1UJp4qYUCz9u18XQgc86c9gksA
Date:   Thu, 26 Sep 2019 06:37:24 +0000
Message-ID: <15be848facd5e80222e5db30c61fe72f82a85713.camel@analog.com>
References: <20190919145114.13006-1-philipp.puschmann@emlix.com>
         <VI1PR0402MB3600CA068AEBAC63D3CE6A4CFF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
         <ac67f010-1b2c-6996-f542-ab955ca86489@emlix.com>
         <CAHCN7xL0BKmt8xrhuB4rrvOqkCM5AUJ6YAzbcU8eNDXbzj4fZg@mail.gmail.com>
In-Reply-To: <CAHCN7xL0BKmt8xrhuB4rrvOqkCM5AUJ6YAzbcU8eNDXbzj4fZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b29ce82-c511-4a9a-ff52-08d7424bfde7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR03MB5165;
x-ms-traffictypediagnostic: MN2PR03MB5165:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR03MB516587D444AF7C3BD4DEE52DF9860@MN2PR03MB5165.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(51914003)(54534003)(189003)(199004)(36756003)(99286004)(6116002)(8676002)(3846002)(76116006)(91956017)(7736002)(305945005)(118296001)(76176011)(54906003)(14454004)(5660300002)(2906002)(110136005)(81166006)(316002)(81156014)(71190400001)(966005)(256004)(14444005)(66476007)(66946007)(71200400001)(66446008)(64756008)(66556008)(102836004)(8936002)(11346002)(2616005)(4326008)(186003)(86362001)(66066001)(6486002)(6436002)(476003)(6506007)(7416002)(26005)(229853002)(6306002)(2501003)(446003)(53546011)(6512007)(486006)(478600001)(6246003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5165;H:MN2PR03MB5200.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z+XHWqkv7oj0nINpIbXcvEdyXWVPb5MGhebBRSG6z7uBZSlwI2Sr9977vuU7xQ60Btei5Nrl4/siy9uOUAl4EePHLEBkAGuxqdUvecsOhAn0+0RnDl1afzv6/KX9aVqY4/rEBokRKF+myoHdKyFlRi3cnUoXMlbvuiK/Rur60GRovB7t4mSKSMn3hlFEOdEgVke/dqGHvzibX+J/gYGO1+KVeEjx3gBiQC/Zljr4WjMDH6kJ/usmzJR914hzpHsLgDpRmXgZFO2wMHgymik9LMPBpGITVY3Xc7xZNqT8tcv5LvpG2zfpOBe2GHDF7ZAVWDkC+4Rd8nnOIJ0d3kpj2AmdWqIbtXbPy+IacgRTJa/zB4Z1sg5XFpIIYUCMWLgww6Ui831FscmBp0CvERovvr5lPEIYFk7L3RZ1CbWalknPwoZI/KArOD2eddZ70xjYkiqabaaepxYd/7VpBd0XoQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B1FC44150C12F4780866DD289A67B7E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b29ce82-c511-4a9a-ff52-08d7424bfde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 06:37:24.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6QuPDr6SRrEvF4vBGQi6IgfbYOuh5r45f0exYGqhWCJviLRnnAN5dhH9CSdCcGWyDstAHw/o+WJ31wzx9y6XzWqEWu5N8lxcBAS+MCPCX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5165
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_02:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA5LTI1IGF0IDEwOjE0IC0wNTAwLCBBZGFtIEZvcmQgd3JvdGU6DQo+IFtF
eHRlcm5hbF0NCj4gDQo+IE9uIEZyaSwgU2VwIDIwLCAyMDE5IGF0IDI6MDYgQU0gUGhpbGlwcCBQ
dXNjaG1hbm4NCj4gPHBoaWxpcHAucHVzY2htYW5uQGVtbGl4LmNvbT4gd3JvdGU6DQo+ID4gSGkg
QW5keSwNCj4gPiANCj4gPiBBbSAyMC4wOS4xOSB1bSAwNTo0MiBzY2hyaWViIEFuZHkgRHVhbjoN
Cj4gPiA+IEZyb206IFBoaWxpcHAgUHVzY2htYW5uIDxwaGlsaXBwLnB1c2NobWFubkBlbWxpeC5j
b20+IFNlbnQ6IFRodXJzZGF5LA0KPiA+ID4gU2VwdGVtYmVyIDE5LCAyMDE5IDEwOjUxIFBNDQo+
ID4gPiA+IFVzaW5nIG9ubHkgNCBETUEgcGVyaW9kcyBmb3IgVUFSVCBSWCBpcyB2ZXJ5IGZldyBp
ZiB3ZSBoYXZlIGEgaGlnaA0KPiA+ID4gPiBmcmVxdWVuY3kNCj4gPiA+ID4gb2Ygc21hbGwgdHJh
bnNmZXJzIC0gbGlrZSBpbiBvdXIgY2FzZSB1c2luZyBCbHVldG9vdGggd2l0aCBtYW55DQo+ID4g
PiA+IHNtYWxsIHBhY2tldHMNCj4gPiA+ID4gdmlhIFVBUlQgLSBjYXVzaW5nIG1hbnkgZG1hIHRy
YW5zZmVycyBidXQgaW4gZWFjaCBvbmx5IGZpbGxpbmcgYQ0KPiA+ID4gPiBmcmFjdGlvbiBvZiBh
DQo+ID4gPiA+IHNpbmdsZSBidWZmZXIuIFN1Y2ggYSBjYXNlIG1heSBsZWFkIHRvIHRoZSBzaXR1
YXRpb24gdGhhdCBETUEgUlgNCj4gPiA+ID4gdHJhbnNmZXIgaXMNCj4gPiA+ID4gdHJpZ2dlcmVk
IGJ1dCBubyBmcmVlIGJ1ZmZlciBpcyBhdmFpbGFibGUuIFdoZW4gdGhpcyBoYXBwZW5zIGRtYQ0K
PiA+ID4gPiBjaGFubmVsIGlzdA0KPiA+ID4gPiBzdG9wcGVkIC0gd2l0aCB0aGUgcGF0Y2gNCj4g
PiA+ID4gImRtYWVuZ2luZTogaW14LXNkbWE6IGZpeCBkbWEgZnJlZXplcyIgdGVtcG9yYXJpbHkg
b25seSAtIHdpdGggdGhlDQo+ID4gPiA+IHBvc3NpYmxlDQo+ID4gPiA+IGNvbnNlcXVlbmNlcyB0
aGF0Og0KPiANCj4gSSBoYXZlIGFuIGkuTVg2USB3aXRoIFdsMTgzN01PRCBvbiBVQVJUIDIgd2l0
aCBmbG93IGNvbnRyb2wsIGFuZCBJIGFtDQo+IGdldHRpbmcgQmx1ZXRvb3RoIHRyYW5zZmVyIHRp
bWVvdXRzLg0KPiAoc2VlIGlteDYtbG9naWNwZC1zb20uZHRzaSkNCj4gDQo+IE9uIHRvcCBvZiA1
LjMuMSwgSSBoYXZlIGluc3RhbGxlZDoNCj4gDQo+IGRtYWVuZ2luZTogaW14LXNkbWE6IGZpeCBi
dWZmZXIgb3duZXJzaGlwDQo+IGRtYWVuZ2luZTogaW14LXNkbWE6IGZpeCBkbWEgZnJlZXplcw0K
PiBkbWFlbmdpbmU6IGlteC1zZG1hOiBkcm9wIHJlZHVuZGFudCB2YXJpYWJsZQ0KPiBkbWFlbmdp
bmU6IGlteC1zZG1hOiBmaXgga2VybmVsIGhhbmdzIHdpdGggU0xVQiBzbGFiIGFsbG9jYXRvcg0K
PiBzZXJpYWw6IGlteDogYWRhcHQgcnggYnVmZmVyIGFuZCBkbWEgcGVyaW9kcw0KPiANCj4gYW5k
IEkgc3RpbGwgZ2V0IHRpbWVvdXRzOg0KPiANCj4gWyAgIDY2LjYzMjAwNl0gQmx1ZXRvb3RoOiBo
Y2kwOiBjb21tYW5kIDB4ZmYzNiB0eCB0aW1lb3V0DQo+IFsgICA3Ni43OTA0OTldIEJsdWV0b290
aDogaGNpMDogY29tbWFuZCAweDEwMDEgdHggdGltZW91dA0KPiBbICAgODcuMTEwNDg4XSBCbHVl
dG9vdGg6IGhjaTA6IGNvbW1hbmQgMHhmZjM2IHR4IHRpbWVvdXQNCj4gWyAgIDk3LjI3MDUwN10g
Qmx1ZXRvb3RoOiBoY2kwOiBjb21tYW5kIDB4MTAwMSB0eCB0aW1lb3V0DQo+IFsgIDEwNy41OTA0
NTddIEJsdWV0b290aDogaGNpMDogY29tbWFuZCAweGZmMzYgdHggdGltZW91dA0KPiBbICAxMTcu
NzUwNDc3XSBCbHVldG9vdGg6IGhjaTA6IGNvbW1hbmQgMHgxMDAxIHR4IHRpbWVvdXQNCj4gWyAg
MjI2LjM5MDQ5OV0gQmx1ZXRvb3RoOiBoY2kwOiBjb21tYW5kIDB4ZmUzOCB0eCB0aW1lb3V0DQo+
IFsgIDIzMS41OTA3MzVdIEJsdWV0b290aDogaGNpMDogY29tbWFuZCB0eCB0aW1lb3V0DQo+IA0K
PiBJIGRpZCBhIGJpc2VjdCBhbmQgZm91bmQgdGhlIHN0YXJ0IG9mIG15IHByb2JsZW1zIGNhbWUg
ZnJvbQ0KPiANCj4gMzYxZGViNzI0M2QyICgiZG1hZW5naW5lOiBkbWF0ZXN0OiB3cmFwIHNyYyAm
IGRzdCBkYXRhIGludG8gYSBzdHJ1Y3QiKQ0KDQpUaGF0IGNvbW1pdCBvbmx5IHRvdWNoZXMgYGRy
aXZlcnMvZG1hL2RtYXRlc3QuY2AgDQpBcmUgeW91IHVzaW5nIHRoYXQgbW9kdWxlPw0KDQpJdCdz
IGEgInVuaXQtdGVzdCIgbW9kdWxlIGZvciB0ZXN0aW5nIERNQWVuZ2luZSBkcml2ZXJzLg0KVGhl
IG9ubHkgd2F5IHRoYXQgY2FuIGJyZWFrIGFueXRoaW5nIFtmcm9tIHdoYXQgSSBjYW4gdGVsbF0s
IGlzIGlmIGl0IGlzDQpiZWluZyBydW4uIEl0IHdpbGwgcHJvYmFibHkgcHV0IHRoZSBETUEgaW50
byBhIHdlaXJkIHN0YXRlIChpdCBpcyBhIHRlc3QtDQptb2R1bGUgYWZ0ZXItYWxsKSwgYW5kIGl0
IG1heSByZXF1aXJlIHNvbWUgRE1BcyB0byBiZSByZXNldC4NCkkgYWRtaXQgaXQgd291bGQgYmUg
bmljZSB0aGF0IHRoZSB0ZXN0LW1vZHVsZSB3b3VsZCBwdXQgdGhlIERNQSBiYWNrIGludG8gYQ0K
bm9ybWFsLXdvcmtpbmcgc3RhdGUsIGJ1dCB0aGF0IGVmZm9ydCBjb3VsZCBiZSBiaWcgZm9yIHNv
bWUgY2FzZXMuDQoNCg0KPiANCj4gVGhpcyBoYXBwZW5lZCBzb21ldGltZSBiZXR3ZWVuIHY1LjAg
YW5kIHY1LjENCj4gDQo+IElzIHRoZXJlIGEgcGF0Y2ggSSBtaXNzZWQgc29tZXdoZXJlPyAgRG8g
SSBuZWVkIHRvIGNoYW5nZSBteSBkZXZpY2UNCj4gdHJlZSBjb25maWd1cmF0aW9uIHNvbWVob3cg
dG8gYWxsb2NhdGUgdGhlIHByb3BlciBETUEgbWVtb3J5Pw0KPiANCj4gDQo+IA0KPiA+ID4gPiB3
aXRoIGRpc2FibGVkIGh3IGZsb3cgY29udHJvbDoNCj4gPiA+ID4gICBJZiBlbm91Z2ggZGF0YSBp
cyBpbmNvbWluZyBvbiBVQVJUIHBvcnQgdGhlIFJYIEZJRk8gcnVucyBvdmVyIGFuZA0KPiA+ID4g
PiAgIGNoYXJhY3RlcnMgd2lsbCBiZSBsb3N0LiBXaGF0IHRoZW4gaGFwcGVucyBkZXBlbmRzIG9u
IHVwcGVyDQo+ID4gPiA+IGxheWVyLg0KPiA+ID4gPiANCj4gPiA+ID4gd2l0aCBlbmFibGVkIGh3
IGZsb3cgY29udHJvbDoNCj4gPiA+ID4gICBJZiBlbm91Z2ggZGF0YSBpcyBpbmNvbWluZyBvbiBV
QVJUIHBvcnQgdGhlIFJYIEZJRk8gcmVhY2hlcyBhDQo+ID4gPiA+IGxldmVsDQo+ID4gPiA+ICAg
d2hlcmUgQ1RTIGlzIGRlYXNzZXJ0ZWQgYW5kIHJlbW90ZSBkZXZpY2Ugc2VuZGluZyB0aGUgZGF0
YSBzdG9wcy4NCj4gPiA+ID4gICBJZiBpdCBmYWlscyB0byBzdG9wIHRpbWVseSB0aGUgaS5NWCcg
UlggRklGTyBtYXkgcnVuIG92ZXIgYW5kDQo+ID4gPiA+IGRhdGENCj4gPiA+ID4gICBnZXQgbG9z
dC4gT3RoZXJ3aXNlIGl0J3MgaW50ZXJuYWwgVFggYnVmZmVyIG1heSBnZXR0aW5nIGZpbGxlZCB0
bw0KPiA+ID4gPiAgIGEgcG9pbnQgd2hlcmUgaXQgcnVucyBvdmVyIGFuZCBkYXRhIGlzIGFnYWlu
IGxvc3QuIEl0IGRlcGVuZHMgb24NCj4gPiA+ID4gICB0aGUgcmVtb3RlIGRldmljZSBob3cgdGhp
cyBjYXNlIGlzIGhhbmRsZWQgYW5kIGlmIGl0IGlzDQo+ID4gPiA+IHJlY292ZXJhYmxlLg0KPiA+
ID4gPiANCj4gPiA+ID4gT2J2aW91c2x5IHdlIHdhbnQgdG8gYXZvaWQgaGF2aW5nIG5vIGZyZWUg
YnVmZmVycyBhdmFpbGFibGUuIFNvIHdlDQo+ID4gPiA+IGRlY3JlYXNlDQo+ID4gPiA+IHRoZSBz
aXplIG9mIHRoZSBidWZmZXJzIGFuZCBpbmNyZWFzZSB0aGVpciBudW1iZXIgYW5kIHRoZSB0b3Rh
bA0KPiA+ID4gPiBidWZmZXIgc2l6ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHAgUHVzY2htYW5uIDxwaGlsaXBwLnB1c2NobWFubkBlbWxpeC5jb20+DQo+ID4gPiA+
IFJldmlld2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gPiA+
ID4gLS0tDQo+ID4gPiA+IA0KPiA+ID4gPiBDaGFuZ2Vsb2cgdjM6DQo+ID4gPiA+ICAtIGVuaGFu
Y2UgZGVzY3JpcHRpb24NCj4gPiA+ID4gDQo+ID4gPiA+IENoYW5nZWxvZyB2MjoNCj4gPiA+ID4g
IC0gc3BsaXQgdGhpcyBwYXRjaCBmcm9tIHNlcmllcyAiRml4IFVBUlQgRE1BIGZyZWV6ZXMgZm9y
IGlNWDYiDQo+ID4gPiA+ICAtIGFkZCBSZXZpZXdlZC1ieSB0YWcNCj4gPiA+ID4gDQo+ID4gPiA+
ICBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgfCA1ICsrLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC9pbXguYw0KPiA+ID4gPiBpbmRleA0KPiA+ID4gPiA4N2M1OGY5ZjYzOTAuLjUxZGMxOTgzM2Vh
YiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQo+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYw0KPiA+ID4gPiBAQCAtMTAzNCw4ICsxMDM0
LDYgQEAgc3RhdGljIHZvaWQgaW14X3VhcnRfdGltZW91dChzdHJ1Y3QNCj4gPiA+ID4gdGltZXJf
bGlzdCAqdCkNCj4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+ICB9DQo+ID4gPiA+IA0KPiA+ID4g
PiAtI2RlZmluZSBSWF9CVUZfU0laRSAgICAoUEFHRV9TSVpFKQ0KPiA+ID4gPiAtDQo+ID4gPiA+
ICAvKg0KPiA+ID4gPiAgICogVGhlcmUgYXJlIHR3byBraW5kcyBvZiBSWCBETUEgaW50ZXJydXB0
cyhzdWNoIGFzIGluIHRoZSBNWDZRKToNCj4gPiA+ID4gICAqICAgWzFdIHRoZSBSWCBETUEgYnVm
ZmVyIGlzIGZ1bGwuDQo+ID4gPiA+IEBAIC0xMTE4LDcgKzExMTYsOCBAQCBzdGF0aWMgdm9pZCBp
bXhfdWFydF9kbWFfcnhfY2FsbGJhY2sodm9pZA0KPiA+ID4gPiAqZGF0YSkgIH0NCj4gPiA+ID4g
DQo+ID4gPiA+ICAvKiBSWCBETUEgYnVmZmVyIHBlcmlvZHMgKi8NCj4gPiA+ID4gLSNkZWZpbmUg
UlhfRE1BX1BFUklPRFMgNA0KPiA+ID4gPiArI2RlZmluZSBSWF9ETUFfUEVSSU9EUyAxNg0KPiA+
ID4gPiArI2RlZmluZSBSWF9CVUZfU0laRSAgICAoUEFHRV9TSVpFIC8gNCkNCj4gPiA+ID4gDQo+
ID4gPiBXaHkgdG8gZGVjcmVhc2UgdGhlIERNQSBSWCBidWZmZXIgc2l6ZSBoZXJlID8NCj4gPiA+
IA0KPiA+ID4gVGhlIGN1cnJlbnQgRE1BIGltcGxlbWVudGF0aW9uIHN1cHBvcnQgRE1BIGN5Y2xp
YyBtb2RlLCBvbmUgU0RNQSBCRA0KPiA+ID4gcmVjZWl2ZSBvbmUgQmx1ZXRvb3RoIGZyYW1lIGNh
bg0KPiA+ID4gYnJpbmcgYmV0dGVyIHBlcmZvcm1hbmNlLg0KPiA+ID4gQXMgeW91IGtub3csIGZv
ciBMMkNBUCwgYSBtYXhpbXVtIHRyYW5zbWlzc2lvbiB1bml0IChNVFUpIGFzc29jaWF0ZWQNCj4g
PiA+IHdpdGggdGhlIGxhcmdlc3QgQmFzZWJhbmQgcGF5bG9hZA0KPiA+ID4gaXMgMzQxIGJ5dGVz
IGZvciBESDUgcGFja2V0cy4NCj4gPiA+IA0KPiA+ID4gU28gSSBzdWdnZXN0IHRvIGluY3JlYXNl
IFJYX0JVRl9TSVpFIGFsb25nIHdpdGggUlhfRE1BX1BFUklPRFMgdG8NCj4gPiA+IGZlYXNpYmxl
IHZhbHVlLg0KPiA+IA0KPiA+IEkgZGVidWdnZWQgYW5kIGRldmVsb3BlZCB0aGlzIHBhdGNoZXMg
b24gYSBzeXN0ZW0gd2l0aCBhIDQuMTUga2VybmVsLg0KPiA+IFdoZW4gcHJlcGFyZWQgZm9yIHVw
c3RyZWFtIGkgaGF2ZSBhZGFwdGVkDQo+ID4gc29tZSBkZXRhaWxzIGFuZCBtaXNzZWQgYSBpbXBv
cnRhbnQgdGhpbmcgaGVyZS4gSXQgc2hvdWxkIHNheToNCj4gPiANCj4gPiArI2RlZmluZSBSWF9C
VUZfU0laRSAgICAoUlhfRE1BX1BFUklPRFMgKiBQQUdFX1NJWkUgLyA0KQ0KPiA+IA0KPiA+IFll
cywgaSB3YW50ZWQgdG8gaW5jcmVhc2UgdGhlIHRvdGFsIGJ1ZmZlciBzaXplIHRvbywgZXZlbiB3
cm90ZSBpdCBpbg0KPiA+IHRoZSBkZXNjcmlwdGlvbi4NCj4gPiBJIHdpbGwgcHJlcGFyZSBhIHZl
cnNpb24gNCwgdGhhbmtzIGZvciB0aGUgaGludC4NCj4gPiANCj4gPiBKdXN0IGZvciBpbmZvOiBB
IHNpbmdsZSBSWCBETUEgcGVyaW9kIGFrYSBidWZmZXIgY2FuIGJlIGZpbGxlZCB3aXRoDQo+ID4g
bXV0bGlwbGUgcGFja2V0cyBpbiByZWdhcmQgb2YgdGhlIHVwcGVyIGxheWVyLCBoZXJlIEJULg0K
PiA+IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gUGhpbGlwcA0KPiA+ID4gQW5keQ0KPiA+ID4g
DQo+ID4gPiA+ICBzdGF0aWMgaW50IGlteF91YXJ0X3N0YXJ0X3J4X2RtYShzdHJ1Y3QgaW14X3Bv
cnQgKnNwb3J0KSAgew0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjIzLjANCj4gPiANCj4gPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsDQo=
