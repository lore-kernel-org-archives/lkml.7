Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142CE206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pVyfIILp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfDDSUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:20:05 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:64390
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbfDDSUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoRPpeptFIV7BYaW8DXln3IENOwWVbGE8Q4/NQ3CqgE=;
 b=pVyfIILpOkgOR2w7B1QZSEJMyaqUH4e1/+kMYObk+fyO2Sg1Rq2byCrrcV1Z9hCn3iwkstvY0ABG2Fd4/RAkLbOklIN1YAVAbpM2ADRg3ApT+WTIZC53XLfCLs04oDgOBUaeRUbvnbYyQsVf/qC7aKE+demmAi4M36HWKy2jo8U=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.33.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Thu, 4 Apr 2019 18:20:00 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::fc93:97ef:f27e:a9]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::fc93:97ef:f27e:a9%4]) with mapi id 15.20.1771.011; Thu, 4 Apr 2019
 18:20:00 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: RE: [PATCH] soc: fsl: add DPAA2 console support
Thread-Topic: [PATCH] soc: fsl: add DPAA2 console support
Thread-Index: AQHU5AhknrBzPfGcyEqu6n1s2eiIeqYsXICg
Date:   Thu, 4 Apr 2019 18:20:00 +0000
Message-ID: <AM6PR04MB58632DC6480A51CEA6C3C2CC8F500@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <1553627718-23714-1-git-send-email-ioana.ciornei@nxp.com>
 <CADRPPNSPsRJEPW9uMNoDAEqYvKYPF2ybJX7a48rJJqap3nwOtw@mail.gmail.com>
 <VI1PR0402MB28001287DEFB65FD29BE98E0E0500@VI1PR0402MB2800.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB28001287DEFB65FD29BE98E0E0500@VI1PR0402MB2800.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7fdf8db-2fa5-425d-662c-08d6b92a265f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB4936;
x-ms-traffictypediagnostic: AM6PR04MB4936:
x-microsoft-antispam-prvs: <AM6PR04MB4936A94642028DD74FC5B07F8F500@AM6PR04MB4936.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(136003)(346002)(13464003)(199004)(51914003)(189003)(3846002)(316002)(25786009)(5660300002)(6116002)(99286004)(256004)(229853002)(54906003)(14454004)(30864003)(66066001)(86362001)(6436002)(52536014)(14444005)(486006)(478600001)(81156014)(2906002)(6636002)(76176011)(26005)(7696005)(55016002)(74316002)(8936002)(53936002)(8676002)(71190400001)(476003)(97736004)(9686003)(7736002)(33656002)(6246003)(53546011)(81166006)(105586002)(4326008)(6862004)(106356001)(446003)(305945005)(186003)(102836004)(6506007)(11346002)(71200400001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4936;H:AM6PR04MB5863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gg7V3qJ5Nkdua2tthl0AWaRs2FMwmcirr4fmYd5NWx3h5qLclkbpwvrx4+O+v9FVBTQpjMXtK19rcQwx7IwmMBi0IzBu44/R/FXNiOSFY+GRfguA2uAgRR8oV9/3DdUF0f0A5OTFRB8pWPT8H31w6JJWIW6OwQ85Pyel5neQdkluXeSC4mfX42XHAMfRipbVDimft4dbXSJq2PEXAIydOEiIWBiZrIcofxcVlqCQcPaySmGy5X2s5HynjQCpY+wq2eYncNF3ryJ5FyvRtZlyz9DIwGHOjoHAftHzn36QxkaFfMZouqcwL/DD9dKtnvxP+FEICpV68rMqdKUy57x9jJhRRSgvxykE6ziS9+IstumvWsEeWndQNhNuUKPhFiuEDF6wQaeXXa+H1hvLiWdiIYQPVIQ/sqO+Y/WYAnGF/3w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fdf8db-2fa5-425d-662c-08d6b92a265f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 18:20:00.2594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ioana Ciornei
> Sent: Thursday, April 4, 2019 5:48 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-kernel@vger.kernel.org; Roy Pledge <roy.pledge@nxp.com>
> Subject: Re: [PATCH] soc: fsl: add DPAA2 console support
>=20
> On 4/3/19 10:55 PM, Li Yang wrote:
> > On Tue, Mar 26, 2019 at 2:17 PM Ioana Ciornei <ioana.ciornei@nxp.com>
> wrote:
> >>
> >> This patch adds DPAA2 MC and AIOP console log support.
> >>
> >> The platform driver probes on the "fsl,dpaa2-console" device tree
> >> node which describes the base firmware address needed in order to
> >> infer the start address of both firmware logs: MC and AIOP.
> >> It then exports two misc char devices which can be used to dump the
> >> needed logs.
> >>
> >> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> >> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> >> ---
> >>   drivers/soc/fsl/Kconfig         |  10 ++
> >>   drivers/soc/fsl/Makefile        |   1 +
> >>   drivers/soc/fsl/dpaa2-console.c | 306
> ++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 317 insertions(+)
> >>   create mode 100644 drivers/soc/fsl/dpaa2-console.c
> >>
> >> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
> >> 61f8e1433d0a..9fe8222c3968 100644
> >> --- a/drivers/soc/fsl/Kconfig
> >> +++ b/drivers/soc/fsl/Kconfig
> >> @@ -29,4 +29,14 @@ config FSL_MC_DPIO
> >>            other DPAA2 objects. This driver does not expose the DPIO
> >>            objects individually, but groups them under a service layer
> >>            API.
> >> +
> >> +config DPAA2_CONSOLE
> >> +       tristate "QorIQ DPAA2 console driver"
> >> +       depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM
> ||
> >> +ARM64 || X86_LOCAL_APIC || PPC)))
> >
> > I don't know why FSL_MC driver added there architectures dependency
> > for COMPILE_TEST, but is this driver also only buildable on these
> > architectures?  Can we really just remove these dependencies?
> >
>=20
> The initial reasoning behind the dependency on the COMPILE_TEST config
> was to catch early build problems on any build configuration.
> And yes, the dpaa2-console can be compiled without a problem on these
> architectures.
>=20
> In this case, I would suggest to leave the dependencies as they are but i=
f you
> want I can also remove them.

Can we keep the COMPILE_TEST and remove the (ARM || ARM64 || X86_LOCAL_APIC=
 || PPC) if we are not using any architecture specific stuff?

>=20
> >> +       default y
> >> +       help
> >> +         Console driver for DPAA2 platforms. Exports 2 char devices,
> >> +         /dev/dpaa2_mc_console and /dev/dpaa2_aiop_console,
> >> +         which can be used to dump the Management Complex and AIOP
> >> +         firmware logs.
> >>   endmenu
> >> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> >> index 803ef1bfb5ff..57762c9fc7da 100644
> >> --- a/drivers/soc/fsl/Makefile
> >> +++ b/drivers/soc/fsl/Makefile
> >> @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)              +=3D qe/
> >>   obj-$(CONFIG_CPM)                      +=3D qe/
> >>   obj-$(CONFIG_FSL_GUTS)                 +=3D guts.o
> >>   obj-$(CONFIG_FSL_MC_DPIO)              +=3D dpio/
> >> +obj-$(CONFIG_DPAA2_CONSOLE)            +=3D dpaa2-console.o
> >> diff --git a/drivers/soc/fsl/dpaa2-console.c
> >> b/drivers/soc/fsl/dpaa2-console.c new file mode 100644 index
> >> 000000000000..21a5e121f87b
> >> --- /dev/null
> >> +++ b/drivers/soc/fsl/dpaa2-console.c
> >> @@ -0,0 +1,306 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >
> > Probably good to have a one-line description of the driver?
>=20
> Will add one in the next version.
>=20
> >
> >> +/* Copyright 2015-2016 Freescale Semiconductor Inc.
> >> + * Copyright 2018 NXP
> >> + */
> >> +
> >> +#define pr_fmt(fmt) "dpaa2-console: " fmt
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/miscdevice.h>
> >> +#include <linux/uaccess.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/fs.h>
> >> +#include <linux/io.h>
> >> +
> >> +MODULE_LICENSE("Dual BSD/GPL");
> >> +MODULE_AUTHOR("Roy Pledge <roy.pledge@nxp.com>");
> >> +MODULE_DESCRIPTION("DPAA2 console driver");
> >
> > These normally go to the bottom of a driver.
>=20
> Will move them.
>=20
> >
> >> +
> >> +/* MC firmware base low/high registers indexes */ #define
> >> +MCFBALR_OFFSET 0 #define MCFBAHR_OFFSET 1
> >> +
> >> +/* Bit masks used to get the most/least significant part of the MC
> >> +base addr */ #define MC_FW_ADDR_MASK_HIGH 0x1FFFF #define
> >> +MC_FW_ADDR_MASK_LOW  0xE0000000
> >> +
> >> +#define MC_BUFFER_OFFSET 0x01000000
> >> +#define MC_BUFFER_SIZE   (1024 * 1024 * 16)
> >> +#define MC_OFFSET_DELTA  MC_BUFFER_OFFSET
> >> +
> >> +#define AIOP_BUFFER_OFFSET 0x06000000
> >> +#define AIOP_BUFFER_SIZE   (1024 * 1024 * 16)
> >> +#define AIOP_OFFSET_DELTA  0
> >> +
> >> +#define LOG_HEADER_FLAG_BUFFER_WRAPAROUND 0x80000000
> #define
> >> +LAST_BYTE(a) ((a) & ~(LOG_HEADER_FLAG_BUFFER_WRAPAROUND))
> >> +
> >> +/* MC and AIOP Magic words */
> >> +#define MAGIC_MC   0x4d430100
> >> +#define MAGIC_AIOP 0x41494F50
> >> +
> >> +struct log_header {
> >> +       __le32 magic_word;
> >> +       char reserved[4];
> >> +       __le32 buf_start;
> >> +       __le32 buf_length;
> >> +       __le32 last_byte;
> >> +};
> >> +
> >> +struct console_data {
> >> +       char *map_addr;
> >> +       struct log_header *hdr;
> >> +       char *start_addr;
> >> +       char *end_addr;
> >> +       char *end_of_data;
> >> +       char *cur_ptr;
> >> +};
> >> +
> >> +struct resource mc_base_addr;
> >> +
> >> +static inline void adjust_end(struct console_data *cd) {
> >> +       u32 last_byte =3D readl(&cd->hdr->last_byte);
> >> +
> >> +       cd->end_of_data =3D cd->start_addr + LAST_BYTE(last_byte); }
> >> +
> >> +static u64 get_mc_fw_base_address(void) {
> >> +       u64 mcfwbase =3D 0ULL;
> >> +       u32 *mcfbaregs;
> >> +
> >> +       mcfbaregs =3D (u32 *)ioremap(mc_base_addr.start,
> >> +                                  resource_size(&mc_base_addr));
> >> +       if (!mcfbaregs) {
> >> +               pr_err("could not map MC Firmaware Base registers\n");
> >> +               return -EIO;
> >> +       }
> >> +
> >> +       mcfwbase  =3D readl(mcfbaregs + MCFBAHR_OFFSET) &
> MC_FW_ADDR_MASK_HIGH;
> >> +       mcfwbase <<=3D 32;
> >> +       mcfwbase |=3D readl(mcfbaregs + MCFBALR_OFFSET) &
> MC_FW_ADDR_MASK_LOW;
> >> +       iounmap(mcfbaregs);
> >> +
> >> +       pr_debug("MC base address at 0x%016llx\n", mcfwbase);
> >> +       return mcfwbase;
> >> +}
> >> +
> >> +static ssize_t dpaa2_console_size(struct console_data *cd) {
> >> +       ssize_t size;
> >> +
> >> +       if (cd->cur_ptr <=3D cd->end_of_data)
> >> +               size =3D cd->end_of_data - cd->cur_ptr;
> >> +       else
> >> +               size =3D (cd->end_addr - cd->cur_ptr) +
> >> +                       (cd->end_of_data - cd->start_addr);
> >> +
> >> +       return size;
> >> +}
> >> +
> >> +static int dpaa2_generic_console_open(struct inode *node, struct file=
 *fp,
> >> +                                     u64 offset, u64 size,
> >> +                                     u32 expected_magic,
> >> +                                     u32 offset_delta) {
> >> +       u32 read_magic, wrapped, last_byte, buf_start, buf_length;
> >> +       struct console_data *cd;
> >> +       u64 base_addr;
> >> +       int err;
> >> +
> >> +       cd =3D kmalloc(sizeof(*cd), GFP_KERNEL);
> >> +       if (!cd)
> >> +               return -ENOMEM;
> >> +
> >> +       base_addr =3D get_mc_fw_base_address();
> >> +       if (base_addr < 0)
> >
> > We are leaking cd structure here.
>=20
> Ugh, that's right. Will fix.
>=20
> >
> >> +               return -EIO;
> >> +
> >> +       cd->map_addr =3D ioremap(base_addr + offset, size);
> >> +       if (!cd->map_addr) {
> >> +               pr_err("cannot map console log memory\n");
> >> +               err =3D -EIO;
> >> +               goto err_ioremap;
> >> +       }
> >> +
> >> +       cd->hdr =3D (struct log_header *)cd->map_addr;
> >> +       read_magic =3D readl(&cd->hdr->magic_word);
> >> +       last_byte =3D readl(&cd->hdr->last_byte);
> >> +       buf_start =3D readl(&cd->hdr->buf_start);
> >> +       buf_length =3D readl(&cd->hdr->buf_length);
> >> +
> >> +       if (read_magic !=3D expected_magic) {
> >> +               pr_warn("expected =3D %08x, read =3D %08x\n",
> >> +                       expected_magic, read_magic);
> >> +               err =3D -EIO;
> >> +               goto err_magic;
> >> +       }
> >> +
> >> +       cd->start_addr =3D cd->map_addr + buf_start - offset_delta;
> >> +       cd->end_addr =3D cd->start_addr + buf_length;
> >> +
> >> +       wrapped =3D last_byte & LOG_HEADER_FLAG_BUFFER_WRAPAROUND;
> >> +
> >> +       adjust_end(cd);
> >> +       if (wrapped && cd->end_of_data !=3D cd->end_addr)
> >> +               cd->cur_ptr =3D cd->end_of_data + 1;
> >> +       else
> >> +               cd->cur_ptr =3D cd->start_addr;
> >> +
> >> +       fp->private_data =3D cd;
> >> +
> >> +       return 0;
> >> +
> >> +err_magic:
> >> +       iounmap(cd->map_addr);
> >> +
> >> +err_ioremap:
> >> +       kfree(cd);
> >> +
> >> +       return err;
> >> +}
> >> +
> >> +static int dpaa2_mc_console_open(struct inode *node, struct file
> >> +*fp) {
> >> +       return dpaa2_generic_console_open(node, fp,
> >> +                                         MC_BUFFER_OFFSET, MC_BUFFER_=
SIZE,
> >> +                                         MAGIC_MC, MC_OFFSET_DELTA);
> >> +}
> >> +
> >> +static int dpaa2_aiop_console_open(struct inode *node, struct file
> >> +*fp) {
> >> +       return dpaa2_generic_console_open(node, fp,
> >> +                                         AIOP_BUFFER_OFFSET, AIOP_BUF=
FER_SIZE,
> >> +                                         MAGIC_AIOP,
> >> +AIOP_OFFSET_DELTA); }
> >> +
> >> +static int dpaa2_console_close(struct inode *node, struct file *fp)
> >> +{
> >> +       struct console_data *cd =3D fp->private_data;
> >> +
> >> +       iounmap(cd->map_addr);
> >> +       kfree(cd);
> >> +       return 0;
> >> +}
> >> +
> >> +static ssize_t dpaa2_console_read(struct file *fp, char __user *buf,
> >> +                                 size_t count, loff_t *f_pos) {
> >> +       struct console_data *cd =3D fp->private_data;
> >> +       size_t bytes =3D dpaa2_console_size(cd);
> >> +       size_t bytes_end =3D cd->end_addr - cd->cur_ptr;
> >> +       size_t written =3D 0;
> >> +
> >> +       /* Check if we need to adjust the end of data addr */
> >> +       adjust_end(cd);
> >> +
> >> +       if (cd->end_of_data =3D=3D cd->cur_ptr)
> >> +               return 0;
> >> +
> >> +       if (count < bytes)
> >> +               bytes =3D count;
> >> +
> >> +       if (bytes > bytes_end) {
> >> +               if (copy_to_user(buf, cd->cur_ptr, bytes_end))
> >> +                       return -EFAULT;
> >> +               buf +=3D bytes_end;
> >> +               cd->cur_ptr =3D cd->start_addr;
> >> +               bytes -=3D bytes_end;
> >> +               written +=3D bytes_end;
> >> +       }
> >> +
> >> +       if (copy_to_user(buf, cd->cur_ptr, bytes))
> >> +               return -EFAULT;
> >> +       cd->cur_ptr +=3D bytes;
> >> +       written +=3D bytes;
> >> +
> >> +       return written;
> >> +}
> >> +
> >> +static const struct file_operations dpaa2_mc_console_fops =3D {
> >> +       .owner          =3D THIS_MODULE,
> >> +       .open           =3D dpaa2_mc_console_open,
> >> +       .release        =3D dpaa2_console_close,
> >> +       .read           =3D dpaa2_console_read,
> >> +};
> >> +
> >> +static struct miscdevice dpaa2_mc_console_dev =3D {
> >> +       .minor =3D MISC_DYNAMIC_MINOR,
> >> +       .name =3D "dpaa2_mc_console",
> >> +       .fops =3D &dpaa2_mc_console_fops };
> >> +
> >> +static const struct file_operations dpaa2_aiop_console_fops =3D {
> >> +       .owner          =3D THIS_MODULE,
> >> +       .open           =3D dpaa2_aiop_console_open,
> >> +       .release        =3D dpaa2_console_close,
> >> +       .read           =3D dpaa2_console_read,
> >> +};
> >> +
> >> +static struct miscdevice dpaa2_aiop_console_dev =3D {
> >> +       .minor =3D MISC_DYNAMIC_MINOR,
> >> +       .name =3D "dpaa2_aiop_console",
> >> +       .fops =3D &dpaa2_aiop_console_fops };
> >> +
> >> +static int dpaa2_console_probe(struct platform_device *pdev) {
> >> +       int error;
> >> +
> >> +       error =3D of_address_to_resource(pdev->dev.of_node, 0,
> &mc_base_addr);
> >> +       if (error < 0) {
> >> +               pr_err("of_address_to_resource() failed for %pOF with =
%d\n",
> >> +                      pdev->dev.of_node, error);
> >> +               return error;
> >> +       }
> >> +
> >> +       error =3D misc_register(&dpaa2_mc_console_dev);
> >> +       if (error) {
> >> +               pr_err("dpaa2-console: cannot register device %s\n",
> >> +                      dpaa2_mc_console_dev.name);
> >
> > The pr_fmt already have the dpaa2-console prefix.
> >
> >> +               goto err_register_mc;
> >> +       }
> >> +
> >> +       error =3D misc_register(&dpaa2_aiop_console_dev);
> >> +       if (error) {
> >> +               pr_err("dpaa2-console: cannot register device %s\n",
> >> +                      dpaa2_aiop_console_dev.name);
> >
> > The pr_fmt already have the dpaa2-console prefix.
> >
>=20
>=20
> Yep, will remove the duplicate "dpaa2-console" prefix.
>=20
> Thanks for the review,
> Ioana C
>=20
>=20
> >> +               goto err_register_aiop;
> >> +       }
> >> +
> >> +       return 0;
> >> +
> >> +err_register_aiop:
> >> +       misc_deregister(&dpaa2_mc_console_dev);
> >> +err_register_mc:
> >> +       return error;
> >> +}
> >> +
> >> +static int dpaa2_console_remove(struct platform_device *pdev) {
> >> +       misc_deregister(&dpaa2_mc_console_dev);
> >> +       misc_deregister(&dpaa2_aiop_console_dev);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static const struct of_device_id dpaa2_console_match_table[] =3D {
> >> +       { .compatible =3D "fsl,dpaa2-console",},
> >> +       {},
> >> +};
> >> +
> >> +MODULE_DEVICE_TABLE(of, dpaa2_console_match_table);
> >> +
> >> +static struct platform_driver dpaa2_console_driver =3D {
> >> +       .driver =3D {
> >> +                  .name =3D "dpaa2-console",
> >> +                  .pm =3D NULL,
> >> +                  .of_match_table =3D dpaa2_console_match_table,
> >> +                  },
> >> +       .probe =3D dpaa2_console_probe,
> >> +       .remove =3D dpaa2_console_remove, };
> >> +module_platform_driver(dpaa2_console_driver);
> >> --
> >> 1.9.1
> >>
> >

