Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF759C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF292082F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsSTWPP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfCXTVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 15:21:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33180 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXTU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 15:20:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so5955690ljc.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtmQdNoyZ6XU3aqih7G7eXPaXn9F7AT3DKmeTvKh3nk=;
        b=tsSTWPP7FTAPi7qKWKfSPGXQVPBlqQB5T/jA7Nn1AelxnU6ZtlwUgg57rZo31XAthJ
         hYe7I/CmalkKNwig9xtI6dnWOAuHRK/n67+bQhp/QVDCBAz10aXOHiW2UkgDr3lMtPFN
         vqD24eQS0KIbLc/Kf7mGoao9L5n2kBgrA4cCFkB/HxFHa8YgzLp5qy082Bt9KZnRI/gh
         G5Q/tDNJGtnNKx3Aemipzkl059ujHVjU+VXNgIKA6KuB4Z1YkasadTBHSwWTOxHhh2Et
         lPge/TWvhrHAQ+ed2dIu681grmWW4r2rxMciDW+FZHxLJQIaKePNPpc04v1iQLUvMWJe
         GepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtmQdNoyZ6XU3aqih7G7eXPaXn9F7AT3DKmeTvKh3nk=;
        b=Q7XHBn8ylaaourIlEsJn3sl9ug53Lf0++//6NCpAx2P3JGTFtQZTrsxW4x0Gv+P8vp
         L7YFB67cuC/4BoV27CrYmqFc1uzq8Js6vx9iWLPcGhqo8ku4YJnduCnpol+8MzTnqY0/
         +9V6xFfqnhXr3zBzseDFbgOiGBTJrbvi59HiZEFDK/3sveGNPveH8qcMMelaXv6eWLwv
         570AlQy+bSfQ3I9w9uZs25CA7EnHblpPscu382MZiW5cUdliEA3Lgse+nKwERQpHd5Ga
         z9c5GasE9aiaZHhy9wfEBfIIs5Iow1YyhLQ71XY96SKbXvGBDG0Tpbadomki+89EM5gA
         SpMw==
X-Gm-Message-State: APjAAAVdtAlFGzXZATzqpbcj8dRhMqLWhwJP4llWI9tQU1XcqE9AYNB2
        81gYxlQ+QwsObkH6iNBgAWM=
X-Google-Smtp-Source: APXvYqzsf+iK2bTJilLLzXPeieOJ9aB5OnSK/zaddL5rdRmbmM+inPGznvoiMIVm1BMT8BxMgXUU6g==
X-Received: by 2002:a2e:9c42:: with SMTP id t2mr10946088ljj.149.1553455258101;
        Sun, 24 Mar 2019 12:20:58 -0700 (PDT)
Received: from localhost.localdomain ([31.41.177.37])
        by smtp.googlemail.com with ESMTPSA id u19sm1751952lfg.74.2019.03.24.12.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 12:20:57 -0700 (PDT)
From:   Dominik Adamski <adamski.dominik@gmail.com>
Cc:     adamski.dominik@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniela Mormocea <daniela.mormocea@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Lou Knauer <lou.knauer@fau.de>,
        Bhanusree Pola <bhanusreemahesh@gmail.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ralink-gdma: ralink-gdma.c fixed line width
Date:   Sun, 24 Mar 2019 20:20:20 +0100
Message-Id: <20190324192023.3483-1-adamski.dominik@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch issue:
line over 80 characters

Signed-off-by: Dominik Adamski <adamski.dominik@gmail.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index dfdc425557b6..97dd2ca2d261 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -740,7 +740,9 @@ static void gdma_dma_tasklet(unsigned long arg)
 				atomic_inc(&dma_dev->cnt);
 				gdma_start_transfer(dma_dev, chan);
 			} else {
-				dev_dbg(dma_dev->ddev.dev, "chan %d no desc to issue\n", chan->id);
+				dev_dbg(dma_dev->ddev.dev,
+					"chan %d no desc to issue\n",
+					chan->id);
 			}
 			if (!dma_dev->chan_issued)
 				break;
-- 
2.19.1

