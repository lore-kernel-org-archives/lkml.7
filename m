Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D759C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B76520862
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfJEOy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:54:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:44273 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfJEOyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:54:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2019 07:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,260,1566889200"; 
   d="gz'50?scan'50,208,50";a="199121194"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2019 07:54:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iGlSN-000GVU-D2; Sat, 05 Oct 2019 22:54:51 +0800
Date:   Sat, 5 Oct 2019 22:53:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@01.org, Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] dma-mapping: Move vmap address checks into
 dma_map_single()
Message-ID: <201910052236.X97C7dDP%lkp@intel.com>
References: <201910041420.F6E55D29A@keescook>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lgetilakeoklilb3"
Content-Disposition: inline
In-Reply-To: <201910041420.F6E55D29A@keescook>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgetilakeoklilb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kees,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.4-rc1 next-20191004]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Kees-Cook/dma-mapping-Move-vmap-address-checks-into-dma_map_single/20191005-073954
config: i386-randconfig-d001-201939 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/init.h:5:0,
                    from sound/pci/ad1889.c:23:
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
   include/linux/dma-mapping.h:588:9: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
            "%s %s: driver maps %lu bytes from vmalloc area\n",
            ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> include/linux/dma-mapping.h:587:2: note: in expansion of macro 'if'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
     ^~
   include/asm-generic/bug.h:124:3: note: in expansion of macro '__WARN_printf'
      __WARN_printf(TAINT_WARN, format);   \
      ^~~~~~~~~~~~~
   include/asm-generic/bug.h:155:3: note: in expansion of macro 'WARN'
      WARN(1, format);    \
      ^~~~
   include/linux/dma-mapping.h:587:6: note: in expansion of macro 'WARN_ONCE'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
         ^~~~~~~~~
   include/linux/dma-mapping.h:588:9: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
            "%s %s: driver maps %lu bytes from vmalloc area\n",
            ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> include/linux/dma-mapping.h:587:2: note: in expansion of macro 'if'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
     ^~
   include/asm-generic/bug.h:124:3: note: in expansion of macro '__WARN_printf'
      __WARN_printf(TAINT_WARN, format);   \
      ^~~~~~~~~~~~~
   include/asm-generic/bug.h:155:3: note: in expansion of macro 'WARN'
      WARN(1, format);    \
      ^~~~
   include/linux/dma-mapping.h:587:6: note: in expansion of macro 'WARN_ONCE'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
         ^~~~~~~~~
   include/linux/dma-mapping.h:588:9: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
            "%s %s: driver maps %lu bytes from vmalloc area\n",
            ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> include/linux/dma-mapping.h:587:2: note: in expansion of macro 'if'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
     ^~
   include/asm-generic/bug.h:124:3: note: in expansion of macro '__WARN_printf'
      __WARN_printf(TAINT_WARN, format);   \
      ^~~~~~~~~~~~~
   include/asm-generic/bug.h:155:3: note: in expansion of macro 'WARN'
      WARN(1, format);    \
      ^~~~
   include/linux/dma-mapping.h:587:6: note: in expansion of macro 'WARN_ONCE'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
         ^~~~~~~~~
--
   In file included from include/linux/export.h:44:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/linux/delay.h:22,
                    from sound/pci//hda/hda_intel.c:23:
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
   include/linux/dma-mapping.h:588:9: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
            "%s %s: driver maps %lu bytes from vmalloc area\n",
            ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> include/linux/dma-mapping.h:587:2: note: in expansion of macro 'if'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
     ^~
   include/asm-generic/bug.h:124:3: note: in expansion of macro '__WARN_printf'
      __WARN_printf(TAINT_WARN, format);   \
      ^~~~~~~~~~~~~
   include/asm-generic/bug.h:155:3: note: in expansion of macro 'WARN'
      WARN(1, format);    \
      ^~~~
   include/linux/dma-mapping.h:587:6: note: in expansion of macro 'WARN_ONCE'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
         ^~~~~~~~~
   include/linux/dma-mapping.h:588:9: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
            "%s %s: driver maps %lu bytes from vmalloc area\n",
            ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> include/linux/dma-mapping.h:587:2: note: in expansion of macro 'if'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
     ^~
   include/asm-generic/bug.h:124:3: note: in expansion of macro '__WARN_printf'
      __WARN_printf(TAINT_WARN, format);   \
      ^~~~~~~~~~~~~
   include/asm-generic/bug.h:155:3: note: in expansion of macro 'WARN'
      WARN(1, format);    \
      ^~~~
   include/linux/dma-mapping.h:587:6: note: in expansion of macro 'WARN_ONCE'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
         ^~~~~~~~~
   include/linux/dma-mapping.h:588:9: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
            "%s %s: driver maps %lu bytes from vmalloc area\n",
            ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> include/linux/dma-mapping.h:587:2: note: in expansion of macro 'if'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
     ^~
   include/asm-generic/bug.h:124:3: note: in expansion of macro '__WARN_printf'
      __WARN_printf(TAINT_WARN, format);   \
      ^~~~~~~~~~~~~
   include/asm-generic/bug.h:155:3: note: in expansion of macro 'WARN'
      WARN(1, format);    \
      ^~~~
   include/linux/dma-mapping.h:587:6: note: in expansion of macro 'WARN_ONCE'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
         ^~~~~~~~~
   In file included from sound/pci//hda/hda_intel_trace.h:54:0,
                    from sound/pci//hda/hda_intel.c:58:
   include/trace/define_trace.h: At top level:
   include/trace/define_trace.h:95:42: fatal error: ./hda_intel_trace.h: No such file or directory
    #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
                                             ^
   compilation terminated.

vim +/if +587 include/linux/dma-mapping.h

   582	
   583	static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
   584			size_t size, enum dma_data_direction dir, unsigned long attrs)
   585	{
   586		/* DMA must never operate on areas that might be remapped. */
 > 587		if (WARN_ONCE(is_vmalloc_addr(ptr),
 > 588			      "%s %s: driver maps %lu bytes from vmalloc area\n",
   589			      dev ? dev_driver_string(dev) : "unknown driver",
   590			      dev ? dev_name(dev) : "unknown device", size))
   591			return DMA_MAPPING_ERROR;
   592	
   593		debug_dma_map_single(dev, ptr, size);
   594		return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
   595				size, dir, attrs);
   596	}
   597	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--lgetilakeoklilb3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Ysra+X90xNc+LBECAA==

--lgetilakeoklilb3--
