Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0111C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949882173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7b1cfX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390406AbfGRM5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:57:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37191 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfGRM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:57:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so3520812wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBZIMb/cv4p86kHI5WJte6N1oUCOAcyaBxPi0Hq61Aw=;
        b=M7b1cfX/FQQdwf5j1BZI0tZLYWnDxEN/RvoJcwpvS6vwpgCCk35TCYpO6rIw0vmEmN
         UbXR9fH0NPcQzqcIDfbA7u1JKcFFWX6e/ziF4OK6W94eDHSmVxXOMKAH752iSiaFZn73
         vyvwMEt5hLh54/0OBPYJb12uJ7bRTr6kwy2VTOOM1c97XE7o1devRMYA7x5sPti2ncc+
         O4obqmhblD1EnJLhnhEjoguDCNBkNpeoEW7brUXgogcwuIu9r5t9XY07m7njetMImgmM
         KdtYIIOU5hGVHTOm6kw1BvGc7gYR/XkNLRrEOFKm/Nfr0eHBgiFYNpsFyO7oDKnX+CIu
         03zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBZIMb/cv4p86kHI5WJte6N1oUCOAcyaBxPi0Hq61Aw=;
        b=lxHpHl2tapAJ3tzcKmEOARO//WOfOocj28d5ij0KGb9zedtvrWS9JB8YOvR3UU9+ae
         oYqlwf1dxu3sjgb1eokUTbfTlr8BUL8+AN56xskaXOH2QHDj/3reYRZ9CCK5xe+On4ow
         GzC8uh9GuPSpu45Nntuyg0NDr3Ml7+Wx63jLhVb81Axlo+plkV4PdkLwONXFHMMfiO2m
         nGR3kb/eb6Jiu0NKRLvPWzzfLh2+/ksNio0J9blpNadZnuOLZp336nBuaBXmVSXoXo0X
         BUX/canVYoFQKnKUI6hGve6h2RbaqQwSyG4g7zQ/PgPcfcNU+pNHhDW5HApI31LkPo4v
         ifzQ==
X-Gm-Message-State: APjAAAXYYPY0Wo+Gvw+/uNt2dKW+JLU0TORTIkGPqa6M7HKPT84c8e5z
        vtCtBpBbTsNR/hosnU8EDxQDAiUcl/hsqcIERXkE
X-Google-Smtp-Source: APXvYqwsDiDoa/u9Ygd5gihAYozyjCzB+4HWT9/GC9RwvJop09GJRlSYu6/VSqC50r7nHpO7u7jQTXCQp16GTDF2IHo=
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr48860500wrn.54.1563454618636;
 Thu, 18 Jul 2019 05:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190718020745.8867-1-fred@fredlawl.com> <20190718020745.8867-3-fred@fredlawl.com>
In-Reply-To: <20190718020745.8867-3-fred@fredlawl.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 18 Jul 2019 07:56:46 -0500
Message-ID: <CAErSpo4tVvPFSh+fJmfSUNHhmjepDXrpoqVnvOx+jZY8u+r+aQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Prefer pcie_capability_read_word()
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     David Airlie <airlied@linux.ie>, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 9:08 PM Frederick Lawler <fred@fredlawl.com> wrote:
>
> Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
> added accessors for the PCI Express Capability so that drivers didn't
> need to be aware of differences between v1 and v2 of the PCI
> Express Capability.
>
> Replace pci_read_config_word() and pci_write_config_word() calls with
> pcie_capability_read_word() and pcie_capability_write_word().
>
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/gpu/drm/radeon/cik.c | 70 +++++++++++++++++++++-------------
>  drivers/gpu/drm/radeon/si.c  | 73 +++++++++++++++++++++++-------------
>  2 files changed, 90 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> index ab7b4e2ffcd2..f6c91ac5427a 100644
> --- a/drivers/gpu/drm/radeon/cik.c
> +++ b/drivers/gpu/drm/radeon/cik.c
> @@ -9500,7 +9500,6 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>  {
>         struct pci_dev *root = rdev->pdev->bus->self;
>         enum pci_bus_speed speed_cap;
> -       int bridge_pos, gpu_pos;
>         u32 speed_cntl, current_data_rate;
>         int i;
>         u16 tmp16;
> @@ -9542,12 +9541,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>                 DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
>         }
>
> -       bridge_pos = pci_pcie_cap(root);
> -       if (!bridge_pos)
> -               return;
> -
> -       gpu_pos = pci_pcie_cap(rdev->pdev);
> -       if (!gpu_pos)
> +       if (!pci_is_pcie(root) || !pci_is_pcie(rdev->pdev))
>                 return;
>
>         if (speed_cap == PCIE_SPEED_8_0GT) {
> @@ -9557,14 +9551,17 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>                         u16 bridge_cfg2, gpu_cfg2;
>                         u32 max_lw, current_lw, tmp;
>
> -                       pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
> -                       pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
> +                       pcie_capability_read_word(root, PCI_EXP_LNKCTL,
> +                                                 &bridge_cfg);
> +                       pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL,
> +                                                 &gpu_cfg);
>
>                         tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
> -                       pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
> +                       pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
>
>                         tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
> -                       pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
> +                       pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL,
> +                                                  tmp16);
>
>                         tmp = RREG32_PCIE_PORT(PCIE_LC_STATUS1);
>                         max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
> @@ -9582,15 +9579,23 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>
>                         for (i = 0; i < 10; i++) {
>                                 /* check status */
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_DEVSTA,
> +                                                         &tmp16);
>                                 if (tmp16 & PCI_EXP_DEVSTA_TRPND)
>                                         break;
>
> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
> +                                                         &bridge_cfg);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_LNKCTL,
> +                                                         &gpu_cfg);
>
> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
> +                                                         &bridge_cfg2);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_LNKCTL2,
> +                                                         &gpu_cfg2);
>
>                                 tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>                                 tmp |= LC_SET_QUIESCE;
> @@ -9603,26 +9608,39 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>                                 msleep(100);
>
>                                 /* linkctl */
> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
> +                                                         &tmp16);
>                                 tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>                                 tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
> +                               pcie_capability_write_word(root, PCI_EXP_LNKCTL,
> +                                                          tmp16);
>
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_LNKCTL,
> +                                                         &tmp16);
>                                 tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>                                 tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
> -                               pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
> +                               pcie_capability_write_word(rdev->pdev,
> +                                                          PCI_EXP_LNKCTL,
> +                                                          tmp16);
>
>                                 /* linkctl2 */
> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
> +                                                         &tmp16);
>                                 tmp16 &= ~((1 << 4) | (7 << 9));
>                                 tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));

Looks like we could use some new #defines for these LNKCTL2 bits (also below).

> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
> +                               pcie_capability_write_word(root,
> +                                                          PCI_EXP_LNKCTL2,
> +                                                          tmp16);
>
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_LNKCTL2,
> +                                                         &tmp16);
>                                 tmp16 &= ~((1 << 4) | (7 << 9));
>                                 tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
> -                               pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
> +                               pcie_capability_write_word(rdev->pdev,
> +                                                          PCI_EXP_LNKCTL2,
> +                                                          tmp16);
>
>                                 tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>                                 tmp &= ~LC_SET_QUIESCE;
> @@ -9636,7 +9654,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>         speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
>         WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
>
> -       pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
> +       pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL2, &tmp16);
>         tmp16 &= ~0xf;
>         if (speed_cap == PCIE_SPEED_8_0GT)
>                 tmp16 |= 3; /* gen3 */
> @@ -9644,7 +9662,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>                 tmp16 |= 2; /* gen2 */
>         else
>                 tmp16 |= 1; /* gen1 */
> -       pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
> +       pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL2, tmp16);
>
>         speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
>         speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index 841bc8bc333d..6916703d7899 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -3253,7 +3253,7 @@ static void si_gpu_init(struct radeon_device *rdev)
>                 /* XXX what about 12? */
>                 rdev->config.si.tile_config |= (3 << 0);
>                 break;
> -       }
> +       }
>         switch ((mc_arb_ramcfg & NOOFBANK_MASK) >> NOOFBANK_SHIFT) {
>         case 0: /* four banks */
>                 rdev->config.si.tile_config |= 0 << 4;
> @@ -7083,7 +7083,6 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>  {
>         struct pci_dev *root = rdev->pdev->bus->self;
>         enum pci_bus_speed speed_cap;
> -       int bridge_pos, gpu_pos;
>         u32 speed_cntl, current_data_rate;
>         int i;
>         u16 tmp16;
> @@ -7125,12 +7124,7 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>                 DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
>         }
>
> -       bridge_pos = pci_pcie_cap(root);
> -       if (!bridge_pos)
> -               return;
> -
> -       gpu_pos = pci_pcie_cap(rdev->pdev);
> -       if (!gpu_pos)
> +       if (!pci_is_pcie(root) || !pci_is_pcie(rdev->pdev))
>                 return;
>
>         if (speed_cap == PCIE_SPEED_8_0GT) {
> @@ -7140,14 +7134,17 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>                         u16 bridge_cfg2, gpu_cfg2;
>                         u32 max_lw, current_lw, tmp;
>
> -                       pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
> -                       pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
> +                       pcie_capability_read_word(root, PCI_EXP_LNKCTL,
> +                                                 &bridge_cfg);
> +                       pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL,
> +                                                 &gpu_cfg);
>
>                         tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
> -                       pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
> +                       pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
>
>                         tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
> -                       pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
> +                       pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL,
> +                                                  tmp16);
>
>                         tmp = RREG32_PCIE(PCIE_LC_STATUS1);
>                         max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
> @@ -7165,15 +7162,23 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>
>                         for (i = 0; i < 10; i++) {
>                                 /* check status */
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_DEVSTA,
> +                                                         &tmp16);
>                                 if (tmp16 & PCI_EXP_DEVSTA_TRPND)
>                                         break;
>
> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
> +                                                         &bridge_cfg);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_LNKCTL,
> +                                                         &gpu_cfg);
>
> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
> +                                                         &bridge_cfg2);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_LNKCTL2,
> +                                                         &gpu_cfg2);
>
>                                 tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>                                 tmp |= LC_SET_QUIESCE;
> @@ -7186,26 +7191,40 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>                                 msleep(100);
>
>                                 /* linkctl */
> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
> +                                                         &tmp16);
>                                 tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>                                 tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
> +                               pcie_capability_write_word(root,
> +                                                          PCI_EXP_LNKCTL,
> +                                                          tmp16);
>
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_LNKCTL,
> +                                                         &tmp16);
>                                 tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>                                 tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
> -                               pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
> +                               pcie_capability_write_word(rdev->pdev,
> +                                                          PCI_EXP_LNKCTL,
> +                                                          tmp16);
>
>                                 /* linkctl2 */
> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
> +                                                         &tmp16);
>                                 tmp16 &= ~((1 << 4) | (7 << 9));
>                                 tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
> +                               pcie_capability_write_word(root,
> +                                                          PCI_EXP_LNKCTL2,
> +                                                          tmp16);
>
> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
> +                               pcie_capability_read_word(rdev->pdev,
> +                                                         PCI_EXP_LNKCTL2,
> +                                                         &tmp16);
>                                 tmp16 &= ~((1 << 4) | (7 << 9));
>                                 tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
> -                               pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
> +                               pcie_capability_write_word(rdev->pdev,
> +                                                          PCI_EXP_LNKCTL2,
> +                                                          tmp16);
>
>                                 tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>                                 tmp &= ~LC_SET_QUIESCE;
> @@ -7219,7 +7238,7 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>         speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
>         WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
>
> -       pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
> +       pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL2, &tmp16);
>         tmp16 &= ~0xf;
>         if (speed_cap == PCIE_SPEED_8_0GT)
>                 tmp16 |= 3; /* gen3 */

PCI_EXP_LNKCTL2_TLS, PCI_EXP_LNKCTL2_TLS_8_0GT, etc.

> @@ -7227,7 +7246,7 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>                 tmp16 |= 2; /* gen2 */
>         else
>                 tmp16 |= 1; /* gen1 */
> -       pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
> +       pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL2, tmp16);
>
>         speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
>         speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
> --
> 2.17.1
>
