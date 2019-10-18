Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0282FCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA94121D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK3Ai6M2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442062AbfJRHKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:10:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33766 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfJRHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:10:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so2857180pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUKSB/eobGAaYzA+zetYK7qwC81TH5UGLLG8mpvrqjM=;
        b=IK3Ai6M2vww5v5zDqMVx2Y5Ux3F2JnNbcrzWeRo30ZlpTw/YxKGRFm5dPAXISnId2K
         LUWF/zq8wvhnBjW1sgSnfDfDCqSvxFALW1h/kZFJG+U6kfujlc5CLhE2+gvUrYIYFLyF
         eYQbv0KgtyRC03j5YNpvQHy4YWzrw9/v5m4U4iurnbFirv8SLE43Ls6jgVGAdTeTNZeQ
         TJP6IPJpuWU4YtkwYL3o0qYlasjzi57kp9+cmR9IpAQvIjoBtnnC3DPmEQeaqAusnGcb
         ZRae5QAaF5VL/IjzD4UHIeSDiqqqaPtfwmoriJTp7xN5z/F29hwErInQVeEHmxtTc7mJ
         QwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUKSB/eobGAaYzA+zetYK7qwC81TH5UGLLG8mpvrqjM=;
        b=G4eMAmEof8kTjYcOt7uVdMNLx8lsBCwp9+7x1krmvKk2hCwzbbS/vc4fww2uNGWsLb
         Cv1dLje9QmxvkEWaseKMjKK0jU2QOpAGrJGF6SWd/qLkHOoUczBPCnFdILYRaGS5ukYw
         3ALBsTouipbZn5YU0cVaDnvPhD5CU78vQt8nEwPERHVN8X3SUy2YQsAmhIUCHv/tVXIR
         8MBpyiz6DO4TPYVlNIIEajrcmdV5mR3IbWKLSUCP4oipHj7+2ZzxC15DUbA6Pt3LmR7q
         YIp69/R6fICy8a7rAhoSIaPyw6sV0PnCjbm09VId9dmKRSyyzKY/SgTslUkXB+n4f17e
         N8Mg==
X-Gm-Message-State: APjAAAVXEaCJKDoOGM6qhKZfimgdIYGuLg2uikTSAeOWvjuHcLpXadNs
        JvJ2fi0NRQK8RY9xcAzXgL4=
X-Google-Smtp-Source: APXvYqwG6pgWoLTskuPSqA1ZK0IIJIG9b5lF34gkizyFXbN0bJnAbqjQXy5U4vUskXlAmbg0A2NDFA==
X-Received: by 2002:aa7:9907:: with SMTP id z7mr4977952pff.133.1571382600635;
        Fri, 18 Oct 2019 00:10:00 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id s97sm6974508pjc.4.2019.10.18.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 00:09:59 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: KPC2000: kpc2000_spi.c: Fix style issues (misaligned brace)
Date:   Fri, 18 Oct 2019 00:09:48 -0700
Message-Id: <20191018070948.22279-1-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: ERROR: else should follow close brace '}'

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
Previous versions of these patches were not split into different 
patches, did not have different patch numbers and did not have the
keyword staging. The previous version of this patch had the wrong 
description and subject.
 drivers/staging/kpc2000/kpc2000_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 5712a88c8788..929136cdc3e1 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -226,8 +226,7 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
 		}
-	}
-	else if (rx) {
+	} else if (rx) {
 		for (i = 0 ; i < c ; i++) {
 			char test = 0;
 
-- 
2.20.1

