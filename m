Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8AAC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1421E25236
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfEaB0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:26:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36476 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaB0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:26:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id v22so4871908wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 18:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0sFJ+EYxI4EKJT8VIe7qCNZk0SzI2C+OaplHVJywBM=;
        b=MM3NZhkRqEZby7udov/nhFLbyXtzzG0J3WLVIf6e5YI159z/RwXAyoB5N2sABYs3oM
         H7z4jVqhv0ru+ajyvndAE7z3CHX1a06GRnD9rta96PB8mPzlKQNUxHbyLl0FzOIpiNwp
         4qHP1EUBlRbRKzuAxTByl35aVRrHb+NUJQWhEgnPrcIcGTiXLfMABC0pNW4/yfq0ZPrZ
         VDteNeAsvOrAGuDJaDc4Ck2KF6kadHRRnaMm5rypUjiJPlZyqjWDXtd1rWeqAet/kWYV
         8SYxOzScVe3C4fzKPRRvVKlopY35N3Co2fppkoE7AgtwV0mu0uUt1QXnVOrHcCcdviOS
         9ZAQ==
X-Gm-Message-State: APjAAAXwEueOkyK2PMBaXo4UmEfPudbNhr99dupf6YBojSVqVKe89lvm
        FiqMl6o6y6BGXvDmH8gXUuVkHKr6dhQ=
X-Google-Smtp-Source: APXvYqz33TlnS9lJU5GSsPlrA/xnXRVEIRnuRrWNZeVTUv4gIpAQ9xh/WGtitODQKx6ssk91SToWRg==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr2631741wml.4.1559266011769;
        Thu, 30 May 2019 18:26:51 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-144-152-91.cust.vodafonedsl.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id w3sm2974112wrv.25.2019.05.30.18.26.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 18:26:50 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware_loader: fix build without sysctl
Date:   Fri, 31 May 2019 03:26:49 +0200
Message-Id: <20190531012649.31797-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

firmware_config_table has references to the sysctl code which
triggers a build failure when CONFIG_PROC_SYSCTL is not set:

    ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x30): undefined reference to `sysctl_vals'
    ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x38): undefined reference to `sysctl_vals'
    ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x70): undefined reference to `sysctl_vals'
    ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x78): undefined reference to `sysctl_vals'

Put the firmware_config_table struct under #ifdef CONFIG_PROC_SYSCTL.

Fixes: 6a33853c5773 ("proc/sysctl: add shared variables for range check")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/base/firmware_loader/fallback_table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 58d4a1263480..18d646777fb9 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -23,6 +23,8 @@ struct firmware_fallback_config fw_fallback_config = {
 };
 EXPORT_SYMBOL_GPL(fw_fallback_config);
 
+#ifdef CONFIG_PROC_SYSCTL
+
 struct ctl_table firmware_config_table[] = {
 	{
 		.procname	= "force_sysfs_fallback",
@@ -45,3 +47,5 @@ struct ctl_table firmware_config_table[] = {
 	{ }
 };
 EXPORT_SYMBOL_GPL(firmware_config_table);
+
+#endif
-- 
2.21.0

