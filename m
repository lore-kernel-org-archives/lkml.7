Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5913CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2207C206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577779649;
	bh=4rf1EGZ1dD8xBoMjvu9e8yy5rn5psHM91b0SJBhtKj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rNt3LjdEEgP2b1zaBeoSz62ws53eSj/SiWW/42sEBUOl6tO1x+hXHEcZoPYALK0aK
	 uAkGFvwUJmTfJXrZybCnlh6DZSLqi51KvUV55+aNemmtHBR8bpVRO6rx7b00vHSIKk
	 CKtJQwtzSe6pwfm/KdjPqaiGIK6xArHq4DW9xRqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLaIH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 03:07:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37202 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfLaIH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 03:07:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so34720049edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 00:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bGuUl/aBL2OgivOMmQPi9elv22h6HOh655j0TjOw9KI=;
        b=RMnfp3dB1Kup4J3kOKHF+QeukevxkucgDYpbFzzw6h/xTpd0/spkMTo+aC1h1KgcF0
         kQ4bxxvSVa9go73vm20lLpj9V3PFn5b6h1MdDUkOFAMdx+Ni/aO1bGOqWzLdaoKK5wWs
         FOOH9DCY7NyXg3C4zU/Pd5cuC1uKID6b2Pno9ySK53FTg2ze+UnUMTpTDwjZ8tI81kuW
         KSUHKOiPmqviR1ushDQkfJjqybGkt6ivOWLZuOw+v/Q43hgmuyYvnFkqdXiUmUBeAbQN
         ACr87gPbBWIuH1qBLDSda1eEqJnZHCIA1JIHqVNmz+Kw1DUiaCLdaKkbYM89CzW3YLMM
         C3yw==
X-Gm-Message-State: APjAAAXuVBqp+/9Szm3nXobOXcNJ7fKAetJg9OtG2twU9ubjZffmstKx
        LMvef619aleEX1iRew/y72g=
X-Google-Smtp-Source: APXvYqyUAj8bK+pKQYVDqB5++Bf/GRvlOmPn+lZAb7XKAKfKly/WHhtd4ywRHtqTB+Dy6Q87e8va7w==
X-Received: by 2002:a17:906:ed1:: with SMTP id u17mr74859457eji.286.1577779645556;
        Tue, 31 Dec 2019 00:07:25 -0800 (PST)
Received: from pi3 ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id dh4sm5818294edb.77.2019.12.31.00.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 00:07:24 -0800 (PST)
Date:   Tue, 31 Dec 2019 09:07:22 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu: Enable compile testing for some of drivers
Message-ID: <20191231080722.GA6804@pi3>
References: <20191230172619.17814-3-krzk@kernel.org>
 <201912311551.tBrb3BhH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201912311551.tBrb3BhH%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 03:43:39PM +0800, kbuild test robot wrote:
> Hi Krzysztof,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on iommu/next]
> [also build test WARNING on v5.5-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/iommu-omap-Fix-pointer-cast-Wpointer-to-int-cast-warnings-on-64-bit/20191231-022212
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

I saw it already while compile testing my patch. I must admit that I
could not find easy/fast fix for it.  Probably the
omap_iommu_translate() helper should be made 64-bit friendly but this
obfuscates the code. The driver and hardware supports only 32-bit addresses.

Best regards,
Krzysztof


> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/iommu/omap-iommu.c:33:0:
>    drivers/iommu/omap-iommu.c: In function 'omap_iommu_iova_to_phys':
> >> drivers/iommu/omap-iopgtable.h:44:21: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define IOPTE_MASK  (~(IOPTE_SIZE - 1))
>                         ^
> >> drivers/iommu/omap-iommu.c:1641:41: note: in expansion of macro 'IOPTE_MASK'
>        ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
>                                             ^~~~~~~~~~
>    drivers/iommu/omap-iopgtable.h:51:23: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define IOLARGE_MASK  (~(IOLARGE_SIZE - 1))
>                           ^
> >> drivers/iommu/omap-iommu.c:1643:41: note: in expansion of macro 'IOLARGE_MASK'
>        ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
>                                             ^~~~~~~~~~~~
>    drivers/iommu/omap-iopgtable.h:27:25: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define IOSECTION_MASK  (~(IOSECTION_SIZE - 1))
>                             ^
> >> drivers/iommu/omap-iommu.c:1649:41: note: in expansion of macro 'IOSECTION_MASK'
>        ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
>                                             ^~~~~~~~~~~~~~
>    drivers/iommu/omap-iopgtable.h:34:23: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define IOSUPER_MASK  (~(IOSUPER_SIZE - 1))
>                           ^
> >> drivers/iommu/omap-iommu.c:1651:41: note: in expansion of macro 'IOSUPER_MASK'
>        ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
>                                             ^~~~~~~~~~~~
> 
> vim +44 drivers/iommu/omap-iopgtable.h
> 
> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  38  
> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  39  /*
> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  40   * "small page" address mask and size definitions.
> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  41   */
> a9dcad5e375800 arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2009-01-26  42  #define IOPTE_SHIFT		12
> 5ff98fa68c88d7 drivers/iommu/omap-iopgtable.h Suman Anna   2015-07-20  43  #define IOPTE_SIZE		BIT(IOPTE_SHIFT)
> a9dcad5e375800 arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2009-01-26 @44  #define IOPTE_MASK		(~(IOPTE_SIZE - 1))
> a9dcad5e375800 arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2009-01-26  45  
> 
> :::::: The code at line 44 was first introduced by commit
> :::::: a9dcad5e375800fcb07f7617dba23b3aade8f09d omap iommu: tlb and pagetable primitives
> 
> :::::: TO: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> :::::: CC: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


