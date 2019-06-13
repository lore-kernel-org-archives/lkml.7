Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F344C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DFD20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq06vN7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393073AbfFMQwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:52:55 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37537 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfFMDFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:05:02 -0400
Received: by mail-yb1-f194.google.com with SMTP id v144so1427249ybb.4;
        Wed, 12 Jun 2019 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWWBa0nTBIfYqSobNC1C7xjNtAsVYb7zyqkZL1BlQZY=;
        b=pq06vN7Ms6UkApZ0vO7TyshYj05cnnMm445rxsQlPQH0AuaDb0hdXCmpASyDEt77x2
         W6xZ6qgII7nhqXXMJlINNaNqOZrrylfoFJDfjsDR6ITbLRaUltHUU9dm8tTR91+jO3vm
         YRpVelRi+uHB5LzOs3X4O+IFT/UKw8i8hSbWFOeI+dcq4IVPsX2gHkQ8uF8o1T+jQuqq
         7B8UNFlVy9ArWLOCbvSc+tQCth9kFBZVZko3IfvoqGPeFqcU/cJ4gralqp5MK+0AiErM
         IPgqqJ07NPkC4eFwlEIoU7SweSZMXGgYpStlm0KpjlWVsc4SgsKiWph7HCYf1o+xhuVn
         L5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWWBa0nTBIfYqSobNC1C7xjNtAsVYb7zyqkZL1BlQZY=;
        b=mQOladKUYXFP6cmLFaE6yJP/d7uF5I85O2v2Rj4vnr/k+9H5NFO6uNqEInv0pAcsMu
         Qp2tFAgWVJ7Pe8XYMgkpq5CMDEi6FpK8HdXexdE+/4pRILd9pKN+ZY6pDYb+71L+v0SI
         uKAsjzJWeQ3H1rpS8NtPmBAlZegys8psQYSGy+n5fnldqu8KONAgJTXoc2nOCfwUWtIc
         xim4+AqY63YDvZ9guAKGvPh89N54aDmRjlGiDiuQ8f3qXb6wiSi1h3DdODxBE3yFAhyV
         7ragQCN2kcxMqQz4DNp3883RAvq6ztWGPHxjxkz+WF8SgRUhFxA44Fu5SEMKQoASzxOj
         0bag==
X-Gm-Message-State: APjAAAWnWACJwcI2YHzkhKRKhvafhMgC6qWj/63UcgoBAK5vWaSR0WMa
        hbDDT9D9Rrsmq16mmWQAkD4rxusVTA==
X-Google-Smtp-Source: APXvYqyNuXd2BE5Co4jcJjOydd8vpZMOsSp5ubsDeM1jILgi58Mwh4DV3zMnQzpjmzJXC4Hu34k/5w==
X-Received: by 2002:a25:4115:: with SMTP id o21mr40435969yba.162.1560395101673;
        Wed, 12 Jun 2019 20:05:01 -0700 (PDT)
Received: from 960.localdomain ([71.46.56.3])
        by smtp.gmail.com with ESMTPSA id j184sm424831ywf.8.2019.06.12.20.05.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:05:01 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v2 6/8] platform/x86: huawei-wmi: add fn-lock support
Date:   Wed, 12 Jun 2019 23:04:13 -0400
Message-Id: <20190613030416.25807-8-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613030416.25807-1-ayman.bagabas@gmail.com>
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The behavior of hotkeys is not the same among all models. Some models
require fn-lock to do things like `Ctrl-Ins` or `Alt-PrtSc`. By default,
hotkeys behave as special keys (media keys, Ins, etc), but if a modifier
is used (ctrl, alt, shift) these keys behave as F1-F12 keys. If the Fn
key is toggled on, the hotkeys with or without a modifier, behave as
F1-F12 keys. This makes it impossible to use a modifier and `PrtSc` or
`Ins`.

Now, some models fix this by excluding `PrtSc` and `Ins` keys from
being treated as F11 and F12 keys with the use of a modifier. However,
some models do not, and fixes this by the so called fn-lock.

Fn-lock inverts the behavior of the top row from special keys to F1-F12
keys. So a modifier and a special key would be possible which make
things like `Alt-Ins` possible. Now, with fn-lock we would have 4 modes:
* Fn-key off & fn-lock off - hotkeys treated as special keys using a
  modifier gives F1-F12 keys.
* Fn-key on & fn-lock off - hotkeys treated as F1-F12 keys and using a
  modifier gives F1-F12.
* Fn-key off & fn-lock on - hotkeys are treated as F1-F12 keys and using
  a modifier gives special keys.
* Fn-key on & fn-lock on - hotkeys are treated as special keys and using
  a modifier gives special keys.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 06d83e613504..aac9b80f9976 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -357,6 +357,37 @@ static int huawei_wmi_battery_set(struct device *dev, int low, int high)
 	return err;
 }
 
+/* Fn lock */
+
+static int huawei_wmi_fn_lock_get(struct device *dev, int *on)
+{
+	u8 ret[0x100] = { 0 };
+	int err, i;
+
+	err = huawei_wmi_cmd(dev, FN_LOCK_GET, ret, 0x100);
+	if (err) {
+		return err;
+	}
+
+	/* Find the first non-zero value. Return status is ignored. */
+	i = 1;
+	do {
+		*on = ret[i] - 1; // -1 undefined, 0 off, 1 on.
+	} while (i < 0x100 && !ret[i++]);
+
+	return 0;
+}
+
+static int huawei_wmi_fn_lock_set(struct device *dev, int on)
+{
+	u8 arg[8];
+
+	*(u64 *)arg = FN_LOCK_SET;
+	arg[2] = on + 1; // 0 undefined, 1 off, 2 on.
+
+	return huawei_wmi_cmd(dev, *(u64 *)arg, NULL, NULL);
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
-- 
2.20.1

