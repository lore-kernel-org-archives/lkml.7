Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0758C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9122075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMpx6Ttn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDCPQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:16:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33234 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCPQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:16:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id j10so15856796otq.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8rqsXgaLu9l4H6DwFqTyXA9ldT3ZN1SoeT+u6bwBtvk=;
        b=kMpx6TtnVWEdYs1AQ96bVuSEODhhUPITpLAh8eFTOcMobFFo36+rv6QUjXE1Tl05wd
         m+uzeN7y7iTELNMVMGBjz2t00wTHTZjMMN9qmtQnpH47P+RMi1eSM9zqcvD5/E5MFCcT
         r9DXx78lmCBnmed6X6PQ2bhYnerERvckeiYbi9DbFQ8WobduIKDgugboIi8/IY9w4q6k
         df8PZ2SxOOw8r665jghT36sqlvu9JeVO5ogIoanJy7Bw72oo4fHnEGZYXS1AcSxsp3Hh
         cFCq/6STeJgn1x4Kx/Br9SuHv4CLQy6ir8mMC+u15RHK4nhcWzQICmpbUtlSFNcrt6oP
         EGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8rqsXgaLu9l4H6DwFqTyXA9ldT3ZN1SoeT+u6bwBtvk=;
        b=YI3pv54LVjC4BBeEKXkvjkORSsH7agMCaB4zD4ZGnPIb1vZKo7sjIs7LBrzfHP1Nl8
         8ht0YpivCNU4AFjV/kM+YE17pz/D1lDzGggnn4UxXy+fUztWcIRQ4m85cbUFik2ltOmM
         BCYwcu56toddJuebJLQv2zEd+w/9ghskEAhpfWGUhrouVw1PMw+ij+DDKFCpO8MQAKff
         vFDdCP+zQUQ6nqZLhgGSTYyKrdedsP2OQ0SX3MZR60CC2yYv3W/4yomnJ1vWjXHSMMi1
         A8iIuOTbaYIFrE6sQMNtnk/6JsnPc8ZQJ6ck0FP4kAsZ5lRehQDVuj8l7oJW4Qh/QdRo
         Wo0w==
X-Gm-Message-State: APjAAAUJMs6E4WYrsRW0GPpsChjvMJVMGPHJpsCbe+rSqb/agOW5lKai
        mBbPHpUpRcMbYuR5CQ+5pPVfYorYylbj8Q==
X-Google-Smtp-Source: APXvYqyx+TnOMq0zwLjrLEDmte92On7BEzuKG741JmucubR6QxE0x6Y4JgvaY/8Y6pzGQzKJxTEfMA==
X-Received: by 2002:a05:6830:1107:: with SMTP id w7mr187610otq.14.1554304571137;
        Wed, 03 Apr 2019 08:16:11 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:1876:bc0b:8981:17be])
        by smtp.gmail.com with ESMTPSA id w141sm6806333oie.1.2019.04.03.08.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:16:10 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: mt7621-mmc: Use DIV_ROUND_UP in function msdc_set_mclk
Date:   Wed,  3 Apr 2019 10:16:08 -0500
Message-Id: <20190403151608.27326-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DIV_ROUND_UP to make code simple and more understandable.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 4b26ec896a96..b12ed2c988fd 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -240,7 +240,7 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 			div  = 1;         /* mean div = 1/4 */
 			sclk = hclk >> 2; /* sclk = clk / 4 */
 		} else {
-			div  = (hclk + ((hz << 2) - 1)) / (hz << 2);
+			div  = DIV_ROUND_UP(hclk, (hz << 2));
 			sclk = (hclk >> 2) / div;
 		}
 	} else if (hz >= hclk) { /* bug fix */
@@ -253,7 +253,7 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 			div  = 0;         /* mean div = 1/2 */
 			sclk = hclk >> 1; /* sclk = clk / 2 */
 		} else {
-			div  = (hclk + ((hz << 2) - 1)) / (hz << 2);
+			div  = DIV_ROUND_UP(hclk, (hz << 2));
 			sclk = (hclk >> 2) / div;
 		}
 	}
-- 
2.17.1

