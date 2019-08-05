Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2E1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A467220B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMyVun8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfHEMWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:22:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45315 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:22:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so39554155pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3yEsJczZk4ZuqdPDx5JLOGIqCT05A22pIoztZy5LD4=;
        b=rMyVun8jDU5nU4z8IENdJOaneaQw2J+d+Rg4cXCoDHJIjW1njTpAtZXF5GaEFM7YjW
         AIdf1IzEpBtCP6i2ZyH6JWV+KUbSr4xUv9P8ThS3WkjI2D07VeCBjG7glClOCfW7rlLJ
         4OGXgRd1fujoEHSLpOiXO/5IeIliDP4rCRWl8ikeaXrbKJETMzDdkwtbQVCFKxV01p1b
         wiu4xyCJyNK5sNHw+znCtjvNd68vVsdHS8iyOHr5YX0hSN1h3p5sqlA/iOaOBgideP8e
         ZkIzQ1JMkd6UV7W1H8JYhjhE52BADcEbWxMFjHr/H5jTm+L1cmsqe27IIB/wJm0oPzfc
         gTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3yEsJczZk4ZuqdPDx5JLOGIqCT05A22pIoztZy5LD4=;
        b=fYXbkH0i7P0fInZputcNdGFwlKb9Jl1/xNZASYafX0B/8WJf1/xS9qA48v1VA+1n/F
         FsWHZHiUCCLSPz1QHlQjKTowHWEidYkVcMI1i70ob5jamOQ4/2xiyVYGxPagDURKPum8
         Afj2UIhnh6wvYLm/Vsmu0a1an30sbkgri70kbJD96L/UxamXEc19lkTXTb4cl3HLynea
         Af2XctH7QswMxYmJjKfcQBClP4D4gtCokqxH5VKXwqFHc2II8GzKcZpfyztA50ydSNRK
         KUfMgY9dfJgvnTIl9rYublhLrCdOawavJz4VODheYAEGPtpBFNXYRBRkihPNQAMWALqG
         8whw==
X-Gm-Message-State: APjAAAWNWSXMzZc6vpaEvCEKtTKOMT0JmSVO330jdmIV5RpPPFLPUyqs
        kPwvbFJv3NilYzal0y3/5hs=
X-Google-Smtp-Source: APXvYqwogI/fnXLqwAApMoBx9T/YLbLHBkEj2sYreLJgL7EsGb4NcAT0guXujrbqomzYJYPxPETjNQ==
X-Received: by 2002:a63:cc14:: with SMTP id x20mr90544477pgf.142.1565007752637;
        Mon, 05 Aug 2019 05:22:32 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id a12sm12472578pgv.48.2019.08.05.05.22.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:22:32 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 1/8] dma: debug: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 20:22:20 +0800
Message-Id: <20190805122220.12878-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v3:
  - Revise the description.

 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 099002d84f46..0f9e1aba3e1a 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -970,7 +970,7 @@ static __init int dma_debug_cmdline(char *str)
 	if (!str)
 		return -EINVAL;
 
-	if (strncmp(str, "off", 3) == 0) {
+	if (str_has_prefix(str, "off")) {
 		pr_info("debugging disabled on kernel command line\n");
 		global_disable = true;
 	}
-- 
2.20.1

