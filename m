Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B818BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A955217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="idHvt/u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfDWNvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:51:36 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:58114
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728142AbfDWNve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut+wVXAHPbwzaQNpfOq8uz/Qggrwaa2sXbwvclLM4uA=;
 b=idHvt/u6oc5lSJnoZnOiz1m68Ow9rVJR6vS/qDei1Z7Vkovn9gU1Bd1IYmC15Pt5UXfTrHj+1wywm6F5+hxYRQEe9FWNnpkIEZV+lQwHFTljWMpfQ5RaHPZAfGf7dwX7gt7ZDYt6ZYFQwhMCuvCBBboX5dTovP4g4BRI39r9cAE=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5901.eurprd04.prod.outlook.com (20.178.205.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:51:31 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:51:30 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work on
 i.mx8mm
Thread-Topic: [PATCH v1 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Index: AQHU+dunYJsC/GzrSkyTLraBiTeTYQ==
Date:   Tue, 23 Apr 2019 13:51:30 +0000
Message-ID: <1556027045-5269-12-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9af02ba3-36dd-4d56-0542-08d6c7f2c9b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5901;
x-ms-traffictypediagnostic: VI1PR04MB5901:
x-microsoft-antispam-prvs: <VI1PR04MB5901531572C0C8835E9BBDBD89230@VI1PR04MB5901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(102836004)(86362001)(97736004)(386003)(7416002)(36756003)(14444005)(2201001)(25786009)(4326008)(305945005)(26005)(256004)(73956011)(71190400001)(71200400001)(7736002)(64756008)(66556008)(66476007)(478600001)(66446008)(66946007)(11346002)(316002)(14454004)(446003)(81156014)(8676002)(68736007)(54906003)(81166006)(2501003)(8936002)(186003)(5660300002)(6436002)(110136005)(3846002)(6116002)(6486002)(53936002)(66066001)(6512007)(486006)(476003)(99286004)(76176011)(50226002)(2616005)(52116002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5901;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8x45X2bxPO/nT+exJuYuy4IrYrXnQqXlkYFuZK0DH/kD1tPJxZJ7pD+AWO4+WZjJys8m7K2J1XiWXGxAAO8KvbIUb+A9KZjxdwOYa+5nqjX1CX6uzaX+0HDKCcQXGRwi4Va3D/m6QKhnKZiSHDysqCGdhQXuZBxk9toTm+IxwPxWR/rlq7agxQ86POOxbhDmB5ffGKKTTAapOfCWpczIp6RJmjxTkq3WT0RTVvwKmySK0LjWBxUFOHr9QtcLaQRc6UNP3wP039wm7jhrLpv4YGsENONOy56MeiWjE+0JZyhkV1cqkTkCTmTuV5uJJ9gV/QEVmr+FU/8cBV17WCqepoRfPXKHdDoWmPU1HkkJmmANMJeUhJGZOU3Hzi8z/dRhVBrEv7ELLLtGMzUz1A1jACbjnqIv1KiJFn2IzetH9BI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af02ba3-36dd-4d56-0542-08d6c7f2c9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:51:30.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QmVjYXVzZSB0aGUgbnVtYmVyIG9mIGVjc3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlzIDAsIHRo
ZSBjb25kaXRpb24NCmNoZWNrIGlnbm9yZSBzdWNoIHNwZWNpYWwgY2FzZSB3aXRob3V0IGRtYSBj
aGFubmVsIGVuYWJsZWQsIHdoaWNoIGNhdXNlZA0KZWNzcGkxIHJ4IHdvcmtzIGZhaWxlZC4gQWN0
dWFsbHksIG5vIG5lZWQgdG8gY2hlY2sgZXZlbnRfaWQwLCBjaGVja2luZw0KZXZlbnRfaWQxIGlz
IGVub3VnaCBmb3IgREVWXzJfREVWIGNhc2UgYmVjYXVzZSBpdCdzIHNvIGx1Y2t5IHRoYXQgZXZl
bnRfaWQxDQpuZXZlciBiZSAwLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5n
b25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMTIgKysrKystLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jDQppbmRleCA5OWM0NGE1Li5kODdhOGY5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYw0KKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KQEAgLTEzNjMsOCArMTM2Myw4
IEBAIHN0YXRpYyB2b2lkIHNkbWFfZnJlZV9jaGFuX3Jlc291cmNlcyhzdHJ1Y3QgZG1hX2NoYW4g
KmNoYW4pDQogDQogCXNkbWFfY2hhbm5lbF9zeW5jaHJvbml6ZShjaGFuKTsNCiANCi0JaWYgKHNk
bWFjLT5ldmVudF9pZDApDQotCQlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVu
dF9pZDApOw0KKwlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0K
Kw0KIAlpZiAoc2RtYWMtPmV2ZW50X2lkMSkNCiAJCXNkbWFfZXZlbnRfZGlzYWJsZShzZG1hYywg
c2RtYWMtPmV2ZW50X2lkMSk7DQogDQpAQCAtMTY2MywxMSArMTY2Myw5IEBAIHN0YXRpYyBpbnQg
c2RtYV9jb25maWcoc3RydWN0IGRtYV9jaGFuICpjaGFuLA0KIAltZW1jcHkoJnNkbWFjLT5zbGF2
ZV9jb25maWcsIGRtYWVuZ2luZV9jZmcsIHNpemVvZigqZG1hZW5naW5lX2NmZykpOw0KIA0KIAkv
KiBTZXQgRU5CTG4gZWFybGllciB0byBtYWtlIHN1cmUgZG1hIHJlcXVlc3QgdHJpZ2dlcmVkIGFm
dGVyIHRoYXQgKi8NCi0JaWYgKHNkbWFjLT5ldmVudF9pZDApIHsNCi0JCWlmIChzZG1hYy0+ZXZl
bnRfaWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KLQkJCXJldHVybiAt
RUlOVkFMOw0KLQkJc2RtYV9ldmVudF9lbmFibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0K
LQl9DQorCWlmIChzZG1hYy0+ZXZlbnRfaWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1f
ZXZlbnRzKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorCXNkbWFfZXZlbnRfZW5hYmxlKHNkbWFjLCBz
ZG1hYy0+ZXZlbnRfaWQwKTsNCiANCiAJaWYgKHNkbWFjLT5ldmVudF9pZDEpIHsNCiAJCWlmIChz
ZG1hYy0+ZXZlbnRfaWQxID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KLS0g
DQoyLjcuNA0KDQo=
