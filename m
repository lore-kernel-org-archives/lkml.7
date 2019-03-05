Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192DCC10F09
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C583F20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="kSXwZRvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfCEXvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:51:02 -0500
Received: from mail-eopbgr750115.outbound.protection.outlook.com ([40.107.75.115]:58558
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728332AbfCEXvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUoO0BK6O9CqEKKPthFbC+eZCVBVzFY3CU1QqqX9Zys=;
 b=kSXwZRvwlanWyeuAWzeipnsHfBBOzRDDEKpRXdgCW8hJsqhsA/v6r/hiDi9YdQQraMAzmJTAMbkLOkNNqje3NkJ7vqbCBvRJWWmX+edd4sG0ZCtXwhFPti13c+ddpUY5jdDDEFF1iagZswQFJknp6dcgwHmAekiBoBc1NrizQRk=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1759.namprd22.prod.outlook.com (10.164.206.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Tue, 5 Mar 2019 23:50:52 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 23:50:52 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yifeng Li <tomli@tomli.me>
CC:     Lee Jones <lee.jones@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] mfd: yeeloong_kb3310b: support KB3310B EC for
 Lemote Yeeloong laptops.
Thread-Topic: [PATCH v2 1/7] mfd: yeeloong_kb3310b: support KB3310B EC for
 Lemote Yeeloong laptops.
Thread-Index: AQHU0tmuUUdIVkUWJ022Bf3iItn+0aX9ttIA
Date:   Tue, 5 Mar 2019 23:50:51 +0000
Message-ID: <20190305235050.mdouj2gnxwmilhoy@pburton-laptop>
References: <20190304222848.25037-1-tomli@tomli.me>
 <20190304222848.25037-2-tomli@tomli.me>
In-Reply-To: <20190304222848.25037-2-tomli@tomli.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0065.namprd08.prod.outlook.com
 (2603:10b6:a03:117::42) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f609b0f2-c4c1-4245-e75a-08d6a1c5663a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1759;
x-ms-traffictypediagnostic: MWHPR2201MB1759:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1759;23:mcqa1GDjo4wnJyqW8Us8aOvgNWtnTP9egxvYvsj?=
 =?us-ascii?Q?mC+rjQMRB6s9SQReJksk85g/H+AyPMAiLXPEEuZ6vNdomlseoHZf6dXFhLqE?=
 =?us-ascii?Q?9UvdnK5B9yQ0fSWUcWTzP3yjkb3v1o2UbJb1Yu0PLjFUI2tLNljB6JM3t0rV?=
 =?us-ascii?Q?22OITLpbdUFK78OaqO63okeyKXyRXnQRRK5fHxewJ7zqi2MxJcvn/Nb1+ZfE?=
 =?us-ascii?Q?AFP8tbQrWu9JgRr1fTo6rcs87PLcYLvKHn3Yy6205BBpyTQXhEZPkTy3Pa8Y?=
 =?us-ascii?Q?mtIpfqDBM0cYW24u2y2vhu+AdoYHg8xOsO9Cw+cGhDTnhtqxFBlUezBf7k0y?=
 =?us-ascii?Q?Uj/U8MAkMmQjxhMpfzqAXJNza7BGZN6aYYVfCaO1qqxjqSLT8k3NYmCgksK4?=
 =?us-ascii?Q?qSuNXN+jwWA/IFDbjtPiwLxaD28j+D7FyxjOs/wakdQyE166UKZHQOzco1XF?=
 =?us-ascii?Q?igOk4Ba1Ddl7Tz7fg0T/wuidXVD72UjWxpza4DIWgKjYlv/i6KA2uWQhc/3I?=
 =?us-ascii?Q?K4t0FpT1/+wTPHHVTn0I7fppr/uOfnFy029VAfdrXtQvCUu9hMCjonPfczJU?=
 =?us-ascii?Q?nfcwNbpX+jqFoHHIVoJfCsYaJenxnKCXfNwo5K2OgayU26X1pSfHhmejJAN/?=
 =?us-ascii?Q?VzKNxLMUrPtyftJhcp3mZzNsGCYhS/uU1UOcNwoJwzC9Ir8uSYONqMCXmLeY?=
 =?us-ascii?Q?VgBHATPRrnLug/gRdZm43/oH3qfUuqLB/KIC9JF/HVkhrjVd1oHMslO4tQPX?=
 =?us-ascii?Q?BK8itAzkslVQDipn0Zqde85o1qLDqK+IuH+Vmq2yEfryTP+qeZTH26SdQ5FE?=
 =?us-ascii?Q?HQvuDFvIDUHFy8BmJeTcWuWAEm+Tkky8unYKbqvuEpIFM0zRq0PBRru3LB08?=
 =?us-ascii?Q?tY1TaMWY9r2ZUmChpGQK3zARhgg8vXwUrbxEymWsR6q7r5kARmc5MF0bOdI0?=
 =?us-ascii?Q?2Cu32DZe2mZ0nTS7OTG8zgBOz31DkdPzOaJWBcY7k6bLDHPnO/NhmGPLYnMv?=
 =?us-ascii?Q?dKgtDAxgfJVGIZFZdSGDbrho9nQT33FM/2ADWGS32XZ4R9hrdbIeXpaX7Z30?=
 =?us-ascii?Q?NZ4ui7xwze++Cl7xrMeMjr9YkMK6iBCQ+chiWor2+8dQj+9StHQlQuN22oTJ?=
 =?us-ascii?Q?sOWi1TePR8zPlyD5TLuRPTdOa09eWCq0DCySp+tfuiQ5o4iHdCb/GfWz+K1n?=
 =?us-ascii?Q?ySn9Yn5cvOpN5H3enksSX/BepeqaP+kJQRDDncIzRIXk1icvZeAVNkM8cYL8?=
 =?us-ascii?Q?xeXZDe7ORnb6nrNGMJp7cuXkRw1SRZpJDLysaUdpKsGtM0Vz7YcX/wig064m?=
 =?us-ascii?Q?zJZhH6Z0k8+Ph5wQ/n7CzxaSPQS3KutHb13k0gHNeznX4q64Rrd9ChTF08Ua?=
 =?us-ascii?Q?XsqRcZw=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB17593BBBF2A8454FF27A905DC1720@MWHPR2201MB1759.namprd22.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(376002)(366004)(396003)(346002)(39850400004)(189003)(199004)(99286004)(6116002)(105586002)(102836004)(386003)(4326008)(3846002)(106356001)(6506007)(6916009)(478600001)(52116002)(68736007)(81156014)(25786009)(8676002)(6246003)(76176011)(81166006)(53936002)(53946003)(6436002)(6512007)(9686003)(6486002)(7736002)(305945005)(229853002)(316002)(54906003)(58126008)(1076003)(2906002)(8936002)(476003)(97736004)(42882007)(256004)(14444005)(71200400001)(71190400001)(33716001)(66066001)(11346002)(14454004)(26005)(30864003)(446003)(44832011)(5660300002)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1759;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1RJhF7QDOJBUKcCoIhY+adtiFIe8UthvWTjIyhjxTenTLUyTSJ/Xwx99MVxw4SVi6cfzYIh2tCzMy6If7nDXmOJvN7m20kqWTP2x+BnmAgAvfVZF0+wz09GCW4IqRl5+DceZiyUh2E357fA1YzdfMNVi0keeTdv6zrTvHM9SJs/qQ1KWCLykKTrDHQlcOtrMTknpadDq99fBRqMj/Nr0Lt/WL8XI30esnvyzg2YCIMbD/8ArxcW2GwnQz0fX/0ZVPvWQBqQUbk/tf4A26+z+QMp7He/bS65diQYFYHC44sQtfrmb4OO9I6xKYzCDG6dKaM07koIk0etul2Xgu6QOjubXxR6ZPrOZU1TQCUkgGsr8VLMLAIwoTv23fbjV7uYeee7vRPYpKcndas7eW2Zi3ssbkU8UAJM81zW6u9L8wKA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95D532638B6CB24A896F55E67011178C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f609b0f2-c4c1-4245-e75a-08d6a1c5663a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 23:50:51.9422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Overall I think this is much better than the older out of tree platform
driver - thanks for cleaning it up.

One general comment - it would be good to run the patches through
./scripts/checkpatch.pl & fix up any warnings it gives unless you have a
good reason to disagree with them.

On Tue, Mar 05, 2019 at 06:28:42AM +0800, Yifeng Li wrote:
> Lemote Yeeloong is a laptop powered by Loongson 2F MIPS processor,
> primarily a demo platform for hobbyists and developers. It uses an
> ENE KB3310B Embedded Controller with customized firmware to implement
> hardware and power management.
>=20
> A monolithic platform driver code for those functionality has existed
> out-of-tree for many years. This commit creates a MFD driver for the EC
> chip on Yeeloong laptop to isolate EC-related code from core MIPS code,
> and serves as the foundation of various subdrivers.
>=20
> My original attempt was to create a regmap for subdrivers to access the
> EC, unfortunately, the board files in Linux/MIPS still needs to access
> the EC directly for power management. Unless we find a better home for
> those code, we simply export the EC-related functions.

I'm not sure I follow why the power management code prevents use of
regmap?

Are you talking about the wakeup_loongson() function? Perhaps it would
make sense for the suspend code to be part of one of the possible
subdrivers you mention. The lemote-2f seems to be the only system that
provides an implementation of wakeup_loongson() so perhaps a driver
could instead just register its own struct platform_suspend_ops & avoid
the need for code in arch/mips to care about the EC.

> diff --git a/drivers/mfd/yeeloong_kb3310b.c b/drivers/mfd/yeeloong_kb3310=
b.c
> new file mode 100644
> index 000000000000..64d353a83122
> --- /dev/null
> +++ b/drivers/mfd/yeeloong_kb3310b.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * MFD driver for ENE KB3310B embedded controller on Lemote Yeeloong lap=
tops
> + *
> + * Copyright (C) 2008 Lemote Inc.
> + * Author: liujl <liujl@lemote.com>, 2008-04-20
> + *
> + * Copyright (C) 2018 Yifeng Li
> + * Author: Yifeng Li <tomli@tomli.me>
> + *
> + * This is a MFD driver for the ENE KB3310B Embedded Controller for Lemo=
te
> + * Yeeloong laptops to provide utility functions to access the chip from
> + * subdrivers, and handle events and interrupts in board files. This is =
a
> + * special-purpose driver, and it's only used on Lemote Yeeloong laptops=
,
> + * and is a mandatory dependency.
> + *
> + * My original attempt was to create a regmap for subdrivers to access t=
he
> + * EC, unfortunately, the board files in Linux/MIPS still needs to acces=
s
> + * the EC directly for power management. Unless we find a better home fo=
r
> + * those code, we simply export the EC-related functions.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/core.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +
> +#include <linux/mfd/yeeloong_kb3310b.h>
> +
> +#define DRV_NAME "yeeloong_kb3310b: "

Defining pr_fmt() would be cleaner - you wouldn't need to manually
include DRV_NAME in your messages later.

> +
> +/***********************************************************************=
******
> + * Most drivers, such as battery or backlight drivers, uses the I/O port=
s to
> + * access the Index Registers to obtain hardware status and information =
from
> + * EC chip.
> + ***********************************************************************=
*****/

Nit: the lines of asterisks aren't part of the kernel's general comment
style & I think it would looks cleaner to remove them.

> +static struct kb3310b_chip *kb3310b_fwinfo;
> +
> +static const struct mfd_cell kb3310b_cells[] =3D {
> +	{
> +		.name =3D "yeeloong_sci"
> +	},
> +	{
> +		.name =3D "yeeloong_hwmon"
> +	},
> +	{
> +		.name =3D "yeeloong_battery"
> +	},
> +	{
> +		.name =3D "yeeloong_backlight"
> +	},
> +	{
> +		.name =3D "yeeloong_lcd"
> +	},
> +	{
> +		.name =3D "yeeloong_hotkey"
> +	},

Nit: I think it'd look cleaner if you remove the newlines within each
array entry, eg:

	{ .name =3D "yeeloong_sci" },
	{ .name =3D "yeelong_hwmon" },
	...

> +};
> +
> +static DEFINE_SPINLOCK(kb3310b_index_lock);
> +
> +u8 kb3310b_read(u16 reg)
> +{
> +	unsigned long flags;
> +	u8 val;
> +
> +	spin_lock_irqsave(&kb3310b_index_lock, flags);
> +
> +	outb((reg & 0xff00) >> 8, KB3310B_IO_PORT_HIGH);
> +	outb((reg & 0x00ff), KB3310B_IO_PORT_LOW);
> +	val =3D inb(KB3310B_IO_PORT_DATA);
> +
> +	spin_unlock_irqrestore(&kb3310b_index_lock, flags);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(kb3310b_read);
> +
> +void kb3310b_write(u16 reg, u8 val)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&kb3310b_index_lock, flags);
> +
> +	outb((reg & 0xff00) >> 8, KB3310B_IO_PORT_HIGH);
> +	outb((reg & 0x00ff), KB3310B_IO_PORT_LOW);
> +	outb(val, KB3310B_IO_PORT_DATA);
> +	inb(KB3310B_IO_PORT_DATA);  /* flush pending writes */
> +
> +	spin_unlock_irqrestore(&kb3310b_index_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(kb3310b_write);

If you do switch to using regmap then the above could be neatly
represented as a bus - see struct regmap_bus, and various users of it
throughout drivers/. regmap would even handle the locking for you.

> +
> +bool kb3310b_fw_earlier(char *version)
> +{
> +	return (strncasecmp(kb3310b_fwinfo->version,
> +				version, KB3310B_VERSION_LEN) < 0);
> +}
> +EXPORT_SYMBOL_GPL(kb3310b_fw_earlier);
> +
> +static int kb3310b_probe(struct platform_device *pdev)
> +{
> +	kb3310b_fwinfo =3D dev_get_platdata(&pdev->dev);
> +	pr_info(DRV_NAME "firmware version %s", kb3310b_fwinfo->version);
> +
> +	return devm_mfd_add_devices(&pdev->dev, -1, kb3310b_cells,
> +				    ARRAY_SIZE(kb3310b_cells), NULL, 0, NULL);
> +}
> +
> +static struct platform_driver kb3310b_driver =3D {
> +	.driver =3D {
> +		   .name =3D "yeeloong_kb3310b",
> +	},
> +	.probe =3D kb3310b_probe,
> +};
> +builtin_platform_driver(kb3310b_driver);
> +
> +/***********************************************************************=
******
> + * For interrupt handling and power management, the EC chip is also need=
ed to
> + * be queried from the board file at arch/mips/loongson64, through a sep=
arate
> + * command port.
> + ***********************************************************************=
******/

As before, I think it'd be cleaner without the lines of asterisks.
Probably without the empty line before the variable too.

> +
> +static DEFINE_SPINLOCK(kb3310b_command_lock);

Since this is only used in kb3310b_query_seq() could you just declare it
(still static) inside that function?

Thanks,
    Paul

> +
> +/*
> + * This function is used for EC command writes and corresponding status =
queries.
> + */
> +int kb3310b_query_seq(unsigned char cmd)
> +{
> +	int timeout;
> +	unsigned char status;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&kb3310b_command_lock, flags);
> +
> +	/* make chip goto reset mode */
> +	udelay(KB3310B_REG_UDELAY);
> +	outb(cmd, KB3310B_CMD_PORT);
> +	udelay(KB3310B_REG_UDELAY);
> +
> +	/* check if the command is received by EC */
> +	timeout =3D KB3310B_CMD_TIMEOUT;
> +	status =3D inb(KB3310B_STS_PORT);
> +	while (timeout-- && (status & (1 << 1))) {
> +		status =3D inb(KB3310B_STS_PORT);
> +		udelay(KB3310B_REG_UDELAY);
> +	}
> +
> +	spin_unlock_irqrestore(&kb3310b_command_lock, flags);
> +
> +	if (timeout <=3D 0) {
> +		pr_err(DRV_NAME
> +			"(%x/NA) failed to issue command %d, no response!\n",
> +			timeout, cmd);
> +		return -EINVAL;
> +	}
> +
> +	pr_info(DRV_NAME
> +		 "(%x/%x) issued command %d, status: 0x%x\n",
> +		 timeout, KB3310B_CMD_TIMEOUT - timeout,
> +		 cmd, status);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kb3310b_query_seq);
> +
> +/*
> + * Send query command to EC to get the proper event number.
> + */
> +int kb3310b_query_event_num(void)
> +{
> +	return kb3310b_query_seq(KB3310B_CMD_GET_EVENT_NUM);
> +}
> +EXPORT_SYMBOL_GPL(kb3310b_query_event_num);
> +
> +/*
> + * Get event number from EC.
> + *
> + * NOTE: This routine must follow the query_event_num function in the
> + * interrupt.
> + */
> +int kb3310b_get_event_num(void)
> +{
> +	int timeout =3D 100;
> +	unsigned char value;
> +	unsigned char status;
> +
> +	udelay(KB3310B_REG_UDELAY);
> +	status =3D inb(KB3310B_STS_PORT);
> +	udelay(KB3310B_REG_UDELAY);
> +	while (timeout-- && !(status & (1 << 0))) {
> +		status =3D inb(KB3310B_STS_PORT);
> +		udelay(KB3310B_REG_UDELAY);
> +	}
> +	if (timeout <=3D 0) {
> +		pr_info("%s: get event number timeout.\n", __func__);
> +		return -EINVAL;
> +	}
> +	value =3D inb(KB3310B_DAT_PORT);
> +	udelay(KB3310B_REG_UDELAY);
> +
> +	return value;
> +}
> +EXPORT_SYMBOL_GPL(kb3310b_get_event_num);
> diff --git a/include/linux/mfd/yeeloong_kb3310b.h b/include/linux/mfd/yee=
loong_kb3310b.h
> new file mode 100644
> index 000000000000..1f16ba2579bc
> --- /dev/null
> +++ b/include/linux/mfd/yeeloong_kb3310b.h
> @@ -0,0 +1,211 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/*
> + * MFD driver for ENE KB3310B embedded controller on Lemote Yeeloong lap=
tops
> + *
> + * Copyright (C) 2008 Lemote Inc.
> + * Author: liujl <liujl@lemote.com>, 2008-04-20
> + *
> + * Copyright (C) 2018 Yifeng Li
> + * Author: Yifeng Li <tomli@tomli.me>
> + */
> +
> +#ifndef __LINUX_MFD_YEELOONG_KB3310B_H
> +#define __LINUX_MFD_YEELOONG_KB3310B_H
> +
> +extern u8 kb3310b_read(u16 reg);
> +extern void kb3310b_write(u16 reg, u8 val);
> +extern bool kb3310b_fw_earlier(char *version);
> +extern int kb3310b_query_seq(unsigned char cmd);
> +extern int kb3310b_query_event_num(void);
> +extern int kb3310b_get_event_num(void);
> +
> +typedef int (*sci_handler) (int status);
> +
> +extern int yeeloong_sci_register_notify(struct notifier_block *nb);
> +extern int yeeloong_sci_unregister_notify(struct notifier_block *nb);
> +
> +#define KB3310B_VERSION_LEN 8
> +
> +struct kb3310b_chip {
> +	char version[KB3310B_VERSION_LEN];
> +};
> +
> +#define KB3310B_SCI_IRQ_NUM	0x0A
> +
> +/*
> + * The following registers are determined by the EC index configuration.
> + * 1, fill the PORT_HIGH as EC register high part.
> + * 2, fill the PORT_LOW as EC register low part.
> + * 3, fill the PORT_DATA as EC register write data or get the data from =
it.
> + */
> +#define KB3310B_IO_PORT_HIGH	0x0381
> +#define KB3310B_IO_PORT_LOW	0x0382
> +#define KB3310B_IO_PORT_DATA	0x0383
> +
> +/*
> + * EC delay time is 500us for register and status access
> + */
> +#define KB3310B_REG_UDELAY	500
> +#define KB3310B_CMD_TIMEOUT	0x1000
> +
> +/*
> + * EC access port for SCI communication
> + */
> +#define KB3310B_CMD_PORT		0x66
> +#define KB3310B_STS_PORT		0x66
> +#define KB3310B_DAT_PORT		0x62
> +#define KB3310B_CMD_INIT_IDLE_MODE	0xdd
> +#define KB3310B_CMD_EXIT_IDLE_MODE	0xdf
> +#define KB3310B_CMD_INIT_RESET_MODE	0xd8
> +#define KB3310B_CMD_REBOOT_SYSTEM	0x8c
> +#define KB3310B_CMD_GET_EVENT_NUM	0x84
> +#define KB3310B_CMD_PROGRAM_PIECE	0xda
> +
> +/* temperature & fan registers */
> +#define KB3310B_REG_TEMPERATURE_VALUE	0xF458
> +#define KB3310B_REG_FAN_AUTO_MAN_SWITCH 0xF459
> +#define KB3310B_BIT_FAN_AUTO		0
> +#define KB3310B_BIT_FAN_MANUAL		1
> +#define KB3310B_REG_FAN_CONTROL		0xF4D2
> +#define KB3310B_BIT_FAN_CONTROL_ON	(1 << 0)
> +#define KB3310B_BIT_FAN_CONTROL_OFF	(0 << 0)
> +#define KB3310B_REG_FAN_STATUS		0xF4DA
> +#define KB3310B_BIT_FAN_STATUS_ON	(1 << 0)
> +#define KB3310B_BIT_FAN_STATUS_OFF	(0 << 0)
> +#define KB3310B_REG_FAN_SPEED_HIGH	0xFE22
> +#define KB3310B_REG_FAN_SPEED_LOW	0xFE23
> +#define KB3310B_REG_FAN_SPEED_LEVEL	0xF4CC
> +
> +/* fan speed divider */
> +#define KB3310B_FAN_SPEED_DIVIDER	480000	/* (60*1000*1000/62.5/2)*/
> +
> +/* battery registers */
> +#define KB3310B_REG_BAT_DESIGN_CAP_HIGH		0xF77D
> +#define KB3310B_REG_BAT_DESIGN_CAP_LOW		0xF77E
> +#define KB3310B_REG_BAT_FULLCHG_CAP_HIGH	0xF780
> +#define KB3310B_REG_BAT_FULLCHG_CAP_LOW		0xF781
> +#define KB3310B_REG_BAT_DESIGN_VOL_HIGH		0xF782
> +#define KB3310B_REG_BAT_DESIGN_VOL_LOW		0xF783
> +#define KB3310B_REG_BAT_CURRENT_HIGH		0xF784
> +#define KB3310B_REG_BAT_CURRENT_LOW		0xF785
> +#define KB3310B_REG_BAT_VOLTAGE_HIGH		0xF786
> +#define KB3310B_REG_BAT_VOLTAGE_LOW		0xF787
> +#define KB3310B_REG_BAT_TEMPERATURE_HIGH	0xF788
> +#define KB3310B_REG_BAT_TEMPERATURE_LOW		0xF789
> +#define KB3310B_REG_BAT_RELATIVE_CAP_HIGH	0xF492
> +#define KB3310B_REG_BAT_RELATIVE_CAP_LOW	0xF493
> +#define KB3310B_REG_BAT_VENDOR			0xF4C4
> +#define KB3310B_FLAG_BAT_VENDOR_SANYO		0x01
> +#define KB3310B_FLAG_BAT_VENDOR_SIMPLO		0x02
> +#define KB3310B_REG_BAT_CELL_COUNT		0xF4C6
> +#define KB3310B_FLAG_BAT_CELL_3S1P		0x03
> +#define KB3310B_FLAG_BAT_CELL_3S2P		0x06
> +#define KB3310B_REG_BAT_CHARGE			0xF4A2
> +#define KB3310B_FLAG_BAT_CHARGE_DISCHARGE	0x01
> +#define KB3310B_FLAG_BAT_CHARGE_CHARGE		0x02
> +#define KB3310B_FLAG_BAT_CHARGE_ACPOWER		0x00
> +#define KB3310B_REG_BAT_STATUS			0xF4B0
> +#define KB3310B_BIT_BAT_STATUS_LOW		(1 << 5)
> +#define KB3310B_BIT_BAT_STATUS_DESTROY		(1 << 2)
> +#define KB3310B_BIT_BAT_STATUS_FULL		(1 << 1)
> +#define KB3310B_BIT_BAT_STATUS_IN		(1 << 0)
> +#define KB3310B_REG_BAT_CHARGE_STATUS		0xF4B1
> +#define KB3310B_BIT_BAT_CHARGE_STATUS_OVERTEMP	(1 << 2)
> +#define KB3310B_BIT_BAT_CHARGE_STATUS_PRECHG	(1 << 1)
> +#define KB3310B_REG_BAT_STATE			0xF482
> +#define KB3310B_BIT_BAT_STATE_CHARGING		(1 << 1)
> +#define KB3310B_BIT_BAT_STATE_DISCHARGING	(1 << 0)
> +#define KB3310B_REG_BAT_POWER			0xF440
> +#define KB3310B_BIT_BAT_POWER_S3		(1 << 2)
> +#define KB3310B_BIT_BAT_POWER_ON		(1 << 1)
> +#define KB3310B_BIT_BAT_POWER_ACIN		(1 << 0)
> +
> +/* other registers */
> +
> +/* Audio: rd/wr */
> +#define KB3310B_REG_AUDIO_VOLUME	0xF46C
> +#define KB3310B_REG_AUDIO_MUTE		0xF4E7
> +#define KB3310B_REG_AUDIO_BEEP		0xF4D0
> +
> +/* USB port power or not: rd/wr */
> +#define KB3310B_REG_USB0_FLAG		0xF461
> +#define KB3310B_REG_USB1_FLAG		0xF462
> +#define KB3310B_REG_USB2_FLAG		0xF463
> +#define KB3310B_BIT_USB_FLAG_ON		1
> +#define KB3310B_BIT_USB_FLAG_OFF	0
> +
> +/* LID */
> +#define KB3310B_REG_LID_DETECT		0xF4BD
> +#define KB3310B_BIT_LID_DETECT_ON	1
> +#define KB3310B_BIT_LID_DETECT_OFF	0
> +
> +/* CRT */
> +#define KB3310B_REG_CRT_DETECT		0xF4AD
> +#define KB3310B_BIT_CRT_DETECT_PLUG	1
> +#define KB3310B_BIT_CRT_DETECT_UNPLUG	0
> +
> +/* LCD backlight brightness adjust: 9 levels */
> +#define KB3310B_REG_DISPLAY_BRIGHTNESS	0xF4F5
> +
> +/* Black screen status */
> +#define KB3310B_REG_DISPLAY_LCD		0xF79F
> +#define KB3310B_BIT_DISPLAY_LCD_ON	1
> +#define KB3310B_BIT_DISPLAY_LCD_OFF	0
> +
> +/* LCD backlight control: off/restore */
> +#define KB3310B_REG_BACKLIGHT_CTRL	0xF7BD
> +#define KB3310B_BIT_BACKLIGHT_ON	1
> +#define KB3310B_BIT_BACKLIGHT_OFF	0
> +
> +/* Reset the machine auto-clear: rd/wr */
> +#define KB3310B_REG_RESET		0xF4EC
> +#define KB3310B_BIT_RESET_ON		1
> +
> +/* Light the LED: rd/wr */
> +#define KB3310B_REG_LED			0xF4C8
> +#define KB3310B_BIT_LED_RED_POWER	(1 << 0)
> +#define KB3310B_BIT_LED_ORANGE_POWER	(1 << 1)
> +#define KB3310B_BIT_LED_GREEN_CHARGE	(1 << 2)
> +#define KB3310B_BIT_LED_RED_CHARGE	(1 << 3)
> +#define KB3310B_BIT_LED_NUMLOCK		(1 << 4)
> +
> +/* Test LED mode, all LED on/off */
> +#define KB3310B_REG_LED_TEST		0xF4C2
> +#define KB3310B_BIT_LED_TEST_IN		1
> +#define KB3310B_BIT_LED_TEST_OUT	0
> +
> +/* Camera on/off */
> +#define KB3310B_REG_CAMERA_STATUS	0xF46A
> +#define KB3310B_BIT_CAMERA_STATUS_ON	1
> +#define KB3310B_BIT_CAMERA_STATUS_OFF	0
> +#define KB3310B_REG_CAMERA_CONTROL	0xF7B7
> +#define KB3310B_BIT_CAMERA_CONTROL_OFF	0
> +#define KB3310B_BIT_CAMERA_CONTROL_ON	1
> +
> +/* WLAN Status */
> +#define KB3310B_REG_WLAN		0xF4FA
> +#define KB3310B_BIT_WLAN_ON		1
> +#define KB3310B_BIT_WLAN_OFF		0
> +
> +/* SCI Event Number from EC */
> +enum {
> +	KB3310B_EVENT_START =3D 0x22,
> +	KB3310B_EVENT_LID =3D 0x23,	   /* LID open/close */
> +	KB3310B_EVENT_DISPLAY_TOGGLE,	   /* Fn+F3 for display switch */
> +	KB3310B_EVENT_SLEEP,		   /* Fn+F1 for entering sleep mode */
> +	KB3310B_EVENT_OVERTEMP,		   /* Over-temperature occurred */
> +	KB3310B_EVENT_CRT_DETECT,	   /* CRT is connected */
> +	KB3310B_EVENT_CAMERA,		   /* Camera on/off */
> +	KB3310B_EVENT_USB_OC2,		   /* USB2 Overcurrent occurred */
> +	KB3310B_EVENT_USB_OC0,		   /* USB0 Overcurrent occurred */
> +	KB3310B_EVENT_BLACK_SCREEN,	   /* Turn on/off backlight */
> +	KB3310B_EVENT_AUDIO_MUTE,	   /* Mute on/off */
> +	KB3310B_EVENT_DISPLAY_BRIGHTNESS,  /* LCD backlight brightness adjust *=
/
> +	KB3310B_EVENT_AC_BAT,		   /* AC & Battery relative issue */
> +	KB3310B_EVENT_AUDIO_VOLUME,	   /* Volume adjust */
> +	KB3310B_EVENT_WLAN,		   /* WLAN on/off */
> +	KB3310B_EVENT_END
> +};
> +
> +#endif /* !__LINUX_MFD_YEELOONG_KB3310B_H */
> --=20
> 2.20.1
>=20
