Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E7CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C906120862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1PKiPJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404333AbfJ1SHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:07:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34305 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfJ1SHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:07:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id e4so3113800pgs.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KooIewZwbvjOkWEaBdb5ogJ6e+TbvWJNeEYKOS8P4w0=;
        b=Y1PKiPJSo5cC4StnmwLOwPxBIOiH1/YjuhzkGWx/4kjWfWLT96mT2xSrwfVi7yHFEl
         Nh5NKHRthKhTX38td42WJaxB7C3k4RnOtzAnd/+cwXMPAkE3gXJcIgkRB0vVN8o9bcN4
         KAp7kN+geHLFssZe5717qy+JPk/T5xKxDrkTMcvlXZmievm/WR8G9YLZjh9nakfkEi8c
         DuqWxZHoTQVwkP3WRh337YW3LM5Mvc9mLDhNNXAY5c6wXqksrU5cSXZO2Ga09wU9SwfR
         LCosxU8Rahy9Gs3YHw1vnjY/XZ7JWwuSclzwONsO/L1nul6Ksh4YXaEw13q3UQ39M2GX
         TZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KooIewZwbvjOkWEaBdb5ogJ6e+TbvWJNeEYKOS8P4w0=;
        b=RgZh0h5ivQ73tZnpLSm1IGg07nxvHq9SBwghJiPNvdnaXKY6VybD1OvPe0bqvWjzeY
         yNlSCdNHRwvTLP8k1wga6Rb30T5+Btec7Yn5SEYsliDY1JLLSuzCOkyw9O+AuesuSg4R
         B14co3VGvBTwscviACiJasGV3/ogmslIv6j7b5dOF5nQNZqaxLy9voxTwpu7NaF6TMUo
         7s9O0QqWd4HoBL5MyKpynttCfrsaqRE4yZM/dpRlSR/002AjAf/WRMqX6Y72XEMyglZ4
         UF0a/bVaYXU/CHZLW9XSjCFW3kUjlqOoIoqyAgLLvnIR63aDSIftjv3cw5XkqOCVmRX6
         osKA==
X-Gm-Message-State: APjAAAVs4cvwpx8bRGr/iO9B8PaEJ4xNmtQlyGpOJHZj/+DPFa3ke8QV
        aG5+NNL+b0UjRhasMNUJ70c=
X-Google-Smtp-Source: APXvYqxbYQIyXuOm4thgIzsK1cAneqYYBmH5ZCOjF7KVYtMewLsSjXsd96H2cMKo8EN9gFEru5EWjw==
X-Received: by 2002:a17:90a:37e4:: with SMTP id v91mr773608pjb.8.1572286061510;
        Mon, 28 Oct 2019 11:07:41 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id i102sm168856pje.17.2019.10.28.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 11:07:40 -0700 (PDT)
Date:   Mon, 28 Oct 2019 23:37:33 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     joern@lazybastard.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] mtd: devices: phram.c: Fix multiple kfree statement from
 phram_setup]
Message-ID: <20191028180733.GA26168@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multiple kfree statement from phram_setup() in phram.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/mtd/devices/phram.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index c467286ca007..38f95a1517ac 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -243,22 +243,22 @@ static int phram_setup(const char *val)
 
 	ret = parse_num64(&start, token[1]);
 	if (ret) {
-		kfree(name);
 		parse_err("illegal start address\n");
+		goto free_nam;
 	}
 
 	ret = parse_num64(&len, token[2]);
 	if (ret) {
-		kfree(name);
 		parse_err("illegal device length\n");
+		goto free_nam;
 	}
 
 	ret = register_device(name, start, len);
 	if (!ret)
 		pr_info("%s device: %#llx at %#llx\n", name, len, start);
-	else
-		kfree(name);
 
+free_nam:
+	kfree(name);
 	return ret;
 }
 
-- 
2.20.1

