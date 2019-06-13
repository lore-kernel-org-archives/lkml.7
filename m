Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F904C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615CF2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uwar+8M0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404225AbfFMQrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:47:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38862 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbfFME7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:59:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5D4x3YZ037442;
        Wed, 12 Jun 2019 23:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560401943;
        bh=NMa4uk9UyXREv+U2FENU860reiDu6LVpknylFvVeAMc=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=uwar+8M0MiSjoYVy1hRvFXbTuNiZNRO6hcip3GEBh+Z4zGRS6t6xBtFSGX1LWwMDK
         W2xCNj6MQ/i/IR4ntls+4tTiHmKgENNYPk9t//eb0nDwnMQ0PdGI/vhjUBhFyNkFHz
         ma5wioTNpODjP9a1nH+hLQGEjm4gKuYDYPQFLHXU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5D4x2qL059225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jun 2019 23:59:02 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 12
 Jun 2019 23:59:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 12 Jun 2019 23:59:01 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5D4x0b3120076;
        Wed, 12 Jun 2019 23:59:00 -0500
Subject: Re: [PATCH v4 4/5] phy: ti: Add a new SERDES driver for TI's AM654x
 SoC
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
References: <c357f9bc-dcf9-e8de-f879-f208e45a5b86@axentia.se>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ac361a0c-829c-41bb-64f0-bd74bb0c0dd6@ti.com>
Date:   Thu, 13 Jun 2019 10:27:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c357f9bc-dcf9-e8de-f879-f208e45a5b86@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 13/06/19 4:20 AM, Peter Rosin wrote:
> Hi!
> 
> [I know this has already been merged upstream, but I only just
>  now noticed the code and went to the archives to find the
>  originating mail. I hope I managed to set in-reply-to correctly...]
> 
> The mux handling is problematic and does not follow the rules.
> It needs to be fixed, or you may face deadlocks. See below.
> 
> On 2019-04-05 11:08, Kishon Vijay Abraham I wrote:
>> Add a new SERDES driver for TI's AM654x SoC which configures
>> the SERDES only for PCIe. Support fo USB3 will be added later.
>>
>> SERDES in am654x has three input clocks (left input, externel reference
>> clock and right input) and two output clocks (left output and right
>> output) in addition to a PLL mux clock which the SERDES uses for Clock
>> Multiplier Unit (CMU refclock).
>>
>> The PLL mux clock can select from one of the three input clocks.
>> The right output can select between left input and external reference
>> clock while the left output can select between the right input and
>> external reference clock.
>>
>> The driver has support to select PLL mux and left/right output mux as
>> specified in device tree.
>>
>> [rogerq@ti.com: Fix boot lockup caused by accessing a structure member
>> (hw->init) allocated in stack of probe() and accessed in get_parent]
>> [rogerq@ti.com: Fix "Failed to find the parent" warnings]
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/phy/ti/Kconfig            |  12 +
>>  drivers/phy/ti/Makefile           |   1 +
>>  drivers/phy/ti/phy-am654-serdes.c | 624 ++++++++++++++++++++++++++++++
>>  3 files changed, 637 insertions(+)
>>  create mode 100644 drivers/phy/ti/phy-am654-serdes.c
>>
>> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
>> index 7cdc35f8c862..6931c87235b9 100644
>> --- a/drivers/phy/ti/Kconfig
>> +++ b/drivers/phy/ti/Kconfig
>> @@ -20,6 +20,18 @@ config PHY_DM816X_USB
>>  	help
>>  	  Enable this for dm816x USB to work.
>>  
>> +config PHY_AM654_SERDES
>> +	tristate "TI AM654 SERDES support"
>> +	depends on OF && ARCH_K3 || COMPILE_TEST
>> +	depends on COMMON_CLK
>> +	select GENERIC_PHY
>> +	select MULTIPLEXER
>> +	select REGMAP_MMIO
>> +	select MUX_MMIO
>> +	help
>> +	  This option enables support for TI AM654 SerDes PHY used for
>> +	  PCIe.
>> +
>>  config OMAP_CONTROL_PHY
>>  	tristate "OMAP CONTROL PHY Driver"
>>  	depends on ARCH_OMAP2PLUS || COMPILE_TEST
>> diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
>> index 368de8e1548d..601bbd88f35e 100644
>> --- a/drivers/phy/ti/Makefile
>> +++ b/drivers/phy/ti/Makefile
>> @@ -6,5 +6,6 @@ obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>>  obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
>>  obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
>>  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
>> +obj-$(CONFIG_PHY_AM654_SERDES)		+= phy-am654-serdes.o
>>  obj-$(CONFIG_PHY_TI_GMII_SEL)		+= phy-gmii-sel.o
>>  obj-$(CONFIG_PHY_TI_KEYSTONE_SERDES)	+= phy-keystone-serdes.o
>> diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
>> new file mode 100644
>> index 000000000000..4817c67abbbb
>> --- /dev/null
>> +++ b/drivers/phy/ti/phy-am654-serdes.c
>> @@ -0,0 +1,624 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * PCIe SERDES driver for AM654x SoC
>> + *
>> + * Copyright (C) 2018 - 2019 Texas Instruments Incorporated - http://www.ti.com/
>> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
>> + */
>> +
>> +#include <dt-bindings/phy/phy.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mux/consumer.h>
>> +#include <linux/of_address.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +
>> +#define CMU_R07C		0x7c
>> +
>> +#define COMLANE_R138		0xb38
>> +#define VERSION			0x70
>> +
>> +#define COMLANE_R190		0xb90
>> +
>> +#define COMLANE_R194		0xb94
>> +
>> +#define SERDES_CTRL		0x1fd0
>> +
>> +#define WIZ_LANEXCTL_STS	0x1fe0
>> +#define TX0_DISABLE_STATE	0x4
>> +#define TX0_SLEEP_STATE		0x5
>> +#define TX0_SNOOZE_STATE	0x6
>> +#define TX0_ENABLE_STATE	0x7
>> +
>> +#define RX0_DISABLE_STATE	0x4
>> +#define RX0_SLEEP_STATE		0x5
>> +#define RX0_SNOOZE_STATE	0x6
>> +#define RX0_ENABLE_STATE	0x7
>> +
>> +#define WIZ_PLL_CTRL		0x1ff4
>> +#define PLL_DISABLE_STATE	0x4
>> +#define PLL_SLEEP_STATE		0x5
>> +#define PLL_SNOOZE_STATE	0x6
>> +#define PLL_ENABLE_STATE	0x7
>> +
>> +#define PLL_LOCK_TIME		100000	/* in microseconds */
>> +#define SLEEP_TIME		100	/* in microseconds */
>> +
>> +#define LANE_USB3		0x0
>> +#define LANE_PCIE0_LANE0	0x1
>> +
>> +#define LANE_PCIE1_LANE0	0x0
>> +#define LANE_PCIE0_LANE1	0x1
>> +
>> +#define SERDES_NUM_CLOCKS	3
>> +
>> +struct serdes_am654_clk_mux {
>> +	struct clk_hw	hw;
>> +	struct regmap	*regmap;
>> +	unsigned int	reg;
>> +	int		*table;
>> +	u32		mask;
>> +	u8		shift;
>> +	struct clk_init_data clk_data;
>> +};
>> +
>> +#define to_serdes_am654_clk_mux(_hw)	\
>> +		container_of(_hw, struct serdes_am654_clk_mux, hw)
>> +
>> +static struct regmap_config serdes_am654_regmap_config = {
>> +	.reg_bits = 32,
>> +	.val_bits = 32,
>> +	.reg_stride = 4,
>> +	.fast_io = true,
>> +};
>> +
>> +static const struct reg_field cmu_master_cdn_o = REG_FIELD(CMU_R07C, 24, 24);
>> +static const struct reg_field config_version = REG_FIELD(COMLANE_R138, 16, 23);
>> +static const struct reg_field l1_master_cdn_o = REG_FIELD(COMLANE_R190, 9, 9);
>> +static const struct reg_field cmu_ok_i_0 = REG_FIELD(COMLANE_R194, 19, 19);
>> +static const struct reg_field por_en = REG_FIELD(SERDES_CTRL, 29, 29);
>> +static const struct reg_field tx0_enable = REG_FIELD(WIZ_LANEXCTL_STS, 29, 31);
>> +static const struct reg_field rx0_enable = REG_FIELD(WIZ_LANEXCTL_STS, 13, 15);
>> +static const struct reg_field pll_enable = REG_FIELD(WIZ_PLL_CTRL, 29, 31);
>> +static const struct reg_field pll_ok = REG_FIELD(WIZ_PLL_CTRL, 28, 28);
>> +
>> +struct serdes_am654 {
>> +	struct regmap		*regmap;
>> +	struct regmap_field	*cmu_master_cdn_o;
>> +	struct regmap_field	*config_version;
>> +	struct regmap_field	*l1_master_cdn_o;
>> +	struct regmap_field	*cmu_ok_i_0;
>> +	struct regmap_field	*por_en;
>> +	struct regmap_field	*tx0_enable;
>> +	struct regmap_field	*rx0_enable;
>> +	struct regmap_field	*pll_enable;
>> +	struct regmap_field	*pll_ok;
>> +
>> +	struct device		*dev;
>> +	struct mux_control	*control;
>> +	bool			busy;
>> +	u32			type;
>> +	struct device_node	*of_node;
>> +	struct clk_onecell_data	clk_data;
>> +	struct clk		*clks[SERDES_NUM_CLOCKS];
>> +};
>> +
>> +static int serdes_am654_enable_pll(struct serdes_am654 *phy)
>> +{
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = regmap_field_write(phy->pll_enable, PLL_ENABLE_STATE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return regmap_field_read_poll_timeout(phy->pll_ok, val, val, 1000,
>> +					      PLL_LOCK_TIME);
>> +}
>> +
>> +static void serdes_am654_disable_pll(struct serdes_am654 *phy)
>> +{
>> +	struct device *dev = phy->dev;
>> +	int ret;
>> +
>> +	ret = regmap_field_write(phy->pll_enable, PLL_DISABLE_STATE);
>> +	if (ret)
>> +		dev_err(dev, "Failed to disable PLL\n");
>> +}
>> +
>> +static int serdes_am654_enable_txrx(struct serdes_am654 *phy)
>> +{
>> +	int ret;
>> +
>> +	/* Enable TX */
>> +	ret = regmap_field_write(phy->tx0_enable, TX0_ENABLE_STATE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable RX */
>> +	ret = regmap_field_write(phy->rx0_enable, RX0_ENABLE_STATE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int serdes_am654_disable_txrx(struct serdes_am654 *phy)
>> +{
>> +	int ret;
>> +
>> +	/* Disable TX */
>> +	ret = regmap_field_write(phy->tx0_enable, TX0_DISABLE_STATE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Disable RX */
>> +	ret = regmap_field_write(phy->rx0_enable, RX0_DISABLE_STATE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int serdes_am654_power_on(struct phy *x)
>> +{
>> +	struct serdes_am654 *phy = phy_get_drvdata(x);
>> +	struct device *dev = phy->dev;
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = serdes_am654_enable_pll(phy);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable PLL\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = serdes_am654_enable_txrx(phy);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable TX RX\n");
>> +		return ret;
>> +	}
>> +
>> +	return regmap_field_read_poll_timeout(phy->cmu_ok_i_0, val, val,
>> +					      SLEEP_TIME, PLL_LOCK_TIME);
>> +}
>> +
>> +static int serdes_am654_power_off(struct phy *x)
>> +{
>> +	struct serdes_am654 *phy = phy_get_drvdata(x);
>> +
>> +	serdes_am654_disable_txrx(phy);
>> +	serdes_am654_disable_pll(phy);
>> +
>> +	return 0;
>> +}
>> +
>> +static int serdes_am654_init(struct phy *x)
>> +{
>> +	struct serdes_am654 *phy = phy_get_drvdata(x);
>> +	int ret;
>> +
>> +	ret = regmap_field_write(phy->config_version, VERSION);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_field_write(phy->cmu_master_cdn_o, 0x1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_field_write(phy->l1_master_cdn_o, 0x1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int serdes_am654_reset(struct phy *x)
>> +{
>> +	struct serdes_am654 *phy = phy_get_drvdata(x);
>> +	int ret;
>> +
>> +	ret = regmap_field_write(phy->por_en, 0x1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mdelay(1);
>> +
>> +	ret = regmap_field_write(phy->por_en, 0x0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static void serdes_am654_release(struct phy *x)
>> +{
>> +	struct serdes_am654 *phy = phy_get_drvdata(x);
>> +
>> +	phy->type = PHY_NONE;
>> +	phy->busy = false;
>> +	mux_control_deselect(phy->control);
> 
> Here you unconditionally deselect the mux, and that seems
> dangerous. Are you *sure* that ->release may not be called
> without a successful xlate call?

Yeah, without a successful xlate(), the consumer will never get a reference to
the PHY and the ->release() is invoked only from phy_put() which needs a
reference to the PHY.
> 
> I'm not 100% sure of that, but I have not looked at the phy
> code before today, so it may very well be the case that this
> is safe...
> 
>> +}
>> +
>> +struct phy *serdes_am654_xlate(struct device *dev, struct of_phandle_args
>> +				 *args)
>> +{
>> +	struct serdes_am654 *am654_phy;
>> +	struct phy *phy;
>> +	int ret;
>> +
>> +	phy = of_phy_simple_xlate(dev, args);
>> +	if (IS_ERR(phy))
>> +		return phy;
>> +
>> +	am654_phy = phy_get_drvdata(phy);
>> +	if (am654_phy->busy)
>> +		return ERR_PTR(-EBUSY);
>> +
>> +	ret = mux_control_select(am654_phy->control, args->args[1]);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to select SERDES Lane Function\n");
>> +		return ERR_PTR(ret);
>> +	}
> 
> *However*
> 
> Here you select the mux as the last action, good, but, a mux must
> be handled with that same care as a locking primitive, i.e.
> successful selects must be perfectly balanced with deselects. I
> see no guarantee of that here, since there are other failures
> possible after the xlate call. So, being last in the function
> does not really help. If I read the code correctly, the
> phy core may fail if try_module_get fails in phy_get(). If that
> ever happens, a successful call to mux_control_select is simply
> forgotten, and the mux will be locked indefinitely.

Good catch. While adding ->release() ops which is only invoked from phy_put,
perhaps this was missed. Ideally it should be invoked from other places where
there is a failure after phy_get.
> 
> am654_phy->busy will also be set indefinitely, so you will get
> -EBUSY and not a hard deadlock. At least here, but if the now
> locked mux control happens to also control some other muxes
> (probably unlikely, but if), then their consumers will potentially
> deadlock hard. But that's just after a cursory reading, so I may
> completely miss something...

The ->busy here should prevent two consumers trying to control the same mux.
> 
> Thinking some more, the above mentioned forgotten phy problem
> in fact looks like a generic leak in phy_get. It will simply
> leak any and all phys where the owner module is not yet
> available. Or, am I missing something?

yes you are right. Ideally we should have invoked ->release() after phy_get()
failures.
> 
> Perhaps fixing that is all that is needed to make the mux
> select/deselect calls guaranteed to be balanced?

That's correct. Thanks for reporting this.

Cheers
Kishon
