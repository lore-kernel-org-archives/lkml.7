Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77B7C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 21:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827662082F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 21:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="yEv/5vlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfGTV6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 17:58:33 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46213 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfGTV6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 17:58:32 -0400
Received: by mail-yw1-f65.google.com with SMTP id z197so14643407ywd.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7ukW3xU7Dcdw07hb7w1OwbyME2bLJbeEEY9buEId9ZI=;
        b=yEv/5vlpldcp4zkNkdkqAAbxR+rIo/c+YS2ShOvWv/UNAn41eMnKxvDbwPaE876RVY
         MbUaz/Bw76ZNrApQkX8FliIwic+1l0LDmsavNp5ZprbKFk4LUJF77MIFc21zYAAuzk6z
         KIVb1IVRx+rNv1qV8YMR2cQeCy0Etrg3acia3jRGoEfHcChIomSKeqmZcUVueRfgdweF
         B4snzmZ54qL+V1QqdY13JsWnQNmVCPVOBWrHtyVjHqV/LsWJ1+SMh1ciYOFqtVsAzo7a
         qGaA9moSYoFlydSYKT0NO9hYqwLdD0G5MqBomRKY8m29JyzxUcUhaps9Ff+X7O6xOw64
         wZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7ukW3xU7Dcdw07hb7w1OwbyME2bLJbeEEY9buEId9ZI=;
        b=r9gRVO0R3W3cZ4vbpsQgZxC4NNuJPCCakwD/Dbo/rLLSHRirxhAyVlBXK6AGEzkG/U
         yZ+hvT0rVmyEl4MOc6VCmFqy6Px6VYgk/6F9IRdE3jTNYHwaUm3eaWIz3eS/wuownJeB
         V7qJXBCwNgSBKK9M8HWtN9QVeYOwGzovF3tDf3gTHrPeXA5MzU3dcIJ8ykd+a1ccEBbb
         lf1eSWBbz9jtr/QrkP7inO4myrJxhB60smKuGORtlXjaRqJ2VmyZcu4HcbuOa0yfW6XC
         4KKWRmWU501NibUbc4LMqitN4my/iDRE3/WO3aR+B3PiqQnNky3yJkspTzsP2MfIMPKS
         h+kw==
X-Gm-Message-State: APjAAAWBUeoGNEM2P7LwWQxveSDyWagPllUpyq8HNf6sJ0+/8fQwRJ8L
        XERx62VWerMbmmIvX43AGg8=
X-Google-Smtp-Source: APXvYqzamNJM6KFOVjPngTR9POgtTBtB36NiRBmXoq3VDvIIPP3a8uzMyP69zSjBCB+fSqtjkMRaTQ==
X-Received: by 2002:a0d:dd01:: with SMTP id g1mr37007514ywe.482.1563659911682;
        Sat, 20 Jul 2019 14:58:31 -0700 (PDT)
Received: from graymalkin (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id q13sm7814780ywj.61.2019.07.20.14.58.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 20 Jul 2019 14:58:31 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@graymalkin>
Received: by graymalkin (sSMTP sendmail emulation); Sat, 20 Jul 2019 17:58:29 -0400
Date:   Sat, 20 Jul 2019 17:58:29 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB changes for v5.3
Message-ID: <20190720215829.GA10213@graymalkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are the NTB changes for v5.3.  The big change is adding the virtual
MSI interface for NTB (reviewed and acked by Bjorn).  Also, there are
some bug fixes.  Please consider pulling them.

Thanks,
Jon



The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.3

for you to fetch changes up to d9c53aa440b332059f7f0ce3f7868ff1dc58c62c:

  NTB: Describe the ntb_msi_test client in the documentation. (2019-06-13 09:03:12 -0400)

----------------------------------------------------------------
New feature to add support for NTB virtual MSI interrupts, the ability
to test and use this feature in the NTB transport layer.  Also, bug
fixes for the AMD and Switchtec drivers, as well as some general
patches.

----------------------------------------------------------------
Dan Carpenter (2):
      ntb_hw_switchtec: potential shift wrapping bug in switchtec_ntb_init_sndev()
      NTB: amd: Silence shift wrapping warning in amd_ntb_db_vector_mask()

Joey Zhang (2):
      ntb_hw_switchtec: Remove redundant steps of switchtec_ntb_reinit_peer() function
      ntb_hw_switchtec: Fix setup MW with failure bug

Logan Gunthorpe (11):
      NTB: ntb_transport: Ensure qp->tx_mw_dma_addr is initaliazed
      PCI/MSI: Support allocating virtual MSI interrupts
      PCI/switchtec: Add module parameter to request more interrupts
      NTB: Introduce helper functions to calculate logical port number
      NTB: Introduce functions to calculate multi-port resource index
      NTB: Rename ntb.c to support multiple source files in the module
      NTB: Introduce MSI library
      NTB: Introduce NTB MSI Test Client
      NTB: Add ntb_msi_test support to ntb_test
      NTB: Add MSI interrupt support to ntb_transport
      NTB: Describe the ntb_msi_test client in the documentation.

Sanjay R Mehta (4):
      NTB: ntb_perf: Increased the number of message retries to 1000
      NTB: ntb_perf: Disable NTB link after clearing peer XLAT registers
      NTB: ntb_perf: Clear stale values in doorbell and command SPAD register
      NTB: ntb_hw_amd: set peer limit register

Wesley Sheng (2):
      NTB: correct ntb_dev_ops and ntb_dev comment typos
      ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window for crosslink case

YueHaibing (1):
      ntb: intel: Make intel_ntb3_peer_db_addr static

 Documentation/ntb.txt                   |  27 ++
 drivers/ntb/Kconfig                     |  11 +
 drivers/ntb/Makefile                    |   3 +
 drivers/ntb/{ntb.c => core.c}           |   0
 drivers/ntb/hw/amd/ntb_hw_amd.c         |  10 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.c      |   6 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c  |  82 +++---
 drivers/ntb/msi.c                       | 415 ++++++++++++++++++++++++++++++
 drivers/ntb/ntb_transport.c             | 170 ++++++++++++-
 drivers/ntb/test/Kconfig                |   9 +
 drivers/ntb/test/Makefile               |   1 +
 drivers/ntb/test/ntb_msi_test.c         | 433 ++++++++++++++++++++++++++++++++
 drivers/ntb/test/ntb_perf.c             |  14 +-
 drivers/pci/msi.c                       |  54 +++-
 drivers/pci/switch/switchtec.c          |  12 +-
 include/linux/msi.h                     |   8 +
 include/linux/ntb.h                     | 200 ++++++++++++++-
 include/linux/pci.h                     |   9 +
 tools/testing/selftests/ntb/ntb_test.sh |  54 +++-
 19 files changed, 1458 insertions(+), 60 deletions(-)
 rename drivers/ntb/{ntb.c => core.c} (100%)
 create mode 100644 drivers/ntb/msi.c
 create mode 100644 drivers/ntb/test/ntb_msi_test.c
