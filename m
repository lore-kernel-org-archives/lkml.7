Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1568C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB3020854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dif9eQCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCRKiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:38:21 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:48659 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfCRKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:38:20 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190318103817epoutp022af608535eb64b1ce9bf97015befc187~NB1KPLyzp2824828248epoutp02M
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:38:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190318103817epoutp022af608535eb64b1ce9bf97015befc187~NB1KPLyzp2824828248epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552905497;
        bh=gOfzhcozWYbOwdysz4P+DuY6GpKbZ+TcqStDTbQRyI4=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=dif9eQCWYg6LcbYuR+0azlMlggoh3BzoYObVMo35YiLDMZ3/ZHvOvVWC6KxXUgkdd
         4P1DbqzZb36JmrBCXjeYhIEITyI4JIo1NIYUZSDAM7h4tERzyyVp31pbgmm7djkeoZ
         /lhlkXt+3wLjgy3i8dGZI1ndz7O2ZrGnQn+QSnyQ=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190318103814epcas1p49e8f789f6ae6af61732b110ccfc70d4e~NB1HIPBaF0091100911epcas1p4Y;
        Mon, 18 Mar 2019 10:38:14 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.88.04108.6157F8C5; Mon, 18 Mar 2019 19:38:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190318103813epcas1p4225a5ccadee8c1fca012b1b3a61d57ca~NB1GtHlFD2273322733epcas1p4n;
        Mon, 18 Mar 2019 10:38:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190318103813epsmtrp141b9837bf1cec7154b819d79201a3fca~NB1GsbODY1129211292epsmtrp1S;
        Mon, 18 Mar 2019 10:38:13 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-64-5c8f7516c008
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.E1.03662.5157F8C5; Mon, 18 Mar 2019 19:38:13 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190318103813epsmtip2437f48719dfb1d556d26eddad6840b89~NB1GgTFaV0720507205epsmtip2n;
        Mon, 18 Mar 2019 10:38:13 +0000 (GMT)
Subject: Re: [PATCH v1 2/2] extcon: mrfld: Introduce extcon driver for Basin
 Cove PMIC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3af26666-8913-c8bb-d2fb-64bd9ea0ec69@samsung.com>
Date:   Mon, 18 Mar 2019 19:38:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318101109.GP9224@smile.fi.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmrq5YaX+MQcNqQYvepulMFm+OA4nL
        u+awWdxuXMHmwOIx72Sgx/t9V9k8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91WyTs4
        3jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKOSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4
        xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITvj04XqgkkJFQs3fGNuYOz262Lk5JAQ
        MJE4fHwdSxcjF4eQwA5GiWlT3zNBOJ8YJc5POMEKUiUk8I1RYlWvKkzHxp5eVoiivYwSNz8d
        gnLeM0q0LF/DDlIlLBAh8XTDJTaQhIjAckaJp3eWgCXYBLQk9r+4wQZi8wsoSlz98ZgRxOYV
        sJNY2neJBcRmEVCVONZ/F6xeFGjQ+6e7WSBqBCVOznwCZnMKmEvs6H0MZjMLiEvcejKfCcKW
        l2jeOpsZ4tQDbBKX+gsgbBeJadO3MEHYwhKvjm9hh7ClJF72t0HZ1RIrTx4BO1pCoINRYsv+
        C6wQCWOJ/UsnAzVzAC3QlFi/Sx9iF5/Eu689rCBhCQFeiY42IYhqZYnLD+5CrZKUWNzeyQZh
        e0h8vredERJYLUwS52bvY5zAqDALyWuzkLwzC8k7sxA2L2BkWcUollpQnJueWmxYYIoc25sY
        walRy3IH47FzPocYBTgYlXh4G6b0xQixJpYVV+YeYpTgYFYS4bX37I8R4k1JrKxKLcqPLyrN
        SS0+xGgKDPmJzFKiyfnAtJ1XEm9oamRsbGxhYmhmamioJM673sE5RkggPbEkNTs1tSC1CKaP
        iYNTqoFx+Yoil/SjJnk3li54vrlvV33rh9e3vzwPuXrx2Mzl/7+aLH+z373kV9yFlVu6ys/d
        mLdre77h5wzR/JwVLH7Rov/lr8zK9hJOP7mW9bFWWk5Lr3th771X887/fu986mK4xbdbM6xP
        /Aid3p/evOmmdoRqw7EY9SMaVxUvX+v+sb95WmeH8YfPqUosxRmJhlrMRcWJAPHsJUKjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK5oaX+MQdMTA4vepulMFm+OA4nL
        u+awWdxuXMHmwOIx72Sgx/t9V9k8+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK+PTheqCSQkV
        Czd8Y25g7PbrYuTkkBAwkdjY08vaxcjFISSwm1GieVcTO0RCUmLaxaPMXYwcQLawxOHDxRA1
        bxklTp+axQRSIywQIfF0wyU2kISIwHJGicfnFrFDVLUwSfx7sYkNpIpNQEti/4sbYDa/gKLE
        1R+PGUFsXgE7iaV9l1hAbBYBVYlj/XfBNosCTb178QULRI2gxMmZT8BsTgFziR29j8FsZgF1
        iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFR
        Xmq5XnFibnFpXrpecn7uJkZwNGhp7WA8cSL+EKMAB6MSD++NaX0xQqyJZcWVuYcYJTiYlUR4
        7T37Y4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwBtRM
        P66yxfv1pz2Va6quLw6Kjr6wdN3vBX0T1KZntbNKeNkK89cWLK0pX5p6hXOr6kaN0/pO2838
        lXmCt93LELtfJXDvrX77s6OsfOGrg/hu1Kw6a2HsL5TuIcEttqxCo+Z92pYZ7qe64ozfMmnH
        Xn5i0rQ7eJv07fbr1/dsfJf0in3eYzUOJZbijERDLeai4kQADkaSh4ICAAA=
X-CMS-MailID: 20190318103813epcas1p4225a5ccadee8c1fca012b1b3a61d57ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190318101117epcas2p246ba2571549569d1ce18b829d6579bd3
References: <20190318095225.69200-1-andriy.shevchenko@linux.intel.com>
        <20190318095225.69200-2-andriy.shevchenko@linux.intel.com>
        <CGME20190318101117epcas2p246ba2571549569d1ce18b829d6579bd3@epcas2p2.samsung.com>
        <20190318101109.GP9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for comment. I add my comments
and then you have to rebase it on latest v5.0-rc1
because the merge conflict happen on v5.0-rc1.

On 19. 3. 18. 오후 7:11, Andy Shevchenko wrote:
> On Mon, Mar 18, 2019 at 12:52:25PM +0300, Andy Shevchenko wrote:
>> TBD
> 
> Oops.
> I though I have written it already.
> 
> I will wait for other comments today and sent a new version with commit message
> filled as follows:
> 
> On Intel Merrifield the Basin Cove PMIC provides a feature to detect
> the USB connection type. This driver utilizes the feature in order to support
> the USB dual role detection.
> 
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/extcon/Kconfig              |   7 +
>>  drivers/extcon/Makefile             |   1 +
>>  drivers/extcon/extcon-intel-mrfld.c | 256 ++++++++++++++++++++++++++++
>>  3 files changed, 264 insertions(+)
>>  create mode 100644 drivers/extcon/extcon-intel-mrfld.c
>>
>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>> index 8e17149655f0..75349c6cc89e 100644
>> --- a/drivers/extcon/Kconfig
>> +++ b/drivers/extcon/Kconfig
>> @@ -60,6 +60,13 @@ config EXTCON_INTEL_CHT_WC
>>  	  Say Y here to enable extcon support for charger detection / control
>>  	  on the Intel Cherrytrail Whiskey Cove PMIC.
>>  
>> +config EXTCON_INTEL_MRFLD
> 
>> +	tristate "Intel MErrifield Basin Cove PMIC extcon driver"
> 
> ME -> Me (will be fixed)
> 
>> +	depends on INTEL_SOC_PMIC_MRFLD

This driver uses the regmap interface. So, you better to add
following dependency?
- select REGMAP_I2C or REGMAP_SPI

But, if 'INTEL_SOC_PMIC_MRFLE' selects already REGMAP_*
configuration. It is not necessary.

>> +	help
>> +	  Say Y here to enable extcon support for charger detection / control
>> +	  on the Intel Merrifiel Basin Cove PMIC.

What is correct word?
- Merrifield? is used on above
- Merrifiel?


>> +
>>  config EXTCON_MAX14577
>>  	tristate "Maxim MAX14577/77836 EXTCON Support"
>>  	depends on MFD_MAX14577
>> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
>> index 261ce4cfe209..d3941a735df3 100644
>> --- a/drivers/extcon/Makefile
>> +++ b/drivers/extcon/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
>>  obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
>>  obj-$(CONFIG_EXTCON_INTEL_INT3496) += extcon-intel-int3496.o
>>  obj-$(CONFIG_EXTCON_INTEL_CHT_WC) += extcon-intel-cht-wc.o
>> +obj-$(CONFIG_EXTCON_INTEL_MRFLD) += extcon-intel-mrfld.o
>>  obj-$(CONFIG_EXTCON_MAX14577)	+= extcon-max14577.o
>>  obj-$(CONFIG_EXTCON_MAX3355)	+= extcon-max3355.o
>>  obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
>> diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
>> new file mode 100644
>> index 000000000000..d45db4975b5f
>> --- /dev/null
>> +++ b/drivers/extcon/extcon-intel-mrfld.c
>> @@ -0,0 +1,256 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Extcon driver for Basin Cove PMIC
>> + *
>> + * Copyright (c) 2018, Intel Corporation.
> 
> 2019 I suppose :-)

Right.

> 
>> + * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> + */
>> +
>> +#include <linux/extcon-provider.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mfd/intel_soc_pmic.h>
>> +#include <linux/mfd/intel_soc_pmic_mrfld.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "extcon-intel.h"
>> +
>> +#define BCOVE_USBIDCTRL			0x19
>> +#define BCOVE_USBIDCTRL_ID		BIT(0)
>> +#define BCOVE_USBIDCTRL_ACA		BIT(1)
>> +#define BCOVE_USBIDCTRL_ALL	(BCOVE_USBIDCTRL_ID | BCOVE_USBIDCTRL_ACA)
>> +
>> +#define BCOVE_USBIDSTS			0x1a
>> +#define BCOVE_USBIDSTS_GND		BIT(0)
>> +#define BCOVE_USBIDSTS_RARBRC_MASK	GENMASK(2, 1)
>> +#define BCOVE_USBIDSTS_RARBRC_SHIFT	1
>> +#define BCOVE_USBIDSTS_NO_ACA		0
>> +#define BCOVE_USBIDSTS_R_ID_A		1
>> +#define BCOVE_USBIDSTS_R_ID_B		2
>> +#define BCOVE_USBIDSTS_R_ID_C		3
>> +#define BCOVE_USBIDSTS_FLOAT		BIT(3)
>> +#define BCOVE_USBIDSTS_SHORT		BIT(4)
>> +
>> +#define BCOVE_CHGRIRQ_ALL	(BCOVE_CHGRIRQ_VBUSDET | BCOVE_CHGRIRQ_DCDET | \
>> +				 BCOVE_CHGRIRQ_BATTDET | BCOVE_CHGRIRQ_USBIDDET)
>> +
>> +#define BCOVE_CHGRCTRL0			0x4b
>> +#define BCOVE_CHGRCTRL0_CHGRRESET	BIT(0)
>> +#define BCOVE_CHGRCTRL0_EMRGCHREN	BIT(1)
>> +#define BCOVE_CHGRCTRL0_EXTCHRDIS	BIT(2)
>> +#define BCOVE_CHGRCTRL0_SWCONTROL	BIT(3)
>> +#define BCOVE_CHGRCTRL0_TTLCK		BIT(4)
>> +#define BCOVE_CHGRCTRL0_BIT_5		BIT(5)
>> +#define BCOVE_CHGRCTRL0_BIT_6		BIT(6)
>> +#define BCOVE_CHGRCTRL0_CHR_WDT_NOKICK	BIT(7)
>> +
>> +struct mrfld_extcon_data {
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	struct extcon_dev *edev;
>> +	unsigned int status;
>> +	unsigned int id;
>> +};
>> +
>> +static const unsigned int mrfld_extcon_cable[] = {
>> +	EXTCON_USB,
>> +	EXTCON_USB_HOST,
>> +	EXTCON_CHG_USB_SDP,
>> +	EXTCON_CHG_USB_CDP,
>> +	EXTCON_CHG_USB_DCP,
>> +	EXTCON_CHG_USB_ACA,
>> +	EXTCON_NONE,
>> +};
>> +
>> +static int mrfld_extcon_clear(struct mrfld_extcon_data *data, unsigned int reg,
>> +			      unsigned int mask)
>> +{
>> +	return regmap_update_bits(data->regmap, reg, mask, 0x00);
>> +}
>> +
>> +static int mrfld_extcon_set(struct mrfld_extcon_data *data, unsigned int reg,
>> +			    unsigned int mask)
>> +{
>> +	return regmap_update_bits(data->regmap, reg, mask, 0xff);
>> +}

mrfld_extcon_clear() and mrfld_extcon_set() are just wrapper function
for regmap interface. I think that you better to define
the meaningful defintion for '0x00' and '0xff' as following:

(just example, you may make the more correct name)
#define INTEL_MRFLD_RESET	0x00
#define INTEL_MRFLD_SET		0xff

And then you better to use the 'regmap_update_bits()' function
directly instead of mrfld_extcon_clear/set'.

Also, you should handle the exception hanlding when using regmap function.

>> +
>> +static int mrfld_extcon_get_id(struct mrfld_extcon_data *data)
>> +{
>> +	struct regmap *regmap = data->regmap;
>> +	unsigned int id;
>> +	bool ground;
>> +	int ret;
>> +
>> +	ret = regmap_read(regmap, BCOVE_USBIDSTS, &id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (id & BCOVE_USBIDSTS_FLOAT)
>> +		return INTEL_USB_ID_FLOAT;
>> +
>> +	switch ((id & BCOVE_USBIDSTS_RARBRC_MASK) >> BCOVE_USBIDSTS_RARBRC_SHIFT) {
>> +	case BCOVE_USBIDSTS_R_ID_A:
>> +		return INTEL_USB_RID_A;
>> +	case BCOVE_USBIDSTS_R_ID_B:
>> +		return INTEL_USB_RID_B;
>> +	case BCOVE_USBIDSTS_R_ID_C:
>> +		return INTEL_USB_RID_C;

Please add 'default' statement for exception handling.

>> +	}
>> +
>> +	/*
>> +	 * PMIC A0 reports USBIDSTS_GND = 1 for ID_GND,
>> +	 * but PMIC B0 reports USBIDSTS_GND = 0 for ID_GND.
>> +	 * Thus we must check this bit at last.
>> +	 */
>> +	ground = id & BCOVE_USBIDSTS_GND;
>> +	switch ('A' + BCOVE_MAJOR(data->id)) {
>> +	case 'A':
>> +		return ground ? INTEL_USB_ID_GND : INTEL_USB_ID_FLOAT;
>> +	case 'B':
>> +		return ground ? INTEL_USB_ID_FLOAT : INTEL_USB_ID_GND;
>> +	}
>> +
>> +	/* Unknown or unsupported type */
>> +	return INTEL_USB_ID_FLOAT;
>> +}
>> +
>> +static int mrfld_extcon_role_detect(struct mrfld_extcon_data *data)
>> +{
>> +	unsigned int id;
>> +	bool usb_host;
>> +	int ret;>> +
>> +	ret = mrfld_extcon_get_id(data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	id = ret;
>> +
>> +	usb_host = (id == INTEL_USB_ID_GND) || (id == INTEL_USB_RID_A);
>> +	extcon_set_state_sync(data->edev, EXTCON_USB_HOST, usb_host);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mrfld_extcon_cable_detect(struct mrfld_extcon_data *data)
>> +{
>> +	struct regmap *regmap = data->regmap;
>> +	unsigned int status;
>> +	int ret;
>> +
>> +	/*
>> +	 * It seems SCU firmware clears the content of BCOVE_CHGRIRQ1
>> +	 * and makes it useless for OS. Instead we compare a previously
>> +	 * stored status to the current one, provided by BCOVE_SCHGRIRQ1.
>> +	 */
>> +	ret = regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!(status ^ data->status))
>> +		return -ENODATA;
>> +
>> +	if ((status ^ data->status) & BCOVE_CHGRIRQ_USBIDDET)
>> +		ret = mrfld_extcon_role_detect(data);
This line gets the return value from mrfld_extcon_role_detect(data)
without any error handling and then the below line just saves 'status'
to 'data->status' regardless of 'ret' value.

I think that you have to handle the error case of
'ret = mrfld_extcon_role_detect(data)'.

>> +
>> +	data->status = status;

nitpick. better to add one blank line.

>> +	return ret;
>> +}
>> +
>> +static irqreturn_t mrfld_extcon_interrupt(int irq, void *dev_id)
>> +{
>> +	struct mrfld_extcon_data *data = dev_id;
>> +	int ret;
>> +
>> +	ret = mrfld_extcon_cable_detect(data);
>> +
>> +	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
>> +
>> +	return ret ? IRQ_NONE: IRQ_HANDLED;
>> +}
>> +
>> +static int mrfld_extcon_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
>> +	struct regmap *regmap = pmic->regmap;
>> +	struct mrfld_extcon_data *data;
>> +	unsigned int id;
>> +	int irq, ret;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->dev = dev;
>> +	data->regmap = regmap;
>> +
>> +	data->edev = devm_extcon_dev_allocate(dev, mrfld_extcon_cable);
>> +	if (IS_ERR(data->edev))
>> +		return -ENOMEM;
>> +
>> +	ret = devm_extcon_dev_register(dev, data->edev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "can't register extcon device: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_request_threaded_irq(dev, irq, NULL, mrfld_extcon_interrupt,
>> +					IRQF_ONESHOT | IRQF_SHARED, pdev->name,
>> +					data);
>> +	if (ret)
>> +		return ret;

You better add the error log with dev_err.

>> +
>> +	ret = regmap_read(regmap, BCOVE_ID, &id);
>> +	if (ret)
>> +		return ret;

ditto for error log.

>> +
>> +	data->id = id;
>> +
>> +	mrfld_extcon_set(data, BCOVE_CHGRCTRL0, BCOVE_CHGRCTRL0_SWCONTROL);
>> +
>> +	/* Get initial state */
>> +	mrfld_extcon_role_detect(data);

Please handle the return value for exception handling with log.

>> +
>> +	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
>> +	mrfld_extcon_clear(data, BCOVE_MCHGRIRQ1, BCOVE_CHGRIRQ_ALL);
>> +
>> +	mrfld_extcon_set(data, BCOVE_USBIDCTRL, BCOVE_USBIDCTRL_ALL);
>> +
>> +	platform_set_drvdata(pdev, data);

nitpick. better to add one blank line.

>> +	return 0;
>> +}
>> +
>> +static int mrfld_extcon_remove(struct platform_device *pdev)
>> +{
>> +	struct mrfld_extcon_data *data = platform_get_drvdata(pdev);
>> +
>> +	mrfld_extcon_clear(data, BCOVE_CHGRCTRL0, BCOVE_CHGRCTRL0_SWCONTROL);

nitpick. better to add one blank line.

>> +	return 0;
>> +}
>> +
>> +static const struct platform_device_id mrfld_extcon_id_table[] = {
>> +	{ .name = "mrfld_bcove_extcon" },

I think that it is not proper to use 'extcon' word for the compatible name
because 'extcon' word is linuxium. So, I recommend that you remove
the 'extcon' word. Instead, you better to use new word related to h/w.

>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(platform, mrfld_extcon_id_table);
>> +
>> +static struct platform_driver mrfld_extcon_driver = {
>> +	.driver = {
>> +		.name	= KBUILD_MODNAME,

Where is the definition of KBUILD_MODNAME? Are you missing?

>> +	},
>> +	.probe		= mrfld_extcon_probe,
>> +	.remove		= mrfld_extcon_remove,
>> +	.id_table	= mrfld_extcon_id_table,
>> +};
>> +module_platform_driver(mrfld_extcon_driver);
>> +
>> +MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
>> +MODULE_DESCRIPTION("Extcon driver for Basin Cove PMIC");

Add the 'Merrifield' word in front of 'Basin Cove PMIC' as following:
- Merrifield Basic Cove PMIC

>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.20.1
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
