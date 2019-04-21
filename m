Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76917C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA212086A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfDUOTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:19:20 -0400
Received: from ozlabs.org ([203.11.71.1]:56223 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbfDUOTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 10:19:09 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBfL1LfBz9s5c; Mon, 22 Apr 2019 00:19:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c05f57fdc34a3d00c9ee28a35772e9d11b5ce100
X-Patchwork-Hint: ignore
In-Reply-To: <20190407024808.39821-1-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     aik@ozlabs.ru, Qian Cai <cai@lca.pw>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/pseries/iommu: fix set but not used values
Message-Id: <44nBfL1LfBz9s5c@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:19:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-04-07 at 02:48:08 UTC, Qian Cai wrote:
> The commit b7d6bf4fdd47 ("powerpc/pseries/pci: Remove obsolete SW
> invalidate") left 2 variables unused.
> 
> arch/powerpc/platforms/pseries/iommu.c: In function 'tce_build_pSeries':
> arch/powerpc/platforms/pseries/iommu.c:108:17: warning: variable 'tces'
> set but not used [-Wunused-but-set-variable]
>   __be64 *tcep, *tces;
>                  ^~~~
> arch/powerpc/platforms/pseries/iommu.c: In function 'tce_free_pSeries':
> arch/powerpc/platforms/pseries/iommu.c:132:17: warning: variable 'tces'
> set but not used [-Wunused-but-set-variable]
>   __be64 *tcep, *tces;
>                  ^~~~
> 
> Also, the commit 68c0449ea16d ("powerpc/pseries/iommu: Use memory@ nodes
> in max RAM address calculation") set "ranges" in
> ddw_memory_hotplug_max() but never use it.
> 
> arch/powerpc/platforms/pseries/iommu.c: In function
> 'ddw_memory_hotplug_max':
> arch/powerpc/platforms/pseries/iommu.c:948:7: warning: variable 'ranges'
> set but not used [-Wunused-but-set-variable]
>    int ranges, n_mem_addr_cells, n_mem_size_cells, len;
>        ^~~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c05f57fdc34a3d00c9ee28a35772e9d1

cheers
