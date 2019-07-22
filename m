Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5746BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6C221951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjc7Z7Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfGVVsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:48:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38842 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732907AbfGVVsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:48:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so7147103edo.5;
        Mon, 22 Jul 2019 14:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=inZa3TVmWFkwKROJnwjdOzwsfiSlRUzlERV4AMAiDbU=;
        b=Kjc7Z7LbkyZQoSYGIqGObI6lmtBjBt3vDFoIHBE3IjlpFyFMt7itVoEIPg7EzqEBkl
         2r9oOlFGi1mlcnyOXAP44kNxY2aHsO6VkgNWB1zaHyHoHMt4UiG/7yD/gDv3uLi1Rpg1
         8rF7bLnZ+D/TXDBAokXCP38dEDpTOa98eOOt7DHgmu63o1n23PAqRxElh0dOoRa/giWn
         p75TAJt6Qs5SIaNDwPoHcBJ7mcP1ZwyHnUWPqVVNY6B9zzsbqIN6LDsKpBWLnhL+MnR+
         PNE7pLw2VZUHOTfsDFcuXB8wm3Tma+QmNe15fuTV3co19jvD8JDyHzlAbXE4V0O5VMO7
         Dufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inZa3TVmWFkwKROJnwjdOzwsfiSlRUzlERV4AMAiDbU=;
        b=BhYyz3JgA6Z8bI0/Ng0DMjxkqAW2XogEMNaL9CgKu3epKeeL/wQ0OxFlF6SIF+VJdX
         l858D9Wb39Rn7BIm0EN5rj0aHWFYEMNWuZFGHvt4E75JCddDNyayjMFDTKSfm/r4aDIG
         OtA0YpdAH0bjTaO7jGFpnBTuKybGWzm7nX2Zw9UwnCPzW48nI1L/Bt/M8F3X+6ayttnX
         BsvWfb2tWczLgS41kmZolcj7ARCYZ5qHG3VrOqfU3Lsgqg9F6wtHHATsvE7Z378SkX+m
         Iv5NtpURhPuaDpatOtpS9L2bnPI5MLrfpHQjMBHHDRWqewRm00O+xntYpblMcxzQuzdV
         BTzA==
X-Gm-Message-State: APjAAAXc+oXSlxsRjVO3rVHvsdUGh387tsEyLW5EYQ8ZgDF5H0lMV6dy
        8cvGsu3GHkCsP1wCLfwfCxQ=
X-Google-Smtp-Source: APXvYqwaf+94HctotgfRZtaDLULEesihLhjER6anVGZWKKut2Gqj7GVw1S5B6Pok/SYDL+TqT8txlw==
X-Received: by 2002:a17:906:340e:: with SMTP id c14mr56112743ejb.170.1563832125374;
        Mon, 22 Jul 2019 14:48:45 -0700 (PDT)
Received: from localhost.localdomain ([65.154.66.198])
        by smtp.gmail.com with ESMTPSA id d4sm11315617edb.4.2019.07.22.14.48.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 14:48:44 -0700 (PDT)
From:   stillcompiling@gmail.com
To:     Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org (open list:HID CORE LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH v3 3/3] HID: core: only warn once of oversize hid report
Date:   Mon, 22 Jul 2019 15:48:27 -0600
Message-Id: <20190722214827.29257-3-stillcompiling@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722214827.29257-1-stillcompiling@gmail.com>
References: <20190722163642.10417-2-stillcompiling@gmail.com>
 <20190722214827.29257-1-stillcompiling@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joshua Clayton <stillcompiling@gmail.com>

On HP spectre x360 convertible the message:
hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (192) > 32! (kworker/1:2)
is continually printed many times per second, crowding out all else
Protect dmesg by printing the warning only one time.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 210b81a56e1a..3eaee2c37931 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1311,8 +1311,8 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
 			unsigned offset, unsigned n)
 {
 	if (n > 32) {
-		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
-			 n, current->comm);
+		hid_warn_once(hid, "%s() called with n (%d) > 32! (%s)\n",
+			      __func__, n, current->comm);
 		n = 32;
 	}
 
-- 
2.21.0

