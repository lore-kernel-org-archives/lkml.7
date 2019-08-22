Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C13C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2027921726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbfHVNIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:08:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731794AbfHVNIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:08:54 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGX5qJ5z9sNk; Thu, 22 Aug 2019 23:08:52 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c784be435d5dae28d3b03db31753dd7a18733f0c
In-Reply-To: <1557906352-29048-1-git-send-email-ego@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/pseries: Fix cpu_hotplug_lock acquisition in resize_hpt()
Message-Id: <46DlGX5qJ5z9sNk@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:08:52 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 07:45:52 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The calls to arch_add_memory()/arch_remove_memory() are always made
> with the read-side cpu_hotplug_lock acquired via
> memory_hotplug_begin().  On pSeries,
> arch_add_memory()/arch_remove_memory() eventually call resize_hpt()
> which in turn calls stop_machine() which acquires the read-side
> cpu_hotplug_lock again, thereby resulting in the recursive acquisition
> of this lock.
...
> 
> Fix this issue by
>   1) Requiring all the calls to pseries_lpar_resize_hpt() be made
>      with cpu_hotplug_lock held.
> 
>   2) In pseries_lpar_resize_hpt() invoke stop_machine_cpuslocked()
>      as a consequence of 1)
> 
>   3) To satisfy 1), in hpt_order_set(), call mmu_hash_ops.resize_hpt()
>      with cpu_hotplug_lock held.
> 
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c784be435d5dae28d3b03db31753dd7a18733f0c

cheers
