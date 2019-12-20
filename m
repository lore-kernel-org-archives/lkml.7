Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B53C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21148206EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLTInO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:43:14 -0500
Received: from 8bytes.org ([81.169.241.247]:58300 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfLTInK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:43:10 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 97A4B46B; Fri, 20 Dec 2019 09:43:08 +0100 (CET)
Date:   Fri, 20 Dec 2019 09:43:03 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org,
        kernel-team@android.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 03/16] PCI/ATS: Restore EXPORT_SYMBOL_GPL() for
 pci_{enable,disable}_ats()
Message-ID: <20191220084303.GA9347@8bytes.org>
References: <20191219120352.382-1-will@kernel.org>
 <20191219120352.382-4-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219120352.382-4-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thu, Dec 19, 2019 at 12:03:39PM +0000, Will Deacon wrote:
> From: Greg Kroah-Hartman <gregkh@google.com>
> 
> Commit d355bb209783 ("PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()")
> unexported a bunch of symbols from the PCI core since the only external
> users were non-modular IOMMU drivers. Although most of those symbols
> can remain private for now, 'pci_{enable,disable_ats()' is required for
> the ARM SMMUv3 driver to build as a module, otherwise we get a build
> failure as follows:
> 
>   | ERROR: "pci_enable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!
>   | ERROR: "pci_disable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!
> 
> Re-export these two functions so that the ARM SMMUv3 driver can be build
> as a module.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@google.com>
> [will: rewrote commit message]
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/pci/ats.c | 2 ++
>  1 file changed, 2 insertions(+)

Are you fine with this change? I would apply this series to my tree
then.

Regards,

	Joerg

