Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD4C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 11:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5407A21835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 11:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLGLoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 06:44:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:47632 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLGLo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 06:44:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2019 03:44:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,287,1571727600"; 
   d="gz'50?scan'50,208,50";a="206391560"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2019 03:44:23 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1idYVa-000HSL-Ug; Sat, 07 Dec 2019 19:44:22 +0800
Date:   Sat, 7 Dec 2019 19:44:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     kbuild-all@lists.01.org, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        luto@kernel.org, peterz@infradead.org, dave.hansen@linux-intel.com,
        konrad.wilk@oracle.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <201912071913.N8iDqXct%lkp@intel.com>
References: <20191206003652.14102-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6f26a4mbvvngazog"
Content-Disposition: inline
In-Reply-To: <20191206003652.14102-1-Ashish.Kalra@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6f26a4mbvvngazog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ashish,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hch-configfs/for-next]
[also build test ERROR on linus/master v5.4 next-20191202]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Ashish-Kalra/swiotlb-Adjust-SWIOTBL-bounce-buffer-size-for-SEV-guests/20191207-184151
base:   git://git.infradead.org/users/hch/configfs.git for-next
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/pci-dma.c:2:0:
>> include/linux/dma-direct.h:49:1: error: expected identifier or '(' before '{' token
    {
    ^
   include/linux/dma-direct.h:47:29: warning: 'adjust_swiotlb_default_size' declared 'static' but never defined [-Wunused-function]
    static inline unsigned long adjust_swiotlb_default_size
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +49 include/linux/dma-direct.h

    43	
    44	#ifdef CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
    45	unsigned long adjust_swiotlb_default_size(unsigned long default_size);
    46	#else
    47	static inline unsigned long adjust_swiotlb_default_size
    48			(unsigned long default_size);
  > 49	{
    50		return default_size;
    51	}
    52	#endif	/* CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT */
    53	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--6f26a4mbvvngazog
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
NoKq3Bk6omqnx9YJDhR+ABLGPtEMaAAA

--6f26a4mbvvngazog--
