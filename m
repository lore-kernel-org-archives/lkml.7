Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4251D2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="w24mVjvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfLQEHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:07:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36896 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQEHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:07:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so4907610pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 20:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/EeyVzDVQ/EXYLvR3izxdw4IrryrAjrJet7kKduLXL8=;
        b=w24mVjvHWS6xhPLizVIqdxluN56TOLjTe/dmRGHizGmJE1dJIi/SoIIp6crqLUCvDv
         RICPDQNNbi4T//ksVi2aE5X5XqWj1XzLXbSTxd7/XfxSXJMKTqBT7qgfOymP+yIZQEns
         X7/xSX9Zi3jgkO4ol08jz/owD79u5IzNCDyMbbyspy3chicGbLp45qG2wjQiphmv/Fm5
         7VofOExbYlW5SRXR6pEvw7dlRmy3kXq1p0Iidx3fnbtBU7DivpaD6KFcyFByK1Tw374Z
         yfa08geILbcjaiztnpNJwUxh3vET834kRuI3jn5tSGq7EsFCOBp43iGmkowt2tGfBNSa
         AB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/EeyVzDVQ/EXYLvR3izxdw4IrryrAjrJet7kKduLXL8=;
        b=B8xEUgrr3KGMElJe3sZeYJEblME1ci7fNYY7MfGb1LUrdhGRbAafU/NAMxzWOs6PQT
         nuWnvK8TeT0SaaNsFTc/uvptRdbys+zL31iyPrljkm7lAh27yNc23aL9yuCyQ7QqBqP6
         ACBSiInHa1trGW3syolHxNYOe3iRmKXIGkZws4zBvVpRks3i1FC89kgvxqoSZt7ITz0K
         fIQcj99ReyoU7dZFrNNlAMATPvEFI4Co9CYEXJVNaPbVnSdrW8Cv0xJkg9CRQWrRM3n7
         EMYJkAqrfEtZpyEkeMmPuG66iD8OZbvxcq4tiDXOD2BCDQrpdUlsOuXPiHrXwAe6bEA5
         wtxQ==
X-Gm-Message-State: APjAAAWNiwWwmML5JHDICfOELtcVyYyhYxyfG8FWFUuZ9MVqEC+VKOmx
        bRwtGWNEU+Skc5Gf3ekzsJy36g==
X-Google-Smtp-Source: APXvYqxFBXZL0vNbgrX4e1e3py+mq6yo/2cpBe4nLVuK/VzX+a8+XIqlGiJ8aBFa2A1hNqvdkeLCyw==
X-Received: by 2002:a65:4142:: with SMTP id x2mr5763326pgp.393.1576555630925;
        Mon, 16 Dec 2019 20:07:10 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id e11sm1032340pjj.26.2019.12.16.20.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 20:07:09 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] riscv: export flush_icache_all to modules
Date:   Mon, 16 Dec 2019 20:07:04 -0800
Message-Id: <20191217040704.91995-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed by LKDTM (crash dump test module), it calls
flush_icache_range(), which on RISC-V turns into flush_icache_all(). On
other architectures, the actual implementation is exported, so follow
that precedence and export it here too.

Fixes build of CONFIG_LKDTM that fails with:
ERROR: "flush_icache_all" [drivers/misc/lkdtm/lkdtm.ko] undefined!

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/mm/cacheflush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 8f19006866405..8930ab7278e6d 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -22,6 +22,7 @@ void flush_icache_all(void)
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
 }
+EXPORT_SYMBOL(flush_icache_all);
 
 /*
  * Performs an icache flush for the given MM context.  RISC-V has no direct
-- 
2.11.0

