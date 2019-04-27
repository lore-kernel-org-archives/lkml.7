Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD900C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6492146E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfD0P6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:58:13 -0400
Received: from sauhun.de ([88.99.104.3]:60900 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfD0P6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:58:13 -0400
Received: from localhost (p54B33C06.dip0.t-ipconnect.de [84.179.60.6])
        by pokefinder.org (Postfix) with ESMTPSA id 245252C3637;
        Sat, 27 Apr 2019 17:58:08 +0200 (CEST)
Date:   Sat, 27 Apr 2019 17:58:07 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     minyard@acm.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>
Subject: Re: [PATCH v2 1/1] Add support for IPMB driver
Message-ID: <20190427155807.GA9529@kunai>
References: <cover.1555529640.git.Asmaa@mellanox.com>
 <8fae547729559b27e92baf69d289cdae9fe3396f.1555529640.git.Asmaa@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <8fae547729559b27e92baf69d289cdae9fe3396f.1555529640.git.Asmaa@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for your contribution!

On Wed, Apr 17, 2019 at 03:59:19PM -0400, Asmaa Mnebhi wrote:
> Support receiving IPMB requests on a Satellite MC from the BMC.
> Once a response is ready, this driver will send back a response
> to the BMC via the IPMB channel.

I know nothing about IPMB, so I can only give general comments about I2C
and kernel coding. Alone from that, there were some things in need of a
change. So, I'd think another closer review from someone else about
IPMI, misc device usage, list handling is desirable as well. The IPMI
part is nicely documented. I am adding two Mellanox guys to CC which
have done some I2C things in the past. Hopefully they can help checking,
too.

>=20
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
> ---
>  drivers/char/ipmi/Kconfig        |   8 +
>  drivers/char/ipmi/Makefile       |   1 +
>  drivers/char/ipmi/ipmb_dev_int.c | 407 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 416 insertions(+)
>  create mode 100644 drivers/char/ipmi/ipmb_dev_int.c
>=20
> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> index 94719fc..784bc84 100644
> --- a/drivers/char/ipmi/Kconfig
> +++ b/drivers/char/ipmi/Kconfig
> @@ -74,6 +74,14 @@ config IPMI_SSIF
>  	 have a driver that must be accessed over an I2C bus instead of a
>  	 standard interface.  This module requires I2C support.
> =20
> +config IPMB_DEVICE_INTERFACE
> +       tristate 'IPMB Interface handler'
> +       select I2C
> +       help
> +         Provides a driver for a device (Satellite MC) to
> +         receive requests and send responses back to the BMC via
> +         the IPMB interface. This module requires I2C support.

Even more, it requires I2C_SLAVE support. And you don't select something
massive like I2C, you depend on it.

> +
>  config IPMI_POWERNV
>         depends on PPC_POWERNV
>         tristate 'POWERNV (OPAL firmware) IPMI interface'
> diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
> index 3f06b20..0822adc 100644
> --- a/drivers/char/ipmi/Makefile
> +++ b/drivers/char/ipmi/Makefile
> @@ -26,3 +26,4 @@ obj-$(CONFIG_IPMI_KCS_BMC) +=3D kcs_bmc.o
>  obj-$(CONFIG_ASPEED_BT_IPMI_BMC) +=3D bt-bmc.o
>  obj-$(CONFIG_ASPEED_KCS_IPMI_BMC) +=3D kcs_bmc_aspeed.o
>  obj-$(CONFIG_NPCM7XX_KCS_IPMI_BMC) +=3D kcs_bmc_npcm7xx.o
> +obj-$(CONFIG_IPMB_DEVICE_INTERFACE) +=3D ipmb_dev_int.o
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_de=
v_int.c
> new file mode 100644
> index 0000000..638324d
> --- /dev/null
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -0,0 +1,407 @@
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

Why the boilerplate? You have an SPDX header.

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

Please use pr_fmt for this.

> +
> +#define	DEVICE_NAME	"ipmb-dev"

Only used once, so I think we can use it directly.

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

Why the tab and not one space after #define?

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

This double negation is confusing. I'd think the code becomes much
easier to read if you'd name it 'blocking'.

> +
> +try_again:
> +		res =3D wait_event_interruptible(ipmb_dev_p->wait_queue,
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

We have a limited use of 'goto' in the kernel, but this is over the top
IMO. It is hard to follow the flow of code.

> +	}
> +
> +	if (list_empty(&ipmb_dev_p->request_queue)) {
> +		pr_err(PFX "request_queue is empty\n");
> +		return -EIO;
> +	}
> +
> +	queue_elem =3D list_first_entry(&ipmb_dev_p->request_queue,
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
> +static ssize_t ipmb_read(struct file *file, char __user *buf, size_t cou=
nt,
> +			loff_t *ppos)
> +{
> +	struct ipmb_dev *ipmb_dev_p =3D to_ipmb_dev(file);
> +	struct ipmb_msg msg;
> +	ssize_t ret;
> +
> +	memset(&msg, 0, sizeof(msg));
> +
> +	mutex_lock(&ipmb_dev_p->file_mutex);
> +	ret =3D receive_ipmb_request(ipmb_dev_p, file->f_flags & O_NONBLOCK,
> +				&msg);
> +	if (ret < 0)
> +		goto out;
> +	count =3D min_t(size_t, count, ipmb_msg_len(&msg));
> +	if (copy_to_user(buf, &msg, count)) {
> +		ret =3D -EFAULT;
> +		goto out;
> +	}
> +
> +out:
> +	mutex_unlock(&ipmb_dev_p->file_mutex);
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return count;

	return ret < 0 ? ret : count

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
> +		length =3D I2C_SMBUS_BLOCK_MAX;
> +
> +	data.block[0] =3D length;
> +	memcpy(&data.block[1], msg, length);
> +
> +	ret =3D i2c_smbus_xfer(client->adapter, requester_i2c_addr,
> +				client->flags,
> +				I2C_SMBUS_WRITE, command,
> +				I2C_SMBUS_BLOCK_DATA, &data);

Why can't you use i2c_smbus_write_block_data() here?

> +
> +	return ret;
> +}
> +
> +static ssize_t ipmb_write(struct file *file, const char __user *buf,
> +			size_t count, loff_t *ppos)
> +{
> +	struct ipmb_dev *ipmb_dev_p =3D to_ipmb_dev(file);
> +	u8 msg[MAX_MSG_LEN];
> +	ssize_t ret;
> +	u8 rq_sa, netf_rq_lun, msg_len;
> +
> +	if (count > sizeof(msg))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&msg, buf, count) || count < msg[0])
> +		return -EFAULT;
> +
> +	rq_sa =3D (u16)(msg[RQ_SA_8BIT_IDX] >> 1);
> +	netf_rq_lun =3D msg[NETFN_LUN_IDX];
> +	/*
> +	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
> +	 * i2c_smbus_write_block_data_local
> +	 */
> +	msg_len =3D msg[IPMB_MSG_LEN_IDX] - 2;
> +
> +	mutex_lock(&ipmb_dev_p->file_mutex);
> +	ret =3D i2c_smbus_write_block_data_local(ipmb_dev_p->client,
> +					netf_rq_lun, msg_len, rq_sa, msg + 3);
> +	mutex_unlock(&ipmb_dev_p->file_mutex);
> +
> +	if (ret)
> +		return ret;
> +	else
> +		return count;

	return ret ?: count

> +}
> +
> +static unsigned int ipmb_poll(struct file *file, poll_table *wait)
> +{
> +	struct ipmb_dev *ipmb_dev_p =3D to_ipmb_dev(file);
> +	unsigned int mask =3D 0;
> +
> +	mutex_lock(&ipmb_dev_p->file_mutex);
> +	poll_wait(file, &ipmb_dev_p->wait_queue, wait);
> +
> +	if (atomic_read(&ipmb_dev_p->request_queue_len))
> +		mask |=3D POLLIN;
> +	mask |=3D POLLOUT;
> +	mutex_unlock(&ipmb_dev_p->file_mutex);
> +	return mask;
> +}
> +
> +static const struct file_operations ipmb_fops =3D {
> +	.owner	=3D THIS_MODULE,
> +	.read	=3D ipmb_read,
> +	.write	=3D ipmb_write,
> +	.poll	=3D ipmb_poll,
> +};
> +
> +/* Called with ipmb_dev->lock held. */
> +static void handle_request(struct ipmb_dev *ipmb_dev_p)

The namespace for the following two functions is too generic.

> +{
> +	struct ipmb_request_elem *queue_elem;
> +
> +	if (atomic_read(&ipmb_dev_p->request_queue_len) >=3D
> +			REQUEST_QUEUE_MAX_LEN)
> +		return;
> +
> +	queue_elem =3D kmalloc(sizeof(*queue_elem), GFP_KERNEL);
> +	if (!queue_elem)
> +		return;
> +
> +	memcpy(&queue_elem->request, &ipmb_dev_p->request,
> +		sizeof(struct ipmb_msg));
> +	list_add(&queue_elem->list, &ipmb_dev_p->request_queue);
> +	atomic_inc(&ipmb_dev_p->request_queue_len);
> +	wake_up_all(&ipmb_dev_p->wait_queue);
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
> +	if (ipmb_dev_p->msg_idx >=3D IPMB_REQUEST_LEN_MIN) {
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
> +	struct ipmb_dev *ipmb_dev_p =3D i2c_get_clientdata(client);
> +	u8 *buf =3D (u8 *)&ipmb_dev_p->request;
> +
> +	spin_lock(&ipmb_dev_p->lock);
> +	switch (event) {
> +	case I2C_SLAVE_WRITE_REQUESTED:
> +		memset(&ipmb_dev_p->request, 0, sizeof(ipmb_dev_p->request));
> +		ipmb_dev_p->msg_idx =3D 0;
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
> +		buf[++ipmb_dev_p->msg_idx] =3D (u8)(client->addr << 1);
> +		break;
> +
> +	case I2C_SLAVE_WRITE_RECEIVED:
> +		if (ipmb_dev_p->msg_idx >=3D sizeof(struct ipmb_msg))
> +			break;
> +
> +		buf[++ipmb_dev_p->msg_idx] =3D *val;
> +		break;
> +
> +	case I2C_SLAVE_STOP:
> +		ipmb_dev_p->request.len =3D ipmb_dev_p->msg_idx;
> +
> +		if (is_ipmb_request(ipmb_dev_p, (u8)(client->addr << 1)))
> +			handle_request(ipmb_dev_p);
> +		break;
> +
> +	default:
> +		break;

Can't we leave the 'default' or will the compiler complain?

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
> +	ipmb_dev_p =3D devm_kzalloc(&client->dev, sizeof(*ipmb_dev_p),
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
> +	ipmb_dev_p->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> +	ipmb_dev_p->miscdev.name =3D DEVICE_NAME;
> +	ipmb_dev_p->miscdev.fops =3D &ipmb_fops;
> +	ipmb_dev_p->miscdev.parent =3D &client->dev;
> +	ret =3D misc_register(&ipmb_dev_p->miscdev);
> +	if (ret)
> +		return ret;

I really don't know enough about IPMB to judge if the design of having
one i2c-dev interface and another ipmb-dev interface is a good solution.

> +
> +	ipmb_dev_p->client =3D client;
> +	i2c_set_clientdata(client, ipmb_dev_p);
> +	ret =3D i2c_slave_register(client, ipmb_slave_cb);
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
> +	struct ipmb_dev *ipmb_dev_p =3D i2c_get_clientdata(client);
> +
> +	i2c_slave_unregister(client);
> +	misc_deregister(&ipmb_dev_p->miscdev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ipmb_id[] =3D {
> +	{"ipmb-dev", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, ipmb_id);
> +
> +static struct i2c_driver ipmb_driver =3D {
> +	.driver =3D {
> +		.name =3D "ipmb-dev",
> +	},
> +	.probe =3D ipmb_probe,
> +	.remove =3D ipmb_remove,
> +	.id_table =3D ipmb_id,
> +};
> +module_i2c_driver(ipmb_driver);
> +
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_DESCRIPTION("Mellanox BlueField IPMB driver");
> +MODULE_LICENSE("GPL");

Header says GPL v2!

I'd think this is enough from my side for now? Some questions to be
discussed and it would be really good if someone else could have another
look. Some parts were nice (IPMI docs), some a bit sloppy (GPL header
mismatches), so I'd think this needs a few more rounds. This is not a
complaint, though. I am happy someone is using the i2c slave interface
with the upstream kernel. Yet, it is an interface exposed to userspace,
so we need to be extra careful. Oh, and we need documentation for this
ABI.

Regards,

   Wolfram


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzEfAsACgkQFA3kzBSg
KbYoSA//TnIQVvVaSI1Uoj033fBw2GiV7aVZww5bj4CMb8n2JIy+JG83nN0J+SnZ
pdz5p0PCrevUqjp3cY0zOi3RrbgFeGHKebZtiid4dpKEmQqI8DqBbWH0LAtYuIXA
Kkie4mBPN54YD49S+ngjnNQrrl2v5mM0qliJw5oSHy2KfnELTsNXZPnJjHwaJeSq
s6CjzgMFn9jUxzO2qajXSmWuFpvwnLY2P7R4OMDePJRsQhBSfLGG2Fwlqf56wgXV
UiR+qRbRLzIdIlQ6g9+im1TBSU8uMAkes+PDIh3cLccm1ndWPsOhaIchxOIUVRfV
LP9Tkh/IzOqJP/dUvwjOtlPLPuDlhNN+tgMIGO9BtBskVtSLjiCTvy5K1vAC3anM
jg+jLXscmPJLeBAYWZ0UHxIH0/1TuDuxZ+R8KGUB5s1r0VB1nu9sfIEuuJxjeLI4
qJbiyRF6xyJOeuX2waQPaDqKbIL57DhxwbbCuuD7GdPVx7NJQPgYZZH7k0WkN+gN
XzgMmehkZOWf4U+TR0OvZDBSlNnDIXGoxjeGIGzMxQAcYQQFj2dXiDq31lMeIr69
Ys0NclY1Xl9dt+nfx1raiSH1rFiaw8N3JtFke3WaDYvwC13cAJLnJcDD8AgxkajF
LdQ56QllnznXsx23JFlkbjjHdYQH5KTnNlVCxqmi9fyVJ6WCTn8=
=0n/G
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
