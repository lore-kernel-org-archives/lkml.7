Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB06C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9896920856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfEVJBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:01:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37147 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfEVJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:01:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so1324563wmo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 02:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L8RX4sPU7xtBZ/Yu6Cb5KIGIoicE2IW+b+xnWX81zOc=;
        b=ZqjuEz6gyJjJFXZLdEuBRW6EVsvEbTf01zGrrxRU5ror6aeJu5bvBYxR/Uj0F90f8R
         GBjhJAv595eq89Nzp909qwxqCfKNRASUhp7HI8YXDntk6+v3D9JgXp9bIoiaEudy7eSr
         z1UcRCDJYVCEgtpB3xyBk/bHUJWQEdnBL+kDfuvQGS0adi6TRb4hSwdiKo86XbrSE/qF
         HAZ3hPwbzvBT1MYPwrAoP2nVuMbd7rgdK9XIAk/QR16UMZpJPmCZvOGTeYLMQIPHDERs
         XMyybZ7mdqCeigGTPorL23pZObLmJkcj2DIrIugZqr7PgTFdzCv10lDLcoEy77kPL5LH
         pGHQ==
X-Gm-Message-State: APjAAAXoCZQnX6qPxtTfG1MNzMuTN03+YWEHuGOlKvfdGt6r+87vaSsL
        z0QMDSkd/FsOEwiBaK7W+vU=
X-Google-Smtp-Source: APXvYqyjb14fkukdqvHfwxTl9zyI4MF0r2ufe6I477JVKU2qbXpMI2csyNmjd9zhFdxzHUOma1foMQ==
X-Received: by 2002:a1c:be0b:: with SMTP id o11mr6834750wmf.63.1558515697516;
        Wed, 22 May 2019 02:01:37 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id u15sm43778174wru.16.2019.05.22.02.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 02:01:36 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] tty: add rpmsg driver
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabien DESSENNE <fabien.dessenne@st.com>
References: <1558103266-1613-1-git-send-email-arnaud.pouliquen@st.com>
 <1558103266-1613-3-git-send-email-arnaud.pouliquen@st.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <433332bb-e066-e752-7204-e4df336e4c95@suse.cz>
Date:   Wed, 22 May 2019 11:01:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558103266-1613-3-git-send-email-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 05. 19, 16:27, Arnaud Pouliquen wrote:
> This driver exposes a standard tty interface on top of the rpmsg
> framework through the "rpmsg-tty-channel" rpmsg service.
> 
> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
> per rpmsg endpoint.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  Documentation/serial/tty_rpmsg.txt |  38 +++
>  drivers/tty/Kconfig                |   9 +
>  drivers/tty/Makefile               |   1 +
>  drivers/tty/rpmsg_tty.c            | 479 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 527 insertions(+)
>  create mode 100644 Documentation/serial/tty_rpmsg.txt
>  create mode 100644 drivers/tty/rpmsg_tty.c
> 
> diff --git a/Documentation/serial/tty_rpmsg.txt b/Documentation/serial/tty_rpmsg.txt
> new file mode 100644
> index 000000000000..e069ed268a2b
> --- /dev/null
> +++ b/Documentation/serial/tty_rpmsg.txt
> @@ -0,0 +1,38 @@
> +
> +			The rpmsg TTY

Perhaps you should use rst nowadays.

> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> new file mode 100644
> index 000000000000..c7f53352acb6
> --- /dev/null
> +++ b/drivers/tty/rpmsg_tty.c
> @@ -0,0 +1,479 @@
...
> +struct rpmsg_tty_port {
> +	struct tty_port		port;	 /* TTY port data */
> +	int			id;	 /* TTY rpmsg index */
> +	struct rpmsg_device	*rpdev;	 /* rpmsg device */
> +	int			cts;	 /* remote reception status */

Just a nit, but if you move this int to the one above, you save some
bytes thanks to alignment and holes.

> +};
> +
> +typedef void (*rpmsg_tty_rx_cb_t)(struct rpmsg_device *, void *, int, void *,
> +				  u32);
> +
> +static void rpmsg_tty_data_handler(struct rpmsg_device *rpdev, void *data,
> +				   int len, void *priv, u32 src)
> +{
> +	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
> +	u8 *cbuf;
> +	int space;
> +
> +	dev_dbg(&rpdev->dev, "msg(<- src 0x%x) len %d\n", src, len);
> +
> +	if (!len)
> +		return;
> +
> +	space = tty_prepare_flip_string(&cport->port, &cbuf, len);
> +	if (space != len)
> +		dev_dbg(&rpdev->dev, "trunc buffer: available space is %d\n",
> +			len, space);
> +	if (space <= 0)
> +		return;
> +
> +	memcpy(cbuf, data, space);

Why is the above not tty_insert_flip_string_fixed_flag instead?

> +	tty_flip_buffer_push(&cport->port);
> +}
> +
> +static void rpmsg_tty_ctrl_handler(struct rpmsg_device *rpdev, void *data,
> +				   int len, void *priv, u32 src)
> +{
> +	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
> +	struct rpmsg_tty_ctrl *ctrl = data;
> +
> +	dev_dbg(&rpdev->dev, "%s: ctrl received %d\n", __func__, ctrl->ctrl);
> +	print_hex_dump_debug(__func__, DUMP_PREFIX_NONE, 16, 1, data, len,
> +			     true);
> +
> +	if (len <= sizeof(*ctrl)) {
> +		dev_err(&rpdev->dev, "%s: ctrl message invalid\n", __func__);
> +		return;
> +	}
> +
> +	if (ctrl->ctrl == DATA_TERM_READY) {

Could this be switch-case instead?

> +		/* Update the CTS according to remote RTS */
> +		if (!ctrl->values[0]) {
> +			cport->cts = 0;
> +		} else {
> +			cport->cts = 1;
> +			tty_port_tty_wakeup(&cport->port);
> +		}
> +	} else {
> +		dev_err(&rpdev->dev, "unknown control ID %d\n", ctrl->ctrl);
> +	}
> +}
> +
> +static const rpmsg_tty_rx_cb_t rpmsg_tty_handler[] = {
> +	[RPMSG_DATA] = rpmsg_tty_data_handler,
> +	[RPMSG_CTRL] = rpmsg_tty_ctrl_handler,
> +};
> +
> +static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len,
> +			void *priv, u32 src)
> +{
> +	struct rpmsg_tty_payload  *rbuf = data;
> +
> +	if (len <= sizeof(*rbuf) || rbuf->cmd > NUM_RPMSG_TTY_TYPE) {
> +		dev_err(&rpdev->dev, "Invalid message: size %d, type %d\n",
> +			len, rbuf->cmd);
> +		return -EINVAL;
> +	}
> +
> +	rpmsg_tty_handler[rbuf->cmd](rpdev, &rbuf->data,
> +				     len - sizeof(rbuf->cmd), priv, src);

Out-of-bound access if rbuf->cmd == NUM_RPMSG_TTY_TYPE, right? Nice hole.

> +
> +	return 0;
> +}
> +
> +static int rpmsg_tty_write_control(struct tty_struct *tty, u8 ctrl, u8 *values,
> +				   unsigned int n_value)
> +{
> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> +	struct rpmsg_tty_payload *msg;
> +	struct rpmsg_tty_ctrl *m_ctrl;
> +	struct rpmsg_device *rpdev;
> +	unsigned int msg_size;
> +	int ret;
> +
> +	if (!cport) {
> +		dev_err(tty->dev, "cannot get cport\n");
> +		return -ENODEV;
> +	}
> +
> +	rpdev = cport->rpdev;
> +
> +	msg_size = sizeof(*msg) + sizeof(*m_ctrl) + n_value;
> +	msg = kzalloc(msg_size, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->cmd = RPMSG_CTRL;
> +	m_ctrl =  (struct rpmsg_tty_ctrl *)&msg->data[0];
> +	m_ctrl->ctrl = DATA_TERM_READY;
> +	memcpy(m_ctrl->values, values, n_value);
> +
> +	ret = rpmsg_trysend(rpdev->ept, msg, msg_size);
> +	if (ret < 0) {
> +		dev_dbg(tty->dev, "cannot send control (%d)\n", ret);
> +		ret = 0;
> +	}
> +	kfree(msg);
> +
> +	return ret;
> +};
> +
> +static void rpmsg_tty_throttle(struct tty_struct *tty)
> +{
> +	u8 rts = 0;
> +
> +	/* Disable remote transmission */
> +	rpmsg_tty_write_control(tty, DATA_TERM_READY, &rts, 1);
> +};
> +
> +static void rpmsg_tty_unthrottle(struct tty_struct *tty)
> +{
> +	u8 rts = 1;
> +
> +	/* Enable remote transmission */
> +	rpmsg_tty_write_control(tty, DATA_TERM_READY, &rts, 1);
> +};
> +
> +static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
> +{
> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> +
> +	if (!cport) {
> +		dev_err(tty->dev, "cannot get cport\n");
> +		return -ENODEV;
> +	}

Set cport to driver_data?

> +
> +	return tty_port_install(&cport->port, driver, tty);
> +}
> +
> +static int rpmsg_tty_open(struct tty_struct *tty, struct file *filp)
> +{
> +	return tty_port_open(tty->port, tty, filp);
> +}
> +
> +static void rpmsg_tty_close(struct tty_struct *tty, struct file *filp)
> +{
> +	return tty_port_close(tty->port, tty, filp);
> +}
> +
> +static int rpmsg_tty_write(struct tty_struct *tty, const u8 *buf, int len)
> +{
> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);

Get from driver_data?

> +	struct rpmsg_device *rpdev;
> +	int msg_size, msg_max_size, ret = 0;
> +	int cmd_sz = sizeof(struct rpmsg_tty_payload);
> +	u8 *tmpbuf;
> +
> +	if (!cport) {

This would be superflous then?

> +		dev_err(tty->dev, "cannot get cport\n");
> +		return -ENODEV;
> +	}
> +
> +	/* If cts not set, the message is not sent*/
> +	if (!cport->cts)
> +		return 0;
> +
> +	rpdev = cport->rpdev;
> +
> +	dev_dbg(&rpdev->dev, "%s: send msg from tty->index = %d, len = %d\n",
> +		__func__, tty->index, len);
> +	if (!buf) {

How can this happen?

> +		dev_err(&rpdev->dev, "buf shouldn't be null.\n");
> +		return -ENOMEM;
> +	}
> +
> +	msg_max_size = rpmsg_get_buf_payload_size(rpdev->ept);
> +	if (msg_max_size < 0)
> +		return msg_max_size;
> +
> +	msg_size = min(len + cmd_sz, msg_max_size);
> +	tmpbuf = kzalloc(msg_size, GFP_KERNEL);
> +	if (!tmpbuf)
> +		return -ENOMEM;
> +
> +	tmpbuf[0] = RPMSG_DATA;
> +	memcpy(&tmpbuf[cmd_sz], buf, msg_size - cmd_sz);

Just curious: could "msg_size - cmd_sz" overflow to negatives? i.e.
msg_max_size < sizeof(struct rpmsg_tty_payload)?

> +
> +	/*
> +	 * Try to send the message to remote processor, if failed return 0 as
> +	 * no data sent
> +	 */
> +	ret = rpmsg_trysend(rpdev->ept, (void *)tmpbuf, msg_size);

No need to cast.

> +	kfree(tmpbuf);
> +	if (ret) {
> +		dev_dbg(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
> +		return 0;
> +	}
> +
> +	return msg_size - sizeof(struct rpmsg_tty_payload);

The latter is cmd_sz or not?

> +}
> +
> +static int rpmsg_tty_write_room(struct tty_struct *tty)
> +{
> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> +	int space = 0;
> +
> +	if (!cport) {

The same as above.

> +		dev_err(tty->dev, "cannot get cport\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Report the space in the rpmsg buffer, first byte is reserved to
> +	 * define the buffer type.
> +	 */
> +	if (cport->cts) {
> +		space = rpmsg_get_buf_payload_size(cport->rpdev->ept);
> +		space -= sizeof(struct rpmsg_tty_payload);
> +	}
> +
> +	return space;
> +}
> +
> +static const struct tty_operations rpmsg_tty_ops = {
> +	.install	= rpmsg_tty_install,
> +	.open		= rpmsg_tty_open,
> +	.close		= rpmsg_tty_close,
> +	.write		= rpmsg_tty_write,
> +	.write_room	= rpmsg_tty_write_room,
> +	.throttle	= rpmsg_tty_throttle,
> +	.unthrottle	= rpmsg_tty_unthrottle,
> +};
> +
> +static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
> +{
> +	struct rpmsg_tty_port *cport;
> +
> +	cport = kzalloc(sizeof(*cport), GFP_KERNEL);
> +	if (!cport)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_lock(&idr_lock);
> +	cport->id = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
> +	mutex_unlock(&idr_lock);
> +
> +	if (cport->id < 0) {
> +		kfree(cport);
> +		return ERR_PTR(-ENOSPC);
> +	}
> +
> +	return cport;
> +}
> +
> +static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
> +{
> +	mutex_lock(&idr_lock);
> +	idr_remove(&tty_idr, cport->id);
> +	mutex_unlock(&idr_lock);
> +
> +	kfree(cport);
> +}
> +
> +static int rpmsg_tty_port_activate(struct tty_port *p, struct tty_struct *tty)
> +{
> +	/* Allocate the buffer we use for writing data */
> +	return tty_port_alloc_xmit_buf(p);
> +}
> +
> +static void rpmsg_tty_port_shutdown(struct tty_port *p)
> +{
> +	/* Free the write buffer */
> +	tty_port_free_xmit_buf(p);
> +}
> +
> +static void rpmsg_tty_dtr_rts(struct tty_port *port, int raise)
> +{
> +	struct rpmsg_tty_port *cport =
> +				container_of(port, struct rpmsg_tty_port, port);
> +
> +	pr_debug("%s: dtr_rts state %d\n", __func__, raise);
> +	if (!port->tty || !cport) {

The latter barely can happen given you use container_of above.

> +		pr_err("invalid port\n");
> +		return;
> +	}
> +
> +	cport->cts = raise;
> +
> +	if (raise)
> +		rpmsg_tty_unthrottle(port->tty);
> +	else
> +		rpmsg_tty_throttle(port->tty);
> +}
> +
> +static const struct tty_port_operations rpmsg_tty_port_ops = {
> +	.activate = rpmsg_tty_port_activate,
> +	.shutdown = rpmsg_tty_port_shutdown,
> +	.dtr_rts  = rpmsg_tty_dtr_rts,
> +};
> +
> +static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_tty_port *cport;
> +	struct device *dev = &rpdev->dev;
> +	struct device *tty_dev;
> +	int ret;
> +
> +	cport = rpmsg_tty_alloc_cport();
> +	if (IS_ERR(cport)) {
> +		dev_err(dev, "failed to alloc tty port\n");
> +		return PTR_ERR(cport);
> +	}
> +
> +	tty_port_init(&cport->port);
> +	cport->port.low_latency = cport->port.flags | ASYNC_LOW_LATENCY;

"|"? Not "&"? You should prepend "!!" in any way as low latency is 13th bit.

> +	cport->port.ops = &rpmsg_tty_port_ops;
> +
> +	tty_dev = tty_port_register_device(&cport->port, rpmsg_tty_driver,
> +					   cport->id, dev);
> +	if (IS_ERR(tty_dev)) {
> +		dev_err(dev, "failed to register tty port\n");
> +		ret = PTR_ERR(tty_dev);
> +		goto  err_destroy;
> +	}
...
regards,
-- 
js
suse labs
