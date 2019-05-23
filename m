Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079BDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6F821019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="2CMbxjkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfEWMwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:52:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41633 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbfEWMv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so4303845lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ia7CedsVGwIb86j/mel4yJY3UB1AG6M5u+2ZXx5Hn7o=;
        b=2CMbxjkZ6LJd8gm7ntkrCQeJx7LqjcqwKEvmI5El9W4rTiP+Kxt1mKpNr90yXIVbek
         8bG07ZU3cTR+kx1TBFcGVZrSP69gNyPlZ2qiKfpJNeY0rJf8CmzQzYtvEXy9aIHfVXCd
         d9iJQ9JwmkoWOKX0dIXRQMUOG9yiMAuqNKqXA0RudMAjquOFTnyD0/QhUj5+rYxj/xAl
         atWZW5QLBsUxWDM9Tdr4IKAxw0O2681lJY/+Eh2zfTLqwA8CHOHFhJXjrtRXYnPky6XU
         B+7z9+uJV7iqfJ6Tk1m3/z5ajyEY3FQNxR6z+Jcyqnid8BdlnyjOB73IxCo16bBV+BZm
         MMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ia7CedsVGwIb86j/mel4yJY3UB1AG6M5u+2ZXx5Hn7o=;
        b=O1U5NpTb6CFVqA+tQsZJLyOcHPdvRSGoy5tNNSr19lPh4A55VUuDVAnaueQwGuGvQN
         NrAwBht4u/v0Bjb75Tr2iHSknudfdoMTZn1vE7NS43OKH5w2t5lIbY1ch9maomstTjBs
         bwfnN6BaohMzAZjJhcIl3GvjbbAa98eT2zxy1I12wEkcfK3XOYMu4okLs9o1AcV5VqSR
         yS4y0xVRLQ+lB8+iE4dZMX23IZRQ9VAtlIWGl87J4ksFq+eeWSgNaeOLedNvuNdwooql
         IQ9sG8RWrLxI/jwdbfQTxFr/amUzqQDXWvPEGpIygkcO6qqrS3bFTl+pEho5k81G4Gf7
         bGyA==
X-Gm-Message-State: APjAAAXmyBzh26cWgAgF0+XKSdQoQpc6bsFsZ+RgDDwrGSfkbpCclWij
        jai93cTRNHggQgvHCu9G9TP8cg==
X-Google-Smtp-Source: APXvYqyMpM8twI2730Pqo6Oq0I4rCKeDxFMN5e3PhGc9TPfyniD1qBb8sI2/114nfDhBVeRVn8+3Gg==
X-Received: by 2002:a19:be17:: with SMTP id o23mr21838119lff.170.1558615915079;
        Thu, 23 May 2019 05:51:55 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:54 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] staging: kpc2000: remove unnecessary oom message
Date:   Thu, 23 May 2019 14:51:43 +0200
Message-Id: <20190523125143.32511-10-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523125143.32511-1-simon@nikanor.nu>
References: <20190523125143.32511-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Possible unnecessary 'out of memory'
message".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 5e65bd56d66e..f731a97c6cac 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -291,10 +291,8 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 	dev_dbg(&pcard->pdev->dev, "Found UIO core:   type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
 
 	kudev = kzalloc(sizeof(*kudev), GFP_KERNEL);
-	if (!kudev) {
-		dev_err(&pcard->pdev->dev, "probe_core_uio: failed to kzalloc kpc_uio_device\n");
+	if (!kudev)
 		return -ENOMEM;
-	}
 
 	INIT_LIST_HEAD(&kudev->list);
 	kudev->pcard = pcard;
-- 
2.20.1

