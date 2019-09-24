Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE074C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70802053B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="mda76Tfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436685AbfIXJ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:56:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34125 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395316AbfIXJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:56:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so1226412wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6mFLvIMfw2DNaFq2SlQUFoLc0Apcq4Du4YX3SLzWJpM=;
        b=mda76TfiArq/V8QqRLC1++0HuqHIXhUKYZ5ljVy4Ace07v2wzTCsKegaGZCkcjs6T+
         eA28YmI55iSyvkRcOOb4yIDXIcCInWMFZav+jrRhnZSdYKzWRRJd2iH7Zv22P/b+R2SL
         ZKiBEnsVeiz8dTEDS7oVmdBwK5SRmhD2qooXfl2ZI/gTGGO2G0slza0y4WVkMYMO+kD7
         AHZmFAe2KNLQzJU/TtIwLmYJAsAhmSyw1KbyypgsM3/SF+v2xgOit949b4SZeuuXPdVs
         X2G+pKht8BTU0myEL3ptA7ImllNNZ+3odA0o2/5icyRjZjbbW0JqucQigE97TVSwiOhI
         GSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6mFLvIMfw2DNaFq2SlQUFoLc0Apcq4Du4YX3SLzWJpM=;
        b=VAij/jY0L/7BAd6eGEcoS6+Tp0w/sJKMjRug1y9zMqZQGGtYy1B6sgE9WH7Ii8bzFh
         rd49kVBtcHMzfTChkRYnCRt7nA6YqeKyU2z8/HX5fT3+YEfWpdhO5YK0JZeJ2GGKpOmy
         atKFCu0H2evQK0735+VwQjMGe+/z33txwkY+pdiVkNyqXsXISvnOYEoJwL4t5iRnS8Lx
         O3h+HgpGSD4FPYi9Wepl/ouzhR/92BnATtziwAeQUKPDb6PAAMbL0LE/EwlEkK+c97J1
         MdrVT/cz15mC6V1ZNo90UnjCBRGkSM/SQoPJ41Ks1pple7eUj2jHFeAjLFjw13xqoGor
         WbGA==
X-Gm-Message-State: APjAAAVou6Mr5VR/HJmghlHp0KT67HLxghFKk0Nd4KKNCuooW8sKmY6X
        zotCNdVTIwK3UfZyQNQ9STSl0bsKRY1y7A==
X-Google-Smtp-Source: APXvYqzWyQ3Vc4JJNt1BcrebaTvJAE7VZZtlPdYHSjHUo4w+Tw2fNs3nHjojwC6mJJ5zaVRRshRFKg==
X-Received: by 2002:a1c:1f47:: with SMTP id f68mr2129335wmf.78.1569318979864;
        Tue, 24 Sep 2019 02:56:19 -0700 (PDT)
Received: from [64.233.167.108] ([149.199.62.129])
        by smtp.gmail.com with ESMTPSA id f13sm1190257wmj.17.2019.09.24.02.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 02:56:18 -0700 (PDT)
From:   Michal Simek <monstr@monstr.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [GIT PULL] arch/microblaze patches for 5.4-rc1
Message-ID: <99b0cfb6-0d4a-555b-ebd6-d97f96dfd2c9@monstr.eu>
Date:   Tue, 24 Sep 2019 11:56:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following patches to your tree. Just a reminder to
remove atomic_pool_init() from arch/microblaze/mm/consistent.c.
In tag I have also added link to patch created by Stephen.

This is the first time this is needed that's why please let me know if I
should do it differently.

Thanks,
Michal

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.4-rc1

for you to fetch changes up to 7cca9b8b7c5bcc56d627851550840586a25aaa1b:

  microblaze: Switch to standard restart handler (2019-09-19 10:43:32 +0200)

----------------------------------------------------------------
Microblaze patches for 5.4-rc1

- Clean up reset gpio handler
- Defconfig updates
- Add support for 8 byte get_user()
- Switch to generic dma code

In merge please fix dma_atomic_pool_init reported also by:
https://lkml.org/lkml/2019/9/2/393
or
https://lore.kernel.org/linux-next/20190902214011.2a5400c9@canb.auug.org.au/

----------------------------------------------------------------
Christoph Hellwig (3):
      microblaze/nommu: use the generic uncached segment support
      microblaze: use the generic dma coherent remap allocator
      microblaze: remove ioremap_fullcache

Linus Walleij (1):
      microblaze: Switch to standard restart handler

Michal Simek (2):
      microblaze: Enable Xilinx AXI emac driver by default
      microblaze: defconfig synchronization

Randy Dunlap (1):
      arch/microblaze: support get_user() of size 8 bytes

 arch/microblaze/Kconfig                 |   3 ++
 arch/microblaze/boot/dts/system.dts     |  16 +++++++-
 arch/microblaze/configs/mmu_defconfig   |  22 +++++------
 arch/microblaze/configs/nommu_defconfig |  25 ++++++------
 arch/microblaze/include/asm/io.h        |   1 -
 arch/microblaze/include/asm/uaccess.h   |  42 +++++---------------
 arch/microblaze/kernel/reset.c          |  87
++++++-----------------------------------
 arch/microblaze/mm/consistent.c         | 223
++++++++++++++++----------------------------------------------------------------------------------------
 8 files changed, 96 insertions(+), 323 deletions(-)




-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

