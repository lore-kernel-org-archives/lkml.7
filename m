Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14343C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D912080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F0uIwwoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfD3Uvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:51:32 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39553 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfD3Uvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:51:32 -0400
Received: by mail-it1-f195.google.com with SMTP id t200so7048996itf.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vjQtX5qzbngzO6WItWUMVIwx0kzAkLppgcgbD0Y95uE=;
        b=F0uIwwoWKlnBD0zMndyAUgxMQWgstX0DeGWUgyikUtD+ZL9Ef8bN9f0oJWQaWvbvFw
         85rBa8HLz4CIBild/BejxfpIYzucwPsZm6jNgFcwBaor5feaM/EmRCNpKIO43DZKx8Z9
         RwbJnPR6SrC7LuwVrwXPZRsPeIPcKimDfH7G3OZm6AFNMPjYVAZfbjoaZpBNYC1+/gzW
         FCxn8taXvl4WOtg0aS9EwvN9AhMSCgSmg8Mir1WWq1AuBHTLsb0E9rq95fRSubl/25Gm
         IM3Zq8AI4oezyB5rIGxoW/eLLFOuIs/akYM/TWigLwLLqaIfMEnXr/0NEfNvfYfXwT8I
         GbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vjQtX5qzbngzO6WItWUMVIwx0kzAkLppgcgbD0Y95uE=;
        b=PIjW7aXYSRiZ1HfNyaF6Me0hSsZpYWI0I6F1+ZTBRMaS4vcPyUTfFPwy+umXZxc86R
         Kt3d82+RkKEFY+FxJ0uR0/um3z/kf3neW4H0LJFirakXvFaM2ph29aG+1we49jkurrUT
         W3jRJfYMH9lkhzNeTK8ioVC+AIb6Ex6yl6dxZeRdm6Aryqj7tuV6Xr7d9Q7/c9VqsL5g
         Ip30GZBe7KnNum9RnG4Zv6ND8r6bal7HkGhxbWVv4Tqe4GNv6NyZGk5PqykH+dD/GGKc
         K5P5EEHE8SV187z2Sg4vpCjR1Q+56oSt9pcKAaqs+4ON+JQtVWYBxFRp+ALIBuCTUZCH
         eRZQ==
X-Gm-Message-State: APjAAAXia1eljKXxymlo5bdYCbUI7FV7ji+7zpTmpObrou0wW3iqao4k
        LOekVCpfLyk7DiNzzErUDJBaZA==
X-Google-Smtp-Source: APXvYqx8LPqX8+1jPVWOhnE83hohCgwnay3/bNio9Sr2ZTQMCvXG1lYnXsfpJOWygz06tzC47v2Dug==
X-Received: by 2002:a24:7688:: with SMTP id z130mr5167604itb.57.1556657490516;
        Tue, 30 Apr 2019 13:51:30 -0700 (PDT)
Received: from viisi.lan (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id v134sm1998052ita.16.2019.04.30.13.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:51:29 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v4 0/2] clk: add driver for the SiFive FU540 PRCI and PLLs it controls
Date:   Tue, 30 Apr 2019 13:50:55 -0700
Message-Id: <20190430205055.25673-1-paul.walmsley@sifive.com>
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

This fourth version incorporates changes requested by Stephen Boyd
<sboyd@kernel.org>.  The DT bindings patch has been dropped since
Stephen has already queued it.

This patch series is also available, with the binding documentation
patch, at:

   https://github.com/sifive/riscv-linux/tree/dev/paulw/prci-v5.1-rc7

Boot-tested on a SiFive HiFive Unleashed board, using BBL and the
open-source FSBL with a mainline-focused DTB, using the following
composite test branch:

   https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.1-rc7-experimental


- Paul

Paul Walmsley (2):
  clk: analogbits: add Wide-Range PLL library
  clk: sifive: add a driver for the SiFive FU540 PRCI IP block

 MAINTAINERS                                   |   6 +
 drivers/clk/Kconfig                           |   3 +
 drivers/clk/Makefile                          |   2 +
 drivers/clk/analogbits/Kconfig                |   2 +
 drivers/clk/analogbits/Makefile               |   3 +
 drivers/clk/analogbits/wrpll-cln28hpc.c       | 364 ++++++++++
 drivers/clk/sifive/Kconfig                    |  18 +
 drivers/clk/sifive/Makefile                   |   1 +
 drivers/clk/sifive/fu540-prci.c               | 630 ++++++++++++++++++
 include/linux/clk/analogbits-wrpll-cln28hpc.h |  79 +++
 10 files changed, 1108 insertions(+)
 create mode 100644 drivers/clk/analogbits/Kconfig
 create mode 100644 drivers/clk/analogbits/Makefile
 create mode 100644 drivers/clk/analogbits/wrpll-cln28hpc.c
 create mode 100644 drivers/clk/sifive/Kconfig
 create mode 100644 drivers/clk/sifive/Makefile
 create mode 100644 drivers/clk/sifive/fu540-prci.c
 create mode 100644 include/linux/clk/analogbits-wrpll-cln28hpc.h

-- 
2.20.1

