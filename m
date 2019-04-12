Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D16C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C236F20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555093955;
	bh=zFwgN1sOMDea7TNovxIY+gAobjB9y0e2myeBcykA46s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GmNYe9cJSOG+RelL3S5nWItAPUyuULXrI4Jb5hoM4h2AQaO4dmFFRDq3PKRRS2x2N
	 mVkaI000Ym4RDmOAQkASvJNCDAMjTlb1Jt0QvR/gVJ3jjDEK+YOpsuzcFC2XZzZNZF
	 WquYBIwanmBty2LvZrcP8lVaa4QiSHxgOoGY8qBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfDLScf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfDLSbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:31:52 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0053B20818;
        Fri, 12 Apr 2019 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555093911;
        bh=zFwgN1sOMDea7TNovxIY+gAobjB9y0e2myeBcykA46s=;
        h=From:To:Cc:Subject:Date:From;
        b=xF4GNv8Nl+uviNc3A31GjGkwdCJZeJ402GCjEHUkgbrxskZqkwrVmQcBeNFWxts5y
         ZkuzOXzBg7A+/KQNRbbSqmydHZ6AVOsGejGhoHSi62XCMqPjVx+aNSA08Y/6kxJzP9
         q8a+z26L4Dr0C2wUTr6nL8WmrfaOhNvhqRzOxE2U=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 0/9] Rewrite clk parent handling
Date:   Fri, 12 Apr 2019 11:31:41 -0700
Message-Id: <20190412183150.102131-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple warts with clk parent handling in the common clk
framework. This patch series addresses one of those warts, parent-child
linkages. We use strings for all parent-child linkages, and this leads
to poorly written code that extracts clk names from struct clk pointers
and makes clk provider drivers use clk consumer APIs. I've converted the
fixed factor clk and I'm looking at converting users of other "basic"
clk types in follow-up patches so we can start moving drivers away from
string matching in the clk namespace.

Changes from v3:
 * Split clkdev patch into two
 * New patch to let dev_of_node() accept NULL
 * Use dev_of_node() in of_clk_hw_register() to avoid NULL deref

Changes from v2:
 * Dropped patches that got merged into v5.1-rc1
 * Introduced a new function of_clk_hw_register()
 * Introduced 'index' into clk_parent_data structure 
 * Converted fixed-factor basic type to new design
 * Fixed some bugs in a recent patch to clkdev, leading to
   an essential API for clkdev based lookups working

Changes from v1:
 * Dropped new get_parent_hw, we'll pick it up in a later series
 * Rebased to v5.0-rc6 to avoid conflicts with clk-fixes
 * Renamed 'fallback' to 'name' and 'name' to 'fw_name' in parent map
 * Made sure that clk_hw_get_parent_by_index() never sees an error pointer
   so that we don't mistakenly try to defer an error pointer
 * Fixed index passing mistake on of_clk_get_hw_from_clkspec()
 * Copy over all the data from parent maps and free it correctly too

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>

Stephen Boyd (9):
  clkdev: Hold clocks_mutex while iterating clocks list
  clkdev: Move clk creation outside of 'clocks_mutex'
  clk: Prepare for clk registration API that uses DT nodes
  driver core: Let dev_of_node() accept a NULL dev
  clk: Add of_clk_hw_register() API for early clk drivers
  clk: Allow parents to be specified without string names
  clk: Look for parents with clkdev based clk_lookups
  clk: Allow parents to be specified via clkspec index
  clk: fixed-factor: Let clk framework find parent

 drivers/clk/clk-fixed-factor.c |  53 ++++--
 drivers/clk/clk.c              | 326 +++++++++++++++++++++++++--------
 drivers/clk/clk.h              |   2 +
 drivers/clk/clkdev.c           |  30 +--
 include/linux/clk-provider.h   |  22 +++
 include/linux/device.h         |   2 +-
 6 files changed, 327 insertions(+), 108 deletions(-)


base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
-- 
Sent by a computer through tubes

