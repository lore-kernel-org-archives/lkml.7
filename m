Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6237C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F995214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FbTCRrC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbfDYBOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:14:34 -0400
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:39075
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728712AbfDYBOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMrGsHFSr84jVLmd4m/2/B64dNSw1UWjdhzur/Lzdgg=;
 b=FbTCRrC9gUtB8P4v5gq/b3ayg6tehB9JFaht5HuVsq0jTeZqyb9i74bI7vJA9sqFIcGZqP1nqin0MU9HNi1HcgDrx9aP+qq/NFg+iGC4Mz8oDnY09kbLEbRLwrdZr39XQ6Pz/Kzz3FafY8SmM1KsMOs5pUxpgyhUcKTnPRwCxkQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.18; Thu, 25 Apr 2019 01:14:27 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 01:14:27 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] watchdog: imx_sc: Add pretimeout support
Thread-Topic: [PATCH 2/2] watchdog: imx_sc: Add pretimeout support
Thread-Index: AQHU+wQ67HfMfWtsaUW0yczuADoMLQ==
Date:   Thu, 25 Apr 2019 01:14:27 +0000
Message-ID: <1556154581-31890-2-git-send-email-Anson.Huang@nxp.com>
References: <1556154581-31890-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1556154581-31890-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:203:52::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84f21954-e104-42af-7ab9-08d6c91b5c79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3788;
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB3788BD1CEE6AF1A9BC00FF66F53D0@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39850400004)(199004)(189003)(68736007)(36756003)(256004)(478600001)(8936002)(50226002)(76176011)(2201001)(14444005)(14454004)(97736004)(86362001)(316002)(6486002)(110136005)(66476007)(66446008)(64756008)(66556008)(73956011)(476003)(53936002)(6506007)(8676002)(2616005)(186003)(66946007)(66066001)(305945005)(446003)(11346002)(102836004)(26005)(7736002)(6116002)(486006)(25786009)(2501003)(4326008)(386003)(52116002)(99286004)(81166006)(6436002)(81156014)(6512007)(3846002)(71190400001)(5660300002)(2906002)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3788;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6p2124/KYgVXesqg3JxYO51SMfxkMLzo65nl+90aSsTRjw+eeUUEe5W1pJdWscAUKN/ZIS+FJXfswnMEZ5NwcdzVH10D9PAdi/yu3Y4asTJMOFvmw29/olJPBeWZj4kC+0w4yLaFt9iJcCwO+ysCSSHBOuUEsoecLcxcLi8KMgrhcdTcZzqL8MRf0jVHHHu0mfU9K0QVLIy+d+1uqNcTgvampbaq7nUiP0XbPMGt76MYrsDlM/kqrIg8zj8FWZ0FKfNJMUI37wU+orHB92jQYeSAaPm0afTlr0qJwrNG7dCdM6cAJvIKIZta9O2SwCxL7xKTCHbfNUIsoy2BdvDfvN+AnVasU0WXrjAsYWoD/um5ifK/o+iKudMq5BgWBnxCjG1lZLzTSovaRvSYHbiKp+bfz8haUVRwT43Zkn5pGh0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f21954-e104-42af-7ab9-08d6c91b5c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 01:14:27.7712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWCBzeXN0ZW0gY29udHJvbGxlciB3YXRjaGRvZyBjYW4gc3VwcG9ydCBwcmV0aW1lb3V0IElS
UQ0KdmlhIGdlbmVyYWwgU0NVIE1VIElSUSwgaXQgZGVwZW5kcyBvbiBJTVhfU0NVIGFuZCBkcml2
ZXIgTVVTVA0KYmUgcHJvYmVkIGFmdGVyIFNDVSBJUEMgcmVhZHksIHRoZW4gZW5hYmxlIGNvcnJl
c3BvbmRpbmcgU0NVDQpJUlEgZ3JvdXAgYW5kIHJlZ2lzdGVyIFNDVSBJUlEgbm90aWZpZXIsIHdo
ZW4gd2F0Y2hkb2cgcHJldGltZW91dA0KSVJRIGZpcmVzLCBTQ1UgTVUgSVJRIHdpbGwgYmUgaGFu
ZGxlZCBhbmQgd2F0Y2hkb2cgcHJldGltZW91dA0Kbm90aWZpZXIgd2lsbCBiZSBjYWxsZWQgdG8g
aGFuZGxlIHRoZSBldmVudC4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL3dhdGNoZG9nL0tjb25maWcgICAgICB8ICAxICsN
CiBkcml2ZXJzL3dhdGNoZG9nL2lteF9zY193ZHQuYyB8IDY1ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3dhdGNoZG9nL0tjb25m
aWcgYi9kcml2ZXJzL3dhdGNoZG9nL0tjb25maWcNCmluZGV4IDQ0YTMxNTguLmYyYzJjMWEgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3dhdGNoZG9nL0tjb25maWcNCisrKyBiL2RyaXZlcnMvd2F0Y2hk
b2cvS2NvbmZpZw0KQEAgLTY0NCw2ICs2NDQsNyBAQCBjb25maWcgSU1YMl9XRFQNCiBjb25maWcg
SU1YX1NDX1dEVA0KIAl0cmlzdGF0ZSAiSU1YIFNDIFdhdGNoZG9nIg0KIAlkZXBlbmRzIG9uIEhB
VkVfQVJNX1NNQ0NDDQorCWRlcGVuZHMgb24gSU1YX1NDVQ0KIAlzZWxlY3QgV0FUQ0hET0dfQ09S
RQ0KIAloZWxwDQogCSAgVGhpcyBpcyB0aGUgZHJpdmVyIGZvciB0aGUgc3lzdGVtIGNvbnRyb2xs
ZXIgd2F0Y2hkb2cNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3dhdGNoZG9nL2lteF9zY193ZHQuYyBi
L2RyaXZlcnMvd2F0Y2hkb2cvaW14X3NjX3dkdC5jDQppbmRleCA0OTg0OGI2Li5mNDVlZDEwIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy93YXRjaGRvZy9pbXhfc2Nfd2R0LmMNCisrKyBiL2RyaXZlcnMv
d2F0Y2hkb2cvaW14X3NjX3dkdC5jDQpAQCAtNCw2ICs0LDcgQEANCiAgKi8NCiANCiAjaW5jbHVk
ZSA8bGludXgvYXJtLXNtY2NjLmg+DQorI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zY2ku
aD4NCiAjaW5jbHVkZSA8bGludXgvaW8uaD4NCiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KICNp
bmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCkBAIC0zMywxMSArMzQsMTYgQEANCiANCiAjZGVmaW5l
IFNDX1RJTUVSX1dET0dfQUNUSU9OX1BBUlRJVElPTgkwDQogDQorI2RlZmluZSBTQ19JUlFfV0RP
RwkJCTENCisjZGVmaW5lIFNDX0lSUV9HUk9VUF9XRE9HCQkxDQorDQogc3RhdGljIGJvb2wgbm93
YXlvdXQgPSBXQVRDSERPR19OT1dBWU9VVDsNCiBtb2R1bGVfcGFyYW0obm93YXlvdXQsIGJvb2ws
IDAwMDApOw0KIE1PRFVMRV9QQVJNX0RFU0Mobm93YXlvdXQsICJXYXRjaGRvZyBjYW5ub3QgYmUg
c3RvcHBlZCBvbmNlIHN0YXJ0ZWQgKGRlZmF1bHQ9Ig0KIAkJIF9fTU9EVUxFX1NUUklORyhXQVRD
SERPR19OT1dBWU9VVCkgIikiKTsNCiANCitzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICppbXhfc2Nf
d2RkOw0KKw0KIHN0YXRpYyBpbnQgaW14X3NjX3dkdF9waW5nKHN0cnVjdCB3YXRjaGRvZ19kZXZp
Y2UgKndkb2cpDQogew0KIAlzdHJ1Y3QgYXJtX3NtY2NjX3JlcyByZXM7DQpAQCAtODUsMTIgKzkx
LDQyIEBAIHN0YXRpYyBpbnQgaW14X3NjX3dkdF9zZXRfdGltZW91dChzdHJ1Y3Qgd2F0Y2hkb2df
ZGV2aWNlICp3ZG9nLA0KIAlyZXR1cm4gcmVzLmEwID8gLUVBQ0NFUyA6IDA7DQogfQ0KIA0KK3N0
YXRpYyBpbnQgaW14X3NjX3dkdF9zZXRfcHJldGltZW91dChzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNl
ICp3ZG9nLA0KKwkJCQkgICAgIHVuc2lnbmVkIGludCBwcmV0aW1lb3V0KQ0KK3sNCisJc3RydWN0
IGFybV9zbWNjY19yZXMgcmVzOw0KKw0KKwl3ZG9nLT5wcmV0aW1lb3V0ID0gcHJldGltZW91dDsN
CisJYXJtX3NtY2NjX3NtYyhJTVhfU0lQX1RJTUVSLCBJTVhfU0lQX1RJTUVSX1NFVF9QUkVUSU1F
X1dET0csDQorCQkgICAgICBwcmV0aW1lb3V0ICogMTAwMCwgMCwgMCwgMCwgMCwgMCwgJnJlcyk7
DQorDQorCXJldHVybiByZXMuYTAgPyAtRUFDQ0VTIDogMDsNCit9DQorDQorc3RhdGljIGludCBp
bXhfc2Nfd2R0X25vdGlmeShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLA0KKwkJCSAgICAgdW5z
aWduZWQgbG9uZyBldmVudCwgdm9pZCAqZ3JvdXApDQorew0KKwkvKiBpZ25vcmUgb3RoZXIgaXJx
cyAqLw0KKwlpZiAoIShldmVudCAmIFNDX0lSUV9XRE9HICYmDQorCQkoKih1OCAqKWdyb3VwID09
IFNDX0lSUV9HUk9VUF9XRE9HKSkpDQorCQlyZXR1cm4gMDsNCisNCisJd2F0Y2hkb2dfbm90aWZ5
X3ByZXRpbWVvdXQoaW14X3NjX3dkZCk7DQorDQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMg
c3RydWN0IG5vdGlmaWVyX2Jsb2NrIGlteF9zY193ZHRfbm90aWZpZXIgPSB7DQorCS5ub3RpZmll
cl9jYWxsID0gaW14X3NjX3dkdF9ub3RpZnksDQorfTsNCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0
IHdhdGNoZG9nX29wcyBpbXhfc2Nfd2R0X29wcyA9IHsNCiAJLm93bmVyID0gVEhJU19NT0RVTEUs
DQogCS5zdGFydCA9IGlteF9zY193ZHRfc3RhcnQsDQogCS5zdG9wICA9IGlteF9zY193ZHRfc3Rv
cCwNCiAJLnBpbmcgID0gaW14X3NjX3dkdF9waW5nLA0KIAkuc2V0X3RpbWVvdXQgPSBpbXhfc2Nf
d2R0X3NldF90aW1lb3V0LA0KKwkuc2V0X3ByZXRpbWVvdXQgPSBpbXhfc2Nfd2R0X3NldF9wcmV0
aW1lb3V0LA0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCB3YXRjaGRvZ19pbmZvIGlteF9z
Y193ZHRfaW5mbyA9IHsNCkBAIC0xMDIsOSArMTM4LDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
d2F0Y2hkb2dfaW5mbyBpbXhfc2Nfd2R0X2luZm8gPSB7DQogc3RhdGljIGludCBpbXhfc2Nfd2R0
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSAmcGRldi0+ZGV2Ow0KLQlzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICppbXhfc2Nfd2Rk
Ow0KIAlpbnQgcmV0Ow0KIA0KKwkvKiB3YWl0IHVudGlsIGkuTVggU0NVIElQQyByZWFkeSAqLw0K
KwlyZXQgPSBpbXhfc2N1X2lycV9ncm91cF9lbmFibGUoU0NfSVJRX0dST1VQX1dET0csDQorCQkJ
CSAgICAgICBTQ19JUlFfV0RPRywNCisJCQkJICAgICAgIHRydWUpOw0KKwlpZiAocmV0ID09IC1F
UFJPQkVfREVGRVIpDQorCQlyZXR1cm4gcmV0Ow0KKw0KIAlpbXhfc2Nfd2RkID0gZGV2bV9remFs
bG9jKGRldiwgc2l6ZW9mKCppbXhfc2Nfd2RkKSwgR0ZQX0tFUk5FTCk7DQogCWlmICghaW14X3Nj
X3dkZCkNCiAJCXJldHVybiAtRU5PTUVNOw0KQEAgLTExNyw2ICsxNTksNyBAQCBzdGF0aWMgaW50
IGlteF9zY193ZHRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaW14X3Nj
X3dkZC0+bWF4X3RpbWVvdXQgPSBNQVhfVElNRU9VVDsNCiAJaW14X3NjX3dkZC0+cGFyZW50ID0g
ZGV2Ow0KIAlpbXhfc2Nfd2RkLT50aW1lb3V0ID0gREVGQVVMVF9USU1FT1VUOw0KKwlpbXhfc2Nf
d2RkLT5wcmV0aW1lb3V0ID0gMDsNCiANCiAJd2F0Y2hkb2dfaW5pdF90aW1lb3V0KGlteF9zY193
ZGQsIDAsIGRldik7DQogCXdhdGNoZG9nX3N0b3Bfb25fcmVib290KGlteF9zY193ZGQpOw0KQEAg
LTEyOCwxMyArMTcxLDI2IEBAIHN0YXRpYyBpbnQgaW14X3NjX3dkdF9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KKwlyZXQgPSBpbXhf
c2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllcigmaW14X3NjX3dkdF9ub3RpZmllcik7DQorCWlmIChy
ZXQpDQorCQlkZXZfd2FybigmcGRldi0+ZGV2LA0KKwkJCSAiRmFpbGVkIHRvIHJlZ2lzdGVyIHdh
dGNoZG9nIGlycSBub3RpZmllclxuIik7DQorDQogCXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMg
aW50IF9fbWF5YmVfdW51c2VkIGlteF9zY193ZHRfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYp
DQorc3RhdGljIGludCBpbXhfc2Nfd2R0X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIHsNCi0Jc3RydWN0IHdhdGNoZG9nX2RldmljZSAqaW14X3NjX3dkZCA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOw0KKwlpbXhfc2N1X2lycV91bnJlZ2lzdGVyX25vdGlmaWVyKCZpbXhfc2Nf
d2R0X25vdGlmaWVyKTsNCisJaW14X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKFNDX0lSUV9HUk9VUF9X
RE9HLA0KKwkJCQkgU0NfSVJRX1dET0csDQorCQkJCSBmYWxzZSk7DQogDQorCXJldHVybiAwOw0K
K30NCisNCitzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGlteF9zY193ZHRfc3VzcGVuZChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQorew0KIAlpZiAod2F0Y2hkb2dfYWN0aXZlKGlteF9zY193ZGQpKQ0K
IAkJaW14X3NjX3dkdF9zdG9wKGlteF9zY193ZGQpOw0KIA0KQEAgLTE0Myw4ICsxOTksNiBAQCBz
dGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGlteF9zY193ZHRfc3VzcGVuZChzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQogDQogc3RhdGljIGludCBfX21heWJlX3VudXNlZCBpbXhfc2Nfd2R0X3Jlc3VtZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQogew0KLQlzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICppbXhfc2Nf
d2RkID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQotDQogCWlmICh3YXRjaGRvZ19hY3RpdmUoaW14
X3NjX3dkZCkpDQogCQlpbXhfc2Nfd2R0X3N0YXJ0KGlteF9zY193ZGQpOw0KIA0KQEAgLTE2Miw2
ICsyMTYsNyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXhfc2Nfd2R0X2R0X2lkcyk7DQog
DQogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW14X3NjX3dkdF9kcml2ZXIgPSB7DQog
CS5wcm9iZQkJPSBpbXhfc2Nfd2R0X3Byb2JlLA0KKwkucmVtb3ZlCQk9IGlteF9zY193ZHRfcmVt
b3ZlLA0KIAkuZHJpdmVyCQk9IHsNCiAJCS5uYW1lCT0gImlteC1zYy13ZHQiLA0KIAkJLm9mX21h
dGNoX3RhYmxlID0gaW14X3NjX3dkdF9kdF9pZHMsDQotLSANCjIuNy40DQoNCg==
