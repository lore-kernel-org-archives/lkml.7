Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C815C2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECC020836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mROG/HOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfLKFvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:51:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44769 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKFvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:51:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id bh2so953065plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 21:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lLapnIIb6lVWR88dgYwHj0pEFw/ZzVii/Ej9vRXRHTM=;
        b=mROG/HOXnDdmgjbz5J5ouZ0n9b8BoMdcOxlbXxqEDlEjoAq7Dntbf93vu7bBjTHium
         kAR7DNGI1KuqmYjaldUi0+7gcE227rB4ZIq9u73q2ekVwwKsF7fNWMrljGVA3U8Cx2zc
         /3zNmHq33VSz2DEMoqccgdoWCigZiyKx+gaqz4PZJGFrGsrx+FqpUo0lT4gbAgDWjvRc
         8rkIqPoeMva5PCorMQUOOARnM7YrnvsEKcY2qShZwkBEyJCKOb7Glgv3iVJWE0hx+l4a
         oYR3satfkmDNaLOG4317KCiIXwzqulGwWmnW/YIK0rjquaVMKbN31pnBC43kBCFdelbQ
         40dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lLapnIIb6lVWR88dgYwHj0pEFw/ZzVii/Ej9vRXRHTM=;
        b=mJTKRQHLbB7qrn99uD/pS2CMHLQdDOYo0pF/8pXwNyk10/w1JSVD9QyCS81cMVdpHE
         K+hSy41HtVAllCKkLnTd0Rnk1xfGjLl5OF1CAYnmaRx2GjIYpKw5lQ/I4iQfh1cEA4Yd
         7udp8NmDnqCka+2xMBfle6lvb7Z/kzw/KSwEVIATE5Tboy0vrhuFQwwpcqHh6j6BsZ5Y
         PnpjGvq77WxVX8X/C2OhCJrR2Ot2p68p7qQXPMOrM0/cJUs/ECrzoYIAGYZB8ZOXQYqD
         DMxDmmITdvTVATS9aNKlVzsq8zsmcYpzGTzClGsveR7j+4ktQF4Y5LL4NvmBlefAnHYX
         2wiw==
X-Gm-Message-State: APjAAAXl3aJdEEg2NULDtUj14ZQV+RCSXiwl2nGXFZszeRSVqtBvV12F
        giQI1GPSbBJMX/CU296LnWrOFQ==
X-Google-Smtp-Source: APXvYqzb6DmUBn52QUZxXvhWxCspFS4mNZV2nAvBl5SaYNTj0HvIx72deigYfD3dWXLAJ2R1ktVXxg==
X-Received: by 2002:a17:90a:2808:: with SMTP id e8mr1537917pjd.63.1576043465746;
        Tue, 10 Dec 2019 21:51:05 -0800 (PST)
Received: from ?IPv6:240e:362:417:e00:d1ed:4eb5:7aae:41c8? ([240e:362:417:e00:d1ed:4eb5:7aae:41c8])
        by smtp.gmail.com with ESMTPSA id u1sm988461pfn.133.2019.12.10.21.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 21:51:04 -0800 (PST)
Subject: Re: [RESEND PATCH v9 2/4] uacce: add uacce driver
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
References: <1575945755-27380-3-git-send-email-zhangfei.gao@linaro.org>
 <201912110600.7K87vvu4%lkp@intel.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <9aa3ec9b-6ca3-c8cc-a381-5445d34d0ed5@linaro.org>
Date:   Wed, 11 Dec 2019 13:50:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201912110600.7K87vvu4%lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/11 上午8:09, kbuild test robot wrote:
> Hi Zhangfei,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on cryptodev/master]
> [also build test ERROR on crypto/master char-misc/char-misc-testing v5.5-rc1 next-20191210]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Zhangfei-Gao/Add-uacce-module-for-Accelerator/20191210-160210
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 7.5.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.5.0 make.cross ARCH=sparc64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     drivers/misc/uacce/uacce.c:112:15: error: variable 'uacce_sva_ops' has initializer but incomplete type
>      static struct iommu_sva_ops uacce_sva_ops = {
>                    ^~~~~~~~~~~~~
>     drivers/misc/uacce/uacce.c:113:3: error: 'struct iommu_sva_ops' has no member named 'mm_exit'
>       .mm_exit = uacce_sva_exit,
>        ^~~~~~~
>     drivers/misc/uacce/uacce.c:113:13: warning: excess elements in struct initializer
>       .mm_exit = uacce_sva_exit,
>                  ^~~~~~~~~~~~~~
>     drivers/misc/uacce/uacce.c:113:13: note: (near initialization for 'uacce_sva_ops')
>     drivers/misc/uacce/uacce.c: In function 'uacce_mm_get':
>     drivers/misc/uacce/uacce.c:144:12: error: implicit declaration of function 'iommu_sva_bind_device'; did you mean 'bus_find_device'? [-Werror=implicit-function-declaration]
>        handle = iommu_sva_bind_device(uacce->parent, mm, uacce_mm);
>                 ^~~~~~~~~~~~~~~~~~~~~
>                 bus_find_device
>     drivers/misc/uacce/uacce.c:144:10: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>        handle = iommu_sva_bind_device(uacce->parent, mm, uacce_mm);
>               ^
>     drivers/misc/uacce/uacce.c:148:9: error: implicit declaration of function 'iommu_sva_set_ops'; did you mean 'iommu_setup_dma_ops'? [-Werror=implicit-function-declaration]
>        ret = iommu_sva_set_ops(handle, &uacce_sva_ops);
>              ^~~~~~~~~~~~~~~~~
>              iommu_setup_dma_ops
>     drivers/misc/uacce/uacce.c:152:21: error: implicit declaration of function 'iommu_sva_get_pasid' [-Werror=implicit-function-declaration]
>        uacce_mm->pasid = iommu_sva_get_pasid(handle);
>                          ^~~~~~~~~~~~~~~~~~~
>>> drivers/misc/uacce/uacce.c:153:26: error: 'IOMMU_PASID_INVALID' undeclared (first use in this function); did you mean 'HV_MSIVALID_INVALID'?
>        if (uacce_mm->pasid == IOMMU_PASID_INVALID)
>                               ^~~~~~~~~~~~~~~~~~~
>                               HV_MSIVALID_INVALID
>     drivers/misc/uacce/uacce.c:153:26: note: each undeclared identifier is reported only once for each function it appears in
>     drivers/misc/uacce/uacce.c:168:3: error: implicit declaration of function 'iommu_sva_unbind_device'; did you mean 'bus_find_device'? [-Werror=implicit-function-declaration]
>        iommu_sva_unbind_device(handle);
>        ^~~~~~~~~~~~~~~~~~~~~~~
>        bus_find_device
>     drivers/misc/uacce/uacce.c: At top level:
>>> drivers/misc/uacce/uacce.c:274:21: error: variable 'uacce_vm_ops' has initializer but incomplete type
>      static const struct vm_operations_struct uacce_vm_ops = {
>                          ^~~~~~~~~~~~~~~~~~~~
>>> drivers/misc/uacce/uacce.c:275:3: error: 'const struct vm_operations_struct' has no member named 'close'
>       .close = uacce_vma_close,
>        ^~~~~
>     drivers/misc/uacce/uacce.c:275:11: warning: excess elements in struct initializer
>       .close = uacce_vma_close,
>                ^~~~~~~~~~~~~~~
>     drivers/misc/uacce/uacce.c:275:11: note: (near initialization for 'uacce_vm_ops')
>     drivers/misc/uacce/uacce.c: In function 'uacce_fops_mmap':
>>> drivers/misc/uacce/uacce.c:295:19: error: 'VM_DONTCOPY' undeclared (first use in this function)
>       vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_WIPEONFORK;
>                        ^~~~~~~~~~~
>>> drivers/misc/uacce/uacce.c:295:33: error: 'VM_DONTEXPAND' undeclared (first use in this function); did you mean 'VM_DONTCOPY'?
>       vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_WIPEONFORK;
>                                      ^~~~~~~~~~~~~
>                                      VM_DONTCOPY
>>> drivers/misc/uacce/uacce.c:295:49: error: 'VM_WIPEONFORK' undeclared (first use in this function)
>       vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_WIPEONFORK;
>                                                      ^~~~~~~~~~~~~
>     drivers/misc/uacce/uacce.c: In function 'uacce_alloc':
>     drivers/misc/uacce/uacce.c:502:9: error: implicit declaration of function 'iommu_dev_enable_feature'; did you mean 'module_enable_ro'? [-Werror=implicit-function-declaration]
>        ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
>              ^~~~~~~~~~~~~~~~~~~~~~~~
>              module_enable_ro
>     drivers/misc/uacce/uacce.c:502:42: error: 'IOMMU_DEV_FEAT_SVA' undeclared (first use in this function); did you mean 'NOMMU_VMFLAGS'?
>        ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
>                                               ^~~~~~~~~~~~~~~~~~
>                                               NOMMU_VMFLAGS
>     drivers/misc/uacce/uacce.c:530:3: error: implicit declaration of function 'iommu_dev_disable_feature'; did you mean 'module_disable_ro'? [-Werror=implicit-function-declaration]
>        iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~
>        module_disable_ro
>     drivers/misc/uacce/uacce.c: In function 'uacce_remove':
>     drivers/misc/uacce/uacce.c:592:44: error: 'IOMMU_DEV_FEAT_SVA' undeclared (first use in this function); did you mean 'NOMMU_VMFLAGS'?
>        iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
>                                                 ^~~~~~~~~~~~~~~~~~
>                                                 NOMMU_VMFLAGS
>     drivers/misc/uacce/uacce.c: At top level:
>     drivers/misc/uacce/uacce.c:112:29: error: storage size of 'uacce_sva_ops' isn't known
>      static struct iommu_sva_ops uacce_sva_ops = {
>                                  ^~~~~~~~~~~~~
>>> drivers/misc/uacce/uacce.c:274:42: error: storage size of 'uacce_vm_ops' isn't known
>
The build issue can be solved by
-#include <linux/dma-iommu.h>
+#include <linux/dma-mapping.h>
+#include <linux/iommu.h>

Since CONFIG_IOMMU_DMA is not defined in the arch.
include/linux/dma-iommu.h
#ifdef CONFIG_IOMMU_DMA
#include <linux/dma-mapping.h>
#include <linux/iommu.h>

Will update later.

Thanks
