Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77354C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D92229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twS3XVK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfGZKRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:17:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45396 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:17:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id x19so46889086eda.12;
        Fri, 26 Jul 2019 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIW+FFTWXaiuRYtfslq3zFPbdDme/ZwvYTYRB/tpVEg=;
        b=twS3XVK3y0OK6TqT8Tj6MgUAXBj91EVduR7QnQwsehTM4RzIWbls07XI8RhwBc0WRo
         3Op4+qfw1r7rf//s3g/8y/MJhfXLyltZkkuAgwwJdjyyfNJ7GYfsBjUCytHIBADdNsoc
         oTxbiJn2zzeJ6UdXeZ/6b97AcSHQxASlDI9UaFdLBUDyBa/YB1ot1HSvU4wndtoOK7cu
         TSbXZp1wt39xocjRDgYePMK0J65geEonzjuYKgFQBxiYGM9zapHF7ioyEWTxB5K+0o8B
         IPkmYlDWTDW+28rsSQpkPsVtjo5FZArohmhGMUvvElTOxGG+oKfeP6fEmPVgGwAyVHp3
         QbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIW+FFTWXaiuRYtfslq3zFPbdDme/ZwvYTYRB/tpVEg=;
        b=sVZg6mM14jnWMHeJ4Pet+fkFXy1AhCIZkwl+DZ/5XIORZRcnLwlOKfCdhJJCyOEMfq
         1BVAZYNaesc9KaUt3Eyh6EQfiji+tKGgZKCd81KG4K2+fG6OK732n/Tk4d2XLGgB4/8S
         VseHFNiQT8Okp7OVx0RRLoB4i4QBsqldfHtv37xtxjSJAZUjEm2yS3VTphy5Ue40qS5c
         5354jRG6r6I50Vhvk+hKmV0OHF7xpt4dTTYzUw5B7jegI/rgAGRksNExCvyyX8R9pQnA
         kMcVUTPVE8s1bswTGSXFI6doj6zAGJ2+GiSX6QPrsIEgnsUhNWA4P9dji2JvZj5X8tE+
         JNgw==
X-Gm-Message-State: APjAAAU84++gASsdHSozE5a6FCCW83+4YHqOV3XdumOMtypaApSGdzQs
        15pBblh/38yk2t7mIsRY0zw=
X-Google-Smtp-Source: APXvYqxcoqrKLyf4ICIB9AIGJ/3BmTrXrKSxEj0dbe1Xx7B3XOdwnHazDmK6N1tnwkKkBARPVm5eSQ==
X-Received: by 2002:a17:906:fd5:: with SMTP id c21mr72474499ejk.135.1564136265525;
        Fri, 26 Jul 2019 03:17:45 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id o21sm13534340edt.26.2019.07.26.03.17.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 03:17:45 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: Fix typo in kerneldoc
Date:   Fri, 26 Jul 2019 12:17:44 +0200
Message-Id: <20190726101744.27118-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

"Findfrom" is not a word. Replace the function synopsis by something
that makes sense.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 0cf857012f11..844f89e1b039 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1164,7 +1164,7 @@ static inline int of_property_read_string_index(const struct device_node *np,
 }
 
 /**
- * of_property_read_bool - Findfrom a property
+ * of_property_read_bool - Find a property
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
  *
-- 
2.22.0

