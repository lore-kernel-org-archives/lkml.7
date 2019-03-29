Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B7DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14C62082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xCGJM6Wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfC2H3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:29:51 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:64988 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfC2H3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:29:41 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x2T7SQa7002537;
        Fri, 29 Mar 2019 16:28:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x2T7SQa7002537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553844507;
        bh=ukTnO9IMqmEzjeKRCA0eRgyV1YFCQFAKScpWn4HMm/k=;
        h=From:To:Cc:Subject:Date:From;
        b=xCGJM6Wrmn+S0Cnc7l33nKlJjUsg9VnSH9IT/+Pwn7e/ghnuD2V8GtVONOxlggu0/
         N2OBL0tZZQnqqt37tSCJOiqvq1nLMorQ7uj8tUPEYnYv6+3t3wtmKAallcb7pjHTh/
         rLNPBsIsDO4EsN6k4NdhYxArz5AuQalNpDL7GSTMgWtUto8pGon/ATDGtFaReDGY5e
         mmNJ4sLJ9Nzl8gq1533YGdffQYz7oXQz0x0krlh/EJekDC32mNBVTrN2T01uHZLY/h
         7F/E9WEknpX4tqi438e4Mw0jk5bgLLvQZY3PM6N2CNkk+gTsDmQHQ1S4UFUHyF/Jvv
         8a/C8bK8aMYHw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/9] mtd: rawnand: denali: exec_op(), controller/chip separation, and cleanups
Date:   Fri, 29 Mar 2019 16:28:12 +0900
Message-Id: <1553844501-7119-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I took time for the Denali driver to catch up with the latest framework.

 - switch over to exec_op() and remove legacy hooks

 - separate controller/chips

 - various cleanups

Major changes in v4:
  - Add denali_exec_out() and denali_exec_in()
    in order to make denali_exec_instr() readable

  - Make .read_page_raw() and .write_page_raw() even simpler
    by giving up the performance

Major changes in v3:
  - Drop "mtd: rawnand: denali: use more precise timeout for NAND_OP_WAITRDT_INSTR"
    entirely according to the review comments in v2

  - Add comments to helpers in 2/9

Masahiro Yamada (9):
  mtd: rawnand: denali: use nand_chip pointer more for internal
    functions
  mtd: rawnand: denali: refactor raw page accessors
  mtd: rawnand: denali: remove unneeded casts in denali_{read,write}_pio
  mtd: rawnand: denali: switch over to ->exec_op() from legacy hooks
  mtd: rawnand: denali: use bool type instead of int where appropriate
  mtd: rawnand: denali_pci: rename goto labels
  mtd: rawnand: denali: decouple controller and NAND chips
  mtd: rawnand: denali: remove DENALI_NR_BANKS macro
  mtd: rawnand: denali: clean up coding style

 .../devicetree/bindings/mtd/denali-nand.txt        |   40 +-
 drivers/mtd/nand/raw/denali.c                      | 1146 ++++++++++----------
 drivers/mtd/nand/raw/denali.h                      |  117 +-
 drivers/mtd/nand/raw/denali_dt.c                   |   98 +-
 drivers/mtd/nand/raw/denali_pci.c                  |   38 +-
 5 files changed, 823 insertions(+), 616 deletions(-)

-- 
2.7.4

