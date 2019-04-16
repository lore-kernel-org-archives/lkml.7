Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B059C282DC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605CC20872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p49+FH8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfDPLqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:46:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37597 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfDPLqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:46:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so10295133pfr.4;
        Tue, 16 Apr 2019 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+DR3+vlSbSxZmlBQUDjdm+W5hcNMX8iBKfyCHlGcd98=;
        b=p49+FH8wefNN/TFhm0musz8K67UGp4XqQ68M2G0tG6gO1vJGpXZ3Z3NHiJenPGxaA2
         Yd8ylPhe8XcATRkuSkHwuDLu39aepT7soVRT9pyel9vIQNihWW/ZcUGm0smQEsjTCn2D
         FyBo3nU67Z7Tvs7bPLA+GVeXAe2VMsxlFRJSQ/ByUa+chNz2i8h036z7Bc11Y+wFAjmF
         ld3LGMMZrtjiJbO/AdH1l1e89HLwIAGdatLHVeXSAvcAG6MVV5/QSVxVMzhvae0OLT6U
         LcVMaTmvXS0soKFNCnMoE5ptynqYlYvKH/Rb2zwD82IeS2SIaaKHOxRXebFN+0ct9Usy
         wj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+DR3+vlSbSxZmlBQUDjdm+W5hcNMX8iBKfyCHlGcd98=;
        b=GLz7AOY5cC8uEvTUknn7D+zNo5CBnQyHIiVjXWYKpbL2KbiaYlqIilaIylfX4hH39W
         9I4B+Fv1IfPAExhND+ksVS8NNjlQSn8cjxo5O2XTNS6j4/XkgcJwarAaMkBPQoCIcpug
         cfEq40S2WqOrBCPd7LXpWBrL1hrziHWUYXGi6uowOrpvL0SvNcW/UithHJm0S8X1TWuh
         NhKyRInXhM8Pja6CeDDYyNY7rG+x/GzXK8OwbjMIORoSMNXWRrdX9BHyF7+yaQyzF8iH
         bxDmbSHPfDVsi9/t8VO7ix9wTlNQu4bqdLhRaevF/PbO9Jvrc6Cf8mlKRndlyTeXHD1C
         URjw==
X-Gm-Message-State: APjAAAV9dlh0CmRhBvNjVRWkaYnnVnq3y74mpVXm9BM8w6r7dzx7jp/v
        P0fX8/DR/FziyNXzoTOMasc=
X-Google-Smtp-Source: APXvYqwcEwxacabFKCduxFjnVQjDbc16O98VQyj0wkD2blUxPLseoQlu9WxBt7zSdrSXH5UhKAygqw==
X-Received: by 2002:a63:6fcf:: with SMTP id k198mr75605186pgc.158.1555415195795;
        Tue, 16 Apr 2019 04:46:35 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
        by smtp.gmail.com with ESMTPSA id p6sm55942835pfd.122.2019.04.16.04.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 04:46:34 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
        sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com,
        peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 0/9] mm: Use vm_map_pages() and vm_map_pages_zero() API
Date:   Tue, 16 Apr 2019 17:19:41 +0530
Message-Id: <cover.1552921225.git.jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416114941.4SGWd9um42LwpHTr3nUkpLL64MOkWBW7sHTAWueZARA@z>

Previouly drivers have their own way of mapping range of
kernel pages/memory into user vma and this was done by
invoking vm_insert_page() within a loop.

As this pattern is common across different drivers, it can
be generalized by creating new functions and use it across
the drivers.

vm_map_pages() is the API which could be used to map
kernel memory/pages in drivers which has considered vm_pgoff.

vm_map_pages_zero() is the API which could be used to map
range of kernel memory/pages in drivers which has not considered
vm_pgoff. vm_pgoff is passed default as 0 for those drivers.

We _could_ then at a later "fix" these drivers which are using
vm_map_pages_zero() to behave according to the normal vm_pgoff
offsetting simply by removing the _zero suffix on the function
name and if that causes regressions, it gives us an easy way to revert.

Tested on Rockchip hardware and display is working fine, including talking
to Lima via prime.

v1 -> v2:
        Few Reviewed-by.

        Updated the change log in [8/9]

        In [7/9], vm_pgoff is treated in V4L2 API as a 'cookie'
        to select a buffer, not as a in-buffer offset by design
        and it always want to mmap a whole buffer from its beginning.
        Added additional changes after discussing with Marek and
        vm_map_pages() could be used instead of vm_map_pages_zero().

v2 -> v3:
        Corrected the documentation as per review comment.

        As suggested in v2, renaming the interfaces to -
        *vm_insert_range() -> vm_map_pages()* and
        *vm_insert_range_buggy() -> vm_map_pages_zero()*.
        As the interface is renamed, modified the code accordingly,
        updated the change logs and modified the subject lines to use the
        new interfaces. There is no other change apart from renaming and
        using the new interface.

        Patch[1/9] & [4/9], Tested on Rockchip hardware.

v3 -> v4:
        Fixed build warnings on patch [8/9] reported by kbuild test robot.

v4 -> v5:
	Rebase the code to 5.1-rc5.

Souptick Joarder (9):
  mm: Introduce new vm_map_pages() and vm_map_pages_zero() API
  arm: mm: dma-mapping: Convert to use vm_map_pages()
  drivers/firewire/core-iso.c: Convert to use vm_map_pages_zero()
  drm/rockchip/rockchip_drm_gem.c: Convert to use vm_map_pages()
  drm/xen/xen_drm_front_gem.c: Convert to use vm_map_pages()
  iommu/dma-iommu.c: Convert to use vm_map_pages()
  videobuf2/videobuf2-dma-sg.c: Convert to use vm_map_pages()
  xen/gntdev.c: Convert to use vm_map_pages()
  xen/privcmd-buf.c: Convert to use vm_map_pages_zero()

 arch/arm/mm/dma-mapping.c                          | 22 ++----
 drivers/firewire/core-iso.c                        | 15 +---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        | 17 +----
 drivers/gpu/drm/xen/xen_drm_front_gem.c            | 18 ++---
 drivers/iommu/dma-iommu.c                          | 12 +---
 drivers/media/common/videobuf2/videobuf2-core.c    |  7 ++
 .../media/common/videobuf2/videobuf2-dma-contig.c  |  6 --
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 22 ++----
 drivers/xen/gntdev.c                               | 11 ++-
 drivers/xen/privcmd-buf.c                          |  8 +--
 include/linux/mm.h                                 |  4 ++
 mm/memory.c                                        | 81 ++++++++++++++++++++++
 mm/nommu.c                                         | 14 ++++
 13 files changed, 134 insertions(+), 103 deletions(-)

-- 
1.9.1

