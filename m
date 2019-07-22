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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A803C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5332199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTxJUMUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbfGVV0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:26:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39769 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732607AbfGVV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:26:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so41875536edv.6;
        Mon, 22 Jul 2019 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KM/OihnolL+F1PXvRp03ASHFDh/aKfLJ+VNL7vMQ4JU=;
        b=GTxJUMUbN1sLxMNXdAHXgTSg3YUDHugEwJYqoAC/le7mkZpVlVZztVkYWG4eomYsHz
         A2mXn/7E1qLJo0qOUogD/1twqQk1pS+vq8yv3rcYouF7ULJPh5ZgZoBZiMA7VJZQwDlM
         aPvfkYezADe3MvYlKqXTAqLEOeij++63092tLIN1W1TSFOcInI/bU590hxL3ohuM5WNw
         clZ+1PZqpM+8NuddvHXO6j0ubSE04W1X6FhWOevNqOchAX1ipN9gva/cwXjTxx5uJtSp
         /dLuC4+hGEsZiPb1mTNjjNj1KqLgIV26EsShbyPPVedyrU8S33a6KT2TaE63z6mC2UN0
         AOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KM/OihnolL+F1PXvRp03ASHFDh/aKfLJ+VNL7vMQ4JU=;
        b=q3wLWMH+DsSL85cx1szD4C/iG2PGf6iaJGdQ0dNOSkvkzbqXdKt40Efb8Qq7FKndMD
         7Fkv756vUEtqiB0FOJHPJmdg4h+Rl3vM9E+67YrxxCJ5G1QY6bEoLtKzm9DMI/+LI7v2
         Z9OWkKnzVJ9wPfpUBu5GzKMgYOFI9IWuYz8XJSt/pPzmHfan+jYiLWbXgAcJHANEQc41
         bIZLDRQsJxJhNmNtILLeZfsbzUXfX0EqCj+55UCqtEnFwgLgr26ybJ+tkb1YXb9sUdst
         hzFJWI+6WffQ4+3LoaVtN2J5nRRrTt5IEE10GXRetcdl7Ty81Q9b3OLjy4iLoq8TjK/u
         Zjsw==
X-Gm-Message-State: APjAAAX6EqLReEUQQf8muNRZx2v7bQFZhjXdtG28ywu1OTbj3B0dpuTi
        2FDIE+pruHyNzKTfa6TZpbk=
X-Google-Smtp-Source: APXvYqy2ZNXpy3vciRC86L7bxksQpiBrSq3iqDdJDzd0eGTdKCpWOzPUvrwVcWpWpGJRwjmIapO28Q==
X-Received: by 2002:a17:906:ca56:: with SMTP id jx22mr54067358ejb.201.1563830794127;
        Mon, 22 Jul 2019 14:26:34 -0700 (PDT)
Received: from localhost.localdomain ([65.154.66.198])
        by smtp.gmail.com with ESMTPSA id a67sm11469524edf.6.2019.07.22.14.26.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 14:26:33 -0700 (PDT)
From:   stillcompiling@gmail.com
To:     Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org (open list:HID CORE LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH v2 3/3] HID: core: only warn once of oversize hid report
Date:   Mon, 22 Jul 2019 15:26:13 -0600
Message-Id: <20190722212613.24906-3-stillcompiling@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722212613.24906-1-stillcompiling@gmail.com>
References: <20190722163642.10417-2-stillcompiling@gmail.com>
 <20190722212613.24906-1-stillcompiling@gmail.com>
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
index 210b81a56e1a..0cb53dddf341 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1311,8 +1311,8 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
 			unsigned offset, unsigned n)
 {
 	if (n > 32) {
-		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
-			 n, current->comm);
+		hid_warn_once(hid, "%s() called with n (%d) > 32! (%s)\n",
+			      __func__ ,n , current->comm);
 		n = 32;
 	}
 
-- 
2.21.0

