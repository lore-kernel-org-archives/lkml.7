Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13889C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A792089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W1dW/vG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfEVW2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:28:23 -0400
Received: from mail-eopbgr770082.outbound.protection.outlook.com ([40.107.77.82]:5848
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726781AbfEVW2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G2+Q7rX0fiQEpU/UkandYOiZEAI+aj/mnDSpAZhWvI=;
 b=W1dW/vG1PClO0fx1E4ZwM/2eKbMJ4JK/eDTOPEbjONdq1or0XtOGMXGNIKFs1HOgFGrujHlMSQd1FNrRuWlfu5Yx7Oo5z0Mz24xsWN4X46LUZZvIxPdvD5krsAUYwbOtBuNVx0k4j4S0c/29FrCHZjKCfEYea6kC0EwExFJQTEY=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1175.namprd12.prod.outlook.com (10.168.167.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Wed, 22 May 2019 22:28:10 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::1ced:c975:7f66:c066]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::1ced:c975:7f66:c066%4]) with mapi id 15.20.1922.016; Wed, 22 May 2019
 22:28:10 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Phillips, Kim" <kim.phillips@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        =?utf-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PATCH] perf vendor events amd: add L3 cache events for Family 17h
Thread-Topic: [PATCH] perf vendor events amd: add L3 cache events for Family
 17h
Thread-Index: AQHVEO2jkZFC1Zh4lkagKtJsFSyxRQ==
Date:   Wed, 22 May 2019 22:28:10 +0000
Message-ID: <20190522222756.10323-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0024.namprd04.prod.outlook.com
 (2603:10b6:803:21::34) To CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e86d709-be1c-4849-af24-08d6df04c55b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CY4PR12MB1175;
x-ms-traffictypediagnostic: CY4PR12MB1175:
x-microsoft-antispam-prvs: <CY4PR12MB117554E03C3A24BB1BA61F4787000@CY4PR12MB1175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(68736007)(5660300002)(102836004)(86362001)(486006)(66446008)(186003)(26005)(6116002)(3846002)(25786009)(66946007)(66476007)(73956011)(476003)(2616005)(64756008)(66556008)(66066001)(7416002)(71200400001)(71190400001)(99286004)(6506007)(386003)(66574012)(2501003)(54906003)(1076003)(52116002)(305945005)(316002)(6916009)(81156014)(8936002)(7736002)(478600001)(81166006)(8676002)(50226002)(36756003)(6486002)(6436002)(2351001)(2906002)(4326008)(14444005)(256004)(6512007)(53936002)(5640700003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1175;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XhuiOP5jx/c0kGe9LumagJWxUJYXbFBzdYZQdHilBpmb6ylvypnOou8J9RseWz+iq69FOoewcZk0KqmvH0dP9PldrBMFHnA36rGfuLe5RV80jx6DB4BAK7nI4wBMskH7RlNzdnXFyWypsu6L8u+AonuK1NbW4zGSoIB501AR84e8AFhFl8GGLwHo5PItiGdKPxHPWGEvi/9oC6oxua2PL9HXze0iYeM5FxP6hJwSK6RNAgYDHrtg7Zc58C69AssTijeFD2dPmF7Fhwby6OUOWNYgsuKqlprgv9UWNrDy8jsza2gBsOVVGAQQT7gQRKIUB7/vC/KAsVuMsbDbLNdofF747sJSdMqLuSAAmseNmErGgkw5mBL5Om6vqi7KtYkLPxL6/KZrPi0OiDrfbufvZUeP1G+eXPV2azVz2ls4eQo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC56069AA36BAE4CA1DDB3E348D426EC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e86d709-be1c-4849-af24-08d6df04c55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 22:28:10.6279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2ltIFBoaWxsaXBzIDxraW0ucGhpbGxpcHNAYW1kLmNvbT4NCg0KQWxsb3cgdXNlcnMg
dG8gc3ltYm9saWNhbGx5IHNwZWNpZnkgTDMgZXZlbnRzIGZvciBGYW1pbHkgMTdoIHByb2Nlc3Nv
cnMNCnVzaW5nIHRoZSBleGlzdGluZyBBTUQgVW5jb3JlIGRyaXZlci4NCg0KU2lnbmVkLW9mZi1i
eTogS2ltIFBoaWxsaXBzIDxraW0ucGhpbGxpcHNAYW1kLmNvbT4NCkNjOiBKYW5ha2FyYWphbiBO
YXRhcmFqYW4gPEphbmFrYXJhamFuLk5hdGFyYWphbkBhbWQuY29tPg0KQ2M6IFBldGVyIFppamxz
dHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCkNjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0
LmNvbT4NCkNjOiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAa2VybmVsLm9yZz4NCkNj
OiBBbGV4YW5kZXIgU2hpc2hraW4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+
DQpDYzogQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPg0KQ2M6IEppcmkgT2xzYSA8am9s
c2FAcmVkaGF0LmNvbT4NCkNjOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+DQpD
YzogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KQ2M6ICJNYXJ0aW4gTGnFoWthIiA8bWxp
c2thQHN1c2UuY3o+DQpDYzogVGhvbWFzIFJpY2h0ZXIgPHRtcmljaHRAbGludXguaWJtLmNvbT4N
CkNjOiBIZW5kcmlrIEJydWVja25lciA8YnJ1ZWNrbmVyQGxpbnV4LmlibS5jb20+DQpDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KLS0tDQogLi4uL3BlcmYvcG11LWV2ZW50cy9hcmNo
L3g4Ni9hbWRmYW0xN2gvY2FjaGUuanNvbiAgfCAxNCArKysrKysrKysrKysrKw0KIHRvb2xzL3Bl
cmYvcG11LWV2ZW50cy9qZXZlbnRzLmMgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIDIgZmls
ZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9w
bXUtZXZlbnRzL2FyY2gveDg2L2FtZGZhbTE3aC9jYWNoZS5qc29uIGIvdG9vbHMvcGVyZi9wbXUt
ZXZlbnRzL2FyY2gveDg2L2FtZGZhbTE3aC9jYWNoZS5qc29uDQppbmRleCA1ZDlmOWUxNzI3NDMu
LmUzOGFkZjg5MjdhZSAxMDA2NDQNCi0tLSBhL3Rvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL3g4
Ni9hbWRmYW0xN2gvY2FjaGUuanNvbg0KKysrIGIvdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gv
eDg2L2FtZGZhbTE3aC9jYWNoZS5qc29uDQpAQCAtMzExLDUgKzMxMSwxOSBAQA0KICAgICAiQnJp
ZWZEZXNjcmlwdGlvbiI6ICJUb3RhbCBjeWNsZXMgc3BlbnQgd2l0aCBvbmUgb3IgbW9yZSBmaWxs
IHJlcXVlc3RzIGluIGZsaWdodCBmcm9tIEwyLiIsDQogICAgICJQdWJsaWNEZXNjcmlwdGlvbiI6
ICJUb3RhbCBjeWNsZXMgc3BlbnQgd2l0aCBvbmUgb3IgbW9yZSBmaWxsIHJlcXVlc3RzIGluIGZs
aWdodCBmcm9tIEwyLiIsDQogICAgICJVTWFzayI6ICIweDEiDQorICB9LA0KKyAgew0KKyAgICAi
RXZlbnROYW1lIjogImwzX3JlcXVlc3RfZzEuY2FjaGluZ19sM19jYWNoZV9hY2Nlc3NlcyIsDQor
ICAgICJFdmVudENvZGUiOiAiMHgwMSIsDQorICAgICJCcmllZkRlc2NyaXB0aW9uIjogIkwzIGNh
Y2hlIGFjY2Vzc2VzIiwNCisgICAgIlVNYXNrIjogIjB4ODAiLA0KKyAgICAiVW5pdCI6ICJMM1BN
QyINCisgIH0sDQorICB7DQorICAgICJFdmVudE5hbWUiOiAibDNfY29tYl9jbHN0cl9zdGF0ZS5y
ZXF1ZXN0X21pc3MiLA0KKyAgICAiRXZlbnRDb2RlIjogIjB4MDYiLA0KKyAgICAiQnJpZWZEZXNj
cmlwdGlvbiI6ICJMMyBjYWNoZSBtaXNzZXMiLA0KKyAgICAiVU1hc2siOiAiMHgwMSIsDQorICAg
ICJVbml0IjogIkwzUE1DIg0KICAgfQ0KIF0NCmRpZmYgLS1naXQgYS90b29scy9wZXJmL3BtdS1l
dmVudHMvamV2ZW50cy5jIGIvdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2pldmVudHMuYw0KaW5kZXgg
NThmNzdmZDBmNTlmLi5mYjJjYzk4YzViMGUgMTAwNjQ0DQotLS0gYS90b29scy9wZXJmL3BtdS1l
dmVudHMvamV2ZW50cy5jDQorKysgYi90b29scy9wZXJmL3BtdS1ldmVudHMvamV2ZW50cy5jDQpA
QCAtMjM2LDYgKzIzNiw3IEBAIHN0YXRpYyBzdHJ1Y3QgbWFwIHsNCiAJeyAiQ1BVLU0tQ0YiLCAi
Y3B1bV9jZiIgfSwNCiAJeyAiQ1BVLU0tU0YiLCAiY3B1bV9zZiIgfSwNCiAJeyAiVVBJIExMIiwg
InVuY29yZV91cGkiIH0sDQorCXsgIkwzUE1DIiwgImFtZF9sMyIgfSwNCiAJe30NCiB9Ow0KIA0K
LS0gDQoyLjIxLjANCg==
