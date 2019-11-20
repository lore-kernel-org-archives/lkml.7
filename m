Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203DDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51D42252C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="YreErlZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfKTNkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38770 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbfKTNkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so7865861wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 05:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hc+e/4bbkmOsPc7h3n96rW8fCtHfYV+rcvDUEGU80WQ=;
        b=YreErlZlPJh+ONjf/24/XKR2tp1V0tI82se8RiBRjVqwfZj4r2VHnsbcTRwyLtFtPi
         m425AUFz9OdzMCNLdOlhtkeuUyYnv+iXxPY4RKjIWaFDirWUu3ohOGHntM71SUY5P3n8
         WGqM67AN98Jgp2Pr0j7pLNbpkjfICD63OwRzkHJYyKZ7ZGpu/7M1ftpb2BNaWZ3yVemt
         8vKtB9cgAaVib6G/r53uPmElhvhu1+hbD6VTglES/yMpKxtgcLd2NKANYpFfllEMEnfy
         TvtqjNtCIzQmG6Lq7PRvxJsTXUIFy2clzU0MBG2bteNdIJ9GvtcckDd5IJKsTYhslg7Z
         cieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hc+e/4bbkmOsPc7h3n96rW8fCtHfYV+rcvDUEGU80WQ=;
        b=lQYPfRpkHpEOpxYzdOpLvcIJbGhMHeU0OLjtzt9rXf4qHuHgULSaUddPSNNwNDpTmV
         tdueMc1uAZCqWq4IFvHmyWULzamauhVShvyvWQSknXopvUOf8m6U3pISF9zGo1fhsbiM
         GJYb5sC/0anOG6WeihnIvt7xjN31RCK8m1qxqdkk6nSstfCjjATIm3t5PX/EwirQfoPU
         U/zbSJHirgzNmpVZn/EMeRKyqKkM0x3So4aJJ1CjHGqKH9xmeHUy6oOzBgn48aHz1Wou
         gfpXJLuE8AfDewzobYnLiy9n5Wbt5fzXBHYLqfHUARitlFENEgHF59K/mg9WMYnY78KU
         h/wQ==
X-Gm-Message-State: APjAAAVLNSzHjdDFfMPzdAAUMs3mqtc25gSX4b0Vihzs3ElH7eSn2JNP
        +VEjMZzMEcuauBAu8qu7Q0sE8xifhiPt5W3f
X-Google-Smtp-Source: APXvYqwQpaqJpD3l6llJ7t3FYS4oXmsrEDSYQUr/f+rrl6YFypfpvaXy7hyGHbaIxrecX8QmgxFleg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr3400151wma.116.1574257216438;
        Wed, 20 Nov 2019 05:40:16 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id t14sm30473434wrw.87.2019.11.20.05.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 05:40:15 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 0/2] firmware: google: Expose coreboot tables and CBMEM
Date:   Wed, 20 Nov 2019 14:39:45 +0100
Message-Id: <20191120133958.13160-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

As user land tools currently use /dev/mem to access coreboot tables and
CBMEM, provide a better way by using read-only sysfs attributes.

Unconditionally expose all tables and buffers making future changes in
coreboot possible without modifying a kernel driver.

Changes in v2:
 - Add ABI documentation
 - Add 0x prefix on hex values
 - Remove wrong ioremap hint as found by CI

Patrick Rudolph (2):
  firmware: google: Expose CBMEM over sysfs
  firmware: google: Expose coreboot tables over sysfs

 Documentation/ABI/stable/sysfs-bus-coreboot |  73 +++++++++
 drivers/firmware/google/Kconfig             |   9 ++
 drivers/firmware/google/Makefile            |   1 +
 drivers/firmware/google/cbmem-coreboot.c    | 162 ++++++++++++++++++++
 drivers/firmware/google/coreboot_table.c    |  60 ++++++++
 drivers/firmware/google/coreboot_table.h    |  13 ++
 6 files changed, 318 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-coreboot
 create mode 100644 drivers/firmware/google/cbmem-coreboot.c

-- 
2.21.0

