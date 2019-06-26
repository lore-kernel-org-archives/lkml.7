Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EC6C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEFD2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0dQvF2Y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfFZJHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:07:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46700 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfFZJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:06:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so1740098wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PBhHywaKoqeEXor4qGKKEbTn6ANfeSg4ls1LrAVLLs=;
        b=0dQvF2Y37cH6qhAVKYSNd6wABJorxdelAViXz4ofOHPaWbEl0G4K+YJkciOphm7wCj
         Yqg0PEZzw/3DDwW4RH+HZVs7miXIE4EGM0Z450dN9YOu+OZxfvRyYoaEQQhmNAlIFPQm
         uhKfWMtUTzbaw8aOM99khqpNMqeOnkVVHhBYJbhUNhrmfRYpzkXNebTF+0fqCHkJH7r7
         OXif0OQ13z7qvVprUKI2oREU5H5PqDHYT9+NXF9T0nPgGxU71WAs4fXbbQmBtPmtJkVr
         0bwDZDsF88vzy3fHx8tQ2UY6ZZqnh+vslTNeoxd+/RoZFqPBfcVhY/btLgVIcNSIAxt/
         CPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PBhHywaKoqeEXor4qGKKEbTn6ANfeSg4ls1LrAVLLs=;
        b=ZmZhzLn5Py2BsldulDIcNUJmWT+LyDso8F4wtRU/zXE1okj6Xxxxv/NCHfMGQqnG5d
         HKGJuwT3O9Z38MV4JcI3AGCVlbFinQfPuJsuhzWfmI5DRbpd2UPaGLF6JWphAnFCeuhH
         id3okPWBS//wfpIIuqQn7aH/nBxnllqx1MHJm14fJrvWuOsU7be6rvuH9EDGvgyWPG3R
         SgPmk65Elsgh+NzxCXBveVOlsIALux52kSEM9/WPugTGmSfnZYaGgdgVuiFHYvfxKpJB
         HuN3aCXLYr3HYNUF0yvk1rWCGIINsC3lRD92LUg7OfVXhu8bQcGoAallVqJR5k50zE0O
         +Z6A==
X-Gm-Message-State: APjAAAVNyrh1pGdt9oxeFIU76SMHtyzteT4wQhI8VL1GJyju1vZma+sO
        hCZxR49b2tXcb2eZX3+1tX/uFA==
X-Google-Smtp-Source: APXvYqxvUFmJny+jMH1kZs7aju+I59XRIseKcpXP0X5SnQQR7xSg23DSD/lqG4I9aJxmcv8Xe0QucA==
X-Received: by 2002:adf:b605:: with SMTP id f5mr1726864wre.305.1561539999021;
        Wed, 26 Jun 2019 02:06:39 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o6sm1925797wmc.46.2019.06.26.02.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 02:06:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v2 02/14] clk: core: introduce clk_hw_set_parent()
Date:   Wed, 26 Jun 2019 11:06:20 +0200
Message-Id: <20190626090632.7540-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626090632.7540-1-narmstrong@baylibre.com>
References: <20190626090632.7540-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the clk_hw_set_parent() provider call to change parent of
a clock by using the clk_hw pointers.

This eases the clock reparenting from clock rate notifiers and
implementing DVFS with simpler code avoiding the boilerplates
functions as __clk_lookup(clk_hw_get_name()) then clk_set_parent().

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/clk.c            | 6 ++++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..06e1abe3391c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2490,6 +2490,12 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 	return ret;
 }
 
+int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *parent)
+{
+	return clk_core_set_parent_nolock(hw->core, parent->core);
+}
+EXPORT_SYMBOL_GPL(clk_hw_set_parent);
+
 /**
  * clk_set_parent - switch the parent of a mux clk
  * @clk: the mux clk whose input we are switching
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index bb6118f79784..8a453380f9a4 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -812,6 +812,7 @@ unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
 					  unsigned int index);
+int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long __clk_get_flags(struct clk *clk);
-- 
2.21.0

