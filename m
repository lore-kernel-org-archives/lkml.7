Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797EC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EC021852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554414828;
	bh=xZLj/dM4yvsxxAOduPfGFuMxFMUwm2DjGIt71EuyvGI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KKwrCgxq1L+cErc+P9SYeKmG+JkFJzhQI4vbsoUPOfUggqeDN1J2zPJ8stgR2RsPE
	 U/8lRNrBJxtzeq6r4hcKGMtfeZD16wL9OAat4KxwNLxs/loF5UFVFUCdgzAodOQd7G
	 pT/Rke6ISm6GpfgoSLreE5oRaArf2f5pYrk4283U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfDDVxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfDDVxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:53:46 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C4820882;
        Thu,  4 Apr 2019 21:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554414825;
        bh=xZLj/dM4yvsxxAOduPfGFuMxFMUwm2DjGIt71EuyvGI=;
        h=From:To:Cc:Subject:Date:From;
        b=q0MoGxANnXlWbJ6m1CiOKEXsTDi6hTNn8PFvBgmnY2hCQ5WFAOh53FQCyu8s+2MHu
         DCpD6UqdC7k8bYbBKYqTIopI3LXM9efYLXRQDdyVcyGdX3QB9GMkA2xvlBO+miDBgr
         Kloe7yBEXhmFU01WETw7NrHWyhWbtgxNgoO6Fkgc=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v3 0/7] Rewrite clk parent handling
Date:   Thu,  4 Apr 2019 14:53:37 -0700
Message-Id: <20190404215344.6330-1-sboyd@kernel.org>
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

Stephen Boyd (7):
  clkdev: Hold clocks_mutex while iterating clocks list
  clk: Prepare for clk registration API that uses DT nodes
  clk: Add of_clk_hw_register() API for early clk drivers
  clk: Allow parents to be specified without string names
  clk: Look for parents with clkdev based clk_lookups
  clk: Allow parents to be specified via clkspec index
  clk: fixed-factor: Let clk framework find parent

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

 drivers/clk/clk-fixed-factor.c |  53 ++++--
 drivers/clk/clk.c              | 326 +++++++++++++++++++++++++--------
 drivers/clk/clk.h              |   2 +
 drivers/clk/clkdev.c           |  38 ++--
 include/linux/clk-provider.h   |  22 +++
 5 files changed, 334 insertions(+), 107 deletions(-)


base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
-- 
Sent by a computer through tubes

