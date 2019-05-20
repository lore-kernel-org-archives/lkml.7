Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38500C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0053A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558339645;
	bh=bQgehpdwJzg1v6T6W08qkEx1c9bSqawoCkXT0ME7XwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BzGwNnUUsKlDNPuQ6YeBeiYdv8CpWail6Tr4Xcf+JXyeIVSRzR7hClf1Tp+st+XKY
	 /kS777mMZ4INRTyBdEaP+JXNjx4Qp1i3Ybit4fsbHI9dNMP+VAWeo13zvUUxfipTdf
	 hz4ar+gCOl9aqVai8WjU4yYOMVAvxwMwPHkAYkdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfETIFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfETIFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:35 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A544720856;
        Mon, 20 May 2019 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339534;
        bh=bQgehpdwJzg1v6T6W08qkEx1c9bSqawoCkXT0ME7XwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbFn0yPghbZ2rjhsPAaW+eVmdn/Luj2YxI/1PbriDe7mAPNSDrOWfUlsSjRD2B5ZU
         O2LJ8UNu7WzmPUirO5KrqsPTT/42mc4VaqN1iLCYcOEHLscADbWhbkCEOSz4T9g7AU
         DKgUbVZJpwMh3CZ+zhLz/IgDfraSuDKBZI4Sm5/o=
Received: by wens.tw (Postfix, from userid 1000)
        id 55EC6602F9; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] clk: Add CLK_HW_INIT_PARENT_DATA macro using .parent_data
Date:   Mon, 20 May 2019 16:04:00 +0800
Message-Id: <20190520080421.12575-5-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520080421.12575-1-wens@kernel.org>
References: <20190520080421.12575-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

With the new clk parenting code, struct clk_init_data was expanded to
include .parent_data, for clk drivers that have parents referenced using
a combination of device tree clock-names, clock indices, and/or struct
clk_hw pointers.

Add a new macro that can take a list of struct clk_parent_data for
drivers to use.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index edad4ad5d897..d0d58c49f3ad 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -951,6 +951,15 @@ extern struct of_device_id __clk_of_table;
 		.ops		= _ops,				\
 	})
 
+#define CLK_HW_INIT_PARENTS_DATA(_name, _parents, _ops, _flags)	\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_data	= _parents,			\
+		.num_parents	= ARRAY_SIZE(_parents),		\
+		.ops		= _ops,				\
+	})
+
 #define CLK_HW_INIT_NO_PARENT(_name, _ops, _flags)	\
 	(&(struct clk_init_data) {			\
 		.flags          = _flags,		\
-- 
2.20.1

