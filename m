Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BF4C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C592089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I8LbVOy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfECLTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:19:35 -0400
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:40769
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbfECLTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TmTahHCBNWFPCJExfqYFjyX7VBn88No3244GdyV/vM=;
 b=I8LbVOy2i7C2r+19dXpQgrMJi2romUcH3UzilzpfHukf11JciV7kqHBOy8UvoJX0lRJ9OYGXkgbH1wrAXGXrTz9R03dkMD0WBovsJaxqo5COQZ9wVIYtUXvuoo7cjZz80szootl0Qy4ErWitrSY1GK/XDTKMHfV1mVH8vcH31Z4=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5859.eurprd04.prod.outlook.com (20.178.202.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Fri, 3 May 2019 11:19:30 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 11:19:30 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] gdb/scripts: Improve lx-clk-summary
Thread-Topic: [PATCH 0/2] gdb/scripts: Improve lx-clk-summary
Thread-Index: AQHVAaITaVxkbZFe1kuCtvvT+0qG3Q==
Date:   Fri, 3 May 2019 11:19:30 +0000
Message-ID: <cover.1556881728.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2ac0f060-6232-4c4c-2551-08d6cfb93621
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5859;
x-ms-traffictypediagnostic: AM0PR04MB5859:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB585956A3F5DD0939258C3FB7EE350@AM0PR04MB5859.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(478600001)(256004)(66066001)(966005)(14454004)(6306002)(6436002)(386003)(66946007)(6512007)(2616005)(110136005)(316002)(476003)(6486002)(8676002)(66476007)(66556008)(64756008)(66446008)(99286004)(53936002)(3846002)(81156014)(81166006)(54906003)(36756003)(6116002)(68736007)(8936002)(50226002)(44832011)(73956011)(2906002)(486006)(305945005)(52116002)(4326008)(102836004)(6506007)(25786009)(5660300002)(186003)(26005)(7736002)(86362001)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5859;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5YzIV5TdvP9RDWtj+/pFCW8PQ14PQYUvURPgPhaOY5ErwdqhXCodMjZ5PVXztfvQfNar0fnp8HMMmqXpvjhcoW9BDxGsItTEpqlS95i3+nAhiVWplXVTORCagjShIx72z/8/CLsaDIzBQsLW5E4mGznVYG/DMHRfR5rBoZF9MoY47cM0/jXRt7QL+kbeZZzo4bMqJyB70vqj3T3UI96zMOY1Ts3zhGkwN148MdU7Lkt0RqiVFV+HB8vDQjmdp6RL8t3pMwwQwpGLlmiyLwWjsUEMkHVOpSM0IazG7NaIZvNxFdSgT3YGdUr3oNlXyVswSrg/bdvYJcUij3edR+33QgTOo5IfRsyNfVaLqp1sGMxN2bn+5JwQb5kdN15NVoL/MpCoPrz3mjakmhXO6NqI8TxYWYFzs5dFjwL0tXfyXTE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac0f060-6232-4c4c-2551-08d6cfb93621
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 11:19:30.8172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5859
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGVhcmxpZXIgc2VyaWVzIGFkZGluZyBjbGsgc3VwcG9ydCB0byBnZGIvc2NyaXB0cyB3YXMg
cXVpY2tseQ0KYWNjZXB0ZWQgYnV0IHNvbWUgY29uY2VybnMgd2VyZSByYWlzZWQgYnkgU3RlcGhl
biBCb3lkIHNvIHRoaXMgc2VyaWVzDQphdHRlbXB0cyB0byBhZGRyZXNzIHRoZW0uDQoNCkxpbmsg
dG8gcHJldmlvdXMgc2VyaWVzOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS80LzIyLzU1DQoN
ClRoaXMgaXMgbm90IGEgdjIgYW5kIHNxdWFzaGluZyBpcyBub3QgZXhwZWN0ZWQuDQoNCkZpZWxk
cyBvdGhlciB0aGFuIGNsayByYXRlIG5vdCBjb3ZlcmVkIGJlY2F1c2UgdGhleSdyZSBtdWNoIG1v
cmUgcmFyZWx5DQp1c2VkIGFuZCBjYWNoZSBsb2dpYyBjYW4gZ2V0IG1vcmUgY29tcGxpY2F0ZWQg
YW5kIGJyaXR0bGUuDQoNCkxYX0dEQlBBUlNFRCBpcyB1c2VkIGluIGNvbnN0YW50cy5weS5pbiBi
ZWNhdXNlIHB5dGhvbiBkb2VzIG5vdA0KdW5kZXJzdGFuZCBDIGludGVnZXIgbGl0ZXJhbCBzdWZm
aXhlcyBsaWtlIHRoZSAiMVVMIiBmcm9tIHRoZSBkZWZpbml0aW9uDQpvZiBCSVQoKSB1c2VkIGJ5
IENMS19HRVRfUkFURV9OT0NBQ0hFLiBBbHRlcm5hdGl2ZSB3b3JrYXJvdW5kcyB3b3VsZCBiZQ0K
aGFja2luZyBhd2F5IFVMIHN1ZmZpeGVzIHdpdGggc2VkIG9yIHJlZGVmaW5pbmcgQklUJmNvIGJ1
dCByZWx5aW5nIG9uDQpnZGIgZXZhbHVhdGlvbiBpcyBlYXNpZXIgYW5kIG11Y2ggbW9yZSBmbGV4
aWJsZS4NCg0KTGVvbmFyZCBDcmVzdGV6ICgyKToNCiAgc2NyaXB0cy9nZGI6IENsZWFudXAgZXJy
b3IgaGFuZGxpbmcgaW4gbGlzdCBoZWxwZXJzDQogIHNjcmlwdHMvZ2RiOiBQcmludCBjYWNoZWQg
cmF0ZSBpbiBseC1jbGstc3VtbWFyeQ0KDQogc2NyaXB0cy9nZGIvbGludXgvY2xrLnB5ICAgICAg
ICAgIHwgMjEgKysrKysrKysrKysrKystLS0tLS0tDQogc2NyaXB0cy9nZGIvbGludXgvY29uc3Rh
bnRzLnB5LmluIHwgIDQgKysrKw0KIHNjcmlwdHMvZ2RiL2xpbnV4L2xpc3RzLnB5ICAgICAgICB8
IDEwICsrLS0tLS0tLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDE1IGRl
bGV0aW9ucygtKQ0KDQotLSANCjIuMTcuMQ0KDQo=
