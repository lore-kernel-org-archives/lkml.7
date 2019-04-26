Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8519FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F30206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g388yM8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfDZGz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:55:58 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:49537
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfDZGz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oitB9cAJAe6yp15cJyFTAfn4cB+2hG/zWuzePDEmJkA=;
 b=g388yM8VgYq6jXo9xseOk1hVV19nTa9xVHiwuELVUVQqomdf73TgXb2RaCXHHzBRJjkyt6nPSmrAZr27CJpdnW4OwC48AIcBS9JJnyPyokwjsxhzit/MZ7d44y02VCjsaNrc1H5QJ5cpS1+jK9OjfaKNWvmgQ/FjUQ2NiEgcOhc=
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com (20.177.32.218) by
 AM6PR04MB6294.eurprd04.prod.outlook.com (20.179.7.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 06:55:55 +0000
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::2c:6837:2927:a618]) by AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::2c:6837:2927:a618%3]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 06:55:55 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Andy Tang <andy.tang@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4] cpufreq: qoriq: add support for lx2160a
Thread-Topic: [PATCH v4] cpufreq: qoriq: add support for lx2160a
Thread-Index: AQHU+/0YoMkczGxbgEqQ3+d1tNVJlw==
Date:   Fri, 26 Apr 2019 06:55:55 +0000
Message-ID: <1556261743-20584-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To AM6PR04MB4789.eurprd04.prod.outlook.com
 (2603:10a6:20b:3::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91c228b4-15a6-485e-19fa-08d6ca143a75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6294;
x-ms-traffictypediagnostic: AM6PR04MB6294:
x-microsoft-antispam-prvs: <AM6PR04MB6294EE645F880F3734ADC25CF33E0@AM6PR04MB6294.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(68736007)(2501003)(81156014)(86362001)(2616005)(256004)(26005)(4326008)(486006)(316002)(44832011)(186003)(8676002)(476003)(66066001)(6506007)(386003)(6486002)(36756003)(2906002)(6436002)(6116002)(3846002)(478600001)(66476007)(102836004)(54906003)(99286004)(25786009)(73956011)(66946007)(5660300002)(66556008)(64756008)(66446008)(110136005)(7736002)(8936002)(6512007)(52116002)(305945005)(81166006)(71200400001)(50226002)(14454004)(53936002)(97736004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6294;H:AM6PR04MB4789.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rWIBHd9b6ScRWOe9V1d2v3wCzngifYAGqvDidyr53huponzFDJuqLEBLIVC/MWmhFfs8NEnSW6FVf7ozEONHDr2X0TQNQrd4q6jG92DIp/yqldh5vugW+h8Vfn98VY7eHI6/QYkKRwOdwJE+AtMZqR0jTnU8UO0OD+YHVVIFWJ6GGi4ksvlfe+OEo8D5pJUn3qO+CasnCV8xgoE2UlvK4OhNgl9CRnEmEdlmekGin+k+cdvGHDfkNFpH+pdld5bL0tNyFmDQugn/GJ/Nwi0q6+dN2Trfd57FBShsSeasbg6Yx6WfDHYts04RUiDXcorEkL6l7+gnZf2a8ZaqnKKhazYZTjRjcYfQwjPTX1IK9mWjOhJodUPnnquroIVCxu2lKex+xKgISf8c5t0qoJxg9wt6fLr++F700rTBlCxkCZc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c228b4-15a6-485e-19fa-08d6ca143a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 06:55:55.1795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW5hYmxlIHN1cHBvcnQgb2YgTlhQIFNvQyBseDIxNjBhIHRvIGhhbmRsZSB0aGUNCmx4MjE2MGEg
U29DLg0KDQpTaWduZWQtb2ZmLWJ5OiBUYW5nIFl1YW50aWFuIDxhbmR5LnRhbmdAbnhwLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCkFj
a2VkLWJ5OiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0Pg0KQWNrZWQtYnk6IFN0ZXBoZW4g
Qm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCkFja2VkLWJ5OiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5r
dW1hckBsaW5hcm8ub3JnPg0KLS0tDQpDaGFuZ2VzIGZvciB2NDoNCi0gSW5jb3Jwb3JhdGVkIHJl
dmlldyBjb21tZW50cyBmcm9tIFN0ZXBoZW4gQm95ZA0KDQpDaGFuZ2VzIGZvciB2MzoNCi0gSW5j
b3Jwb3JhdGVkIHJldmlldyBjb21tZW50cyBvZiBSYWZhZWwgSi4gV3lzb2NraQ0KLSBVcGRhdGVk
IGNvbW1pdCBtZXNzYWdlDQoNCkNoYW5nZXMgZm9yIHYyOg0KLSBTdWJqZWN0IGxpbmUgdXBkYXRl
ZA0KDQogZHJpdmVycy9jcHVmcmVxL3FvcmlxLWNwdWZyZXEuYyB8IDEgKw0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL3Fvcmlx
LWNwdWZyZXEuYyBiL2RyaXZlcnMvY3B1ZnJlcS9xb3JpcS1jcHVmcmVxLmMNCmluZGV4IDQyOTVl
NTQuLjgxZjAyODggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NwdWZyZXEvcW9yaXEtY3B1ZnJlcS5j
DQorKysgYi9kcml2ZXJzL2NwdWZyZXEvcW9yaXEtY3B1ZnJlcS5jDQpAQCAtMjg0LDYgKzI4NCw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG5vZGVfbWF0Y2hlc1tdIF9faW5p
dGNvbnN0ID0gew0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxsczEwNDZhLWNsb2NrZ2VuIiwgfSwN
CiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMxMDg4YS1jbG9ja2dlbiIsIH0sDQogCXsgLmNvbXBh
dGlibGUgPSAiZnNsLGxzMjA4MGEtY2xvY2tnZW4iLCB9LA0KKwl7IC5jb21wYXRpYmxlID0gImZz
bCxseDIxNjBhLWNsb2NrZ2VuIiwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wscDQwODAtY2xv
Y2tnZW4iLCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxxb3JpcS1jbG9ja2dlbi0xLjAiLCB9
LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxxb3JpcS1jbG9ja2dlbi0yLjAiLCB9LA0KLS0gDQoy
LjcuNA0KDQo=
