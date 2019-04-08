Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17C3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E32C20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oHoDo2GM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDHKfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:35:33 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:32488
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfDHKfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFv5YM4+53V60QfBpIKpZF2QpbE3J6Ht2kzb3FvvBjM=;
 b=oHoDo2GM6RDHgqf8esHbDQyYsq5Iik7pfL032sOd7t+W5DmTnTvaU8DUFly2xy3TSb08mAacGvKQwPHFjmIUCcyd6KwKTdYpmqR/7Y8dXOFDz48ssS095YTt081oEEq+s7TPbzh/Yv6TrpHPv1NEJIy7T5LpFwK+xCUu2t6T5R4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4900.eurprd04.prod.outlook.com (20.176.215.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 10:35:26 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 10:35:26 +0000
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
Subject: RE: [PATCH V5 2/4] firmware: imx: enable imx scu general irq function
Thread-Topic: [PATCH V5 2/4] firmware: imx: enable imx scu general irq
 function
Thread-Index: AQHU3TgQGWe7UaJrGEy/JdXOZrh4C6YyMA3g
Date:   Mon, 8 Apr 2019 10:35:26 +0000
Message-ID: <AM0PR04MB42115BC951C501A5886B0C6B802C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
 <1552878291-22866-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552878291-22866-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41a13d9e-9adc-4c8b-5c18-08d6bc0dea1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4900;
x-ms-traffictypediagnostic: AM0PR04MB4900:
x-microsoft-antispam-prvs: <AM0PR04MB49009237B333A636700C950C802C0@AM0PR04MB4900.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(33656002)(229853002)(486006)(86362001)(102836004)(5660300002)(2201001)(14444005)(105586002)(71190400001)(71200400001)(97736004)(6436002)(256004)(8676002)(2501003)(11346002)(446003)(53936002)(26005)(7696005)(25786009)(66066001)(2906002)(99286004)(186003)(106356001)(44832011)(81156014)(81166006)(6506007)(4326008)(476003)(68736007)(8936002)(14454004)(110136005)(3846002)(55016002)(478600001)(76176011)(316002)(74316002)(305945005)(6246003)(6116002)(7736002)(52536014)(9686003)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4900;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PIwMk3/qx3Ii/JQ4jAyi/SW8zfmUw1fYCAnTkbWhHiETwRIuiXIPIKQq7QV2zo1kDoMNRBBMpTnxEa/8Q+JxvtcpH4nPBfVZWCDCnRJvJNmnDby+OpPanYl2gPIT1duxeVKJ5T/QencFwOkAJaIedIJ0qONDN8Mi8tpmxTqZCkey3qbWM0fsO6PcIgdVjUQwBf41XiH5HEfDzd4fIWTrSesie0OEEqHWvJVqZgXI3NG3TGdQdRtBxyibdUUmDwhu0MbDC0tc5g25I9IYxHjFhaYiKrh0MLT23xewyJWc7rACcaoMrjw25yqacNcXlVHnOghrbbED39mHgBJjPOV4daEtg7xi0oeRbU1ka49h5wixb/Gwvg5r720v8sO/q8Math7Qk0rwy+fmsXV9GTkSqzeeMUkT2QLksYBUTiEVwAg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a13d9e-9adc-4c8b-5c18-08d6bc0dea1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 10:35:26.6055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
> Sent: Monday, March 18, 2019 11:10 AM
>=20
> The System Controller Firmware (SCFW) controls RTC, thermal and WDOG etc.=
,
> these resources' interrupt function are managed by SCU. When any IRQ
> pending, SCU will notify Linux via MU general interrupt channel #3, and L=
inux
> kernel needs to call SCU APIs to get IRQ status and notify each module to
> handle the interrupt.
>=20
> Since there is no data transmission for SCU IRQ notification, so doorbell=
 mode
> is used for this MU channel, and SCU driver will use notifier mechanism t=
o
> broadcast to every module which registers the SCU block notifier.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

This patch mostly looks good me, except a few minor comments.
Otherwise, you can add my tag.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

> ---
> Changes since V4:
> 	- move scu irq support to a new file imx-scu-irq.c;
> 	- improve the function name with "imx_scu_irq_" as prefix for irq relate=
d
> functions;
> 	- move MU IRQ sources id out of sc ipc struct;
> 	- add IRQ group info message print when get irq status fail;
> 	- move MU ID parse into imx_scu_enable_general_irq_channel() function
> and ONLY do it
> 	  when irq channel enable successfully.
> 	- change max IRQ group supported to 4, ONLY support for those kernel
> features.
> ---
>  drivers/firmware/imx/Makefile      |   2 +-
>  drivers/firmware/imx/imx-scu-irq.c | 133
> +++++++++++++++++++++++++++++++++++++
>  drivers/firmware/imx/imx-scu.c     |   6 ++
>  include/linux/firmware/imx/sci.h   |   4 ++
>  4 files changed, 144 insertions(+), 1 deletion(-)  create mode 100644
> drivers/firmware/imx/imx-scu-irq.c
>=20
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefil=
e
> index 1b2e15b..802c4ad 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_IMX_SCU)		+=3D imx-scu.o misc.o
> +obj-$(CONFIG_IMX_SCU)		+=3D imx-scu.o misc.o imx-scu-irq.o
>  obj-$(CONFIG_IMX_SCU_PD)	+=3D scu-pd.o
> diff --git a/drivers/firmware/imx/imx-scu-irq.c
> b/drivers/firmware/imx/imx-scu-irq.c
> new file mode 100644
> index 0000000..0e20aa7
> --- /dev/null
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 NXP
> + *
> + * Implementation of the SCU IRQ functions using MU.
> + *
> + */
> +
> +#include <dt-bindings/firmware/imx/rsrc.h> #include
> +<linux/firmware/imx/ipc.h> #include <linux/mailbox_client.h>
> +
> +#define IMX_SC_IRQ_FUNC_STATUS	2
> +#define IMX_SC_IRQ_NUM_GROUP	4
> +
> +static u32 mu_resource_id;
> +
> +struct imx_sc_msg_irq_get_status {
> +	struct imx_sc_rpc_msg hdr;
> +	union {
> +		struct {
> +			u16 resource;
> +			u8 group;
> +			u8 reserved;
> +		} __packed req;
> +		struct {
> +			u32 status;
> +		} resp;
> +	} data;
> +};
> +
> +static struct imx_sc_ipc *imx_sc_irq_ipc_handle; static struct
> +work_struct imx_sc_irq_work; static
> +BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
> +
> +int imx_scu_irq_register_notifier(struct notifier_block *nb) {
> +	return blocking_notifier_chain_register(

We probably can use atomic_notifier_call_chain as it's used for irq functio=
n.

> +		&imx_scu_irq_notifier_chain, nb);
> +}
> +EXPORT_SYMBOL(imx_scu_irq_register_notifier);
> +
> +int imx_scu_irq_unregister_notifier(struct notifier_block *nb) {
> +	return blocking_notifier_chain_unregister(
> +		&imx_scu_irq_notifier_chain, nb);
> +}
> +EXPORT_SYMBOL(imx_scu_irq_unregister_notifier);
> +
> +static int imx_scu_irq_notifier_call_chain(unsigned long status, u8
> +*group) {
> +	return blocking_notifier_call_chain(&imx_scu_irq_notifier_chain,
> +		status, (void *)group);
> +}
> +
> +static void imx_scu_irq_work_handler(struct work_struct *work) {
> +	struct imx_sc_msg_irq_get_status msg;
> +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> +	u32 irq_status;
> +	int ret;
> +	u8 i;
> +
> +	for (i =3D 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
> +		hdr->ver =3D IMX_SC_RPC_VERSION;
> +		hdr->svc =3D IMX_SC_RPC_SVC_IRQ;
> +		hdr->func =3D IMX_SC_IRQ_FUNC_STATUS;
> +		hdr->size =3D 2;
> +
> +		msg.data.req.resource =3D mu_resource_id;
> +		msg.data.req.group =3D i;
> +
> +		ret =3D imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
> +		if (ret) {
> +			pr_err("get irq group %d status failed, ret %d\n",
> +			       i, ret);
> +			return;
> +		}
> +
> +		irq_status =3D msg.data.resp.status;
> +		if (!irq_status)
> +			continue;
> +
> +		imx_scu_irq_notifier_call_chain(irq_status, &i);
> +	}
> +}
> +
> +static void imx_scu_irq_callback(struct mbox_client *c, void *msg) {
> +	schedule_work(&imx_sc_irq_work);
> +}
> +
> +int imx_scu_enable_general_irq_channel(struct device *dev) {
> +	struct of_phandle_args spec;
> +	struct mbox_client *cl;
> +	struct mbox_chan *ch;
> +	int ret =3D 0, i =3D 0;
> +
> +	cl =3D devm_kzalloc(dev, sizeof(*cl), GFP_KERNEL);
> +	if (!cl)
> +		return -ENOMEM;
> +
> +	cl->dev =3D dev;
> +	cl->rx_callback =3D imx_scu_irq_callback;
> +
> +	/* SCU general IRQ uses general interrupt channel 3 */
> +	ch =3D mbox_request_channel_byname(cl, "gip3");
> +	if (IS_ERR(ch)) {
> +		ret =3D PTR_ERR(ch);
> +		dev_err(dev, "failed to request mbox chan gip3, ret %d\n", ret);

There may be memory leak as this function is optional in imx-scu.c.
So here seems to miss a devm_kfree

Regards
Dong Aisheng

> +		return ret;
> +	}
> +
> +	ret =3D imx_scu_get_handle(&imx_sc_irq_ipc_handle);
> +	if (ret)
> +		return ret;
> +
> +	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
> +
> +	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
> +				       "#mbox-cells", 0, &spec))
> +		i =3D of_alias_get_id(spec.np, "mu");
> +
> +	/* use mu1 as general mu irq channel if failed */
> +	if (i < 0)
> +		i =3D 1;
> +
> +	mu_resource_id =3D IMX_SC_R_MU_0A + i;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(imx_scu_enable_general_irq_channel);
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-sc=
u.c
> index 2bb1a19..04a24a8 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -10,6 +10,7 @@
>  #include <linux/err.h>
>  #include <linux/firmware/imx/types.h>
>  #include <linux/firmware/imx/ipc.h>
> +#include <linux/firmware/imx/sci.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> @@ -246,6 +247,11 @@ static int imx_scu_probe(struct platform_device
> *pdev)
>=20
>  	imx_sc_ipc_handle =3D sc_ipc;
>=20
> +	ret =3D imx_scu_enable_general_irq_channel(dev);
> +	if (ret)
> +		dev_warn(dev,
> +			"failed to enable general irq channel: %d\n", ret);
> +
>  	dev_info(dev, "NXP i.MX SCU Initialized\n");
>=20
>  	return devm_of_platform_populate(dev); diff --git
> a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
> index ebc5509..918fa16 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -15,4 +15,8 @@
>=20
>  #include <linux/firmware/imx/svc/misc.h>  #include
> <linux/firmware/imx/svc/pm.h>
> +
> +int imx_scu_enable_general_irq_channel(struct device *dev); int
> +imx_scu_irq_register_notifier(struct notifier_block *nb); int
> +imx_scu_irq_unregister_notifier(struct notifier_block *nb);
>  #endif /* _SC_SCI_H */
> --
> 2.7.4

