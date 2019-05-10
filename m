Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8DFC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D223208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XUIUURZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfEJSCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:02:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39964 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfEJSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:01:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so3617680pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/3h1kMbNsFz/9Ja/3wNgp3lXv+K0KmnTBsVELfUR00=;
        b=XUIUURZH2RPIOEBY4ZT6CGvC2zPBAvX/JHtr/s0Oqb95aYCoTcPMJKyzVxcsnTACkt
         Eg1REMjQkhu+sjucVhtTTSeEh+WDjzJ038G7pv6W4t0mjNa6ECQm6HnYxzxUCnbBgC11
         4y/xA3G9ozFmevuQVAaHSFWolEd47L+NZNzG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/3h1kMbNsFz/9Ja/3wNgp3lXv+K0KmnTBsVELfUR00=;
        b=tph+CXafzL7rbtUrsODTroV0i1TLvT/f2EXNMuTNy0iD9QW47tPnfKkiBUkNpaGRpk
         NKWefl2PJYbgJEuaNursmnVJizIvgrtAtqm1xc9At9ZSgEHA210cAfIkhbwMNCPFNXZ6
         HJGNnkFf4vyKvKlHvrZZqb67m7vsbnCv8afBVgq1moTD8YcU6AX/OVnW4F81Rz653nqt
         ncYkmSOoh7zGW6MyjCAH6Xevc9xqg/DnmlYT3ACZ1GGwAYZZpAL1Ep1WdXsC4dWq/MgR
         83z98OfeQygolGWCMWbaCYoPCMyPjCGiQD9vkrHMm98WVp7YyCSNrDbu4nfnXyr52AH4
         pNNw==
X-Gm-Message-State: APjAAAW4JYmo2xHHGC0JcLBDWlf7kmUSwS6hq/w5AX+6NNJpebGKX6ko
        YnKsIf9kdVQOxdMxb2PKjJX1Ng==
X-Google-Smtp-Source: APXvYqwkVSOjKCq0csjOxv8s6o/riJPm0RfFeBQfGBL+YUW5dQowt8Ucunt8Ax6o11zntjiuvhh5jA==
X-Received: by 2002:a62:2b4e:: with SMTP id r75mr16139959pfr.131.1557511316262;
        Fri, 10 May 2019 11:01:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s19sm7556740pfe.74.2019.05.10.11.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:01:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 3/5] firmware: google: memconsole: Drop __iomem on memremap memory
Date:   Fri, 10 May 2019 11:01:49 -0700
Message-Id: <20190510180151.115254-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510180151.115254-1-swboyd@chromium.org>
References: <20190510180151.115254-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memremap() doesn't return __iomem marked memory, so drop the marking
here. This makes static analysis tools like sparse happy again.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/memconsole-coreboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
index 0b29b27b86f5..ab0fe93b88ad 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -34,7 +34,7 @@ struct cbmem_cons {
 #define CURSOR_MASK ((1 << 28) - 1)
 #define OVERFLOW (1 << 31)
 
-static struct cbmem_cons __iomem *cbmem_console;
+static struct cbmem_cons *cbmem_console;
 static u32 cbmem_console_size;
 
 /*
@@ -75,7 +75,7 @@ static ssize_t memconsole_coreboot_read(char *buf, loff_t pos, size_t count)
 
 static int memconsole_probe(struct coreboot_device *dev)
 {
-	struct cbmem_cons __iomem *tmp_cbmc;
+	struct cbmem_cons *tmp_cbmc;
 
 	tmp_cbmc = memremap(dev->cbmem_ref.cbmem_addr,
 			    sizeof(*tmp_cbmc), MEMREMAP_WB);
-- 
Sent by a computer through tubes

