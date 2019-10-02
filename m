Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C26C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45D217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfJBWhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:37:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:64110 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJBWhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:37:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 15:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="gz'50?scan'50,208,50";a="221562695"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Oct 2019 15:37:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iFnFk-0002aZ-ON; Thu, 03 Oct 2019 06:37:48 +0800
Date:   Thu, 3 Oct 2019 06:37:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@01.org, Christoph Hellwig <hch@lst.de>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Lift address space checks out of debug code
Message-ID: <201910030607.OlM3herg%lkp@intel.com>
References: <201910021341.7819A660@keescook>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="w636lgzdhh5r55mg"
Content-Disposition: inline
In-Reply-To: <201910021341.7819A660@keescook>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w636lgzdhh5r55mg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kees,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.4-rc1 next-20191002]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Kees-Cook/dma-mapping-Lift-address-space-checks-out-of-debug-code/20191003-060622
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:15:0,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from init/do_mounts.c:2:
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
>> include/linux/dma-mapping.h:588:3: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
      "%s %s: driver maps %lu bytes from %s area\n",
      ^
   include/linux/printk.h:137:10: note: in definition of macro 'no_printk'
      printk(fmt, ##__VA_ARGS__);  \
             ^~~
   include/asm-generic/bug.h:196:41: note: in expansion of macro 'WARN'
    #define WARN_ONCE(condition, format...) WARN(condition, format)
                                            ^~~~
>> include/linux/dma-mapping.h:587:2: note: in expansion of macro 'WARN_ONCE'
     WARN_ONCE(is_vmalloc_addr(ptr) || !virt_addr_valid(ptr),
     ^~~~~~~~~

vim +588 include/linux/dma-mapping.h

   582	
   583	static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
   584			size_t size, enum dma_data_direction dir, unsigned long attrs)
   585	{
   586		/* DMA must never operate on stack or other remappable places. */
 > 587		WARN_ONCE(is_vmalloc_addr(ptr) || !virt_addr_valid(ptr),
 > 588			"%s %s: driver maps %lu bytes from %s area\n",
   589			dev ? dev_driver_string(dev) : "unknown driver",
   590			dev ? dev_name(dev) : "unknown device", size,
   591			is_vmalloc_addr(ptr) ? "vmalloc" : "invalid");
   592	
   593		return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
   594				size, dir, attrs);
   595	}
   596	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--w636lgzdhh5r55mg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
BFW5M3SEaqfH1gkOFH4AbeTrWw1oAAA=

--w636lgzdhh5r55mg--
