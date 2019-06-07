Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7994EC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3798D2133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ceEsF/1Z";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="sQZYLrhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfFGEq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:59 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40228 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726714AbfFGEqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:50 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x574iXid026198;
        Thu, 6 Jun 2019 21:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9aQ5IavDC2UNFiSpKuTM72tD/DioC2PR3ZwcjZEmaLI=;
 b=ceEsF/1ZcSY9lyebhjf93eES9ocBfenVCpz/lsHGH0wfmYNSglXxzaVp/zm4a7gVFeAc
 IkdXQH4HZpjssSbIWRZDxNO0DYHdWkp/bfKnYVbhgP7AL03uNqyx6rTML701KoAXOO4U
 bUZ/mJZJQoNPKUZhAbv5secdZ4QZKe/j0KBZJWMiffhFg2RKjg9sJv9et3SiBR2afwF0
 mScFmuAqOUoRnR13aryvu72LZBQnBKWnuXY4JzKs0K6wMaPDLlff8j5sYHVbGsxxLbT4
 ZX88Hk3tEL9o8gDpC1dMAZNu3l+SFO0BXYgxuFA5ZHq3Q+UrTgDJpGoU2XF9d0nuzIYo xQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2sy5dd32a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jun 2019 21:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aQ5IavDC2UNFiSpKuTM72tD/DioC2PR3ZwcjZEmaLI=;
 b=sQZYLrhAlQbOysvcL+50LM0r9+f/z7rx8LELBgi6MZ5bGdDNkTrFLavv8PY7My+Np/g3mCCwM0zeaaISk0znsv2KIVSoZF26UllHuHj3cdevn/ww+MDptZylCLRZXRDtuVFv5e6gzed94hiOPk6sFrXkZIrWNBSFzc+S5eMbaOA=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5175.namprd07.prod.outlook.com (20.176.254.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 04:46:00 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 04:46:00 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHVG4YSLjJ8ECZT9ECicIdMOrgMB6aOii2AgAEH4iA=
Date:   Fri, 7 Jun 2019 04:46:00 +0000
Message-ID: <BYAPR07MB470903AF06C1F8A34BBB3C64DD100@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-2-git-send-email-pawell@cadence.com>
 <f032b3f3-409d-b0fc-8d5f-01c898b4c7a7@ti.com>
In-Reply-To: <f032b3f3-409d-b0fc-8d5f-01c898b4c7a7@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjM3MjI0OTAtODhkZi0xMWU5LTg3NDEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDIzNzIyNDkxLTg4ZGYtMTFlOS04NzQxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDk5MSIgdD0iMTMyMDQzNTYzNTc1NzI5MzkzIiBoPSI0dlNtcjd2UlNhbWpkbEJFQm9ET2dwWFJQNnc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e224a2a9-cc7a-4d68-1337-08d6eb030a37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR07MB5175;
x-ms-traffictypediagnostic: BYAPR07MB5175:
x-microsoft-antispam-prvs: <BYAPR07MB5175514974D514D2BD221550DD100@BYAPR07MB5175.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39850400004)(346002)(396003)(376002)(36092001)(189003)(199004)(26005)(6506007)(478600001)(71200400001)(99286004)(107886003)(102836004)(6246003)(14454004)(76176011)(186003)(68736007)(4326008)(66066001)(7416002)(74316002)(256004)(25786009)(8676002)(66476007)(66946007)(476003)(73956011)(110136005)(66446008)(64756008)(7696005)(33656002)(5660300002)(71190400001)(53936002)(2501003)(6116002)(55016002)(3846002)(9686003)(76116006)(52536014)(6436002)(229853002)(81156014)(8936002)(81166006)(446003)(316002)(305945005)(486006)(2906002)(7736002)(54906003)(86362001)(66556008)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5175;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CYA+8qFsyc0cIHEZiibZHwU47xYgnSDUe7ET+djQBH18BcxloGQF7VhljsVB4YVmdw14NbvaIVbfryHlKl03J1Q6IhtoymWi0LiPBKFHRRSHiety8I18F+YMSgciUDtz4f/vsFy6Z1KiAKxQOGLhfJKmX6ARqHR24Hph3modRDMkZHPbqusCHTkO8fO8GoLxoB15g9okZPWfNkv8Y8ouR89h3xwgwBSHNo2enQCTmItWTLkOqxBvg5JCd8LX0BrpJWiJGPDv+WveAnALhhOfXV+8ApqJg4Utp9XrJ6YbaOug6NUkf6aXW87ARJ6fkaWss+NN8pwjmAMpF0AECY2QGf7H5lq0YHXh8c4HIzf/QiRp980NX2ysSEHbeVy930yHVI2VSS5f3twRWoOh1bH4wb73EpCV4uinKOPhygdIVx0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e224a2a9-cc7a-4d68-1337-08d6eb030a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 04:46:00.6625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5175
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+DQo+UGF3ZWwsDQo+DQo+T24gMDUvMDYvMjAxOSAxMzowMywgUGF3ZWwgTGFzemN6YWsgd3Jv
dGU6DQo+PiBUaGlzIHBhdGNoIGFpbSBhdCBkb2N1bWVudGluZyBVU0IgcmVsYXRlZCBkdC1iaW5k
aW5ncyBmb3IgdGhlDQo+PiBDYWRlbmNlIFVTQlNTLURSRCBjb250cm9sbGVyLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+DQo+PiBSZXZp
ZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4+DQo+PiAtLS0NCj4+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvY2Rucy11c2IzLnR4dCAgICAgfCAzMCArKysrKysr
KysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9j
ZG5zLXVzYjMudHh0DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy91c2IvY2Rucy11c2IzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvY2Rucy11c2IzLnR4dA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uMWQyYjQ0OWUzY2I0DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NkbnMtdXNiMy50eHQNCj4+
IEBAIC0wLDAgKzEsMzAgQEANCj4+ICtCaW5kaW5nIGZvciB0aGUgQ2FkZW5jZSBVU0JTUy1EUkQg
Y29udHJvbGxlcg0KPj4gKw0KPj4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+PiArICAtIHJlZzog
UGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBjb250cm9sbGVyJ3MgcmVnaXN0
ZXIgYXJlYXMuDQo+PiArCSBDb250cm9sbGVyIGhhcyAzIGRpZmZlcmVudCByZWdpb25zOg0KPj4g
KwkgcmVnaW9uIDEgLSBIT1NUIHJlZ2lzdGVycyBhcmVhDQo+PiArCSByZWdpb24gMiAtIERFVklD
RSByZWdpc3RlcnMgYXJlYQ0KPj4gKwkgcmVnaW9uIDMgLSBPVEcvRFJEIHJlZ2lzdGVycyBhcmVh
DQo+PiArICAtIHJlZy1uYW1lcyAtIHJlZ2lzdGVyIG1lbW9yeSBhcmVhIG5hbWVzOg0KPj4gKwki
eGhjaSIgLSBmb3IgSE9TVCByZWdpc3RlcnMgc3BhY2UNCj4+ICsJImRldiIgLSBmb3IgREVWSUNF
IHJlZ2lzdGVycyBzcGFjZQ0KPj4gKwkib3RnIiAtIGZvciBPVEcvRFJEIHJlZ2lzdGVycyBzcGFj
ZQ0KPj4gKyAgLSBjb21wYXRpYmxlOiBTaG91bGQgY29udGFpbjogImNkbnMsdXNiMy0xLjAuMCIg
b3IgImNkbnMsdXNiMy0xLjAuMSINCj4+ICsgIC0gaW50ZXJydXB0czogSW50ZXJydXB0cyB1c2Vk
IGJ5IGNkbnMzIGNvbnRyb2xsZXIuDQo+DQo+U2luY2Ugd2UgYXJlIHJlcXVlc3RpbmcgMyBzZXBh
cmF0ZSBuYW1lZCBpbnRlcnJ1cHRzIGluIGNvZGUgd2UgbmVlZCB0bw0KPm1lbnRpb24gdGhlbSBo
ZXJlLg0KDQpIaSBSb2dlciwgDQoNClllcywgSSBrbm93LCBidXQgdGhpcyBjb2RlIGlzIFJldmll
d2VkLWJ5OiBSb2IgSGVycmluZywgc28gSSB0aG91Z2h0IHRvIGFkZCANCnRoaXMgYXMgc2VwYXJh
dGUgcGF0Y2ggYWZ0ZXIgcHV0dGluZyB0aGlzIGRyaXZlciBpbnRvIGtlcm5lbC4NCg0KSSBhc3N1
bWUgdGhhdCBhZnRlciBtYWtpbmcgc29tZSBjaGFuZ2UgaW4gdGhpcyBmaWxlIEkgc2hvdWxkIHJl
bW92ZSBzdGF0ZW1lbnQNClJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PiBmcm9tIHRoaXMgcGF0Y2ggdG8gc3RhcnQgcmV2aXZpbmcgDQpmcm9tIHRoZSBiZWdpbm5pbmcu
ICANCg0KV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgc3VjaCBkdC1iaW5kaW5nOg0KDQpSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KICAtIHJlZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBzaXplIG9m
IHRoZSBjb250cm9sbGVyJ3MgcmVnaXN0ZXIgYXJlYXMuDQogICAgICAgICBDb250cm9sbGVyIGhh
cyAzIGRpZmZlcmVudCByZWdpb25zOg0KICAgICAgICAgcmVnaW9uIDEgLSBIT1NUIHJlZ2lzdGVy
cyBhcmVhDQogICAgICAgICByZWdpb24gMiAtIERFVklDRSByZWdpc3RlcnMgYXJlYQ0KICAgICAg
ICAgcmVnaW9uIDMgLSBPVEcvRFJEIHJlZ2lzdGVycyBhcmVhDQogIC0gcmVnLW5hbWVzIC0gcmVn
aXN0ZXIgbWVtb3J5IGFyZWEgbmFtZXM6DQogICAgICAgICJ4aGNpIiAtIGZvciBIT1NUIHJlZ2lz
dGVycyBzcGFjZQ0KICAgICAgICAiZGV2IiAtIGZvciBERVZJQ0UgcmVnaXN0ZXJzIHNwYWNlDQog
ICAgICAgICJvdGciIC0gZm9yIE9URy9EUkQgcmVnaXN0ZXJzIHNwYWNlDQogIC0gY29tcGF0aWJs
ZTogU2hvdWxkIGNvbnRhaW46DQogICAgICAgICJjZG5zLHVzYjMtMS4wLjAiIC0gZm9yIDB4MDAw
MjQ1MDIgY29udHJvbGxlciB2ZXJzaW9uDQogICAgICAgICJjZG5zLHVzYjMtMS4wLjEiIC0gZm9y
IDB4MDAwMjQ1MDkgY29udHJvbGxlciB2ZXJzaW9uDQogICAgICAgICJjZG5zLHVzYjMtMS4wLjIi
IC0gZm9yIDB4MDAwMjQ1MEMgY29udHJvbGxlciB2ZXJzaW9uDQogICAgICAgICJjZG5zLHVzYjMt
MS4wLjMiIC0gZm9yIDB4MDAwMjQ1MGQgY29udHJvbGxlciB2ZXJzaW9uDQoNCi0gaW50ZXJydXB0
czogSW50ZXJydXB0cyB1c2VkIGJ5IGNkbnMzIGNvbnRyb2xsZXI6DQogICAgICAgICJob3N0IiAt
IGludGVycnVwdCB1c2VkIGJ5IFhIQ0kgZHJpdmVyLg0KICAgICAgICAicGVyaXBoZXJhbCIgLSBp
bnRlcnJ1cHQgdXNlZCBieSBkZXZpY2UgZHJpdmVyDQogICAgICAgICJvdGciIC0gaW50ZXJydXB0
IHVzZWQgYnkgRFJEL09URyAgcGFydCBvZiBkcml2ZXINCg0KT3B0aW9uYWwgcHJvcGVydGllczoN
CiAtIG1heGltdW0tc3BlZWQgOiB2YWxpZCBhcmd1bWVudHMgYXJlICJzdXBlci1zcGVlZCIsICJo
aWdoLXNwZWVkIiBhbmQNCiAgICAgICAgICAgICAgICAgICAiZnVsbC1zcGVlZCI7IHJlZmVyIHRv
IHVzYi9nZW5lcmljLnR4dA0KIC0gZHJfbW9kZTogU2hvdWxkIGJlIG9uZSBvZiAiaG9zdCIsICJw
ZXJpcGhlcmFsIiBvciAib3RnIi4NCiAtIHBoeXM6IHJlZmVyZW5jZSB0byB0aGUgVVNCIFBIWQ0K
IC0gb24tY2hpcC1idWZmLXNpemUgOiBzaXplIG9mIG1lbW9yeSBpbnRlbmRlZCBhcyBpbnRlcm5h
bCBtZW1vcnkgZm9yIGVuZHBvaW50cw0KICAgICAgICBidWZmZXJzIGV4cHJlc3NlZCBpbiBLQg0K
DQpFeGFtcGxlOg0KICAgICAgICB1c2JAZjMwMDAwMDAgew0KICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAiY2Rucyx1c2IzLTEuMC4xIjsNCiAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0g
PFVTQl9IT1NUX0lSUSAgNyBJUlFfVFlQRV9MRVZFTF9ISUdIPg0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA8VVNCX0RFVklDRV9JUlEgIDcgSVJRX1RZUEVfTEVWRUxfSElHSD4NCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPFVTQl9PVEdfSVJRICA4IElSUV9UWVBFX0xF
VkVMX0hJR0g+Ow0KICAgICAgICAgICAgICAgIGludGVycnVwdC1uYW1lcyA9ICJob3N0IiwgInBl
cmlwaGVyYWwiLCAib3RnIjsNCiAgICAgICAgICAgICAgICByZWcgPSA8MHhmMzAwMDAwMCAweDEw
MDAwICAgICAgIC8qIG1lbW9yeSBhcmVhIGZvciBIT1NUIHJlZ2lzdGVycyAqLw0KICAgICAgICAg
ICAgICAgICAgICAgICAgMHhmMzAxMDAwMCAweDEwMDAwICAgICAgLyogbWVtb3J5IGFyZWEgZm9y
IERFVklDRSByZWdpc3RlcnMgKi8NCiAgICAgICAgICAgICAgICAgICAgICAgIDB4ZjMwMjAwMDAg
MHgxMDAwMD47ICAgIC8qIG1lbW9yeSBhcmVhIGZvciBPVEcvRFJEIHJlZ2lzdGVycyAqLw0KICAg
ICAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJ4aGNpIiwgImRldiIsICJvdGciOw0KICAgICAgICB9
Ow0KDQpJcyB0aGlzIGNvcnJlY3Qgbm93ID8NCg0KTWF5YmUgSSBzaG91bGQgYWRkIHNvbWV0aGlu
ZyBhZGRpdGlvbmFsbHkgZm9yIHBoeSA/DQoNClJlZ2FyZHMsDQpQYXdlbA0KDQogIA0KPg0KPj4g
Kw0KPj4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+PiArIC0gbWF4aW11bS1zcGVlZCA6IHZhbGlk
IGFyZ3VtZW50cyBhcmUgInN1cGVyLXNwZWVkIiwgImhpZ2gtc3BlZWQiIGFuZA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAiZnVsbC1zcGVlZCI7IHJlZmVyIHRvIHVzYi9nZW5lcmljLnR4dA0KPj4g
KyAtIGRyX21vZGU6IFNob3VsZCBiZSBvbmUgb2YgImhvc3QiLCAicGVyaXBoZXJhbCIgb3IgIm90
ZyIuDQo+PiArIC0gcGh5czogcmVmZXJlbmNlIHRvIHRoZSBVU0IgUEhZDQo+PiArDQo+PiArRXhh
bXBsZToNCj4+ICsJdXNiQGYzMDAwMDAwIHsNCj4+ICsJCWNvbXBhdGlibGUgPSAiY2Rucyx1c2Iz
LTEuMC4xIjsNCj4+ICsJCWludGVycnVwdHMgPSA8VVNCX0lSUSAgNyBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsNCj4NCj5UaGlzIGV4YW1wbGUgd29uJ3Qgd29yayBhcyBjb2RlIHJlcXVlc3RzIGZvciAz
IHNlcGFyYXRlIGludGVycnVwdHMuDQo+DQo+PiArCQlyZWcgPSA8MHhmMzAwMDAwMCAweDEwMDAw
CS8qIG1lbW9yeSBhcmVhIGZvciBIT1NUIHJlZ2lzdGVycyAqLw0KPj4gKwkJCTB4ZjMwMTAwMDAg
MHgxMDAwMAkvKiBtZW1vcnkgYXJlYSBmb3IgREVWSUNFIHJlZ2lzdGVycyAqLw0KPj4gKwkJCTB4
ZjMwMjAwMDAgMHgxMDAwMD47CS8qIG1lbW9yeSBhcmVhIGZvciBPVEcvRFJEIHJlZ2lzdGVycyAq
Lw0KPj4gKwkJcmVnLW5hbWVzID0gInhoY2kiLCAiZGV2IiwgIm90ZyI7DQo+PiArCX07DQo+Pg0K
Pg0KPi0tDQo+Y2hlZXJzLA0KPi1yb2dlcg0KPg0KPlRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQg
T3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLg0KPlktdHVubnVzL0J1c2luZXNz
IElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
