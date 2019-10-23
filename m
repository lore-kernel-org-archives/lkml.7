Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A0BCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E7E21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM5CCQ6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406726AbfJWPYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:24:47 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:43324 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406708AbfJWPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:24:44 -0400
Received: by mail-ua1-f74.google.com with SMTP id b12so2445193uan.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+fsowxQJsoipiOcnYQh/aAOpnyB04Lo2+yDsb2t+OXI=;
        b=rM5CCQ6QwHb40lD+8V+d3DREorqYK5DjOVpuv3ArZyGAQ516U+qeieYBqLgPg/xCCK
         UAjub/EHsWLgM2LRDliKIF+uBvQ/JLIyFqbB4P8PCFH2x5ojoCa0GTnMm7AwA84gXKV+
         kZMFiWnZrMW7me+aEiFoCKyx0Zg9KGlJpjayMWrLM/C4QjFy49U7YDeOOlyQRvjPEUhb
         7eRgQp1jx6Zkg5prYydvLpCIKKUNKxau5Flcl2aoiu02/1k6+a2awvXc/lfyJ2JFlgjD
         wJ1xx+GsUvq738BGFcz8U+DTA9duDH1CnWnU5lcaa/rUxJ8X2VmIijtBB1WemnynjuMk
         NdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+fsowxQJsoipiOcnYQh/aAOpnyB04Lo2+yDsb2t+OXI=;
        b=Q2i6CTPQlSguiKAOKNUQe6QIaNsK3OcQudA7QsK4MZWMszfm+Hl33TuQokSlmo3v8c
         FTbbaXPFfzVAGpqW4xMhKzf16WQyhSTlIHB4aL9/it3ERuC5d5sBfbngCFlWyVzNpZFl
         Pjwf3G5M+A9k4wY5ziJtMyjh3PgSWSd0PP1oo5WVVG6pb3nPjGAeXYS+BB5GP90abGnN
         e478PC5u2MUvG15UokXLouP1s7RcRDlRP4hmgao1yl6Tc/5TFqMDaw3KHeZMvP8U6+Ct
         dOMKgMiwtqOVp2dZL05T0tfql7egn6ndGI6KgI3ESRT7wpVFaIXFWcRFH87JtQzkBMyG
         jpig==
X-Gm-Message-State: APjAAAUHvH1+FEeT9nBw8lTxCJFz1qV6RsyqaS7yl+Laxu+W5ynSrUR9
        WrSOv5L+HkUWVbuqhAY4d9TVDFPbAoZAd1CD
X-Google-Smtp-Source: APXvYqyVi59fXRYgZbs3IqAwnhV+t83pyUg453y+vcRDf4p6UDsgQ0xoylaSfeVaF4BAxV8813MNkxvSMM0JesNv
X-Received: by 2002:a1f:97c2:: with SMTP id z185mr5634334vkd.0.1571844282053;
 Wed, 23 Oct 2019 08:24:42 -0700 (PDT)
Date:   Wed, 23 Oct 2019 17:24:30 +0200
In-Reply-To: <cover.1571844200.git.andreyknvl@google.com>
Message-Id: <7ac106f30b2c1dab4809c75c5ae6efb91b531cce.1571844200.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1571844200.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 2/3] usb, kcov: collect coverage from hub_event
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
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds kcov_remote_start()/kcov_remote_stop() annotations to the
hub_event() function, which is responsible for processing events on USB
buses, in particular events that happen during USB device enumeration.
Since hub_event() is run in a global background kernel thread (see
Documentation/dev-tools/kcov.rst for details), each USB bus gets a unique
global handle id from the USB subsystem kcov handle id range. As the
result kcov can now be used to collect coverage from events that happen on
a particular USB bus.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/core/hub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 236313f41f4a..823dd675f6db 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -29,6 +29,7 @@
 #include <linux/random.h>
 #include <linux/pm_qos.h>
 #include <linux/kobject.h>
+#include <linux/kcov.h>
 
 #include <linux/uaccess.h>
 #include <asm/byteorder.h>
@@ -5374,6 +5375,8 @@ static void hub_event(struct work_struct *work)
 	hub_dev = hub->intfdev;
 	intf = to_usb_interface(hub_dev);
 
+	kcov_remote_start_usb((u64)hdev->bus->busnum);
+
 	dev_dbg(hub_dev, "state %d ports %d chg %04x evt %04x\n",
 			hdev->state, hdev->maxchild,
 			/* NOTE: expects max 15 ports... */
@@ -5480,6 +5483,8 @@ static void hub_event(struct work_struct *work)
 	/* Balance the stuff in kick_hub_wq() and allow autosuspend */
 	usb_autopm_put_interface(intf);
 	kref_put(&hub->kref, hub_release);
+
+	kcov_remote_stop();
 }
 
 static const struct usb_device_id hub_id_table[] = {
-- 
2.24.0.rc0.303.g954a862665-goog

