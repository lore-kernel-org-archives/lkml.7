Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE56C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61832173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bluu7D9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbfGPWpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:45:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35002 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388921AbfGPWpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so3837172pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhoCZVaLlau9+Xc+5qSO9umR0QsUdpX7Z2QE44vnJZU=;
        b=bluu7D9B/mMWMLSKmrkYFqWlQqd81PwDK6IUpGDHR9A82/CADp8Ac7NeQrUBhy32gp
         un4BOzUZXGz/UosByptd3LvbToVwTST2LMbVWMk7+mDvzRsTkqdAMysmWFPl0zLwop74
         VThHreHsZRuHz+/sHCR45nilICSBE7D5SjV2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhoCZVaLlau9+Xc+5qSO9umR0QsUdpX7Z2QE44vnJZU=;
        b=bqtAGgY36mu/SNZ9USHKKArZ0+503GaFP6MPtpuyPM9bsl2TcgE8ZEMKZoHuc4UDgV
         PaLIKlVCFP7Q/u1iMw/iAXscM3vkzDuZMdbV1JrUw0ad1sJWPjQW6jYV1lPRJ2VmroV+
         TLEoKfvySRUZJ7NQyJB9A9N1M9F5ejG49zuBd90xd/7qqs6b6vhh5U6n25ag2qiAg8ev
         VPDkwL/dWGHD+AH9VCIM5nTK9tNjX0yBY313Hc+63RZz5cQNn4oYzXP5xl1doP096KuU
         dr53831ZunPGmBb0l5gsk+5T+3nBcWjWr8Rdtpj0WDYnCRYdgYMT9mQucf5/qgfzIMIj
         ZABA==
X-Gm-Message-State: APjAAAUkpgy0BODkI7GALX70+MrlapAPa1QvGl1z7bsZdLO8tPiiBgip
        xFLQsK6IRZSpouy/q327phT2bA==
X-Google-Smtp-Source: APXvYqzJCyO68XJZcaLnDyrXCNdFh5UGj9LKILi3eXmr8hQVkr/gtkE5Z7MtsrtHorzGNfG0SBaK3Q==
X-Received: by 2002:a17:90a:32ed:: with SMTP id l100mr39314318pjb.11.1563317122065;
        Tue, 16 Jul 2019 15:45:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 64sm22182562pfe.128.2019.07.16.15.45.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:45:21 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH v2 2/6] tpm_tis_core: add optional max xfer size check
Date:   Tue, 16 Jul 2019 15:45:14 -0700
Message-Id: <20190716224518.62556-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716224518.62556-1-swboyd@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

If tpm reports a bigger burstcnt than allowed by the physical protocol,
set burstcnt to the max allowed value.

In practice, seen in case of xfer issues (e.g. in spi interface case,
lost header causing flow control issues and wrong values returned on read
from TPM_STS). Without catching, causes the physical layer to reject xfer.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
[swboyd@chromium.org: Drop extra parenthesis in if statement]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_core.c | 9 ++++++++-
 drivers/char/tpm/tpm_tis_core.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c3181ea9f271..5134b05487e5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -268,8 +268,15 @@ static int get_burstcount(struct tpm_chip *chip)
 			return rc;
 
 		burstcnt = (value >> 8) & 0xFFFF;
-		if (burstcnt)
+		if (burstcnt) {
+			if (priv->phy_ops->max_xfer_size &&
+			    burstcnt > priv->phy_ops->max_xfer_size) {
+				dev_warn(&chip->dev,
+					 "Bad burstcnt read: %d\n", burstcnt);
+				burstcnt = priv->phy_ops->max_xfer_size;
+			}
 			return burstcnt;
+		}
 		usleep_range(TPM_TIMEOUT_USECS_MIN, TPM_TIMEOUT_USECS_MAX);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 7337819f5d7b..248e8ac8fd02 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -106,6 +106,7 @@ struct tpm_tis_phy_ops {
 	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
 	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
 	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
+	u16 max_xfer_size;
 };
 
 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
-- 
Sent by a computer through tubes

