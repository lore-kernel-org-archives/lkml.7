Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AAAC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57196206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ug6X12I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLaCvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 21:51:01 -0500
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:19014
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfLaCvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 21:51:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5+8fC29klPPDlDNyjyk/8ytgsn4wrQqkYpIjy2PWBoDqSKf1APy9baTeurwx43ldnQrEsR3Np5cPZ5FXB0hSBmtZMsHw6K/iIi+F3ne7xIFwBpqMFq4AC8gitBFKLjgO4nbin0prqM1krECUBe7vgW8KhyJMPv7jwv1PRPscakRfziRUn4M7Ybp+7uKYfIPaNSpt8XG5k2RZEWy3c1CIsXf4TkDXBN6WN/vHYtj+LbKKMN5FOPhd584waakhrW6e6LKUsp7tHjjIhGSyXOqKNHW1YAbaoj0pMjb/wG0cx95IzzbIe6BsfY07qnMV6fF9XbrnqODdEJZSpon/UOpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg2YwtoB0oX3dU4fSMVW41zsk6Ec9oh2whax5ksk9FY=;
 b=aHViqkMTgX5YFASQsAQY1ZepxsFAKvudBVGkmkDu2TbwZHG/F160+cpdOWcRYyDV48Wfpk6gu0CYovEOzUekfasm2ju73mhj2zAdiNpam9mK2Mk/0d9p0iJONkZ6Vx2OFrCqsNHCrmaKDws4V8B8NwqRhF1KrqbQep1Dg9HPRKXfcMHytHNtfqxQztaIB6/EEi/hTWEKjO6zZKOTDWvwVH70NTFuUoLkfNS9iy4EMgr3ugo6mj0lIqPiQFMauWzExiGbFLVxyzjXx0RjkUqdxS3f2+waD/tIdc29mNgfW6+cv7wcqFvf5dMHkY9gs7upx5GMBUw13NtWxggtyGZhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg2YwtoB0oX3dU4fSMVW41zsk6Ec9oh2whax5ksk9FY=;
 b=Ug6X12I28LvJED3VeMGAlO/QsTyjJRtBmNslEV0buHrJ1vLf+Tm5I5D614Qar4M14HV050mF10DIIdYrtfh3Oh5dZ6uFwXEH0EyL+/1Jdxc2gFsCci5U7NKWZ4JxoZ+qtreSb/pCHe/pcxEqxI6+GzLXrHZGfTXyx1SvfNd6JW4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5457.eurprd04.prod.outlook.com (20.178.113.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Tue, 31 Dec 2019 02:50:40 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58%6]) with mapi id 15.20.2581.007; Tue, 31 Dec 2019
 02:50:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Topic: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Index: AQHVppfygI23RUpETUWFTxolQ+nTs6fTvJtw
Date:   Tue, 31 Dec 2019 02:50:40 +0000
Message-ID: <AM0PR04MB44817F7C0FB0E6D417823B4A88260@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
In-Reply-To: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 354152b2-85f3-475a-c669-08d78d9c391a
x-ms-traffictypediagnostic: AM0PR04MB5457:
x-microsoft-antispam-prvs: <AM0PR04MB5457956164ADFC833FF6F35288260@AM0PR04MB5457.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(5660300002)(966005)(478600001)(4326008)(33656002)(2906002)(66556008)(64756008)(66446008)(66476007)(66946007)(44832011)(76116006)(54906003)(30864003)(45080400002)(26005)(110136005)(186003)(81166006)(81156014)(7696005)(55016002)(6506007)(316002)(71200400001)(8936002)(86362001)(52536014)(8676002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5457;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46p85NN7TPaCvXe3nk7bIHQGJFVMPBNN9PxZlTe5ZR+SkajcYTpr+WCJMl0zfOAz6znJnCjj5dQA8oGKBEybPuuYCHmsOyb9F/CL4hsHcqyBUPCougfqmM/TOs1DDE5Auycirs/tHZ2xCVuNAAMCCK9AmSzfYG6jmU5J7WljpIrp7D1dJaZDsvgiBE6sJo5MoQK9VwPG47EJ2XLN23uHz6nJ3UgPVCkHV/JxSCw3H9fg+bbqzPMO4s/+ud9J6ocicVQmIdcFi2cP1Gjidlpr6r4dNhYKGE9Ud+70EDm2EwdCqX3FNYYvM5JSEKLuSkYTto/OWjB4H6efcOL3cFF9F4pBTd9JNmcARWd6CVS6/E1/e+hloGsgpZENnpukT9NUtMr6vNC48WVIC3xCbcgEGRXLcE0hS1lbyR76VCsBWksaFGED5zTyUvC+uGz2xKSN6A1DrJhWXeYVyy87sUksbaVa0jqR97oD2sGiu+seKaA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354152b2-85f3-475a-c669-08d78d9c391a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 02:50:40.6696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98t1AGJvk4sCG6kE57rSTFIiPzTcEEAtgBcVn9jRCicPphobLV4aZOq9sa/8XfiE+m+JCtuJkfQq/l6AigV27Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: [PATCH] firmware: arm_scmi: Make scmi core independent of
> transport type
>=20
> The SCMI specification is fairly independent of the transport protocol, w=
hich
> can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent of the
> mailbox transport layer.
>=20
> This patch makes the SCMI core code (driver.c) independent of the mailbox
> transport layer and moves all mailbox related code to a new
> file: mailbox.c.
>=20
> We can now implement more transport protocols to transport SCMI
> messages.
>=20
> The transport protocols just need to provide struct scmi_transport_ops, w=
ith
> its version of the callbacks to enable exchange of SCMI messages.

Will there be v2? will this be used to replace smc mailbox?

Thanks,
Peng.

>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/firmware/arm_scmi/Makefile  |   3 +-
>  drivers/firmware/arm_scmi/common.h  |  39 ++++++++
> drivers/firmware/arm_scmi/driver.c  | 143 ++++++++++-----------------
> drivers/firmware/arm_scmi/mailbox.c | 146
> ++++++++++++++++++++++++++++
>  4 files changed, 236 insertions(+), 95 deletions(-)  create mode 100644
> drivers/firmware/arm_scmi/mailbox.c
>=20
> diff --git a/drivers/firmware/arm_scmi/Makefile
> b/drivers/firmware/arm_scmi/Makefile
> index 5f298f00a82e..df2c05a545d8 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y	=3D scmi-bus.o scmi-driver.o scmi-protocols.o
> +obj-y	=3D scmi-bus.o scmi-driver.o scmi-protocols.o scmi-transport.o
>  scmi-bus-y =3D bus.o
>  scmi-driver-y =3D driver.o
> +scmi-transport-y =3D mailbox.o
>  scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o
>  obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) +=3D scmi_pm_domain.o diff
> --git a/drivers/firmware/arm_scmi/common.h
> b/drivers/firmware/arm_scmi/common.h
> index 5237c2ff79fe..e11314146e67 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -111,3 +111,42 @@ void scmi_setup_protocol_implemented(const
> struct scmi_handle *handle,
>  				     u8 *prot_imp);
>=20
>  int scmi_base_protocol_init(struct scmi_handle *h);
> +
> +/* SCMI Transport */
> +
> +/**
> + * struct scmi_chan_info - Structure representing a SCMI channel
> +information
> + *
> + * @payload: Transmit/Receive payload area
> + * @dev: Reference to device in the SCMI hierarchy corresponding to this
> + *	 channel
> + * @handle: Pointer to SCMI entity handle
> + * @transport_info: Transport layer related information  */ struct
> +scmi_chan_info {
> +	void __iomem *payload;
> +	struct device *dev;
> +	struct scmi_handle *handle;
> +	void *transport_info;
> +};
> +
> +/**
> + * struct scmi_transport_ops - Structure representing a SCMI transport
> +ops
> + *
> + * @send_message: Callback to send a message
> + * @mark_txdone: Callback to mark tx as done
> + * @chan_setup: Callback to allocate and setup a channel
> + * @chan_free: Callback to free a channel  */ struct scmi_transport_ops
> +{
> +	bool (*chan_available)(struct device *dev, int idx);
> +	int (*chan_setup)(struct scmi_chan_info *cinfo, bool tx);
> +	int (*chan_free)(int id, void *p, void *data);
> +	int (*send_message)(struct scmi_chan_info *cinfo, struct scmi_xfer
> *xfer);
> +	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret); };
> +
> +void scmi_tx_prepare(struct scmi_chan_info *cinfo, struct scmi_xfer
> +*t); void scmi_rx_callback(struct scmi_chan_info *cinfo, struct
> +scmi_xfer *t); void scmi_free_channel(struct scmi_chan_info *cinfo,
> +struct idr *idr, int id); struct scmi_transport_ops
> +*scmi_mailbox_get_ops(struct device *dev);
> diff --git a/drivers/firmware/arm_scmi/driver.c
> b/drivers/firmware/arm_scmi/driver.c
> index 3eb0382491ce..dfdd12f3dd8b 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -19,7 +19,6 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/ktime.h>
> -#include <linux/mailbox_client.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -91,24 +90,6 @@ struct scmi_desc {
>  	int max_msg_size;
>  };
>=20
> -/**
> - * struct scmi_chan_info - Structure representing a SCMI channel informa=
tion
> - *
> - * @cl: Mailbox Client
> - * @chan: Transmit/Receive mailbox channel
> - * @payload: Transmit/Receive mailbox channel payload area
> - * @dev: Reference to device in the SCMI hierarchy corresponding to this
> - *	 channel
> - * @handle: Pointer to SCMI entity handle
> - */
> -struct scmi_chan_info {
> -	struct mbox_client cl;
> -	struct mbox_chan *chan;
> -	void __iomem *payload;
> -	struct device *dev;
> -	struct scmi_handle *handle;
> -};
> -
>  /**
>   * struct scmi_info - Structure representing a SCMI instance
>   *
> @@ -128,6 +109,7 @@ struct scmi_chan_info {  struct scmi_info {
>  	struct device *dev;
>  	const struct scmi_desc *desc;
> +	struct scmi_transport_ops *transport_ops;
>  	struct scmi_revision_info version;
>  	struct scmi_handle handle;
>  	struct scmi_xfers_info tx_minfo;
> @@ -138,7 +120,6 @@ struct scmi_info {
>  	int users;
>  };
>=20
> -#define client_to_scmi_chan_info(c) container_of(c, struct scmi_chan_inf=
o,
> cl)
>  #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
>=20
>  /*
> @@ -233,18 +214,16 @@ static inline void unpack_scmi_header(u32
> msg_hdr, struct scmi_msg_hdr *hdr)  }
>=20
>  /**
> - * scmi_tx_prepare() - mailbox client callback to prepare for the transf=
er
> + * scmi_tx_prepare() - callback to prepare for the transfer
>   *
> - * @cl: client pointer
> - * @m: mailbox message
> + * @cinfo: SCMI channel info
> + * @t: transfer message
>   *
>   * This function prepares the shared memory which contains the header an=
d
> the
>   * payload.
>   */
> -static void scmi_tx_prepare(struct mbox_client *cl, void *m)
> +void scmi_tx_prepare(struct scmi_chan_info *cinfo, struct scmi_xfer *t)
>  {
> -	struct scmi_xfer *t =3D m;
> -	struct scmi_chan_info *cinfo =3D client_to_scmi_chan_info(cl);
>  	struct scmi_shared_mem __iomem *mem =3D cinfo->payload;
>=20
>  	/*
> @@ -332,10 +311,10 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo,
> struct scmi_xfer *xfer)  }
>=20
>  /**
> - * scmi_rx_callback() - mailbox client callback for receive messages
> + * scmi_rx_callback() - callback for receive messages
>   *
> - * @cl: client pointer
> - * @m: mailbox message
> + * @cinfo: SCMI channel info
> + * @t: transfer message
>   *
>   * Processes one received message to appropriate transfer information an=
d
>   * signals completion of the transfer.
> @@ -343,13 +322,12 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo,
> struct scmi_xfer *xfer)
>   * NOTE: This function will be invoked in IRQ context, hence should be
>   * as optimal as possible.
>   */
> -static void scmi_rx_callback(struct mbox_client *cl, void *m)
> +void scmi_rx_callback(struct scmi_chan_info *cinfo, struct scmi_xfer
> +*t)
>  {
>  	u8 msg_type;
>  	u32 msg_hdr;
>  	u16 xfer_id;
>  	struct scmi_xfer *xfer;
> -	struct scmi_chan_info *cinfo =3D client_to_scmi_chan_info(cl);
>  	struct device *dev =3D cinfo->dev;
>  	struct scmi_info *info =3D handle_to_scmi_info(cinfo->handle);
>  	struct scmi_xfers_info *minfo =3D &info->tx_minfo; @@ -439,15 +417,12
> @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer
> *xfer)
>  	if (unlikely(!cinfo))
>  		return -EINVAL;
>=20
> -	ret =3D mbox_send_message(cinfo->chan, xfer);
> +	ret =3D info->transport_ops->send_message(cinfo, xfer);
>  	if (ret < 0) {
> -		dev_dbg(dev, "mbox send fail %d\n", ret);
> +		dev_dbg(dev, "Failed to send message %d\n", ret);
>  		return ret;
>  	}
>=20
> -	/* mbox_send_message returns non-negative value on success, so reset
> */
> -	ret =3D 0;
> -
>  	if (xfer->hdr.poll_completion) {
>  		ktime_t stop =3D ktime_add_ns(ktime_get(),
> SCMI_MAX_POLL_TO_NS);
>=20
> @@ -461,7 +436,7 @@ int scmi_do_xfer(const struct scmi_handle *handle,
> struct scmi_xfer *xfer)
>  		/* And we wait for the response. */
>  		timeout =3D msecs_to_jiffies(info->desc->max_rx_timeout_ms);
>  		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
> -			dev_err(dev, "mbox timed out in resp(caller: %pS)\n",
> +			dev_err(dev, "timed out in resp(caller: %pS)\n",
>  				(void *)_RET_IP_);
>  			ret =3D -ETIMEDOUT;
>  		}
> @@ -470,13 +445,7 @@ int scmi_do_xfer(const struct scmi_handle *handle,
> struct scmi_xfer *xfer)
>  	if (!ret && xfer->hdr.status)
>  		ret =3D scmi_to_linux_errno(xfer->hdr.status);
>=20
> -	/*
> -	 * NOTE: we might prefer not to need the mailbox ticker to manage the
> -	 * transfer queueing since the protocol layer queues things by itself.
> -	 * Unfortunately, we have to kick the mailbox framework after we have
> -	 * received our message.
> -	 */
> -	mbox_client_txdone(cinfo->chan, ret);
> +	info->transport_ops->mark_txdone(cinfo, ret);
>=20
>  	return ret;
>  }
> @@ -713,21 +682,14 @@ static int scmi_xfer_info_init(struct scmi_info
> *sinfo)
>  	return 0;
>  }
>=20
> -static int scmi_mailbox_check(struct device_node *np, int idx) -{
> -	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells",
> -					  idx, NULL);
> -}
> -
> -static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *d=
ev,
> -				int prot_id, bool tx)
> +static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
> +			   int prot_id, bool tx)
>  {
>  	int ret, idx;
>  	struct resource res;
>  	resource_size_t size;
> -	struct device_node *shmem, *np =3D dev->of_node;
> +	struct device_node *shmem;
>  	struct scmi_chan_info *cinfo;
> -	struct mbox_client *cl;
>  	struct idr *idr;
>  	const char *desc =3D tx ? "Tx" : "Rx";
>=20
> @@ -735,7 +697,7 @@ static int scmi_mbox_chan_setup(struct scmi_info
> *info, struct device *dev,
>  	idx =3D tx ? 0 : 1;
>  	idr =3D tx ? &info->tx_idr : &info->rx_idr;
>=20
> -	if (scmi_mailbox_check(np, idx)) {
> +	if (!info->transport_ops->chan_available(dev, idx)) {
>  		cinfo =3D idr_find(idr, SCMI_PROTOCOL_BASE);
>  		if (unlikely(!cinfo)) /* Possible only if platform has no Rx */
>  			return -EINVAL;
> @@ -748,14 +710,7 @@ static int scmi_mbox_chan_setup(struct scmi_info
> *info, struct device *dev,
>=20
>  	cinfo->dev =3D dev;
>=20
> -	cl =3D &cinfo->cl;
> -	cl->dev =3D dev;
> -	cl->rx_callback =3D scmi_rx_callback;
> -	cl->tx_prepare =3D tx ? scmi_tx_prepare : NULL;
> -	cl->tx_block =3D false;
> -	cl->knows_txdone =3D tx;
> -
> -	shmem =3D of_parse_phandle(np, "shmem", idx);
> +	shmem =3D of_parse_phandle(dev->of_node, "shmem", idx);
>  	ret =3D of_address_to_resource(shmem, 0, &res);
>  	of_node_put(shmem);
>  	if (ret) {
> @@ -770,14 +725,9 @@ static int scmi_mbox_chan_setup(struct scmi_info
> *info, struct device *dev,
>  		return -EADDRNOTAVAIL;
>  	}
>=20
> -	cinfo->chan =3D mbox_request_channel(cl, idx);
> -	if (IS_ERR(cinfo->chan)) {
> -		ret =3D PTR_ERR(cinfo->chan);
> -		if (ret !=3D -EPROBE_DEFER)
> -			dev_err(dev, "failed to request SCMI %s mailbox\n",
> -				desc);
> +	ret =3D info->transport_ops->chan_setup(cinfo, tx);
> +	if (ret)
>  		return ret;
> -	}
>=20
>  idr_alloc:
>  	ret =3D idr_alloc(idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL); @@ -79=
1,12
> +741,12 @@ static int scmi_mbox_chan_setup(struct scmi_info *info, struct
> device *dev,  }
>=20
>  static inline int
> -scmi_mbox_txrx_setup(struct scmi_info *info, struct device *dev, int pro=
t_id)
> +scmi_txrx_setup(struct scmi_info *info, struct device *dev, int
> +prot_id)
>  {
> -	int ret =3D scmi_mbox_chan_setup(info, dev, prot_id, true);
> +	int ret =3D scmi_chan_setup(info, dev, prot_id, true);
>=20
>  	if (!ret) /* Rx is optional, hence no error check */
> -		scmi_mbox_chan_setup(info, dev, prot_id, false);
> +		scmi_chan_setup(info, dev, prot_id, false);
>=20
>  	return ret;
>  }
> @@ -814,7 +764,7 @@ scmi_create_protocol_device(struct device_node *np,
> struct scmi_info *info,
>  		return;
>  	}
>=20
> -	if (scmi_mbox_txrx_setup(info, &sdev->dev, prot_id)) {
> +	if (scmi_txrx_setup(info, &sdev->dev, prot_id)) {
>  		dev_err(&sdev->dev, "failed to setup transport\n");
>  		scmi_device_destroy(sdev);
>  		return;
> @@ -824,6 +774,23 @@ scmi_create_protocol_device(struct device_node
> *np, struct scmi_info *info,
>  	scmi_set_handle(sdev);
>  }
>=20
> +static int scmi_set_transport_ops(struct scmi_info *info) {
> +	struct scmi_transport_ops *ops;
> +	struct device *dev =3D info->dev;
> +
> +	/* Only mailbox method supported for now */
> +	ops =3D scmi_mailbox_get_ops(dev);
> +	if (!ops) {
> +		dev_err(dev, "Transport protocol not found in %pOF\n",
> +			dev->of_node);
> +		return -EINVAL;
> +	}
> +
> +	info->transport_ops =3D ops;
> +	return 0;
> +}
> +
>  static int scmi_probe(struct platform_device *pdev)  {
>  	int ret;
> @@ -833,12 +800,6 @@ static int scmi_probe(struct platform_device *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct device_node *child, *np =3D dev->of_node;
>=20
> -	/* Only mailbox method supported, check for the presence of one */
> -	if (scmi_mailbox_check(np, 0)) {
> -		dev_err(dev, "no mailbox found in %pOF\n", np);
> -		return -EINVAL;
> -	}
> -
>  	desc =3D of_device_get_match_data(dev);
>  	if (!desc)
>  		return -EINVAL;
> @@ -851,6 +812,10 @@ static int scmi_probe(struct platform_device *pdev)
>  	info->desc =3D desc;
>  	INIT_LIST_HEAD(&info->node);
>=20
> +	ret =3D scmi_set_transport_ops(info);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D scmi_xfer_info_init(info);
>  	if (ret)
>  		return ret;
> @@ -863,7 +828,7 @@ static int scmi_probe(struct platform_device *pdev)
>  	handle->dev =3D info->dev;
>  	handle->version =3D &info->version;
>=20
> -	ret =3D scmi_mbox_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
> +	ret =3D scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
>  	if (ret)
>  		return ret;
>=20
> @@ -898,19 +863,9 @@ static int scmi_probe(struct platform_device *pdev)
>  	return 0;
>  }
>=20
> -static int scmi_mbox_free_channel(int id, void *p, void *data)
> +void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr,
> +int id)
>  {
> -	struct scmi_chan_info *cinfo =3D p;
> -	struct idr *idr =3D data;
> -
> -	if (!IS_ERR_OR_NULL(cinfo->chan)) {
> -		mbox_free_channel(cinfo->chan);
> -		cinfo->chan =3D NULL;
> -	}
> -
>  	idr_remove(idr, id);
> -
> -	return 0;
>  }
>=20
>  static int scmi_remove(struct platform_device *pdev) @@ -930,11 +885,11
> @@ static int scmi_remove(struct platform_device *pdev)
>  		return ret;
>=20
>  	/* Safe to free channels since no more users */
> -	ret =3D idr_for_each(idr, scmi_mbox_free_channel, idr);
> +	ret =3D idr_for_each(idr, info->transport_ops->chan_free, idr);
>  	idr_destroy(&info->tx_idr);
>=20
>  	idr =3D &info->rx_idr;
> -	ret =3D idr_for_each(idr, scmi_mbox_free_channel, idr);
> +	ret =3D idr_for_each(idr, info->transport_ops->chan_free, idr);
>  	idr_destroy(&info->rx_idr);
>=20
>  	return ret;
> diff --git a/drivers/firmware/arm_scmi/mailbox.c
> b/drivers/firmware/arm_scmi/mailbox.c
> new file mode 100644
> index 000000000000..d9d301df5cc9
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/mailbox.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Message Mailbox
> +Transport driver
> + *
> + * Copyright (C) 2019 ARM Ltd.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/device.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include "common.h"
> +
> +/**
> + * struct scmi_mailbox - Structure representing a SCMI mailbox
> +transport
> + *
> + * @cl: Mailbox Client
> + * @chan: Transmit/Receive mailbox channel
> + * @cinfo: SCMI channel info
> + */
> +struct scmi_mailbox {
> +	struct mbox_client cl;
> +	struct mbox_chan *chan;
> +	struct scmi_chan_info *cinfo;
> +};
> +
> +#define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox,
> +cl)
> +
> +static bool mailbox_chan_available(struct device *dev, int idx) {
> +	return !of_parse_phandle_with_args(dev->of_node, "mboxes",
> +					   "#mbox-cells", idx, NULL);
> +}
> +
> +static void mailbox_tx_prepare(struct mbox_client *cl, void *m) {
> +	struct scmi_mailbox *smbox =3D client_to_scmi_mailbox(cl);
> +	struct scmi_chan_info *cinfo =3D smbox->cinfo;
> +
> +	scmi_tx_prepare(cinfo, m);
> +}
> +
> +static void mailbox_rx_callback(struct mbox_client *cl, void *m) {
> +	struct scmi_mailbox *smbox =3D client_to_scmi_mailbox(cl);
> +	struct scmi_chan_info *cinfo =3D smbox->cinfo;
> +
> +	scmi_rx_callback(cinfo, m);
> +}
> +
> +static int mailbox_chan_setup(struct scmi_chan_info *cinfo, bool tx) {
> +	struct device *dev =3D cinfo->dev;
> +	struct scmi_mailbox *smbox;
> +	struct mbox_client *cl;
> +	int ret;
> +
> +	smbox =3D devm_kzalloc(dev, sizeof(*smbox), GFP_KERNEL);
> +	if (!smbox)
> +		return -ENOMEM;
> +
> +	cl =3D &smbox->cl;
> +	cl->dev =3D dev;
> +	cl->tx_prepare =3D tx ? mailbox_tx_prepare : NULL;
> +	cl->rx_callback =3D mailbox_rx_callback;
> +	cl->tx_block =3D false;
> +	cl->knows_txdone =3D tx;
> +
> +	smbox->chan =3D mbox_request_channel(cl, tx ? 0 : 1);
> +	if (IS_ERR(smbox->chan)) {
> +		ret =3D PTR_ERR(smbox->chan);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to request SCMI %s mailbox\n",
> +				tx ? "Tx" : "Rx");
> +		return ret;
> +	}
> +
> +	cinfo->transport_info =3D smbox;
> +	smbox->cinfo =3D cinfo;
> +
> +	return 0;
> +}
> +
> +static int mailbox_chan_free(int id, void *p, void *data) {
> +	struct scmi_chan_info *cinfo =3D p;
> +	struct scmi_mailbox *smbox =3D cinfo->transport_info;
> +
> +	if (!IS_ERR_OR_NULL(smbox->chan)) {
> +		mbox_free_channel(smbox->chan);
> +		cinfo->transport_info =3D NULL;
> +		smbox->chan =3D NULL;
> +		smbox->cinfo =3D NULL;
> +	}
> +
> +	scmi_free_channel(cinfo, data, id);
> +
> +	return 0;
> +}
> +
> +static int mailbox_send_message(struct scmi_chan_info *cinfo,
> +			struct scmi_xfer *xfer)
> +{
> +	struct scmi_mailbox *smbox =3D cinfo->transport_info;
> +	int ret;
> +
> +	ret =3D mbox_send_message(smbox->chan, xfer);
> +
> +	/* mbox_send_message returns non-negative value on success, so reset
> */
> +	if (ret > 0)
> +		ret =3D 0;
> +
> +	return ret;
> +}
> +
> +static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret)
> +{
> +	struct scmi_mailbox *smbox =3D cinfo->transport_info;
> +
> +	/*
> +	 * NOTE: we might prefer not to need the mailbox ticker to manage the
> +	 * transfer queueing since the protocol layer queues things by itself.
> +	 * Unfortunately, we have to kick the mailbox framework after we have
> +	 * received our message.
> +	 */
> +	mbox_client_txdone(smbox->chan, ret);
> +}
> +
> +static struct scmi_transport_ops scmi_mailbox_ops =3D {
> +	.chan_available =3D mailbox_chan_available,
> +	.chan_setup =3D mailbox_chan_setup,
> +	.chan_free =3D mailbox_chan_free,
> +	.send_message =3D mailbox_send_message,
> +	.mark_txdone =3D mailbox_mark_txdone,
> +};
> +
> +struct scmi_transport_ops *scmi_mailbox_get_ops(struct device *dev) {
> +	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
> "#mbox-cells",
> +					0, NULL))
> +		return &scmi_mailbox_ops;
> +
> +	return NULL;
> +}
> --
> 2.21.0.rc0.269.g1a574e7a288b
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D02%7C01
> %7Cpeng.fan%40nxp.com%7C8fe2d24d2ab54103882208d774af1406%7C686
> ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637106167622251045&a
> mp;sdata=3Dq74lMDic9eolz1JhL2Iple8wz1KxNEDq0BbHkh1QfRU%3D&amp;res
> erved=3D0
