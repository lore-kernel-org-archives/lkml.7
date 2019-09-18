Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1207D2196E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787714;
	bh=Y5r2DYc2U6q8ELMTom+yXiIfvMUSdI+vlfrsGLeT+0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lgLFSI+QVyhRiJbafKhWEk0bNHmjr1EsqQuVG9vxnrGXR7E96nqyct9undkRajHr8
	 Wn7oA5QO/hZgwc94mUQ3miOxlqRxAsb+EqCIIQrhd+fKyY54cQbCZb3au5697thqZj
	 MLLRYxDC1dGmOV70XBmYl4+PUK0TeqIzC3tTNZgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfIRGVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfIRGVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:21:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729B921920;
        Wed, 18 Sep 2019 06:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787710;
        bh=Y5r2DYc2U6q8ELMTom+yXiIfvMUSdI+vlfrsGLeT+0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWmKl8ebepApTYWPM9TY6xtO9I6P11jCZEfZQ/owAWJtBdQStPJ/q6G8rA8kYRjVH
         Nv9klTbyl0SoaHbZpWZmlTnmrNJRa5422IMwHZoWhCYD36q506wLLZ8ux4/xmwCaCX
         m1hrRVjgN6fwiDeqd7lLdpIjA/cIDmRPS796s3MQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 43/45] platform/x86: pmc_atom: Add CB4063 Beckhoff Automation board to critclk_systems DMI table
Date:   Wed, 18 Sep 2019 08:19:21 +0200
Message-Id: <20190918061227.970393408@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

commit 9452fbf5c6cf5f470e0748fe7a14a683e7765f7a upstream.

The CB4063 board uses pmc_plt_clk* clocks for ethernet controllers. This
adds it to the critclk_systems DMI table so the clocks are marked as
CLK_CRITICAL and not turned off.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/pmc_atom.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -453,6 +453,14 @@ static const struct dmi_system_id critcl
 	},
 	{
 		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident = "Beckhoff CB4063",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
+			DMI_MATCH(DMI_BOARD_NAME, "CB4063"),
+		},
+	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
 		.ident = "Beckhoff CB6263",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),


