Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B507C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F159208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688089;
	bh=uKx5i3vKS0GeF/yUflMcRlNzLFZx7yPBGWbdtr6j/l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kP5lEyA7vlo9a297F/xqsx+j7l/wnnQ+hfBa8Rqy7TT6/mJbxxs2+4vYYKSSt0c8v
	 KLXVJjqWPf2Tfrf+I9gIsmd09c2sSb9Q/q1X3K9INXGHYFQrfh5k7jphWM5vj71Fo5
	 b1nPl6Su4U1hKnzE7nsm7EJ4pb4nrGaLI1ifZENc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCDI2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:28:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbfCDI2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:28:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A2220836;
        Mon,  4 Mar 2019 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688079;
        bh=uKx5i3vKS0GeF/yUflMcRlNzLFZx7yPBGWbdtr6j/l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yEJEkduJTzVbvgngc1ZUBK8nXY8GyNg3UXuubXB9BdxiExvNgziZl5V38Xvskr2Yw
         AHvQ2CwQ2A4N6MTjAY+L6iMMCqQdAd0Sjsmbz6eNr2IAjH/Hj+17/TvmuKREnzrQB5
         83uZQGYm7oXLDTHL+G1XcHdTDzOOOtMTwLm0ttak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/78] clk: sysfs: fix invalid JSON in clk_dump
Date:   Mon,  4 Mar 2019 09:21:54 +0100
Message-Id: <20190304081626.002791078@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c6e909972ef87aa2a479269f46b84126f99ec6db ]

Add a missing comma so that the output is valid JSON format again.

Fixes: 9fba738a53dd ("clk: add duty cycle support")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d31055ae6ec6f..5413ffaf02e23 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2687,7 +2687,7 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 	seq_printf(s, "\"protect_count\": %d,", c->protect_count);
 	seq_printf(s, "\"rate\": %lu,", clk_core_get_rate(c));
 	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
-	seq_printf(s, "\"phase\": %d", clk_core_get_phase(c));
+	seq_printf(s, "\"phase\": %d,", clk_core_get_phase(c));
 	seq_printf(s, "\"duty_cycle\": %u",
 		   clk_core_get_scaled_duty_cycle(c, 100000));
 }
-- 
2.19.1



