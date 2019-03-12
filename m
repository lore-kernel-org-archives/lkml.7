Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F675C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D195214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SqjhzdHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfCLIrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:47:23 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:37397 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfCLIqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:46:40 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x2C8j6Za004092;
        Tue, 12 Mar 2019 17:45:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x2C8j6Za004092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552380308;
        bh=C9gZXtfmd5qJIYI6eWiFiUbhuKniUjG4z7pUr+Zd8L8=;
        h=From:To:Cc:Subject:Date:From;
        b=SqjhzdHEvESIJ4zgNhoCQyTKXNABVfIVIrwvcbiqeaOFQIs+onEwInRZXd+4Sq0vC
         u91GiExfxkUEYLBgTUNEYzkvuj7d9b4gxwAYAjBwD9TBJkbpQfflysgGgsUnxqcxx0
         JYyUw/G5jZ3xQfWaBk/r3O4OW7C7QFsNPOwF5HUra6uPjdHzOVnQwBvk5P3pNHL+57
         eh+i0rW7Wr2Qr/GZpl3/paLcYt+PzkD8L0mT9VxSEGzqehXRC1d70cVUe0cCBeFLUS
         EOzfoJ07Hz9UhinNzMwcXZn69xNpVNHm37B2VixdGHzvL/drZvoqth0LdXIxDrURlf
         H6d/Suw3NR7vA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/9] mtd: rawnand: denali: exec_op(), controller/chip separation, and cleanups
Date:   Tue, 12 Mar 2019 17:44:41 +0900
Message-Id: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I took time for the Denali driver to catch up with the latest framework.

 - switch over to exec_op() and remove legacy hooks

 - separate controller/chips

 - various cleanups

Major changes in v3:
  - Drop "mtd: rawnand: denali: use more precise timeout for NAND_OP_WAITRDT_INSTR"
    entirely according to the review comments in v2

  - Add comments to helpers in 2/9



Masahiro Yamada (9):
  mtd: rawnand: denali: use nand_chip pointer more for internal
    functions
  mtd: rawnand: denali: refactor syndrome layout handling for raw access
  mtd: rawnand: denali: remove unneeded casts in denali_{read,write}_pio
  mtd: rawnand: denali: switch over to ->exec_op() from legacy hooks
  mtd: rawnand: denali: use bool type instead of int where appropriate
  mtd: rawnand: denali_pci: rename goto labels
  mtd: rawnand: denali: decouple controller and NAND chips
  mtd: rawnand: denali: remove DENALI_NR_BANKS macro
  mtd: rawnand: denali: clean up coding style

 .../devicetree/bindings/mtd/denali-nand.txt        |   39 +-
 drivers/mtd/nand/raw/denali.c                      | 1141 +++++++++++---------
 drivers/mtd/nand/raw/denali.h                      |  119 +-
 drivers/mtd/nand/raw/denali_dt.c                   |   98 +-
 drivers/mtd/nand/raw/denali_pci.c                  |   38 +-
 5 files changed, 852 insertions(+), 583 deletions(-)

-- 
2.7.4

