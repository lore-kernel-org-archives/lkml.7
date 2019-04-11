Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD685C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2A12070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jtBPM0uK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDKI0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:26:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42201 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDKI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:26:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so3156648pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eI+tQazR5An6Y/OSr8wxU+9RbkrTFLTQCf+Sjow2u5c=;
        b=jtBPM0uKIksF0uxyGF7ie4zWZavYx1OXYnKFel0MgH3cgDyorOZqR5H2g21i0LDruB
         LRfSom10ilaADBXGQKIBLI/O4ojx23oDmtVXf5T5Opwb7PZOoBAi8ZqjTTc8RAIKdhsv
         kmHkjSKjGbxhKKSp6mKDL5sEDB9nlZj9s0sL9I8B8yxYwG9AQXZfng1lMgtQ4igJ44E4
         5YUEVTnlbqw1YXpggX2aqTlNKs3DeWJbmt3Yo8PqJhiIAdUXUNqi2J7QwcwvVNg3nXOi
         D+XYf45s4AJu9+4wLXc/Wy9b1+tQiIU/4NzxQH9xJliieBaOnBtTJlrNCzcXudSj4Doo
         hETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eI+tQazR5An6Y/OSr8wxU+9RbkrTFLTQCf+Sjow2u5c=;
        b=GKgyItM50KaEoFcaBGfZ/Z4JBAXJ6BwxTosIC8G1+ZLEOR5Fhr1oohXlRdQrXQDoYa
         4URYcoO5SFi1HQjnmVle64xJyeM+WoJiXbWxnQAXtl/yaHCarGyZWTzLnmWVcBNsSqUz
         sgBjQCE+YpL6tAO4da8RnOC0sZbjCIf8fMeKLG0FT5Xqzxc1x/mifGOT//iMpFFBNZ1Z
         aHzK6KJUPWeWEATSoraEDD1ig4fVrFug1jfqjq73B4nlvyigss3PG8uunGyXQqIA8lcB
         7O1obwfOCMRpHKfAk/FCGgTLfXWDnRHDSX+D6KeOjIWJT1vYGUiGj9tiKKfw59ErG5rY
         5vSw==
X-Gm-Message-State: APjAAAW8v5eXcUpVVYTNHb8eDT6YLuXNR+bAui6x/XHv/CDhhaiMiyIB
        OIRNe83hbMkyKAr9OV4vOZ8LivM0C7o=
X-Google-Smtp-Source: APXvYqy2KN/ugGsiGTtSdgnZH7biVx1GMF+NrYkwSH4fgxSkHOCPM7MZ28Xt8L8KnRjx+ZrR6K4btw==
X-Received: by 2002:aa7:864a:: with SMTP id a10mr48652416pfo.181.1554971207324;
        Thu, 11 Apr 2019 01:26:47 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id k65sm81608225pfb.68.2019.04.11.01.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:26:46 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v3 0/3] clk: add driver for the SiFive FU540 PRCI and PLLs it controls
Date:   Thu, 11 Apr 2019 01:26:16 -0700
Message-Id: <20190411082618.3502-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk: add driver for the SiFive FU540 PRCI and PLLs it controls

Add a driver for the SiFive FU540 PRCI IP block, which handles clock and
some device reset control for the SiFive FU540 chip.  Also add a driver-
independent library for the Analog Bits Wide-Range PLL (WRPLL), used by
the PRCI driver to monitor and control the WRPLL instances on the FU540
chip.

Boot-tested on a SiFive HiFive Unleashed board, using BBL and the
open-source FSBL with a mainline-focused DTB.

This third version incorporates changes requested by Stephen Boyd
<sboyd@kernel.org> and Rob Herring <robh@kernel.org>.

This patch series is also available, along with the DT macro prerequisite
patch, at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/prci-v5.1-rc4


- Paul


Paul Walmsley (3):
  clk: analogbits: add Wide-Range PLL library
  dt-bindings: clk: add documentation for the SiFive PRCI driver
  clk: sifive: add a driver for the SiFive FU540 PRCI IP block

 .../bindings/clock/sifive/fu540-prci.txt      |  46 ++
 MAINTAINERS                                   |   6 +
 drivers/clk/Kconfig                           |   2 +
 drivers/clk/Makefile                          |   2 +
 drivers/clk/analogbits/Kconfig                |   2 +
 drivers/clk/analogbits/Makefile               |   1 +
 drivers/clk/analogbits/wrpll-cln28hpc.c       | 360 ++++++++++
 drivers/clk/sifive/Kconfig                    |  18 +
 drivers/clk/sifive/Makefile                   |   1 +
 drivers/clk/sifive/fu540-prci.c               | 630 ++++++++++++++++++
 include/linux/clk/analogbits-wrpll-cln28hpc.h |  96 +++
 11 files changed, 1164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
 create mode 100644 drivers/clk/analogbits/Kconfig
 create mode 100644 drivers/clk/analogbits/Makefile
 create mode 100644 drivers/clk/analogbits/wrpll-cln28hpc.c
 create mode 100644 drivers/clk/sifive/Kconfig
 create mode 100644 drivers/clk/sifive/Makefile
 create mode 100644 drivers/clk/sifive/fu540-prci.c
 create mode 100644 include/linux/clk/analogbits-wrpll-cln28hpc.h

-- 
2.20.1

