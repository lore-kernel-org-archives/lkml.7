Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D322EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745CF2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewrurWo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfDPQQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:16:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42112 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfDPQQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:16:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so17438371oie.9;
        Tue, 16 Apr 2019 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0VKgjRSMizxtvWYaamXNufFDdzutmT2oyalw20vklAg=;
        b=ewrurWo0pQoyBOhE4X71QzuXrhnlMc+DIMQx9qPGvNrUGv2otNx4zP3YJnhYy3Pn6r
         Qqx7LjvvftbnvdOz6q7da9J8Rxe3+rlveCd0gASaZ1//x4QlIwsbgmbGbbvC8xmYv3bQ
         nHi9SYMnTR6tYw9UG1NF+XgEaKjzkgmHgCBjJLgnf77HO3kd83OfqSH6yxs+iWoFFdr+
         4ao8+o5nDo6qfbz/QWGJG0na+Ay3e5SKCWygmJJbr3YSQaYjUg5WCzG3I6Oi2PrSXFew
         occ9fKxZAdvcFWvF+p8vqok3dblF23zJRYWfCKVizviovWzMrvBURzj98sPQYkB2wYSQ
         ajBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=0VKgjRSMizxtvWYaamXNufFDdzutmT2oyalw20vklAg=;
        b=Rko4ZjzIFgmi6Nn7fDWis2RXWlHJAYd2f6txoTxisge1k8Z9Sg6yHnH9856ioPJoLx
         K2do2IlCOsh5vlRwhmVJoRtON7DgAg7edhck2trxCDZSxLWy6t9A/d3oD+Rtjg6fTGuj
         /i5V+n2NPjMz5H6wirzdGagmdMEz+pBGiVHxJXJkhK6YUuT5JOAG7AIyETfuVwFvW0PS
         QoDleyhC1Sc4R8J9lroNLj0mWmUck3AheazBGCNUR+Rz6GBkHfd4hPoi73uSgAJY8ZJk
         rBucHh/+V8QOZ4Rlz+7lWkZ0oYRj1BPo9ln8hVvTdrT7MdAIAM2bXr4na5tj3lXan99N
         itXA==
X-Gm-Message-State: APjAAAVTIclJOAITUcXYdaefZrUPuTkUPUCM1lEzbQTcAta/Q52phW2h
        V9PLXRFAXoqBpxBXG+htIkZRCXo=
X-Google-Smtp-Source: APXvYqwXFXXpRf2dRervSEtaTiPZGG/ofJAfiWEMY4/0qsd5Z29cXM2kt2HzD4wbqImT7I8gyO/94w==
X-Received: by 2002:aca:b841:: with SMTP id i62mr24895215oif.103.1555431374944;
        Tue, 16 Apr 2019 09:16:14 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id a20sm7133257otd.0.2019.04.16.09.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 09:16:14 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id 4BC621800CF;
        Tue, 16 Apr 2019 16:16:13 +0000 (UTC)
Date:   Tue, 16 Apr 2019 11:16:12 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Add support for IPMB driver
Message-ID: <20190416161612.GK4121@minyard.net>
Reply-To: minyard@acm.org
References: <cover.1555105745.git.Asmaa@mellanox.com>
 <7664a7fca1ebe0a2e44e37be96827df4602c7cb6.1555105745.git.Asmaa@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7664a7fca1ebe0a2e44e37be96827df4602c7cb6.1555105745.git.Asmaa@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 05:59:16PM -0400, Asmaa Mnebhi wrote:
> Support receiving IPMB requests on a Satellite MC from the BMC.
> Once a response is ready, this driver will send back a response
> to the BMC via the IPMB channel.

I haven't done a detailed analysis of this, but from a cursory
look it looks structurally good.  I made a few small comments
inline.

But there is really very little here that is IPMB-specific.
You could push the few IPMB-specific formatting things up
to userland, I think.

I am wondering if you could make this into a generic I2C
slave interface.  I'm adding the I2C mailing list to the CC
and for their review.

For the I2C mailing list...

IPMB is a protocol that lets IPMI devices talk between
themselves, so it is master/slave on all device on the
IPMB.  It's basically designed so that modular parts of
the system (like a power supply) can have their own
IPMI management controller that handles things for that
device, and a management system can discover these and
use them through the main IPMI management controller.
It's used like a normal packet-oriented bus, with only
writes, no reads.

It seems to me that you could create a slave-specific
I2C device that only received messages and took
responses to those messages.  You could use the normal
I2C dev interface to to the sends and open a separate
I2C slave dev interface to do the receives.

-corey

> 
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
> ---
>  drivers/char/ipmi/Kconfig        |   8 +
>  drivers/char/ipmi/Makefile       |   1 +
>  drivers/char/ipmi/ipmb_dev_int.c | 418 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 427 insertions(+)
>  create mode 100644 drivers/char/ipmi/ipmb_dev_int.c
> 
> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> index 94719fc..784bc84 100644
> --- a/drivers/char/ipmi/Kconfig
> +++ b/drivers/char/ipmi/Kconfig
> @@ -74,6 +74,14 @@ config IPMI_SSIF
>  	 have a driver that must be accessed over an I2C bus instead of a
>  	 standard interface.  This module requires I2C support.
>  
> +config IPMB_DEVICE_INTERFACE
> +       tristate 'IPMB Interface handler'
> +       select I2C
> +       help
> +         Provides a driver for a device (Satellite MC) to
> +         receive requests and send responses back to the BMC via
> +         the IPMB interface. This module requires I2C support.
> +
>  config IPMI_POWERNV
>         depends on PPC_POWERNV
>         tristate 'POWERNV (OPAL firmware) IPMI interface'
> diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
> index 3f06b20..0822adc 100644
> --- a/drivers/char/ipmi/Makefile
> +++ b/drivers/char/ipmi/Makefile
> @@ -26,3 +26,4 @@ obj-$(CONFIG_IPMI_KCS_BMC) += kcs_bmc.o
>  obj-$(CONFIG_ASPEED_BT_IPMI_BMC) += bt-bmc.o
>  obj-$(CONFIG_ASPEED_KCS_IPMI_BMC) += kcs_bmc_aspeed.o
>  obj-$(CONFIG_NPCM7XX_KCS_IPMI_BMC) += kcs_bmc_npcm7xx.o
> +obj-$(CONFIG_IPMB_DEVICE_INTERFACE) += ipmb_dev_int.o
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> new file mode 100644
> index 0000000..a45a686
> --- /dev/null
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -0,0 +1,418 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Mellanox IPMB driver to receive a request and send a response
> + *
> + * Copyright (C) 2018 Mellanox Techologies, Ltd.
> + *
> + * This was inspired by Brendan Higgins' ipmi-bmc-bt-i2c driver.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/poll.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/wait.h>
> +
> +#define	PFX	"IPMB DEV INT: "
> +
> +#define	DEVICE_NAME	"ipmb-dev"
> +
> +#define	MAX_MSG_LEN		128
> +#define	IPMB_REQUEST_LEN_MIN	7
> +#define	NETFN_RSP_BIT_MASK	0x4
> +#define	REQUEST_QUEUE_MAX_LEN	256
> +
> +#define	IPMB_MSG_LEN_IDX	0
> +#define	RQ_SA_8BIT_IDX		1
> +#define	NETFN_LUN_IDX		2
> +
> +#define	IPMB_MSG_PAYLOAD_LEN_MAX \
> +	(MAX_MSG_LEN - IPMB_REQUEST_LEN_MIN - 1)
> +
> +struct ipmb_msg {
> +	u8 len;
> +	u8 rs_sa;
> +	u8 netfn_rs_lun;
> +	u8 checksum1;
> +	u8 rq_sa;
> +	u8 rq_seq_rq_lun;
> +	u8 cmd;
> +	u8 payload[IPMB_MSG_PAYLOAD_LEN_MAX];
> +	/* checksum2 is included in payload */
> +} __packed;
> +
> +static u32 ipmb_msg_len(struct ipmb_msg *ipmb_msg)
> +{
> +	return ipmb_msg->len + 1;
> +}
> +
> +struct ipmb_request_elem {
> +	struct list_head list;
> +	struct ipmb_msg request;
> +};
> +
> +struct ipmb_dev {
> +	struct i2c_client *client;
> +	struct miscdevice miscdev;
> +	struct ipmb_msg request;
> +	struct list_head request_queue;
> +	atomic_t request_queue_len;
> +	struct ipmb_msg response;
> +	size_t msg_idx;
> +	spinlock_t lock;
> +	wait_queue_head_t wait_queue;
> +	struct mutex file_mutex;
> +};
> +
> +static int receive_ipmb_request(struct ipmb_dev *ipmb_dev_p,
> +				bool non_blocking,
> +				struct ipmb_msg *ipmb_request)
> +{
> +	struct ipmb_request_elem *queue_elem;
> +	unsigned long flags;
> +	int res;
> +
> +	if (!non_blocking) {
> +
> +try_again:
> +		res = wait_event_interruptible(ipmb_dev_p->wait_queue,
> +				atomic_read(&ipmb_dev_p->request_queue_len));
> +		if (res)
> +			return res;
> +	}
> +
> +	spin_lock_irqsave(&ipmb_dev_p->lock, flags);
> +
> +	if (!atomic_read(&ipmb_dev_p->request_queue_len)) {
> +		spin_unlock_irqrestore(&ipmb_dev_p->lock, flags);
> +		if (non_blocking)
> +			return -EAGAIN;
> +		goto try_again;
> +	}
> +
> +	if (list_empty(&ipmb_dev_p->request_queue)) {
> +		pr_err(PFX "request_queue is empty\n");
> +		return -EIO;
> +	}
> +
> +	queue_elem = list_first_entry(&ipmb_dev_p->request_queue,
> +					struct ipmb_request_elem, list);
> +	memcpy(ipmb_request, &queue_elem->request, sizeof(*ipmb_request));
> +	list_del(&queue_elem->list);
> +	kfree(queue_elem);
> +	atomic_dec(&ipmb_dev_p->request_queue_len);
> +
> +	spin_unlock_irqrestore(&ipmb_dev_p->lock, flags);
> +
> +	return 0;
> +}
> +
> +static inline struct ipmb_dev *to_ipmb_dev(struct file *file)
> +{
> +	return container_of(file->private_data, struct ipmb_dev, miscdev);
> +}
> +
> +static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
> +			loff_t *ppos)
> +{
> +	struct ipmb_dev *ipmb_dev_p = to_ipmb_dev(file);
> +	struct ipmb_msg msg;
> +	ssize_t ret;
> +
> +	if (!ipmb_dev_p)
> +		return -ENOMEM;

I don't think this can happen.  Same for other things like this.

> +
> +	memset(&msg, 0, sizeof(msg));
> +
> +	mutex_lock(&ipmb_dev_p->file_mutex);
> +	ret = receive_ipmb_request(ipmb_dev_p, file->f_flags & O_NONBLOCK,
> +				&msg);
> +	if (ret < 0)
> +		goto out;
> +	count = min_t(size_t, count, ipmb_msg_len(&msg));
> +	if (copy_to_user(buf, &msg, count)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +out:
> +	mutex_unlock(&ipmb_dev_p->file_mutex);
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return count;
> +}
> +
> +static s32 i2c_smbus_write_block_data_local(struct i2c_client *client,
> +					u8 command, u8 length,
> +					u16 requester_i2c_addr,
> +					const char *msg)
> +{
> +	union i2c_smbus_data data;
> +	int ret;
> +
> +	if (length > I2C_SMBUS_BLOCK_MAX)
> +		length = I2C_SMBUS_BLOCK_MAX;
> +
> +	data.block[0] = length;
> +	memcpy(&data.block[1], msg, length);
> +
> +	ret = i2c_smbus_xfer(client->adapter, requester_i2c_addr,
> +				client->flags,
> +				I2C_SMBUS_WRITE, command,
> +				I2C_SMBUS_BLOCK_DATA, &data);
> +
> +	return ret;
> +}
> +
> +static ssize_t ipmb_write(struct file *file, const char __user *buf,
> +			size_t count, loff_t *ppos)
> +{
> +	struct ipmb_dev *ipmb_dev_p = to_ipmb_dev(file);
> +	u8 msg[MAX_MSG_LEN];
> +	ssize_t ret;
> +	u8 rq_sa, netf_rq_lun, msg_len;
> +
> +	if (!ipmb_dev_p)
> +		return -ENOMEM;
> +
> +	if (count > sizeof(msg))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&msg, buf, count) || count < msg[0])
> +		return -EINVAL;

copy_from_user() should return -EFAULT on an error.

> +
> +	rq_sa = (u16)(msg[RQ_SA_8BIT_IDX] >> 1);
> +	netf_rq_lun = msg[NETFN_LUN_IDX];
> +	/*
> +	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
> +	 * i2c_smbus_write_block_data_local
> +	 */
> +	msg_len = msg[IPMB_MSG_LEN_IDX] - 2;
> +
> +	mutex_lock(&ipmb_dev_p->file_mutex);
> +	ret = i2c_smbus_write_block_data_local(ipmb_dev_p->client,
> +					netf_rq_lun, msg_len, rq_sa, msg + 3);
> +	mutex_unlock(&ipmb_dev_p->file_mutex);
> +
> +	if (ret)
> +		return ret;
> +	else
> +		return count;
> +}
> +
> +static unsigned int ipmb_poll(struct file *file, poll_table *wait)
> +{
> +	struct ipmb_dev *ipmb_dev_p = to_ipmb_dev(file);
> +	unsigned int mask = 0;
> +
> +	mutex_lock(&ipmb_dev_p->file_mutex);
> +	poll_wait(file, &ipmb_dev_p->wait_queue, wait);
> +
> +	if (atomic_read(&ipmb_dev_p->request_queue_len))
> +		mask |= POLLIN;
> +	mask |= POLLOUT;
> +	mutex_unlock(&ipmb_dev_p->file_mutex);
> +	return mask;
> +}
> +
> +static const struct file_operations ipmb_fops = {
> +	.owner	= THIS_MODULE,
> +	.read	= ipmb_read,
> +	.write	= ipmb_write,
> +	.poll	= ipmb_poll,
> +};
> +
> +/* Called with ipmb_dev->lock held. */
> +static int handle_request(struct ipmb_dev *ipmb_dev_p)

The return value from handle_request is ignored below, do
you need to return it?

> +{
> +	struct ipmb_request_elem *queue_elem;
> +
> +	if (atomic_read(&ipmb_dev_p->request_queue_len) >=
> +			REQUEST_QUEUE_MAX_LEN)
> +		return -EFAULT;

EFAULT is not what you want here.  I'm not sure exactly what
to do here, but you should probably just drop the data on
the floor, maybe have a counter to count dropped packets.

> +
> +	queue_elem = kmalloc(sizeof(*queue_elem), GFP_KERNEL);
> +	if (!queue_elem)
> +		return -ENOMEM;
> +
> +	memcpy(&queue_elem->request, &ipmb_dev_p->request,
> +		sizeof(struct ipmb_msg));
> +	list_add(&queue_elem->list, &ipmb_dev_p->request_queue);
> +	atomic_inc(&ipmb_dev_p->request_queue_len);
> +	wake_up_all(&ipmb_dev_p->wait_queue);
> +
> +	return 0;
> +}
> +
> +static u8 verify_checksum1(struct ipmb_dev *ipmb_dev_p, u8 rs_sa)
> +{
> +	return (rs_sa + ipmb_dev_p->request.netfn_rs_lun +
> +		ipmb_dev_p->request.checksum1);
> +}
> +
> +static bool is_ipmb_request(struct ipmb_dev *ipmb_dev_p, u8 rs_sa)
> +{
> +	if (ipmb_dev_p->msg_idx >= IPMB_REQUEST_LEN_MIN) {
> +		if (verify_checksum1(ipmb_dev_p, rs_sa))
> +			return false;
> +
> +		/*
> +		 * Check whether this is an IPMB request or
> +		 * response.
> +		 * The 6 MSB of netfn_rs_lun are dedicated to the netfn
> +		 * while the remaining bits are dedicated to the lun.
> +		 * If the LSB of the netfn is cleared, it is associated
> +		 * with an IPMB request.
> +		 * If the LSB of the netfn is set, it is associated with
> +		 * an IPMB response.
> +		 */
> +		if (!(ipmb_dev_p->request.netfn_rs_lun & NETFN_RSP_BIT_MASK))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * The IPMB protocol only supports I2C Writes so there is no need
> + * to support I2C_SLAVE_READ* events.
> + * This i2c callback function only monitors IPMB request messages
> + * and adds them in a queue, so that they can be handled by
> + * receive_ipmb_request.
> + */
> +static int ipmb_slave_cb(struct i2c_client *client,
> +			enum i2c_slave_event event, u8 *val)
> +{
> +	struct ipmb_dev *ipmb_dev_p = i2c_get_clientdata(client);
> +	u8 *buf = (u8 *)&ipmb_dev_p->request;
> +
> +	spin_lock(&ipmb_dev_p->lock);
> +	switch (event) {
> +	case I2C_SLAVE_WRITE_REQUESTED:
> +		memset(&ipmb_dev_p->request, 0, sizeof(ipmb_dev_p->request));
> +		ipmb_dev_p->msg_idx = 0;
> +
> +		/*
> +		 * At index 0, ipmb_msg stores the length of msg,
> +		 * skip it for now.
> +		 * The len will be populated once the whole
> +		 * buf is populated.
> +		 *
> +		 * The I2C bus driver's responsibility is to pass the
> +		 * data bytes to the backend driver; it does not
> +		 * forward the i2c slave address.
> +		 * Since the first byte in the IPMB message is the
> +		 * address of the responder, it is the responsibility
> +		 * of the IPMB driver to format the message properly.
> +		 * So this driver prepends the address of the responder
> +		 * to the received i2c data before the request message
> +		 * is handled in userland.
> +		 */
> +		buf[++ipmb_dev_p->msg_idx] = (u8)(client->addr << 1);
> +		break;
> +
> +	case I2C_SLAVE_WRITE_RECEIVED:
> +		if (ipmb_dev_p->msg_idx >= sizeof(struct ipmb_msg))
> +			break;
> +
> +		buf[++ipmb_dev_p->msg_idx] = *val;
> +		break;
> +
> +	case I2C_SLAVE_STOP:
> +		ipmb_dev_p->request.len = ipmb_dev_p->msg_idx;
> +
> +		if (is_ipmb_request(ipmb_dev_p, (u8)(client->addr << 1)))
> +			handle_request(ipmb_dev_p);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +	spin_unlock(&ipmb_dev_p->lock);
> +
> +	return 0;
> +}
> +
> +static int ipmb_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct ipmb_dev *ipmb_dev_p;
> +	int ret;
> +
> +	ipmb_dev_p = devm_kzalloc(&client->dev, sizeof(*ipmb_dev_p),
> +					GFP_KERNEL);
> +	if (!ipmb_dev_p)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&ipmb_dev_p->lock);
> +	init_waitqueue_head(&ipmb_dev_p->wait_queue);
> +	atomic_set(&ipmb_dev_p->request_queue_len, 0);
> +	INIT_LIST_HEAD(&ipmb_dev_p->request_queue);
> +
> +	mutex_init(&ipmb_dev_p->file_mutex);
> +
> +	ipmb_dev_p->miscdev.minor = MISC_DYNAMIC_MINOR;
> +	ipmb_dev_p->miscdev.name = DEVICE_NAME;
> +	ipmb_dev_p->miscdev.fops = &ipmb_fops;
> +	ipmb_dev_p->miscdev.parent = &client->dev;
> +	ret = misc_register(&ipmb_dev_p->miscdev);
> +	if (ret)
> +		return ret;
> +
> +	ipmb_dev_p->client = client;
> +	i2c_set_clientdata(client, ipmb_dev_p);
> +	ret = i2c_slave_register(client, ipmb_slave_cb);
> +	if (ret) {
> +		misc_deregister(&ipmb_dev_p->miscdev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ipmb_remove(struct i2c_client *client)
> +{
> +	struct ipmb_dev *ipmb_dev_p = i2c_get_clientdata(client);
> +
> +	if (!ipmb_dev_p)
> +		return 0;
> +
> +	i2c_slave_unregister(client);
> +	misc_deregister(&ipmb_dev_p->miscdev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ipmb_id[] = {
> +	{"ipmb-dev", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, ipmb_id);
> +
> +static struct i2c_driver ipmb_driver = {
> +	.driver = {
> +		.name = "ipmb-dev",
> +	},
> +	.probe = ipmb_probe,
> +	.remove = ipmb_remove,
> +	.id_table = ipmb_id,
> +};
> +module_i2c_driver(ipmb_driver);
> +
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_DESCRIPTION("Mellanox BlueField IPMB driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.1.2
> 
