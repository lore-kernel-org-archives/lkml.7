Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F03BC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EC8205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qI/griKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfD1D1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:27:19 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:64350
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfD1D1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoWrustM0UiwCXzofxodfOBuh3ClMbE8zgk6YUoYgfE=;
 b=qI/griKrlsGC9eg5VYc6S25JrYmnEz4RXGjqIXH1pDpNqQpaH2IzEdbtTTDlLnflJoISsNmmAjwwhRDFJ8NqWbiPF6cYh8Gav8mJqgdzxXtihfyygdK4Ay3+x1jUsGQXywWXyZgCa3HB15iM/G49uZf+/fhb1s5GnpK3cMAHJCs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 03:27:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.015; Sun, 28 Apr 2019
 03:27:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 3/4] watchdog: imx_sc: Add pretimeout support
Thread-Topic: [PATCH V2 3/4] watchdog: imx_sc: Add pretimeout support
Thread-Index: AQHU/XJEb2AE+bf5WEKUqaf0TfCvNQ==
Date:   Sun, 28 Apr 2019 03:27:11 +0000
Message-ID: <1556421727-7401-3-git-send-email-Anson.Huang@nxp.com>
References: <1556421727-7401-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1556421727-7401-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2fa1688-11aa-4247-fe94-08d6cb8966bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-microsoft-antispam-prvs: <DB3PR0402MB3897A821CDA9AA624C49BA2EF5380@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(256004)(71190400001)(14444005)(71200400001)(97736004)(6116002)(186003)(66066001)(86362001)(2201001)(476003)(2616005)(8936002)(36756003)(486006)(11346002)(81156014)(81166006)(25786009)(53936002)(50226002)(3846002)(446003)(2906002)(2501003)(386003)(6506007)(76176011)(68736007)(4326008)(102836004)(64756008)(52116002)(66946007)(66476007)(66556008)(8676002)(66446008)(6486002)(6436002)(7416002)(14454004)(73956011)(7736002)(99286004)(478600001)(316002)(110136005)(305945005)(26005)(6512007)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IhUBNCjRZte1/LQ93sR4BmPBU0V0Qov+EIXfKr0W/EYbn8VynFeOJaQC9Ool8IiZGDHvKMahPEwojmuRN+DIhmEi3pmn7LWnFmOFbHrezcHAqXS64GTdboo8BHwyYbSW3nUrfk/nd55bfswK9tFW3yDT7raftSIPPiIBDFuuWtFBpmu15Gf/jpl0UvtitPZyu3qPNsYhb//uKjYhd1Dys5z7B5yhxj8eSsAfg3ycq0UzGEGo+d9ItmjHLBz6LTwGTC0IgfNeX03DgNRI83p55vgp16Pbeulh7TAtaR0SrLIpwOtXXYbAMA3+CjZAmDTfLo6XY7T7+c3nIgxX72Ilxi596xQHo7MtZoINF+cUzPzd+A6C969E3mG+MKm1/i1JXUAGFjBLPoTlR0GwEE6GMCxjSZMDUnDc4N/Ic0briaY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fa1688-11aa-4247-fe94-08d6cb8966bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 03:27:11.7500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
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
YW5nQG54cC5jb20+DQotLS0NCkNoYW5nZXMgc2luY2UgVjE6DQogICAgICAgIC0gaW1wcm92ZSBp
bXhfc2Nfd2R0X3NldF9wcmV0aW1lb3V0KCkgcmV0dXJuIHZhbHVlIGFuZCBhc3NpZ25tZW50IHNl
cXVlbmNlOw0KICAgICAgICAtIGltcHJvdmUgY29kaW5nIGFuZCBsb2dpYyBvZiBpbXhfc2Nfd2R0
X25vdGlmeSgpIGZ1bmN0aW9uOw0KICAgICAgICAtIHVzZSBkZXZtX2FkZF9hY3Rpb24oKSBpbnN0
ZWFkIG9mIC5yZW1vdmU7DQogICAgICAgIC0gYWRkIGxvY2FsIGRhdGEgc3RydWN0dXJlIHRvIGlu
Y2x1ZGUgbm90aWZpZXIgYmxvY2s7DQogICAgICAgIC0gcmVtb3ZlIHRoZSBkZWZlciBwcm9iZSBj
aGVjayBzaW5jZSB0aGUgd2F0Y2hkb2cgbm9kZSBpcyBub3cgbW92ZWQgaW50byBTQ1Ugbm9kZTsN
CiAgICAgICAgLSBPTkxZIGVuYWJsZSBwcmV0aW1lb3V0IGZ1bmN0aW9uIGFmdGVyIGV2ZXJ5dGhp
bmcgYWJvdXQgSVJRIGFyZSBzdWNjZXNzZnVsbHkuDQotLS0NCiBkcml2ZXJzL3dhdGNoZG9nL0tj
b25maWcgICAgICB8ICAgMSArDQogZHJpdmVycy93YXRjaGRvZy9pbXhfc2Nfd2R0LmMgfCAxMTQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQogMiBmaWxlcyBjaGFu
Z2VkLCA5NSBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvd2F0Y2hkb2cvS2NvbmZpZyBiL2RyaXZlcnMvd2F0Y2hkb2cvS2NvbmZpZw0KaW5kZXgg
NDRhMzE1OC4uZjJjMmMxYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvd2F0Y2hkb2cvS2NvbmZpZw0K
KysrIGIvZHJpdmVycy93YXRjaGRvZy9LY29uZmlnDQpAQCAtNjQ0LDYgKzY0NCw3IEBAIGNvbmZp
ZyBJTVgyX1dEVA0KIGNvbmZpZyBJTVhfU0NfV0RUDQogCXRyaXN0YXRlICJJTVggU0MgV2F0Y2hk
b2ciDQogCWRlcGVuZHMgb24gSEFWRV9BUk1fU01DQ0MNCisJZGVwZW5kcyBvbiBJTVhfU0NVDQog
CXNlbGVjdCBXQVRDSERPR19DT1JFDQogCWhlbHANCiAJICBUaGlzIGlzIHRoZSBkcml2ZXIgZm9y
IHRoZSBzeXN0ZW0gY29udHJvbGxlciB3YXRjaGRvZw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvd2F0
Y2hkb2cvaW14X3NjX3dkdC5jIGIvZHJpdmVycy93YXRjaGRvZy9pbXhfc2Nfd2R0LmMNCmluZGV4
IDQ5ODQ4YjYuLmQ4NDkzYTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3dhdGNoZG9nL2lteF9zY193
ZHQuYw0KKysrIGIvZHJpdmVycy93YXRjaGRvZy9pbXhfc2Nfd2R0LmMNCkBAIC00LDYgKzQsNyBA
QA0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9hcm0tc21jY2MuaD4NCisjaW5jbHVkZSA8bGlu
dXgvZmlybXdhcmUvaW14L3NjaS5oPg0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0KICNpbmNsdWRl
IDxsaW51eC9pbml0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KQEAgLTMzLDExICsz
NCwxOSBAQA0KIA0KICNkZWZpbmUgU0NfVElNRVJfV0RPR19BQ1RJT05fUEFSVElUSU9OCTANCiAN
CisjZGVmaW5lIFNDX0lSUV9XRE9HCQkJMQ0KKyNkZWZpbmUgU0NfSVJRX0dST1VQX1dET0cJCTEN
CisNCiBzdGF0aWMgYm9vbCBub3dheW91dCA9IFdBVENIRE9HX05PV0FZT1VUOw0KIG1vZHVsZV9w
YXJhbShub3dheW91dCwgYm9vbCwgMDAwMCk7DQogTU9EVUxFX1BBUk1fREVTQyhub3dheW91dCwg
IldhdGNoZG9nIGNhbm5vdCBiZSBzdG9wcGVkIG9uY2Ugc3RhcnRlZCAoZGVmYXVsdD0iDQogCQkg
X19NT0RVTEVfU1RSSU5HKFdBVENIRE9HX05PV0FZT1VUKSAiKSIpOw0KIA0KK3N0cnVjdCBpbXhf
c2Nfd2R0X2RldmljZSB7DQorCXN0cnVjdCB3YXRjaGRvZ19kZXZpY2Ugd2RkOw0KKwlzdHJ1Y3Qg
bm90aWZpZXJfYmxvY2sgd2R0X25vdGlmaWVyOw0KK307DQorDQogc3RhdGljIGludCBpbXhfc2Nf
d2R0X3Bpbmcoc3RydWN0IHdhdGNoZG9nX2RldmljZSAqd2RvZykNCiB7DQogCXN0cnVjdCBhcm1f
c21jY2NfcmVzIHJlczsNCkBAIC04NSwyNCArOTQsNjYgQEAgc3RhdGljIGludCBpbXhfc2Nfd2R0
X3NldF90aW1lb3V0KHN0cnVjdCB3YXRjaGRvZ19kZXZpY2UgKndkb2csDQogCXJldHVybiByZXMu
YTAgPyAtRUFDQ0VTIDogMDsNCiB9DQogDQorc3RhdGljIGludCBpbXhfc2Nfd2R0X3NldF9wcmV0
aW1lb3V0KHN0cnVjdCB3YXRjaGRvZ19kZXZpY2UgKndkb2csDQorCQkJCSAgICAgdW5zaWduZWQg
aW50IHByZXRpbWVvdXQpDQorew0KKwlzdHJ1Y3QgYXJtX3NtY2NjX3JlcyByZXM7DQorDQorCWFy
bV9zbWNjY19zbWMoSU1YX1NJUF9USU1FUiwgSU1YX1NJUF9USU1FUl9TRVRfUFJFVElNRV9XRE9H
LA0KKwkJICAgICAgcHJldGltZW91dCAqIDEwMDAsIDAsIDAsIDAsIDAsIDAsICZyZXMpOw0KKwlp
ZiAocmVzLmEwKQ0KKwkJcmV0dXJuIC1FQUNDRVM7DQorDQorCXdkb2ctPnByZXRpbWVvdXQgPSBw
cmV0aW1lb3V0Ow0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIGludCBpbXhfc2Nfd2R0
X25vdGlmeShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLA0KKwkJCSAgICAgdW5zaWduZWQgbG9u
ZyBldmVudCwgdm9pZCAqZ3JvdXApDQorew0KKwlzdHJ1Y3QgaW14X3NjX3dkdF9kZXZpY2UgKmlt
eF9zY193ZGQgPQ0KKwkJCQkgY29udGFpbmVyX29mKG5iLA0KKwkJCQkJICAgICAgc3RydWN0IGlt
eF9zY193ZHRfZGV2aWNlLA0KKwkJCQkJICAgICAgd2R0X25vdGlmaWVyKTsNCisNCisJaWYgKGV2
ZW50ICYgU0NfSVJRX1dET0cgJiYNCisJICAgICoodTggKilncm91cCA9PSBTQ19JUlFfR1JPVVBf
V0RPRykNCisJCXdhdGNoZG9nX25vdGlmeV9wcmV0aW1lb3V0KCZpbXhfc2Nfd2RkLT53ZGQpOw0K
Kw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIHZvaWQgaW14X3NjX3dkdF9hY3Rpb24odm9p
ZCAqZGF0YSkNCit7DQorCXN0cnVjdCBub3RpZmllcl9ibG9jayAqd2R0X25vdGlmaWVyID0gZGF0
YTsNCisNCisJaW14X3NjdV9pcnFfdW5yZWdpc3Rlcl9ub3RpZmllcih3ZHRfbm90aWZpZXIpOw0K
KwlpbXhfc2N1X2lycV9ncm91cF9lbmFibGUoU0NfSVJRX0dST1VQX1dET0csDQorCQkJCSBTQ19J
UlFfV0RPRywNCisJCQkJIGZhbHNlKTsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCB3YXRj
aGRvZ19vcHMgaW14X3NjX3dkdF9vcHMgPSB7DQogCS5vd25lciA9IFRISVNfTU9EVUxFLA0KIAku
c3RhcnQgPSBpbXhfc2Nfd2R0X3N0YXJ0LA0KIAkuc3RvcCAgPSBpbXhfc2Nfd2R0X3N0b3AsDQog
CS5waW5nICA9IGlteF9zY193ZHRfcGluZywNCiAJLnNldF90aW1lb3V0ID0gaW14X3NjX3dkdF9z
ZXRfdGltZW91dCwNCisJLnNldF9wcmV0aW1lb3V0ID0gaW14X3NjX3dkdF9zZXRfcHJldGltZW91
dCwNCiB9Ow0KIA0KLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgd2F0Y2hkb2dfaW5mbyBpbXhfc2Nfd2R0
X2luZm8gPSB7DQorc3RhdGljIHN0cnVjdCB3YXRjaGRvZ19pbmZvIGlteF9zY193ZHRfaW5mbyA9
IHsNCiAJLmlkZW50aXR5CT0gImkuTVggU0Mgd2F0Y2hkb2cgdGltZXIiLA0KIAkub3B0aW9ucwk9
IFdESU9GX1NFVFRJTUVPVVQgfCBXRElPRl9LRUVQQUxJVkVQSU5HIHwNCi0JCQkgIFdESU9GX01B
R0lDQ0xPU0UgfCBXRElPRl9QUkVUSU1FT1VULA0KKwkJCSAgV0RJT0ZfTUFHSUNDTE9TRSwNCiB9
Ow0KIA0KIHN0YXRpYyBpbnQgaW14X3NjX3dkdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIHsNCisJc3RydWN0IGlteF9zY193ZHRfZGV2aWNlICppbXhfc2Nfd2RkOw0KKwlz
dHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICp3ZG9nOw0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRl
di0+ZGV2Ow0KLQlzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICppbXhfc2Nfd2RkOw0KIAlpbnQgcmV0
Ow0KIA0KIAlpbXhfc2Nfd2RkID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCppbXhfc2Nfd2Rk
KSwgR0ZQX0tFUk5FTCk7DQpAQCAtMTExLDQyICsxNjIsNjUgQEAgc3RhdGljIGludCBpbXhfc2Nf
d2R0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogDQogCXBsYXRmb3JtX3Nl
dF9kcnZkYXRhKHBkZXYsIGlteF9zY193ZGQpOw0KIA0KLQlpbXhfc2Nfd2RkLT5pbmZvID0gJmlt
eF9zY193ZHRfaW5mbzsNCi0JaW14X3NjX3dkZC0+b3BzID0gJmlteF9zY193ZHRfb3BzOw0KLQlp
bXhfc2Nfd2RkLT5taW5fdGltZW91dCA9IDE7DQotCWlteF9zY193ZGQtPm1heF90aW1lb3V0ID0g
TUFYX1RJTUVPVVQ7DQotCWlteF9zY193ZGQtPnBhcmVudCA9IGRldjsNCi0JaW14X3NjX3dkZC0+
dGltZW91dCA9IERFRkFVTFRfVElNRU9VVDsNCisJd2RvZyA9ICZpbXhfc2Nfd2RkLT53ZGQ7DQor
CXdkb2ctPmluZm8gPSAmaW14X3NjX3dkdF9pbmZvOw0KKwl3ZG9nLT5vcHMgPSAmaW14X3NjX3dk
dF9vcHM7DQorCXdkb2ctPm1pbl90aW1lb3V0ID0gMTsNCisJd2RvZy0+bWF4X3RpbWVvdXQgPSBN
QVhfVElNRU9VVDsNCisJd2RvZy0+cGFyZW50ID0gZGV2Ow0KKwl3ZG9nLT50aW1lb3V0ID0gREVG
QVVMVF9USU1FT1VUOw0KIA0KLQl3YXRjaGRvZ19pbml0X3RpbWVvdXQoaW14X3NjX3dkZCwgMCwg
ZGV2KTsNCi0Jd2F0Y2hkb2dfc3RvcF9vbl9yZWJvb3QoaW14X3NjX3dkZCk7DQotCXdhdGNoZG9n
X3N0b3Bfb25fdW5yZWdpc3RlcihpbXhfc2Nfd2RkKTsNCisJd2F0Y2hkb2dfaW5pdF90aW1lb3V0
KHdkb2csIDAsIGRldik7DQorCXdhdGNoZG9nX3N0b3Bfb25fcmVib290KHdkb2cpOw0KKwl3YXRj
aGRvZ19zdG9wX29uX3VucmVnaXN0ZXIod2RvZyk7DQogDQotCXJldCA9IGRldm1fd2F0Y2hkb2df
cmVnaXN0ZXJfZGV2aWNlKGRldiwgaW14X3NjX3dkZCk7DQorCXJldCA9IGRldm1fd2F0Y2hkb2df
cmVnaXN0ZXJfZGV2aWNlKGRldiwgd2RvZyk7DQogCWlmIChyZXQpIHsNCiAJCWRldl9lcnIoZGV2
LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIHdhdGNoZG9nIGRldmljZVxuIik7DQogCQlyZXR1cm4gcmV0
Ow0KIAl9DQogDQotCXJldHVybiAwOw0KKwlyZXQgPSBpbXhfc2N1X2lycV9ncm91cF9lbmFibGUo
U0NfSVJRX0dST1VQX1dET0csDQorCQkJCSAgICAgICBTQ19JUlFfV0RPRywNCisJCQkJICAgICAg
IHRydWUpOw0KKwlpZiAocmV0KSB7DQorCQlkZXZfd2FybihkZXYsICJFbmFibGUgaXJxIGZhaWxl
ZCwgcHJldGltZW91dCBOT1Qgc3VwcG9ydGVkXG4iKTsNCisJCXJldHVybiAwOw0KKwl9DQorDQor
CWlteF9zY193ZGQtPndkdF9ub3RpZmllci5ub3RpZmllcl9jYWxsID0gaW14X3NjX3dkdF9ub3Rp
Znk7DQorCXJldCA9IGlteF9zY3VfaXJxX3JlZ2lzdGVyX25vdGlmaWVyKCZpbXhfc2Nfd2RkLT53
ZHRfbm90aWZpZXIpOw0KKwlpZiAocmV0KSB7DQorCQlpbXhfc2N1X2lycV9ncm91cF9lbmFibGUo
U0NfSVJRX0dST1VQX1dET0csDQorCQkJCQkgU0NfSVJRX1dET0csDQorCQkJCQkgZmFsc2UpOw0K
KwkJZGV2X3dhcm4oZGV2LA0KKwkJCSAiUmVnaXN0ZXIgaXJxIG5vdGlmaWVyIGZhaWxlZCwgcHJl
dGltZW91dCBOT1Qgc3VwcG9ydGVkXG4iKTsNCisJCXJldHVybiAwOw0KKwl9DQorDQorCWlteF9z
Y193ZHRfaW5mby5vcHRpb25zIHw9IFdESU9GX1BSRVRJTUVPVVQ7DQorCXJldCA9IGRldm1fYWRk
X2FjdGlvbihkZXYsIGlteF9zY193ZHRfYWN0aW9uLA0KKwkJCSAgICAgICZpbXhfc2Nfd2RkLT53
ZHRfbm90aWZpZXIpOw0KKwlyZXR1cm4gcmV0Ow0KIH0NCiANCiBzdGF0aWMgaW50IF9fbWF5YmVf
dW51c2VkIGlteF9zY193ZHRfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQogew0KLQlzdHJ1
Y3Qgd2F0Y2hkb2dfZGV2aWNlICppbXhfc2Nfd2RkID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQor
CXN0cnVjdCBpbXhfc2Nfd2R0X2RldmljZSAqaW14X3NjX3dkZCA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXYpOw0KIA0KLQlpZiAod2F0Y2hkb2dfYWN0aXZlKGlteF9zY193ZGQpKQ0KLQkJaW14X3NjX3dk
dF9zdG9wKGlteF9zY193ZGQpOw0KKwlpZiAod2F0Y2hkb2dfYWN0aXZlKCZpbXhfc2Nfd2RkLT53
ZGQpKQ0KKwkJaW14X3NjX3dkdF9zdG9wKCZpbXhfc2Nfd2RkLT53ZGQpOw0KIA0KIAlyZXR1cm4g
MDsNCiB9DQogDQogc3RhdGljIGludCBfX21heWJlX3VudXNlZCBpbXhfc2Nfd2R0X3Jlc3VtZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQogew0KLQlzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICppbXhfc2Nf
d2RkID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQorCXN0cnVjdCBpbXhfc2Nfd2R0X2RldmljZSAq
aW14X3NjX3dkZCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KIA0KLQlpZiAod2F0Y2hkb2dfYWN0
aXZlKGlteF9zY193ZGQpKQ0KLQkJaW14X3NjX3dkdF9zdGFydChpbXhfc2Nfd2RkKTsNCisJaWYg
KHdhdGNoZG9nX2FjdGl2ZSgmaW14X3NjX3dkZC0+d2RkKSkNCisJCWlteF9zY193ZHRfc3RhcnQo
JmlteF9zY193ZGQtPndkZCk7DQogDQogCXJldHVybiAwOw0KIH0NCi0tIA0KMi43LjQNCg0K
