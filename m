Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112C7C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EDD222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="X5a3bAm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfDSSUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:20:00 -0400
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:42979
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727330AbfDSST5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C96JGnPZd7FGCHQ8YlkDxYyQPWawk9/4O4uw8ECQxuk=;
 b=X5a3bAm+b05xslzf14kDOfzIq0qgqnJ6lKp3l9NcGmotTVPdx4Oe4ygUVRjH70fq/8W4ygyUf3x+nUoXHwgpARPC6Wtn75aow4UzFQltjJJzT5i+aEAAt8Jf+2jgPtDYGkIG2KF59tQkj5mhcSOev750Y58yHnvfqCDCI5ij7qw=
Received: from HE1PR0501MB2652.eurprd05.prod.outlook.com (10.172.130.146) by
 HE1PR0501MB2586.eurprd05.prod.outlook.com (10.168.123.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 19 Apr 2019 14:05:00 +0000
Received: from HE1PR0501MB2652.eurprd05.prod.outlook.com
 ([fe80::f10b:595a:1abd:9027]) by HE1PR0501MB2652.eurprd05.prod.outlook.com
 ([fe80::f10b:595a:1abd:9027%5]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 14:05:00 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     "minyard@acm.org" <minyard@acm.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] Add support for IPMB driver
Thread-Topic: [PATCH v1 1/1] Add support for IPMB driver
Thread-Index: AQHU8XsFQoKEXn/pqUOSi77g2OWpSaY+/HQAgASSLrA=
Date:   Fri, 19 Apr 2019 14:05:00 +0000
Message-ID: <HE1PR0501MB265283F792C4CB5D3284511FDA270@HE1PR0501MB2652.eurprd05.prod.outlook.com>
References: <cover.1555105745.git.Asmaa@mellanox.com>
 <7664a7fca1ebe0a2e44e37be96827df4602c7cb6.1555105745.git.Asmaa@mellanox.com>
 <20190416161612.GK4121@minyard.net>
In-Reply-To: <20190416161612.GK4121@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41d3865e-158d-4b9e-803b-08d6c4d0031b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR0501MB2586;
x-ms-traffictypediagnostic: HE1PR0501MB2586:
x-microsoft-antispam-prvs: <HE1PR0501MB25868825FABF3F5E9DECDB74DA270@HE1PR0501MB2586.eurprd05.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(13464003)(189003)(199004)(8936002)(6116002)(3846002)(102836004)(66946007)(73956011)(86362001)(486006)(5660300002)(81156014)(8676002)(2906002)(186003)(30864003)(72206003)(66066001)(33656002)(64756008)(76116006)(6246003)(25786009)(66446008)(11346002)(71190400001)(71200400001)(446003)(99286004)(476003)(2501003)(4326008)(52536014)(478600001)(55016002)(9686003)(53936002)(97736004)(74316002)(68736007)(80792005)(14444005)(26005)(7696005)(256004)(7736002)(6506007)(14454004)(76176011)(54906003)(53946003)(6436002)(81166006)(53546011)(305945005)(110136005)(229853002)(316002)(66476007)(66556008)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0501MB2586;H:HE1PR0501MB2652.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KIul6wVp2MojVUE1hPUMWXKUpynwULMJ7zYcp4Qd3Urnvw1zXiuIvOwJVxUQTfu6S72cL/tGxDx/EWBuvkFXf8m9db07TbaSjK9tkQAAa7wM/nYM5D5P4zBoV47O7iExJ9TasFAOK/Yq5pw73MjJ5K0NO4xUAI+9RmD48pAz4Ky0cXmaCwNDEVVEpJu8c+IkYDhRlx4bVNwpu+QiHJPGKAafDQQK2qYSafyh2xBXtZFFqNuJE4RzYKeAiHoiQaGleR6zzGDrG8+1uAzyTCmxOoNLBeVn5X2WTLLGW53qyrihR849K9kkqgY8ypQD/knFTCrhFAho32N6OM5v4EPB9ebhLUYFy7bqY3tVy0mD+zP75aSkDJUgI6WbBLcP2PyH3n04T1UT5jS3pd8X6GA2cB1+R7GPdHMSyhiAfJx9lCk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d3865e-158d-4b9e-803b-08d6c4d0031b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 14:05:00.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2586
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
Sent: Tuesday, April 16, 2019 12:16 PM
To: Asmaa Mnebhi <Asmaa@mellanox.com>
Cc: linux-kernel@vger.kernel.org; linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Add support for IPMB driver

On Fri, Apr 12, 2019 at 05:59:16PM -0400, Asmaa Mnebhi wrote:
> Support receiving IPMB requests on a Satellite MC from the BMC.
> Once a response is ready, this driver will send back a response to the=20
> BMC via the IPMB channel.

I haven't done a detailed analysis of this, but from a cursory look it look=
s structurally good.  I made a few small comments inline.

But there is really very little here that is IPMB-specific.
You could push the few IPMB-specific formatting things up to userland, I th=
ink.

I am wondering if you could make this into a generic I2C slave interface.  =
I'm adding the I2C mailing list to the CC and for their review.

For the I2C mailing list...

IPMB is a protocol that lets IPMI devices talk between themselves, so it is=
 master/slave on all device on the IPMB.  It's basically designed so that m=
odular parts of the system (like a power supply) can have their own IPMI ma=
nagement controller that handles things for that device, and a management s=
ystem can discover these and use them through the main IPMI management cont=
roller.
It's used like a normal packet-oriented bus, with only writes, no reads.

It seems to me that you could create a slave-specific I2C device that only =
received messages and took responses to those messages.  You could use the =
normal I2C dev interface to to the sends and open a separate I2C slave dev =
interface to do the receives.

-corey

>=20
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
> ---
>  drivers/char/ipmi/Kconfig        |   8 +
>  drivers/char/ipmi/Makefile       |   1 +
>  drivers/char/ipmi/ipmb_dev_int.c | 418=20
> +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 427 insertions(+)
>  create mode 100644 drivers/char/ipmi/ipmb_dev_int.c
>=20
> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig=20
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
> +
>  config IPMI_POWERNV
>         depends on PPC_POWERNV
>         tristate 'POWERNV (OPAL firmware) IPMI interface'
> diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile=20
> index 3f06b20..0822adc 100644
> --- a/drivers/char/ipmi/Makefile
> +++ b/drivers/char/ipmi/Makefile
> @@ -26,3 +26,4 @@ obj-$(CONFIG_IPMI_KCS_BMC) +=3D kcs_bmc.o
>  obj-$(CONFIG_ASPEED_BT_IPMI_BMC) +=3D bt-bmc.o
>  obj-$(CONFIG_ASPEED_KCS_IPMI_BMC) +=3D kcs_bmc_aspeed.o
>  obj-$(CONFIG_NPCM7XX_KCS_IPMI_BMC) +=3D kcs_bmc_npcm7xx.o
> +obj-$(CONFIG_IPMB_DEVICE_INTERFACE) +=3D ipmb_dev_int.o
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c=20
> b/drivers/char/ipmi/ipmb_dev_int.c
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
> +	/* checksum2 is included in payload */ } __packed;
> +
> +static u32 ipmb_msg_len(struct ipmb_msg *ipmb_msg) {
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
> +static inline struct ipmb_dev *to_ipmb_dev(struct file *file) {
> +	return container_of(file->private_data, struct ipmb_dev, miscdev); }
> +
> +static ssize_t ipmb_read(struct file *file, char __user *buf, size_t cou=
nt,
> +			loff_t *ppos)
> +{
> +	struct ipmb_dev *ipmb_dev_p =3D to_ipmb_dev(file);
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
> +}
> +
> +static unsigned int ipmb_poll(struct file *file, poll_table *wait) {
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
> +/* Called with ipmb_dev->lock held. */ static int=20
> +handle_request(struct ipmb_dev *ipmb_dev_p)

The return value from handle_request is ignored below, do you need to retur=
n it?

> +{
> +	struct ipmb_request_elem *queue_elem;
> +
> +	if (atomic_read(&ipmb_dev_p->request_queue_len) >=3D
> +			REQUEST_QUEUE_MAX_LEN)
> +		return -EFAULT;

EFAULT is not what you want here.  I'm not sure exactly what to do here, bu=
t you should probably just drop the data on the floor, maybe have a counter=
 to count dropped packets.

> +
> +	queue_elem =3D kmalloc(sizeof(*queue_elem), GFP_KERNEL);
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
> +static u8 verify_checksum1(struct ipmb_dev *ipmb_dev_p, u8 rs_sa) {
> +	return (rs_sa + ipmb_dev_p->request.netfn_rs_lun +
> +		ipmb_dev_p->request.checksum1);
> +}
> +
> +static bool is_ipmb_request(struct ipmb_dev *ipmb_dev_p, u8 rs_sa) {
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
> +			enum i2c_slave_event event, u8 *val) {
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
> +static int ipmb_remove(struct i2c_client *client) {
> +	struct ipmb_dev *ipmb_dev_p =3D i2c_get_clientdata(client);
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
> +MODULE_AUTHOR("Mellanox Technologies"); MODULE_DESCRIPTION("Mellanox=20
> +BlueField IPMB driver"); MODULE_LICENSE("GPL");
> --
> 2.1.2
>=20
