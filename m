Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB34BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9941A24672
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pzuQ36fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfLQAbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:31:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46119 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfLQAbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:31:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so4645472pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 16:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WSuwwYIVFUsjY7TS++RdcJdZuzp4+uR38u5yiZR0+uA=;
        b=pzuQ36fylxKrCIkJKdqN8movucWUzwoSOb3tudW2cHu8/4aFYzDQo8Oz1c8JcxN/In
         0PB1to5e5OIHrkBbcIldpGY4HdcESInV4uhALiuWHN+CDyH0CgsdS76BoXqvP/vD1e1q
         /TDuOOMuUlPWyFKny6/RLI/aX/As13Ycxijm72/JO1eofaS5KVDiAUnOllzmATDp42SE
         +F7pPB0+fPCV8CfcuDhdi05RSKhEWdvjCdvFnsaJqC0v0QCenB+utLL7RNjdS77BVnja
         crZ155pMNcjK/buMed0MxSf8v2l1H3daPYB+RgCy+tncBhqLcLOb3yX2zDBLqgnbvdGl
         QFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WSuwwYIVFUsjY7TS++RdcJdZuzp4+uR38u5yiZR0+uA=;
        b=gP3u+MwXcsWNffytOFRkkkNZ8r1X+qRhH2XmrAO4eoJ2DP/tLU2vLpck3vOsBO5vyP
         k51d3tN5k5m8JHCcHdk2yls69QLLeEIWJHEqrlObSTVthP15IGu02C1Vz1alvaNcR267
         PEQK+S5e4n9SpHNjdPCf1JUZMOs3AcxEJXRLP13/YKOcjnxSj+OEA4fZErt9dzWJwnrC
         gaOxlTFtdE2sK6E3tfJD2TRr2qGwzmj7xmBcxSMOcc6csjjFKMclCxW5Tn1WJFmbUSsa
         8hZ4IxaMd508bb4uMTZ4le7uSPR/tvQnDBP09kxMuZGTKjq7o6B1VOV47TH+/vjdf+wG
         lWbA==
X-Gm-Message-State: APjAAAUW2Pd1pskaUVJ3Uf7srur3OS2Qgxmbs9KldQsB7SyUE1ByamHD
        mRwTXWEBGXpNn3FBUBDxeHtu7THV7u41U31K
X-Google-Smtp-Source: APXvYqzC+hbsFEokWS5VHXNRrZx29+QKBmic6aWP/F1soS5H6PGZYbgptLUiZUzB0PITqbhhajGUTQ==
X-Received: by 2002:aa7:86c5:: with SMTP id h5mr18989496pfo.259.1576542670651;
        Mon, 16 Dec 2019 16:31:10 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a19sm23813873pfn.50.2019.12.16.16.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 16:31:09 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] riscv: export __lshrti3
Date:   Mon, 16 Dec 2019 16:30:57 -0800
Message-Id: <20191217003057.39300-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 exports it already, and recently it started showing up as needed
with allmodconfig.

To keep things building as expected, let's export on riscv as well.

Signed-off-by: Olof Johansson <olof@lixom.net>
---

It'd be nice to see this go in through 5.5-rc, since the breakage showed
up this merge window. It was triggered by ce5c31db3645 ("lib/ubsan:
don't serialize UBSAN report"), but I think that was just coincidental.

 arch/riscv/lib/tishift.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/lib/tishift.S b/arch/riscv/lib/tishift.S
index 15f9d54c7db63..8ecb7db331cfe 100644
--- a/arch/riscv/lib/tishift.S
+++ b/arch/riscv/lib/tishift.S
@@ -35,3 +35,4 @@ ENTRY(__lshrti3)
 	addi	sp,sp,16
 	ret
 ENDPROC(__lshrti3)
+EXPORT_SYMBOL(__lshrti3)
-- 
2.11.0

