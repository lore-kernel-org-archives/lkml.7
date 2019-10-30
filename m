Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F9FCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214F82083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572467446;
	bh=7S030207/lOki5T8aX6j2Aiz+5BYaIpHjY2GGLIav+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Ubldx7JOVA6tQZI1SKVzGPuVFL+I24vga+EgK4atsQAbPK92TFR4udNabrsDB4Z7D
	 UV4xedDsePrybPlQQOC3JV2FMI6/pEGeWW8uzKRMEOPkSeEP2Qu+B7vUZT3Gu64UBT
	 x4/1zKLcBccXMyje6fnX2rPO+5NrWRa/gAKzEk+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfJ3Uap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfJ3Uao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:30:44 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6211205C9;
        Wed, 30 Oct 2019 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572467444;
        bh=7S030207/lOki5T8aX6j2Aiz+5BYaIpHjY2GGLIav+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Yi+gyYU/5+OuyQVMs6E8lOV+CkSwzRgsP4mvwaCNJoZfb0QocOhj7h6TvcML8FYsw
         SSf+N2W9/3cddKdGX9mj5qd7PfPBspOF60E2FFbLYdF5xxgHId4OekX9YLgjts9eGB
         WYRjcUBQWtOieOlw/l/y4/t65AeB97w45y5gHncM=
Date:   Wed, 30 Oct 2019 15:30:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 3/7] PCI: Export pci_ats_disabled() as a GPL symbol to
 modules
Message-ID: <20191030203041.GA247194@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030145112.19738-4-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:51:08PM +0000, Will Deacon wrote:
> Building drivers for ATS-aware IOMMUs as modules requires access to
> pci_ats_disabled(). Export it as a GPL symbol to get things working.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e2571a527..4fbe5b576dd8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -123,6 +123,7 @@ bool pci_ats_disabled(void)
>  {
>  	return pcie_ats_disabled;
>  }
> +EXPORT_SYMBOL_GPL(pci_ats_disabled);
>  
>  /* Disable bridge_d3 for all PCIe ports */
>  static bool pci_bridge_d3_disable;
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 
