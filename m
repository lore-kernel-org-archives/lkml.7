Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54F9C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 21:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944F02173E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 21:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLYV7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 16:59:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:8384 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfLYV7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 16:59:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 13:59:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,356,1571727600"; 
   d="scan'208";a="392192802"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Dec 2019 13:59:47 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ikEh0-0007cC-Vl; Thu, 26 Dec 2019 05:59:46 +0800
Date:   Thu, 26 Dec 2019 05:59:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     kbuild-all@lists.01.org, sravanhome@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] regulator: mpq7920: add mpq7920 regulator driver
Message-ID: <201912260536.tzKV8pVS%lkp@intel.com>
References: <20191222204507.32413-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191222204507.32413-4-sravanhome@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravanan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on regulator/for-next]
[also build test WARNING on robh/for-next linus/master v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Saravanan-Sekar/Add-regulator-support-for-mpq7920/20191225-005026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/regulator/mpq7920.c:339:44: sparse: sparse: Using plain integer as NULL pointer
>> drivers/regulator/mpq7920.c:317:21: sparse: sparse: incorrect type in assignment (different modifiers)
>> drivers/regulator/mpq7920.c:317:21: sparse:    expected struct regulator_ops *ops
>> drivers/regulator/mpq7920.c:317:21: sparse:    got struct regulator_ops const *ops

vim +339 drivers/regulator/mpq7920.c

   306	
   307	static inline int mpq7920_regulator_register(
   308					struct mpq7920_regulator_info *info,
   309					struct regulator_config *config)
   310	{
   311		int i;
   312		struct regulator_desc *rdesc;
   313		struct regulator_ops *ops;
   314	
   315		for (i = 0; i < MPQ7920_MAX_REGULATORS; i++) {
   316			rdesc = &info->rdesc[i];
 > 317			ops = rdesc->ops;
   318			if (rdesc->curr_table) {
   319				ops->get_current_limit =
   320					regulator_get_current_limit_regmap;
   321				ops->set_current_limit =
   322					regulator_set_current_limit_regmap;
   323			}
   324	
   325			info->rdev[i] = devm_regulator_register(info->dev, rdesc,
   326						 config);
   327			if (IS_ERR(info->rdev))
   328				return PTR_ERR(info->rdev);
   329		}
   330	
   331		return 0;
   332	}
   333	
   334	static int mpq7920_i2c_probe(struct i2c_client *client,
   335					    const struct i2c_device_id *id)
   336	{
   337		struct device *dev = &client->dev;
   338		struct mpq7920_regulator_info *info;
 > 339		struct regulator_config config = { 0 };
   340		struct regmap *regmap;
   341		int ret;
   342	
   343		info = devm_kzalloc(dev, sizeof(struct mpq7920_regulator_info),
   344					GFP_KERNEL);
   345		if (!info)
   346			return -ENOMEM;
   347	
   348		info->dev = dev;
   349		info->rdesc = mpq7920_regulators_desc;
   350		regmap = devm_regmap_init_i2c(client, &mpq7920_regmap_config);
   351		if (IS_ERR(regmap)) {
   352			dev_err(dev, "Failed to allocate regmap!\n");
   353			return PTR_ERR(regmap);
   354		}
   355	
   356		i2c_set_clientdata(client, info);
   357		info->regmap = regmap;
   358		if (client->dev.of_node)
   359			mpq7920_parse_dt(&client->dev, info);
   360	
   361		config.dev = info->dev;
   362		config.regmap = regmap;
   363		config.driver_data = info;
   364	
   365		ret = mpq7920_regulator_register(info, &config);
   366		if (ret < 0)
   367			dev_err(dev, "Failed to register regulator!\n");
   368	
   369		return ret;
   370	}
   371	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
