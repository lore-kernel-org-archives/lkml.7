Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA060C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F7221955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vtmz0dcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfGVF5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:57:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42364 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfGVF5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:57:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id v15so39502143eds.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 22:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=YjD84EknKXQ6SgafyIu2355vAswN4w676+lk0Qqv20w=;
        b=Vtmz0dccwTEmYrWEaLHmXaA0xZa5NsQc4ICmHUu07h/zUD3nZEeoulj9M+xVcbGQ66
         c/oyQ/sxDjBhXhb+b2ArlMLkCsMVmIr0BrA6MgR8q0YHmc0ZAbDUrS1ba+iayyPKjvCf
         8nJOq6ckjDdO8BMlrK0jtlqrAqakxImk/9yRA2LYrr3g8AH+uREfF4Cg68x0AwlEa/IZ
         HlUrtbRx3DyBgnoSfeUKSqk1NjWrghk2nLoxshTyPpA0MsThfds+hCg0wInCpi4ypagq
         sG6lgk2n/WQlEqjDg6+ww+tHdWtT+cYyytoPJFsex3hCq2yN2NnYxWZf+wZPrNrRSm/Z
         Cx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=YjD84EknKXQ6SgafyIu2355vAswN4w676+lk0Qqv20w=;
        b=mFqXk4mewqQj/CkVv1h4l/yNjxMiPRBATTCsDXYBFhGluXTocUjK4cFdtQ5WsNqq00
         4didYP7oDAzw4NIUwr5H4gXejrkWc525unhnhmxMtbTxS9v1Yf7RE/bDSGtrQFBtA5Yl
         Ys9Mb8A+WzdlhenNmyhypANeHARGCO4y7p47EkqWG+K6rOBrq/0Zmx87kvNIfUUhabcW
         T7ufBlSt00iWDVKhyQT0Ok/jlmIZ7bbBIVFRx7RKzHQinAheOYABB090MrhYLX0pZqF1
         eN8aWXGFmjPQtA4HTViUKq8x5dT24tSVqsH1IRo24zn0FW+WVzVa9gRCLFRz+U0N48Kv
         1wRQ==
X-Gm-Message-State: APjAAAXP5yYGwM8PuIih6WrISuuTxAw6W9h7Wfb8e3IJu9MwwLatKRm8
        TcF+CyAzQX5Hc+kwLMIQPlU=
X-Google-Smtp-Source: APXvYqwp4Gr3RVhVqlHGhWlojDSuIhtbZE9YVWD5TdSXLWfNomULLmP6NU19lsjMYRlqunLmSuQarA==
X-Received: by 2002:a50:e718:: with SMTP id a24mr57886735edn.91.1563775019154;
        Sun, 21 Jul 2019 22:56:59 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id a6sm10351725eds.19.2019.07.21.22.56.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 22:56:58 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [PATCH 0/8] Introduce generic ONFI support
Date:   Mon, 22 Jul 2019 07:56:13 +0200
Message-Id: <20190722055621.23526-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Current support to ONFI parameter page is only for raw NAND, this patch
series turn ONFI support into generic. So that, other NAND devices like
SPI NAND can use this.

The series has five parts.
1. Prepare for tunrning ONFI into generic
2. Turn ONFI into generic
3. Turn SPI NAND core to use parameter page
4. Redesign Micron SPI NAND driver implementation
5. Support for new Micron SPI NAND devices

Changes in V4
-------------
* Turn ONFI support into generic.
  Re-designed as per the Boris's comment.
  Common functions are moved to nand/onfi.c.
  Function to prase ONFI table is defined in nand/onfi.c
* Enable parameter page support in SPI NAND core.
  Re-designed as per changes in ONFI generic support.
  Function defined to read parameter page.
  Function defined to detect parameter page.

Changes in V3
-------------

* Split the patches as per suggestion
* Addressed the comments
* Some fixes which I missed in last version

Shivamurthy Shastri (8):
  mtd: nand: move ONFI related functions to onfi.h
  mtd: nand: move support functions for ONFI to nand/onfi.c
  mtd: nand: create ONFI table parsing instance
  mtd: spinand: enabled parameter page support
  mtd: spinand: micron: prepare for generalizing driver
  mtd: spinand: micron: Turn driver implementation generic
  mtd: spinand: micron: Fix read failure in Micron M70A flashes
  mtd: spinand: micron: Enable micron flashes with multi-die

 drivers/mtd/nand/Makefile        |   2 +-
 drivers/mtd/nand/onfi.c          | 121 +++++++++++++++++++++++++++
 drivers/mtd/nand/raw/internals.h |   1 -
 drivers/mtd/nand/raw/nand_base.c |  18 ----
 drivers/mtd/nand/raw/nand_onfi.c |  65 +--------------
 drivers/mtd/nand/spi/core.c      | 136 ++++++++++++++++++++++++++++++-
 drivers/mtd/nand/spi/micron.c    | 107 +++++++++++++++++-------
 include/linux/mtd/onfi.h         |  11 +++
 include/linux/mtd/spinand.h      |   7 ++
 9 files changed, 356 insertions(+), 112 deletions(-)
 create mode 100644 drivers/mtd/nand/onfi.c

-- 
2.17.1

