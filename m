Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF73F206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MV63+/qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfGaIkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:40:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44006 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfGaIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:40:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so68664089wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLpjjKS1ce8bNQv8q/Qa2SJ22ctxx4jp20Vf7E5q7wU=;
        b=MV63+/qRVHk4pEL2HzlA9UVoc85DydE09k+CdU0asPODTFDtlVpRZcRLzSaAP0rUVm
         yi9qfx+pp21tlii4qTwgjeQVCMcugVuRyMpv+afoyKd4NMGKn42BJwxvqcBc7XYEgSUy
         Y02feLyW5nr4y+pPzjYnWIuzJF7q9aCqkio42k105UNNp1Y3SHilEVpJcVSYh2JJUqd0
         ZQfPsY/uuHth24yNpFCe0d1+UmcIZupfhlO+Sit5CsTagbQVc+wOcaFx9wlEC1r2q6YU
         DFmP6Me6nEMfvIU2AupxORQCbyYdfJ9ro2OYQwK/U4gvqdzrcbtA5q4UjiPNwYkvBR4G
         xqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLpjjKS1ce8bNQv8q/Qa2SJ22ctxx4jp20Vf7E5q7wU=;
        b=s4IYtPqW18zMCsQ9qRV8jeklciezDsgjK/1x+TcX2/qwbGKKKp+13nO+rr4NMIhRY2
         4ptcnET/oZucof6dsaTxGnax0ErCpxxVfZXK23KS3fajdnZEVLqED6SZHch8VJCqHLgS
         AInDXXEEXAqgEls2eezCwZX23E93QZQkgvzRiCkJPl1q51DXnKRZt4xp92USlyKU4ApM
         XQXLOhGFeob7UjDPo5Rpn9DoOgSGn3jH/894wP3a/uzIiKtkO4ECRZD9HJw2qhW+MTs0
         LgB4GIjC9e825lGV70Ev9q24iURQUCgeFpehPyhugXnY5oZiTxERnJMktE9RCGaQxa6M
         7JZw==
X-Gm-Message-State: APjAAAUUEyjwE7MyHRU9MQst9batNRpeljkM58qUPsz6wenWRkFOpCv8
        vbQiuS1OzeokSmeeZRUt7R/+gQ==
X-Google-Smtp-Source: APXvYqzqvEbqRWHT70qD1Gd6GbwhoKcTb1xDRKV5uUOaWJtUJ43Ikrt6tSU+oew0L9HjDkTlKmV47A==
X-Received: by 2002:adf:f186:: with SMTP id h6mr5501169wro.274.1564562423669;
        Wed, 31 Jul 2019 01:40:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 18sm56049308wmg.43.2019.07.31.01.40.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 01:40:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sboyd@kernel.org, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/4] clk: core: introduce clk_hw_set_parent()
Date:   Wed, 31 Jul 2019 10:40:16 +0200
Message-Id: <20190731084019.8451-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731084019.8451-1-narmstrong@baylibre.com>
References: <20190731084019.8451-1-narmstrong@baylibre.com>
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
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/clk.c            | 6 ++++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..c11b1781d24a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2487,6 +2487,12 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
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
index 2ae7604783dd..dce5521a9bf6 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -817,6 +817,7 @@ unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
 					  unsigned int index);
+int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long __clk_get_flags(struct clk *clk);
-- 
2.22.0

