Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC5FC74A41
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FE520896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfGNMCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 08:02:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44260 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfGNMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 08:02:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so6905464plr.11;
        Sun, 14 Jul 2019 05:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=limhfPU+A9atVqhjrXoRTHVUj/ZAq4Mas0vu8xdEgl4=;
        b=SCdbBghuO3rnNCJDYqnbUb1chWn44CxNhJ/cv2ErFKU6SZD/JoLaOp/PLJlNdZ1DHI
         E+zPGX+rVn8tLeFHsYDP/hFkA0dVNdR/fMph5TyljbymnHSrMvyDparCy2NbjaaEqpLy
         bfxEQXw5yqmEm4M5CRPEq5xVTY8o+cBm8Y4cN9x49yeTSAZ2ynABTwWOOig8Gtc02g0U
         oz4wavmctMGTk/tuTdxvJbVCyU9iQ1885LJ59My0M4tkGuYCStFygODz9+qm57L9sJbU
         GLPu3AWs7i1mJZaHDoxzh9J22zlLRRQLHFS7C+r9S2V5gETCwqKiOqcGQBP7nwWkwO8B
         codA==
X-Gm-Message-State: APjAAAVc5PopNABS3bzTXrcqelvZPhU9YFpwdgoz6dyWfp7fkkX2KBSd
        alyfJ6fRSvbiZmRFA6FVGww=
X-Google-Smtp-Source: APXvYqzSLlOEwTVdKntftT7j7TPUdQorCgYrKIXpC5tQxhdh+4AM/Zj7xGtG6xJfZEqbpNfKeEJ8Xw==
X-Received: by 2002:a17:902:d81:: with SMTP id 1mr23356458plv.323.1563105763620;
        Sun, 14 Jul 2019 05:02:43 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id o3sm32215200pje.1.2019.07.14.05.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 05:02:42 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Catherine Sullivan <csully@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Sagi Shahar <sagis@google.com>,
        Jon Olson <jonolson@google.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gve: Remove the exporting of gve_probe
Date:   Sun, 14 Jul 2019 15:02:25 +0300
Message-Id: <20190714120225.15279-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function gve_probe is declared static and marked EXPORT_SYMBOL, which
is at best an odd combination. Because the function is not used outside of
the drivers/net/ethernet/google/gve/gve_main.c file it is defined in, this
commit removes the EXPORT_SYMBOL() marking.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 24f16e3368cd..e8ee8cac2bbf 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1192,7 +1192,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_disable_device(pdev);
 	return -ENXIO;
 }
-EXPORT_SYMBOL(gve_probe);
 
 static void gve_remove(struct pci_dev *pdev)
 {
-- 
2.21.0

