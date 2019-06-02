Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1C8C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144CA27887
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N0+66sds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFBIFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 04:05:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38380 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfFBIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:05:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so9200802wrs.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lVmMBuEiI1TSAqk1FfU1U7RUZqQknARWWYl0UzTN3/Y=;
        b=N0+66sdsXoQBYe50js1Hd52DvXCm4tFQava67j46KPwocptMhSkacRnEsrzP08Sv6M
         ZO4VUhIwToGBw8eN/1xJi368/FFSszJMbNCn5PezA6EG+vz8FUys0h/WIhvgZ6Sb7dJX
         arodLadOwkTr6yi8k0komr+0GlJYEFNAfKRXeHBIKNSGA+FWbi9Lg3jhdhV4LvCF6gA+
         pX0CT4cSJOtDf3SNJj3EVTLwumDy3eb6KNuOjL2UKl6p66l8keQ9xiKBwQdgj529JNXM
         PUwHCxI9d13KHE5/iJxSHMTnVwJ1alpsZRWvIyrqmjXXUliRLsyle0kZsAGfffvmBszF
         s/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lVmMBuEiI1TSAqk1FfU1U7RUZqQknARWWYl0UzTN3/Y=;
        b=EoYUTfXqn6GhnRn2hLKpQ2kBLfO5iAq5AHwz9h64oMVwv7LIMqNSY1oLShLpANb2PP
         iFFYLzCeuv13qRKB/9NVxZnYxjy48C+C+WvKz9utMrUH/OVeaubOwFrVnYK7ZOmitR7v
         dVWSXL5mnuLQ+GFGfhcF6PwMgaifpljRuKc6L7OiSP+LmWL7o5/CVnD3+Mj6k8G08GZ8
         lj+YLnflRwD6TDbtb2gAhhMUforxHe+7w0E5IUOXQc+LjI12J3z2iFTiktSmRBj1ZxtG
         xMaiX3NezcpGUb6xpHW3Io/uAFeyOnWAlGaEHVWoZ77Xt88F+UoWFue85nrTqc2B3dzx
         Eg9Q==
X-Gm-Message-State: APjAAAXTwJaWxxXzEgNeGrPRDRq/YbznfngCObPNbyZxlUibLTzWcsiG
        q0gR/LseSLdSyNc71iOZTZNHYYyPVwc=
X-Google-Smtp-Source: APXvYqwLy0yWkg8fh1zyhbcW1Qh35LNKhxDQz/zoicwalKTyGXTF96bXuh+t5ibVzUNKdpqPOru/Jg==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr1040541wrn.147.1559462704760;
        Sun, 02 Jun 2019 01:05:04 -0700 (PDT)
Received: from viisi.fritz.box (217-76-161-89.static.highway.a1.net. [217.76.161.89])
        by smtp.gmail.com with ESMTPSA id l190sm10186301wml.16.2019.06.02.01.05.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 01:05:04 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul@pwsan.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v3 1/5] arch: riscv: add support for building DTB files from DT source data
Date:   Sun,  2 Jun 2019 01:04:56 -0700
Message-Id: <20190602080500.31700-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602080500.31700-1-paul.walmsley@sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to ARM64, add support for building DTB files from DT source
data for RISC-V boards.

This patch starts with the infrastructure needed for SiFive boards.
Boards from other vendors would add support here in a similar form.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
---
 arch/riscv/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/riscv/boot/dts/Makefile

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
new file mode 100644
index 000000000000..dcc3ada78455
--- /dev/null
+++ b/arch/riscv/boot/dts/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+subdir-y += sifive
-- 
2.20.1

