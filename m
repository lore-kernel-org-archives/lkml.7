Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5467C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B00206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="A58mg5Kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFERup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:50:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46992 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFERup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:50:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so15239002pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BKkTOGYV6rc7HowFTZvE8K9UA+VQIzhyINAMJ9kdHbs=;
        b=A58mg5KvGYwm+JBY3RSS+1AD82Y6/IErsmfVz+hwmDnRrfIcKyTkZXJ+n5GC4KOSxx
         58ShR5prsog+E6KZmvxbfUojKwQCR9kzcfcZDj110/L2LQSbzSWQcYsqK92VDr0TasCY
         sN/YvM9py6T9rgBWWfRWDBDxoULa3vUO7HgSLBD9p+QxvlG903CtNAe2wI4TuqFff0w3
         UBBKzgvjjXxVlFAmnwUw4OYrddRtTxSLhBaQEdxH0jipTizDEJJOx2xqSYN7U8pQY/6X
         3bY6psXdI6sEZl3yCKIExSP2me3Ym9b+R1hiyh8ghrAOuy7i9DrGYdp/BljCRUL5jGqG
         RssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BKkTOGYV6rc7HowFTZvE8K9UA+VQIzhyINAMJ9kdHbs=;
        b=VSSKHoH5mRlNlkK78XVlbxevzAJq0VKp5jOlW4hJ1Lp8kWtE4xkQfv/jUqnfxvasxE
         VI2zmYYo2dexkivLdVY91+0ut/TDB3AuS+5iA+dP+i1GShbf3Avh6zVuALt8IER9TfVp
         8dcTm8Lcs7eXoAGWxxwnRMzEWZoYLWs5FsLfU5mNFNcgw2llfoAisASduyYpsqk+hsX0
         HhaiPPOCL6ehKnfLld29BCRAHTgpXfV3p4QWXtyvm50WNisetsZdxipH34xPVbCyGHdk
         Z3T7Zb1VCLoBd9PZ2OEfBWwBhVVOxmCgMQOo8Cp6IVT2mOOQMgBBXKAl4xP0Sd+L8XRp
         e8UQ==
X-Gm-Message-State: APjAAAU7JM6jvwdw/N6ZdQX5kXnSSGgzeeDJMiXiwkCKIPPPEf/FD5pD
        prw0G3pJSuWmjRVl56gj+02xfQ==
X-Google-Smtp-Source: APXvYqzGIXQYJbJ/EW9Im5FYNNE63sdg510YUZvGCK/jMI7JQvTrBWq/YpqXuCCeNqPGEqB/0tbO6g==
X-Received: by 2002:a65:5004:: with SMTP id f4mr6334708pgo.268.1559757044629;
        Wed, 05 Jun 2019 10:50:44 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:da9d:67ff:fec6:ee6b])
        by smtp.gmail.com with ESMTPSA id d7sm12013736pfq.0.2019.06.05.10.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 10:50:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Loys Ollivier <lollivier@baylibre.com>
Subject: [PATCH] RISC-V: defconfig: enable clocks, serial console
Date:   Wed,  5 Jun 2019 10:50:42 -0700
Message-Id: <20190605175042.13719-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PRCI clock driver and serial console by default, so the default
upstream defconfig is bootable to a serial console.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/riscv/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2fd3461e50ab..4f02967e55de 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -49,6 +49,8 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
+CONFIG_SERIAL_SIFIVE=y
+CONFIG_SERIAL_SIFIVE_CONSOLE=y
 CONFIG_HVC_RISCV_SBI=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=y
@@ -64,6 +66,8 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_CLK_SIFIVE=y
+CONFIG_CLK_SIFIVE_FU540_PRCI=y
 CONFIG_SIFIVE_PLIC=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.21.0

