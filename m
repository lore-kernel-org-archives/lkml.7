Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1528C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F0C24680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfLTKpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:45:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:4109 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfLTKpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:45:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 02:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="210780192"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2019 02:45:51 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iiFn5-00011C-9a; Fri, 20 Dec 2019 12:45:51 +0200
Date:   Fri, 20 Dec 2019 12:45:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
Subject: Re: [PATCH 2/2] phy: intel: Add driver support for combo phy
Message-ID: <20191220104551.GV32742@smile.fi.intel.com>
References: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
 <09556a80a967780072ae1240c7c8356f9142de50.1576824311.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09556a80a967780072ae1240c7c8356f9142de50.1576824311.git.eswara.kota@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 03:28:28PM +0800, Dilip Kota wrote:
> Combo phy subsystem provides PHYs for various
> controllers like PCIe, SATA and EMAC.

...

> +#define REG_COMBO_MODE(x)	((x) * 0x200)

Perhaps  + 0x000

> +#define REG_CLK_DISABLE(x)	((x) * 0x200 + 0x124)

...

> +static const char *const intel_iphy_names[] = {"pcie", "xpcs", "sata"};
> +static const unsigned long intel_iphy_clk_rate[] = {

names (note S)
rate -> rates

> +	CLK_100MHZ, CLK_156_25MHZ, CLK_100MHZ
> +};

...

> +static ssize_t intel_cbphy_info_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct intel_combo_phy *cbphy;
> +	int i, off;
> +
> +	cbphy = dev_get_drvdata(dev);
> +
> +	off = sprintf(buf, "mode: %u\n", cbphy->mode);
> +
> +	off += sprintf(buf + off, "aggr mode: %s\n",

> +		      cbphy->aggr_mode == PHY_DL_MODE ? "Yes" : "No");

Can't you do

static inline const char *yesno(bool choice)
{
	return choice ? "Yes" : "No";
}

and use it here and below?

Somebody already shared the idea that the above helper should be available
globally.

> +
> +	off += sprintf(buf + off, "capability: ");
> +	for (i = PHY_PCIE_MODE; i < PHY_MAX_MODE; i++) {
> +		if (BIT(i) & cbphy->phy_cap)
> +			off += sprintf(buf + off, "%s ", intel_iphy_names[i]);
> +	}
> +
> +	off += sprintf(buf + off, "\n");
> +
> +	for (i = 0; i < PHY_MAX_NUM; i++) {
> +		off += sprintf(buf + off, "PHY%d mode: %s, enable: %s\n",
> +			       i, intel_iphy_names[cbphy->iphy[i].phy_mode],
> +			       cbphy->iphy[i].enable ? "Yes" : "No");
> +	}
> +
> +	return off;
> +}

...

> +static struct attribute *intel_cbphy_attrs[] = {
> +	&dev_attr_intel_cbphy_info.attr,

> +	NULL,

Comma is redundant for terminator lines.

> +};


> +static int intel_cbphy_sysfs_init(struct intel_combo_phy *cbphy)
> +{
> +	return devm_device_add_groups(cbphy->dev, intel_cbphy_groups);
> +}

What the point?
Moreover, can't you use .dev_groups member of struct device_driver?

...

> +		ret =  phy_cfg(sphy);

In several places you have extra unneeded white spaces.

...

> +	combo_phy_w32_off_mask(iphy->app_base, PCIE_PHY_CLK_PAD,
> +			       0, PCIE_PHY_GEN_CTRL);

Configure your editor properly! There is plenty of room on the previous line.

...

> +	combo_phy_w32_off_mask(iphy->app_base, PCIE_PHY_CLK_PAD,
> +			       1, PCIE_PHY_GEN_CTRL);

Ditto.

...

> +static int intel_cbphy_init(struct phy *phy)
> +{
> +	struct intel_cbphy_iphy *iphy;


> +	int ret = 0;

Redundant assignment. See below.

> +
> +	iphy = phy_get_drvdata(phy);
> +
> +	if (iphy->phy_mode == PHY_PCIE_MODE) {
> +		ret = intel_cbphy_iphy_cfg(iphy,
> +					   intel_cbphy_pcie_en_pad_refclk);
> +	}
> +
> +	if (!ret)
> +		ret = intel_cbphy_iphy_cfg(iphy, intel_cbphy_iphy_power_on);
> +
> +	return ret;

Why not to simple do

	if (A) {
		ret = ...;
		if (ret)
			return ret;
	}

	return intel_...;

?

> +}
> +
> +static int intel_cbphy_exit(struct phy *phy)
> +{
> +	struct intel_cbphy_iphy *iphy;
> +	int ret = 0;
> +
> +	iphy = phy_get_drvdata(phy);
> +
> +	if (iphy->power_en)
> +		ret = intel_cbphy_iphy_cfg(iphy, intel_cbphy_iphy_power_off);
> +
> +	if (!ret && iphy->phy_mode == PHY_PCIE_MODE)
> +		ret = intel_cbphy_iphy_cfg(iphy,
> +					   intel_cbphy_pcie_dis_pad_refclk);
> +
> +	return ret;

Ditto.

> +}

...

> +static int intel_cbphy_iphy_mem_resource(struct intel_cbphy_iphy *iphy)
> +{
> +	void __iomem *base;
> +
> +	base = devm_platform_ioremap_resource(iphy->pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	iphy->app_base = base;
> +
> +	return 0;
> +}

What's the point of this helper?

...

> +static int intel_cbphy_iphy_get_clks(struct intel_cbphy_iphy *iphy)
> +{
> +	enum intel_phy_mode mode = iphy->phy_mode;
> +	struct device *dev = iphy->dev;

> +	int ret = 0;

Redundant. Simple return 0 explicitly at the end.
Ditto for other places in this patch.

> +	if (IS_ERR(iphy->freq_clk)) {
> +		ret = PTR_ERR(iphy->freq_clk);
> +		if (ret != -EPROBE_DEFER) {
> +			dev_err(dev, "PHY[%u:%u] No %s freq clock\n",
> +				COMBO_PHY_ID(iphy), PHY_ID(iphy),
> +				intel_iphy_names[mode]);
> +		}
> +
> +		return ret;
> +	}
> +
> +	iphy->clk_rate = intel_iphy_clk_rate[mode];
> +
> +	return ret;
> +}

...

> +static int intel_cbphy_iphy_dt_parse(struct intel_combo_phy *cbphy,
> +				     struct fwnode_handle *fwn, int idx)

fwn -> fwnode.

> +{
> +	struct intel_cbphy_iphy *iphy = &cbphy->iphy[idx];
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	int ret = 0;
> +	u32 prop;
> +
> +	iphy->id = idx;
> +	iphy->enable = false;
> +	iphy->power_en = false;
> +	iphy->parent = cbphy;

> +	iphy->np = to_of_node(fwn);
> +	pdev = of_find_device_by_node(iphy->np);

Why? Can't it be done simpler?

> +	if (!pdev) {
> +		dev_warn(cbphy->dev, "Combo-PHY%u: PHY device: %d disabled!\n",
> +			 cbphy->id, idx);
> +		return 0;
> +	}

> +	if (!(BIT(iphy->phy_mode) & cbphy->phy_cap)) {

Yoda style?

...

> +				" Mode mismatch lane0 : %u, lane1 : %u\n",

Extra leading space.

...

> +static int intel_cbphy_dt_parse(struct intel_combo_phy *cbphy)
> +{
> +	struct device *dev = cbphy->dev;

> +	struct device_node *np = dev->of_node;

Why do you need this one? You have to device if it's OF centric driver or not.

> +	struct fwnode_handle *fwn;

Better name is fwnode as done in plenty other drivers.

> +	int i = 0, ret = 0;

i = 0 better to have near to its user.
ret = 0 is redundant assignment.


> +	ret = device_property_read_u32(dev, "intel,bid", &cbphy->bid);
> +	if (ret) {
> +		dev_err(dev, "NO intel,bid provided!\n");
> +		return ret;
> +	}
> +
> +	device_for_each_child_node(dev, fwn) {
> +		if (i >= PHY_MAX_NUM) {
> +			fwnode_handle_put(fwn);
> +			dev_err(dev, "Error: DT child number larger than %d\n",
> +				PHY_MAX_NUM);
> +			return -EINVAL;
> +		}
> +
> +		ret = intel_cbphy_iphy_dt_parse(cbphy, fwn, i);
> +		if (ret) {
> +			fwnode_handle_put(fwn);
> +			return ret;
> +		}
> +
> +		i++;
> +	}
> +
> +	return intel_cbphy_dt_sanity_check(cbphy);
> +}

...

> +	regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);

No error check?

> +
> +	return 0;

...

> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		dev_err(dev, "PHY[%u:%u]: register phy provider failed!\n",
> +			COMBO_PHY_ID(iphy), PHY_ID(iphy));

> +		return PTR_ERR(phy_provider);
> +	}
> +
> +	return 0;

return PTR_ERR_OR_ZERO(...);

...

> +	ret = of_property_read_u32(dev->of_node, "cell-index", &id);

You should decide either you go with OF centric API(s) or with device property
one as below.

> +	if (!device_property_read_bool(dev, "intel,cap-pcie-only"))
> +		cbphy->phy_cap |= PHY_XPCS_CAP | PHY_SATA_CAP;

...

> +	ret = intel_cbphy_sysfs_init(cbphy);
> +
> +	return ret;

return intel_...();

...

> +static struct platform_driver intel_cbphy_driver = {
> +	.probe = intel_cbphy_probe,
> +	.driver = {
> +		.name = "intel-combo-phy",
> +		.of_match_table = of_intel_cbphy_match,
> +	}
> +};
> +
> +builtin_platform_driver(intel_cbphy_driver);

Can we unbound it? Is it okay to do unbind/bind cycle? Had it been tested for
that?

-- 
With Best Regards,
Andy Shevchenko


