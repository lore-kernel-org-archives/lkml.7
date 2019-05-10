Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E05AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11596208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hJK2C39x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfEJSCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:02:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38191 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfEJSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:01:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so3620503pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8L4t6g1MMgmlsaHY0e6N7Xo1SKsd8cjPTkUC58Khpk=;
        b=hJK2C39xO5Ilv/Uupip3egzE1IUcXL3ZRSutokIAs/B7U7ym/S1CsyIo9TLzItQkt7
         C1h/+lF5fiHZMFtUnPulWdQb9ZmV1Bcs5H8uZPrzN74AJtjyAX3EIW007+Hx46onbq+n
         2l3jWUDeYt9CGQr5PQmHo/ELDP7gjf0pS+EU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8L4t6g1MMgmlsaHY0e6N7Xo1SKsd8cjPTkUC58Khpk=;
        b=rdMsXgyXI/bVjoav0zhsz0ie4mXrCAxEPf3YWpsnlE/2LqgSvTRIpOuF2IPxj93BUV
         zYdmOGTtYRefH39PORLaI68Hy6RmaN+wsi/wUo0WPoCScI9jJY3s7cfvKkyCSWFLiF+8
         VvMB0SBNCVweJE45EED7TqyV7HagYM9bA62JUw8ihf140jCierHLl+siz6sJYeysbRE5
         ubCL3mEBT5GQ+gn1/bf72KGPNHwEA8Xe+VyZlm6HTeB1F8oaq3ck8kb95c4b7Lb4Jqcu
         VUd91vftNhsQptQPvdA2d3SzsDT1e8Q0L3H41m1UnYY35kajYN+cCOtBddV/PMfhgmHg
         MTwg==
X-Gm-Message-State: APjAAAXE1u5o4DiCNUVKvmWGMDbCmWby00RuYk+1MHC3Cgfqkj9Yrw4H
        XARqqWpKhjI4nx9HruDTGW1Cug==
X-Google-Smtp-Source: APXvYqyEo1Wl+TZo0VVNqqEXfhD2avi8eme0xm7S3SkY4603wFjie5uaqxbyD28g2zhb+GabVSav6Q==
X-Received: by 2002:a65:6490:: with SMTP id e16mr2705557pgv.13.1557511317035;
        Fri, 10 May 2019 11:01:57 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s19sm7556740pfe.74.2019.05.10.11.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:01:56 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 4/5] firmware: google: memconsole: Drop global func pointer
Date:   Fri, 10 May 2019 11:01:50 -0700
Message-Id: <20190510180151.115254-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510180151.115254-1-swboyd@chromium.org>
References: <20190510180151.115254-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can store this function pointer directly in the bin_attribute
structure's private field. Do this to save one global pointer.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/memconsole.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
index 166f07c68c02..968135025e4f 100644
--- a/drivers/firmware/google/memconsole.c
+++ b/drivers/firmware/google/memconsole.c
@@ -22,14 +22,16 @@
 
 #include "memconsole.h"
 
-static ssize_t (*memconsole_read_func)(char *, loff_t, size_t);
-
 static ssize_t memconsole_read(struct file *filp, struct kobject *kobp,
 			       struct bin_attribute *bin_attr, char *buf,
 			       loff_t pos, size_t count)
 {
+	ssize_t (*memconsole_read_func)(char *, loff_t, size_t);
+
+	memconsole_read_func = bin_attr->private;
 	if (WARN_ON_ONCE(!memconsole_read_func))
 		return -EIO;
+
 	return memconsole_read_func(buf, pos, count);
 }
 
@@ -40,7 +42,7 @@ static struct bin_attribute memconsole_bin_attr = {
 
 void memconsole_setup(ssize_t (*read_func)(char *, loff_t, size_t))
 {
-	memconsole_read_func = read_func;
+	memconsole_bin_attr.private = read_func;
 }
 EXPORT_SYMBOL(memconsole_setup);
 
-- 
Sent by a computer through tubes

