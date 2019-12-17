Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA12C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C397B206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="VFltoxNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLQEly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:41:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44343 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfLQEly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:41:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so4932012pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 20:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Nk/W+5arQWBs6ZTiLBLgKOQUzXBaBv6sspqmS0EGHAM=;
        b=VFltoxNYivcht4mRSWRTABNUZvebN0skY+qag2OouKIz4KqoGdQmi4ks7UY7ToejLS
         PmM3/SsG0KYROTJchUegQ3ZKsLyrq5lALVi2+chGheV8prVT/7HfsHzIbUdUDgz7kTNP
         zjniJjRLCzchA/KZiT0RuPe7ihTp+/PUsHsWRD1bU+TPYDYSCwEyH0g1yct1GMqi9RhG
         UUJ4UwXZA2d+P+qF2Ri1CIuw6DbNBK8lO5Nl7nueHYBUIEskketwZPFuWS4B6vjw4Mr3
         xPHjde8l+pjtEqQ+rWrE2InDsMB/QEkTr46EBkZ3I0slwcAj8Se9E/UPwWViFjCTYgph
         blEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nk/W+5arQWBs6ZTiLBLgKOQUzXBaBv6sspqmS0EGHAM=;
        b=lXba0G3Gb+YWHiW6M2cHi4LYizHLjTpVG60Q7m4OZWeYibz/TfRvgEDWKQfmEUTwKj
         u11n2jgqMQJV9KGZdbaPe+rHctdTGkMlv9mRiY/tWvq0/NvgHCR3o3eaCSJNyX1dBd4p
         3ZcHgTUFd+TsSGNo4HTdA8oZj+lOggHf7D6zyVZz16XG1O4CufGWd9SVKKWBLhwqyl/M
         Ib5fiC5hJtiplXeV6YNTg2TZz5Tp7Gwj7UMDddJfFH4WFlit5JfY1BcMr716gUzXWSmE
         DMAvZBbsvzyVxVgm+G95PBGv2kVL3B6SGr/vb2JCpwjPlDUC/Wdee2EfxK/0e4CjCVjg
         AQJA==
X-Gm-Message-State: APjAAAXvbMIMHUBnyeMQ2qIl100Wn1LnmT8qqq8x9nPC9gJidcyO1vZX
        2LOC/Cd/RIZjj79ynkOQmzhYjA==
X-Google-Smtp-Source: APXvYqy+E/6fERbL4RyzNs3+QqabIKLKD87ynTY+Mde2PSKfFtuH0kuleB413ORzLD8oVL9ma/uqWQ==
X-Received: by 2002:aa7:9d0d:: with SMTP id k13mr21099578pfp.254.1576557713533;
        Mon, 16 Dec 2019 20:41:53 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id q12sm24307946pfh.158.2019.12.16.20.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 20:41:52 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] clk: declare clk_core_reparent_orphans() inline
Date:   Mon, 16 Dec 2019 20:41:46 -0800
Message-Id: <20191217044146.127200-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent addition exposed a helper that is only used for
CONFIG_OF. Instead of figuring out best place to have it in the order
of various functions, just declare it as explicitly inline, and the
compiler will happily handle it without warning.

(Also fixup of a single stray empty line while I was looking at the code)

Fixes: 66d9506440bb ("clk: walk orphan list on clock provider registration")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/clk/clk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ae2795b30e060..dc1e6481f6b33 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3277,7 +3277,7 @@ static void clk_core_reparent_orphans_nolock(void)
 	}
 }
 
-static void clk_core_reparent_orphans(void)
+static void __maybe_unused clk_core_reparent_orphans(void)
 {
 	clk_prepare_lock();
 	clk_core_reparent_orphans_nolock();
@@ -3442,7 +3442,6 @@ static int __clk_core_init(struct clk_core *core)
 
 	clk_core_reparent_orphans_nolock();
 
-
 	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
-- 
2.11.0

