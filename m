Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065EAECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C791721848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c0Ul3Ami"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406572AbfJQQcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:32:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37702 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbfJQQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:32:21 -0400
Received: by mail-io1-f68.google.com with SMTP id b19so3797298iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0nsp8YUe6GDrJ0TuBakk/ATNKu0tD/75AlnwMlWFBo=;
        b=c0Ul3AmifOFvya7o3yhj0OCQd/wB5vbawrcr5oOEuOnJNHFSnGN4PYk9oirzftTRmp
         EXs6RkeJ4inpKI3mMCmq255xCbm34gT33YckGqVG4vp0Ur5wyxH4Z74+fD9T1LJTZnU5
         mTQ4+PELk6qy1AA6hx66C6JKyv+1D87qX6Kvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0nsp8YUe6GDrJ0TuBakk/ATNKu0tD/75AlnwMlWFBo=;
        b=JEtfb2rFWy5xTukp/bn4wHvZeEhwBvTKjS7BvDGScuG9hZ5uz/mniXHvlWUA0ljemz
         Wf5rNMp6vOcGruL/KTs+0E1iNUH6U5a1+KEstAHHjPaCWX7mUNLoEbmeNdVy/OoLKXMc
         wyTbo+AcrZyI3baxzI12DAkAAVp8OTvW7y+BE2n+cjQt4H/vhzdEu9+dBdwDUV/BRdFQ
         sffBn1/fbjmxtC3BcldABBcBUT2aVZ5S2RrRlbqHGA2kQvjK3XjsN/7+4E9wiI1Ti2r5
         fdMMZIT4qWVS+rrEOZIDaU2Vt/X31YvCfgZgvhN5987uxUD9UiBGrE8ZtpF5kFJu/zDU
         dLAg==
X-Gm-Message-State: APjAAAXlOet+F0KXxMpMgwSCoFfXEvaBJqivyM92/+gzdz6Ouy9zy/Mv
        nEOoa9bPeDQP4uS5UTj/IpO64g4noNHnzw==
X-Google-Smtp-Source: APXvYqzyReRkOVh7Tfwf5fVzvgZVZ5D3xC7y1UdhocS+o7WoDQiSqBZzqhxMJkTOnOzg2fO4VskDqQ==
X-Received: by 2002:a5e:cb0a:: with SMTP id p10mr3862196iom.85.1571329939058;
        Thu, 17 Oct 2019 09:32:19 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:777a:4e3:a71c:e893])
        by smtp.gmail.com with ESMTPSA id o14sm822878iob.49.2019.10.17.09.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 09:32:18 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Duncan Laurie <dlaurie@google.com>, linux-input@vger.kernel.org
Subject: [PATCH] input: Add privacy screen toggle keycode
Date:   Thu, 17 Oct 2019 10:32:08 -0600
Message-Id: <20191017163208.235518-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add keycode for toggling electronic privacy screen to the keycodes
definition. Some new laptops have a privacy screen which can be toggled
with a key on the keyboard.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
 include/uapi/linux/input-event-codes.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 85387c76c24f..05d8b4f4f82f 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -649,6 +649,8 @@
  */
 #define KEY_DATA			0x277
 #define KEY_ONSCREEN_KEYBOARD		0x278
+/* Electronic privacy screen control */
+#define KEY_PRIVACY_SCREEN_TOGGLE	0x279
 
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
-- 
2.23.0.700.g56cf767bdb-goog

