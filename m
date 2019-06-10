Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33A7C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6092207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hNHkuWRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389035AbfFJSzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:55:11 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52597 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbfFJSzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:55:10 -0400
Received: by mail-it1-f196.google.com with SMTP id l21so784915ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OQiFS4mzZNpmchUtzhYv2GneN1IZGSv7wacJrf6EtE=;
        b=hNHkuWRDqlR3Q3TDaxHRzI06RqOjj75TOm4O2BEcyfY0AOdiydlwK2wHdT4xm6B8iT
         c2OTYhCNwn6/48JaeFcoPisRPJk2Ypw6FzF9hwTd17Lq9FURyXB6uxvutuGxuGi/aMDV
         bBmb3wHsiLbhCsSUfuqYYVT6vmhgQccim0vyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OQiFS4mzZNpmchUtzhYv2GneN1IZGSv7wacJrf6EtE=;
        b=Ug4/QZL8wJtqnHcyj6BVHU6sNaYAKuj0vXtLYVxYxgtD7wcZS6ipfUrCDL02vxWCqS
         3ETo1orBqU8/UXhtwEbZL22QB5lb8+QL8/B6D9226tKhAz5a7tNwQNu8xKj0/eCrn9md
         nh0d0Uh3BJaz1TnC1BQ0NlQzlRNVL++dbIwxHAxr/us0w+wDYRki1btCaccQLkL71HDw
         4LcKUFp6WzTGNEoIZOYSBckjBdS9WxVUUJ+rd/VTE0tHIGXihvFBbA8/YMbfgjSMFkab
         PefOiOv1mbGkui4e606tkENQwbLr40qMPjKewBTfVf6RZmMtFikKJYW1xbNLfe9vS55i
         /slw==
X-Gm-Message-State: APjAAAUEI37BiV8L6MEFW1xBur2ZgFVFC6uml0y3MHAFJM/v1nzbtXDn
        f41X3L3I9gbuBQ/oAppDofulSg==
X-Google-Smtp-Source: APXvYqwKv/qZm4110xGTzg1+th2td34sNn7y93waDnRsw7ju3/C0X2SG909IBDR3rPJdGyr5tvxhSA==
X-Received: by 2002:a24:1dd5:: with SMTP id 204mr16517482itj.180.1560192909650;
        Mon, 10 Jun 2019 11:55:09 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id d7sm3581954iob.67.2019.06.10.11.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:55:09 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
Date:   Mon, 10 Jun 2019 12:53:53 -0600
Message-Id: <20190610185354.35310-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190610185354.35310-1-rrangel@chromium.org>
References: <20190610185354.35310-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value is referring to SDHCI_HOST_CONTROL, not SDHCI_CTRL_DMA_MASK.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
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
2.22.0.rc2.383.gf4fbbf30c2-goog

