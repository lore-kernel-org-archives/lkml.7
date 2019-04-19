Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2857AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C9621736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh5UU1t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfDSTfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:35:01 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39411 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfDSTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:35:01 -0400
Received: by mail-wr1-f50.google.com with SMTP id j9so8015344wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Zx2Ui9Rjn8bM+00mvZfaLRhUlZBh8mk9hZs5FuRALDE=;
        b=kh5UU1t3WGXhv6kG//6QXznTYxy1xulLD03tFxcGO6b8kQggLivDyv/y6CPmRp7K6U
         ypmiv/dnbKJqXjGyjog/xgScKGKQC0HX6Ca9aLm8Rk0uYbJItCdACpMPE6+nl/ag/8JE
         RFjW6T5+oLLJY1tb7erR0itTN1qn8d8FlBpxkGC67fP1HS2IwAAF65LSQzAFRkov0/Gu
         lUuvyHc4iKXCJ9sCYvBdpl66Pqvn8h4h2vNTDek4IXqLotpin9dJjixKrrINCnv8N4mr
         fSw2FHYAJx8V3rapnjtikzGDpeuJS2Dc4f7zlXw1FB2vV0sn/8fr1OI0Vcq6PW6V3I0C
         8+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Zx2Ui9Rjn8bM+00mvZfaLRhUlZBh8mk9hZs5FuRALDE=;
        b=uJKolWljTEsK6Sf3UAAAT0HWTkc1lpYL8wElAasis2SPszWx3T+EP4ivzuM2yP/QMh
         +/DwDi1MlpycUrrmroSOws6eTEV8CuyMStTWebcGPLIFgwsaQy5rnLa9t2bSVf/OZ8Ax
         T0FsaKmF1e2J19bav8aThBw17YdEt8p2xA0+Cv+s5m8hv/EfI7bf4/4Q6Vn1sjQHUZnW
         BvwOX5VczRir9fFLSwAlt8Q2224rzhu4sigYh4IoL1Stq95UKLij1dSFj9CqwaQIqzLI
         8VE+QOsHPTLrKuKChZJ+ikByz7cumSOQbL9lvnpLlZbthrVNo0uHBLgGsufty9PZmaum
         6S1g==
X-Gm-Message-State: APjAAAW9eA/Cj97BxN60yAFcn/NSEj3npX56Jf/I5URP2B930Of/xnf8
        DpEOAZwm3QJW8A1USgMno7acUAdJ
X-Google-Smtp-Source: APXvYqxZ3J4r6eWE96mgQnEdDGxGKdr3KUEHu3xq+aCxUAfxHYT487xqa2YFum7s8r0gG88ZCS/B3Q==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr1950689wrn.145.1555667351461;
        Fri, 19 Apr 2019 02:49:11 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z84sm7259325wmg.24.2019.04.19.02.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 02:49:11 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:49:09 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs next for 5.2
Message-ID: <20190419094909.GA22155@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is the major pull request for habanalabs driver for kernel 5.2.

All of the patches were submitted more then a couple of weeks ago and were
in my repository at fdo which is being checked by the Intel kbuild robot,
so I believe they are clean in terms of compilation in different
architectures.

Please see the tag message for details on what this pull request contains.

Thanks,
Oded

The following changes since commit d358b1733fc33d9f0261ce07c3d328787652245d:

  chardev: update comment based on the code (2019-04-02 17:49:58 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-04-19

for you to fetch changes up to 9f201aba56b92c3daa4b76efae056ddbb80d91e6:

  habanalabs: prevent device PTE read/write during hard-reset (2019-04-06 15:33:38 +0300)

----------------------------------------------------------------
This tag contains many changes for kernel 5.2.

The major changes are:
- Add a new IOCTL for debug, profiling and trace operations on the device.
  This will allow the user to perform profiling and debugging of the
  deep learning topologies that are executing on the ASIC.

- Add a shadow table for the ASIC's MMU page tables to avoid doing page
  table walks on the device's DRAM during map/unmap operations.

- re-factor of ASIC-dependent code to be common code for all ASICs

In addition, there are many small fixes and changes. The notable ones are:
- Allow accessing the DRAM using virtual address through the debugFS
  interface. Until now, only physical addresses were valid, but that is
  useless for debugging when working with MMU.

- Allow the user to modify the TPC clock relaxation value to better
  control TPC power consumption during topology execution.

- Allow the user to inquire about the device's status
  (operational/Malfunction/in-reset) in the INFO IOCTL.

- Improvements to the device's removal function, to prevent crash in case
  of force removal by the OS.

- Prevent PTE read/write during hard-reset. This will improve stability of
  the device during hard-reset.

----------------------------------------------------------------
Dalit Ben Zoor (3):
      habanalabs: set new golden value to tpc clock relaxation
      habanalabs: allow user to modify TPC clock relaxation value
      habanalabs: add device status option to INFO IOCTL

Dotan Barak (1):
      habanalabs: remove implicit include from header files

Igor Grinberg (1):
      habanalabs: add new device CPU boot status

Oded Gabbay (18):
      habanalabs: rename goya_non_fatal_events array to all events
      habanalabs: use EQ MSI/X ID per chip
      habanalabs: remove unused defines
      habanalabs: ratelimit warnings at start of IOCTLs
      uapi/habanalabs: add some comments in habanalabs.h
      habanalabs: keep track of the device's dma mask
      habanalabs: never fail hard reset of device
      habanalabs: improve error messages
      habanalabs: remove trailing blank line from EOF
      habanalabs: prevent CPU soft lockup on Palladium
      habanalabs: remove extra semicolon
      uapi/habanalabs: fix some comments in uapi file
      habanalabs: refactoring in goya.c
      habanalabs: ASIC_AUTO_DETECT enum value is redundant
      habanalabs: split mmu/no-mmu code paths in memory ioctl
      habanalabs: all FD must be closed before removing device
      habanalabs: improve IOCTLs behavior when disabled or reset
      habanalabs: prevent device PTE read/write during hard-reset

Omer Shpigelman (3):
      habanalabs: add MMU shadow mapping
      habanalabs: add new IOCTL for debug, tracing and profiling
      habanalabs: add goya implementation for debug configuration

Tomer Tayar (5):
      habanalabs: Move device CPU code into common file
      habanalabs: Move PCI code into common file
      habanalabs: Remove unneeded function pointers
      habanalabs: Add a printout with the name of a busy engine
      habanalabs: Allow accessing DRAM virtual addresses via debugfs

 drivers/misc/habanalabs/Makefile                   |   2 +-
 drivers/misc/habanalabs/command_buffer.c           |   7 +
 drivers/misc/habanalabs/command_submission.c       |   5 +-
 drivers/misc/habanalabs/debugfs.c                  |  96 ++-
 drivers/misc/habanalabs/device.c                   |  77 +-
 drivers/misc/habanalabs/firmware_if.c              | 325 ++++++++
 drivers/misc/habanalabs/goya/Makefile              |   3 +-
 drivers/misc/habanalabs/goya/goya.c                | 884 +++++----------------
 drivers/misc/habanalabs/goya/goyaP.h               |  47 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      | 620 +++++++++++++++
 drivers/misc/habanalabs/goya/goya_security.c       |  15 +-
 drivers/misc/habanalabs/habanalabs.h               | 110 ++-
 drivers/misc/habanalabs/habanalabs_drv.c           |   7 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c         | 139 +++-
 drivers/misc/habanalabs/include/armcp_if.h         |  10 +-
 .../include/goya/asic_reg/cpu_ca53_cfg_masks.h     |   1 -
 .../include/goya/asic_reg/cpu_ca53_cfg_regs.h      |   1 -
 .../habanalabs/include/goya/asic_reg/cpu_if_regs.h |   1 -
 .../include/goya/asic_reg/cpu_pll_regs.h           |   1 -
 .../include/goya/asic_reg/dma_ch_0_regs.h          |   1 -
 .../include/goya/asic_reg/dma_ch_1_regs.h          |   1 -
 .../include/goya/asic_reg/dma_ch_2_regs.h          |   1 -
 .../include/goya/asic_reg/dma_ch_3_regs.h          |   1 -
 .../include/goya/asic_reg/dma_ch_4_regs.h          |   1 -
 .../include/goya/asic_reg/dma_macro_masks.h        |   1 -
 .../include/goya/asic_reg/dma_macro_regs.h         |   1 -
 .../include/goya/asic_reg/dma_nrtr_masks.h         |   1 -
 .../include/goya/asic_reg/dma_nrtr_regs.h          |   1 -
 .../include/goya/asic_reg/dma_qm_0_masks.h         |   1 -
 .../include/goya/asic_reg/dma_qm_0_regs.h          |   1 -
 .../include/goya/asic_reg/dma_qm_1_regs.h          |   1 -
 .../include/goya/asic_reg/dma_qm_2_regs.h          |   1 -
 .../include/goya/asic_reg/dma_qm_3_regs.h          |   1 -
 .../include/goya/asic_reg/dma_qm_4_regs.h          |   1 -
 .../habanalabs/include/goya/asic_reg/goya_masks.h  |  12 -
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |   3 +-
 .../habanalabs/include/goya/asic_reg/ic_pll_regs.h |   1 -
 .../habanalabs/include/goya/asic_reg/mc_pll_regs.h |   1 -
 .../include/goya/asic_reg/mme1_rtr_masks.h         |   1 -
 .../include/goya/asic_reg/mme1_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/mme2_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/mme3_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/mme4_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/mme5_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/mme6_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/mme_cmdq_masks.h         |   1 -
 .../include/goya/asic_reg/mme_cmdq_regs.h          |   1 -
 .../habanalabs/include/goya/asic_reg/mme_masks.h   |   1 -
 .../include/goya/asic_reg/mme_qm_masks.h           |   1 -
 .../habanalabs/include/goya/asic_reg/mme_qm_regs.h |   1 -
 .../habanalabs/include/goya/asic_reg/mme_regs.h    |   1 -
 .../habanalabs/include/goya/asic_reg/mmu_masks.h   |   1 -
 .../habanalabs/include/goya/asic_reg/mmu_regs.h    |   1 -
 .../include/goya/asic_reg/pci_nrtr_masks.h         |   1 -
 .../include/goya/asic_reg/pci_nrtr_regs.h          |   1 -
 .../include/goya/asic_reg/pcie_aux_regs.h          |   1 -
 .../include/goya/asic_reg/pcie_wrap_regs.h         | 306 +++++++
 .../include/goya/asic_reg/psoc_emmc_pll_regs.h     |   1 -
 .../include/goya/asic_reg/psoc_global_conf_masks.h |   1 -
 .../include/goya/asic_reg/psoc_global_conf_regs.h  |   1 -
 .../include/goya/asic_reg/psoc_mme_pll_regs.h      |   1 -
 .../include/goya/asic_reg/psoc_pci_pll_regs.h      |   1 -
 .../include/goya/asic_reg/psoc_spi_regs.h          |   1 -
 .../include/goya/asic_reg/sram_y0_x0_rtr_regs.h    |   1 -
 .../include/goya/asic_reg/sram_y0_x1_rtr_regs.h    |   1 -
 .../include/goya/asic_reg/sram_y0_x2_rtr_regs.h    |   1 -
 .../include/goya/asic_reg/sram_y0_x3_rtr_regs.h    |   1 -
 .../include/goya/asic_reg/sram_y0_x4_rtr_regs.h    |   1 -
 .../habanalabs/include/goya/asic_reg/stlb_masks.h  |   1 -
 .../habanalabs/include/goya/asic_reg/stlb_regs.h   |   1 -
 .../include/goya/asic_reg/tpc0_cfg_masks.h         |   1 -
 .../include/goya/asic_reg/tpc0_cfg_regs.h          |   1 -
 .../include/goya/asic_reg/tpc0_cmdq_masks.h        |   1 -
 .../include/goya/asic_reg/tpc0_cmdq_regs.h         |   1 -
 .../include/goya/asic_reg/tpc0_eml_cfg_masks.h     |   1 -
 .../include/goya/asic_reg/tpc0_eml_cfg_regs.h      |   1 -
 .../include/goya/asic_reg/tpc0_nrtr_masks.h        |   1 -
 .../include/goya/asic_reg/tpc0_nrtr_regs.h         |   1 -
 .../include/goya/asic_reg/tpc0_qm_masks.h          |   1 -
 .../include/goya/asic_reg/tpc0_qm_regs.h           |   1 -
 .../include/goya/asic_reg/tpc1_cfg_regs.h          |   1 -
 .../include/goya/asic_reg/tpc1_cmdq_regs.h         |   1 -
 .../include/goya/asic_reg/tpc1_qm_regs.h           |   1 -
 .../include/goya/asic_reg/tpc1_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/tpc2_cfg_regs.h          |   1 -
 .../include/goya/asic_reg/tpc2_cmdq_regs.h         |   1 -
 .../include/goya/asic_reg/tpc2_qm_regs.h           |   1 -
 .../include/goya/asic_reg/tpc2_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/tpc3_cfg_regs.h          |   1 -
 .../include/goya/asic_reg/tpc3_cmdq_regs.h         |   1 -
 .../include/goya/asic_reg/tpc3_qm_regs.h           |   1 -
 .../include/goya/asic_reg/tpc3_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/tpc4_cfg_regs.h          |   1 -
 .../include/goya/asic_reg/tpc4_cmdq_regs.h         |   1 -
 .../include/goya/asic_reg/tpc4_qm_regs.h           |   1 -
 .../include/goya/asic_reg/tpc4_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/tpc5_cfg_regs.h          |   1 -
 .../include/goya/asic_reg/tpc5_cmdq_regs.h         |   1 -
 .../include/goya/asic_reg/tpc5_qm_regs.h           |   1 -
 .../include/goya/asic_reg/tpc5_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/tpc6_cfg_regs.h          |   1 -
 .../include/goya/asic_reg/tpc6_cmdq_regs.h         |   1 -
 .../include/goya/asic_reg/tpc6_qm_regs.h           |   1 -
 .../include/goya/asic_reg/tpc6_rtr_regs.h          |   1 -
 .../include/goya/asic_reg/tpc7_cfg_regs.h          |   1 -
 .../include/goya/asic_reg/tpc7_cmdq_regs.h         |   1 -
 .../include/goya/asic_reg/tpc7_nrtr_regs.h         |   1 -
 .../include/goya/asic_reg/tpc7_qm_regs.h           |   1 -
 .../include/goya/asic_reg/tpc_pll_regs.h           |   1 -
 drivers/misc/habanalabs/include/goya/goya.h        |   4 -
 .../habanalabs/include/goya/goya_async_events.h    |   9 +
 .../misc/habanalabs/include/goya/goya_coresight.h  | 199 +++++
 drivers/misc/habanalabs/include/goya/goya_fw_if.h  |   2 +
 drivers/misc/habanalabs/include/hl_boot_if.h       |   3 +-
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |  16 +-
 .../habanalabs/include/hw_ip/pci/pci_general.h     |  23 +
 drivers/misc/habanalabs/memory.c                   | 193 ++---
 drivers/misc/habanalabs/mmu.c                      | 600 +++++++-------
 drivers/misc/habanalabs/pci.c                      | 402 ++++++++++
 include/uapi/misc/habanalabs.h                     | 158 +++-
 120 files changed, 3118 insertions(+), 1250 deletions(-)
 create mode 100644 drivers/misc/habanalabs/firmware_if.c
 create mode 100644 drivers/misc/habanalabs/goya/goya_coresight.c
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_wrap_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_coresight.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h
 create mode 100644 drivers/misc/habanalabs/pci.c
