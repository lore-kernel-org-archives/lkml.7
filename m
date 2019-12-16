Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA55DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738C624676
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFtjl2oO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLPCKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 21:10:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40620 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPCKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:10:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so2747082pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 18:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dA+Be6hjL2cHUlLT4b0QsKh2SO4TkadtZEXugHfpPn0=;
        b=YFtjl2oOg9s6QG+eXFDBYnsP4sW5M5MAy/pdUOOJ6vuyeF1jflPjV2z/YOo+il9v4R
         /eGDJcWYRPV1NoTwxvKC28S5k8H1bEsJsLsmVv2mt/jVvcBlYNhrgg+B+7pllBvUZw6I
         d3qmgKuQI/28TpQHnmxJ0pAF9x0DLSZMbVaEK+8l14cJvPKAdTYCJnYtt/PNXh5iwi+Z
         ajVNj0fF9ptvGl7KRtstEdNoI5kWTL0NyIAE6eOtR1auwBLObX+NfVqNYtG5/PoE/oIv
         d62acGTLwbz8ud1mB2Jn9d/s0jSRR069/iAUPxmsEijJaOVAR7RfiGz/br8Hvpm6UEHA
         ufEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dA+Be6hjL2cHUlLT4b0QsKh2SO4TkadtZEXugHfpPn0=;
        b=neGU4dRswezbwyoBAWyQFb7bUUTKpMlVJZjG2cqKDg2MSGg6cV8t4G7RT58A3a+il+
         76x/DGbEcXrDdDNT+iOOFTkgvAV7VICNJ3g34yMr5C/1C0mboGbLPlflUZGL5Md+sM+x
         Yj38WB85BiL8o9LYnou5Ke794mk1z9DCBXLEJoBGRa9JIovTGlAf0nyxiBdZD2+2W7Nu
         4LG4yxmfkPAPMQj/HsUCGgMA0PtbO4yciJWuAjZ+Tvd/HfFWb2pt+wwCQ1FjGCqsezfq
         Ecqipn5XzQYfK4QL2bMq1RtVjlCksZntd9acPEKSo+noj+FcriulIcqQbirHx7sFkFeQ
         JIVg==
X-Gm-Message-State: APjAAAWk2b3nc/j/oj+rKDt+/9O3Cfo2Tk7gkSuL86UM4TTWRf6INl6D
        nCNtzaBtI/jiljKPeoeUSKj0eQ==
X-Google-Smtp-Source: APXvYqylJxqANyN2tsXOloyg9jZCWJSFnvigEIIla7pk6dyyIchgI7ylkTViTT47zhAEhRlY2Fi3yg==
X-Received: by 2002:a65:644b:: with SMTP id s11mr15436130pgv.332.1576462252631;
        Sun, 15 Dec 2019 18:10:52 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id o31sm18900626pgb.56.2019.12.15.18.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 18:10:51 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 0/2] arm64: kexec_file: add kdump
Date:   Mon, 16 Dec 2019 11:12:45 +0900
Message-Id: <20191216021247.24950-1-takahiro.akashi@linaro.org>
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
(Nothing changed since kexec_file v16[2] except adding Patch#1 and #2.)

Patch#1 and #2 are preliminary patches for libfdt component.
Patch#3 is to add kdump support.

Bhepesh's patch[3] will be required for 52-bit VA support either against
legacy kexec or kexec_file.
Once this patch is applied, whether or not CONFIG_ARM64_VA_BITS_52 is
enabled or not, a matching fix[4] on user space side, crash utility,
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
[4] https://www.redhat.com/archives/crash-utility/2019-November/msg00014.html

Changes in v4 (Dec 16, 2019)
* rebased to v5.5-rc2
* use KEXEC_BUF_MEM_UNKNOWN instead of "0" (patch#2)

Changes in v3 (Dec 9, 2019)
* rebased to v5.5-rc1
* no functional changes (since v1)

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

