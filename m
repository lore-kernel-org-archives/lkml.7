Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B57C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D47A213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cA3DlSIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfDAIQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:16:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46622 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:16:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so10665374wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Xqg+mpbzX662BOIB5egaBo3eavFrr2lMdlCkBB24Ak=;
        b=cA3DlSIs4iKmA92yHvYXiUkmMh8rv+fUULaEO2acGA/suVoK5jLFQehfi/ZljKxtZ0
         lWB+BihnP6dEVuW/48A/jWqMtzhuYm7JryLY3Edssk9VFN5nixfQrSZPpT0oqjlQ3jMo
         KWEzafCVvpwd3nqxrkkCiZjxnzMypsO3Uyf7mI9vpW8GvD86ojwQ9UVGgyISEWOVL8NP
         yp9T3Dr/vH3DaiJ0yHHag+NODA7njWJDOY3ggxtR/QtiVaRxu++R8HlfDNiy1jlUEcMb
         qz2kvaO5uJmZFnqESku2j28wKxC16eCJlU8N3Y7EwP1zxyJQ8hCdk2ltfi+kLmFAc6P+
         lXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Xqg+mpbzX662BOIB5egaBo3eavFrr2lMdlCkBB24Ak=;
        b=UYvPXU97NZbjpQQO+N7bTVLM/aUVWbH2UBok+pUPF/1Oji+v2GFzApo68tKc5L0QE6
         SuFeJYp8zv0NX6UpUWNYdimv9EYeeCiRcyJLeJ5drVqibqH0o1lVWwf6sjXm3PbAxGwN
         n/ItneDgnir5iGbDogVu7P2M7bDnISwaMIvRlXEcRbCTABg7oRzUj/7FSIIUL4rWj7eE
         Oz99wvX+QFjjyxrXI/9jF6qJ+h3D6Xae7PmiF/qN2JJZz0ALRor6luPkllPhj3Ic8s1G
         D1g/Z3D2l8EBq4/gvP5meZSKzV/DPU0XkhQ6Svw575Rda/pcC2XIHczr+N8g+5b6KeEI
         9HCw==
X-Gm-Message-State: APjAAAX57uU2uihpovMTi+LHbaOoBB47FB6Nb54IHVeZ9EdNS22lkCR2
        9ODwOgqdqqG9eKKmb4IroIdb7Q==
X-Google-Smtp-Source: APXvYqy6NhEaxqDywWXfnRnRLCLtBeG88Qrk4WrFvDTBSYI98XxylZxqc+biIN0vN9uqdGmhWb2zMg==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr28489424wrs.250.1554106600362;
        Mon, 01 Apr 2019 01:16:40 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id x205sm5286591wmg.9.2019.04.01.01.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 01:16:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] drivers: fix a typo in the kernel doc for devm_platform_ioremap_resource()
Date:   Mon,  1 Apr 2019 10:16:35 +0200
Message-Id: <20190401081635.18673-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It should have been 'management' not 'managemend'.

Fixes: 7945f929f1a7 ("drivers: provide devm_platform_ioremap_resource()")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dab0a5abc391..09c00d91094c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
  *				    device
  *
  * @pdev: platform device to use both for memory resource lookup as well as
- *        resource managemend
+ *        resource management
  * @index: resource index
  */
 #ifdef CONFIG_HAS_IOMEM
-- 
2.21.0

