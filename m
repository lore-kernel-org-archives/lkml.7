Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6CDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA322133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3M+oN+p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfDILHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:07:43 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:20820 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfDILHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:07:39 -0400
X-IronPort-AV: E=Sophos;i="5.60,329,1549954800"; 
   d="scan'208";a="27026424"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Apr 2019 04:07:38 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 9 Apr 2019 04:07:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twKevkpAnN9QflQd2G+A80nxWKbO79R6mm0EC+IKqxQ=;
 b=3M+oN+p4ZE1lJesmfg1ZKDaQjmzQLcF36dshdnAnZ7haLVjSPIxtvjy8AmdZmtLr58TAameRKLGpsh51XODQFpirecaJBh0oMHSFYBmbYR71xhch7M7VXPqc20YumlruRThYxgGWCGXjoFBy1ejFhNoDqC8NC9r+fVQE5ryr9n4=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1403.namprd11.prod.outlook.com (10.168.106.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 11:07:36 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 11:07:36 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>
CC:     <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 7/7] media: atmel: atmel-isc: fix asd memory allocation
Thread-Topic: [PATCH 7/7] media: atmel: atmel-isc: fix asd memory allocation
Thread-Index: AQHU7sRwSrFOQ/DSMU+GJr/WNiL6ng==
Date:   Tue, 9 Apr 2019 11:07:36 +0000
Message-ID: <1554807715-2353-8-git-send-email-eugen.hristev@microchip.com>
References: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:28::22) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 640b64f5-dbec-46fd-9dae-08d6bcdb9285
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB1403;
x-ms-traffictypediagnostic: DM5PR11MB1403:
x-microsoft-antispam-prvs: <DM5PR11MB1403171BB164270F6A2751B5E82D0@DM5PR11MB1403.namprd11.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(376002)(366004)(346002)(189003)(199004)(106356001)(316002)(110136005)(54906003)(105586002)(86362001)(99286004)(6436002)(5660300002)(6486002)(2201001)(76176011)(26005)(102836004)(486006)(6506007)(52116002)(14454004)(386003)(66066001)(476003)(478600001)(305945005)(8936002)(8676002)(36756003)(50226002)(81166006)(71190400001)(11346002)(72206003)(446003)(81156014)(71200400001)(2616005)(25786009)(3846002)(6116002)(6512007)(186003)(68736007)(4326008)(107886003)(53936002)(2906002)(97736004)(7736002)(2501003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1403;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SckaddXWDQ00yTPRB469BseNUfW8D58dmoyl5/dL6bThmbDTD6Yt3Mp4CFdGqAw4muZZUu9812CvoRdc59C0Ps5BILLizvkxrbJJObxiy4JkEVOwb76XUVAylN01zeMNmb50VMbfyxhg9ylp3isLRlhX+3h/XYHMDQ6dj2OObc9gakK40j7tSy3YfXYuIzfcjHzaO5abSj5nNwXPuoE5aPg5rTpDbUbHhYx68++QzJOp6PWY0ikFteDlFDgWxNsz+1CzYQAX6tlhRzKjXOfIfDJ6Df0fIJMwHW3/VRjFmdSKSLaKfoItnkRa7ZRopGjz18G6AYHnROU5JQMS7UTlEMUm56zd9b7WstweFaPSvZbHUnZpOj7foZMF7lHTS7qlvhJ3CaLI2WD9hgTmm+k2ZR7tXb4IK9iD2VMQCuwiLVY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 640b64f5-dbec-46fd-9dae-08d6bcdb9285
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:07:36.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1403
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpUaGUg
c3Vic3lzdGVtIHdpbGwgZnJlZSB0aGUgYXNkIG1lbW9yeSBvbiBub3RpZmllciBjbGVhbnVwLCBp
ZiB0aGUgYXNkIGlzDQphZGRlZCB0byB0aGUgbm90aWZpZXIuDQpIb3dldmVyIHRoZSBtZW1vcnkg
aXMgZnJlZWQgdXNpbmcga2ZyZWUuDQpUaHVzLCB3ZSBjYW5ub3QgYWxsb2NhdGUgdGhlIGFzZCB1
c2luZyBkZXZtXyoNClRoaXMgY2FuIGxlYWQgdG8gY3Jhc2hlcyBhbmQgcHJvYmxlbXMuDQpUbyB0
ZXN0IHRoaXMgaXNzdWUsIGp1c3QgcmV0dXJuIGFuIGVycm9yIGF0IHByb2JlLCBidXQgY2xlYW51
cCB0aGUNCm5vdGlmaWVyIGJlZm9yZWhhbmQuDQoNCkZpeGVzOiAxMDYyNjc0NDRmICgiW21lZGlh
XSBhdG1lbC1pc2M6IGFkZCB0aGUgSW1hZ2UgU2Vuc29yIENvbnRyb2xsZXIgY29kZSIpDQpTaWdu
ZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQot
LS0NCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jIHwgOCArKysrKyst
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jIGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MuYw0KaW5kZXggNDg2NTJjMC4uOGQ4
Y2NlNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNj
LmMNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMNCkBAIC0y
NDA4LDggKzI0MDgsMTEgQEAgc3RhdGljIGludCBpc2NfcGFyc2VfZHQoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgaXNjX2RldmljZSAqaXNjKQ0KIAkJCWJyZWFrOw0KIAkJfQ0KIA0KLQkJc3Vi
ZGV2X2VudGl0eS0+YXNkID0gZGV2bV9remFsbG9jKGRldiwNCi0JCQkJICAgICBzaXplb2YoKnN1
YmRldl9lbnRpdHktPmFzZCksIEdGUF9LRVJORUwpOw0KKwkJLyogYXNkIHdpbGwgYmUgZnJlZWQg
YnkgdGhlIHN1YnN5c3RlbSBvbmNlIGl0J3MgYWRkZWQgdG8gdGhlDQorCQkgKiBub3RpZmllciBs
aXN0DQorCQkgKi8NCisJCXN1YmRldl9lbnRpdHktPmFzZCA9IGt6YWxsb2Moc2l6ZW9mKCpzdWJk
ZXZfZW50aXR5LT5hc2QpLA0KKwkJCQkJICAgICBHRlBfS0VSTkVMKTsNCiAJCWlmICghc3ViZGV2
X2VudGl0eS0+YXNkKSB7DQogCQkJb2Zfbm9kZV9wdXQocmVtKTsNCiAJCQlyZXQgPSAtRU5PTUVN
Ow0KQEAgLTI1NTMsNiArMjU1Niw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfaXNjX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQkJCQkJICAgICBzdWJkZXZfZW50aXR5LT5hc2Qp
Ow0KIAkJaWYgKHJldCkgew0KIAkJCWZ3bm9kZV9oYW5kbGVfcHV0KHN1YmRldl9lbnRpdHktPmFz
ZC0+bWF0Y2guZndub2RlKTsNCisJCQlrZnJlZShzdWJkZXZfZW50aXR5LT5hc2QpOw0KIAkJCWdv
dG8gY2xlYW51cF9zdWJkZXY7DQogCQl9DQogDQotLSANCjIuNy40DQoNCg==
