Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA7AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA54208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RuYhManX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfECLTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:19:52 -0400
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:40769
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbfECLTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfl+C8Pdn3tOZlH6um1JWP9IX3M26rcYnUTamup+VQs=;
 b=RuYhManXepJTfxwtZCC1s+duh2ujUUQb3BKf0EClc/wEUMEtbmt7sBoJWRj7X2036rlvOpIAV5Dq59i+nTHPtNFXr7RqR9pej86dIy1IxHUXEquaBwxA2TeTC+f5pQjKgqxvPkd0/PSsiGyiNazDaW3jDdkvTOFB1DeO8BXoZ7g=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5859.eurprd04.prod.outlook.com (20.178.202.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Fri, 3 May 2019 11:19:33 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 11:19:33 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] scripts/gdb: Print cached rate in lx-clk-summary
Thread-Topic: [PATCH 2/2] scripts/gdb: Print cached rate in lx-clk-summary
Thread-Index: AQHVAaIU9Nxde2bkokKBi3IR8Q3yGA==
Date:   Fri, 3 May 2019 11:19:32 +0000
Message-ID: <1a474318982a5f0125f2360c4161029b17f56bd1.1556881728.git.leonard.crestez@nxp.com>
References: <cover.1556881728.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1556881728.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VE1PR08CA0027.eurprd08.prod.outlook.com
 (2603:10a6:803:104::40) To AM0PR04MB6434.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5856d9b-2cd5-4a83-3de3-08d6cfb9372d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5859;
x-ms-traffictypediagnostic: AM0PR04MB5859:
x-microsoft-antispam-prvs: <AM0PR04MB5859751FC56B660511936D5FEE350@AM0PR04MB5859.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:451;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(43544003)(189003)(199004)(478600001)(256004)(66066001)(14454004)(6436002)(386003)(11346002)(446003)(66946007)(6512007)(2616005)(110136005)(316002)(476003)(6486002)(8676002)(66476007)(66556008)(64756008)(66446008)(99286004)(53936002)(3846002)(81156014)(81166006)(54906003)(118296001)(36756003)(6116002)(68736007)(8936002)(50226002)(44832011)(73956011)(14444005)(2906002)(486006)(305945005)(76176011)(52116002)(4326008)(102836004)(6506007)(25786009)(5660300002)(186003)(26005)(7736002)(86362001)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5859;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Iy7DgfnWmbFL2dilMP003aDmGHw19S+1WapC9v6qY1k88iwv2rqHE4S2xjmVqfBlf3INl5fGqIPJuEbNKVFwS1DAkdhWrZ70yH9SoWXZpMOQ4qJU4Eo/MAnRF0b3XBYKRDjfJ4l7plF5xoLgrnTx8J57ie0eKra2U9g+20luSlw5tWGs4seJ8QaAHcDxPGLoayR7YQUWzRb00+rdHwkiyANCHyI7uszGI09OieiWvsQ4My9Louj4cyOksL/I+nkxSF1aMAXcjxN9auqihon9pmCyjs9mJr2P1ip4GIrPLOF62E55L+/adteuTZZBtQzT/O/5spSFYKIgFHZTgdO8eHiIotpRd113v9Ffb6jTp9udbNQjPRq+Z2JBVVjklwbHsllh8mh++qVb4eAl+L3R2CtD7DCFoY2M3XMuJy8rBHg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5856d9b-2cd5-4a83-3de3-08d6cfb9372d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 11:19:32.4503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5859
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNsayByYXRlIGlzIGFsd2F5cyBzdG9yZWQgaW4gY2xrX2NvcmUgYnV0IG1pZ2h0IGJlIG91
dCBvZiBkYXRlIGFuZA0KcmVxdWlyZSBjYWxscyB0byB1cGRhdGUgZnJvbSBoYXJkd2FyZS4NCg0K
RGVhbCB3aXRoIHRoYXQgY2FzZSBieSBwcmludGluZyBhIChjKSBzdWZmaXguDQoNClNpZ25lZC1v
ZmYtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+DQoNCi0tLQ0K
IHNjcmlwdHMvZ2RiL2xpbnV4L2Nsay5weSAgICAgICAgICB8IDIxICsrKysrKysrKysrKysrLS0t
LS0tLQ0KIHNjcmlwdHMvZ2RiL2xpbnV4L2NvbnN0YW50cy5weS5pbiB8ICA0ICsrKysNCiAyIGZp
bGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9zY3JpcHRzL2dkYi9saW51eC9jbGsucHkgYi9zY3JpcHRzL2dkYi9saW51eC9jbGsucHkN
CmluZGV4IDZiZjcxOTc2YjU1ZC4uMDYxYWVjZmEyOTRlIDEwMDY0NA0KLS0tIGEvc2NyaXB0cy9n
ZGIvbGludXgvY2xrLnB5DQorKysgYi9zY3JpcHRzL2dkYi9saW51eC9jbGsucHkNCkBAIC0zLDQy
ICszLDQ5IEBADQogIyBDb3B5cmlnaHQgKGMpIE5YUCAyMDE5DQogDQogaW1wb3J0IGdkYg0KIGlt
cG9ydCBzeXMNCiANCi1mcm9tIGxpbnV4IGltcG9ydCB1dGlscywgbGlzdHMNCitmcm9tIGxpbnV4
IGltcG9ydCB1dGlscywgbGlzdHMsIGNvbnN0YW50cw0KIA0KIGNsa19jb3JlX3R5cGUgPSB1dGls
cy5DYWNoZWRUeXBlKCJzdHJ1Y3QgY2xrX2NvcmUiKQ0KIA0KIA0KIGRlZiBjbGtfY29yZV9mb3Jf
ZWFjaF9jaGlsZChobGlzdF9oZWFkKToNCiAgICAgcmV0dXJuIGxpc3RzLmhsaXN0X2Zvcl9lYWNo
X2VudHJ5KGhsaXN0X2hlYWQsDQogICAgICAgICAgICAgY2xrX2NvcmVfdHlwZS5nZXRfdHlwZSgp
LnBvaW50ZXIoKSwgImNoaWxkX25vZGUiKQ0KIA0KIA0KIGNsYXNzIEx4Q2xrU3VtbWFyeShnZGIu
Q29tbWFuZCk6DQotICAgICIiIlByaW50IExpbnV4IGtlcm5lbCBsb2cgYnVmZmVyLiIiIg0KKyAg
ICAiIiJQcmludCBjbGsgdHJlZSBzdW1tYXJ5DQorDQorT3V0cHV0IGlzIGEgc3Vic2V0IG9mIC9z
eXMva2VybmVsL2RlYnVnL2Nsay9jbGtfc3VtbWFyeQ0KKw0KK05vIGNhbGxzIGFyZSBtYWRlIGR1
cmluZyBwcmludGluZywgaW5zdGVhZCBhIChjKSBpZiBwcmludGVkIGFmdGVyIHZhbHVlcyB3aGlj
aA0KK2FyZSBjYWNoZWQgYW5kIHBvdGVudGlhbGx5IG91dCBvZiBkYXRlIiIiDQogDQogICAgIGRl
ZiBfX2luaXRfXyhzZWxmKToNCiAgICAgICAgIHN1cGVyKEx4Q2xrU3VtbWFyeSwgc2VsZikuX19p
bml0X18oImx4LWNsay1zdW1tYXJ5IiwgZ2RiLkNPTU1BTkRfREFUQSkNCiANCiAgICAgZGVmIHNo
b3dfc3VidHJlZShzZWxmLCBjbGssIGxldmVsKToNCi0gICAgICAgIGdkYi53cml0ZSgiJSpzJS0q
cyAlN2QgJThkICU4ZFxuIiAlICgNCisgICAgICAgIGdkYi53cml0ZSgiJSpzJS0qcyAlN2QgJThk
ICU4ZCAlMTFsdSVzXG4iICUgKA0KICAgICAgICAgICAgICAgICBsZXZlbCAqIDMgKyAxLCAiIiwN
CiAgICAgICAgICAgICAgICAgMzAgLSBsZXZlbCAqIDMsDQogICAgICAgICAgICAgICAgIGNsa1sn
bmFtZSddLnN0cmluZygpLA0KICAgICAgICAgICAgICAgICBjbGtbJ2VuYWJsZV9jb3VudCddLA0K
ICAgICAgICAgICAgICAgICBjbGtbJ3ByZXBhcmVfY291bnQnXSwNCi0gICAgICAgICAgICAgICAg
Y2xrWydwcm90ZWN0X2NvdW50J10pKQ0KKyAgICAgICAgICAgICAgICBjbGtbJ3Byb3RlY3RfY291
bnQnXSwNCisgICAgICAgICAgICAgICAgY2xrWydyYXRlJ10sDQorICAgICAgICAgICAgICAgICco
YyknIGlmIGNsa1snZmxhZ3MnXSAmIGNvbnN0YW50cy5MWF9DTEtfR0VUX1JBVEVfTk9DQUNIRSBl
bHNlICcgICAnKSkNCiANCiAgICAgICAgIGZvciBjaGlsZCBpbiBjbGtfY29yZV9mb3JfZWFjaF9j
aGlsZChjbGtbJ2NoaWxkcmVuJ10pOg0KICAgICAgICAgICAgIHNlbGYuc2hvd19zdWJ0cmVlKGNo
aWxkLCBsZXZlbCArIDEpDQogDQogICAgIGRlZiBpbnZva2Uoc2VsZiwgYXJnLCBmcm9tX3R0eSk6
DQotICAgICAgICBnZGIud3JpdGUoIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVu
YWJsZSAgcHJlcGFyZSAgcHJvdGVjdFxuIikNCi0gICAgICAgIGdkYi53cml0ZSgiICAgY2xvY2sg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvdW50ICAgIGNvdW50ICAgIGNvdW50XG4iKQ0KLSAg
ICAgICAgZ2RiLndyaXRlKCItLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS1cbiIpDQorICAgICAgICBnZGIud3JpdGUoIiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGVuYWJsZSAgcHJlcGFyZSAgcHJvdGVjdCAgICAgICAgICAgICAg
IFxuIikNCisgICAgICAgIGdkYi53cml0ZSgiICAgY2xvY2sgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvdW50ICAgIGNvdW50ICAgIGNvdW50ICAgICAgICByYXRlICAgXG4iKQ0KKyAgICAgICAg
Z2RiLndyaXRlKCItLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cbiIpDQogICAgICAgICBmb3IgY2xrIGluIGNsa19j
b3JlX2Zvcl9lYWNoX2NoaWxkKGdkYi5wYXJzZV9hbmRfZXZhbCgiY2xrX3Jvb3RfbGlzdCIpKToN
CiAgICAgICAgICAgICBzZWxmLnNob3dfc3VidHJlZShjbGssIDApDQogICAgICAgICBmb3IgY2xr
IGluIGNsa19jb3JlX2Zvcl9lYWNoX2NoaWxkKGdkYi5wYXJzZV9hbmRfZXZhbCgiY2xrX29ycGhh
bl9saXN0IikpOg0KICAgICAgICAgICAgIHNlbGYuc2hvd19zdWJ0cmVlKGNsaywgMCkNCiANCmRp
ZmYgLS1naXQgYS9zY3JpcHRzL2dkYi9saW51eC9jb25zdGFudHMucHkuaW4gYi9zY3JpcHRzL2dk
Yi9saW51eC9jb25zdGFudHMucHkuaW4NCmluZGV4IDc2ZjQ2ZjQyN2I5Ni4uMWQ3MzA4M2RhNmNi
IDEwMDY0NA0KLS0tIGEvc2NyaXB0cy9nZGIvbGludXgvY29uc3RhbnRzLnB5LmluDQorKysgYi9z
Y3JpcHRzL2dkYi9saW51eC9jb25zdGFudHMucHkuaW4NCkBAIC0xMCwxMCArMTAsMTEgQEANCiAg
Kg0KICAqIFRoaXMgd29yayBpcyBsaWNlbnNlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
UEwgdmVyc2lvbiAyLg0KICAqDQogICovDQogDQorI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRl
ci5oPg0KICNpbmNsdWRlIDxsaW51eC9mcy5oPg0KICNpbmNsdWRlIDxsaW51eC9ocnRpbWVyLmg+
DQogI2luY2x1ZGUgPGxpbnV4L21vdW50Lmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2ZkdC5oPg0K
ICNpbmNsdWRlIDxsaW51eC90aHJlYWRzLmg+DQpAQCAtMzYsMTAgKzM3LDEzIEBADQogLyogVGhl
IGJ1aWxkIHN5c3RlbSB3aWxsIHRha2UgY2FyZSBvZiBkZWxldGluZyBldmVyeXRoaW5nIGFib3Zl
IHRoaXMgbWFya2VyICovDQogPCEtLSBlbmQtYy1oZWFkZXJzIC0tPg0KIA0KIGltcG9ydCBnZGIN
CiANCisvKiBsaW51eC9jbGstcHJvdmlkZXIuaCAqLw0KK0xYX0dEQlBBUlNFRChDTEtfR0VUX1JB
VEVfTk9DQUNIRSkNCisNCiAvKiBsaW51eC9mcy5oICovDQogTFhfVkFMVUUoU0JfUkRPTkxZKQ0K
IExYX1ZBTFVFKFNCX1NZTkNIUk9OT1VTKQ0KIExYX1ZBTFVFKFNCX01BTkRMT0NLKQ0KIExYX1ZB
TFVFKFNCX0RJUlNZTkMpDQotLSANCjIuMTcuMQ0KDQo=
