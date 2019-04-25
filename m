Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BE2C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC563212F5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrLE8l1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfDYNal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:30:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33975 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfDYNai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:30:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id h5so17516758lfm.1;
        Thu, 25 Apr 2019 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNFirraLM7s7j9AxHTJl4hrxwW7TmyqVI4M5YpiegmQ=;
        b=GrLE8l1mB8/Ns8BSizCMIvBMrnUj0jRKn1jlhkVlCeoGqniNofIWXvfjsWclfGEtCG
         zl5PjUk3Gl4mRB3+oh6Si9hXe93GGp5TcE2S0TN/n97+Klm1wAcd87lFuiASCL+IDfOt
         eWtqTPtiTbKh6ZoufpDkHeMote2aaIESsOAISEZINKUSBxAWh2ZvmhYuDlSUsW9XXjoB
         +sbzWkagY3tCD0LEUE5nHYNqxPcMzjV6p5rur0lHeJVSmKl0GkajcxGSA5E+tFH5N7+q
         gd8bPndXUe8jXeT/oIyKIeUSt0mgQRwYXuUwtI2ZV/KA0vRlLozWkHRfhbNKqyB2Tg/v
         cQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNFirraLM7s7j9AxHTJl4hrxwW7TmyqVI4M5YpiegmQ=;
        b=F2TUX1VRAzN6zoozgHNThG6Cfmgvqqt4ahpNTTlKNUreZz/9YHiVRLNYiEA0pt1zHs
         b5gA4fC7qitRIoFflp3zSUll8sqsjq4BP9KR64m1FLP44Qbc9K+wJZQeeF0HA+WPaJ2k
         MwXHFjFSEDGqrkU2TrLqSv2oN+I+KCBRB2MgriA2+0l1WmG/MhLk8bbcmqCEPaB/E54Z
         hzrisuIIaTuXJmQM5A5Lp/M+LJfAtqy9NduaagD9I9OA5j8rocD1K4qroXanjvcph9T0
         3wkl2aAzTidtU1CFls1OKpITpXj/wGDU225VvycJoU6frN+3JqI87JYp1K9PvxwMO+9X
         fS5A==
X-Gm-Message-State: APjAAAUOl1jviDHnqaXzFfm/ZvcHG7Kq6ZF1JBe9rHUZ6C69GctGMtPe
        v6BXjnHWZg39xU6Jspfaug4=
X-Google-Smtp-Source: APXvYqzlgKsvEYbH0JjN7vHcwyejNN9RCstjg0TXjF88R9xPdiFc2sPZNz7WjdVzrK+ozyZf44MW6A==
X-Received: by 2002:ac2:4192:: with SMTP id z18mr19409461lfh.96.1556199036455;
        Thu, 25 Apr 2019 06:30:36 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id k21sm4647237ljk.21.2019.04.25.06.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 06:30:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: Add missing stubs for a few functions
Date:   Thu, 25 Apr 2019 16:28:37 +0300
Message-Id: <20190425132837.18389-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation fails if any of undeclared clk_set_*() functions are in use
and CONFIG_HAVE_CLK=n.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/clk.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index d8bc1a856b39..f689fc58d7be 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -811,6 +811,22 @@ static inline bool clk_has_parent(struct clk *clk, struct clk *parent)
 	return true;
 }
 
+static inline int clk_set_rate_range(struct clk *clk, unsigned long min,
+				     unsigned long max)
+{
+	return 0;
+}
+
+static inline int clk_set_min_rate(struct clk *clk, unsigned long rate)
+{
+	return 0;
+}
+
+static inline int clk_set_max_rate(struct clk *clk, unsigned long rate)
+{
+	return 0;
+}
+
 static inline int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	return 0;
-- 
2.21.0

