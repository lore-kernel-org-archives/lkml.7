Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC27C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F87B20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/fRfIgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfFQUKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:10:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43594 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbfFQUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:10:25 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so24069663ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmQHqjhHBWJi9EwLf/CG1WJEE+QuCC5/BPgepbsr0cM=;
        b=H/fRfIgOLxZAjL30Tf02SNyuVL4rKUnrX2bKgFBJyd5IQUZx1ZP6q7691JqcjyC9nS
         ++sCnwMqLy/QpEj+7Hi7jU5SjniVAjL78+/q92CgC7hs/S7yVAkyhXYXlfSH69K6ZbzC
         a5AjFLd56W7UgJEv9EIhkxSJcgspEV81Jgn30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmQHqjhHBWJi9EwLf/CG1WJEE+QuCC5/BPgepbsr0cM=;
        b=PWE4QunMJVGOo1KE0AjoKjQnaJu/eEvWq8zBK4XABqQ7IN5memnjDkn70ne+mQpGNS
         DJGy8TBj1xCu49KRahZ6WMqFzc1cmENe1p3uapgl2rTEtqH1sOkIA4eEjm9H/hXOoP9W
         mYnJiFpaWJv8aS/fz3hjpZsVaYwRo3NwlMIVPYSxhJYtZy69Uiez9rP56GT0YMvzs8XG
         /9h+U8ano/QmzL3IhTpGypsetsvd7+lnZkoLmX1dFu4K7VN5XePPpGeqVXQzp8SKrn7Q
         HBPQwmrK4jZHwmCSh1urQd++pBVLgpJ5WK+LctsdiqJYR7A0KC0gNlU3gY/xN2M1hZ+g
         5iVg==
X-Gm-Message-State: APjAAAX9I+BXZtlPXNgF+bRgUUU0aZ9CxNpSRihJ3fVMqJe2Ilr8YLW1
        Ll2QLlYV0sWSA9nCENXFMO+dMQ==
X-Google-Smtp-Source: APXvYqwODDA3bqD50Y83iVab01joUoo1S7LoKNsRIrKC1JdP7WoFgOUSHbQOduVooAcoh4huWj9+dg==
X-Received: by 2002:a6b:b257:: with SMTP id b84mr63639506iof.137.1560802224611;
        Mon, 17 Jun 2019 13:10:24 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id s6sm9199236ioo.31.2019.06.17.13.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:10:24 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
Date:   Mon, 17 Jun 2019 14:10:14 -0600
Message-Id: <20190617201014.84503-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190617201014.84503-1-rrangel@chromium.org>
References: <20190617201014.84503-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove whitespace in front of SDHCI_CTRL_8BITBUS. The value is not part
of SDHCI_CTRL_DMA_MASK.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

 drivers/mmc/host/sdhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 199712e7adbb3..89fd96596a1f7 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -89,7 +89,7 @@
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
 #define   SDHCI_CTRL_ADMA3	0x18
-#define   SDHCI_CTRL_8BITBUS	0x20
+#define  SDHCI_CTRL_8BITBUS	0x20
 #define  SDHCI_CTRL_CDTEST_INS	0x40
 #define  SDHCI_CTRL_CDTEST_EN	0x80
 
-- 
2.22.0.410.gd8fdbe21b5-goog

