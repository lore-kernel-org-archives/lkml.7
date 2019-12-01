Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EE0C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 12:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AB4215E5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 12:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLAMsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 07:48:19 -0500
Received: from ns.lynxeye.de ([87.118.118.114]:58979 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbfLAMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 07:48:19 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 07:48:18 EST
Received: by lynxeye.de (Postfix, from userid 501)
        id 2F953E74222; Sun,  1 Dec 2019 13:42:33 +0100 (CET)
Received: from astat.fritz.box (a89-183-126-187.net-htp.de [89.183.126.187])
        by lynxeye.de (Postfix) with ESMTPSA id 93F73E7414D;
        Sun,  1 Dec 2019 13:42:31 +0100 (CET)
Message-ID: <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
From:   Lucas Stach <dev@lynxeye.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, joro@8bytes.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Sun, 01 Dec 2019 13:42:31 +0100
In-Reply-To: <20191129142154.29658-1-kai.heng.feng@canonical.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 29.11.2019, 22:21 +0800 schrieb Kai-Heng Feng:
> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> 
> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
> the same here to avoid screen flickering on 4K monitor.

This doesn't seem like a good solution, especially if there isn't a
method for the user to opt-out.  Some users might prefer having the
IOMMU support to 4K display output.

But before using the big hammer of disabling or breaking one of those
features, we should take a look at what's the issue here. Screen
flickering caused by the IOMMU being active hints to the IOMMU not
being able to sustain the translation bandwidth required by the high-
bandwidth isochronous transfers caused by 4K scanout, most likely due
to insufficient TLB space.

As far as I know the framebuffer memory for the display buffers is
located in stolen RAM, and thus contigous in memory. I don't know the
details of the GPU integration on those APUs, but maybe there even is a
way to bypass the IOMMU for the stolen VRAM regions?

If there isn't and all GPU traffic passes through the IOMMU when
active, we should check if the stolen RAM is mapped with hugepages on
the IOMMU side. All the stolen RAM can most likely be mapped with a few
hugepage mappings, which should reduce IOMMU TLB demand by a large
margin.

Regards,
Lucas

> Cc: Alex Deucher <alexander.deucher@amd.com>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/961
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Find Stoney graphics instead of host bridge.
> 
>  drivers/iommu/amd_iommu_init.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 568c52317757..139aa6fdadda 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2516,6 +2516,7 @@ static int __init early_amd_iommu_init(void)
>  	struct acpi_table_header *ivrs_base;
>  	acpi_status status;
>  	int i, remap_cache_sz, ret = 0;
> +	u32 pci_id;
>  
>  	if (!amd_iommu_detected)
>  		return -ENODEV;
> @@ -2603,6 +2604,16 @@ static int __init early_amd_iommu_init(void)
>  	if (ret)
>  		goto out;
>  
> +	/* Disable IOMMU if there's Stoney Ridge graphics */
> +	for (i = 0; i < 32; i++) {
> +		pci_id = read_pci_config(0, i, 0, 0);
> +		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
> +			pr_info("Disable IOMMU on Stoney Ridge\n");
> +			amd_iommu_disabled = true;
> +			break;
> +		}
> +	}
> +
>  	/* Disable any previously enabled IOMMUs */
>  	if (!is_kdump_kernel() || amd_iommu_disabled)
>  		disable_iommus();
> @@ -2711,7 +2722,7 @@ static int __init state_next(void)
>  		ret = early_amd_iommu_init();
>  		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
>  		if (init_state == IOMMU_ACPI_FINISHED && amd_iommu_disabled) {
> -			pr_info("AMD IOMMU disabled on kernel command-line\n");
> +			pr_info("AMD IOMMU disabled\n");
>  			init_state = IOMMU_CMDLINE_DISABLED;
>  			ret = -EINVAL;
>  		}

