Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B393FC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDA3214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+xUOeyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfJKFwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:52:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38816 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKFwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:52:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so5397162pfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIIpGdRKdT3hjAKKgnZBguQ5qXVsyW6bN9Y5XxQyxMc=;
        b=f+xUOeyOxacA45AwVn6sWUl+nSjKToduHdjQ+uhdJXgZ5vDxI1PRqSYX1lw+ZMCkU7
         wYjqHjc2YKujq2ge4STL0e5L0T7NQFwhWALEIreIitrVqC8wBD9JLVIrSCBokHtGpOPl
         MkeXRtNA9ax/jHKMw43w+TfeEW4rLUcVZDZRembiQC4kGyGmknyUR/ytxOGHBr09Yipq
         fhvyLQrXKPkfylVen9kET2YYqq+6Si2tuLoXkBY0wrPrcH5QZX1ZKz9DED84dllM/O5C
         VpXPubFh3YP+HCgV/pwY9U8UZE6EZyWcihWKQUu32pu5xQAQrQCN7O4pdR65wbUDEWGV
         QdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIIpGdRKdT3hjAKKgnZBguQ5qXVsyW6bN9Y5XxQyxMc=;
        b=P8mMw+Z6MJO7wEY+r325mitghn5eP/il/TolWSschOVDbFxxw0A3f6bAilbK2Zvguy
         LuLqzBgCkvio4k6EUd7/ghmEGOV7virkkpv5PNRlgoOSAC1LgGZ7NCYcwAUa2Lpsz3yH
         s+pDtmZOUYnXfGoHbDzumUrp1K82e0GDP292iYO4no2W1raqleORyM7lTR7qGlm0MKIg
         ozntPzX17pnw6dxxOU8XxqC/QScEDhmlFy+Q/XN8eq5XVJ1Lc8pCXHoGdCfe7hfW1rV1
         gI1oMUhuPjrsgI7L86YlDr7+R12z3TDrSUMPTXVDaf3vC9/D+glyB+aMqIdOZrCNuKum
         giQA==
X-Gm-Message-State: APjAAAX11cEB3zm3xiZMcXAVJISR9IbR3XeUaAfuXLiO847f8kl3Jkac
        8GwMZq8qskcZnHn76572I1Vkq8aIZXjXwg==
X-Google-Smtp-Source: APXvYqx5m5kGl2cgcGxoUukHl4f6QgvVCu68CUW1beVrc8BTbmcRRiJC01ouu48zZfiRd7z3Z994Hg==
X-Received: by 2002:a65:498a:: with SMTP id r10mr15531549pgs.131.1570773131968;
        Thu, 10 Oct 2019 22:52:11 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id i184sm10257782pge.5.2019.10.10.22.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 22:52:11 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, michael.scheiderer@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] KPC2000: kpc2000_spi.c: Fix style issues (alignment)
Date:   Thu, 10 Oct 2019 22:51:54 -0700
Message-Id: <20191011055155.4985-4-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191011055155.4985-1-chandra627@gmail.com>
References: <20191011055155.4985-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: "CHECK: Alignment should match open parenthesis" from checkpatch

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 66cfa5202690..26e1e8466fb2 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -315,19 +315,19 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 		if (transfer->speed_hz > KP_SPI_CLK ||
 		    (len && !(rx_buf || tx_buf))) {
 			dev_dbg(kpspi->dev, "  transfer: %d Hz, %d %s%s, %d bpw\n",
-					transfer->speed_hz,
-					len,
-					tx_buf ? "tx" : "",
-					rx_buf ? "rx" : "",
-					transfer->bits_per_word);
+				transfer->speed_hz,
+				len,
+				tx_buf ? "tx" : "",
+				rx_buf ? "rx" : "",
+				transfer->bits_per_word);
 			dev_dbg(kpspi->dev, "  transfer -EINVAL\n");
 			return -EINVAL;
 		}
 		if (transfer->speed_hz &&
 		    transfer->speed_hz < (KP_SPI_CLK >> 15)) {
 			dev_dbg(kpspi->dev, "speed_hz %d below minimum %d Hz\n",
-					transfer->speed_hz,
-					KP_SPI_CLK >> 15);
+				transfer->speed_hz,
+				KP_SPI_CLK >> 15);
 			dev_dbg(kpspi->dev, "  speed_hz -EINVAL\n");
 			return -EINVAL;
 		}
-- 
2.20.1

