Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58509C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD502086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xPouM+nZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCRDKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:10:13 -0400
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:58626
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbfCRDKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L33S5/GXo31M09YCB/W9ypyPQMU2lZqPXTgOpvK0fg=;
 b=xPouM+nZkoBsyeYA0LnqLgnIIdkgB6ug7ZTbb0irx64WdAkXRq933BuCZqA0WUmidY15asWYhNvuYIMLaUfawC720R6EB6bXrqnpdsRmpI4U+X6uWPXXXxgAPk3ahu9MDazyOHnm9p4cR6JYER/rINlOwk2j2ypWLn7J53Yit+Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Mon, 18 Mar 2019 03:10:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 03:10:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V5 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHU3TgWpyqsIy1Nik+ALNkYzES/zQ==
Date:   Mon, 18 Mar 2019 03:10:06 +0000
Message-ID: <1552878291-22866-4-git-send-email-Anson.Huang@nxp.com>
References: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ade409b4-c845-4f3c-ebfd-08d6ab4f38c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-microsoft-antispam-prvs: <DB3PR0402MB388308B585F096427CC620DBF5470@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(6512007)(256004)(386003)(6486002)(6436002)(97736004)(106356001)(6116002)(3846002)(14444005)(52116002)(446003)(486006)(6506007)(186003)(26005)(53936002)(4326008)(476003)(316002)(11346002)(76176011)(2616005)(2501003)(2201001)(86362001)(25786009)(7416002)(305945005)(478600001)(110136005)(99286004)(7736002)(5660300002)(36756003)(50226002)(68736007)(66066001)(2906002)(105586002)(14454004)(81166006)(8676002)(81156014)(71200400001)(102836004)(71190400001)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tGujSRafuNJZhDjZ0MfcNxPZXXDiuBzODq1BkH5IZhpzuFa3NWcmAujozDyJDj2GO0Rbo79RBBL8kaixAFsJgNPJSrvui0qg8E502dRXHcha923SAlx0myvZDJruUmsTIJHuVQY+bFjiUS0TQf0Ind1a/jWkJBTrOUJdYWEz2Igy6fzujfTuvLqgkCYfSgSeyDXYu90L5SdvGprxmObVZmAwxNqyH/YkiV77a54jdfJqTHjpe8kw8eMfZqKNDoQJXJz4sjoHImtswJqIsmknrjSGHsNxTZNkZcw2FgcJEZuW6CMyxVvdkeVEHyQZh7jEB0PtBPnB78KZvRmA1LUse36irqtBgNhsteCEr4pqLi+t4PoesDKzN1MLU27tdOpdk1a+JVsSc4t8VLywdT9BhFcjW+gs/Hw+9uT6IlDKjrc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade409b4-c845-4f3c-ebfd-08d6ab4f38c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 03:10:06.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX system controller RTC alarm support, the RTC alarm
is implemented via SIP(silicon provider) runtime service call
and ARM-Trusted-Firmware will communicate with system controller
via MU(message unit) IPC to set RTC alarm. When RTC alarm fires,
system controller will generate a common MU irq event and notify
system controller RTC driver to handle the irq event.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No function changes, just update imx_scu_irq_register_notifier() function n=
ame
according to SCU IRQ function name change.
---
 drivers/rtc/rtc-imx-sc.c | 112 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index 19642bf..9df4990 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -3,6 +3,7 @@
  * Copyright 2018 NXP.
  */
=20
+#include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/module.h>
@@ -11,11 +12,17 @@
 #include <linux/rtc.h>
=20
 #define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
+#define IMX_SC_TIMER_FUNC_SET_RTC_ALARM		8
 #define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
=20
+#define IMX_SC_IRQ_FUNC_ENABLE			1
+
 #define IMX_SIP_SRTC			0xC2000002
 #define IMX_SIP_SRTC_SET_TIME		0x0
=20
+#define SC_IRQ_GROUP_RTC    2
+#define SC_IRQ_RTC          1
+
 static struct imx_sc_ipc *rtc_ipc_handle;
 static struct rtc_device *imx_sc_rtc;
=20
@@ -24,6 +31,24 @@ struct imx_sc_msg_timer_get_rtc_time {
 	u32 time;
 } __packed;
=20
+struct imx_sc_msg_timer_enable_irq {
+	struct imx_sc_rpc_msg hdr;
+	u32 mask;
+	u16 resource;
+	u8 group;
+	u8 enable;
+} __packed;
+
+struct imx_sc_msg_timer_rtc_set_alarm {
+	struct imx_sc_rpc_msg hdr;
+	u16 year;
+	u8 mon;
+	u8 day;
+	u8 hour;
+	u8 min;
+	u8 sec;
+} __packed;
+
 static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct imx_sc_msg_timer_get_rtc_time msg;
@@ -60,9 +85,92 @@ static int imx_sc_rtc_set_time(struct device *dev, struc=
t rtc_time *tm)
 	return res.a0;
 }
=20
+static int imx_sc_rtc_alarm_irq_enable(struct device *dev, unsigned int en=
able)
+{
+	struct imx_sc_msg_timer_enable_irq msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_IRQ;
+	hdr->func =3D IMX_SC_IRQ_FUNC_ENABLE;
+	hdr->size =3D 3;
+
+	msg.resource =3D IMX_SC_R_MU_1A;
+	msg.group =3D SC_IRQ_GROUP_RTC;
+	msg.mask =3D SC_IRQ_RTC;
+	msg.enable =3D enable;
+
+	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
+	if (ret) {
+		dev_err(dev, "enable rtc irq failed, ret %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_sc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *al=
rm)
+{
+	return 0;
+}
+
+static int imx_sc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alr=
m)
+{
+	struct imx_sc_msg_timer_rtc_set_alarm msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+	struct rtc_time *alrm_tm =3D &alrm->time;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_TIMER;
+	hdr->func =3D IMX_SC_TIMER_FUNC_SET_RTC_ALARM;
+	hdr->size =3D 3;
+
+	msg.year =3D alrm_tm->tm_year + 1900;
+	msg.mon =3D alrm_tm->tm_mon + 1;
+	msg.day =3D alrm_tm->tm_mday;
+	msg.hour =3D alrm_tm->tm_hour;
+	msg.min =3D alrm_tm->tm_min;
+	msg.sec =3D alrm_tm->tm_sec;
+
+	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
+	if (ret) {
+		dev_err(dev, "set rtc alarm failed, ret %d\n", ret);
+		return ret;
+	}
+
+	ret =3D imx_sc_rtc_alarm_irq_enable(dev, alrm->enabled);
+	if (ret) {
+		dev_err(dev, "enable rtc alarm failed, ret %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct rtc_class_ops imx_sc_rtc_ops =3D {
 	.read_time =3D imx_sc_rtc_read_time,
 	.set_time =3D imx_sc_rtc_set_time,
+	.read_alarm =3D imx_sc_rtc_read_alarm,
+	.set_alarm =3D imx_sc_rtc_set_alarm,
+	.alarm_irq_enable =3D imx_sc_rtc_alarm_irq_enable,
+};
+
+static int imx_sc_rtc_alarm_sc_notify(struct notifier_block *nb,
+					unsigned long event, void *group)
+{
+	/* ignore non-rtc irq */
+	if (!((event & SC_IRQ_RTC) && (*(u8 *)group =3D=3D SC_IRQ_GROUP_RTC)))
+		return 0;
+
+	rtc_update_irq(imx_sc_rtc, 1, RTC_IRQF | RTC_AF);
+
+	return 0;
+}
+
+static struct notifier_block imx_sc_rtc_alarm_sc_notifier =3D {
+	.notifier_call =3D imx_sc_rtc_alarm_sc_notify,
 };
=20
 static int imx_sc_rtc_probe(struct platform_device *pdev)
@@ -73,6 +181,8 @@ static int imx_sc_rtc_probe(struct platform_device *pdev=
)
 	if (ret)
 		return ret;
=20
+	device_init_wakeup(&pdev->dev, true);
+
 	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(imx_sc_rtc))
 		return PTR_ERR(imx_sc_rtc);
@@ -87,6 +197,8 @@ static int imx_sc_rtc_probe(struct platform_device *pdev=
)
 		return ret;
 	}
=20
+	imx_scu_irq_register_notifier(&imx_sc_rtc_alarm_sc_notifier);
+
 	return 0;
 }
=20
--=20
2.7.4

