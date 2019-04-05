Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DADC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE3021738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eeupLFzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfDEJFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:05:33 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:21573
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729728AbfDEJFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjuKnGR7G8zfUrbffkL4QDHb3xQRuBmkf0CnTExfLpw=;
 b=eeupLFzzs9m6LRo7TwLftTLANKqzYLsnkMdmLGrNQunmSlORI2fi7KoZClvz918+NgEe8fN7W+hQa0mrKBdO+E1e8WlP02pW5FtMk0lCSJNHAZ1IvgGpDJWN46OgPrbKwC7mXThkD2e8PBkZR+AACE+mbnLNrIEuJe29JiFZRbU=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2704.eurprd04.prod.outlook.com (10.175.22.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Fri, 5 Apr 2019 09:05:12 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::f808:5ebf:a573:3ea1]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::f808:5ebf:a573:3ea1%8]) with mapi id 15.20.1771.011; Fri, 5 Apr 2019
 09:05:12 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: Re: [PATCH] soc: fsl: add DPAA2 console support
Thread-Topic: [PATCH] soc: fsl: add DPAA2 console support
Thread-Index: AQHU5AhknrBzPfGcyEqu6n1s2eiIeg==
Date:   Fri, 5 Apr 2019 09:05:12 +0000
Message-ID: <VI1PR0402MB2800A8D4D764E2155E354F7FE0510@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1553627718-23714-1-git-send-email-ioana.ciornei@nxp.com>
 <CADRPPNSPsRJEPW9uMNoDAEqYvKYPF2ybJX7a48rJJqap3nwOtw@mail.gmail.com>
 <VI1PR0402MB28001287DEFB65FD29BE98E0E0500@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <AM6PR04MB58632DC6480A51CEA6C3C2CC8F500@AM6PR04MB5863.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [94.230.156.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d362b46-e8fc-4558-8097-08d6b9a5cfa3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2704;
x-ms-traffictypediagnostic: VI1PR0402MB2704:
x-microsoft-antispam-prvs: <VI1PR0402MB27045785A39AC39768321E23E0510@VI1PR0402MB2704.eurprd04.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(366004)(136003)(51914003)(189003)(199004)(13464003)(6862004)(2906002)(4326008)(6436002)(14444005)(256004)(486006)(97736004)(106356001)(186003)(14454004)(44832011)(478600001)(74316002)(6636002)(86362001)(76176011)(6246003)(71200400001)(6116002)(7696005)(30864003)(66066001)(25786009)(3846002)(55016002)(52536014)(68736007)(5660300002)(81156014)(81166006)(8676002)(7736002)(229853002)(9686003)(33656002)(53936002)(71190400001)(53546011)(53946003)(6506007)(305945005)(26005)(54906003)(8936002)(102836004)(105586002)(93886005)(99286004)(476003)(446003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2704;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gIka+Yl7TdCrX317omBposVa4GJmk5HrSeHJMnkwqaW73gdYMFmuQFQkco4PZ3veek+0v0fB4k8EFCVPPIyY2z9/N5YWlKd68CrgPjo5LVRrZXXa2/3gJRbRpHFAeaVVuStDPuEm49KrO7EYDClq5fTLqs57G4Vpzzq3vn5/pskV5VVBDs5mhmCYI0ZbAUWj/3IFsr9Tcsh8hQNvzoXEYmL9jQr+9bKuxpHgNQSIE+VNqkdAW2HP6olEjRAZDikaOsvlSTJ8U8xDB6UbPMhdpiUqsC4cgGN8r5YKUxNblbAcANKXS9Zb8q7aTclT/jlFqrfIJbYxPYmZ5dodKkIP8B2x1jbkTRi//xQ4W3BjEgJiPYHnhBz4PApGF+4KT0PJ93NTW8P2M2J3xu0hjuIqJRBIH7ERcluxz0hJoTO3r7M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d362b46-e8fc-4558-8097-08d6b9a5cfa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 09:05:12.2444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2704
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 9:20 PM, Leo Li wrote:=0A=
> =0A=
> =0A=
>> -----Original Message-----=0A=
>> From: Ioana Ciornei=0A=
>> Sent: Thursday, April 4, 2019 5:48 AM=0A=
>> To: Leo Li <leoyang.li@nxp.com>=0A=
>> Cc: linux-kernel@vger.kernel.org; Roy Pledge <roy.pledge@nxp.com>=0A=
>> Subject: Re: [PATCH] soc: fsl: add DPAA2 console support=0A=
>>=0A=
>> On 4/3/19 10:55 PM, Li Yang wrote:=0A=
>>> On Tue, Mar 26, 2019 at 2:17 PM Ioana Ciornei <ioana.ciornei@nxp.com>=
=0A=
>> wrote:=0A=
>>>>=0A=
>>>> This patch adds DPAA2 MC and AIOP console log support.=0A=
>>>>=0A=
>>>> The platform driver probes on the "fsl,dpaa2-console" device tree=0A=
>>>> node which describes the base firmware address needed in order to=0A=
>>>> infer the start address of both firmware logs: MC and AIOP.=0A=
>>>> It then exports two misc char devices which can be used to dump the=0A=
>>>> needed logs.=0A=
>>>>=0A=
>>>> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>=0A=
>>>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
>>>> ---=0A=
>>>>    drivers/soc/fsl/Kconfig         |  10 ++=0A=
>>>>    drivers/soc/fsl/Makefile        |   1 +=0A=
>>>>    drivers/soc/fsl/dpaa2-console.c | 306=0A=
>> ++++++++++++++++++++++++++++++++++++++++=0A=
>>>>    3 files changed, 317 insertions(+)=0A=
>>>>    create mode 100644 drivers/soc/fsl/dpaa2-console.c=0A=
>>>>=0A=
>>>> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index=
=0A=
>>>> 61f8e1433d0a..9fe8222c3968 100644=0A=
>>>> --- a/drivers/soc/fsl/Kconfig=0A=
>>>> +++ b/drivers/soc/fsl/Kconfig=0A=
>>>> @@ -29,4 +29,14 @@ config FSL_MC_DPIO=0A=
>>>>             other DPAA2 objects. This driver does not expose the DPIO=
=0A=
>>>>             objects individually, but groups them under a service laye=
r=0A=
>>>>             API.=0A=
>>>> +=0A=
>>>> +config DPAA2_CONSOLE=0A=
>>>> +       tristate "QorIQ DPAA2 console driver"=0A=
>>>> +       depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM=0A=
>> ||=0A=
>>>> +ARM64 || X86_LOCAL_APIC || PPC)))=0A=
>>>=0A=
>>> I don't know why FSL_MC driver added there architectures dependency=0A=
>>> for COMPILE_TEST, but is this driver also only buildable on these=0A=
>>> architectures?  Can we really just remove these dependencies?=0A=
>>>=0A=
>>=0A=
>> The initial reasoning behind the dependency on the COMPILE_TEST config=
=0A=
>> was to catch early build problems on any build configuration.=0A=
>> And yes, the dpaa2-console can be compiled without a problem on these=0A=
>> architectures.=0A=
>>=0A=
>> In this case, I would suggest to leave the dependencies as they are but =
if you=0A=
>> want I can also remove them.=0A=
> =0A=
> Can we keep the COMPILE_TEST and remove the (ARM || ARM64 || X86_LOCAL_AP=
IC || PPC) if we are not using any architecture specific stuff?=0A=
=0A=
Yes, that should be a better solution. Will send a v2 with all the changes.=
=0A=
=0A=
Thanks,=0A=
Ioana C=0A=
=0A=
=0A=
> =0A=
>>=0A=
>>>> +       default y=0A=
>>>> +       help=0A=
>>>> +         Console driver for DPAA2 platforms. Exports 2 char devices,=
=0A=
>>>> +         /dev/dpaa2_mc_console and /dev/dpaa2_aiop_console,=0A=
>>>> +         which can be used to dump the Management Complex and AIOP=0A=
>>>> +         firmware logs.=0A=
>>>>    endmenu=0A=
>>>> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile=0A=
>>>> index 803ef1bfb5ff..57762c9fc7da 100644=0A=
>>>> --- a/drivers/soc/fsl/Makefile=0A=
>>>> +++ b/drivers/soc/fsl/Makefile=0A=
>>>> @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)              +=3D qe/=0A=
>>>>    obj-$(CONFIG_CPM)                      +=3D qe/=0A=
>>>>    obj-$(CONFIG_FSL_GUTS)                 +=3D guts.o=0A=
>>>>    obj-$(CONFIG_FSL_MC_DPIO)              +=3D dpio/=0A=
>>>> +obj-$(CONFIG_DPAA2_CONSOLE)            +=3D dpaa2-console.o=0A=
>>>> diff --git a/drivers/soc/fsl/dpaa2-console.c=0A=
>>>> b/drivers/soc/fsl/dpaa2-console.c new file mode 100644 index=0A=
>>>> 000000000000..21a5e121f87b=0A=
>>>> --- /dev/null=0A=
>>>> +++ b/drivers/soc/fsl/dpaa2-console.c=0A=
>>>> @@ -0,0 +1,306 @@=0A=
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)=0A=
>>>=0A=
>>> Probably good to have a one-line description of the driver?=0A=
>>=0A=
>> Will add one in the next version.=0A=
>>=0A=
>>>=0A=
>>>> +/* Copyright 2015-2016 Freescale Semiconductor Inc.=0A=
>>>> + * Copyright 2018 NXP=0A=
>>>> + */=0A=
>>>> +=0A=
>>>> +#define pr_fmt(fmt) "dpaa2-console: " fmt=0A=
>>>> +=0A=
>>>> +#include <linux/module.h>=0A=
>>>> +#include <linux/of_device.h>=0A=
>>>> +#include <linux/of_address.h>=0A=
>>>> +#include <linux/miscdevice.h>=0A=
>>>> +#include <linux/uaccess.h>=0A=
>>>> +#include <linux/slab.h>=0A=
>>>> +#include <linux/fs.h>=0A=
>>>> +#include <linux/io.h>=0A=
>>>> +=0A=
>>>> +MODULE_LICENSE("Dual BSD/GPL");=0A=
>>>> +MODULE_AUTHOR("Roy Pledge <roy.pledge@nxp.com>");=0A=
>>>> +MODULE_DESCRIPTION("DPAA2 console driver");=0A=
>>>=0A=
>>> These normally go to the bottom of a driver.=0A=
>>=0A=
>> Will move them.=0A=
>>=0A=
>>>=0A=
>>>> +=0A=
>>>> +/* MC firmware base low/high registers indexes */ #define=0A=
>>>> +MCFBALR_OFFSET 0 #define MCFBAHR_OFFSET 1=0A=
>>>> +=0A=
>>>> +/* Bit masks used to get the most/least significant part of the MC=0A=
>>>> +base addr */ #define MC_FW_ADDR_MASK_HIGH 0x1FFFF #define=0A=
>>>> +MC_FW_ADDR_MASK_LOW  0xE0000000=0A=
>>>> +=0A=
>>>> +#define MC_BUFFER_OFFSET 0x01000000=0A=
>>>> +#define MC_BUFFER_SIZE   (1024 * 1024 * 16)=0A=
>>>> +#define MC_OFFSET_DELTA  MC_BUFFER_OFFSET=0A=
>>>> +=0A=
>>>> +#define AIOP_BUFFER_OFFSET 0x06000000=0A=
>>>> +#define AIOP_BUFFER_SIZE   (1024 * 1024 * 16)=0A=
>>>> +#define AIOP_OFFSET_DELTA  0=0A=
>>>> +=0A=
>>>> +#define LOG_HEADER_FLAG_BUFFER_WRAPAROUND 0x80000000=0A=
>> #define=0A=
>>>> +LAST_BYTE(a) ((a) & ~(LOG_HEADER_FLAG_BUFFER_WRAPAROUND))=0A=
>>>> +=0A=
>>>> +/* MC and AIOP Magic words */=0A=
>>>> +#define MAGIC_MC   0x4d430100=0A=
>>>> +#define MAGIC_AIOP 0x41494F50=0A=
>>>> +=0A=
>>>> +struct log_header {=0A=
>>>> +       __le32 magic_word;=0A=
>>>> +       char reserved[4];=0A=
>>>> +       __le32 buf_start;=0A=
>>>> +       __le32 buf_length;=0A=
>>>> +       __le32 last_byte;=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +struct console_data {=0A=
>>>> +       char *map_addr;=0A=
>>>> +       struct log_header *hdr;=0A=
>>>> +       char *start_addr;=0A=
>>>> +       char *end_addr;=0A=
>>>> +       char *end_of_data;=0A=
>>>> +       char *cur_ptr;=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +struct resource mc_base_addr;=0A=
>>>> +=0A=
>>>> +static inline void adjust_end(struct console_data *cd) {=0A=
>>>> +       u32 last_byte =3D readl(&cd->hdr->last_byte);=0A=
>>>> +=0A=
>>>> +       cd->end_of_data =3D cd->start_addr + LAST_BYTE(last_byte); }=
=0A=
>>>> +=0A=
>>>> +static u64 get_mc_fw_base_address(void) {=0A=
>>>> +       u64 mcfwbase =3D 0ULL;=0A=
>>>> +       u32 *mcfbaregs;=0A=
>>>> +=0A=
>>>> +       mcfbaregs =3D (u32 *)ioremap(mc_base_addr.start,=0A=
>>>> +                                  resource_size(&mc_base_addr));=0A=
>>>> +       if (!mcfbaregs) {=0A=
>>>> +               pr_err("could not map MC Firmaware Base registers\n");=
=0A=
>>>> +               return -EIO;=0A=
>>>> +       }=0A=
>>>> +=0A=
>>>> +       mcfwbase  =3D readl(mcfbaregs + MCFBAHR_OFFSET) &=0A=
>> MC_FW_ADDR_MASK_HIGH;=0A=
>>>> +       mcfwbase <<=3D 32;=0A=
>>>> +       mcfwbase |=3D readl(mcfbaregs + MCFBALR_OFFSET) &=0A=
>> MC_FW_ADDR_MASK_LOW;=0A=
>>>> +       iounmap(mcfbaregs);=0A=
>>>> +=0A=
>>>> +       pr_debug("MC base address at 0x%016llx\n", mcfwbase);=0A=
>>>> +       return mcfwbase;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static ssize_t dpaa2_console_size(struct console_data *cd) {=0A=
>>>> +       ssize_t size;=0A=
>>>> +=0A=
>>>> +       if (cd->cur_ptr <=3D cd->end_of_data)=0A=
>>>> +               size =3D cd->end_of_data - cd->cur_ptr;=0A=
>>>> +       else=0A=
>>>> +               size =3D (cd->end_addr - cd->cur_ptr) +=0A=
>>>> +                       (cd->end_of_data - cd->start_addr);=0A=
>>>> +=0A=
>>>> +       return size;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int dpaa2_generic_console_open(struct inode *node, struct file=
 *fp,=0A=
>>>> +                                     u64 offset, u64 size,=0A=
>>>> +                                     u32 expected_magic,=0A=
>>>> +                                     u32 offset_delta) {=0A=
>>>> +       u32 read_magic, wrapped, last_byte, buf_start, buf_length;=0A=
>>>> +       struct console_data *cd;=0A=
>>>> +       u64 base_addr;=0A=
>>>> +       int err;=0A=
>>>> +=0A=
>>>> +       cd =3D kmalloc(sizeof(*cd), GFP_KERNEL);=0A=
>>>> +       if (!cd)=0A=
>>>> +               return -ENOMEM;=0A=
>>>> +=0A=
>>>> +       base_addr =3D get_mc_fw_base_address();=0A=
>>>> +       if (base_addr < 0)=0A=
>>>=0A=
>>> We are leaking cd structure here.=0A=
>>=0A=
>> Ugh, that's right. Will fix.=0A=
>>=0A=
>>>=0A=
>>>> +               return -EIO;=0A=
>>>> +=0A=
>>>> +       cd->map_addr =3D ioremap(base_addr + offset, size);=0A=
>>>> +       if (!cd->map_addr) {=0A=
>>>> +               pr_err("cannot map console log memory\n");=0A=
>>>> +               err =3D -EIO;=0A=
>>>> +               goto err_ioremap;=0A=
>>>> +       }=0A=
>>>> +=0A=
>>>> +       cd->hdr =3D (struct log_header *)cd->map_addr;=0A=
>>>> +       read_magic =3D readl(&cd->hdr->magic_word);=0A=
>>>> +       last_byte =3D readl(&cd->hdr->last_byte);=0A=
>>>> +       buf_start =3D readl(&cd->hdr->buf_start);=0A=
>>>> +       buf_length =3D readl(&cd->hdr->buf_length);=0A=
>>>> +=0A=
>>>> +       if (read_magic !=3D expected_magic) {=0A=
>>>> +               pr_warn("expected =3D %08x, read =3D %08x\n",=0A=
>>>> +                       expected_magic, read_magic);=0A=
>>>> +               err =3D -EIO;=0A=
>>>> +               goto err_magic;=0A=
>>>> +       }=0A=
>>>> +=0A=
>>>> +       cd->start_addr =3D cd->map_addr + buf_start - offset_delta;=0A=
>>>> +       cd->end_addr =3D cd->start_addr + buf_length;=0A=
>>>> +=0A=
>>>> +       wrapped =3D last_byte & LOG_HEADER_FLAG_BUFFER_WRAPAROUND;=0A=
>>>> +=0A=
>>>> +       adjust_end(cd);=0A=
>>>> +       if (wrapped && cd->end_of_data !=3D cd->end_addr)=0A=
>>>> +               cd->cur_ptr =3D cd->end_of_data + 1;=0A=
>>>> +       else=0A=
>>>> +               cd->cur_ptr =3D cd->start_addr;=0A=
>>>> +=0A=
>>>> +       fp->private_data =3D cd;=0A=
>>>> +=0A=
>>>> +       return 0;=0A=
>>>> +=0A=
>>>> +err_magic:=0A=
>>>> +       iounmap(cd->map_addr);=0A=
>>>> +=0A=
>>>> +err_ioremap:=0A=
>>>> +       kfree(cd);=0A=
>>>> +=0A=
>>>> +       return err;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int dpaa2_mc_console_open(struct inode *node, struct file=0A=
>>>> +*fp) {=0A=
>>>> +       return dpaa2_generic_console_open(node, fp,=0A=
>>>> +                                         MC_BUFFER_OFFSET, MC_BUFFER_=
SIZE,=0A=
>>>> +                                         MAGIC_MC, MC_OFFSET_DELTA);=
=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int dpaa2_aiop_console_open(struct inode *node, struct file=0A=
>>>> +*fp) {=0A=
>>>> +       return dpaa2_generic_console_open(node, fp,=0A=
>>>> +                                         AIOP_BUFFER_OFFSET, AIOP_BUF=
FER_SIZE,=0A=
>>>> +                                         MAGIC_AIOP,=0A=
>>>> +AIOP_OFFSET_DELTA); }=0A=
>>>> +=0A=
>>>> +static int dpaa2_console_close(struct inode *node, struct file *fp)=
=0A=
>>>> +{=0A=
>>>> +       struct console_data *cd =3D fp->private_data;=0A=
>>>> +=0A=
>>>> +       iounmap(cd->map_addr);=0A=
>>>> +       kfree(cd);=0A=
>>>> +       return 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static ssize_t dpaa2_console_read(struct file *fp, char __user *buf,=
=0A=
>>>> +                                 size_t count, loff_t *f_pos) {=0A=
>>>> +       struct console_data *cd =3D fp->private_data;=0A=
>>>> +       size_t bytes =3D dpaa2_console_size(cd);=0A=
>>>> +       size_t bytes_end =3D cd->end_addr - cd->cur_ptr;=0A=
>>>> +       size_t written =3D 0;=0A=
>>>> +=0A=
>>>> +       /* Check if we need to adjust the end of data addr */=0A=
>>>> +       adjust_end(cd);=0A=
>>>> +=0A=
>>>> +       if (cd->end_of_data =3D=3D cd->cur_ptr)=0A=
>>>> +               return 0;=0A=
>>>> +=0A=
>>>> +       if (count < bytes)=0A=
>>>> +               bytes =3D count;=0A=
>>>> +=0A=
>>>> +       if (bytes > bytes_end) {=0A=
>>>> +               if (copy_to_user(buf, cd->cur_ptr, bytes_end))=0A=
>>>> +                       return -EFAULT;=0A=
>>>> +               buf +=3D bytes_end;=0A=
>>>> +               cd->cur_ptr =3D cd->start_addr;=0A=
>>>> +               bytes -=3D bytes_end;=0A=
>>>> +               written +=3D bytes_end;=0A=
>>>> +       }=0A=
>>>> +=0A=
>>>> +       if (copy_to_user(buf, cd->cur_ptr, bytes))=0A=
>>>> +               return -EFAULT;=0A=
>>>> +       cd->cur_ptr +=3D bytes;=0A=
>>>> +       written +=3D bytes;=0A=
>>>> +=0A=
>>>> +       return written;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static const struct file_operations dpaa2_mc_console_fops =3D {=0A=
>>>> +       .owner          =3D THIS_MODULE,=0A=
>>>> +       .open           =3D dpaa2_mc_console_open,=0A=
>>>> +       .release        =3D dpaa2_console_close,=0A=
>>>> +       .read           =3D dpaa2_console_read,=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +static struct miscdevice dpaa2_mc_console_dev =3D {=0A=
>>>> +       .minor =3D MISC_DYNAMIC_MINOR,=0A=
>>>> +       .name =3D "dpaa2_mc_console",=0A=
>>>> +       .fops =3D &dpaa2_mc_console_fops };=0A=
>>>> +=0A=
>>>> +static const struct file_operations dpaa2_aiop_console_fops =3D {=0A=
>>>> +       .owner          =3D THIS_MODULE,=0A=
>>>> +       .open           =3D dpaa2_aiop_console_open,=0A=
>>>> +       .release        =3D dpaa2_console_close,=0A=
>>>> +       .read           =3D dpaa2_console_read,=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +static struct miscdevice dpaa2_aiop_console_dev =3D {=0A=
>>>> +       .minor =3D MISC_DYNAMIC_MINOR,=0A=
>>>> +       .name =3D "dpaa2_aiop_console",=0A=
>>>> +       .fops =3D &dpaa2_aiop_console_fops };=0A=
>>>> +=0A=
>>>> +static int dpaa2_console_probe(struct platform_device *pdev) {=0A=
>>>> +       int error;=0A=
>>>> +=0A=
>>>> +       error =3D of_address_to_resource(pdev->dev.of_node, 0,=0A=
>> &mc_base_addr);=0A=
>>>> +       if (error < 0) {=0A=
>>>> +               pr_err("of_address_to_resource() failed for %pOF with =
%d\n",=0A=
>>>> +                      pdev->dev.of_node, error);=0A=
>>>> +               return error;=0A=
>>>> +       }=0A=
>>>> +=0A=
>>>> +       error =3D misc_register(&dpaa2_mc_console_dev);=0A=
>>>> +       if (error) {=0A=
>>>> +               pr_err("dpaa2-console: cannot register device %s\n",=
=0A=
>>>> +                      dpaa2_mc_console_dev.name);=0A=
>>>=0A=
>>> The pr_fmt already have the dpaa2-console prefix.=0A=
>>>=0A=
>>>> +               goto err_register_mc;=0A=
>>>> +       }=0A=
>>>> +=0A=
>>>> +       error =3D misc_register(&dpaa2_aiop_console_dev);=0A=
>>>> +       if (error) {=0A=
>>>> +               pr_err("dpaa2-console: cannot register device %s\n",=
=0A=
>>>> +                      dpaa2_aiop_console_dev.name);=0A=
>>>=0A=
>>> The pr_fmt already have the dpaa2-console prefix.=0A=
>>>=0A=
>>=0A=
>>=0A=
>> Yep, will remove the duplicate "dpaa2-console" prefix.=0A=
>>=0A=
>> Thanks for the review,=0A=
>> Ioana C=0A=
>>=0A=
>>=0A=
>>>> +               goto err_register_aiop;=0A=
>>>> +       }=0A=
>>>> +=0A=
>>>> +       return 0;=0A=
>>>> +=0A=
>>>> +err_register_aiop:=0A=
>>>> +       misc_deregister(&dpaa2_mc_console_dev);=0A=
>>>> +err_register_mc:=0A=
>>>> +       return error;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int dpaa2_console_remove(struct platform_device *pdev) {=0A=
>>>> +       misc_deregister(&dpaa2_mc_console_dev);=0A=
>>>> +       misc_deregister(&dpaa2_aiop_console_dev);=0A=
>>>> +=0A=
>>>> +       return 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static const struct of_device_id dpaa2_console_match_table[] =3D {=0A=
>>>> +       { .compatible =3D "fsl,dpaa2-console",},=0A=
>>>> +       {},=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +MODULE_DEVICE_TABLE(of, dpaa2_console_match_table);=0A=
>>>> +=0A=
>>>> +static struct platform_driver dpaa2_console_driver =3D {=0A=
>>>> +       .driver =3D {=0A=
>>>> +                  .name =3D "dpaa2-console",=0A=
>>>> +                  .pm =3D NULL,=0A=
>>>> +                  .of_match_table =3D dpaa2_console_match_table,=0A=
>>>> +                  },=0A=
>>>> +       .probe =3D dpaa2_console_probe,=0A=
>>>> +       .remove =3D dpaa2_console_remove, };=0A=
>>>> +module_platform_driver(dpaa2_console_driver);=0A=
>>>> --=0A=
>>>> 1.9.1=0A=
>>>>=0A=
>>>=0A=
> =0A=
> =0A=
=0A=
