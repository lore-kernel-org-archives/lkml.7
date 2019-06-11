Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A0FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EB02145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCGIgQFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404826AbfFKPTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:19:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40355 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389418AbfFKPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:19:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so14972908qtn.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kg91m/sJcxPHqFT1g9clpn/F84Kg2JYsIXkgOrosMxA=;
        b=UCGIgQFX7Ax5GANZnFSoE4A2CfOvsxLOhWTJ2CDXQ2pbqSLm68AYfyGIJseVxWV9fP
         m+UafrwcE9+EI9vssGMAvJgOfEVy/4tmwZtBq27pKO9YfU086RV41KvXLS70xrDQLr42
         OZDG1FoJoqyYVOpIPvTfZNzxUx/9/IEVUGbQRN2vH1EHk1fWJEwUfEdsl8U/7HDBG1O5
         wuBdmG8H4Jv6hza0zx1zbtsYkpdi5nzL5zpmq1/nItFUp5c9VMRX+J3oz3eGKIaA5c17
         IHpRc7ucS17TAQapqiJoSA2qLbCVYPApBZH57HJZisa5Q3PmAkOPE1kOZ/2L4k/2s8wd
         HjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kg91m/sJcxPHqFT1g9clpn/F84Kg2JYsIXkgOrosMxA=;
        b=gh5s++YmnwYXctZm5D8F+uNb1cgu0jwOnF0IIJ4LneMD+saGilYMT1z8ghSx1UGMDl
         Uar7Q4ZZXNw64Sz+nmucNeb/pwbwNP+N1gorKZYZ8g491tlc3n6uRayF0TEsF6k+Gg2O
         8fsErvGoSftqd+INZ8WClHHGdD6EZzso0l6bfZzuDPvOQilQS/DvT4UdkGmLXU+zjdPI
         I+q4oJ1rKSZ9KqO39I9IuiD/EIhw0m/tMYEntE7P1XGD3kPg++JWJN16GSAUqelEIx7H
         ODGKfo/FWW4GllrimnYIEU8UHPIWFEQB+4A/XNGvI05jcz3MkkBs3W2TtDIGaoRi2cgl
         iHBw==
X-Gm-Message-State: APjAAAW6sBnwnDlq9TminAm7Xo5aR0pM+weBfkrDDQHmD56gAawkbWh+
        vpLoBVX7xEasGvvTV/i9YQ==
X-Google-Smtp-Source: APXvYqxqKUjZCNGzPTqqjaZAUIDyNVMNNbZ7yHVfjGNp9uMe9ANdgOsfpgtugQlDcZNWYCk5lSGQOg==
X-Received: by 2002:ac8:3613:: with SMTP id m19mr63926870qtb.193.1560266374218;
        Tue, 11 Jun 2019 08:19:34 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z57sm6538533qta.62.2019.06.11.08.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:19:33 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
Subject: [PATCH 0/2] Correct the cache line size warning
Date:   Tue, 11 Jun 2019 11:17:29 -0400
Message-Id: <20190611151731.6135-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

If the cache line size is greater than ARCH_DMA_MINALIGN (128),
the warning shows and it's tainted as TAINT_CPU_OUT_OF_SPEC.

However, it's not good about two points.
First, as discussed in the thread [1], the cpu cache line size will be
problem only on non-coherent devices.
Then, it should not be tainted as TAINT_CPU_OUT_OF_SPEC because
according to the specification of CTR_EL0.CWG, the maximum cache
writeback granule is 2048 byte (CWG == 0b1001).

This patch series try to:

- Show the warning only if the device is non-coherent device and
  ARCH_DMA_MINALIGN is smaller than the cpu cache size.

- Show the warning and taints as TAINT_CPU_OUT_OF_SPEC if the cache line
  size is greater than the maximum.

[1] https://lore.kernel.org/linux-arm-kernel/20180514145703.celnlobzn3uh5tc2@localhost/

Masayoshi Mizuma (2):
  arm64/mm: check cpu cache line size with non-coherent device
  arm64/mm: show TAINT_CPU_OUT_OF_SPEC warning if the cache size is over
    the spec.

 arch/arm64/include/asm/cache.h | 2 ++
 arch/arm64/mm/dma-mapping.c    | 9 +++++----
 arch/arm64/mm/init.c           | 5 +++++
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.20.1

