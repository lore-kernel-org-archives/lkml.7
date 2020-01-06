Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BA1C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4724020731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="h5aYFg1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgAFXQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:16:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41764 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgAFXQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:16:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so27545526pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 15:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrkNrlsI6gf+UgcIdoDUEX3iqa/Oz0F6ZIOtZxRpg7U=;
        b=h5aYFg1LHy7RecocWz2pJ8zPdAcz/Zlxf0A90TagTHHfzfgiLT7dDpHo3qzZKG5T7h
         x6bJ+8DtVgwqQG8oyrM0gdwnUJLKdJybBqYaDsW7IsaXO6CsqpcneYkkRi011gVD/Zsz
         9t98bw6eht+s2PTB+3QTmsmDwt8fnshoyGsbUiAghLSWmK0QERKfo7CkKuU6f4XN8JtR
         qN5hg/lchx9eiPOk924DnTRLTxXolWcdAnCmvRJVRpJQCtctjshI1OIAiZukYPFvHeVX
         8r7YjAUrMbKcFgIX4is99Zkb3FsrbRVEKe0fdyj3WsJ5BnfoEy7Dtb+atpT1zhk6ERzt
         0lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrkNrlsI6gf+UgcIdoDUEX3iqa/Oz0F6ZIOtZxRpg7U=;
        b=PxhpFgqOXud7hzlMacL0fPoIuTPrycC97SlM+tJWrDyWgprWFvWKoA6UDzcI/cfG0p
         MbI/RzOAis/xJHSCa7sN2x6pWjL/rtffFx+wK+76YQZfFFuUcWoO43zZizJhtgC8FYQA
         vfHqUxUvTfYsv02H7okCKViAX/Zp/HJqYetCr8lIw5/CCih+5hCuaV6sLvRHEcXikJVg
         n7DiaVcRiseyp1WSTHD87fCmrLFocD6VVMS7s7Z+SHt336gV3ZdANIK/3V8/TENKy/Nl
         O9Dk+W39sAb6wyHDucucHoBPBpAQZgIjtL4+6t+eghgI14teWlyG+wQj76vJGWF106mH
         NVUA==
X-Gm-Message-State: APjAAAUTz1WIVDhxNAilJWBjtuZwpYmiTXksrEcdYZLIedzOViLD4kVi
        ENE9m0M+MD1dJkM7t4FRfbcP4g==
X-Google-Smtp-Source: APXvYqziUHnuk5l/Atiw2vj5n2Wz6sjwDTja/WaJs0V1Vh/2LG/VjEj5/h6HlAXT+QuTPWrIOVMPDQ==
X-Received: by 2002:a63:4c4f:: with SMTP id m15mr112630946pgl.346.1578352579414;
        Mon, 06 Jan 2020 15:16:19 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id s131sm65052995pfs.135.2020.01.06.15.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 15:16:18 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] riscv: keep 32-bit kernel to 32-bit phys_addr_t
Date:   Mon,  6 Jan 2020 15:16:11 -0800
Message-Id: <20200106231611.10169-1-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While rv32 technically has 34-bit physical addresses, no current
platforms use it and it's likely to shake out driver bugs.

Let's keep 64-bit phys_addr_t off on 32-bit builds until one shows up,
since other work will be needed to make such a system useful anyway.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a31169b02ec06..33a20fa046e0a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,8 +12,9 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	# even on 32-bit, physical (and DMA) addresses are > 32-bits
-	select PHYS_ADDR_T_64BIT
+	# While RV32 has 34-bit physical addresses, no known platform
+	# uses it, so keep it to 32-bit until one shows up to test with.
+	select PHYS_ADDR_T_64BIT if 64BIT
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
-- 
2.20.1

