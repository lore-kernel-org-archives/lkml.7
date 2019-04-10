Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D38C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7350521841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="oyF1LPwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfDJMti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:49:38 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:55681
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730758AbfDJMth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc8upti9x5DMkmU0IPIRwe3PfphRMo9M60ROkOBSjJ4=;
 b=oyF1LPwvPT7JncES76alXXvDUkrBnUYmI3M7GOWnS9uCF7iLqIiR1+xJdeY1DxKvNjn020e6tvZslELGhPHWD1yx0ajHYxbAhN2+Z6dOVh18NT7Xbus9wRIDzeuGds13WcSHGpgUeGnLg/zCTCTpzLiDX5fye/vPlLtOSR97tt4=
Received: from DM5PR05MB3292.namprd05.prod.outlook.com (10.174.191.31) by
 DM5PR05MB2828.namprd05.prod.outlook.com (10.168.177.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Wed, 10 Apr 2019 12:49:34 +0000
Received: from DM5PR05MB3292.namprd05.prod.outlook.com
 ([fe80::1872:e9e:7779:4b4c]) by DM5PR05MB3292.namprd05.prod.outlook.com
 ([fe80::1872:e9e:7779:4b4c%2]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 12:49:34 +0000
From:   Bryan Tan <bryantan@vmware.com>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bryan Tan <bryantan@vmware.com>
Subject: [PATCH] watchdog: wdat_wdt: fix get_timeleft call for wdat_wdt
Thread-Topic: [PATCH] watchdog: wdat_wdt: fix get_timeleft call for wdat_wdt
Thread-Index: AQHU75vYKEDScG67k0a+4y5dahf8cA==
Date:   Wed, 10 Apr 2019 12:49:33 +0000
Message-ID: <20190410124813.86892-1-bryantan@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::14) To DM5PR05MB3292.namprd05.prod.outlook.com
 (2603:10b6:4:3e::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bryantan@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1 (Apple Git-117)
x-originating-ip: [212.36.145.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd353b36-c1c3-423a-f7a7-08d6bdb2f79e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR05MB2828;
x-ms-traffictypediagnostic: DM5PR05MB2828:
x-microsoft-antispam-prvs: <DM5PR05MB2828E549F1D6064AC072368CB22E0@DM5PR05MB2828.namprd05.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(366004)(376002)(199004)(189003)(50226002)(55236004)(6436002)(102836004)(36756003)(59246006)(6506007)(386003)(186003)(6116002)(3846002)(105586002)(26005)(54906003)(2906002)(99286004)(6486002)(52116002)(486006)(106356001)(476003)(2616005)(316002)(71190400001)(71200400001)(109986005)(86362001)(7736002)(6512007)(1671002)(107886003)(25786009)(305945005)(4326008)(14454004)(53936002)(68736007)(8936002)(1076003)(14444005)(66066001)(8676002)(256004)(4744005)(81156014)(81166006)(478600001)(97736004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR05MB2828;H:DM5PR05MB3292.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RPbOQIFJEyrpH+j017Q8tI2VA33mXkglHud72Uf3pYyy3+XN3Oy08IzmFwT76a1s9VQ8fAMV6TMQSkp5dGJj0g2V7Z9HZdSP8FHWa3XH7J1SDs+SihtEGw858d7POZhjsPdvxsZ2E56SXKhx9MTdxjkkGSQhcZr+05hMrqNqTP6nsJ0FKVu6tH8O5fobU/h/XtP2gjM7HB5/xDHnZSm2WaW0c9xcD4P1CvwPwKSz6rRXtdF+WFVE5Q5KdBxafmG1DgWqN+zpfAGQP+R7pkUqwpoaBNoAUdi3yNg8/Zrjjpr9CYRibQ5tZshkybKmA9W937CaIb3Vjmaj37Dwd1VSHj2OnwoB0Aq88TIs5QxYFWLjQU1aBy36j6K7s9wh9PaMuEDLYaoUkvdJJP4m+he70ODa3ZhPDnDmyox97RBxiDA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd353b36-c1c3-423a-f7a7-08d6bdb2f79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 12:49:33.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB2828
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGdldF90aW1lbGVmdCBjYWxsIGZvciB3ZGF0X3dkdCB3YXMgdXNpbmcgQUNQSV9XREFUX0dF
VF9DT1VOVERPV04NCndoZW4gcnVubmluZyBhbiBhY3Rpb24gb24gdGhlIGRldmljZSwgd2hpY2gg
d291bGQgcmV0dXJuIHRoZSBjb25maWd1cmVkDQpjb3VudGRvd24sIGluc3RlYWQgb2YgQUNQSV9X
REFUX0dFVF9DVVJSRU5UX0NPVU5URE9XTiwgd2hpY2ggcmV0dXJucyB0aGUNCnRpbWUgbGVmdCBi
ZWZvcmUgdGhlIHdhdGNoZG9nIHdpbGwgZmlyZS4gVGhpcyBjaGFuZ2UgY29ycmVjdHMgdGhhdC4N
Cg0KU2lnbmVkLW9mZi1ieTogQnJ5YW4gVGFuIDxicnlhbnRhbkB2bXdhcmUuY29tPg0KLS0tDQog
ZHJpdmVycy93YXRjaGRvZy93ZGF0X3dkdC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRv
Zy93ZGF0X3dkdC5jIGIvZHJpdmVycy93YXRjaGRvZy93ZGF0X3dkdC5jDQppbmRleCA1NmFkMTk2
Li4zODc4OTJmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy93YXRjaGRvZy93ZGF0X3dkdC5jDQorKysg
Yi9kcml2ZXJzL3dhdGNoZG9nL3dkYXRfd2R0LmMNCkBAIC0yODcsNyArMjg3LDcgQEAgc3RhdGlj
IHVuc2lnbmVkIGludCB3ZGF0X3dkdF9nZXRfdGltZWxlZnQoc3RydWN0IHdhdGNoZG9nX2Rldmlj
ZSAqd2RkKQ0KIAlzdHJ1Y3Qgd2RhdF93ZHQgKndkYXQgPSB0b193ZGF0X3dkdCh3ZGQpOw0KIAl1
MzIgcGVyaW9kcyA9IDA7DQogDQotCXdkYXRfd2R0X3J1bl9hY3Rpb24od2RhdCwgQUNQSV9XREFU
X0dFVF9DT1VOVERPV04sIDAsICZwZXJpb2RzKTsNCisJd2RhdF93ZHRfcnVuX2FjdGlvbih3ZGF0
LCBBQ1BJX1dEQVRfR0VUX0NVUlJFTlRfQ09VTlRET1dOLCAwLCAmcGVyaW9kcyk7DQogCXJldHVy
biBwZXJpb2RzICogd2RhdC0+cGVyaW9kIC8gMTAwMDsNCiB9DQogDQotLSANCjIuNi4yDQoNCg==
