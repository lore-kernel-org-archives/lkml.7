Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33FD20863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JJYJguRu";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="e31rE18z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCDJXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:23:31 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54618 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfCDJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:23:30 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x249MTAZ007246;
        Mon, 4 Mar 2019 01:23:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=AW6V265SWECPXXIFPaoP9+3psZqLbLtqSvnsrLG/WxY=;
 b=JJYJguRukZgeYEid+FIKZrA9HVsEQCffOgeQLgqyK6lBTNZoTa7sVXmXiDVcaQQrJ82w
 2Xkv4Joq8vj0Av7s7mq/Wki1K34K5RgZZRmAkxIHr1DH2l4US/+kox28sfkUufscbs9S
 +aYnRwvjAG+mMf8gUlB2IyHY0X+VkYR5Nhi7iAMynC1YIJQteixrgnL5FdtD+YouLjzr
 L0z1bAOmftNs92tefT/MhL2f6xLn43EOxBMjLrNfuMbUHb7aJmQxCeM3KZsNFTJhTV43
 qQU5QvEEf1aqun0I3PL85+4PYVwzcVR1Af8xeiqJERJI4/I6wTNezd277k9H7l+0QOpR QQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qyq8xy0va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 01:23:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW6V265SWECPXXIFPaoP9+3psZqLbLtqSvnsrLG/WxY=;
 b=e31rE18zjn/vrPVb8p9g5vTLA3qP51Pz7xbobrwWr8VcU8Isunl9jW1fDMxGgaeHX8NEYDkZvzJereZOdr7eWGwvEsKVf+rODwIbWdDgurufpGBqlVxKlnFK+MlDHb0s21x/wDGEGiQ5EQ2wFvSs6ThMJX82HTkqqMW9fT0HR1I=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5368.namprd07.prod.outlook.com (20.177.125.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 09:23:07 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::2dae:f6be:5a31:3bc8]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::2dae:f6be:5a31:3bc8%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 09:23:07 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v4 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v4 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUxJ4VnRX9klsPV0GCGU5zGXPUXqXnI4aAgBQLQeA=
Date:   Mon, 4 Mar 2019 09:23:07 +0000
Message-ID: <BYAPR07MB470940658CEB8885172EF896DD710@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
 <1550173514-23573-6-git-send-email-pawell@cadence.com>
 <20190219132403.GC20719@kroah.com>
In-Reply-To: <20190219132403.GC20719@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMWMwMThkNWEtM2U1Zi0xMWU5LTg3MzAtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDFjMDE4ZDViLTNlNWYtMTFlOS04NzMwLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjA0NDgiIHQ9IjEzMTk2MTY0OTg0NjkwNjQ0MSIgaD0iMHhKYjlnNy9sbGpLR0NML2drS1NJK1NMN2dZPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4084978-6949-43e6-eb4d-08d6a0830335
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5368;
x-ms-traffictypediagnostic: BYAPR07MB5368:
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5368;20:QoAAgfeD85zSloynP6H0G8vHbudZQpejOr+5tQ/m4+UwoU5UZjWNLPBrXICEOjF5W3TAe3o1ih2nKJtSedseAQ36/REYrlEqK0mlYDa8PF0amytkW1gJMppVgnc+DrDdiWbge9pWwIE8NSLxN+m4j1pFY/ykGtvmXnaqdBEQuwUHqfzh2vuaSM2AuTFFIPOu2xbagffwWnsEGQWdqISRuQgSXg+RitKSYAaG873jSdmU62VKlzx4tGNt7JTxGNyS
x-microsoft-antispam-prvs: <BYAPR07MB536847F630CFB7C9AD5949ABDD710@BYAPR07MB5368.namprd07.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(52314003)(36092001)(189003)(199004)(6506007)(6436002)(102836004)(4326008)(5660300002)(86362001)(26005)(71200400001)(71190400001)(14444005)(256004)(25786009)(3846002)(52536013)(229853002)(7696005)(30864003)(99286004)(55016002)(53936002)(6116002)(53946003)(2906002)(76176011)(6246003)(107886003)(9686003)(14454004)(446003)(106356001)(476003)(11346002)(8676002)(486006)(478600001)(105586002)(54906003)(81156014)(81166006)(97736004)(6916009)(8936002)(305945005)(7416002)(186003)(7736002)(66066001)(74316002)(316002)(33656002)(68736007)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5368;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rq3UtSFtxbY0SWEiR8akFZkAbvuhdiZBmJc/6MQrd/ioZW/o4+Wb9Kkva1m8E1IrKPVHgq9KNlegP/y3b4hy3wRl7wFopQKXb29WpDaBevfC1tww+ZfZ+kfxk/egvw3UZkyV/WArZV9rAppRvuVBHJenHYa1xBTzi/LfJ4dBeQVRNn4poL/h9GSEGx90ztIYL3QdrdXB/6crvs0Pe/dSsczh82mN6GxL7vO2Mg/NJWjJ/3weAmBYDWHpvU3uBFnNf8zMwFFJoLkqIRpxX42DlgzcA0JPLmlxHkW3cxl3Ly6JLqXCw8A/Za5v+qSX6nGRYKRcyKhisD1pJpaa6yv2bbUQDSSlsp9JXmxRg+buxpCHtOOCiYlDWfm+E3lnR488N5ffN6FvzEBoA0XjVL6Yjma5Ml6Lvv8l0LkCyjQJWHA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4084978-6949-43e6-eb4d-08d6a0830335
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 09:23:07.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5368
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

>
>On Thu, Feb 14, 2019 at 07:45:13PM +0000, Pawel Laszczak wrote:
>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>
>Nit, "Linux" :)
>
>> The Cadence USBSS DRD Driver is a highly configurable IP Core whichi
>
>"whichi"?
>
>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>> Host Only (XHCI)configurations.
>>
>> The current driver has been validated with FPGA burned. We have support
>
>I can not parse that sentance, sorry.  what does "with FPGA burned"
>mean?

I met with such sentence, and It's means that implementation (IP Core)=20
Is loaded to FPGA. Maybe it was used from some historical reason,=20
and nowadays it is not correct.=20

I will replace it with ".. which is used on FPGA prototyping."

>
>> for PCIe bus, which is used on FPGA prototyping.
>>
>> The host side of USBSS-DRD controller is compliance with XHCI
>
>"compliant"
>
>> specification, so it works with standard XHCI linux driver.
>
>"Linux"
>
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/Kconfig                |    2 +
>>  drivers/usb/Makefile               |    2 +
>>  drivers/usb/cdns3/Kconfig          |   44 +
>>  drivers/usb/cdns3/Makefile         |   14 +
>>  drivers/usb/cdns3/cdns3-pci-wrap.c |  155 +++
>>  drivers/usb/cdns3/core.c           |  403 ++++++
>>  drivers/usb/cdns3/core.h           |  116 ++
>>  drivers/usb/cdns3/debug.h          |  168 +++
>>  drivers/usb/cdns3/debugfs.c        |  164 +++
>>  drivers/usb/cdns3/drd.c            |  365 +++++
>>  drivers/usb/cdns3/drd.h            |  162 +++
>>  drivers/usb/cdns3/ep0.c            |  907 +++++++++++++
>>  drivers/usb/cdns3/gadget-export.h  |   28 +
>>  drivers/usb/cdns3/gadget.c         | 2003 ++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/gadget.h         | 1207 +++++++++++++++++
>>  drivers/usb/cdns3/host-export.h    |   28 +
>>  drivers/usb/cdns3/host.c           |   72 +
>>  drivers/usb/cdns3/trace.c          |   23 +
>>  drivers/usb/cdns3/trace.h          |  404 ++++++
>>  19 files changed, 6267 insertions(+)
>>  create mode 100644 drivers/usb/cdns3/Kconfig
>>  create mode 100644 drivers/usb/cdns3/Makefile
>>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>>  create mode 100644 drivers/usb/cdns3/core.c
>>  create mode 100644 drivers/usb/cdns3/core.h
>>  create mode 100644 drivers/usb/cdns3/debug.h
>>  create mode 100644 drivers/usb/cdns3/debugfs.c
>>  create mode 100644 drivers/usb/cdns3/drd.c
>>  create mode 100644 drivers/usb/cdns3/drd.h
>>  create mode 100644 drivers/usb/cdns3/ep0.c
>>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>>  create mode 100644 drivers/usb/cdns3/gadget.c
>>  create mode 100644 drivers/usb/cdns3/gadget.h
>>  create mode 100644 drivers/usb/cdns3/host-export.h
>>  create mode 100644 drivers/usb/cdns3/host.c
>>  create mode 100644 drivers/usb/cdns3/trace.c
>>  create mode 100644 drivers/usb/cdns3/trace.h
>>
>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>> index 987fc5ba6321..5f9334019d04 100644
>> --- a/drivers/usb/Kconfig
>> +++ b/drivers/usb/Kconfig
>> @@ -112,6 +112,8 @@ source "drivers/usb/usbip/Kconfig"
>>
>>  endif
>>
>> +source "drivers/usb/cdns3/Kconfig"
>> +
>>  source "drivers/usb/mtu3/Kconfig"
>>
>>  source "drivers/usb/musb/Kconfig"
>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
>> index 7d1b8c82b208..ab125b966cac 100644
>> --- a/drivers/usb/Makefile
>> +++ b/drivers/usb/Makefile
>> @@ -12,6 +12,8 @@ obj-$(CONFIG_USB_DWC3)		+=3D dwc3/
>>  obj-$(CONFIG_USB_DWC2)		+=3D dwc2/
>>  obj-$(CONFIG_USB_ISP1760)	+=3D isp1760/
>>
>> +obj-$(CONFIG_USB_CDNS3)		+=3D cdns3/
>> +
>>  obj-$(CONFIG_USB_MON)		+=3D mon/
>>  obj-$(CONFIG_USB_MTU3)		+=3D mtu3/
>>
>> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
>> new file mode 100644
>> index 000000000000..27cb3d8dbe3d
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/Kconfig
>> @@ -0,0 +1,44 @@
>> +config USB_CDNS3
>> +	tristate "Cadence USB3 Dual-Role Controller"
>> +	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
>> +	help
>> +	  Say Y here if your system has a cadence USB3 dual-role controller.
>> +	  It supports: dual-role switch, Host-only, and Peripheral-only.
>> +
>> +	  If you choose to build this driver is a dynamically linked
>> +	  as module, the module will be called cdns3.ko.
>> +
>> +if USB_CDNS3
>> +
>> +config USB_CDNS3_GADGET
>> +        bool "Cadence USB3 device controller"
>> +        depends on USB_GADGET
>> +        help
>> +          Say Y here to enable device controller functionality of the
>> +          cadence USBSS-DEV driver.
>> +
>> +          This controller supports FF, HS and SS mode. It doesn't suppo=
rt
>> +          LS and SSP mode.
>> +
>> +config USB_CDNS3_HOST
>> +        bool "Cadence USB3 host controller"
>> +        depends on USB_XHCI_HCD
>> +        help
>> +          Say Y here to enable host controller functionality of the
>> +          cadence driver.
>> +
>> +          Host controller is compliant with XHCI so it will use
>> +          standard XHCI driver.
>> +
>> +config USB_CDNS3_PCI_WRAP
>> +	tristate "Cadence USB3 support on PCIe-based platforms"
>> +	depends on USB_PCI && ACPI
>> +	default USB_CDNS3
>> +	help
>> +	  If you're using the USBSS Core IP with a PCIe, please say
>> +	  'Y' or 'M' here.
>> +
>> +	  If you choose to build this driver as module it will
>> +	  be dynamically linked and module will be called cdns3-pci.ko
>
>You use tabs here, but not tabs in the other options.  Please be
>uniform.
>
>
>> +
>> +endif
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> new file mode 100644
>> index 000000000000..8f9438593375
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -0,0 +1,14 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# define_trace.h needs to know how to find our header
>> +CFLAGS_trace.o				:=3D -I$(src)
>> +
>> +cdns3-y					:=3D core.o drd.o trace.o
>> +
>> +obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>> +ifneq ($(CONFIG_DEBUG_FS),)
>> +	cdns3-y				+=3D debugfs.o
>> +endif
>> +
>> +cdns3-$(CONFIG_USB_CDNS3_GADGET)	+=3D gadget.o ep0.o
>> +cdns3-$(CONFIG_USB_CDNS3_HOST)		+=3D host.o
>> +obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci-wrap.o
>> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns=
3-pci-wrap.c
>> new file mode 100644
>> index 000000000000..d0b2d3d9b983
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
>> @@ -0,0 +1,155 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence USBSS PCI Glue driver
>> + *
>> + * Copyright (C) 2018 Cadence.
>> + *
>> + * Author: Pawel Laszczak <pawell@cadence.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/slab.h>
>> +
>> +struct cdns3_wrap {
>> +	struct platform_device *plat_dev;
>> +	struct pci_dev *hg_dev;
>> +	struct resource dev_res[4];
>> +};
>> +
>> +struct cdns3_wrap wrap;
>> +
>> +#define RES_IRQ_ID		0
>> +#define RES_HOST_ID		1
>> +#define RES_DEV_ID		2
>> +#define RES_DRD_ID		3
>> +
>> +#define PCI_BAR_HOST		0
>> +#define PCI_BAR_DEV		2
>> +#define PCI_BAR_OTG		4
>> +
>> +#define PCI_DEV_FN_HOST_DEVICE	0
>> +#define PCI_DEV_FN_OTG		1
>> +
>> +#define PCI_DRIVER_NAME		"cdns3-pci-usbss"
>> +#define PLAT_DRIVER_NAME	"cdns-usb3"
>> +
>> +#define CDNS_VENDOR_ID 0x17cd
>
>PCI_VENDOR_ID_CDNS is already in pci_ids.h, no need to define it again
>here.
>
>> +#define CDNS_DEVICE_ID 0x0100
>
>No tabs?

Corrected.=20

>
>> +
>> +/**
>
>kerneldoc is great, but for static functions?  Who is pulling these into
>documentation?
>
>If not, then no need for that format at all.

I'm not sure I understood you correct.=20

Should I remove all static function description, or should change the
formatting style to avoid pulling description into documentation ?

For example in MTU3 driver witch is quite new I found:

"
/*
 * Set or clear the halt bit of an EP.
 * A halted EP won't TX/RX any data but will queue requests.
 */
static int mtu3_gadget_ep_set_halt(struct usb_ep *ep, int value)=20
"
Will it be correct if I change comment formatting from:
/**=20
  *
 */

Into=20
  /*
   *
   */

?

I ask because in this function the description is unnecessary, but in some =
other
static functions the comments could be helpful in understanding what functi=
on does.=20

Currently I have kerneldoc for many static function.=20

>> + * cdns3_pci_probe - Probe function for Cadence USB wrapper driver
>> + * @pdev: platform device object
>> + * @id: pci device id
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +static int cdns3_pci_probe(struct pci_dev *pdev,
>> +			   const struct pci_device_id *id)
>> +{
>> +	struct platform_device_info plat_info;
>> +	struct cdns3_wrap *wrap;
>> +	struct resource *res;
>> +	int err;
>> +
>> +	/*
>> +	 * for GADGET/HOST PCI (devfn) function number is 0,
>> +	 * for OTG PCI (devfn) function number is 1
>> +	 */
>> +	if (!id || pdev->devfn !=3D PCI_DEV_FN_HOST_DEVICE)
>> +		return -EINVAL;
>> +
>> +	err =3D pcim_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +	wrap =3D devm_kzalloc(&pdev->dev, sizeof(*wrap), GFP_KERNEL);
>> +	if (!wrap) {
>> +		dev_err(&pdev->dev, "Failed to allocate memory\n");
>
>No need to print an error again after kzalloc already printed an error.

Ok, I didn't know.=20

>
>> +		return -ENOMEM;
>
>Did you forget to disable the pci device?

Yes, I really forgot.=20

>> +	}
>> +
>> +	/* function 0: host(BAR_0) + device(BAR_1) + otg(BAR_2)). */
>> +	memset(wrap->dev_res, 0x00,
>> +	       sizeof(struct resource) * ARRAY_SIZE(wrap->dev_res));
>> +	dev_dbg(&pdev->dev, "Initialize Device resources\n");
>> +	res =3D wrap->dev_res;
>> +
>> +	res[RES_DEV_ID].start =3D pci_resource_start(pdev, PCI_BAR_DEV);
>> +	res[RES_DEV_ID].end =3D   pci_resource_end(pdev, PCI_BAR_DEV);
>> +	res[RES_DEV_ID].name =3D "dev";
>> +	res[RES_DEV_ID].flags =3D IORESOURCE_MEM;
>> +	dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
>> +		&res[RES_DEV_ID].start);
>> +
>> +	res[RES_HOST_ID].start =3D pci_resource_start(pdev, PCI_BAR_HOST);
>> +	res[RES_HOST_ID].end =3D pci_resource_end(pdev, PCI_BAR_HOST);
>> +	res[RES_HOST_ID].name =3D "xhci";
>> +	res[RES_HOST_ID].flags =3D IORESOURCE_MEM;
>> +	dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
>> +		&res[RES_HOST_ID].start);
>> +
>> +	res[RES_DRD_ID].start =3D pci_resource_start(pdev, PCI_BAR_OTG);
>> +	res[RES_DRD_ID].end =3D   pci_resource_end(pdev, PCI_BAR_OTG);
>> +	res[RES_DRD_ID].name =3D "otg";
>> +	res[RES_DRD_ID].flags =3D IORESOURCE_MEM;
>> +	dev_dbg(&pdev->dev, "USBSS-DRD physical base addr: %pa\n",
>> +		&res[RES_DRD_ID].start);
>> +
>> +	/* Interrupt common for both device and XHCI */
>> +	wrap->dev_res[RES_IRQ_ID].start =3D pdev->irq;
>> +	wrap->dev_res[RES_IRQ_ID].name =3D "cdns3-irq";
>> +	wrap->dev_res[RES_IRQ_ID].flags =3D IORESOURCE_IRQ;
>> +
>> +	/* set up platform device info */
>> +	memset(&plat_info, 0, sizeof(plat_info));
>> +	plat_info.parent =3D &pdev->dev;
>> +	plat_info.fwnode =3D pdev->dev.fwnode;
>> +	plat_info.name =3D PLAT_DRIVER_NAME;
>> +	plat_info.id =3D pdev->devfn;
>> +	plat_info.res =3D wrap->dev_res;
>> +	plat_info.num_res =3D ARRAY_SIZE(wrap->dev_res);
>> +	plat_info.dma_mask =3D pdev->dma_mask;
>> +
>> +	/* register platform device */
>> +	wrap->plat_dev =3D platform_device_register_full(&plat_info);
>> +	if (IS_ERR(wrap->plat_dev))
>> +		return PTR_ERR(wrap->plat_dev);
>
>No disabling of the device?
>
>Anyway, why are you creating a platform device when you have a real PCI
>device?  That seems odd, and an abuse of the platform code.  What's
>wrong with your real PCI device here?

I use PCI platform, but the most our customers use this driver as platform=
=20
driver.=20
The second reason was that we use  different PCI configuration, and some of=
 them=20
makes it impossible to use DRD driver as single driver.  For example PCI fu=
nction
0 contains Device/Host register, and PCI function 1 contains OTG register.=
=20

>
>
>> +
>> +	pci_set_drvdata(pdev, wrap);
>> +
>> +	return err;
>> +}
>> +
>> +void cdns3_pci_remove(struct pci_dev *pdev)
>> +{
>> +	struct cdns3_wrap *wrap =3D (struct cdns3_wrap *)pci_get_drvdata(pdev)=
;
>> +
>> +	platform_device_unregister(wrap->plat_dev);
>> +}
>> +
>> +static const struct pci_device_id cdns3_pci_ids[] =3D {
>> +	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
>> +	{ 0, }
>> +};
>> +
>> +static struct pci_driver cdns3_pci_driver =3D {
>> +	.name =3D PCI_DRIVER_NAME,
>> +	.id_table =3D cdns3_pci_ids,
>> +	.probe =3D cdns3_pci_probe,
>> +	.remove =3D cdns3_pci_remove,
>> +};
>> +
>> +module_pci_driver(cdns3_pci_driver);
>> +MODULE_DEVICE_TABLE(pci, cdns3_pci_ids);
>> +
>> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Cadence USBSS PCI wrapperr");
>> +
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> new file mode 100644
>> index 000000000000..aa2f63241dab
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -0,0 +1,403 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence USBSS DRD Driver.
>> + *
>> + * Copyright (C) 2018 Cadence.
>> + * Copyright (C) 2017-2018 NXP
>> + *
>> + * Author: Peter Chen <peter.chen@nxp.com>
>> + *         Pawel Laszczak <pawell@cadence.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include "gadget.h"
>> +#include "core.h"
>> +#include "host-export.h"
>> +#include "gadget-export.h"
>> +#include "drd.h"
>> +#include "debug.h"
>> +
>> +static inline
>> +struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *c=
dns)
>> +{
>> +	WARN_ON(cdns->role >=3D CDNS3_ROLE_END || !cdns->roles[cdns->role]);
>
>What is someone supposed to do with this?
>

Generally such concept was created by Peter Chan. He has different platform=
.=20
Some time ago he wrote:=20
"The current version of this IP has some issues to detect vbus status corre=
ctly,
we have to force vbus status accordingly, so we need a status to indicate
vbus disconnection, and add some code to let controller know vbus
removal, in that case, the controller's state machine can be correct.
So, we increase one role 'CDNS3_ROLE_END' to for this purpose.

CDNS3_ROLE_GADGET: gadget mode and VBUS on
CDNS3_ROLE_HOST: host mode and VBUS on
CDNS3_ROLE_END: VBUS off, eg either host or device cable on the port.

So, we may start role from CDNS3_ROLE_END at probe when nothing is connecte=
d,
and need to set role as CDNS3_ROLE_END at ->stop for further handling at
role switch routine. "

So It's looks like this third state is necessary for his platform and role =
=3D=3D CDNS3_ROLE_END
is possible but role > CDNS3_ROLE_END is not possible.  I know that I could=
 remove this=20
from code, but I want to be compatible with Peter Chan platform as much as =
possible.=20
As far as I know, his platform specific code will be upstreaming in the fut=
ure.=20

>> +	return cdns->roles[cdns->role];
>> +}
>> +
>> +static int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
>> +{
>> +	int ret;
>> +
>> +	if (WARN_ON(role >=3D CDNS3_ROLE_END))
>
>Same here, how can this happen?  What can I do if it does?

>
>> +		return 0;
>> +
>> +	if (!cdns->roles[role])
>> +		return -ENXIO;
>> +
>> +	if (cdns->roles[role]->state =3D=3D CDNS3_ROLE_STATE_ACTIVE)
>> +		return 0;
>> +
>> +	mutex_lock(&cdns->mutex);
>> +	cdns->role =3D role;
>> +	ret =3D cdns->roles[role]->start(cdns);
>> +	if (!ret)
>> +		cdns->roles[role]->state =3D CDNS3_ROLE_STATE_ACTIVE;
>> +	mutex_unlock(&cdns->mutex);
>> +	return ret;
>> +}
>> +
>> +void cdns3_role_stop(struct cdns3 *cdns)
>> +{
>> +	enum cdns3_roles role =3D cdns->role;
>> +
>> +	if (role >=3D CDNS3_ROLE_END) {
>> +		WARN_ON(role > CDNS3_ROLE_END);
>
>Again, why?
>
>> +		return;
>> +	}
>> +
>> +	if (cdns->roles[role]->state =3D=3D CDNS3_ROLE_STATE_INACTIVE)
>> +		return;
>> +
>> +	mutex_lock(&cdns->mutex);
>> +	cdns->roles[role]->stop(cdns);
>> +	cdns->roles[role]->state =3D CDNS3_ROLE_STATE_INACTIVE;
>> +	mutex_unlock(&cdns->mutex);
>> +}
>> +
>> +/*
>> + * cdns->role gets from cdns3_get_initial_role, and this API tells role=
 at the
>> + * runtime.
>> + * If both roles are supported, the role is selected based on vbus/id.
>> + * It could be read from OTG register or external connector.
>> + * If only single role is supported, only one role structure
>> + * is allocated, cdns->roles[CDNS3_ROLE_HOST] or cdns->roles[CDNS3_ROLE=
_GADGET].
>> + */
>> +static enum cdns3_roles cdns3_get_initial_role(struct cdns3 *cdns)
>> +{
>> +	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
>> +		if (cdns3_is_host(cdns))
>> +			return CDNS3_ROLE_HOST;
>> +		if (cdns3_is_device(cdns))
>> +			return CDNS3_ROLE_GADGET;
>> +	}
>> +	return cdns->roles[CDNS3_ROLE_HOST]
>> +		? CDNS3_ROLE_HOST
>> +		: CDNS3_ROLE_GADGET;
>> +}
>> +
>> +static void cdns3_exit_roles(struct cdns3 *cdns)
>> +{
>> +	cdns3_role_stop(cdns);
>> +	cdns3_drd_exit(cdns);
>> +}
>> +
>> +/**
>> + * cdns3_core_init_role - initialize role of operation
>> + * @cdns: Pointer to cdns3 structure
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +static int cdns3_core_init_role(struct cdns3 *cdns)
>> +{
>> +	struct device *dev =3D cdns->dev;
>> +	enum usb_dr_mode best_dr_mode;
>> +	enum usb_dr_mode dr_mode;
>> +	int ret =3D 0;
>> +
>> +	dr_mode =3D usb_get_dr_mode(dev);
>> +	cdns->role =3D CDNS3_ROLE_END;
>> +
>> +	/*
>> +	 * If driver can't read mode by means of usb_get_dr_mdoe function then
>> +	 * chooses mode according with Kernel configuration. This setting
>> +	 * can be restricted later depending on strap pin configuration.
>> +	 */
>> +	if (dr_mode =3D=3D USB_DR_MODE_UNKNOWN) {
>> +		if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
>> +		    IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
>> +			dr_mode =3D USB_DR_MODE_OTG;
>> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
>> +			dr_mode =3D USB_DR_MODE_HOST;
>> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
>> +			dr_mode =3D USB_DR_MODE_PERIPHERAL;
>> +	}
>> +
>> +	best_dr_mode =3D USB_DR_MODE_OTG;
>> +
>> +	if (dr_mode =3D=3D USB_DR_MODE_OTG) {
>> +		best_dr_mode =3D cdns->dr_mode;
>> +	} else if (cdns->dr_mode =3D=3D USB_DR_MODE_OTG) {
>> +		best_dr_mode =3D dr_mode;
>> +	} else if (cdns->dr_mode !=3D dr_mode) {
>> +		dev_err(dev, "Incorrect DRD configuration\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dr_mode =3D best_dr_mode;
>> +
>> +	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST)=
 {
>> +		ret =3D cdns3_host_init(cdns);
>> +		if (ret) {
>> +			dev_err(dev, "Host initialization failed with %d\n",
>> +				ret);
>> +			goto err;
>> +		}
>> +	}
>> +
>> +	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_PERIP=
HERAL) {
>> +		ret =3D cdns3_gadget_init(cdns);
>> +		if (ret) {
>> +			dev_err(dev, "Device initialization failed with %d\n",
>> +				ret);
>> +			goto err;
>
>Do you clean up from the host init here properly?   It's hard to tell.

Driver doesn't have to clean anything here from cdns3_host_init.
=20
>
>> +		}
>> +	}
>> +
>> +	cdns->desired_dr_mode =3D dr_mode;
>> +	cdns->dr_mode =3D dr_mode;
>> +	/*
>> +	 * dr_mode could be change so DRD must update controller
>> +	 * configuration
>> +	 */
>> +	ret =3D cdns3_drd_update_mode(cdns);
>> +	if (ret)
>> +		goto err;
>> +
>> +	cdns->role =3D cdns3_get_initial_role(cdns);
>> +
>> +	ret =3D cdns3_role_start(cdns, cdns->role);
>> +	if (ret) {
>> +		dev_err(dev, "can't start %s role\n",
>> +			cdns3_get_current_role_driver(cdns)->name);
>> +		goto err;
>> +	}
>> +
>> +	return ret;
>> +err:
>> +	cdns3_exit_roles(cdns);
>> +	return ret;
>> +}
>
>thanks,
>
>greg k-h

Thanks=20
Pawel
