Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FEAC06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6960E2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGBKo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:44:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbfGBKo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:44:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35ED8636E3FD535B37C2;
        Tue,  2 Jul 2019 18:40:47 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 18:40:45 +0800
Subject: Re: linux-next: Tree for Jul 2
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20190702195158.79aa5517@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <000f56ac-2abc-bc6a-e2db-5ae38779d276@hisilicon.com>
Date:   Tue, 2 Jul 2019 18:40:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20190702195158.79aa5517@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Will Deacon

There is a compiler failure on arm64 platform, as follow:
In file included from ./include/linux/list.h:9:0,
                 from ./include/linux/kobject.h:19,
                 from ./include/linux/of.h:17,
                 from ./include/linux/irqdomain.h:35,
                 from ./include/linux/acpi.h:13,
                 from drivers/iommu/arm-smmu-v3.c:12:
drivers/iommu/arm-smmu-v3.c: In function ‘arm_smmu_device_hw_probe’:
drivers/iommu/arm-smmu-v3.c:194:40: error: ‘CONFIG_CMA_ALIGNMENT’ undeclared (first use in this function)
 #define Q_MAX_SZ_SHIFT   (PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
                                        ^
It's the commit <d25f6ead162e> ("iommu/arm-smmu-v3: Increase maximum size of queues")

Thanks,
Shaokun

On 2019/7/2 17:51, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190701:
> 
> New trees: iomap, djw-vfs
> 
> The m68knommu tree gained conflicts against the m68k tree.
> 
> The xfs tree lost its build failure.
> 
> The pm tree lost its build failure.
> 
> The rdma tree still had its build failures so I used the version from
> next-20190628.
> 
> The net-next tree gained a conflict against the net tree.
> 
> The mlx5-next tree gained conflicts against Linus' tree.
> 
> The tip tree gained a conflict against the btrfs-kdave tree which
> required a merge fix patch.
> 
> The hmm tree gained build failures due to interactions with the tip and
> drm trees for which I added a merge fix patch and disabled a driver.
> 
> Non-merge commits (relative to Linus' tree): 10449
>  10116 files changed, 811540 insertions(+), 297040 deletions(-)
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig. And finally, a simple boot test of the powerpc
> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
> 
> Below is a summary of the state of the merge.
> 
> I am currently merging 299 trees (counting Linus' and 72 trees of bug
> fix patches pending for the current merge release).
> 
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
> 
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
> 
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.
> 

