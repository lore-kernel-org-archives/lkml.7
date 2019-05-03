Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8700AC46460
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F6E2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="WDVpnGuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfECEAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 00:00:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36786 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfECEAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 00:00:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id b18so4159953otq.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 21:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/2oLZth3d6lTSmqXK+KRn/EC/hEppxx8Q8bFkHJjpTE=;
        b=WDVpnGuTVdySlDsEVyhzBl2rxPdcjs3XN9sraMUpmlplzCmj3J+EusECWEvhcsmp/k
         +A64ByZoElP+f61GqB/9RE+huGrRkev74OPtK5G9Msj21CEh52kgp3WZtry6apol2h8Q
         LzDNnrn5uWmee8YDjAv7GfMdYpx/MtmNdv9CH2Is9gOFVTV3z9I4WOYTZARWMeNQ5D1R
         AIgq66XCg8oMIWW5S1YXRVzdG6BZsYIPJ1WYNxzuxM0dpCHrg4756Bwit/39G+4lXGgj
         L71fFpAa/mhFOIBJs0s2s15X5S43/+gzhB2enBI2l0/I76p+QHs982rvlaT4sMLYJkXS
         wOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/2oLZth3d6lTSmqXK+KRn/EC/hEppxx8Q8bFkHJjpTE=;
        b=LHV9nFehW2bFpbxtw/GxorL3ACaY8XorY5TDGaf3S9YlB6CIEuVBVQ1vcOOmepx8QK
         1LE4m/cMTFxf2qQ/a/KzuEKdfWmdSw8GZfJP0G2GFIXHASYE/E5MMfRnCS3BrVnOWrcy
         BLi4slBmvrENLiSdOoC0y/bsW6RMiSpl3KKdajkrMocjjpZr3E7zZxHlsYI8BCkM4LDk
         Ya5sbjI68EBKMFHAlvQSPzuEqVI7vLmF7hbr3XY0OR9bGzdN3IqnpGoAqMpHxnZKl8Go
         7seVeBsES13sUul5+11zHfir1sd/cF25cSBcFBCn27hPGmvI7oHwQxj51f7UfSfhDyuR
         52+w==
X-Gm-Message-State: APjAAAWuieF6HyIlQbycyrSlyhH5lFHffz5/XlFyf9vtu2fmiOm/X5uJ
        l5iS3gYrmqcF+pqSpzOlzqOPjQ==
X-Google-Smtp-Source: APXvYqy6KWNuHyZ4bmVPl7AtwCnrtgW7crNSpZilsNWCfKP1jSwTNkBNznOucbDkWdYYfSbymCBWLA==
X-Received: by 2002:a05:6830:1602:: with SMTP id g2mr4767166otr.329.1556856013208;
        Thu, 02 May 2019 21:00:13 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id h62sm392191otb.79.2019.05.02.21.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:12 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 0/9] PCI: Use PCIe service name in dmesg logs
Date:   Thu,  2 May 2019 22:59:37 -0500
Message-Id: <20190503035946.23608-1-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In referrence to [1], PCIe services did not have uniform logging via pci_*()
printk wrappers. Add dev_fmt() to each service, clean up dmesg logs,
use pci_dbg() for hotplug debug messages, and lastly, uniformally
add Slot(%s) prefixes to hotplug ctrl_*() wrappers.

1. https://lore.kernel.org/linux-pci/20190308180149.GD214730@google.com/

Changes from v1:
 - Split dev_fmt() additions into own patches per service
 - Kept ctrl_*() wrappers and applied "Slot(%s)" prefix to messages
 - Attempted to leave no log gaps between patches

Frederick Lawler (9):
  PCI/AER: Cleanup dmesg logs
  PCI/DPC: Prefix dmesg logs with PCIe service name
  PCI/PME: Prefix dmesg logs with PCIe service name
  PCI/LINK: Prefix dmesg logs with PCIe service name
  PCI/AER: Prefix dmesg logs with PCIe service name
  PCI: hotplug: Prefix dmesg logs with PCIe service name
  PCI: hotplug: Prefer CONFIG_DYNAMIC_DEBUG/DEBUG for dmesg logs
  PCI: hotplug: Remove unnecessary dbg/err/info/warn() printk() wrappers
  PCI: hotplug: Prefix ctrl_*() dmesg logs with pciehp slot name

 drivers/pci/hotplug/pciehp.h       | 28 ++++----------
 drivers/pci/hotplug/pciehp_core.c  | 20 ++++++----
 drivers/pci/hotplug/pciehp_ctrl.c  | 60 ++++++++++++------------------
 drivers/pci/hotplug/pciehp_hpc.c   |  9 +++--
 drivers/pci/hotplug/pciehp_pci.c   |  2 +
 drivers/pci/pcie/aer.c             | 19 ++++++----
 drivers/pci/pcie/aer_inject.c      |  6 ++-
 drivers/pci/pcie/bw_notification.c |  2 +
 drivers/pci/pcie/dpc.c             | 37 +++++++++---------
 drivers/pci/pcie/pme.c             |  2 +
 10 files changed, 89 insertions(+), 96 deletions(-)

--
2.17.1

