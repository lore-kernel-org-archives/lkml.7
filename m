Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F47C46460
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8C32785C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h7gLVYnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFBIBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 04:01:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41736 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfFBIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:01:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so9186695wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lVmMBuEiI1TSAqk1FfU1U7RUZqQknARWWYl0UzTN3/Y=;
        b=h7gLVYnLm/kUsn4wK95+sL2SBMrx+hS39lImfxCL7a5t3aAgMWd/a5XIETxd2AlQcO
         KjWBs8hXvdmlhMKUwemrMqwjSbptuo/FwJsVn09PULAuqWbhDtTFC4RtyFsFvjOLUaAs
         oZIIsIIgJW9vPhHR9F69zppcNkeFPjZdgv0WtYca/KsgRmscfX4rAAPsg9cWt9sNrFnK
         +r6dTHRhy81CsFlU6DIF0DVPKi88seXGMQbPQNkYytiUxY5ga3p4tZw3rdC0sO3n7jNG
         xB/Ra0o8YipjZ16UApgRWEDcRWUWQaZ/sYlL/205G37BtlzqS9sgCoA3jnxZlY9xRUYe
         IutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lVmMBuEiI1TSAqk1FfU1U7RUZqQknARWWYl0UzTN3/Y=;
        b=FHh1dnJP0hAF5oArviYwbRtz8VQ2L0/b+JfTxkhMzet4XbL0bOYlItCknIo52Pq6Fl
         sHeHeRXgFmZm2nCZwZ6IxvKeZCUlc3Ipx2VqPY6ZV1qLoaf0rTUFbWFr08Dv86wVv8Gv
         n2nlI/B+6XWneFEVg+/gp4ZEljqWLfNyVNiJAkPIDsEFlJjfN5R+0RnhQkGLVW4EbVfT
         rS3POlC732koIkvFOTUIRShWgLvFWcdmFIyHLxJyOLvrEj0Z5+hJay27P81aNy/ro1xp
         ORkL3tFfTLad1FySB8RAon5xy7koB4lXlNHvG12DL7zbO7f+/r/Ls9/mNZs1oUkOCF4S
         XV1A==
X-Gm-Message-State: APjAAAXU+QnyvQZsX0u1/djJ61uqYt3eT1odaz+TJf+Y0bqQMfgHBHHq
        MpWdbqcpm7eoRuMRipQso6Ys9sOY5UI=
X-Google-Smtp-Source: APXvYqyzl0GBenPZ3PBEvpnd3Q3e392pV9ArIPE/Ls+QOYf7FH+9zlK3H9nw68c1OfcLmBth8HdTkw==
X-Received: by 2002:a5d:5348:: with SMTP id t8mr12119924wrv.43.1559462491760;
        Sun, 02 Jun 2019 01:01:31 -0700 (PDT)
Received: from viisi.fritz.box (217-76-161-89.static.highway.a1.net. [217.76.161.89])
        by smtp.gmail.com with ESMTPSA id y133sm4868583wmg.5.2019.06.02.01.01.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 01:01:31 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul@pwsan.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 1/5] arch: riscv: add support for building DTB files from DT source data
Date:   Sun,  2 Jun 2019 01:01:22 -0700
Message-Id: <20190602080126.31075-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602080126.31075-1-paul.walmsley@sifive.com>
References: <20190602080126.31075-1-paul.walmsley@sifive.com>
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

