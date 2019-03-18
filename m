Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B97BC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5782133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pgd8pnzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfCRTlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:41:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbfCRTlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:41:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so11949196pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZsNEBezwmWs+YHZ6kfp16NA+EJPEx0i92YAVIIqyYc=;
        b=Pgd8pnzXugLHCCl+d2M1IecEaS/ImA4wWVgjaB4vxHcRwkEtBcuXrfDlcKee971Esm
         b55hB49pYvY8zzN79jMbB2A5ldYWTsZwl1723dUEuz8gvZiNcwxLbgglYhjOmG41FrAw
         YH7v4VitON/3LTl+8m+tJIQUT1kCiAzgiC9eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZsNEBezwmWs+YHZ6kfp16NA+EJPEx0i92YAVIIqyYc=;
        b=qkIiJGPYi+j2MOjaQRJxXrm7nyLEnWVjlXSPIc4HbYirq727+tV9Avkd9NeTbCt1dS
         cWBrr4YRMDwfi5JUlscK9tUbkB3pTYD4vfWH721p+YIpaVNZ8F9KGFpFREl3Mh9RnjmX
         uaRlt+Do6dnpt4sF7Gkh1Ng6brrEpgRFcoS9IEBUKOg8qv96vWA4Y88IxLHXGj+Z8t7I
         upfjLjH5kSius9oHCSh3VkJTw5W/i44z2W6iCFxGTtrwZs6Q0CNaB0rBYHH7Gy/UtbAq
         zgexiVrEQfADkEmocys+0QZjqOZSZ/L+HXXaskHjhEI9wOa8EIAJjoepfn2oyzyIMrY/
         5iBg==
X-Gm-Message-State: APjAAAVFTVansUvTmQs0R6vEGHI4xrhfUV6OP5Ks8NfwkbRCinE3iDIL
        PZND+iYaAhiThSUmtMOEVOjlZQ==
X-Google-Smtp-Source: APXvYqxEoFBQsThYkhYZZlIwR/gEwdRO4h3jDC3E3KJsZ7aiaZUC1ycfBc68sRZhJ+/+2N5CCQkZFA==
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr21161211plb.59.1552938078260;
        Mon, 18 Mar 2019 12:41:18 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 138sm16336082pfx.93.2019.03.18.12.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 12:41:17 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH v2] firmware: vpd: Drop __iomem usage for memremap() memory
Date:   Mon, 18 Mar 2019 12:41:16 -0700
Message-Id: <20190318194116.212620-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memremap() doesn't return an iomem pointer, so we can just use memcpy()
and drop the __iomem annotation here. This silences a sparse warning.

Cc: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Added RB and fixed signoff

 drivers/firmware/google/vpd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index c0c0b4e4e281..f240946ed701 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -254,7 +254,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
 
 static int vpd_sections_init(phys_addr_t physaddr)
 {
-	struct vpd_cbmem __iomem *temp;
+	struct vpd_cbmem *temp;
 	struct vpd_cbmem header;
 	int ret = 0;
 
@@ -262,7 +262,7 @@ static int vpd_sections_init(phys_addr_t physaddr)
 	if (!temp)
 		return -ENOMEM;
 
-	memcpy_fromio(&header, temp, sizeof(struct vpd_cbmem));
+	memcpy(&header, temp, sizeof(struct vpd_cbmem));
 	memunmap(temp);
 
 	if (header.magic != VPD_CBMEM_MAGIC)
-- 
Sent by a computer through tubes

