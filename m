Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D89C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AAB20838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Fq3RX+1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfGNTWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 15:22:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45785 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfGNTWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 15:22:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so14776052wre.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iP1QeXax5u9ablOpAghHD8pe3qwVvFJkG9TEutDiBgE=;
        b=Fq3RX+1QKKhVvJ0uP4diOj4HGXZNw+ejPy0Dp1pLgfy72hQXN6sLeFdamGRcDc1Y+Q
         H2Ck6LWDZ9gV8wnN3PpXTVhdtByQrqS5immPOzQsWL/H1J61PE9vP/QnNJk8YFDC5kyk
         zwOM4J07UC7LEevEU1T+KhALJOdKBjk+IhQaVMo/SKaYbZBAnEnN0x4cpqxpMf3r17xB
         frVzY80GiYN4XOTW52kMlr5DRJdKBShWrg3+vpyuW7z6Img1fUCqWg+mKnhQ6/ABs6dn
         pdhStCTBV6a0KiRiAs4Y0QgOP5Hf4n4TpHNSO51o9uCeX5Kuw74MJ5BxtS1K3NS/mBSJ
         JkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iP1QeXax5u9ablOpAghHD8pe3qwVvFJkG9TEutDiBgE=;
        b=Hs0wmfoG1Js2ZEEC7whoZlm4qPhKzFB4ddaV4ZUZMx7+lNHuxcaB8VE5CTAyPuotxb
         R4y/4cWLnGhXlEk7LCXAnsLqD/Yjg1WAPeuLxMV9Kby/hLAxqX8lSMLeOIGGi4q8eqdZ
         nlo1Jl6iS9uKou92L8CW4OtX/LqBCgurR5s7j6iJpDDbnkBhxpg0XaPA6VluLtqdog50
         V9Zf4/lD6N0KJfyJSa3YsZ48y5MBOc+spg9h5s/wt8Lya9FRlATxtgsGtYUhXry5o1Hk
         lgGY3c5Ro8IamejdXvRPdrv5TPMPg8QSCchXPcjRrkEzAwveiloVcF/Z8nk+YwsKvW2v
         BhIQ==
X-Gm-Message-State: APjAAAWlTev6Ch5Hvbh+qGxAUXU+g3mNUNN06VFSeRuRYcrR6BpK0WQf
        pHr3HGAQbOeaiTgIeDP2+xMRoqy54hE=
X-Google-Smtp-Source: APXvYqw0J8LToS007FVX0ITkQ4qnlB5Xn4e6LTfnb1KyxrbwaFKVpIOq5nV3BrWRMul1qe5qEwyz/A==
X-Received: by 2002:adf:f851:: with SMTP id d17mr24326405wrq.77.1563132168438;
        Sun, 14 Jul 2019 12:22:48 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id r12sm18142743wrt.95.2019.07.14.12.22.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 12:22:47 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/2] clone3 fixes
Date:   Sun, 14 Jul 2019 21:22:03 +0200
Message-Id: <20190714192205.27190-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

Here are two small fixes/improvements for the clone3 syscall that I plan
on sending soon.

The first patches reserves the clone3 syscalls number 435 across all
architectures by placing a commit in the corresponding syscall tables of
architectures that do not yet implement clone3. This is done to preserve
the identical numbering for all new syscalls that Arnd introduced.

The second patch dates back to a discussion with Arnd when I suggested
reserving the syscall number. Arnd suggested to ensure that we catch all
arches that do implement clone3 without explicitly setting
__ARCH_WANT_SYS_CLONE3.

Thanks!
Christian

Christian Brauner (2):
  arch: mark syscall number 435 reserved for clone3
  unistd: protect clone3 via __ARCH_WANT_SYS_CLONE3

 arch/alpha/kernel/syscalls/syscall.tbl    | 1 +
 arch/ia64/kernel/syscalls/syscall.tbl     | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl     | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl   | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl  | 1 +
 arch/s390/kernel/syscalls/syscall.tbl     | 1 +
 arch/sh/kernel/syscalls/syscall.tbl       | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl    | 1 +
 include/uapi/asm-generic/unistd.h         | 2 ++
 12 files changed, 13 insertions(+)

-- 
2.22.0

