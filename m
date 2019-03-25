Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF56C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2307B20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfCYNqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:46:04 -0400
Received: from 8bytes.org ([81.169.241.247]:59000 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfCYNqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:46:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D2B422D8; Mon, 25 Mar 2019 14:46:02 +0100 (CET)
Date:   Mon, 25 Mar 2019 14:46:01 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH] svm/avic: iommu/amd: Flush IOMMU IRT after update all
 entries
Message-ID: <20190325134601.GB25350@8bytes.org>
References: <20190320081432.2606-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320081432.2606-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:14:56AM +0000, Suthikulpanit, Suravee wrote:
> When AVIC is enabled and the VM has discrete device assignment,
> the interrupt remapping table (IRT) is used to keep track of which
> destination APIC ID the IOMMU will inject the device interrput to.
> 
> This means every time a vcpu is blocked or context-switched (i.e.
> vcpu_blocking/unblocking() and vcpu_load/put()), the information
> in IRT must be updated and the IOMMU IRT flush command must be
> issued.
> 
> The current implementation flushes IOMMU IRT every time an entry
> is modified. If the assigned device has large number of interrupts
> (hence large number of entries), this would add large amount of
> overhead to vcpu context-switch. Instead, this can be optmized by
> only flush IRT once per vcpu context-switch per device after all
> IRT entries are modified.
> 
> The function amd_iommu_update_ga() is refactored to only update
> IRT entry, while the amd_iommu_sync_ga() is introduced to allow
> IRT flushing to be done separately.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm.c        | 35 ++++++++++++++++++++++++++++++++++-
>  drivers/iommu/amd_iommu.c | 20 +++++++++++++++++---
>  include/linux/amd-iommu.h | 13 ++++++++++---
>  3 files changed, 61 insertions(+), 7 deletions(-)

For the IOMMU parts:

	Acked-by: Joerg Roedel <jroedel@suse.de>
