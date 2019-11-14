Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CCFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BCA206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAqGs6fQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKNFOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 00:14:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38384 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfKNFOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:14:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id w8so2081524plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 21:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7b2JPtWwEx72nyCRSKpBp7/BtsD5j/Gd6lSZi42tNY=;
        b=SAqGs6fQe8YE08HwbEoz3pMr+dp5RUp5r07rVVDRW1kTo3hsf1d0dzMBdMNQbAqOa+
         6xDVVt10resWw/FTWyy8sWSzzlyQ5a0kQ50/t43SI/7LD8UkqOJsxJdriFxpoUFe8N6l
         hbL2nLKz5wc1YvFIfbr74jMQPuusyPBbR8Bg5CzEVBj85/whJlLXjWcQROl5qJqCTv40
         5pNxOqKDIq/82f9UByGx9DP1aiNI6vHqxFaBPQGBlqnLeebjOcCQcQB2sZxjDyY8L88Q
         aiYpfon2RNigH4ZfGF8tbhyvLrQe5NiBtmBdC2KZ6cQl379vvUy2IbrfSHKpBv5aITAc
         5SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7b2JPtWwEx72nyCRSKpBp7/BtsD5j/Gd6lSZi42tNY=;
        b=MKJV41QlAhwSSncgx08S6semh35LzR1rQduiggYIJo0E4Mzy7skEBMur0N1DiVVcuQ
         YqDrhMz5OmubEaaJaZ/ZCuZk/gASSPpucBEInTgDobEYAmvJotHHVEtSdeRtfkjv5UdK
         9qZr0/KUGHu0u2WwJRxQDpCLc2bAP9orYC8kS6oJxMYxpwMFmKr2hxG87PGUy4SwFvJ2
         9sdA2dQnYyp0m5uhJdugz0pJlVIokqYvF6h2LacEJS28Twz9ufzucSXFk8XPpkFHzluN
         Z0S4nwSCfVkND0W57OZh8fd09Lp+4ZirUAgzGOlyOfi2ARuKSbpYDg17kqkwK0Ke3bpb
         7IjA==
X-Gm-Message-State: APjAAAVTuLVPbSqPOepOPYfJBw04svff/Bvl8uI9oiiKHJEV7Q3makxI
        LcT+ljIAR6GhR7yJQUp+fbZB07c0PZA=
X-Google-Smtp-Source: APXvYqyUGkyUr51KXBUYxjBncLe29pHZ3ycMcQpcMe9U0q8KrLojzhcQSJQH8Kdlb50vioiqEfwVzg==
X-Received: by 2002:a17:902:aa42:: with SMTP id c2mr7453010plr.311.1573708474696;
        Wed, 13 Nov 2019 21:14:34 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id i123sm7799642pfe.145.2019.11.13.21.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 21:14:34 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 0/3] arm64: kexec_file: add kdump
Date:   Thu, 14 Nov 2019 14:15:07 +0900
Message-Id: <20191114051510.17037-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last piece of my kexec_file_load implementation for arm64.
It is now ready for being merged as some relevant patch to dtc/libfdt[1]
has finally been integrated in v5.3-rc1.
(Nothing changed since kexec_file v16[2] except adding Patch#1 and #2.)

Patch#1 and #2 are preliminary patches for libfdt component.
Patch#3 is to add kdump support.

Bhepesh's patch[3] will be required for 52-bit VA support.
Once this patch is applied, whether or not CONFIG_ARM64_VA_BITS_52 is
enabled or not, a matching fix on user space side, crash utility,
will also be needed. 

Anyway, I tested my patch, at least, with the following configuration:
1) CONFIG_ARM64_BITS_48=y
2) CONFIG_ARM64_BITS_52=y, but vabits_actual=48

(I don't have any platform to use for
3) CONFIG_ARM64_BITS_52=y, and vabits_actual=52)

[1] commit 9bb9c6a110ea ("scripts/dtc: Update to upstream version
    v1.5.0-23-g87963ee20693"), in particular
	7fcf8208b8a9 libfdt: add fdt_append_addrrange()
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612641.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-November/693411.html

Changes in v2 (Nov 14, 2019)
* rebased to v5.4-rc7
* no functional changes

AKASHI Takahiro (3):
  libfdt: define UINT32_MAX in libfdt_env.h
  libfdt: include fdt_addresses.c
  arm64: kexec_file: add crash dump support

 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/kexec_image.c        |   4 -
 arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
 include/linux/libfdt_env.h             |   3 +
 lib/Makefile                           |   2 +-
 lib/fdt_addresses.c                    |   2 +
 6 files changed, 112 insertions(+), 9 deletions(-)
 create mode 100644 lib/fdt_addresses.c

-- 
2.21.0

