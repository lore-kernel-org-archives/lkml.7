Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F3C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55461204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kHyJz+m7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733271AbfHARMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:12:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35529 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfHARML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:12:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so28255089pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcjmT1jOSVdsV93kLH8gtUAFCZgmRAp5z5U28nSu3es=;
        b=kHyJz+m7BmumSB/lXMmIWdSeNfe0tZwSsJVXm23HuBNojk088JpKyAFkU3Zv01EKO4
         ieGUBag0hyqYjHxfBVqXUkpXPZfwkmAqjlgcwQCp2KRu6T8v+Y5MURo7X+LJVfw8IQEc
         TleAaC303hHw5NzUk7alhSbmDoS8QCe4uUWqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcjmT1jOSVdsV93kLH8gtUAFCZgmRAp5z5U28nSu3es=;
        b=c4OPyw1yFOJppeHuixSeL6BXGevi1uiyK7a+bhttZ3P7WaYfHkpJYar3mQt3+ZImcj
         1I3Pk6omRBdM1OG+P3R0l0aa7JaeFp/+/NOHyur3I56B2Pxns9k+lFY8LPX17KTetQpc
         Uz3ewftSgj2qDlQmJlGgUWm7kvBFSs0XaB6ASlApnwF/bJlY9mkuEwMMekGphjS1Whr+
         WhvOIPYa9OkoT7RekunRXcPFya5gxAcTEe5oyGAV/X2UR7n2ErB54iBB277dJj+XJ2zd
         VqEgGWXn0ElL7Dj6zFqYNrHucOlmbXQccQOrPbRVTDoWmIeQbP6ktias3gPbA+oGYYJo
         iAhQ==
X-Gm-Message-State: APjAAAVU9FXHf1G9F7WrVdgp3oCbwvs89FfTlN/BZ/wS/tKvc8B/aQZo
        dVRi68YKSSrF2jXC85II7vrtyQ==
X-Google-Smtp-Source: APXvYqx1cQXEOiX/lyozSzHWzCxjT6GUENupJHLuvSbCfxgZdgdhtJmIjnRlQ01pJzKN5yfw7hOLuw==
X-Received: by 2002:a17:90b:f0f:: with SMTP id br15mr9940132pjb.101.1564679530629;
        Thu, 01 Aug 2019 10:12:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y22sm83985492pfo.39.2019.08.01.10.12.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:12:10 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
X-Google-Original-From: Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] clk: Fix falling back to legacy parent string matching
Date:   Thu,  1 Aug 2019 10:12:09 -0700
Message-Id: <20190801171209.234546-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to clk_core_get() will return ERR_PTR(-EINVAL) if we've started
migrating a clk driver to use the DT based style of specifying parents
but we haven't made any DT updates yet. This happens when we pass a
non-NULL value as the 'name' argument of of_parse_clkspec(). That
function returns -EINVAL in such a situation, instead of -ENOENT like we
expected. The return value comes back up to clk_core_fill_parent_index()
which proceeds to skip calling clk_core_lookup() because the error
pointer isn't equal to -ENOENT, it's -EINVAL.

Furthermore, we'll blindly overwrite the error pointer returned by
clk_core_get() with NULL when there isn't a legacy .name member
specified in the parent map. This isn't too bad right now because we
don't really care to differentiate NULL from an error, but in the future
we should only try to do a legacy lookup if we know we might find
something so that DT lookups that fail don't try to lookup based on
strings when there isn't any string to match, hiding the error.

Fix both these problems so that clk provider drivers can use the new
style of parent mapping without having to also update their DT at the
same time. This patch is based on an earlier patch from Taniya Das which
checked for -EINVAL in addition to -ENOENT return values.

Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
Cc: Taniya Das <tdas@codeaurora.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Reported-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..6587a70c271c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -355,8 +355,9 @@ static struct clk_core *clk_core_lookup(const char *name)
  *      };
  *
  * Returns: -ENOENT when the provider can't be found or the clk doesn't
- * exist in the provider. -EINVAL when the name can't be found. NULL when the
- * provider knows about the clk but it isn't provided on this system.
+ * exist in the provider or the name can't be found in the DT node or
+ * in a clkdev lookup. NULL when the provider knows about the clk but it
+ * isn't provided on this system.
  * A valid clk_core pointer when the clk can be found in the provider.
  */
 static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
@@ -374,9 +375,9 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	/*
 	 * If the DT search above couldn't find the provider or the provider
 	 * didn't know about this clk, fallback to looking up via clkdev based
-	 * clk_lookups
+	 * clk_lookups.
 	 */
-	if (PTR_ERR(hw) == -ENOENT && name)
+	if (IS_ERR(hw) && name)
 		hw = clk_find_hw(dev_id, name);
 
 	if (IS_ERR(hw))
@@ -401,7 +402,7 @@ static void clk_core_fill_parent_index(struct clk_core *core, u8 index)
 			parent = ERR_PTR(-EPROBE_DEFER);
 	} else {
 		parent = clk_core_get(core, index);
-		if (IS_ERR(parent) && PTR_ERR(parent) == -ENOENT)
+		if (IS_ERR(parent) && entry->name)
 			parent = clk_core_lookup(entry->name);
 	}
 
-- 
Sent by a computer through tubes

