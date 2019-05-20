Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC97C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFC020863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RhKZDuJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfETGvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:51:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36415 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfETGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:51:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so6729725pfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96LsfiFrWMDve/VrbKW+rKdzJVThO32QPdm+2n7gs78=;
        b=RhKZDuJCmDpIMcrrCRuhoMsURulbqflkugS+ljsC9RkqTHVGuuBv4b8r+t7zhH4/0i
         7+oicObbU4MMMzlU0ShNf90XRV9cN0LNelxAcDxel6lwamqkvk1gc+9a71f6BIEslgFI
         HJdPhLRhLuBwhbUrip5gzGoPMoW1YM0HU5xgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96LsfiFrWMDve/VrbKW+rKdzJVThO32QPdm+2n7gs78=;
        b=hjFfhqpjW+a/IwRwKJRAMd32oiX95nzYrnF1XBp2ZM06mvebrb9CrnUpZcewI61cBO
         bSP6PqcxeyeZvXs8fQSPXJFdFIsSyhFGaC7GHLAJGa0SGHuj6y0gDKHtwpQOiIv+0e9Q
         f8RAhqqD+cUhcQIGkzncCZ3oe/HgYRUgMWj1wu6OAQTwgSfi0wBwUVHO/WnhcU06XXId
         XwUkn2p/rI2bWv5aahD1ZHo1yGOW4rbJZFeVot5PkJnWw5inopdExH2al+2Km/Xr+vKI
         H33a5d/QJYP5lOkdg+RSEsdmFi15gA4OuYzMLAj3Oyt7Pwntk9lk92FDjnkTVQUsfGnc
         8mLg==
X-Gm-Message-State: APjAAAX+7LGqdOPqGyymFvuXGe3sZ/U7csPHLEZLgOigh5FuExfZ4xmK
        qDtIyg9mRffOv3Qu8Y5MWkUE/4B5pcA=
X-Google-Smtp-Source: APXvYqxl9tO0x+WMlFYuRzoESYG4KIQ6GYvdOenA2HMODeW4lJ0QDIqJLOqnOXoXuUqGb8+J0iYpDQ==
X-Received: by 2002:a63:a449:: with SMTP id c9mr38209456pgp.149.1558335110646;
        Sun, 19 May 2019 23:51:50 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id v1sm17881919pgb.85.2019.05.19.23.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 23:51:50 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pstore: Set tfm to NULL on free_buf_for_compression.
Date:   Mon, 20 May 2019 14:51:19 +0800
Message-Id: <20190520065120.245811-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set tfm to NULL on free_buf_for_compression after crypto_free_comp.

This avoid a use-after-free when allocate_buf_for_compression and
free_buf_for_compression are called twice. Although
free_buf_for_compression freed the tfm, allocate_buf_for_compression
won't reinitialize the tfm since the tfm pointer is not NULL.

Fixes: 95047b0519c1 ("pstore: Refactor compression initialization")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 fs/pstore/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 75887a269b64..8355a46638d0 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -347,8 +347,10 @@ static void allocate_buf_for_compression(void)
 
 static void free_buf_for_compression(void)
 {
-	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm)
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
 		crypto_free_comp(tfm);
+		tfm = NULL;
+	}
 	kfree(big_oops_buf);
 	big_oops_buf = NULL;
 	big_oops_buf_sz = 0;
-- 
2.21.0.1020.gf2820cf01a-goog

