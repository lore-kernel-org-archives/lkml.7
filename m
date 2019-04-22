Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA014C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05CF20857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cMMpmBKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfDVI1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:27:10 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:46981
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbfDVI1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQG9+EicDDqiO3pPblGHcLfoEohoSMr16D5NCPgk8Bs=;
 b=cMMpmBKlYU/6lMokmpKJ6wm0UBi8hZ1AarDnKAJ0e5FkrxDJ7tCEB3+xqC7+hW8Ta6kYMjcAT4609jFDTNTi3reoERmPVMsyOPm6Dzclnj93OvLGjxgxzBz7kyYJDd+2z51PPrdRiS2vAvrjXPQ8+ySNBjVoDGgbT23HtZWrFsQ=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5583.eurprd04.prod.outlook.com (20.178.123.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 08:26:57 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822%4]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 08:26:57 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] scripts/gdb: Initial clk support: lx-clk-summary
Thread-Topic: [PATCH 2/3] scripts/gdb: Initial clk support: lx-clk-summary
Thread-Index: AQHU+OUmB+Asb7UQREqOu/CEABG59w==
Date:   Mon, 22 Apr 2019 08:26:57 +0000
Message-ID: <ab7b65d29dbd7623c679c4ef91352d594a24f39a.1555921081.git.leonard.crestez@nxp.com>
References: <cover.1555921081.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1555921081.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.146.100.6]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR08CA0227.eurprd08.prod.outlook.com
 (2603:10a6:802:15::36) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a044afa-bf15-406d-ff73-08d6c6fc4873
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5583;
x-ms-traffictypediagnostic: VI1PR04MB5583:
x-microsoft-antispam-prvs: <VI1PR04MB55837D2A5A5BDB119B097795EE220@VI1PR04MB5583.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(68736007)(305945005)(99286004)(6512007)(2906002)(54906003)(316002)(110136005)(52116002)(76176011)(53936002)(7736002)(97736004)(36756003)(386003)(6506007)(102836004)(26005)(66446008)(64756008)(6116002)(8676002)(186003)(71190400001)(71200400001)(66476007)(81166006)(81156014)(86362001)(66556008)(2616005)(4326008)(486006)(66946007)(5660300002)(476003)(73956011)(11346002)(25786009)(44832011)(8936002)(50226002)(118296001)(3846002)(6486002)(256004)(6436002)(14454004)(478600001)(446003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5583;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zh69m6YLjqrZj/E38I+Kx3Q6GMGWbLwFcI7Y4dKIoTlH1YIniDC0QhaxYF3iq2z5RJW+CWaiC9YhH3ES9R1C2BpNTON7GApyMHq6crUtj/R4nYxsQSkx1lR2CBAvMDFuAM7J0Z80pIBJwqBRbBA9WK2qH5Z/0cRsTyQyzfJ2XYH2rz3ohVVulfOM9D2TwP2KZIJOApaalJjDv5Ut6iym9SEN94u3o8ura1wotKSDyfoplU1yEB2kUEFfoPJt9UDHTDpk83YK1NrScboTlGRdZ5vW9d/mxXVJ1V51Dy/4IZvI0KX6fC8p8VAogDWr/qh2SggbOA8lgTb3IO7Cy01SznUWHBtx6ldOlDWdt8TPA2TKf8E8R/U2El092sl4ITmjCZot2Dc8JdTTh+Ih337SI5PwsTHPhdaypC25WFfgX1c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a044afa-bf15-406d-ff73-08d6c6fc4873
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 08:26:57.1685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFuIGx4LWNsay1zdW1tYXJ5IGNvbW1hbmQgd2hpY2ggcHJpbnRzIGEgc3Vic2V0IG9mDQov
c3lzL2tlcm5lbC9kZWJ1Zy9jbGsvY2xrX3N1bW1hcnkuDQoNClRoaXMgY2FuIGJlIHVzZWQgdG8g
ZXhhbWluZSBoYW5ncyBjYXVzZWQgYnkgY2xrIG5vdCBiZWluZyBlbmFibGVkLg0KDQpTaWduZWQt
b2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KLS0tDQog
c2NyaXB0cy9nZGIvbGludXgvY2xrLnB5ICAgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KIHNjcmlwdHMvZ2RiL3ZtbGludXgtZ2RiLnB5IHwgIDEgKw0KIDIgZmls
ZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzY3JpcHRz
L2dkYi9saW51eC9jbGsucHkNCg0KZGlmZiAtLWdpdCBhL3NjcmlwdHMvZ2RiL2xpbnV4L2Nsay5w
eSBiL3NjcmlwdHMvZ2RiL2xpbnV4L2Nsay5weQ0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4
IDAwMDAwMDAwMDAwMC4uYTkxMjlkODY1YzVkDQotLS0gL2Rldi9udWxsDQorKysgYi9zY3JpcHRz
L2dkYi9saW51eC9jbGsucHkNCkBAIC0wLDAgKzEsNDYgQEANCisjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wDQorIw0KKyMgQ29weXJpZ2h0IChjKSBOWFAgMjAxOQ0KKw0KK2ltcG9y
dCBnZGINCitpbXBvcnQgc3lzDQorDQorZnJvbSBsaW51eCBpbXBvcnQgdXRpbHMsIGxpc3RzDQor
DQorY2xrX2NvcmVfdHlwZSA9IHV0aWxzLkNhY2hlZFR5cGUoInN0cnVjdCBjbGtfY29yZSIpDQor
DQorDQorZGVmIGNsa19jb3JlX2Zvcl9lYWNoX2NoaWxkKGhsaXN0X2hlYWQpOg0KKyAgICByZXR1
cm4gbGlzdHMuaGxpc3RfZm9yX2VhY2hfZW50cnkoaGxpc3RfaGVhZCwNCisgICAgICAgICAgICBj
bGtfY29yZV90eXBlLmdldF90eXBlKCkucG9pbnRlcigpLCAiY2hpbGRfbm9kZSIpDQorDQorDQor
Y2xhc3MgTHhDbGtTdW1tYXJ5KGdkYi5Db21tYW5kKToNCisgICAgIiIiUHJpbnQgTGludXgga2Vy
bmVsIGxvZyBidWZmZXIuIiIiDQorDQorICAgIGRlZiBfX2luaXRfXyhzZWxmKToNCisgICAgICAg
IHN1cGVyKEx4Q2xrU3VtbWFyeSwgc2VsZikuX19pbml0X18oImx4LWNsay1zdW1tYXJ5IiwgZ2Ri
LkNPTU1BTkRfREFUQSkNCisNCisgICAgZGVmIHNob3dfc3VidHJlZShzZWxmLCBjbGssIGxldmVs
KToNCisgICAgICAgIGdkYi53cml0ZSgiJSpzJS0qcyAlN2QgJThkICU4ZFxuIiAlICgNCisgICAg
ICAgICAgICAgICAgbGV2ZWwgKiAzICsgMSwgIiIsDQorICAgICAgICAgICAgICAgIDMwIC0gbGV2
ZWwgKiAzLA0KKyAgICAgICAgICAgICAgICBjbGtbJ25hbWUnXS5zdHJpbmcoKSwNCisgICAgICAg
ICAgICAgICAgY2xrWydlbmFibGVfY291bnQnXSwNCisgICAgICAgICAgICAgICAgY2xrWydwcmVw
YXJlX2NvdW50J10sDQorICAgICAgICAgICAgICAgIGNsa1sncHJvdGVjdF9jb3VudCddKSkNCisN
CisgICAgICAgIGZvciBjaGlsZCBpbiBjbGtfY29yZV9mb3JfZWFjaF9jaGlsZChjbGtbJ2NoaWxk
cmVuJ10pOg0KKyAgICAgICAgICAgIHNlbGYuc2hvd19zdWJ0cmVlKGNoaWxkLCBsZXZlbCArIDEp
DQorDQorICAgIGRlZiBpbnZva2Uoc2VsZiwgYXJnLCBmcm9tX3R0eSk6DQorICAgICAgICBnZGIu
d3JpdGUoIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZSAgcHJlcGFyZSAg
cHJvdGVjdFxuIikNCisgICAgICAgIGdkYi53cml0ZSgiICAgY2xvY2sgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvdW50ICAgIGNvdW50ICAgIGNvdW50XG4iKQ0KKyAgICAgICAgZ2RiLndyaXRl
KCItLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS1cbiIpDQorICAgICAgICBmb3IgY2xrIGluIGNsa19jb3JlX2Zvcl9lYWNoX2NoaWxkKGdkYi5w
YXJzZV9hbmRfZXZhbCgiY2xrX3Jvb3RfbGlzdCIpKToNCisgICAgICAgICAgICBzZWxmLnNob3df
c3VidHJlZShjbGssIDApDQorICAgICAgICBmb3IgY2xrIGluIGNsa19jb3JlX2Zvcl9lYWNoX2No
aWxkKGdkYi5wYXJzZV9hbmRfZXZhbCgiY2xrX29ycGhhbl9saXN0IikpOg0KKyAgICAgICAgICAg
IHNlbGYuc2hvd19zdWJ0cmVlKGNsaywgMCkNCisNCisNCitMeENsa1N1bW1hcnkoKQ0KZGlmZiAt
LWdpdCBhL3NjcmlwdHMvZ2RiL3ZtbGludXgtZ2RiLnB5IGIvc2NyaXB0cy9nZGIvdm1saW51eC1n
ZGIucHkNCmluZGV4IDAzMzU3OGNjNGNkNy4uZWZmNWE0OGFjMDI2IDEwMDY0NA0KLS0tIGEvc2Ny
aXB0cy9nZGIvdm1saW51eC1nZGIucHkNCisrKyBiL3NjcmlwdHMvZ2RiL3ZtbGludXgtZ2RiLnB5
DQpAQCAtMzIsNSArMzIsNiBAQCBlbHNlOg0KICAgICBpbXBvcnQgbGludXgubGlzdHMNCiAgICAg
aW1wb3J0IGxpbnV4LnJidHJlZQ0KICAgICBpbXBvcnQgbGludXgucHJvYw0KICAgICBpbXBvcnQg
bGludXguY29uc3RhbnRzDQogICAgIGltcG9ydCBsaW51eC50aW1lcmxpc3QNCisgICAgaW1wb3J0
IGxpbnV4LmNsaw0KLS0gDQoyLjE3LjENCg0K
