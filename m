Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D10C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1B42080C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="znxmORUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbfIEM1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:27:03 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54403 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387820AbfIEM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:27:03 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85CQIOP000764;
        Thu, 5 Sep 2019 14:26:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=nLkZMuC34tZ2bf98LVNmMeoTssSSVt1ZSbE//fr5g8c=;
 b=znxmORUquqtvLPilFa39WOdCx8JIS65skGzAclUfn438+Sdw7UIC2RqtCfN5YQAWEUWw
 zUs4vlz6kBJinvyh/B9nX4cQGiOAKQGmPB3YyB0OAfxS7tmgyDDOBxdyd/vxYi3mxOgB
 SvMFF5Jqt+LpdUygiPJa+GS0xw8Xyhvue+//MRyN/YUmt1z5U0UR2rhVIGxDIc1iqukR
 djNGEyTP6SMBmClBdpRepIIRT/pZykyULUGx6H7IdJdWe4e+f8oJ/UQu1W0GgS+2XQMN
 CaPGLy42iuImUxN9O7UFy4tojbCA1i2Pjkd7jl8ibP8H3GPBZ3yrdSOkT2hObmcgNllp Xw== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uqenvg4su-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Sep 2019 14:26:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5823D22;
        Thu,  5 Sep 2019 12:26:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0D0C12CBDB9;
        Thu,  5 Sep 2019 14:26:32 +0200 (CEST)
Received: from [10.48.0.131] (10.75.127.49) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Sep
 2019 14:26:31 +0200
Subject: Re: [PATCH v6 2/2] tty: add rpmsg driver
To:     Richard Genoud <richard.genoud@gmail.com>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <1567602594-2913-1-git-send-email-arnaud.pouliquen@st.com>
 <1567602594-2913-3-git-send-email-arnaud.pouliquen@st.com>
 <6595e951-82ff-212d-b488-af4422461a8e@gmail.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <d3d1bcbe-93a8-6d97-4aa5-d80b4438f48d@st.com>
Date:   Thu, 5 Sep 2019 14:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6595e951-82ff-212d-b488-af4422461a8e@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_04:2019-09-04,2019-09-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 9/5/19 12:50 PM, Richard Genoud wrote:
> Hi Arnaud,
> 
> Le 04/09/2019 à 15:09, Arnaud Pouliquen a écrit :
>> This driver exposes a standard tty interface on top of the rpmsg
>> framework through a rpmsg service.
>>
>> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
>> per rpmsg endpoint.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
>> ---
>>   Documentation/serial/tty_rpmsg.rst |  45 ++++
>>   drivers/tty/Kconfig                |   9 +
>>   drivers/tty/Makefile               |   1 +
>>   drivers/tty/rpmsg_tty.c            | 418 +++++++++++++++++++++++++++++++++++++
>>   4 files changed, 473 insertions(+)
>>   create mode 100644 Documentation/serial/tty_rpmsg.rst
>>   create mode 100644 drivers/tty/rpmsg_tty.c
>>
>> diff --git a/Documentation/serial/tty_rpmsg.rst b/Documentation/serial/tty_rpmsg.rst
>> new file mode 100644
>> index 000000000000..fc1d3fba73c5
>> --- /dev/null
>> +++ b/Documentation/serial/tty_rpmsg.rst
>> @@ -0,0 +1,45 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=============
>> +The rpmsg TTY
>> +=============
>> +
>> +The rpmsg tty driver implements serial communication on the RPMsg bus to makes possible for user-space programs to send and receive rpmsg messages as a standard tty protocol.
>> +
>> +The remote processor can instantiate a new tty by requesting:
>> +- a "rpmsg-tty-raw" RPMsg service, for TTY raw data support without flow control
>> +- a "rpmsg-tty-ctrl" RPMSg service, for TTY support with flow control.
>> +
>> +Information related to the RPMsg and associated tty device is available in
>> +/sys/bus/rpmsg/devices/.
>> +
>> +RPMsg TTY without control
>> +---------------------
>> +
>> +The default end point associated with the "rpmsg-tty-raw" service is directly
>> +used for data exchange. No flow control is available.
>> +
>> +To be compliant with this driver, the remote firmware must create its data end point associated with the "rpmsg-tty-raw" service.
>> +
>> +RPMsg TTY with control
>> +---------------------
>> +
>> +The default end point associated with the "rpmsg-tty-ctrl" service is reserved for
>> +the control. A second endpoint must be created for data exchange.
>> +
>> +The control channel is used to transmit to the remote processor the CTS status,
>> +as well as the end point address for data transfer.
>> +
>> +To be compatible with this driver, the remote firmware must create or use its end point associated with "rpmsg-tty-ctrl" service, plus a second endpoint for the data flow.
>> +On Linux rpmsg_tty probes, the data endpoint address and the CTS (set to disable)
>> +is sent to the remote processor.
>> +The remote processor has to respect following rules:
>> +- It only transmits data when Linux remote cts is enable, otherwise message
>> +  could be lost.
>> +- It can pause/resume reception by sending a control message (rely on CTS state).
>> +
>> +Control message structure:
>> +struct rpmsg_tty_ctrl {
>> +	u8 cts;			/* remote reception status */
>> +	u16 d_ept_addr;		/* data endpoint address */
>> +};
> Correct me if I'm wrong, but I think this structure should be packed,
> shouldn't it ?
> It's working ok on the STM32MP127, between M4 and A7, but the alignment
> may be not the same on another architecture ?
you are right, i have to fix this.

Thanks,
Arnaud

> 
> 
> 
>> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
>> index c7623f99ac0f..1046bf4aa709 100644
>> --- a/drivers/tty/Kconfig
>> +++ b/drivers/tty/Kconfig
>> @@ -454,6 +454,15 @@ config VCC
>>   	help
>>   	  Support for Sun logical domain consoles.
>>   
>> +config RPMSG_TTY
>> +	tristate "RPMSG tty driver"
>> +	depends on RPMSG
>> +	help
>> +	  Say y here to export rpmsg endpoints as tty devices, usually found
>> +	  in /dev/ttyRPMSGx.
>> +	  This makes it possible for user-space programs to send and receive
>> +	  rpmsg messages as a standard tty protocol.
>> +
>>   config LDISC_AUTOLOAD
>>   	bool "Automatically load TTY Line Disciplines"
>>   	default y
>> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
>> index 020b1cd9294f..c2465e7ebc2a 100644
>> --- a/drivers/tty/Makefile
>> +++ b/drivers/tty/Makefile
>> @@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
>>   obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>>   obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>>   obj-$(CONFIG_VCC)		+= vcc.o
>> +obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
>>   
>>   obj-y += ipwireless/
>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
>> new file mode 100644
>> index 000000000000..3e4d0e1a6663
>> --- /dev/null
>> +++ b/drivers/tty/rpmsg_tty.c
>> @@ -0,0 +1,418 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
>> + * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/rpmsg.h>
>> +#include <linux/slab.h>
>> +#include <linux/tty.h>
>> +#include <linux/tty_flip.h>
>> +
>> +#define MAX_TTY_RPMSG	32
>> +
>> +#define TTY_CH_NAME_RAW		"rpmsg-tty-raw"
>> +#define TTY_CH_NAME_WITH_CTS	"rpmsg-tty-ctrl"
>> +
>> +static DEFINE_IDR(tty_idr);	/* tty instance id */
>> +static DEFINE_MUTEX(idr_lock);	/* protects tty_idr */
>> +
>> +static struct tty_driver *rpmsg_tty_driver;
>> +
>> +struct rpmsg_tty_ctrl {
>> +	u8 cts;			/* remote reception status */
>> +	u16 d_ept_addr;		/* data endpoint address */
>> +};
>> +
>> +struct rpmsg_tty_port {
>> +	struct tty_port		port;	 /* TTY port data */
>> +	int			id;	 /* TTY rpmsg index */
>> +	bool			cts;	 /* remote reception status */
>> +	struct rpmsg_device	*rpdev;	 /* rpmsg device */
>> +	struct rpmsg_endpoint   *cs_ept; /* channel control endpoint */
>> +	struct rpmsg_endpoint   *d_ept;  /* data endpoint */
>> +	u32 data_dst;			 /* data destination endpoint address */
>> +};
>> +
>> +typedef void (*rpmsg_tty_rx_cb_t)(struct rpmsg_device *, void *, int, void *,
>> +				  u32);
>> +
>> +static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len,
>> +			void *priv, u32 src)
>> +{
>> +	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
>> +	int copied;
>> +
>> +	if (src == cport->data_dst) {
>> +		/* data message */
>> +		if (!len)
>> +			return -EINVAL;
>> +		/* data message */
>> +		copied = tty_insert_flip_string_fixed_flag(&cport->port, data,
>> +							   TTY_NORMAL, len);
>> +		if (copied != len)
>> +			dev_dbg(&rpdev->dev, "trunc buffer: available space is %d\n",
>> +				copied);
>> +		tty_flip_buffer_push(&cport->port);
>> +	} else {
>> +		/* control message */
>> +		struct rpmsg_tty_ctrl *msg = data;
>> +
>> +		if (len != sizeof(*msg))
>> +			return -EINVAL;
>> +
>> +		cport->data_dst = msg->d_ept_addr;
>> +
>> +		/* Update remote cts state */
>> +		cport->cts = msg->cts ? 1 : 0;
>> +
>> +		if (cport->cts)
>> +			tty_port_tty_wakeup(&cport->port);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rpmsg_tty_send_term_ready(struct tty_struct *tty, u8 state)
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +	struct rpmsg_tty_ctrl m_ctrl;
>> +	int ret;
>> +
>> +	m_ctrl.cts = state;
>> +	m_ctrl.d_ept_addr = cport->d_ept->addr;
>> +
>> +	ret = rpmsg_trysend(cport->cs_ept, &m_ctrl, sizeof(m_ctrl));
>> +	if (ret < 0)
>> +		dev_dbg(tty->dev, "cannot send control (%d)\n", ret);
>> +};
>> +
>> +static void rpmsg_tty_throttle(struct tty_struct *tty)
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +
>> +	/* Disable remote transmission */
>> +	if (cport->cs_ept)
>> +		rpmsg_tty_send_term_ready(tty, 0);
>> +};
>> +
>> +static void rpmsg_tty_unthrottle(struct tty_struct *tty)
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +
>> +	/* Enable remote transmission */
>> +	if (cport->cs_ept)
>> +		rpmsg_tty_send_term_ready(tty, 1);
>> +};
>> +
>> +static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>> +{
>> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
>> +
>> +	if (!cport) {
>> +		dev_err(tty->dev, "cannot get cport\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	tty->driver_data = cport;
>> +
>> +	return tty_port_install(&cport->port, driver, tty);
>> +}
>> +
>> +static int rpmsg_tty_open(struct tty_struct *tty, struct file *filp)
>> +{
>> +	return tty_port_open(tty->port, tty, filp);
>> +}
>> +
>> +static void rpmsg_tty_close(struct tty_struct *tty, struct file *filp)
>> +{
>> +	return tty_port_close(tty->port, tty, filp);
>> +}
>> +
>> +static int rpmsg_tty_write(struct tty_struct *tty, const u8 *buf, int len)
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +	struct rpmsg_device *rpdev;
>> +	int msg_max_size, msg_size;
>> +	int ret;
>> +	u8 *tmpbuf;
>> +
>> +	/* If cts not set, the message is not sent*/
>> +	if (!cport->cts)
>> +		return 0;
>> +
>> +	rpdev = cport->rpdev;
>> +
>> +	dev_dbg(&rpdev->dev, "%s: send msg from tty->index = %d, len = %d\n",
>> +		__func__, tty->index, len);
>> +
>> +	msg_max_size = rpmsg_get_mtu(rpdev->ept);
>> +
>> +	msg_size = min(len, msg_max_size);
>> +	tmpbuf = kzalloc(msg_size, GFP_KERNEL);
>> +	if (!tmpbuf)
>> +		return -ENOMEM;
>> +
>> +	memcpy(tmpbuf, buf, msg_size);
>> +
>> +	/*
>> +	 * Try to send the message to remote processor, if failed return 0 as
>> +	 * no data sent
>> +	 */
>> +	ret = rpmsg_trysendto(cport->d_ept, tmpbuf, msg_size, cport->data_dst);
>> +	kfree(tmpbuf);
>> +	if (ret) {
>> +		dev_dbg(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
>> +		return 0;
>> +	}
>> +
>> +	return msg_size;
>> +}
>> +
>> +static int rpmsg_tty_write_room(struct tty_struct *tty)
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +
>> +	return cport->cts ? rpmsg_get_mtu(cport->rpdev->ept) : 0;
>> +}
>> +
>> +static const struct tty_operations rpmsg_tty_ops = {
>> +	.install	= rpmsg_tty_install,
>> +	.open		= rpmsg_tty_open,
>> +	.close		= rpmsg_tty_close,
>> +	.write		= rpmsg_tty_write,
>> +	.write_room	= rpmsg_tty_write_room,
>> +	.throttle	= rpmsg_tty_throttle,
>> +	.unthrottle	= rpmsg_tty_unthrottle,
>> +};
>> +
>> +static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
>> +{
>> +	struct rpmsg_tty_port *cport;
>> +
>> +	cport = kzalloc(sizeof(*cport), GFP_KERNEL);
>> +	if (!cport)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mutex_lock(&idr_lock);
>> +	cport->id = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
>> +	mutex_unlock(&idr_lock);
>> +
>> +	if (cport->id < 0) {
>> +		kfree(cport);
>> +		return ERR_PTR(-ENOSPC);
>> +	}
>> +
>> +	return cport;
>> +}
>> +
>> +static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
>> +{
>> +	mutex_lock(&idr_lock);
>> +	idr_remove(&tty_idr, cport->id);
>> +	mutex_unlock(&idr_lock);
>> +
>> +	kfree(cport);
>> +}
>> +
>> +static int rpmsg_tty_port_activate(struct tty_port *p, struct tty_struct *tty)
>> +{
>> +	p->low_latency = (p->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
>> +
>> +	/* Allocate the buffer we use for writing data */
>> +	return tty_port_alloc_xmit_buf(p);
>> +}
>> +
>> +static void rpmsg_tty_port_shutdown(struct tty_port *p)
>> +{
>> +	/* Free the write buffer */
>> +	tty_port_free_xmit_buf(p);
>> +}
>> +
>> +static void rpmsg_tty_dtr_rts(struct tty_port *port, int raise)
>> +{
>> +	dev_dbg(port->tty->dev, "%s: dtr_rts state %d\n", __func__, raise);
>> +
>> +	if (raise)
>> +		rpmsg_tty_unthrottle(port->tty);
>> +	else
>> +		rpmsg_tty_throttle(port->tty);
>> +}
>> +
>> +static const struct tty_port_operations rpmsg_tty_port_ops = {
>> +	.activate = rpmsg_tty_port_activate,
>> +	.shutdown = rpmsg_tty_port_shutdown,
>> +	.dtr_rts  = rpmsg_tty_dtr_rts,
>> +};
>> +
>> +static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
>> +{
>> +	struct rpmsg_tty_port *cport;
>> +	struct device *dev = &rpdev->dev;
>> +	struct rpmsg_channel_info chinfo;
>> +	struct device *tty_dev;
>> +	int ret;
>> +
>> +	cport = rpmsg_tty_alloc_cport();
>> +	if (IS_ERR(cport)) {
>> +		dev_err(dev, "failed to alloc tty port\n");
>> +		return PTR_ERR(cport);
>> +	}
>> +
>> +	if (!strncmp(rpdev->id.name, TTY_CH_NAME_WITH_CTS,
>> +		     sizeof(TTY_CH_NAME_WITH_CTS))) {
>> +		/*
>> +		 * the default endpoint is used for control. Create a second
>> +		 * endpoint for the data that would be exchanges trough control
>> +		 * endpoint. address of the data endpoint will be provided with
>> +		 * the cts state
>> +		 */
>> +		cport->cs_ept = rpdev->ept;
>> +		cport->data_dst = RPMSG_ADDR_ANY;
>> +
>> +		strscpy(chinfo.name, TTY_CH_NAME_WITH_CTS, sizeof(chinfo.name));
>> +		chinfo.src = RPMSG_ADDR_ANY;
>> +		chinfo.dst = RPMSG_ADDR_ANY;
>> +
>> +		cport->d_ept = rpmsg_create_ept(rpdev, rpmsg_tty_cb, cport,
>> +						chinfo);
>> +		if (!cport->d_ept) {
>> +			dev_err(dev, "failed to create tty control channel\n");
>> +			ret = -ENOMEM;
>> +			goto err_r_cport;
>> +		}
>> +		dev_dbg(dev, "%s: creating data endpoint with address %#x\n",
>> +			__func__, cport->d_ept->addr);
>> +	} else {
>> +		/*
>> +		 * TTY over rpmsg without CTS management the default endpoint
>> +		 * is use for raw data transmission.
>> +		 */
>> +		cport->cs_ept = NULL;
>> +		cport->cts = 1;
>> +		cport->d_ept = rpdev->ept;
>> +		cport->data_dst = rpdev->dst;
>> +	}
>> +
>> +	tty_port_init(&cport->port);
>> +	cport->port.ops = &rpmsg_tty_port_ops;
>> +
>> +	tty_dev = tty_port_register_device(&cport->port, rpmsg_tty_driver,
>> +					   cport->id, dev);
>> +	if (IS_ERR(tty_dev)) {
>> +		dev_err(dev, "failed to register tty port\n");
>> +		ret = PTR_ERR(tty_dev);
>> +		goto  err_destroy;
>> +	}
>> +
>> +	cport->rpdev = rpdev;
>> +
>> +	dev_set_drvdata(dev, cport);
>> +
>> +	dev_dbg(dev, "new channel: 0x%x -> 0x%x : ttyRPMSG%d\n",
>> +		rpdev->src, rpdev->dst, cport->id);
>> +
>> +	return 0;
>> +
>> +err_destroy:
>> +	tty_port_destroy(&cport->port);
>> +	if (cport->cs_ept)
>> +		rpmsg_destroy_ept(cport->d_ept);
>> +err_r_cport:
>> +	rpmsg_tty_release_cport(cport);
>> +
>> +	return ret;
>> +}
>> +
>> +static void rpmsg_tty_remove(struct rpmsg_device *rpdev)
>> +{
>> +	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
>> +
>> +	dev_dbg(&rpdev->dev, "removing rpmsg tty device %d\n", cport->id);
>> +
>> +	/* User hang up to release the tty */
>> +	if (tty_port_initialized(&cport->port))
>> +		tty_port_tty_hangup(&cport->port, false);
>> +
>> +	tty_unregister_device(rpmsg_tty_driver, cport->id);
>> +
>> +	tty_port_destroy(&cport->port);
>> +	if (cport->cs_ept)
>> +		rpmsg_destroy_ept(cport->d_ept);
>> +	rpmsg_tty_release_cport(cport);
>> +}
>> +
>> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
>> +	{ .name	= TTY_CH_NAME_RAW },
>> +	{ .name	= TTY_CH_NAME_WITH_CTS},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(rpmsg, rpmsg_driver_tty_id_table);
>> +
>> +static struct rpmsg_driver rpmsg_tty_rpmsg_drv = {
>> +	.drv.name	= KBUILD_MODNAME,
>> +	.id_table	= rpmsg_driver_tty_id_table,
>> +	.probe		= rpmsg_tty_probe,
>> +	.callback	= rpmsg_tty_cb,
>> +	.remove		= rpmsg_tty_remove,
>> +};
>> +
>> +static int __init rpmsg_tty_init(void)
>> +{
>> +	int err;
>> +
>> +	rpmsg_tty_driver = tty_alloc_driver(MAX_TTY_RPMSG, TTY_DRIVER_REAL_RAW |
>> +					    TTY_DRIVER_DYNAMIC_DEV);
>> +	if (IS_ERR(rpmsg_tty_driver))
>> +		return PTR_ERR(rpmsg_tty_driver);
>> +
>> +	rpmsg_tty_driver->driver_name = "rpmsg_tty";
>> +	rpmsg_tty_driver->name = "ttyRPMSG";
>> +	rpmsg_tty_driver->major = 0;
>> +	rpmsg_tty_driver->type = TTY_DRIVER_TYPE_CONSOLE;
>> +
>> +	/* Disable unused mode by default */
>> +	rpmsg_tty_driver->init_termios = tty_std_termios;
>> +	rpmsg_tty_driver->init_termios.c_lflag &= ~(ECHO | ICANON);
>> +	rpmsg_tty_driver->init_termios.c_oflag &= ~(OPOST | ONLCR);
>> +
>> +	tty_set_operations(rpmsg_tty_driver, &rpmsg_tty_ops);
>> +
>> +	err = tty_register_driver(rpmsg_tty_driver);
>> +	if (err < 0) {
>> +		pr_err("Couldn't install rpmsg tty driver: err %d\n", err);
>> +		goto error_put;
>> +	}
>> +
>> +	err = register_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
>> +	if (err < 0) {
>> +		pr_err("Couldn't register rpmsg tty driver: err %d\n", err);
>> +		goto error_unregister;
>> +	}
>> +
>> +	return 0;
>> +
>> +error_unregister:
>> +	tty_unregister_driver(rpmsg_tty_driver);
>> +
>> +error_put:
>> +	put_tty_driver(rpmsg_tty_driver);
>> +
>> +	return err;
>> +}
>> +
>> +static void __exit rpmsg_tty_exit(void)
>> +{
>> +	unregister_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
>> +	tty_unregister_driver(rpmsg_tty_driver);
>> +	put_tty_driver(rpmsg_tty_driver);
>> +	idr_destroy(&tty_idr);
>> +}
>> +
>> +module_init(rpmsg_tty_init);
>> +module_exit(rpmsg_tty_exit);
>> +
>> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
>> +MODULE_DESCRIPTION("remote processor messaging tty driver");
>> +MODULE_LICENSE("GPL v2");
>>
> 
> Best regards,
> Richard
> 
