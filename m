Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0132C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7909B26BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mPsYFip7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfEaQUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:20:42 -0400
Received: from mail-eopbgr750050.outbound.protection.outlook.com ([40.107.75.50]:9952
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfEaQUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G2+Q7rX0fiQEpU/UkandYOiZEAI+aj/mnDSpAZhWvI=;
 b=mPsYFip7/TZS2UZgWHr4L4e5gPI4l70SexvJmCKW6SngnJjqA9r/G8d5e5CEygtSvif8E09wWVC2QLtrZhnCNDZiwN1PDS8uNQIjYrY9X3HI5E3nUk3Oc3Bsaa5XfC59u9zbPY9LL1ZMG9l0rG5QKpKMjASk+xcE9htZzpbPcyY=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1800.namprd12.prod.outlook.com (10.175.63.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 16:20:38 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::38d5:5f22:2510:9e44]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::38d5:5f22:2510:9e44%9]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 16:20:38 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Phillips, Kim" <kim.phillips@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        =?utf-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PATCH RESEND] perf vendor events amd: add L3 cache events for Family
 17h
Thread-Topic: [PATCH RESEND] perf vendor events amd: add L3 cache events for
 Family 17h
Thread-Index: AQHVF8zIvbaFaoypXEqtoo3CaBUOTw==
Date:   Fri, 31 May 2019 16:20:38 +0000
Message-ID: <20190531162027.25895-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:805:8e::39) To CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 746cc795-9963-4057-11c9-08d6e5e3eaf9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR12MB1800;
x-ms-traffictypediagnostic: CY4PR12MB1800:
x-microsoft-antispam-prvs: <CY4PR12MB1800575B12D620627396991487190@CY4PR12MB1800.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(66946007)(64756008)(66556008)(66476007)(66446008)(73956011)(50226002)(110136005)(36756003)(486006)(66574012)(316002)(66066001)(6512007)(1076003)(25786009)(6116002)(102836004)(6436002)(52116002)(386003)(6506007)(2906002)(3846002)(86362001)(26005)(6486002)(4326008)(14454004)(99286004)(2616005)(476003)(53936002)(54906003)(71190400001)(7416002)(14444005)(305945005)(2501003)(68736007)(478600001)(5660300002)(7736002)(186003)(8936002)(256004)(81156014)(8676002)(71200400001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1800;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XUkFN7cj5iAEboeKu5SAfdraL1zsHmkZDXH7HnwQ+yCw1D5sfE8ZiF2rFwmj7uoFWffNko1I/qfU0C39kGwsTnHwLgeYNA6DbZmnmxnVflN87qUzZX4CM2xVUNhlEg7uBvdlS2+sUN4OG7cp7IskhRdf/zmPL9HgSv/zjvBcO/qzgH4zgWuq1LO2HvTiqV/mmoG2JvxXYYv8UG2tPc7/LOW40DIA7N/0+VJ1fJpJcCw5Sbzt77RlABY4Src2HoCho7IDCpIA36Cc9CNfr35/htNvAIolHl5KUFcsrzHoGkmJJnryiiVYlHTC5ll1AhodkFwXZ5vlVlU9fY9U3AvpcPPwEet7A+iSbzVD6WfZ8IQVP/OVaAtizoOE+sGsK/azetVmcCGh3cqNkjq4pDQSqJ1/UwrPNwSL/JhPVSoqH5s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4908B499F0B0E74BB378B26E9B9FCF2F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746cc795-9963-4057-11c9-08d6e5e3eaf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 16:20:38.5174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kphillips@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1800
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
