Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E785C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A80220857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fYYEorSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfDBEEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:04:35 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:18457 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfDBEEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:04:32 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x3243HaT021871;
        Tue, 2 Apr 2019 13:03:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3243HaT021871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554177798;
        bh=4H9MGJSlbEpklZkslmhL5zcfV22J63gvcxppEKv7zWs=;
        h=From:To:Cc:Subject:Date:From;
        b=fYYEorSqS40lPH3j1jj3ClqSRgsA9OyfZKj95ZO3KcAZ8dWEstgPhnQyoxsyXSk3E
         3ccSeiNGQL/OaMvN7NFbe80tBsh2YbDwgBUlhCVjQCowvo1LWgJdWa7TqcwLKYhFPU
         eqdMODwFxafwVKd2hXy3y3Du+NbAqdPE0oR8q/EUKv7g9APOIsolMsqamy5MbXgkcO
         Ebq/pj735Ghy49eprtOvT9jFGVBbixHMHv76QKI7D7C1wlzY8k53WS7LA23Z4PO/e8
         rxbMCTNUgfRv4Jr442yXdejzj/PCHB8PtInMPaeKvim+fGqKenO2vIY1K5N07IPBl/
         e/i8eHL/o+CqQ==
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
Subject: [PATCH v5 0/9] mtd: rawnand: denali: exec_op(), controller/chip separation, and cleanups
Date:   Tue,  2 Apr 2019 13:03:00 +0900
Message-Id: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I took time for the Denali driver to catch up with the latest framework.

 - switch over to exec_op() and remove legacy hooks

 - separate controller/chips

 - various cleanups

Major changes in v5:

  - Passing both nand_chip and denali is redundant.
    Pass only nand_chip to local helpers.

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
  mtd: rawnand: denali: use more nand_chip pointers for internal
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

