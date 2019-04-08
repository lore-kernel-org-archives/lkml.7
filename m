Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2830C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D3620857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fprIPmeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDHLIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:08:55 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:8197
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfDHLIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hcxjxn+0emttIXHWWn0yFUoYsaSSshsaGOCLQLyaRCY=;
 b=fprIPmeICgH6nWucFQhMQWS1c7KusLofq2xY1ZGRGAdzPEZJBwkmdhAguo33G+qWQZQiEwNyfVQ4tOy1iZqT6GWL1KUwQhDpcptfhP/55gO0DubF5JK+MC/JSmIEjllcOtQ4xkunD/86eTbnNLUu7Odhc3mhOIDrLWKdC1OQfv0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 11:08:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 11:08:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V5 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHU3TgXVF69xScZaEuBoN4oQ+OPnaYyOqtQ
Date:   Mon, 8 Apr 2019 11:08:48 +0000
Message-ID: <AM0PR04MB4211209072B94795A6A04E9A802C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
 <1552878291-22866-4-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552878291-22866-4-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc59e528-2bfe-4680-1eb9-08d6bc129304
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-microsoft-antispam-prvs: <AM0PR04MB44029832A96C943E1DE982F5802C0@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(66066001)(7416002)(55016002)(68736007)(3846002)(6116002)(7696005)(6246003)(9686003)(71190400001)(2201001)(25786009)(71200400001)(4326008)(53936002)(86362001)(6506007)(81166006)(81156014)(11346002)(52536014)(446003)(26005)(106356001)(8676002)(102836004)(105586002)(44832011)(486006)(14444005)(256004)(76176011)(229853002)(14454004)(110136005)(7736002)(478600001)(8936002)(2906002)(99286004)(2501003)(74316002)(316002)(5660300002)(186003)(6436002)(33656002)(305945005)(97736004)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aPvW8SMnv8uoVoPvt+ETIgYGQpwXLFJoiALL2LwHwxmzCEWQ9sti7TA9y4ziB7wf5lx4VwabBAMTmAaC2sFIxzl/a50z1TYJw6xjGH3i5SSIGmgeXYRP03ZDwAG6R1ZweHe3R3j9Xz1jKYHKJzRhrmuG04ziZUiHcK3aQJF/fwZx0pOxsiL4/KxgGHYDWgqX038rPho+Me+DWuohTSaW67Kyoyx1UgWHjsA2IGgY2ICz2VIAw/N4TInNEOiudCuCBFTPtIfCatrZ2eM8o+LAWk+pOA55s7Ak9ckXkvQl1y9viEjpdsGEHPaXqL42EvhRPZ0pROqwe5EdXeW3Dn2V51h1tp5S3cAStT3fxI7mkBiWFAWhUlrnd0Z1CPCPRXwMrgQNP+EvbelSUL5tSW7cXEbsopyS7HWwdZPJ8dJrZ3w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc59e528-2bfe-4680-1eb9-08d6bc129304
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 11:08:48.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
> Sent: Monday, March 18, 2019 11:10 AM
>=20
> Add i.MX system controller RTC alarm support, the RTC alarm is implemente=
d
> via SIP(silicon provider) runtime service call and ARM-Trusted-Firmware w=
ill
> communicate with system controller via MU(message unit) IPC to set RTC
> alarm. When RTC alarm fires, system controller will generate a common MU
> irq event and notify system controller RTC driver to handle the irq event=
.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No function changes, just update imx_scu_irq_register_notifier() function
> name according to SCU IRQ function name change.
> ---
>  drivers/rtc/rtc-imx-sc.c | 112
> +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>=20
> diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c index
> 19642bf..9df4990 100644
> --- a/drivers/rtc/rtc-imx-sc.c
> +++ b/drivers/rtc/rtc-imx-sc.c
> @@ -3,6 +3,7 @@
>   * Copyright 2018 NXP.
>   */
>=20
> +#include <dt-bindings/firmware/imx/rsrc.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/module.h>
> @@ -11,11 +12,17 @@
>  #include <linux/rtc.h>
>=20
>  #define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
> +#define IMX_SC_TIMER_FUNC_SET_RTC_ALARM		8
>  #define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
>=20
> +#define IMX_SC_IRQ_FUNC_ENABLE			1
> +
>  #define IMX_SIP_SRTC			0xC2000002
>  #define IMX_SIP_SRTC_SET_TIME		0x0
>=20
> +#define SC_IRQ_GROUP_RTC    2
> +#define SC_IRQ_RTC          1
> +
>  static struct imx_sc_ipc *rtc_ipc_handle;  static struct rtc_device
> *imx_sc_rtc;
>=20
> @@ -24,6 +31,24 @@ struct imx_sc_msg_timer_get_rtc_time {
>  	u32 time;
>  } __packed;
>=20
> +struct imx_sc_msg_timer_enable_irq {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 mask;
> +	u16 resource;
> +	u8 group;
> +	u8 enable;
> +} __packed;
> +
> +struct imx_sc_msg_timer_rtc_set_alarm {
> +	struct imx_sc_rpc_msg hdr;
> +	u16 year;
> +	u8 mon;
> +	u8 day;
> +	u8 hour;
> +	u8 min;
> +	u8 sec;
> +} __packed;
> +
>  static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)=
  {
>  	struct imx_sc_msg_timer_get_rtc_time msg; @@ -60,9 +85,92 @@ static
> int imx_sc_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	return res.a0;
>  }
>=20
> +static int imx_sc_rtc_alarm_irq_enable(struct device *dev, unsigned int
> +enable) {

I think you shouldn't implement this generic function in rtc driver instead=
 of
Imx-scu-irq driver.

> +	struct imx_sc_msg_timer_enable_irq msg;
> +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> +	int ret;
> +
> +	hdr->ver =3D IMX_SC_RPC_VERSION;
> +	hdr->svc =3D IMX_SC_RPC_SVC_IRQ;
> +	hdr->func =3D IMX_SC_IRQ_FUNC_ENABLE;
> +	hdr->size =3D 3;
> +
> +	msg.resource =3D IMX_SC_R_MU_1A;

Here may be wrong as it is not align with what you did in Patch 2
that MU resource is dynamically detected.

> +	msg.group =3D SC_IRQ_GROUP_RTC;
> +	msg.mask =3D SC_IRQ_RTC;
> +	msg.enable =3D enable;
> +
> +	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> +	if (ret) {
> +		dev_err(dev, "enable rtc irq failed, ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_sc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm
> +*alrm) {
> +	return 0;
> +}

Can't avoid define NULL function?

> +
> +static int imx_sc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm
> +*alrm) {
> +	struct imx_sc_msg_timer_rtc_set_alarm msg;
> +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> +	int ret;
> +	struct rtc_time *alrm_tm =3D &alrm->time;
> +
> +	hdr->ver =3D IMX_SC_RPC_VERSION;
> +	hdr->svc =3D IMX_SC_RPC_SVC_TIMER;
> +	hdr->func =3D IMX_SC_TIMER_FUNC_SET_RTC_ALARM;
> +	hdr->size =3D 3;
> +
> +	msg.year =3D alrm_tm->tm_year + 1900;
> +	msg.mon =3D alrm_tm->tm_mon + 1;
> +	msg.day =3D alrm_tm->tm_mday;
> +	msg.hour =3D alrm_tm->tm_hour;
> +	msg.min =3D alrm_tm->tm_min;
> +	msg.sec =3D alrm_tm->tm_sec;
> +
> +	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> +	if (ret) {
> +		dev_err(dev, "set rtc alarm failed, ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D imx_sc_rtc_alarm_irq_enable(dev, alrm->enabled);

Just curious we already have .alarm_irq_enable().
Why do we need call it again here?

Regards
Dong Aisheng

> +	if (ret) {
> +		dev_err(dev, "enable rtc alarm failed, ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct rtc_class_ops imx_sc_rtc_ops =3D {
>  	.read_time =3D imx_sc_rtc_read_time,
>  	.set_time =3D imx_sc_rtc_set_time,
> +	.read_alarm =3D imx_sc_rtc_read_alarm,
> +	.set_alarm =3D imx_sc_rtc_set_alarm,
> +	.alarm_irq_enable =3D imx_sc_rtc_alarm_irq_enable, };
> +
> +static int imx_sc_rtc_alarm_sc_notify(struct notifier_block *nb,
> +					unsigned long event, void *group)
> +{
> +	/* ignore non-rtc irq */
> +	if (!((event & SC_IRQ_RTC) && (*(u8 *)group =3D=3D SC_IRQ_GROUP_RTC)))
> +		return 0;
> +
> +	rtc_update_irq(imx_sc_rtc, 1, RTC_IRQF | RTC_AF);
> +
> +	return 0;
> +}
> +
> +static struct notifier_block imx_sc_rtc_alarm_sc_notifier =3D {
> +	.notifier_call =3D imx_sc_rtc_alarm_sc_notify,
>  };
>=20
>  static int imx_sc_rtc_probe(struct platform_device *pdev) @@ -73,6 +181,=
8
> @@ static int imx_sc_rtc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>=20
> +	device_init_wakeup(&pdev->dev, true);
> +
>  	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
>  	if (IS_ERR(imx_sc_rtc))
>  		return PTR_ERR(imx_sc_rtc);
> @@ -87,6 +197,8 @@ static int imx_sc_rtc_probe(struct platform_device
> *pdev)
>  		return ret;
>  	}
>=20
> +	imx_scu_irq_register_notifier(&imx_sc_rtc_alarm_sc_notifier);
> +
>  	return 0;
>  }
>=20
> --
> 2.7.4

