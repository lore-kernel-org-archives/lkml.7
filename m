Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6705DC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C3F20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jjo8/bzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDOLl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:41:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37363 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOLl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:41:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so8467370pfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9vAsjj4wH0cq3m3qpVkSYBnwOxwjBpDvsPJW0c5pFjc=;
        b=jjo8/bznAfvwZ9+Xcy6VY23GYfv8XoI/ScoXsSDVX/xI0csb5RA1gUIQpTgMfDffLf
         08H5gttNVgjmUGOhJ/R+tWlxLe0tCxBkDmYOfxnROA4UEpU08bOhnBdTKQX2BF+djS8e
         JZ0eaLUMtYTN606fMdufSySDgGQfLu4amDdZwN6DgBdAg5jbNmNzJAt6zAddVIlOux5B
         EHvBDs4KBI/tXMj5GtVPnp+urM4r4v7/B7+7hguTIZ7MncP49poortFok/kCTSI1PuWz
         7NgiKBucZD92cCi9D9/pKfo3JtLBPV3RLLabmWXlj2jHlpDrFNnMezY3XI+xZV/bw0ae
         N8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9vAsjj4wH0cq3m3qpVkSYBnwOxwjBpDvsPJW0c5pFjc=;
        b=PuASPsuvy3buZ7mvRzttUOd2YwA4Di8x6nz8vkU72KoAI9VagYdlFROhtuAtTU8OuV
         UTUfRFK/DL4Tjzc/W7PU6GS6RRMCyznmdV36BfwZvLIdiN5jvqkdB1Jo5Bqaq53r3Y1t
         aFWpa/xLA6ErYmyTdmnGWfd3gG104TTVcldTAaDts9Hd7cOUImUCVkClW3WPu3O5Ryaa
         VZlnoSTIzubfwD5fyjDo2rveS40q0jOm07uQwarmvYgSwhxxogo6O8eMpnaYpIPE0Ckg
         dSsjPq7573P4/J0H3KwkWXIt8JFFVGB1uZPnxQ0TDoENlD6TfK6bp8LStq83pN9SGhKs
         E+kQ==
X-Gm-Message-State: APjAAAXrCaO0cqL7ortbfhPgUxjbUIrhbdQV5OEadIowBFue0AaRZdS0
        /b5YA9A3LlyxbNAU9EBkqwZMXg==
X-Google-Smtp-Source: APXvYqx4SVLlNI2m1S7EfnifBaaXSVCoC3VOJ0YAalvRiTkoqXpmx98l3ql8ZpwotOJc6pya6B+new==
X-Received: by 2002:a65:6410:: with SMTP id a16mr56340566pgv.315.1555328487201;
        Mon, 15 Apr 2019 04:41:27 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id l4sm32317273pgh.17.2019.04.15.04.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 04:41:26 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/3] L2 cache controller and EDAC support for SiFive SoCs
Date:   Mon, 15 Apr 2019 17:10:40 +0530
Message-Id: <1555328443-30874-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds an L2 cache controller driver with DT documentation
and an EDAC platform driver for SiFive SoCs.

The EDAC platform driver registers for notifier events from the L2 cache
controller driver for L2 ECC events.

This patchset is based on Linux 5.1-rc2 and tested on HiFive Unleashed
board with additional board related patches needed for testing can be found
at dev/yashs/L2_cache_controller branch of:
https://github.com/yashshah7/riscv-linux.git

Yash Shah (3):
  RISC-V: Add DT documentation for SiFive L2 Cache Controller
  RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive
    SoCs
  edac: sifive: Add EDAC platform driver for SiFive SoCs

 .../devicetree/bindings/riscv/sifive-l2-cache.txt  |  53 +++++
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/mm/Makefile                             |   1 +
 arch/riscv/mm/sifive_l2_cache.c                    | 224 +++++++++++++++++++++
 drivers/edac/Kconfig                               |   6 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/sifive_edac.c                         | 121 +++++++++++
 7 files changed, 407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 arch/riscv/mm/sifive_l2_cache.c
 create mode 100644 drivers/edac/sifive_edac.c

-- 
1.9.1

