Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A3C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B729D20828
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="czEV6VfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfFBIDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 04:03:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40177 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfFBIC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:02:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id u16so3142953wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lVmMBuEiI1TSAqk1FfU1U7RUZqQknARWWYl0UzTN3/Y=;
        b=czEV6VfJGHSdQrrv7KfOsGVl0G73ngWzwio3YKfOAcumfIM9TrV/w4Z7BC7b8o6mF/
         GewBgTlEEmUNOHIMMOhCJBAbL6rONe/U4BY7S1Y2ictwYrJeZ4iozJLwqqdDA5aI2li9
         krAhN5NgTTXufkDh5VOLGZOSqkhUgCBL5yixxmhL2OEc8ml2fD19C+Bf88n65vy1ZkmY
         qD4jv5We3XUwTJlXTVyNGzZqAsQXMmTkhInBAKEuYkjv1d8r+0+0uKG26Q6CqpysV2Cd
         2+OiwNORhGauyvRBrw58tYvb3o9Cm71w8TaLhMnaWKhmqgYaDimAcGFb43XvNb53hKVK
         Gwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lVmMBuEiI1TSAqk1FfU1U7RUZqQknARWWYl0UzTN3/Y=;
        b=cvWU08EcWTvtdD8TJcE371iWYZsuyzDoq8eYUCYtBx/lgGkqrKQsAeEyFW5tJzCurY
         +P0DIH/IyACdDAdKeUwhHGIz9NwlGv8yskkJtISjmtqxBYL9Alx1v4iC1u6zP1Q4kN7E
         WA/kmNn9wgeP+ZNhMOXrgGsHF01XQ7SxiPX/cA9uyoFke/kviqFzC0KWY6Ee25h/gudg
         PkEaPbMgwtKuYHwD8qlpFR58FK8ZmPWuwJ7Mi5TULOaruIg46JVAucRY0StKD7hsT/ms
         XjU82ePed3iNfWVGpmfjgA1XFn5qep6KA8fGy/BrYQvRjNTFjy5Ho2PtLHZbfURrADvx
         QlNA==
X-Gm-Message-State: APjAAAU9Ct/H9aQuwe2WwTWODkQSr01PkzanYoFRYyg9qo3zzXmiZjWs
        +3MVDVRGuOXQxC/FF8AnQt/KX8WPjUw=
X-Google-Smtp-Source: APXvYqyqRK0MO1SgJM+vCDNFXLFtqxjAsoNIptEUPqNrNKCiXiOIpOuGAH27qr3kIa093dNVUbbOdw==
X-Received: by 2002:a1c:5546:: with SMTP id j67mr10910514wmb.80.1559462576132;
        Sun, 02 Jun 2019 01:02:56 -0700 (PDT)
Received: from viisi.fritz.box (217-76-161-89.static.highway.a1.net. [217.76.161.89])
        by smtp.gmail.com with ESMTPSA id t6sm22208264wmt.34.2019.06.02.01.02.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 01:02:55 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul@pwsan.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 1/5] arch: riscv: add support for building DTB files from DT source data
Date:   Sun,  2 Jun 2019 01:02:47 -0700
Message-Id: <20190602080251.31372-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602080251.31372-1-paul.walmsley@sifive.com>
References: <20190602080251.31372-1-paul.walmsley@sifive.com>
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

