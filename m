Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B230FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F4C20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rf+FezEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437410AbfJPVHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:07:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33141 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437357AbfJPVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:07:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so15029367pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yhc17rdI0LyvCBTE9HyBQcBbUAfkKS8bzaH6Rt6+gho=;
        b=rf+FezEcwhwpMjDzpPnMW/BF/yazYf1PSyCfiji2/AbLzaWQVIWIhSZELKTf7CEkZh
         VANW/Umjp0+zU2Q5K1A09fjMgfDm+d7RexWVHTs1PGdlMveebQ47lRFGhfDVa9drY0lE
         AKuk9klps5TU8pG6jjgIsNKALSm60nQ/5XtNVhY+EvSNt8txBr/iypkz6U32PU+exFyD
         hyIuIoVBM+b9Lqbay3Cz1M4PNuW1XyjjShMDRGYvjMa79IvjUeWcKfFsU9zLvhwV1j91
         RO4nmmEkPkId3/E5l83h8Yai/w7AlNEwigT37nhBjuGZvYoWp+eBesjQaDzumiJQn/5a
         kF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yhc17rdI0LyvCBTE9HyBQcBbUAfkKS8bzaH6Rt6+gho=;
        b=BVW5MJ19PD/LY9y4QZneo/OJESw6cATVADXy57gm2Wv99qpKkOA4aeI/s3+shTOXfZ
         wa1LvmKy2WrKqFJNl5dDMtvUM+b8EJHCACEH7yFLHKc+GdEvlB2J9MYPi/d/KWlfM9cQ
         vWhPdeVy5UZm/G6d3tnvo/xk2PfwRfryskBHdtD3tX+kM8+W7t6MSwnuHGel/XvLLMLd
         U3ZxmuzR99eLGGrZ5wMmCAPPVziyqAYeTQfHFj31s56KIC36LN9MYZderwYOkjS4u2w6
         17NDx8LiWNILiGb05S7j/DqwLwCIvedKgZiFwAZ8LwaXl9KpiyxG5zvu6g/JSaOoDIcb
         otTQ==
X-Gm-Message-State: APjAAAV1ZsbuWXPerkhf71+yT6fxxNM59EXMs6maxoFpwdEOyIAF7Hbg
        Topm4XfIBQURsD659RKmVyQ=
X-Google-Smtp-Source: APXvYqxgkmgXKsj2mYuQCU41xLmYmTUcqDOP/NwRymkwdsw6F/Q+fEDyLc+dRgXELfLh2xlcHlNfeA==
X-Received: by 2002:a63:b5b:: with SMTP id a27mr192236pgl.262.1571260057415;
        Wed, 16 Oct 2019 14:07:37 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id x11sm11613226pja.3.2019.10.16.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 14:07:36 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, mcgrof@kernel.org, davem@davemloft.net,
        Tuowen Zhao <ztuowen@gmail.com>
Subject: [PATCH v5 2/4] lib: devres: add a helper function for ioremap_uc
Date:   Wed, 16 Oct 2019 15:06:28 -0600
Message-Id: <20191016210629.1005086-3-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016210629.1005086-1-ztuowen@gmail.com>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a resource managed strongly uncachable ioremap function.

Cc: <stable@vger.kernel.org>
Tested-by: AceLan Kao <acelan.kao@canonical.com>
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/io.h |  2 ++
 lib/devres.c       | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index accac822336a..a59834bc0a11 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -64,6 +64,8 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 
 void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			   resource_size_t size);
+void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
+				   resource_size_t size);
 void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
diff --git a/lib/devres.c b/lib/devres.c
index 6a0e9bd6524a..17624d35e82d 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -9,6 +9,7 @@
 enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
 	DEVM_IOREMAP_NC,
+	DEVM_IOREMAP_UC,
 	DEVM_IOREMAP_WC,
 };
 
@@ -39,6 +40,9 @@ static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
 	case DEVM_IOREMAP_NC:
 		addr = ioremap_nocache(offset, size);
 		break;
+	case DEVM_IOREMAP_UC:
+		addr = ioremap_uc(offset, size);
+		break;
 	case DEVM_IOREMAP_WC:
 		addr = ioremap_wc(offset, size);
 		break;
@@ -68,6 +72,21 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 }
 EXPORT_SYMBOL(devm_ioremap);
 
+/**
+ * devm_ioremap_uc - Managed ioremap_uc()
+ * @dev: Generic device to remap IO address for
+ * @offset: Resource address to map
+ * @size: Size of map
+ *
+ * Managed ioremap_uc().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
+			      resource_size_t size)
+{
+	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_UC);
+}
+EXPORT_SYMBOL_GPL(devm_ioremap_uc);
+
 /**
  * devm_ioremap_nocache - Managed ioremap_nocache()
  * @dev: Generic device to remap IO address for
-- 
2.23.0

