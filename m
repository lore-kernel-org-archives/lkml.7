Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8E521841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCTRcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:32:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43588 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfCTRcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:32:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AAFDA78;
        Wed, 20 Mar 2019 10:32:02 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8BA3F614;
        Wed, 20 Mar 2019 10:31:59 -0700 (PDT)
Date:   Wed, 20 Mar 2019 17:31:54 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <kvmarm@lists.cs.columbia.edu>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>,
        <julien.thierry@arm.com>, <wanghaibin.wang@huawei.com>,
        <lious.lilei@hisilicon.com>, <lishuo1@hisilicon.com>,
        <zhengxiang9@huawei.com>, <yuzenghui@huawei.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH v2] kvm: arm: Fix handling of stage2 huge mappings
Message-ID: <20190320173154.6cfc7072@why.wild-wind.fr.eu.org>
In-Reply-To: <1553093839-29317-1-git-send-email-suzuki.poulose@arm.com>
References: <1553093839-29317-1-git-send-email-suzuki.poulose@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 14:57:19 +0000
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> We rely on the mmu_notifier call backs to handle the split/merge
> of huge pages and thus we are guaranteed that, while creating a
> block mapping, either the entire block is unmapped at stage2 or it
> is missing permission.
> 
> However, we miss a case where the block mapping is split for dirty
> logging case and then could later be made block mapping, if we cancel the
> dirty logging. This not only creates inconsistent TLB entries for
> the pages in the the block, but also leakes the table pages for
> PMD level.
> 
> Handle this corner case for the huge mappings at stage2 by
> unmapping the non-huge mapping for the block. This could potentially
> release the upper level table. So we need to restart the table walk
> once we unmap the range.
> 
> Fixes : ad361f093c1e31d ("KVM: ARM: Support hugetlbfs backed huge pages")
> Reported-by: Zheng Xiang <zhengxiang9@huawei.com>
> Cc: Zheng Xiang <zhengxiang9@huawei.com>
> Cc: Zhenghui Yu <yuzenghui@huawei.com>
       ^
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Applied, with Zenghui's name fixed.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
