Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001F3C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFF920692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqR48An0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfLIDCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:02:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39796 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfLIDCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:02:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so6441391pfx.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 19:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NbnsQ6ttBdh/Z/p6HKp+CY97QZQdRbJ9oPgvtM/X3Xk=;
        b=UqR48An0tfqvHjq/UHrgSgERccvByqklZebNFmIzyHBPsp3DcP29jBrAtbNOopkKfp
         fgJYRqkbswS/wiiDwlRCu3DJYHi/1aC//Zy5pTi7J0OVW6UHkFQKZXOcs+OMVTwtK2zT
         obluGXLQTOk8bvwqXcwtul7vuclqcwztBHIDUmmnc4jA32ji14qcCudxPJavX6Irs/iT
         PUm1NzQhqmvC5+C1y1+PTIgaRR/a57mBerAI5ECJp4b/kIyiLp5fkevyjAXT565pQ4QN
         3dtTpLUAZBC+NYLXYkbGr1259qR2aIWtmgt2vwjdw27nKXRw2p7fG+R5AoY5rMjycuca
         uz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NbnsQ6ttBdh/Z/p6HKp+CY97QZQdRbJ9oPgvtM/X3Xk=;
        b=j4GI/u/4LHQHBTrSlrOmaEH719g3QP+gWpSYUe1Zfw+4h0YYYRHanc3/KIZMAxmzg4
         flQQc+HWR25FnPeNWdYmUO/9mQjkMkOXsp2QErFulVMKQE9MHGuZbgz1pw0dx+C2Z2kY
         17JFE57Kd7e4sSAvqM91iZ8FqtEBNPZ2G+IoJnhLae1qdIqFtRs9y/hLp4cYHUrC4LPJ
         8zaDoWd8C4RxH7ks04C2WgxdZVF5NSYtGi/RoT3cx4+/6ovbj6oUdhdffAF+/PYRu6hE
         XoraMBw3+pDvy2shrneUxUm4MkIuTyjfx8wyeXS3SKu3oK4mbygh3W+EB4VZc47fMFft
         6VXQ==
X-Gm-Message-State: APjAAAV6vjLDzj4hwAmLrOP766w3PJJ9MVWKBzldTZDoq3ACEcVK+xgB
        8Q9o8AmE5T4wHT6G6hk7INjeSNgdWqw=
X-Google-Smtp-Source: APXvYqyFDl32R/rnwpVkKgrNnE1eRzlqR9wwFkEon9M0auaRUzwaRi9sgW8y2FSWf8RbQdA7tC4HnA==
X-Received: by 2002:a62:382:: with SMTP id 124mr2496242pfd.11.1575860533827;
        Sun, 08 Dec 2019 19:02:13 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id z19sm23401431pfn.49.2019.12.08.19.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 19:02:13 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 0/2] arm64: kexec_file: add kdump
Date:   Mon,  9 Dec 2019 12:03:43 +0900
Message-Id: <20191209030345.5735-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last piece of my kexec_file_load implementation for arm64.
It is now ready for being merged as some relevant patch to dtc/libfdt[1]
has finally been integrated in v5.3-rc1.
(Nothing changed since kexec_file v16[2] except adding Patch#1.)

Patch#1 is preliminary patches for libfdt component.
Patch#2 is to add kdump support.

Bhepesh's patch[3] will be required for 52-bit VA support either against
legacy kexec or kexec_file.
Once this patch is applied, whether or not CONFIG_ARM64_VA_BITS_52 is
enabled or not, a matching fix[4] on user space side, crash utility,
will also be needed. 
# NOTE:
# As of v5.5-rc1, crash utility doesn't work due to the commit
# b6e43c0e3129 ("arm64: remove __exception annotations").
# But the fix is trivial and it won't affect this kernel patch.

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
[4] https://www.redhat.com/archives/crash-utility/2019-November/msg00014.html

Changes in v3 (Dec 9, 2019)
* rebased to v5.5-rc1
* remove v2's patch#2 as the same fix has been applied
* Otherwise, no functional changes (since v1)

Changes in v2 (Nov 14, 2019)
* rebased to v5.4-rc7
* no functional changes

v1 (Sept 12, 2019)
* on top of v5.3-rc8

AKASHI Takahiro (2):
  libfdt: include fdt_addresses.c
  arm64: kexec_file: add crash dump support

 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/kexec_image.c        |   4 -
 arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
 lib/Makefile                           |   2 +-
 lib/fdt_addresses.c                    |   2 +
 5 files changed, 109 insertions(+), 9 deletions(-)
 create mode 100644 lib/fdt_addresses.c

-- 
2.24.0

