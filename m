Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB69CC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B500620866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZEu5qqMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgABWkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:40:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49204 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbgABWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:40:41 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 002MeGkW130610;
        Thu, 2 Jan 2020 16:40:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578004816;
        bh=iY+CXAjnnmWi7PKkKhPCb/3kqbYV4sgylNQyJliTwSQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZEu5qqMSCYzSWdRn2BzeiF7A2pIrxP7uPHhY4vpBT+fqVlGJhFnY79n9h/Xygw/mS
         atGBU+RR5Stpn4c0pShXenNyX5NZ12ghl0L2w18MI3kbgKkHdS+MXe3HpG8+T8U73/
         6AnAChozzAJps4rrVOLKXu6lR6aQJ6OS3VTvLGGY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 002MeGcB014864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jan 2020 16:40:16 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 2 Jan
 2020 16:40:16 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 2 Jan 2020 16:40:16 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 002MeGRU042981;
        Thu, 2 Jan 2020 16:40:16 -0600
Subject: Re: [PATCH 3/3] iommu: Enable compile testing for some of drivers
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tero Kristo <t-kristo@ti.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20191230172619.17814-3-krzk@kernel.org>
 <201912311551.tBrb3BhH%lkp@intel.com> <20191231080722.GA6804@pi3>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <923b1f2f-2b5c-8b6e-6083-243beae09777@ti.com>
Date:   Thu, 2 Jan 2020 16:40:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191231080722.GA6804@pi3>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 12/31/19 2:07 AM, Krzysztof Kozlowski wrote:
> On Tue, Dec 31, 2019 at 03:43:39PM +0800, kbuild test robot wrote:
>> Hi Krzysztof,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on iommu/next]
>> [also build test WARNING on v5.5-rc4]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/iommu-omap-Fix-pointer-cast-Wpointer-to-int-cast-warnings-on-64-bit/20191231-022212
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
>> config: ia64-allmodconfig (attached as .config)
>> compiler: ia64-linux-gcc (GCC) 7.5.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=7.5.0 make.cross ARCH=ia64 
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> I saw it already while compile testing my patch. I must admit that I
> could not find easy/fast fix for it.  Probably the
> omap_iommu_translate() helper should be made 64-bit friendly but this
> obfuscates the code. 

>The driver and hardware supports only 32-bit addresses.

Yeah, is there a reason why you are trying to enable the build for the
OMAP IOMMU driver on 64-bit platforms or other architectures - the IP
and driver is only ever used on ARMv7 platforms, and it should already
be available for COMPILE_TEST on those.

regards
Suman

> 
> Best regards,
> Krzysztof
> 
> 
>>
>> All warnings (new ones prefixed by >>):
>>
>>    In file included from drivers/iommu/omap-iommu.c:33:0:
>>    drivers/iommu/omap-iommu.c: In function 'omap_iommu_iova_to_phys':
>>>> drivers/iommu/omap-iopgtable.h:44:21: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>     #define IOPTE_MASK  (~(IOPTE_SIZE - 1))
>>                         ^
>>>> drivers/iommu/omap-iommu.c:1641:41: note: in expansion of macro 'IOPTE_MASK'
>>        ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
>>                                             ^~~~~~~~~~
>>    drivers/iommu/omap-iopgtable.h:51:23: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>     #define IOLARGE_MASK  (~(IOLARGE_SIZE - 1))
>>                           ^
>>>> drivers/iommu/omap-iommu.c:1643:41: note: in expansion of macro 'IOLARGE_MASK'
>>        ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
>>                                             ^~~~~~~~~~~~
>>    drivers/iommu/omap-iopgtable.h:27:25: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>     #define IOSECTION_MASK  (~(IOSECTION_SIZE - 1))
>>                             ^
>>>> drivers/iommu/omap-iommu.c:1649:41: note: in expansion of macro 'IOSECTION_MASK'
>>        ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
>>                                             ^~~~~~~~~~~~~~
>>    drivers/iommu/omap-iopgtable.h:34:23: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>     #define IOSUPER_MASK  (~(IOSUPER_SIZE - 1))
>>                           ^
>>>> drivers/iommu/omap-iommu.c:1651:41: note: in expansion of macro 'IOSUPER_MASK'
>>        ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
>>                                             ^~~~~~~~~~~~
>>
>> vim +44 drivers/iommu/omap-iopgtable.h
>>
>> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  38  
>> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  39  /*
>> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  40   * "small page" address mask and size definitions.
>> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  41   */
>> a9dcad5e375800 arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2009-01-26  42  #define IOPTE_SHIFT		12
>> 5ff98fa68c88d7 drivers/iommu/omap-iopgtable.h Suman Anna   2015-07-20  43  #define IOPTE_SIZE		BIT(IOPTE_SHIFT)
>> a9dcad5e375800 arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2009-01-26 @44  #define IOPTE_MASK		(~(IOPTE_SIZE - 1))
>> a9dcad5e375800 arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2009-01-26  45  
>>
>> :::::: The code at line 44 was first introduced by commit
>> :::::: a9dcad5e375800fcb07f7617dba23b3aade8f09d omap iommu: tlb and pagetable primitives
>>
>> :::::: TO: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> :::::: CC: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>>
>> ---
>> 0-DAY kernel test infrastructure                 Open Source Technology Center
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 
> 

