Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4A8C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790B620874
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfHKXz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 19:55:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:22926 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfHKXz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 19:55:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 16:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,375,1559545200"; 
   d="gz'50?scan'50,208,50";a="187261540"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2019 16:54:58 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hwxft-000IoX-Ok; Mon, 12 Aug 2019 07:54:57 +0800
Date:   Mon, 12 Aug 2019 07:54:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: drivers/dma/fsldma.c:1165:26: warning: this statement may fall
 through
Message-ID: <201908120721.RrTbsYsP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mi2e35y3rnhfqezy"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mi2e35y3rnhfqezy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d45331b00ddb179e291766617259261c112db872
commit: a035d552a93bb9ef6048733bb9f2a0dc857ff869 Makefile: Globally enable fall-through warning
date:   2 weeks ago
config: powerpc-ppa8548_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a035d552a93bb9ef6048733bb9f2a0dc857ff869
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma/fsldma.c: In function 'fsl_dma_chan_probe':
>> drivers/dma/fsldma.c:1165:26: warning: this statement may fall through [-Wimplicit-fallthrough=]
      chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
      ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/fsldma.c:1166:2: note: here
     case FSL_DMA_IP_83XX:
     ^~~~

vim +1165 drivers/dma/fsldma.c

a4f56d4b103d4e Ira Snyder               2010-01-06  1104  
463a1f8b3ceebe Bill Pemberton           2012-11-19  1105  static int fsl_dma_chan_probe(struct fsldma_device *fdev,
77cd62e8082b97 Timur Tabi               2008-09-26  1106  	struct device_node *node, u32 feature, const char *compatible)
173acc7ce8538f Zhang Wei                2008-03-01  1107  {
a1c03319018061 Ira Snyder               2010-01-06  1108  	struct fsldma_chan *chan;
4ce0e953f62867 Ira Snyder               2010-01-06  1109  	struct resource res;
173acc7ce8538f Zhang Wei                2008-03-01  1110  	int err;
173acc7ce8538f Zhang Wei                2008-03-01  1111  
173acc7ce8538f Zhang Wei                2008-03-01  1112  	/* alloc channel */
a1c03319018061 Ira Snyder               2010-01-06  1113  	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
a1c03319018061 Ira Snyder               2010-01-06  1114  	if (!chan) {
e7a29151de1bd5 Ira Snyder               2010-01-06  1115  		err = -ENOMEM;
e7a29151de1bd5 Ira Snyder               2010-01-06  1116  		goto out_return;
e7a29151de1bd5 Ira Snyder               2010-01-06  1117  	}
e7a29151de1bd5 Ira Snyder               2010-01-06  1118  
e7a29151de1bd5 Ira Snyder               2010-01-06  1119  	/* ioremap registers for use */
a1c03319018061 Ira Snyder               2010-01-06  1120  	chan->regs = of_iomap(node, 0);
a1c03319018061 Ira Snyder               2010-01-06  1121  	if (!chan->regs) {
e7a29151de1bd5 Ira Snyder               2010-01-06  1122  		dev_err(fdev->dev, "unable to ioremap registers\n");
e7a29151de1bd5 Ira Snyder               2010-01-06  1123  		err = -ENOMEM;
a1c03319018061 Ira Snyder               2010-01-06  1124  		goto out_free_chan;
173acc7ce8538f Zhang Wei                2008-03-01  1125  	}
173acc7ce8538f Zhang Wei                2008-03-01  1126  
4ce0e953f62867 Ira Snyder               2010-01-06  1127  	err = of_address_to_resource(node, 0, &res);
173acc7ce8538f Zhang Wei                2008-03-01  1128  	if (err) {
e7a29151de1bd5 Ira Snyder               2010-01-06  1129  		dev_err(fdev->dev, "unable to find 'reg' property\n");
e7a29151de1bd5 Ira Snyder               2010-01-06  1130  		goto out_iounmap_regs;
173acc7ce8538f Zhang Wei                2008-03-01  1131  	}
173acc7ce8538f Zhang Wei                2008-03-01  1132  
a1c03319018061 Ira Snyder               2010-01-06  1133  	chan->feature = feature;
173acc7ce8538f Zhang Wei                2008-03-01  1134  	if (!fdev->feature)
a1c03319018061 Ira Snyder               2010-01-06  1135  		fdev->feature = chan->feature;
173acc7ce8538f Zhang Wei                2008-03-01  1136  
e7a29151de1bd5 Ira Snyder               2010-01-06  1137  	/*
e7a29151de1bd5 Ira Snyder               2010-01-06  1138  	 * If the DMA device's feature is different than the feature
e7a29151de1bd5 Ira Snyder               2010-01-06  1139  	 * of its channels, report the bug
173acc7ce8538f Zhang Wei                2008-03-01  1140  	 */
a1c03319018061 Ira Snyder               2010-01-06  1141  	WARN_ON(fdev->feature != chan->feature);
e7a29151de1bd5 Ira Snyder               2010-01-06  1142  
a1c03319018061 Ira Snyder               2010-01-06  1143  	chan->dev = fdev->dev;
8de7a7d95049bd Hongbo Zhang             2013-09-26  1144  	chan->id = (res.start & 0xfff) < 0x300 ?
8de7a7d95049bd Hongbo Zhang             2013-09-26  1145  		   ((res.start - 0x100) & 0xfff) >> 7 :
8de7a7d95049bd Hongbo Zhang             2013-09-26  1146  		   ((res.start - 0x200) & 0xfff) >> 7;
a1c03319018061 Ira Snyder               2010-01-06  1147  	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
e7a29151de1bd5 Ira Snyder               2010-01-06  1148  		dev_err(fdev->dev, "too many channels for device\n");
173acc7ce8538f Zhang Wei                2008-03-01  1149  		err = -EINVAL;
e7a29151de1bd5 Ira Snyder               2010-01-06  1150  		goto out_iounmap_regs;
173acc7ce8538f Zhang Wei                2008-03-01  1151  	}
173acc7ce8538f Zhang Wei                2008-03-01  1152  
a1c03319018061 Ira Snyder               2010-01-06  1153  	fdev->chan[chan->id] = chan;
a1c03319018061 Ira Snyder               2010-01-06  1154  	tasklet_init(&chan->tasklet, dma_do_tasklet, (unsigned long)chan);
b158471ef63bf3 Ira Snyder               2011-03-03  1155  	snprintf(chan->name, sizeof(chan->name), "chan%d", chan->id);
e7a29151de1bd5 Ira Snyder               2010-01-06  1156  
e7a29151de1bd5 Ira Snyder               2010-01-06  1157  	/* Initialize the channel */
a1c03319018061 Ira Snyder               2010-01-06  1158  	dma_init(chan);
173acc7ce8538f Zhang Wei                2008-03-01  1159  
173acc7ce8538f Zhang Wei                2008-03-01  1160  	/* Clear cdar registers */
a1c03319018061 Ira Snyder               2010-01-06  1161  	set_cdar(chan, 0);
173acc7ce8538f Zhang Wei                2008-03-01  1162  
a1c03319018061 Ira Snyder               2010-01-06  1163  	switch (chan->feature & FSL_DMA_IP_MASK) {
173acc7ce8538f Zhang Wei                2008-03-01  1164  	case FSL_DMA_IP_85XX:
a1c03319018061 Ira Snyder               2010-01-06 @1165  		chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
173acc7ce8538f Zhang Wei                2008-03-01  1166  	case FSL_DMA_IP_83XX:
a1c03319018061 Ira Snyder               2010-01-06  1167  		chan->toggle_ext_start = fsl_chan_toggle_ext_start;
a1c03319018061 Ira Snyder               2010-01-06  1168  		chan->set_src_loop_size = fsl_chan_set_src_loop_size;
a1c03319018061 Ira Snyder               2010-01-06  1169  		chan->set_dst_loop_size = fsl_chan_set_dst_loop_size;
a1c03319018061 Ira Snyder               2010-01-06  1170  		chan->set_request_count = fsl_chan_set_request_count;
173acc7ce8538f Zhang Wei                2008-03-01  1171  	}
173acc7ce8538f Zhang Wei                2008-03-01  1172  
a1c03319018061 Ira Snyder               2010-01-06  1173  	spin_lock_init(&chan->desc_lock);
9c3a50b7d7ec45 Ira Snyder               2010-01-06  1174  	INIT_LIST_HEAD(&chan->ld_pending);
9c3a50b7d7ec45 Ira Snyder               2010-01-06  1175  	INIT_LIST_HEAD(&chan->ld_running);
43452fadd614b6 Hongbo Zhang             2014-05-21  1176  	INIT_LIST_HEAD(&chan->ld_completed);
f04cd40701deac Ira Snyder               2011-03-03  1177  	chan->idle = true;
14c6a3333c8e88 Hongbo Zhang             2014-05-21  1178  #ifdef CONFIG_PM
14c6a3333c8e88 Hongbo Zhang             2014-05-21  1179  	chan->pm_state = RUNNING;
14c6a3333c8e88 Hongbo Zhang             2014-05-21  1180  #endif
173acc7ce8538f Zhang Wei                2008-03-01  1181  
a1c03319018061 Ira Snyder               2010-01-06  1182  	chan->common.device = &fdev->common;
8ac695463f37af Russell King - ARM Linux 2012-03-06  1183  	dma_cookie_init(&chan->common);
173acc7ce8538f Zhang Wei                2008-03-01  1184  
d3f620b2c4fecd Ira Snyder               2010-01-06  1185  	/* find the IRQ line, if it exists in the device tree */
a1c03319018061 Ira Snyder               2010-01-06  1186  	chan->irq = irq_of_parse_and_map(node, 0);
d3f620b2c4fecd Ira Snyder               2010-01-06  1187  
173acc7ce8538f Zhang Wei                2008-03-01  1188  	/* Add the channel to DMA device channel list */
a1c03319018061 Ira Snyder               2010-01-06  1189  	list_add_tail(&chan->common.device_node, &fdev->common.channels);
173acc7ce8538f Zhang Wei                2008-03-01  1190  
a1c03319018061 Ira Snyder               2010-01-06  1191  	dev_info(fdev->dev, "#%d (%s), irq %d\n", chan->id, compatible,
aa570be6de67f3 Michael Ellerman         2016-09-10  1192  		 chan->irq ? chan->irq : fdev->irq);
173acc7ce8538f Zhang Wei                2008-03-01  1193  
173acc7ce8538f Zhang Wei                2008-03-01  1194  	return 0;
51ee87f27a1d2c Li Yang                  2008-05-29  1195  
e7a29151de1bd5 Ira Snyder               2010-01-06  1196  out_iounmap_regs:
a1c03319018061 Ira Snyder               2010-01-06  1197  	iounmap(chan->regs);
a1c03319018061 Ira Snyder               2010-01-06  1198  out_free_chan:
a1c03319018061 Ira Snyder               2010-01-06  1199  	kfree(chan);
e7a29151de1bd5 Ira Snyder               2010-01-06  1200  out_return:
173acc7ce8538f Zhang Wei                2008-03-01  1201  	return err;
173acc7ce8538f Zhang Wei                2008-03-01  1202  }
173acc7ce8538f Zhang Wei                2008-03-01  1203  

:::::: The code at line 1165 was first introduced by commit
:::::: a1c03319018061304be28d131073ac13a5cb86fb fsldma: rename fsl_chan to chan

:::::: TO: Ira Snyder <iws@ovro.caltech.edu>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mi2e35y3rnhfqezy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
B1b1oZwH0wAA

--mi2e35y3rnhfqezy--
