Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16201C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5A520868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uVwb4PZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfEVQP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:15:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36326 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729576AbfEVQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:15:57 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MGDeWr014311;
        Wed, 22 May 2019 18:15:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=VZgb3tFvnUtPcFgmnk8RmrYuaOjqkiYQ7TbWalBB6Ow=;
 b=uVwb4PZBAKfYdzO5p3Gmt3r7ZC8+2Y70NUjfCt51fZwJVlFNNA6rwvVR85KSHJy6o2WQ
 795bAHyfp5XdYqf/z9bGgCdQWHYOUKzZGAisfEJumuHQU2V82sc34N7wAgzTqAoSIe14
 QxJCSPBEFfnFoIJy79tDvYqo7Xv6fMhFyKdli5kxBs1LOnqYi5b/0GY5x1YjXKkB7Bsn
 sGD56GIdfBp5InitUKEpQwRilwXfs2ZZUdXaEnpoHnTkISf7AUavpxr2H23yZjliJ/oT
 QAoAqh9S0HyxrmyCFFhP1GDmwwzKFGuPEF/zF6R3lLpi1VOMXyTO4V+VBHfWQ8sO1w6F bQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sj8xghgqk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 22 May 2019 18:15:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33FBF31;
        Wed, 22 May 2019 16:15:42 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6EFC2C59;
        Wed, 22 May 2019 16:15:41 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 May
 2019 18:15:41 +0200
Subject: Re: [PATCH v3 2/2] tty: add rpmsg driver
To:     Jiri Slaby <jslaby@suse.cz>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>
CC:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>
References: <1558103266-1613-1-git-send-email-arnaud.pouliquen@st.com>
 <1558103266-1613-3-git-send-email-arnaud.pouliquen@st.com>
 <433332bb-e066-e752-7204-e4df336e4c95@suse.cz>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <d9d06da4-0d78-5287-fda6-a8b726df30ad@st.com>
Date:   Wed, 22 May 2019 18:15:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <433332bb-e066-e752-7204-e4df336e4c95@suse.cz>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiri,

On 5/22/19 11:01 AM, Jiri Slaby wrote:
> On 17. 05. 19, 16:27, Arnaud Pouliquen wrote:
>> This driver exposes a standard tty interface on top of the rpmsg
>> framework through the "rpmsg-tty-channel" rpmsg service.
>>
>> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
>> per rpmsg endpoint.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
>> ---
>>  Documentation/serial/tty_rpmsg.txt |  38 +++
>>  drivers/tty/Kconfig                |   9 +
>>  drivers/tty/Makefile               |   1 +
>>  drivers/tty/rpmsg_tty.c            | 479 +++++++++++++++++++++++++++++++++++++
>>  4 files changed, 527 insertions(+)
>>  create mode 100644 Documentation/serial/tty_rpmsg.txt
>>  create mode 100644 drivers/tty/rpmsg_tty.c
>>
>> diff --git a/Documentation/serial/tty_rpmsg.txt b/Documentation/serial/tty_rpmsg.txt
>> new file mode 100644
>> index 000000000000..e069ed268a2b
>> --- /dev/null
>> +++ b/Documentation/serial/tty_rpmsg.txt
>> @@ -0,0 +1,38 @@
>> +
>> +			The rpmsg TTY
> 
> Perhaps you should use rst nowadays.
> 
>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
>> new file mode 100644
>> index 000000000000..c7f53352acb6
>> --- /dev/null
>> +++ b/drivers/tty/rpmsg_tty.c
>> @@ -0,0 +1,479 @@
> ...
>> +struct rpmsg_tty_port {
>> +	struct tty_port		port;	 /* TTY port data */
>> +	int			id;	 /* TTY rpmsg index */
>> +	struct rpmsg_device	*rpdev;	 /* rpmsg device */
>> +	int			cts;	 /* remote reception status */
> 
> Just a nit, but if you move this int to the one above, you save some
> bytes thanks to alignment and holes.
Indeed for 64 bit arch can be more optimized
> 
>> +};
>> +
>> +typedef void (*rpmsg_tty_rx_cb_t)(struct rpmsg_device *, void *, int, void *,
>> +				  u32);
>> +
>> +static void rpmsg_tty_data_handler(struct rpmsg_device *rpdev, void *data,
>> +				   int len, void *priv, u32 src)
>> +{
>> +	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
>> +	u8 *cbuf;
>> +	int space;
>> +
>> +	dev_dbg(&rpdev->dev, "msg(<- src 0x%x) len %d\n", src, len);
>> +
>> +	if (!len)
>> +		return;
>> +
>> +	space = tty_prepare_flip_string(&cport->port, &cbuf, len);
>> +	if (space != len)
>> +		dev_dbg(&rpdev->dev, "trunc buffer: available space is %d\n",
>> +			len, space);
>> +	if (space <= 0)
>> +		return;
>> +
>> +	memcpy(cbuf, data, space);
> 
> Why is the above not tty_insert_flip_string_fixed_flag instead?
Just because i was not aware about this (i parsed driver/tty looking for
an example), thanks to reporting it to me!
> 
>> +	tty_flip_buffer_push(&cport->port);
>> +}
>> +
>> +static void rpmsg_tty_ctrl_handler(struct rpmsg_device *rpdev, void *data,
>> +				   int len, void *priv, u32 src)
>> +{
>> +	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
>> +	struct rpmsg_tty_ctrl *ctrl = data;
>> +
>> +	dev_dbg(&rpdev->dev, "%s: ctrl received %d\n", __func__, ctrl->ctrl);
>> +	print_hex_dump_debug(__func__, DUMP_PREFIX_NONE, 16, 1, data, len,
>> +			     true);
>> +
>> +	if (len <= sizeof(*ctrl)) {
>> +		dev_err(&rpdev->dev, "%s: ctrl message invalid\n", __func__);
>> +		return;
>> +	}
>> +
>> +	if (ctrl->ctrl == DATA_TERM_READY) {
> 
> Could this be switch-case instead?
Yes for future extension, i hesitated... "if" seems more optimized if
only one case.
> 
>> +		/* Update the CTS according to remote RTS */
>> +		if (!ctrl->values[0]) {
>> +			cport->cts = 0;
>> +		} else {
>> +			cport->cts = 1;
>> +			tty_port_tty_wakeup(&cport->port);
>> +		}
>> +	} else {
>> +		dev_err(&rpdev->dev, "unknown control ID %d\n", ctrl->ctrl);
>> +	}
>> +}
>> +
>> +static const rpmsg_tty_rx_cb_t rpmsg_tty_handler[] = {
>> +	[RPMSG_DATA] = rpmsg_tty_data_handler,
>> +	[RPMSG_CTRL] = rpmsg_tty_ctrl_handler,
>> +};
>> +
>> +static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len,
>> +			void *priv, u32 src)
>> +{
>> +	struct rpmsg_tty_payload  *rbuf = data;
>> +
>> +	if (len <= sizeof(*rbuf) || rbuf->cmd > NUM_RPMSG_TTY_TYPE) {
>> +		dev_err(&rpdev->dev, "Invalid message: size %d, type %d\n",
>> +			len, rbuf->cmd);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rpmsg_tty_handler[rbuf->cmd](rpdev, &rbuf->data,
>> +				     len - sizeof(rbuf->cmd), priv, src);
> 
> Out-of-bound access if rbuf->cmd == NUM_RPMSG_TTY_TYPE, right? Nice hole.
oops...this kind of error should not allowed on such a basic test :(

>> +
>> +	return 0;
>> +}
>> +
>> +static int rpmsg_tty_write_control(struct tty_struct *tty, u8 ctrl, u8 *values,
>> +				   unsigned int n_value)
>> +{
>> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
>> +	struct rpmsg_tty_payload *msg;
>> +	struct rpmsg_tty_ctrl *m_ctrl;
>> +	struct rpmsg_device *rpdev;
>> +	unsigned int msg_size;
>> +	int ret;
>> +
>> +	if (!cport) {
>> +		dev_err(tty->dev, "cannot get cport\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	rpdev = cport->rpdev;
>> +
>> +	msg_size = sizeof(*msg) + sizeof(*m_ctrl) + n_value;
>> +	msg = kzalloc(msg_size, GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	msg->cmd = RPMSG_CTRL;
>> +	m_ctrl =  (struct rpmsg_tty_ctrl *)&msg->data[0];
>> +	m_ctrl->ctrl = DATA_TERM_READY;
>> +	memcpy(m_ctrl->values, values, n_value);
>> +
>> +	ret = rpmsg_trysend(rpdev->ept, msg, msg_size);
>> +	if (ret < 0) {
>> +		dev_dbg(tty->dev, "cannot send control (%d)\n", ret);
>> +		ret = 0;
>> +	}
>> +	kfree(msg);
>> +
>> +	return ret;
>> +};
>> +
>> +static void rpmsg_tty_throttle(struct tty_struct *tty)
>> +{
>> +	u8 rts = 0;
>> +
>> +	/* Disable remote transmission */
>> +	rpmsg_tty_write_control(tty, DATA_TERM_READY, &rts, 1);
>> +};
>> +
>> +static void rpmsg_tty_unthrottle(struct tty_struct *tty)
>> +{
>> +	u8 rts = 1;
>> +
>> +	/* Enable remote transmission */
>> +	rpmsg_tty_write_control(tty, DATA_TERM_READY, &rts, 1);
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
> 
> Set cport to driver_data?
Yes would be more optimized, i will test it.
> 
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
>> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> 
> Get from driver_data?
> 
>> +	struct rpmsg_device *rpdev;
>> +	int msg_size, msg_max_size, ret = 0;
>> +	int cmd_sz = sizeof(struct rpmsg_tty_payload);
>> +	u8 *tmpbuf;
>> +
>> +	if (!cport) {
> 
> This would be superflous then?
yes
> 
>> +		dev_err(tty->dev, "cannot get cport\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* If cts not set, the message is not sent*/
>> +	if (!cport->cts)
>> +		return 0;
>> +
>> +	rpdev = cport->rpdev;
>> +
>> +	dev_dbg(&rpdev->dev, "%s: send msg from tty->index = %d, len = %d\n",
>> +		__func__, tty->index, len);
>> +	if (!buf) {
> 
> How can this happen?
overprotection, i will clean it
> 
>> +		dev_err(&rpdev->dev, "buf shouldn't be null.\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	msg_max_size = rpmsg_get_buf_payload_size(rpdev->ept);
>> +	if (msg_max_size < 0)
>> +		return msg_max_size;
>> +
>> +	msg_size = min(len + cmd_sz, msg_max_size);
>> +	tmpbuf = kzalloc(msg_size, GFP_KERNEL);
>> +	if (!tmpbuf)
>> +		return -ENOMEM;
>> +
>> +	tmpbuf[0] = RPMSG_DATA;
>> +	memcpy(&tmpbuf[cmd_sz], buf, msg_size - cmd_sz);
> 
> Just curious: could "msg_size - cmd_sz" overflow to negatives? i.e.
> msg_max_size < sizeof(struct rpmsg_tty_payload)?
In theory this could not happen today as rpmsg payload size is fixed to
496 bytes. In future this size could be customizable. But this would
be a design issue.

> 
>> +
>> +	/*
>> +	 * Try to send the message to remote processor, if failed return 0 as
>> +	 * no data sent
>> +	 */
>> +	ret = rpmsg_trysend(rpdev->ept, (void *)tmpbuf, msg_size);
> 
> No need to cast.
> 
>> +	kfree(tmpbuf);
>> +	if (ret) {
>> +		dev_dbg(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
>> +		return 0;
>> +	}
>> +
>> +	return msg_size - sizeof(struct rpmsg_tty_payload);
> 
> The latter is cmd_sz or not?
yes to be replaced for readability.
> 
>> +}
>> +
>> +static int rpmsg_tty_write_room(struct tty_struct *tty)
>> +{
>> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
>> +	int space = 0;
>> +
>> +	if (!cport) {
> 
> The same as above.
> 
>> +		dev_err(tty->dev, "cannot get cport\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/*
>> +	 * Report the space in the rpmsg buffer, first byte is reserved to
>> +	 * define the buffer type.
>> +	 */
>> +	if (cport->cts) {
>> +		space = rpmsg_get_buf_payload_size(cport->rpdev->ept);
>> +		space -= sizeof(struct rpmsg_tty_payload);
>> +	}
>> +
>> +	return space;
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
>> +	struct rpmsg_tty_port *cport =
>> +				container_of(port, struct rpmsg_tty_port, port);
>> +
>> +	pr_debug("%s: dtr_rts state %d\n", __func__, raise);
>> +	if (!port->tty || !cport) {
> 
> The latter barely can happen given you use container_of above.
overprotection again
> 
>> +		pr_err("invalid port\n");
>> +		return;
>> +	}
>> +
>> +	cport->cts = raise;
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
>> +	struct device *tty_dev;
>> +	int ret;
>> +
>> +	cport = rpmsg_tty_alloc_cport();
>> +	if (IS_ERR(cport)) {
>> +		dev_err(dev, "failed to alloc tty port\n");
>> +		return PTR_ERR(cport);
>> +	}
>> +
>> +	tty_port_init(&cport->port);
>> +	cport->port.low_latency = cport->port.flags | ASYNC_LOW_LATENCY;
> 
> "|"? Not "&"? You should prepend "!!" in any way as low latency is 13th bit.
After crosscheck this line is wrong and should not be fixed in probe.
Should be in activate ops (as done in uart_port_activate)

> 
>> +	cport->port.ops = &rpmsg_tty_port_ops;
>> +
>> +	tty_dev = tty_port_register_device(&cport->port, rpmsg_tty_driver,
>> +					   cport->id, dev);
>> +	if (IS_ERR(tty_dev)) {
>> +		dev_err(dev, "failed to register tty port\n");
>> +		ret = PTR_ERR(tty_dev);
>> +		goto  err_destroy;
>> +	}
> ...
> regards,
> 
--
Thanks for your reviewing
i will send a V4 soon to fix.

Regards,
Arnaud
