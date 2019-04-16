Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2CEC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA80A2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E2khNjBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDPDWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:22:23 -0400
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:50575
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfDPDWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y1qJnNfkOM3Ow2YFkmqivAVweRaWhs19+5fyvCNQ3A=;
 b=E2khNjBdUWxQQW59fMmWyfPFt7eT5uekcq9wy60cA1L6pPU4M3WIMUJKydjbaFR/m0KoK0wz2wVzRx6QDerpeT+8xJLNLeYgSmv3bv1oFx1ZlJXIQIdOwDn2osVXS9NCzWRJrIheRo1O1evJ+cGN1lxadSutfooTcflS78AJjIU=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3895.eurprd04.prod.outlook.com (52.133.29.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Tue, 16 Apr 2019 03:22:17 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2%6]) with mapi id 15.20.1792.020; Tue, 16 Apr 2019
 03:22:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V12 2/5] thermal: of-thermal: add API for getting sensor ID
 from DT
Thread-Topic: [PATCH V12 2/5] thermal: of-thermal: add API for getting sensor
 ID from DT
Thread-Index: AQHU9AOYmR6BJ3silEqzBa3crqYckQ==
Date:   Tue, 16 Apr 2019 03:22:17 +0000
Message-ID: <1555384609-7030-2-git-send-email-Anson.Huang@nxp.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f05a450b-eb62-4362-819e-08d6c21aba5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3895;
x-ms-traffictypediagnostic: AM6PR0402MB3895:
x-microsoft-antispam-prvs: <AM6PR0402MB3895609FF6BC4E0CD34CBFAEF5240@AM6PR0402MB3895.eurprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(6512007)(106356001)(105586002)(53936002)(2501003)(36756003)(6116002)(3846002)(66066001)(68736007)(486006)(110136005)(316002)(5660300002)(11346002)(446003)(476003)(2616005)(97736004)(71190400001)(71200400001)(81166006)(99286004)(8936002)(81156014)(8676002)(50226002)(52116002)(102836004)(256004)(14454004)(478600001)(6506007)(386003)(26005)(7736002)(4326008)(76176011)(86362001)(2906002)(7416002)(186003)(2201001)(25786009)(6486002)(6436002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3895;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2lTIscw5KFDqFnh6h0QVSqOr2m3B8jRxzXOFmam/zHivjYcDk2t/gKsIdTWUFrhpMSQehAjzidWsw2csHyDBO3+5Eo+wRNvEm7waXJoUceEcVK2t5hNVD4FZ+FTLGik1Tiqc9r2XmO9Pk75bS3TnhOol0Z9W3+Tlbc6KQ/oFCYX8P/FKdkzab5YUggqX93msJG7WvSj/CE+IdIIMtFO+SpVK8ToJJMc8JfUAYN1vk2bqmD19jL/MdU13I2JQuR7zu4NiTLrUzp0d8PlZwFOHi9ZfW+YONKS/Z7vyBJo/n3laxqOL8nZijz7kM5BirXmuPVosYyoRYiqTXODSnfPf9Jdcazi4ta0mNTAZzWCWGczaLMuR2Z0j3sPlhmTdL/GjudiV7S5em3mmKCUUfondPzZI6Qfky/6GfmV1EwrKDj8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05a450b-eb62-4362-819e-08d6c21aba5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 03:22:17.8220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gc29tZSBwbGF0Zm9ybXMgbGlrZSBpLk1YOFFYUCwgdGhlIHRoZXJtYWwgZHJpdmVyIG5lZWRz
IGENCnJlYWwgSFcgc2Vuc29yIElEIGZyb20gRFQgdGhlcm1hbCB6b25lLCB0aGUgSFcgc2Vuc29y
IElEIGlzDQp1c2VkIHRvIGdldCB0ZW1wZXJhdHVyZSBmcm9tIFNDVSBmaXJtd2FyZSwgYW5kIHRo
ZSB2aXJ0dWFsDQpzZW5zb3IgSUQgc3RhcnRpbmcgZnJvbSAwIHRvIE4gaXMgTk9UIHVzZWQgYXQg
YWxsLCB0aGlzIHBhdGNoDQphZGRzIG5ldyBBUEkgdGhlcm1hbF96b25lX29mX2dldF9zZW5zb3Jf
aWQoKSB0byBwcm92aWRlIHRoZQ0KZmVhdHVyZSBvZiBnZXR0aW5nIHNlbnNvciBJRCBmcm9tIERU
IHRoZXJtYWwgem9uZSdzIG5vZGUuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KLS0tDQpOZXcgcGF0Y2guDQotLS0NCiBkcml2ZXJzL3RoZXJtYWwv
b2YtdGhlcm1hbC5jIHwgNTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0NCiBpbmNsdWRlL2xpbnV4L3RoZXJtYWwuaCAgICAgIHwgMTAgKysrKysrKysrDQogMiBm
aWxlcyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvb2Yt
dGhlcm1hbC5jDQppbmRleCAyZGYwNTljLi4yZTQzMjBjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy90
aGVybWFsL29mLXRoZXJtYWwuYw0KKysrIGIvZHJpdmVycy90aGVybWFsL29mLXRoZXJtYWwuYw0K
QEAgLTQ0Niw2ICs0NDYsNDYgQEAgdGhlcm1hbF96b25lX29mX2FkZF9zZW5zb3Ioc3RydWN0IGRl
dmljZV9ub2RlICp6b25lLA0KIH0NCiANCiAvKioNCisgKiB0aGVybWFsX3pvbmVfb2ZfZ2V0X3Nl
bnNvcl9pZCAtIGdldCBzZW5zb3IgSUQgZnJvbSBhIERUIHRoZXJtYWwgem9uZQ0KKyAqIEB0el9u
cDogYSB2YWxpZCB0aGVybWFsIHpvbmUgZGV2aWNlIG5vZGUuDQorICogQHNlbnNvcl9zcGVjczog
cG9pbnRlciB0byBvdXRwdXQgYXJndW1lbnRzIHN0cnVjdHVyZSB3aWxsIGJlIHBhc3NlZCBiYWNr
Lg0KKyAqIEBpZDogYSBzZW5zb3IgSUQgcG9pbnRlciB3aWxsIGJlIHBhc3NlZCBiYWNrLg0KKyAq
DQorICogVGhpcyBmdW5jdGlvbiB3aWxsIGdldCBzZW5zb3IgSUQgZnJvbSBhIGdpdmVuIHRoZXJt
YWwgem9uZSBub2RlLCB1c2UNCisgKiAidGhlcm1hbC1zZW5zb3JzIiBhcyBsaXN0IG5hbWUsIGFu
ZCBnZXQgc2Vuc29yIElEIGZyb20gZmlyc3QgcGhhbmRsZSdzDQorICogYXJndW1lbnQuDQorICoN
CisgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgcHJvcGVyIGVycm9yIGNvZGUgb3RoZXJ3aXNlLg0K
KyAqLw0KKw0KK2ludCB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChzdHJ1Y3QgZGV2aWNl
X25vZGUgKnR6X25wLA0KKwkJCQkgIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKnNlbnNvcl9zcGVj
cywNCisJCQkJICB1MzIgKmlkKQ0KK3sNCisJaW50IHJldDsNCisNCisJcmV0ID0gb2ZfcGFyc2Vf
cGhhbmRsZV93aXRoX2FyZ3ModHpfbnAsDQorCQkJCQkgInRoZXJtYWwtc2Vuc29ycyIsDQorCQkJ
CQkgIiN0aGVybWFsLXNlbnNvci1jZWxscyIsDQorCQkJCQkgMCwNCisJCQkJCSBzZW5zb3Jfc3Bl
Y3MpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJaWYgKHNlbnNvcl9zcGVjcy0+
YXJnc19jb3VudCA+PSAxKSB7DQorCQkqaWQgPSBzZW5zb3Jfc3BlY3MtPmFyZ3NbMF07DQorCQlX
QVJOKHNlbnNvcl9zcGVjcy0+YXJnc19jb3VudCA+IDEsDQorCQkgICAgICIlcE9GbjogdG9vIG1h
bnkgY2VsbHMgaW4gc2Vuc29yIHNwZWNpZmllciAlZFxuIiwNCisJCSAgICAgc2Vuc29yX3NwZWNz
LT5ucCwgc2Vuc29yX3NwZWNzLT5hcmdzX2NvdW50KTsNCisJfSBlbHNlIHsNCisJCSppZCA9IDA7
DQorCX0NCisNCisJcmV0dXJuIDA7DQorfQ0KK0VYUE9SVF9TWU1CT0xfR1BMKHRoZXJtYWxfem9u
ZV9vZl9nZXRfc2Vuc29yX2lkKTsNCisNCisvKioNCiAgKiB0aGVybWFsX3pvbmVfb2Zfc2Vuc29y
X3JlZ2lzdGVyIC0gcmVnaXN0ZXJzIGEgc2Vuc29yIHRvIGEgRFQgdGhlcm1hbCB6b25lDQogICog
QGRldjogYSB2YWxpZCBzdHJ1Y3QgZGV2aWNlIHBvaW50ZXIgb2YgYSBzZW5zb3IgZGV2aWNlLiBN
dXN0IGNvbnRhaW4NCiAgKiAgICAgICBhIHZhbGlkIC5vZl9ub2RlLCBmb3IgdGhlIHNlbnNvciBu
b2RlLg0KQEAgLTUwMCwyMSArNTQwLDEwIEBAIHRoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0
ZXIoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgc2Vuc29yX2lkLCB2b2lkICpkYXRhLA0KIAkJaW50
IHJldCwgaWQ7DQogDQogCQkvKiBGb3Igbm93LCB0aGVybWFsIGZyYW1ld29yayBzdXBwb3J0cyBv
bmx5IDEgc2Vuc29yIHBlciB6b25lICovDQotCQlyZXQgPSBvZl9wYXJzZV9waGFuZGxlX3dpdGhf
YXJncyhjaGlsZCwgInRoZXJtYWwtc2Vuc29ycyIsDQotCQkJCQkJICIjdGhlcm1hbC1zZW5zb3It
Y2VsbHMiLA0KLQkJCQkJCSAwLCAmc2Vuc29yX3NwZWNzKTsNCisJCXJldCA9IHRoZXJtYWxfem9u
ZV9vZl9nZXRfc2Vuc29yX2lkKGNoaWxkLCAmc2Vuc29yX3NwZWNzLCAmaWQpOw0KIAkJaWYgKHJl
dCkNCiAJCQljb250aW51ZTsNCiANCi0JCWlmIChzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCA+PSAx
KSB7DQotCQkJaWQgPSBzZW5zb3Jfc3BlY3MuYXJnc1swXTsNCi0JCQlXQVJOKHNlbnNvcl9zcGVj
cy5hcmdzX2NvdW50ID4gMSwNCi0JCQkgICAgICIlcE9GbjogdG9vIG1hbnkgY2VsbHMgaW4gc2Vu
c29yIHNwZWNpZmllciAlZFxuIiwNCi0JCQkgICAgIHNlbnNvcl9zcGVjcy5ucCwgc2Vuc29yX3Nw
ZWNzLmFyZ3NfY291bnQpOw0KLQkJfSBlbHNlIHsNCi0JCQlpZCA9IDA7DQotCQl9DQotDQogCQlp
ZiAoc2Vuc29yX3NwZWNzLm5wID09IHNlbnNvcl9ucCAmJiBpZCA9PSBzZW5zb3JfaWQpIHsNCiAJ
CQl0emQgPSB0aGVybWFsX3pvbmVfb2ZfYWRkX3NlbnNvcihjaGlsZCwgc2Vuc29yX25wLA0KIAkJ
CQkJCQkgZGF0YSwgb3BzKTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaCBi
L2luY2x1ZGUvbGludXgvdGhlcm1hbC5oDQppbmRleCA1ZjQ3MDVmLi45NzBmYjM3IDEwMDY0NA0K
LS0tIGEvaW5jbHVkZS9saW51eC90aGVybWFsLmgNCisrKyBiL2luY2x1ZGUvbGludXgvdGhlcm1h
bC5oDQpAQCAtMzc1LDYgKzM3NSw5IEBAIHN0cnVjdCB0aGVybWFsX3RyaXAgew0KIA0KIC8qIEZ1
bmN0aW9uIGRlY2xhcmF0aW9ucyAqLw0KICNpZmRlZiBDT05GSUdfVEhFUk1BTF9PRg0KK2ludCB0
aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChzdHJ1Y3QgZGV2aWNlX25vZGUgKnR6X25wLA0K
KwkJCQkgIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKnNlbnNvcl9zcGVjcywNCisJCQkJICB1MzIg
KmlkKTsNCiBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqDQogdGhlcm1hbF96b25lX29mX3Nl
bnNvcl9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpZCwgdm9pZCAqZGF0YSwNCiAJ
CQkJY29uc3Qgc3RydWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzICpvcHMpOw0KQEAgLTM4
Niw2ICszODksMTMgQEAgc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKmRldm1fdGhlcm1hbF96
b25lX29mX3NlbnNvcl9yZWdpc3RlcigNCiB2b2lkIGRldm1fdGhlcm1hbF96b25lX29mX3NlbnNv
cl91bnJlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldiwNCiAJCQkJCSAgICBzdHJ1Y3QgdGhlcm1h
bF96b25lX2RldmljZSAqdHopOw0KICNlbHNlDQorDQorc3RhdGljIGludCB0aGVybWFsX3pvbmVf
b2ZfZ2V0X3NlbnNvcl9pZChzdHJ1Y3QgZGV2aWNlX25vZGUgKnR6X25wLA0KKwkJCQkJIHN0cnVj
dCBvZl9waGFuZGxlX2FyZ3MgKnNlbnNvcl9zcGVjcywNCisJCQkJCSB1MzIgKmlkKQ0KK3sNCisJ
cmV0dXJuIC1FTk9FTlQ7DQorfQ0KIHN0YXRpYyBpbmxpbmUgc3RydWN0IHRoZXJtYWxfem9uZV9k
ZXZpY2UgKg0KIHRoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAq
ZGV2LCBpbnQgaWQsIHZvaWQgKmRhdGEsDQogCQkJCWNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVf
b2ZfZGV2aWNlX29wcyAqb3BzKQ0KLS0gDQoyLjcuNA0KDQo=
