Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF95020850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QVyAKu/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCRKuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:50:19 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40098 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCRKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:50:18 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190318105016epoutp0107363d9f216880af89e1ba2f784a74a3~NB-nWthvy3044530445epoutp010
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:50:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190318105016epoutp0107363d9f216880af89e1ba2f784a74a3~NB-nWthvy3044530445epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552906216;
        bh=TFLYQENZy2kRab2JU9rpArZMUlYi1hEEW7nNGxotQbE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=QVyAKu/FvhDw4HitvcesnV3AQsum6oijcHBFs0uyNhKFjRuK+r0fRGg66yBJa7HO9
         yEEVFbQiiB82DFZ1keYR8gRUcIrbKClxupKCbUPX+IKsbZdZ+1I55+wC2GfaPdsAJv
         VB6imrnEbN0WyJ8sliczkU36s0sofW3fNkdGcwco=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190318105013epcas1p270b6860e487319727aba7dfc80c3b585~NB-kjXOLw0431904319epcas1p2q;
        Mon, 18 Mar 2019 10:50:13 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.BD.04257.0E77F8C5; Mon, 18 Mar 2019 19:50:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190318105007epcas1p4bfb1dbdd37a59aa285f2736177440180~NB-fe7UBV2579725797epcas1p4r;
        Mon, 18 Mar 2019 10:50:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190318105007epsmtrp276d26cf7b0bd13893a8eae1c7491c6eb~NB-fePt0F1815718157epsmtrp2y;
        Mon, 18 Mar 2019 10:50:07 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-84-5c8f77e0c199
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.82.03662.FD77F8C5; Mon, 18 Mar 2019 19:50:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190318105007epsmtip15cf17551a4b312dbe36e04f6ba9734f5~NB-fU9Zxz1670916709epsmtip1Y;
        Mon, 18 Mar 2019 10:50:07 +0000 (GMT)
Subject: Re: [PATCH v1 2/2] extcon: mrfld: Introduce extcon driver for Basin
 Cove PMIC
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Organization: Samsung Electronics
Message-ID: <6061c134-e322-45d6-96bc-4ad8b2ae8455@samsung.com>
Date:   Mon, 18 Mar 2019 19:50:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3af26666-8913-c8bb-d2fb-64bd9ea0ec69@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmnu6D8v4Yg5/fhC16m6YzWbw5DiQu
        75rDZnG7cQWbA4vHvJOBHu/3XWXz6NuyitHj8ya5AJaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoI1KCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
        Elul1IKUnALLAr3ixNzi0rx0veT8XCtDAwMjU6DChOyMc8cPshe8TqnY8eIiewPjv8AuRk4O
        CQETiVVf1rB1MXJxCAnsYJRYem8nC4TziVHi05fpjBDON0aJ+61fWGBadrUcgqrayygx78JS
        qKr3jBKvjlxlBKkSFoiQeLrhEhuIzSagJbH/xQ2wJSICyxklnt5Zwg6S4BdQlLj64zFYA6+A
        nUT7hT9MIDaLgKrE9gsbwOKiQIPeP93NAlEjKHFy5hMwm1PAXmLmnudgC5gFxCVuPZnPBGHL
        SzRvnc0MskxC4ACbxIN5Z9kg7naReHXwBzOELSzx6vgWdghbSuLzu71QNdUSK08eYYNo7mCU
        2LL/AitEwlhi/9LJQBs4gDZoSqzfpQ+xjE/i3dceVpCwhACvREebEES1ssTlB3eZIGxJicXt
        nVDjPSQ+39sODa2dTBJzvvawTWBUmIXkt1lI/pmF5J9ZCJsXMLKsYhRLLSjOTU8tNiwwQY7w
        TYzgBKllsYNxzzmfQ4wCHIxKPLwNU/pihFgTy4orcw8xSnAwK4nw2nv2xwjxpiRWVqUW5ccX
        leakFh9iNAUG/URmKdHkfGDyziuJNzQ1MjY2tjAxNDM1NFQS513v4BwjJJCeWJKanZpakFoE
        08fEwSnVwJi6fHsew8yNBXcXBt6VCdc/I7M85Pie+FRBW3GtunebFzG9/CUk9KFt8xtB/v9Z
        ZYJalW8Y72neXtO1X/N8r3jLsfCy0G6dP44+RbuP31vpqXVl++djLCe/Pfddt1RUPENX3Dys
        u7ODbZHtnciXb3bc0lTef+Fem/3GFhXh/bN/8f0O6zeKLlFiKc5INNRiLipOBACnuprppgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO798v4Yg8NzVS16m6YzWbw5DiQu
        75rDZnG7cQWbA4vHvJOBHu/3XWXz6NuyitHj8ya5AJYoLpuU1JzMstQifbsEroxzxw+yF7xO
        qdjx4iJ7A+O/wC5GTg4JAROJXS2HWLoYuTiEBHYzSuxo/MYMkZCUmHbxKJDNAWQLSxw+XAxR
        85ZRom/hdkaQGmGBCImnGy6xgdhsAloS+1/cYAMpEhFYzijx+NwidoiOnUwSh3e+BKviF1CU
        uPrjMVg3r4CdRPuFP0wgNouAqsT2CxvA4qJAU+9efMECUSMocXLmEzCbU8BeYuae52BzmAXU
        Jf7Mu8QMYYtL3HoynwnClpdo3jqbeQKj0Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgVG
        eanlesWJucWleel6yfm5mxjB8aCltYPxxIn4Q4wCHIxKPLw3pvXFCLEmlhVX5h5ilOBgVhLh
        tffsjxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUgtQgmy8TBKdXAmJW+
        krvNmVd65TSPIwxWClO+t8pMNF3fufRKcNz/T39/pGqJetvv6Qp+evpesM/xplefZ054uEb9
        3w6GRHW+YmFf2ee/nj+SVEqcs+Dq2m0NbR9X/kpdvvA3G094/esm2VlcvrYTPkjt62TOtjft
        +vfNQ07Fc16hk7bInr3e92aVLrDWP2Ivr8RSnJFoqMVcVJwIAOqPGcuDAgAA
X-CMS-MailID: 20190318105007epcas1p4bfb1dbdd37a59aa285f2736177440180
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
        <3af26666-8913-c8bb-d2fb-64bd9ea0ec69@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 19. 3. 18. 오후 7:38, Chanwoo Choi wrote:
> Hi Andy,
> 
> Thanks for comment. I add my comments
> and then you have to rebase it on latest v5.0-rc1
> because the merge conflict happen on v5.0-rc1.

Please rebase the extcon-next branch instead of v5.0-rc1.

> 
> On 19. 3. 18. 오후 7:11, Andy Shevchenko wrote:
>> On Mon, Mar 18, 2019 at 12:52:25PM +0300, Andy Shevchenko wrote:
>>> TBD
>>
>> Oops.
>> I though I have written it already.
>>
>> I will wait for other comments today and sent a new version with commit message
>> filled as follows:
>>
>> On Intel Merrifield the Basin Cove PMIC provides a feature to detect
>> the USB connection type. This driver utilizes the feature in order to support
>> the USB dual role detection.
>>
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>  drivers/extcon/Kconfig              |   7 +
>>>  drivers/extcon/Makefile             |   1 +
>>>  drivers/extcon/extcon-intel-mrfld.c | 256 ++++++++++++++++++++++++++++
>>>  3 files changed, 264 insertions(+)
>>>  create mode 100644 drivers/extcon/extcon-intel-mrfld.c
>>>
>>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>>> index 8e17149655f0..75349c6cc89e 100644
>>> --- a/drivers/extcon/Kconfig
>>> +++ b/drivers/extcon/Kconfig
>>> @@ -60,6 +60,13 @@ config EXTCON_INTEL_CHT_WC
>>>  	  Say Y here to enable extcon support for charger detection / control
>>>  	  on the Intel Cherrytrail Whiskey Cove PMIC.
>>>  
>>> +config EXTCON_INTEL_MRFLD
>>
>>> +	tristate "Intel MErrifield Basin Cove PMIC extcon driver"
>>
>> ME -> Me (will be fixed)
>>
>>> +	depends on INTEL_SOC_PMIC_MRFLD
> 
> This driver uses the regmap interface. So, you better to add
> following dependency?
> - select REGMAP_I2C or REGMAP_SPI
> 
> But, if 'INTEL_SOC_PMIC_MRFLE' selects already REGMAP_*
> configuration. It is not necessary.
> 
>>> +	help
>>> +	  Say Y here to enable extcon support for charger detection / control
>>> +	  on the Intel Merrifiel Basin Cove PMIC.
> 
> What is correct word?
> - Merrifield? is used on above
> - Merrifiel?
> 
> 
>>> +
>>>  config EXTCON_MAX14577
>>>  	tristate "Maxim MAX14577/77836 EXTCON Support"
>>>  	depends on MFD_MAX14577
>>> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
>>> index 261ce4cfe209..d3941a735df3 100644
>>> --- a/drivers/extcon/Makefile
>>> +++ b/drivers/extcon/Makefile
>>> @@ -11,6 +11,7 @@ obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
>>>  obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
>>>  obj-$(CONFIG_EXTCON_INTEL_INT3496) += extcon-intel-int3496.o
>>>  obj-$(CONFIG_EXTCON_INTEL_CHT_WC) += extcon-intel-cht-wc.o
>>> +obj-$(CONFIG_EXTCON_INTEL_MRFLD) += extcon-intel-mrfld.o
>>>  obj-$(CONFIG_EXTCON_MAX14577)	+= extcon-max14577.o
>>>  obj-$(CONFIG_EXTCON_MAX3355)	+= extcon-max3355.o
>>>  obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
>>> diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
>>> new file mode 100644
>>> index 000000000000..d45db4975b5f
>>> --- /dev/null
>>> +++ b/drivers/extcon/extcon-intel-mrfld.c
>>> @@ -0,0 +1,256 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Extcon driver for Basin Cove PMIC
>>> + *
>>> + * Copyright (c) 2018, Intel Corporation.
>>
>> 2019 I suppose :-)
> 
> Right.
> 
>>
>>> + * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> + */
>>> +
>>> +#include <linux/extcon-provider.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/mfd/intel_soc_pmic.h>
>>> +#include <linux/mfd/intel_soc_pmic_mrfld.h>
>>> +#include <linux/mod_devicetable.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +#include "extcon-intel.h"
>>> +
>>> +#define BCOVE_USBIDCTRL			0x19
>>> +#define BCOVE_USBIDCTRL_ID		BIT(0)
>>> +#define BCOVE_USBIDCTRL_ACA		BIT(1)
>>> +#define BCOVE_USBIDCTRL_ALL	(BCOVE_USBIDCTRL_ID | BCOVE_USBIDCTRL_ACA)
>>> +
>>> +#define BCOVE_USBIDSTS			0x1a
>>> +#define BCOVE_USBIDSTS_GND		BIT(0)
>>> +#define BCOVE_USBIDSTS_RARBRC_MASK	GENMASK(2, 1)
>>> +#define BCOVE_USBIDSTS_RARBRC_SHIFT	1
>>> +#define BCOVE_USBIDSTS_NO_ACA		0
>>> +#define BCOVE_USBIDSTS_R_ID_A		1
>>> +#define BCOVE_USBIDSTS_R_ID_B		2
>>> +#define BCOVE_USBIDSTS_R_ID_C		3
>>> +#define BCOVE_USBIDSTS_FLOAT		BIT(3)
>>> +#define BCOVE_USBIDSTS_SHORT		BIT(4)
>>> +
>>> +#define BCOVE_CHGRIRQ_ALL	(BCOVE_CHGRIRQ_VBUSDET | BCOVE_CHGRIRQ_DCDET | \
>>> +				 BCOVE_CHGRIRQ_BATTDET | BCOVE_CHGRIRQ_USBIDDET)
>>> +
>>> +#define BCOVE_CHGRCTRL0			0x4b
>>> +#define BCOVE_CHGRCTRL0_CHGRRESET	BIT(0)
>>> +#define BCOVE_CHGRCTRL0_EMRGCHREN	BIT(1)
>>> +#define BCOVE_CHGRCTRL0_EXTCHRDIS	BIT(2)
>>> +#define BCOVE_CHGRCTRL0_SWCONTROL	BIT(3)
>>> +#define BCOVE_CHGRCTRL0_TTLCK		BIT(4)
>>> +#define BCOVE_CHGRCTRL0_BIT_5		BIT(5)
>>> +#define BCOVE_CHGRCTRL0_BIT_6		BIT(6)
>>> +#define BCOVE_CHGRCTRL0_CHR_WDT_NOKICK	BIT(7)
>>> +
>>> +struct mrfld_extcon_data {
>>> +	struct device *dev;
>>> +	struct regmap *regmap;
>>> +	struct extcon_dev *edev;
>>> +	unsigned int status;
>>> +	unsigned int id;
>>> +};
>>> +
>>> +static const unsigned int mrfld_extcon_cable[] = {
>>> +	EXTCON_USB,
>>> +	EXTCON_USB_HOST,
>>> +	EXTCON_CHG_USB_SDP,
>>> +	EXTCON_CHG_USB_CDP,
>>> +	EXTCON_CHG_USB_DCP,
>>> +	EXTCON_CHG_USB_ACA,
>>> +	EXTCON_NONE,
>>> +};
>>> +
>>> +static int mrfld_extcon_clear(struct mrfld_extcon_data *data, unsigned int reg,
>>> +			      unsigned int mask)
>>> +{
>>> +	return regmap_update_bits(data->regmap, reg, mask, 0x00);
>>> +}
>>> +
>>> +static int mrfld_extcon_set(struct mrfld_extcon_data *data, unsigned int reg,
>>> +			    unsigned int mask)
>>> +{
>>> +	return regmap_update_bits(data->regmap, reg, mask, 0xff);
>>> +}
> 
> mrfld_extcon_clear() and mrfld_extcon_set() are just wrapper function
> for regmap interface. I think that you better to define
> the meaningful defintion for '0x00' and '0xff' as following:
> 
> (just example, you may make the more correct name)
> #define INTEL_MRFLD_RESET	0x00
> #define INTEL_MRFLD_SET		0xff
> 
> And then you better to use the 'regmap_update_bits()' function
> directly instead of mrfld_extcon_clear/set'.
> 
> Also, you should handle the exception hanlding when using regmap function.
> 
>>> +
>>> +static int mrfld_extcon_get_id(struct mrfld_extcon_data *data)
>>> +{
>>> +	struct regmap *regmap = data->regmap;
>>> +	unsigned int id;
>>> +	bool ground;
>>> +	int ret;
>>> +
>>> +	ret = regmap_read(regmap, BCOVE_USBIDSTS, &id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (id & BCOVE_USBIDSTS_FLOAT)
>>> +		return INTEL_USB_ID_FLOAT;
>>> +
>>> +	switch ((id & BCOVE_USBIDSTS_RARBRC_MASK) >> BCOVE_USBIDSTS_RARBRC_SHIFT) {
>>> +	case BCOVE_USBIDSTS_R_ID_A:
>>> +		return INTEL_USB_RID_A;
>>> +	case BCOVE_USBIDSTS_R_ID_B:
>>> +		return INTEL_USB_RID_B;
>>> +	case BCOVE_USBIDSTS_R_ID_C:
>>> +		return INTEL_USB_RID_C;
> 
> Please add 'default' statement for exception handling.
> 
>>> +	}
>>> +
>>> +	/*
>>> +	 * PMIC A0 reports USBIDSTS_GND = 1 for ID_GND,
>>> +	 * but PMIC B0 reports USBIDSTS_GND = 0 for ID_GND.
>>> +	 * Thus we must check this bit at last.
>>> +	 */
>>> +	ground = id & BCOVE_USBIDSTS_GND;
>>> +	switch ('A' + BCOVE_MAJOR(data->id)) {
>>> +	case 'A':
>>> +		return ground ? INTEL_USB_ID_GND : INTEL_USB_ID_FLOAT;
>>> +	case 'B':
>>> +		return ground ? INTEL_USB_ID_FLOAT : INTEL_USB_ID_GND;
>>> +	}
>>> +
>>> +	/* Unknown or unsupported type */
>>> +	return INTEL_USB_ID_FLOAT;
>>> +}
>>> +
>>> +static int mrfld_extcon_role_detect(struct mrfld_extcon_data *data)
>>> +{
>>> +	unsigned int id;
>>> +	bool usb_host;
>>> +	int ret;>> +
>>> +	ret = mrfld_extcon_get_id(data);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	id = ret;
>>> +
>>> +	usb_host = (id == INTEL_USB_ID_GND) || (id == INTEL_USB_RID_A);
>>> +	extcon_set_state_sync(data->edev, EXTCON_USB_HOST, usb_host);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int mrfld_extcon_cable_detect(struct mrfld_extcon_data *data)
>>> +{
>>> +	struct regmap *regmap = data->regmap;
>>> +	unsigned int status;
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * It seems SCU firmware clears the content of BCOVE_CHGRIRQ1
>>> +	 * and makes it useless for OS. Instead we compare a previously
>>> +	 * stored status to the current one, provided by BCOVE_SCHGRIRQ1.
>>> +	 */
>>> +	ret = regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (!(status ^ data->status))
>>> +		return -ENODATA;
>>> +
>>> +	if ((status ^ data->status) & BCOVE_CHGRIRQ_USBIDDET)
>>> +		ret = mrfld_extcon_role_detect(data);
> This line gets the return value from mrfld_extcon_role_detect(data)
> without any error handling and then the below line just saves 'status'
> to 'data->status' regardless of 'ret' value.
> 
> I think that you have to handle the error case of
> 'ret = mrfld_extcon_role_detect(data)'.
> 
>>> +
>>> +	data->status = status;
> 
> nitpick. better to add one blank line.
> 
>>> +	return ret;
>>> +}
>>> +
>>> +static irqreturn_t mrfld_extcon_interrupt(int irq, void *dev_id)
>>> +{
>>> +	struct mrfld_extcon_data *data = dev_id;
>>> +	int ret;
>>> +
>>> +	ret = mrfld_extcon_cable_detect(data);
>>> +
>>> +	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
>>> +
>>> +	return ret ? IRQ_NONE: IRQ_HANDLED;
>>> +}
>>> +
>>> +static int mrfld_extcon_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
>>> +	struct regmap *regmap = pmic->regmap;
>>> +	struct mrfld_extcon_data *data;
>>> +	unsigned int id;
>>> +	int irq, ret;
>>> +
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	if (irq < 0)
>>> +		return irq;
>>> +
>>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>> +	if (!data)
>>> +		return -ENOMEM;
>>> +
>>> +	data->dev = dev;
>>> +	data->regmap = regmap;
>>> +
>>> +	data->edev = devm_extcon_dev_allocate(dev, mrfld_extcon_cable);
>>> +	if (IS_ERR(data->edev))
>>> +		return -ENOMEM;
>>> +
>>> +	ret = devm_extcon_dev_register(dev, data->edev);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "can't register extcon device: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = devm_request_threaded_irq(dev, irq, NULL, mrfld_extcon_interrupt,
>>> +					IRQF_ONESHOT | IRQF_SHARED, pdev->name,
>>> +					data);
>>> +	if (ret)
>>> +		return ret;
> 
> You better add the error log with dev_err.
> 
>>> +
>>> +	ret = regmap_read(regmap, BCOVE_ID, &id);
>>> +	if (ret)
>>> +		return ret;
> 
> ditto for error log.
> 
>>> +
>>> +	data->id = id;
>>> +
>>> +	mrfld_extcon_set(data, BCOVE_CHGRCTRL0, BCOVE_CHGRCTRL0_SWCONTROL);
>>> +
>>> +	/* Get initial state */
>>> +	mrfld_extcon_role_detect(data);
> 
> Please handle the return value for exception handling with log.
> 
>>> +
>>> +	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
>>> +	mrfld_extcon_clear(data, BCOVE_MCHGRIRQ1, BCOVE_CHGRIRQ_ALL);
>>> +
>>> +	mrfld_extcon_set(data, BCOVE_USBIDCTRL, BCOVE_USBIDCTRL_ALL);
>>> +
>>> +	platform_set_drvdata(pdev, data);
> 
> nitpick. better to add one blank line.
> 
>>> +	return 0;
>>> +}
>>> +
>>> +static int mrfld_extcon_remove(struct platform_device *pdev)
>>> +{
>>> +	struct mrfld_extcon_data *data = platform_get_drvdata(pdev);
>>> +
>>> +	mrfld_extcon_clear(data, BCOVE_CHGRCTRL0, BCOVE_CHGRCTRL0_SWCONTROL);
> 
> nitpick. better to add one blank line.
> 
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct platform_device_id mrfld_extcon_id_table[] = {
>>> +	{ .name = "mrfld_bcove_extcon" },
> 
> I think that it is not proper to use 'extcon' word for the compatible name
> because 'extcon' word is linuxium. So, I recommend that you remove
> the 'extcon' word. Instead, you better to use new word related to h/w.
> 
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(platform, mrfld_extcon_id_table);
>>> +
>>> +static struct platform_driver mrfld_extcon_driver = {
>>> +	.driver = {
>>> +		.name	= KBUILD_MODNAME,
> 
> Where is the definition of KBUILD_MODNAME? Are you missing?
> 
>>> +	},
>>> +	.probe		= mrfld_extcon_probe,
>>> +	.remove		= mrfld_extcon_remove,
>>> +	.id_table	= mrfld_extcon_id_table,
>>> +};
>>> +module_platform_driver(mrfld_extcon_driver);
>>> +
>>> +MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
>>> +MODULE_DESCRIPTION("Extcon driver for Basin Cove PMIC");
> 
> Add the 'Merrifield' word in front of 'Basin Cove PMIC' as following:
> - Merrifield Basic Cove PMIC
> 
>>> +MODULE_LICENSE("GPL v2");
>>> -- 
>>> 2.20.1
>>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
