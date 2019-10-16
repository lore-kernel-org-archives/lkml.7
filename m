Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F295FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C4E218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE7ppxxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437434AbfJPVHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:07:48 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:43915 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437424AbfJPVHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:07:47 -0400
Received: by mail-pg1-f181.google.com with SMTP id i32so15009744pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+P6zoyjsNb/VS3ZBuzpQC+S4mJFCQY0XUfEH02NQ6io=;
        b=UE7ppxxdryPBE2zx6SjNeB+5QulDkfR1ovQnseegKF5vFgsmGa/ANc/QaflOTZ3npn
         KPng2uRfrrn7YIbDM8qgr+yo1cNWQAxP6fz5fAdldgH2MN62rmRhvA26MwIB7mukNvE6
         LrLn2RqhlIOcGQQuOO6Epu87P4mJ9Dnd+HsxhtYJ9pprNHg3RQ6FjxwS74nGbAh2o6tH
         K1NRNulTp967QmGGby0gstmRDE1F0mmD27qdh1pJRURUuMpuV44ekagAitl4m7mXBUa1
         7U9p7qsTDYXNuo/CNhY3TmQj1TbnvgTsZwfcmanRMDE32QzWBr7Qvrdknd5Uzri4Sj4z
         xQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+P6zoyjsNb/VS3ZBuzpQC+S4mJFCQY0XUfEH02NQ6io=;
        b=Lg63YtGsetuyuZWOspbRI3Cx84s177/BdLpwRdTVvHJFAR/6ppesve2BFSpzYODYjV
         T0NdmyH6D/fb3oIPw19fhoQ4bZmutNeh+qOFP5nD7s7fhLxP3W7KQlWaZZfpdj/sfuzV
         pRpff7OmR5ExonrN4l+wP9C/9SlKytrJTVcjZpAE301g3Wgs+yvgs8b3A3d5Vc/X6l8Z
         Q6AxUpoe3QXdb7uamsGI9s5LVPwQAYzr4cIjv7hBaLYZu4gfm5qKtKCOWGDGmVr2og6Q
         7BQmwZlwDfmEvrMv9exvIGadRWO4t/6fdNVDu5JgM0kKmrBaJTFBjTE8/V1lTdO8cn0x
         FnxQ==
X-Gm-Message-State: APjAAAVOvfs4fqsXIW4FfvWHU+5YDiONQZ+TH1Px5R9TOTlxvPfcu4zQ
        kwszfXL5DSXYUMmKohXLNu8=
X-Google-Smtp-Source: APXvYqyKoxROinQUv0KAHvwbSn7AfQzeJgNCXd3y3Ue3tZOSSTPyTvJ1oxY6hpfKijnvck+xysNIvQ==
X-Received: by 2002:a63:1b10:: with SMTP id b16mr156761pgb.235.1571260066705;
        Wed, 16 Oct 2019 14:07:46 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id x11sm11613226pja.3.2019.10.16.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 14:07:46 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, mcgrof@kernel.org, davem@davemloft.net,
        Tuowen Zhao <ztuowen@gmail.com>
Subject: [PATCH v5 4/4] docs: driver-model: add devm_ioremap_uc
Date:   Wed, 16 Oct 2019 15:06:30 -0600
Message-Id: <20191016210629.1005086-5-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016210629.1005086-1-ztuowen@gmail.com>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
---
 Documentation/driver-api/driver-model/devres.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index a100bef54952..92628fdc2f11 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -314,6 +314,7 @@ IOMAP
   devm_ioport_unmap()
   devm_ioremap()
   devm_ioremap_nocache()
+  devm_ioremap_uc()
   devm_ioremap_wc()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_iounmap()
-- 
2.23.0

