Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB5ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223E221A49
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1zp2EAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437001AbfJQRog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:44:36 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:46299 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394573AbfJQRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:44:29 -0400
Received: by mail-wr1-f73.google.com with SMTP id z17so1308010wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zd3UN9zj2SRTHAHyqFE8cwUhiGg9Ar8y6WSvk5Ep4Jk=;
        b=Q1zp2EAe5BhHQV8QkifUBjlziwXk67WUG2YNifCFUAx5IK3xHOz5v/UgLmDMMOwmO4
         qd6jdxNsYepFmbN1fbfDZals8/HHWEKEza2A4sjJWSVO6ZCN+WKHxqzQ/k7QQc6IxOst
         LIrxj7s9dLj87ugnrTc8I23h4uxILDe5fw7CacavgsS/ZTnYYcG56kQTGkyABVRTpshS
         hyMUQZYCLURuM79VtykzhI88iasvt/ENgYmhHbyejw7OqrLNUPmsyOMHMsQRfdMXgZex
         UB+yQspHdV4/RgkMd2E+eqh6uDrBq0A/+XL2xEH3FpZAf0SY99GbSD7M8ZTfH8+xm2v2
         cN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zd3UN9zj2SRTHAHyqFE8cwUhiGg9Ar8y6WSvk5Ep4Jk=;
        b=IGdIvRqjZbYUFwR4ikmiaaD+SH55x3UPMKSJKnntAdTJB6wgOk5JlYVfcjyb/Ga+Uz
         3UOEtGqvHbLb7fKcsQYWHqf9ALrJ0BOd8zxgRkrm6jG0jvkSQyOs/1yF1uegQy2hs+Kg
         EyvTIdpelCXSq3MtIwPf7n5tgPzupxpii/7wzPfUr4+4LU567PgBvZEcB8LX9AHPEGXZ
         jVKQaAwFZTDNfgTNgRUC1MVE1kFuYeY0uKDKX2slF1VHsSucFp1FBf2/MrK3hWKs0YBx
         vLSgXBqSvfpDtUP5Im//BSCGLwGtX9tJYyOJqHcWrulTPq/O8m7gMUWftr/a6gOwtipZ
         UVYw==
X-Gm-Message-State: APjAAAUCpqWO9iO2SzksuAX9HWEJtK1YM/6S+3pRRvnMj2J328IdqjUP
        F5iTokYRvzvaQr9RtTMlTILWamvv9Foe6Rh2
X-Google-Smtp-Source: APXvYqwPbc0HszLZCUbWsoFAApUOTC3ojb+0uPqAUeUTVYCTxoTQacwVoD4Ct1vAVwfHyC9LzISFTizsELobTjWq
X-Received: by 2002:adf:9f08:: with SMTP id l8mr3900073wrf.325.1571334265559;
 Thu, 17 Oct 2019 10:44:25 -0700 (PDT)
Date:   Thu, 17 Oct 2019 19:44:14 +0200
In-Reply-To: <cover.1571333592.git.andreyknvl@google.com>
Message-Id: <1b30d1c9e7f86c25425c5ee53d7facede289608e.1571333592.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1571333592.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH RFC 2/3] usb, kcov: collect coverage from hub_event
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds kcov_remote_start/kcov_remote_stop annotations to the
hub_event function, which is responsible for processing events on USB
buses, in particular events that happen during USB device enumeration.
Each USB bus gets a unique id, which can be used to attach a kcov device
to a particular USB bus for coverage collection.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/core/hub.c    | 4 ++++
 include/linux/kcov.h      | 1 +
 include/uapi/linux/kcov.h | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 236313f41f4a..03a40e41b099 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5374,6 +5374,8 @@ static void hub_event(struct work_struct *work)
 	hub_dev = hub->intfdev;
 	intf = to_usb_interface(hub_dev);
 
+	kcov_remote_start(kcov_remote_handle_usb(hdev->bus->busnum));
+
 	dev_dbg(hub_dev, "state %d ports %d chg %04x evt %04x\n",
 			hdev->state, hdev->maxchild,
 			/* NOTE: expects max 15 ports... */
@@ -5480,6 +5482,8 @@ static void hub_event(struct work_struct *work)
 	/* Balance the stuff in kick_hub_wq() and allow autosuspend */
 	usb_autopm_put_interface(intf);
 	kref_put(&hub->kref, hub_release);
+
+	kcov_remote_stop();
 }
 
 static const struct usb_device_id hub_id_table[] = {
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 702672d98d35..38a47e0b67c2 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -30,6 +30,7 @@ void kcov_task_exit(struct task_struct *t);
 /*
  * Reserved handle ranges:
  * 0000000000000000 - 0000ffffffffffff : common handles
+ * 0001000000000000 - 0001ffffffffffff : USB subsystem handles
  */
 void kcov_remote_start(u64 handle);
 void kcov_remote_stop(void);
diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
index 46f78f716ca9..45c9ae59cebc 100644
--- a/include/uapi/linux/kcov.h
+++ b/include/uapi/linux/kcov.h
@@ -43,4 +43,11 @@ enum {
 #define KCOV_CMP_SIZE(n)        ((n) << 1)
 #define KCOV_CMP_MASK           KCOV_CMP_SIZE(3)
 
+#define KCOV_REMOTE_HANDLE_USB  0x0001000000000000ull
+
+static inline __u64 kcov_remote_handle_usb(unsigned int bus)
+{
+	return KCOV_REMOTE_HANDLE_USB + (__u64)bus;
+}
+
 #endif /* _LINUX_KCOV_IOCTLS_H */
-- 
2.23.0.866.gb869b98d4c-goog

