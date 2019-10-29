Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A454FCA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AEF20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVACzUz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfJ2DVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 23:21:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41171 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfJ2DVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 23:21:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id p26so4338432pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 20:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LR/aUnBa1iOG11/R57xuvDj2bw8xBBwQLIyehox+hYQ=;
        b=fVACzUz62yAgAZzCMpuE+qtQ6Z0iCAc0Y7g+Nnqh5pg83Kh9rzxW8l2GI7qN2LiUWO
         3Gr8YM+gVikDS/RVHO9gaEx3czDXHRuO8qV91Bh4CG3jJNFxave6xYRfYnVZf94T6geh
         FYwaVkkHTYbkZaWDYW0eeMvB8l5IDJR4BrxLLFrR3A+swfiD8NJnvOhH4Mt9P4huHHoJ
         h1Fu4pFIWAE3jcGUEro6fhXOkEjFuAWKDoU7tTXSnU6kS4NMjGOt7X0nKS+t/+kj/qLx
         H5fkojw/KDrTM3VpfB6Wl57SuifZoGqv1/7YsBzrehxW1eLzM1QBWtYaXicDFa2XI9fI
         lRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LR/aUnBa1iOG11/R57xuvDj2bw8xBBwQLIyehox+hYQ=;
        b=d9cWUMDZ1tMmlgvYjRD1tUfWZPDbFcQhpvxAOCKs/vJdhH+Ay1L704mEgJFJTupGIP
         fwCZr0bcgUn/7KGbEnTARV05Vur881RkFQ3WfBDkDqXmARICkhbEK5s1EbzXz27GNDNI
         NyGRpQMoj1E0f4HA7CiJGMmm+A6CdPyWNNvhsBVAVtTNXYXn6MltjsYsXBe2/qy8jflu
         3UESverItzMwg0ew3eX/++Hg3OyDTZ+9uHw8P+iUC+OOGmeQ7xqNFMCXBycy24SISG9W
         xkojMYrdMTRqNdSNLSBJkhc3KzaXSrLQI65t46GNhrkIDIa0tsmFldlTBXul7Y4qhcOV
         hXgQ==
X-Gm-Message-State: APjAAAVZTekGrtWKzsXMKwsuRZ/h/clAp2LXF+VhPlzGymeHb8iQaAGW
        NIbPd0C8UfzBYq2V5F6A/3Q=
X-Google-Smtp-Source: APXvYqyIAsC+K9MsUK+66FRnvbVhq/0Ce7vcczJhLyl13Eg7tdplx+xI5xpMotaKwEsxbbXZBCamkw==
X-Received: by 2002:a17:90a:a598:: with SMTP id b24mr3409701pjq.46.1572319311860;
        Mon, 28 Oct 2019 20:21:51 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id j126sm13359276pfb.186.2019.10.28.20.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 20:21:51 -0700 (PDT)
Date:   Tue, 29 Oct 2019 08:51:42 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     linux@armlinux.org.uk, joern@lazybastard.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        saurav.girepunje@gmail.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] mtd: devices: phram.c: Fix use true/false for bool type
Message-ID: <20191029032142.GA6758@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return type for security_extensions_enabled() is bool
so use true/false.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 arch/arm/mm/nommu.c         |  2 +-
 drivers/mtd/devices/phram.c | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 24ecf8d30a1e..1fed74f93c66 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -56,7 +56,7 @@ static inline bool security_extensions_enabled(void)
 	if ((read_cpuid_id() & 0x000f0000) == 0x000f0000)
 		return cpuid_feature_extract(CPUID_EXT_PFR1, 4) ||
 			cpuid_feature_extract(CPUID_EXT_PFR1, 20);
-	return 0;
+	return true;
 }
 
 unsigned long setup_vectors_base(void)
diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 86ae13b756b5..931e5c2481b5 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -239,27 +239,26 @@ static int phram_setup(const char *val)
 
 	ret = parse_name(&name, token[0]);
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = parse_num64(&start, token[1]);
 	if (ret) {
+		kfree(name);
 		parse_err("illegal start address\n");
-		goto parse_err;
 	}
 
 	ret = parse_num64(&len, token[2]);
 	if (ret) {
+		kfree(name);
 		parse_err("illegal device length\n");
-		goto parse_err;
 	}
 
 	ret = register_device(name, start, len);
 	if (!ret)
 		pr_info("%s device: %#llx at %#llx\n", name, len, start);
+	else
+		kfree(name);
 
-parse_err:
-	kfree(name);
-exit:
 	return ret;
 }
 
-- 
2.20.1

