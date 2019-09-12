Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE27C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668B02075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sinym85E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfILF6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 01:58:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37256 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILF6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 01:58:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id b10so11311104plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 22:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewsM+ptx+1TxqOGMUvTLgS+XKJ532sfsZuY42/XtR1w=;
        b=sinym85EOH7jJpDdKQ/TEn8uVKWo7eqXR7VorCouyeWiz9YlVd8iijtdZKbkft+aS2
         cma3rSeSWJ7ndFdyqkGxMchUx8dOKSyLfKMCbyIQidLAoMzaSmx9vLlwLdra8KyKTXQ3
         269kt8q4g7LDXXKCpHg1Vv73xtiXw+VjC1AJpdvhmD6nVoOKl+qkIW3OBOyr9WsVP1ng
         gYyHl0OeSeFxh1c6AWpdTp+dnjVzCyLgYV8HU5B35iGz1ixQHZGzJsTzPCoDnnFhQEy7
         26RfJLNjncKmzsJ+jDkqTyojTnDBSi8O5eDvkn+u08SEwMO1HwZyrkiXNYUeHg2c9Z1E
         8lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewsM+ptx+1TxqOGMUvTLgS+XKJ532sfsZuY42/XtR1w=;
        b=ZVRHjSESrGe1q8wRDwhG0sQ17zboFae2RcVuTzg5yorYDJJjqHzJMPWnLi6kESquCS
         a3snfr75o0zy2Dd32VWw3x3mPbqlDylLuHUeECOM9RQD8rpl9NrqXGpsvxwAZ3jlKvD8
         sMAM3fP9AJfF8l0CyD07UzIpGSvwiGmyDfjL5h+/SvLoonuo4SMbtlj31HqdF+8hoOMx
         Kb2XhM5myh8CgummtTzDqOegOYcHr52nRMcqZR6FD/KMDq7i60MS5mUoizvfSqjvkuaa
         49Q3WO/Jpl2y6agP+aLdgrjm8Se6968phv0nFNcNRtMpIF3Sv8iT12JYNePkdBAH18RK
         AIng==
X-Gm-Message-State: APjAAAXgBUpo9VM97IzlKfJd/oiQINXJb4mQuyE+nyzx5DPbcn3hQnIo
        rXdDUnraTVp9XcKl0aahsnI7FA==
X-Google-Smtp-Source: APXvYqzZpl0/HTX1R8ymT1ubUa4kovYmNBK+fPCzo83wsXYgya38Pn/fN+mE+kfvEHZnSIqyD+crrA==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5mr35629312plb.120.1568267923917;
        Wed, 11 Sep 2019 22:58:43 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id r30sm45472534pfl.42.2019.09.11.22.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 22:58:43 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/3] arm64: kexec_file: add kdump
Date:   Thu, 12 Sep 2019 15:01:47 +0900
Message-Id: <20190912060150.10818-1-takahiro.akashi@linaro.org>
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

[1] commit 9bb9c6a110ea ("scripts/dtc: Update to upstream version
    v1.5.0-23-g87963ee20693"), in particular
	7fcf8208b8a9 libfdt: add fdt_append_addrrange()
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612641.html

AKASHI Takahiro (3):
  libfdt: define UINT32_MAX in libfdt_env.h
  libfdt: include fdt_addresses.c
  arm64: kexec_file: add crash dump support

 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/kexec_image.c        |   4 -
 arch/arm64/kernel/machine_kexec_file.c | 105 ++++++++++++++++++++++++-
 include/linux/libfdt_env.h             |   3 +
 lib/Makefile                           |   2 +-
 lib/fdt_addresses.c                    |   2 +
 6 files changed, 112 insertions(+), 8 deletions(-)
 create mode 100644 lib/fdt_addresses.c

-- 
2.21.0

