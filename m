Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC7C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BD3218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rx4EgxY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfCOLF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:05:28 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:43623
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbfCOLF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT/00+mFx0Gb9S7OhFDbBCMWMZ10h/aQKXhOrPXeEwk=;
 b=Rx4EgxY/O3ZNtMLyNi4m+W55b4nz/5dUWVrGXnVKawDJEYv2VONU3/pvIeWtAsKa0si3eClINPxpMLT7Tp4TScs6qoxfZEv/WLzse8zXZITmVC0ycDsabMumfj6uNfETYH7lYveXYvYxg619IQOWLTI0Sjwf9BpwBnAIh/D2LhQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4337.eurprd04.prod.outlook.com (52.134.124.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 11:05:22 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 11:05:22 +0000
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
Subject: RE: [PATCH V4 2/4] firmware: imx: enable imx scu general irq function
Thread-Topic: [PATCH V4 2/4] firmware: imx: enable imx scu general irq
 function
Thread-Index: AQHUycaMJFaXS/PcVUWJ0ep29wYPYqYMonyA
Date:   Fri, 15 Mar 2019 11:05:22 +0000
Message-ID: <AM0PR04MB421142B1C681A0F4F991C7CB80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
 <1550740354-2701-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550740354-2701-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09704176-35d4-4e9d-cebc-08d6a9361e81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4337;
x-ms-traffictypediagnostic: AM0PR04MB4337:
x-microsoft-antispam-prvs: <AM0PR04MB43372F4C016D97DFABA3D86E80440@AM0PR04MB4337.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(136003)(376002)(189003)(199004)(3846002)(6116002)(66066001)(8936002)(52536014)(186003)(106356001)(71200400001)(105586002)(26005)(486006)(7416002)(478600001)(476003)(4326008)(33656002)(6506007)(86362001)(68736007)(110136005)(71190400001)(9686003)(2201001)(316002)(81166006)(81156014)(8676002)(229853002)(2501003)(44832011)(7696005)(256004)(5660300002)(99286004)(14444005)(74316002)(55016002)(11346002)(446003)(102836004)(97736004)(14454004)(6436002)(76176011)(2906002)(7736002)(6246003)(53936002)(25786009)(305945005)(21314003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4337;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J+xQwH2ZNnUhyOAXAjfDRG0hyVhkPdxZvKcEYy1eaKw8Q7QXq9NIB4tsDf9PtSci57CcgWI0psjsA/zuS80F2JalB0Px75iM3uRJ0c84KTSO5l4jxPxgy60YSLiei3KdOzwl9cIDEX8irg4dq6nO1tPtxwQONh3jLwsajemTYWZgr/K+hUYGRq/dOERZUJuwnfMOw0qjEJAc0whsowFr7LqHyIysdUK26LlTmW5b3F83H1vPv2uvlqzoJtetcdG0+rTvkt9JPmvUl9caUAo+0RgeIhidlzWlrw2cW1NDzfxKafTIDeicoQC1q8xeWpCVbCP2FPQhmmHWGlehzFF8gZL92YOsxfy4NtUoaWh7yZwezh9UYngWtiq01irtBrUkcZMNKCXhS+2RH7DLRxExEwPbabdSA+PgXrMKKlU4/ls=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09704176-35d4-4e9d-cebc-08d6a9361e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 11:05:22.3584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
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
> ---
> Changes since V3:
> 	- use alias to get general MU interrupt channel id and then get resource
> ID,
> 	  this is to support different MU instance;
> 	- add return value check for imx_scu_enable_general_irq_channel().
> ---
>  drivers/firmware/imx/imx-scu.c   | 116
> +++++++++++++++++++++++++++++++++++++++

Generally I would suggest to put scu irq support into another separate file=
 under
The same folder to make code clean from function point of view.

>  include/linux/firmware/imx/sci.h |   3 +
>  2 files changed, 119 insertions(+)
>=20
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-sc=
u.c
> index 2bb1a19..1dcd7b3 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -7,6 +7,7 @@
>   *
>   */
>=20
> +#include <dt-bindings/firmware/imx/rsrc.h>
>  #include <linux/err.h>
>  #include <linux/firmware/imx/types.h>
>  #include <linux/firmware/imx/ipc.h>
> @@ -21,6 +22,8 @@
>=20
>  #define SCU_MU_CHAN_NUM		8
>  #define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
> +#define IMX_SC_IRQ_FUNC_STATUS	2
> +#define IMX_SC_IRQ_NUM_GROUP	6
>=20
>  struct imx_sc_chan {
>  	struct imx_sc_ipc *sc_ipc;
> @@ -41,6 +44,7 @@ struct imx_sc_ipc {
>  	u32 *msg;
>  	u8 rx_size;
>  	u8 count;
> +	u32 mu_resource_id;

I feel it a bit strange to put this mu id in struct imx_sc_ipc.

>  };
>=20
>  /*
> @@ -77,7 +81,23 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] =3D {
>  	-EIO,	 /* IMX_SC_ERR_FAIL */
>  };
>=20
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
> +		} __packed resp;

No packed needed for this one

> +	} data;
> +};
> +
>  static struct imx_sc_ipc *imx_sc_ipc_handle;
> +static struct work_struct imx_sc_general_irq_work; static
> +BLOCKING_NOTIFIER_HEAD(imx_scu_notifier_chain);

Imx_scu_irq_xxx

>=20
>  static inline int imx_sc_to_linux_errno(int errno)  { @@ -194,9 +214,90 =
@@
> int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp=
)  }
> EXPORT_SYMBOL(imx_scu_call_rpc);
>=20
> +int imx_scu_register_notifier(struct notifier_block *nb) {
> +	return blocking_notifier_chain_register(&imx_scu_notifier_chain, nb);
> +} EXPORT_SYMBOL(imx_scu_register_notifier);
> +
> +int imx_scu_unregister_notifier(struct notifier_block *nb) {
> +	return blocking_notifier_chain_unregister(&imx_scu_notifier_chain,
> +nb); } EXPORT_SYMBOL(imx_scu_unregister_notifier);
> +
> +static int imx_scu_notifier_call_chain(unsigned long status, u8 *group)
> +{
> +	return blocking_notifier_call_chain(&imx_scu_notifier_chain,
> +					    status, (void *)group);
> +}
> +
> +static void imx_scu_general_irq_work_handler(struct work_struct *work)
> +{
> +	struct imx_sc_msg_irq_get_status msg;
> +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> +	u32 irq_status;
> +	int ret;
> +	u8 i;
> +
> +	for (i =3D 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {

Do we need to support all irq group?

> +		hdr->ver =3D IMX_SC_RPC_VERSION;
> +		hdr->svc =3D IMX_SC_RPC_SVC_IRQ;
> +		hdr->func =3D IMX_SC_IRQ_FUNC_STATUS;
> +		hdr->size =3D 2;
> +
> +		msg.data.req.resource =3D imx_sc_ipc_handle->mu_resource_id;
> +		msg.data.req.group =3D i;
> +
> +		ret =3D imx_scu_call_rpc(imx_sc_ipc_handle, &msg, true);
> +		if (ret) {
> +			pr_err("get irq status failed, ret %d\n", ret);

Can the error output more useful information?

> +			return;
> +		}
> +
> +		irq_status =3D msg.data.resp.status;
> +		if (!irq_status)
> +			continue;
> +
> +		imx_scu_notifier_call_chain(irq_status, &i);
> +	}
> +}
> +
> +static void imx_scu_rxdb_callback(struct mbox_client *c, void *msg) {

Imx_scu_irq_callback

> +	schedule_work(&imx_sc_general_irq_work);
> +}
> +
> +static int imx_scu_enable_general_irq_channel(struct device *dev) {
> +	struct mbox_client *cl;
> +	struct mbox_chan *ch;
> +	int ret =3D 0;
> +
> +	cl =3D devm_kzalloc(dev, sizeof(*cl), GFP_KERNEL);
> +	if (!cl)
> +		return -ENOMEM;
> +
> +	cl->dev =3D dev;
> +	cl->rx_callback =3D imx_scu_rxdb_callback;
> +
> +	/* SCU general IRQ uses general interrupt channel 3 */
> +	ch =3D mbox_request_channel_byname(cl, "gip3");
> +	if (IS_ERR(ch)) {
> +		ret =3D PTR_ERR(ch);
> +		dev_err(dev, "failed to request mbox chan gip3, ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	INIT_WORK(&imx_sc_general_irq_work,
> imx_scu_general_irq_work_handler);
> +
> +	return ret;
> +}
> +
>  static int imx_scu_probe(struct platform_device *pdev)  {
>  	struct device *dev =3D &pdev->dev;
> +	struct of_phandle_args spec;
>  	struct imx_sc_ipc *sc_ipc;
>  	struct imx_sc_chan *sc_chan;
>  	struct mbox_client *cl;
> @@ -246,6 +347,21 @@ static int imx_scu_probe(struct platform_device
> *pdev)
>=20
>  	imx_sc_ipc_handle =3D sc_ipc;
>=20
> +	ret =3D imx_scu_enable_general_irq_channel(dev);
> +	if (ret)
> +		dev_warn(dev,
> +			"failed to enable general irq channel: %d\n", ret);
> +

It does not make sense to parse again if failed. Pls put them into one func=
tion.

> +	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
> +				       "#mbox-cells", 0, &spec))
> +		i =3D of_alias_get_id(spec.np, "mu");

This needs a binding doc for mailbox (mu).

> +
> +	/* use mu1 as general mu irq channel if failed */
> +	if (i < 0)
> +		i =3D 1;
> +
> +	imx_sc_ipc_handle->mu_resource_id =3D IMX_SC_R_MU_0A + i;
> +
>  	dev_info(dev, "NXP i.MX SCU Initialized\n");
>=20
>  	return devm_of_platform_populate(dev); diff --git
> a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
> index ebc5509..9d608db 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -15,4 +15,7 @@
>=20
>  #include <linux/firmware/imx/svc/misc.h>  #include
> <linux/firmware/imx/svc/pm.h>
> +
> +int imx_scu_register_notifier(struct notifier_block *nb); int
> +imx_scu_unregister_notifier(struct notifier_block *nb);

imx_scu_irq_xxx

Regards
Dong Aisheng

>  #endif /* _SC_SCI_H */
> --
> 2.7.4

