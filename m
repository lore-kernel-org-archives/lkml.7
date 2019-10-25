Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F95FCA9EBB
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB14621929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYJ6J557"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfJYAX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 20:23:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46741 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfJYAX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:23:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id d1so589198ljl.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 17:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2fgicRSBCHO3h5cuJiqh9yLktldXuNEsASbg79hEk8=;
        b=vYJ6J557hoJJf9Rv4HokILjRkJ+cnXH4bg8uA6pK7pZdKY6QC819qqBomX+a0BXBYb
         EGIxj5ws4QzfaxdBaam30tX3pAKU1N7JJpqo3wB9Ho2cXd18o1VhhPEWaiy0KD5To32e
         piM3SJ7OlsLJ2FpfV7n+eFwH0G6TIKNlMYxQ0zPEMum+hW4XJ53DAZRz2trsn1QX4vu2
         CNJWJD36GVyNSuk2mq9q3fRz7Mev/X8KgoT3IL6I25Veq/7pVep4ac/2vsW0ZoZj7tTp
         QFqYGK0bmW+odytuX98jpSuqCeaTWn54vuRq/0scNhT0S/POWAZVcve0FGP7TrQ+pUd2
         Vc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2fgicRSBCHO3h5cuJiqh9yLktldXuNEsASbg79hEk8=;
        b=Ejsp3Ju7UQTZFT2Vqmqhm0fm/VXf7XplaTemMiP6mCsUWhbvGKElb8M8iNGfTGub02
         pxQmh0wS1DNuYIjutXKa136bFW/g1qc0KimAT2vOKeNpBQtEGcMp35QCZLjbNEyI6BDO
         6WaH9x4DL55twU8o/UvN3/7mESt23HM4LLJe7xaqOlu+0/nExFK7juA2fHYoH96dVvw3
         cz5mgtOnnsFgi7gUh0DlsTtWfIvMAgbNLN4OxyBaRXxJ0qIOPCgiY4zH+P2eW/xWDBmM
         Zo1RabHYOpC2Rig8LgHrz1utCBwaoVGL+e0ar4h+cmuCp4PExiJLeHpD6PY6LXhnLWTN
         rLIw==
X-Gm-Message-State: APjAAAVSwuuW3FYJ4fCLn1OVXjN7tFXqSdWCCGRV9OWMIHOVgl7Fzte5
        tY2qNEDMa+xLAfMTs+kwrj5jQRqy
X-Google-Smtp-Source: APXvYqw1plFLNKSTv6b0KToqOaCpldy26Yf73Urft7pocbcLMinonzehmXFFL1soRW+ToKiWJC+7Ow==
X-Received: by 2002:a2e:8694:: with SMTP id l20mr282249lji.64.1571963032967;
        Thu, 24 Oct 2019 17:23:52 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id p18sm78949lfh.24.2019.10.24.17.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 17:23:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] regulator: core: Release coupled_rdevs on regulator_init_coupling() error
Date:   Fri, 25 Oct 2019 03:22:39 +0300
Message-Id: <20191025002240.25288-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes memory leak which should happen if regulator's coupling
fails to initialize.

Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a46be221dbdc..51ce280c1ce1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5198,6 +5198,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	regulator_remove_coupling(rdev);
 	mutex_unlock(&regulator_list_mutex);
 wash:
+	kfree(rdev->coupling_desc.coupled_rdevs);
 	kfree(rdev->constraints);
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
-- 
2.23.0

