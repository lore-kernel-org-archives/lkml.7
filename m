Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A809C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4FB2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EX46zlqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfLFCB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:01:59 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:50292 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFCB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:01:58 -0500
Received: by mail-qk1-f202.google.com with SMTP id j1so3494043qkk.17
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 18:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7yhy1qVy7r+OhvXrem9lQMeX0WI2ZBv4daZte/Qe81A=;
        b=EX46zlqkNdgUkQf4DjlzdWcdW0CotPab3ag5TehwyqpseikYVbO8LOlacwlZv8u/6h
         TNnsxzYEASdKkuiCFl9UkI14s0SP5xwOBQIcoW4xxVCw45EPIA1W+42WHM8ForICvwwY
         ZSG2uZjkWJ7CQvaZBX8JAeezo2S3bjAJGB9AWN+sTgewVxGK7q4oi6Ti1aFH06ww1xji
         HnHUzrvD4XvhL3yKrdGMDaUvZUNA5GWUwVE6NA7VyXdOAmyn8TtYeTMJB/mfzDRWZVN2
         fGprjqR7yw7qDNJnErIqcttmh6hajXBVmR+2H5wpWpz/gYLFLcxLV2qiNZiM8Bk5K2rJ
         WT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7yhy1qVy7r+OhvXrem9lQMeX0WI2ZBv4daZte/Qe81A=;
        b=IadunemzEC0olgaF5SXeN6r5q0nj7MO+H+hUrVas55qKFf3qWcN3P5uh/j8cjSlnwJ
         PQXv0O1DpBbtevl4XaqYccjgM9FBrbWMGTLMie60u91GjOU2Rsl16xiHSBgdKnaI14B8
         QFOxqwNnK6ngtq/zFIt7/f3DKAnJ42IeyB3LZ05kjtTcImoo+KWqKFQ+Vm55MgvO59eT
         aUdvCBeonW7ZYFJm2R9l/+BVT0qdmqRtY1iumXOSMsugSqhMCVgO4+e+mf07f4Fi+WOk
         /A/HtdyOKTLYzcBpIyHQWWdT6NFx+21L765zcn/Lm+pGHWfdyoE+BnF+OjftbA1EZxGs
         oYYQ==
X-Gm-Message-State: APjAAAUYQv6DiHatcXN01IkzvMS/6AP4Rjlwed8WB+xGOVyUECwTlYI3
        cQRMKurvNQ/VAqUkEU+HtbyKiep1nyLBcn5zyebQsQ==
X-Google-Smtp-Source: APXvYqx8I5bEIazMNgm70QCTtM1l3Nmciyo0UDNEDBk/gGH1/pKfd5iPWcvoIq0JcpNcc2IVrJoYfiifLm5Gs//JviyGSQ==
X-Received: by 2002:ac8:425a:: with SMTP id r26mr10607042qtm.138.1575597717420;
 Thu, 05 Dec 2019 18:01:57 -0800 (PST)
Date:   Thu,  5 Dec 2019 18:01:51 -0800
Message-Id: <20191206020153.228283-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [RFC v1 0/2] um: drop broken features to fix allyesconfig
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# TL;DR

This patchset drops two broken features in an attempt to get
allyesconfig closer to working for ARCH=um.

# What am I trying to do?

This patchset is part of my attempt to get `make ARCH=um allyesconfig`
to produce a config that will build *and* boot to init, so that I can
use it as a mechanism to run tests[1].

# How far away are we from an allyesconfig UML kernel?

I have identified 33 Kconfigs that are selected by allyesconfig, but
will either not build on UML, or prevent it from booting. They are:

CONFIG_STATIC_LINK=y
CONFIG_UML_NET_PCAP=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_IP_VS=y
CONFIG_BRIDGE_EBT_BROUTE=y
CONFIG_BRIDGE_EBT_T_FILTER=y
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_MTD_NAND_CADENCE=y
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_RAM=y
CONFIG_SCSI_DEBUG=y
CONFIG_NET_VENDOR_XILINX=y
CONFIG_NULL_TTY=y
CONFIG_PTP_1588_CLOCK=y
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_DMABUF_SELFTESTS=y
CONFIG_COMEDI=y
CONFIG_XIL_AXIS_FIFO=y
CONFIG_EXFAT_FS=y
CONFIG_STM_DUMMY=y
CONFIG_FSI_MASTER_ASPEED=y
CONFIG_JFS_FS=y
CONFIG_UBIFS_FS=y
CONFIG_CRAMFS=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_KCOV=y
CONFIG_LKDTM=y
CONFIG_REED_SOLOMON_TEST=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_MEMINIT=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y

This patchset attempts to deal with CONFIG_STATIC_LINK=y and
CONFIG_UML_NET_PCAP=y by just removing them since they are broken and
appear to have been broken for some time. (I am aware of the taboo of
dropping configs, but given the amount of time they have been broken, I
figured that I might be able to get away with it in this case, which is
easier than trying to actually fix them.)

I also have a patch out to fix CONFIG_EXFAT_FS=y[2].

After this I plan on going after

CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_MTD_NAND_CADENCE=y
CONFIG_FSI_MASTER_ASPEED=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_XIL_AXIS_FIFO=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_XILINX_AXI_EMAC=y

the problem with these is that they depend on
devm_platform_ioremap_resource without explicitly depending on
CONFIG_HAS_IOMEM=y.

Also note that I don't think that CONFIG_NULL_TTY=y is actually broken
on UML; however, console seems to get assigned to the null TTY by
default when it is enabled, so I added it to the list for the sake of
completeness.

The other broken configs require more investigation (I would welcome
help, if anyone is interested ;-) ).

# Why won't allyesconfig break again after this series of fixes?

As I mentioned above, I am using UML for testing the kernel, and I am
currently working on getting my tests to run on KernelCI. As part of our
testing procedure for KernelCI, we are planning on building a UML kernel
using allyesconfig and running our tests on it. Thus, we will find out
very quickly once someone breaks allyesconfig again once we get this all
working.

Brendan Higgins (2):
  um: drivers: remove support for UML_NET_PCAP
  uml: remove support for CONFIG_STATIC_LINK

 arch/um/Kconfig              |  23 +----
 arch/um/Makefile             |   3 +-
 arch/um/drivers/Kconfig      |  16 ----
 arch/um/drivers/Makefile     |  17 +---
 arch/um/drivers/pcap_kern.c  | 113 ----------------------
 arch/um/drivers/pcap_user.c  | 137 ---------------------------
 arch/um/drivers/pcap_user.h  |  21 -----
 arch/um/kernel/dyn.lds.S     | 170 ----------------------------------
 arch/um/kernel/uml.lds.S     | 115 -----------------------
 arch/um/kernel/vmlinux.lds.S | 175 ++++++++++++++++++++++++++++++++++-
 10 files changed, 174 insertions(+), 616 deletions(-)
 delete mode 100644 arch/um/drivers/pcap_kern.c
 delete mode 100644 arch/um/drivers/pcap_user.c
 delete mode 100644 arch/um/drivers/pcap_user.h
 delete mode 100644 arch/um/kernel/dyn.lds.S
 delete mode 100644 arch/um/kernel/uml.lds.S

Looking forward to hearing people's thoughts!

[1] https://bugzilla.kernel.org/show_bug.cgi?id=205223
[2] https://patchwork.kernel.org/patch/11273771/

-- 
2.24.0.393.g34dc348eaf-goog

