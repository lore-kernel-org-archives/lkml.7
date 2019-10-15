Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D612ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BD921A49
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfJOLkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:40:49 -0400
Received: from 8bytes.org ([81.169.241.247]:47474 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfJOLks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:40:48 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E6A532D9; Tue, 15 Oct 2019 13:40:46 +0200 (CEST)
Date:   Tue, 15 Oct 2019 13:40:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/intel: Use fallback generic_device_group() for
 ACPI devices
Message-ID: <20191015114045.GJ14518@8bytes.org>
References: <20191004205554.21055-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004205554.21055-1-chris@chris-wilson.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 09:55:54PM +0100, Chris Wilson wrote:
> [    2.073922] DMAR: ACPI device "INT33C2:00" under DMAR at fed91000 as 00:15.1
> [    2.073983] DMAR: ACPI device "INT33C3:00" under DMAR at fed91000 as 00:15.2
> [    2.074027] DMAR: ACPI device "INT33C0:00" under DMAR at fed91000 as 00:15.3
> [    2.074072] DMAR: ACPI device "INT33C1:00" under DMAR at fed91000 as 00:15.4

I think just using generic_device_group() is not enough here. You need
to mach the device-id of the ACPI device with the PCI hierarchy and find
the right group there. You can look at the AMD IOMMU drivers
acpihid_device_group() function for some inspiration.

Regards,

	Joerg

