Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC5EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3362020821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EMElRd2h";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KFH5OVmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfDPIoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:44:05 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:45346 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbfDPIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:44:04 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3G8gVmk018795;
        Tue, 16 Apr 2019 01:43:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=c8ij8g7RCF+CvaeHCkdbcsRhw+MJGIN8/utbgDCKzWM=;
 b=EMElRd2hImstDA9hk481c7wVOs/wEw4B8EGq23KcNwwD25CDBZmz22Dk43I+nKLFpfAY
 YArkksmlDFmQ9RwEWNUYyxH9onWLstSls5relinReogCQ/IRG3fK89tyXRF6rn4xU95I
 5tbDGnJoFoaLCBEHzc/BQ5Y6qS29+MKZpYKhC5JH5ZNWlEBjY3dOPtIqKMhc4w+4Yodl
 e0ff0Vps3Vti+sdPqI4V4xQeWP3jkAaBULiFMYouhDDUDfs40psn42LBGkda5IY76Sdu
 YW82KfVAvxCqjUlkOZy84FLFo+1d2I/DOucT+royiyX3Y0+wPlM5FDNSp2D2X7NMkqCj Uw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rwbf684cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Apr 2019 01:43:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8ij8g7RCF+CvaeHCkdbcsRhw+MJGIN8/utbgDCKzWM=;
 b=KFH5OVmfeC3DGIVq1J+w20DW1fHjga260zmG1zs8Hx3G1zDlHWbr2g667Vjs0RzeyshW2Ez0Isex31C+P9SYSxyk3nMkHVeKtDvacfkkWFPVJQJXPRaCBMVIUAYTpcddAyeTZq6gcvpwIj/m5n9Xz6NVp/JY6K801Hhf0PwPljU=
Received: from CY1PR07MB2521.namprd07.prod.outlook.com (10.167.16.12) by
 CY1PR07MB2603.namprd07.prod.outlook.com (10.167.16.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Tue, 16 Apr 2019 08:43:53 +0000
Received: from CY1PR07MB2521.namprd07.prod.outlook.com
 ([fe80::71b2:7651:1d16:505f]) by CY1PR07MB2521.namprd07.prod.outlook.com
 ([fe80::71b2:7651:1d16:505f%9]) with mapi id 15.20.1813.011; Tue, 16 Apr 2019
 08:43:53 +0000
From:   Jan Kotas <jank@cadence.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Jan Kotas <jank@cadence.com>,
        "sanyog.r.kale@intel.com" <sanyog.r.kale@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] soundwire: cdns: Fix compilation error on
 arm64
Thread-Topic: [alsa-devel] [PATCH] soundwire: cdns: Fix compilation error on
 arm64
Thread-Index: AQHU6r4tHXqRN20fiUK52juZz07+36Y7d7kAgAHD54CAAU/GAA==
Date:   Tue, 16 Apr 2019 08:43:53 +0000
Message-ID: <F63978EE-8D0E-446C-BDAB-48B7F5FF7D82@global.cadence.com>
References: <20190404081221.341-1-jank@cadence.com>
 <20190414094408.GF28103@vkoul-mobl>
 <8ba31402-b507-5060-76be-89a7ddaf7dca@linux.intel.com>
In-Reply-To: <8ba31402-b507-5060-76be-89a7ddaf7dca@linux.intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 142ea2f5-17e2-405f-b955-08d6c247a7dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY1PR07MB2603;
x-ms-traffictypediagnostic: CY1PR07MB2603:
x-microsoft-antispam-prvs: <CY1PR07MB2603EF98B73AA06718881FF7D0240@CY1PR07MB2603.namprd07.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39850400004)(396003)(136003)(366004)(189003)(36092001)(199004)(186003)(53546011)(316002)(229853002)(76176011)(6506007)(26005)(54906003)(25786009)(53936002)(5660300002)(6486002)(6512007)(110136005)(105586002)(3846002)(2906002)(33656002)(8936002)(102836004)(6116002)(99286004)(6436002)(106356001)(6246003)(4326008)(68736007)(81156014)(8676002)(81166006)(14454004)(66066001)(71200400001)(71190400001)(97736004)(83716004)(305945005)(14444005)(256004)(478600001)(7736002)(446003)(486006)(82746002)(86362001)(11346002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2603;H:CY1PR07MB2521.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fjFXbXkltmDelJc2ryROe+5mtMjoHBCPO9l7tAnANMhbPb7PJ1DLmkbDfFo1u2nAe+BUS+E/hnv9oeM0d7YMVziJo2mbcS6bsdcmvHBIlnli5VsHbC6riY7dnx77atF0KVLbXP7CZeEbrcJD+5yVXn9Uv88CFydIO68XSnAKVzryZ2aHAf8OI0iafI+U2U0yWnSh6A6fJMl3BXkuSWBmdQEiZxunJpCFjHIK1QzgeLTM1PS+mcNmapT5Qk5T3+WtP9OBQ0FSxggYK3jYeadKns3SppaILIWCjF7goIhKp/8xgKNxXwWmTS3WrblYMjGQMrtmGTFcf7oBV8se2pLfFzkqoEfsNCdEL+VO0lt/pQJWmuhAEBHpDLW6x8xNRhstpRiKodHzSO8r42RCgQbYzne1RXMTctTDPH4neD6rXlw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55E01CCD6BEDD446B95A2BC4D1F14312@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142ea2f5-17e2-405f-b955-08d6c247a7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 08:43:53.3169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2603
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=914 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxNCBBcHIgMjAxOSwgYXQgMTE6NDQsIFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+
IHdyb3RlOg0KPiANCj4gDQo+IE9uIDA0LTA0LTE5LCAwOToxMiwgSmFuIEtvdGFzIHdyb3RlOg0K
Pj4gT24gYXJtNjQgdGhlIGNhZGVuY2VfbWFzdGVyLmMgZmlsZSBkb2Vzbid0IGNvbXBpbGUuDQo+
PiANCj4+IHJlYWRsIGFuZCB3cml0ZWwgYXJlIHVuZGVmaW5lZC4NCj4+IFRoaXMgcGF0Y2ggZml4
ZXMgdGhhdCBieSBpbmNsdWRpbmcgaW8uaC4NCj4gDQo+IEFuZCBJIGNhbnQgdmVyaWZ5IHRoYXQg
d2l0aG91dCBoYWNraW5nIGtjb25maWcgdG8gZm9yY2UgY29tcGlsZSB0aGUgbGliLg0KDQpJ4oCZ
bSB3b3JraW5nIG9uIGEgbmV3IGRyaXZlciB3aGljaCB1c2VzIHRoZSBTT1VORFdJUkVfQ0FERU5D
RToNCkhlcmXigJlzIGEgZGlmZiBvZiB0aGUgS2NvbmZpZywgaXTigJlzIGEgdmVyeSBlYXJseSBz
dGFnZS4NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc291bmR3aXJlL0tjb25maWcgYi9kcml2ZXJz
L3NvdW5kd2lyZS9LY29uZmlnDQppbmRleCAxOWM4ZWZiOWEuLjkwZDU2OWUwMyAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvc291bmR3aXJlL0tjb25maWcNCisrKyBiL2RyaXZlcnMvc291bmR3aXJlL0tj
b25maWcNCkBAIC0zNCw0ICszNCwxMCBAQCBjb25maWcgU09VTkRXSVJFX0lOVEVMDQogICAgICBl
bmFibGUgdGhpcyBjb25maWcgb3B0aW9uIHRvIGdldCB0aGUgU291bmRXaXJlIHN1cHBvcnQgZm9y
IHRoYXQNCiAgICAgIGRldmljZS4NCg0KK2NvbmZpZyBTT1VORFdJUkVfQ0FERU5DRV9QTEFURk9S
TQ0KKyAgIHRyaXN0YXRlICJTb3VuZFdpcmUgQ2FkZW5jZSBQbGF0Zm9ybSBkcml2ZXIiDQorICAg
c2VsZWN0IFNPVU5EV0lSRV9DQURFTkNFDQorICAgc2VsZWN0IFNPVU5EV0lSRV9CVVMNCisgICBo
ZWxwDQorICAgICBTb3VuZFdpcmUgQ2FkZW5jZSBQbGF0Zm9ybSBkcml2ZXJzLg0KIGVuZGlmDQoN
CkkgaGF2ZW7igJl0IG1vZGlmaWVkIGFueSBvZiB0aGUgZXhpc3RpbmcgbGluZXMuIA0KU09VTkRX
SVJFX0NBREVOQ0UgZG9lc27igJl0IGRlcGVuZCBvbiBhbnl0aGluZywgZXhjZXB0IFNPVU5EV0lS
RSwNCnNvIGl0IHNob3VsZCB3b3JrLCB3aGVuIHNlbGVjdGVkLg0KDQo+IE9uIDE1IEFwciAyMDE5
LCBhdCAxNDo0MSwgUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxp
bnV4LmludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
b3VuZHdpcmUvY2FkZW5jZV9tYXN0ZXIuYyBiL2RyaXZlcnMvc291bmR3aXJlL2NhZGVuY2VfbWFz
dGVyLmMNCj4+PiBpbmRleCBjYjZhMzMxZjQuLjBiNWJjYzIwOSAxMDA2NDQNCj4+PiAtLS0gYS9k
cml2ZXJzL3NvdW5kd2lyZS9jYWRlbmNlX21hc3Rlci5jDQo+Pj4gKysrIGIvZHJpdmVycy9zb3Vu
ZHdpcmUvY2FkZW5jZV9tYXN0ZXIuYw0KPj4+IEBAIC05LDYgKzksNyBAQA0KPj4+ICAjaW5jbHVk
ZSA8bGludXgvZGVsYXkuaD4NCj4+PiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPj4+ICAj
aW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+Pj4gKyNpbmNsdWRlIDxsaW51eC9pby5oPg0K
Pj4gV2h5IG5vdCBhZGQgYXNtL2lvLmggd2hpY2ggaXMgdGhlIGhlYWRlciB0aGF0IGFjdHVhbGx5
IGRlZmluZXMNCj4+IHJlYWRsL3dyaXRlbD8NCj4gDQo+IFRoZSB2YXN0IG1ham9yaXR5IG9mIGtl
cm5lbCBjb2RlIHVzZXMgbGludXgvaW8uaC4NCj4gV2UgdXNlIGxpbnV4L2lvLmggZm9yIFNPRiBh
cyB3ZWxsLg0KDQpJIHVzZSBsaW51eC9pby5oIGluIG15IG90aGVyIGRyaXZlcnMgdG9vLg0KDQo+
IA0KPj4+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+Pj4gICNpbmNsdWRlIDxsaW51eC9t
b2RfZGV2aWNldGFibGUuaD4NCj4+PiAgI2luY2x1ZGUgPGxpbnV4L3NvdW5kd2lyZS9zZHdfcmVn
aXN0ZXJzLmg+DQo+Pj4gLS0gDQo+Pj4gMi4xNS4wDQoNCg==
