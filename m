Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34CC4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D8520830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a16SB8y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403927AbfIMWDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:03:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41879 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389617AbfIMWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:03:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so18900270pfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peRAbMQ2xKT0fFJ89FYNdeBR3nBllTZJZRN8uGrtZQY=;
        b=a16SB8y7DtHAZOq5Hes9SBNTETQkEg+2M16auoZs6P5Nx+GDEkq6hcyakn5++4DdcB
         xuotJ1/LBSLQ6/x9i8PSx9EORvkMkkcAslecx1PEO2e932P8IGbrvFqJcEOscwYd0Qjl
         JGGr1z03FZH0C+mmPO4aH9P6LGbCOROUFsGTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peRAbMQ2xKT0fFJ89FYNdeBR3nBllTZJZRN8uGrtZQY=;
        b=ns79cB5KgDOCWRDGZIOUJl/OMart86GI+Tkto5odGVa/8NvSEjTQXvP9VpAWnBZr3+
         nzwK9XS6MxLt4bBk/o9bnu9okAmcdsHpaHHcdVCX+ji4tHculgDrdwhxT0HtjwG+CO56
         nKDXB9IRe9Cjfs9LmkqmzMyzxfPLundwuqskaV/OVPC0V5vsm7iCWYJQu3LP9ervy5yi
         9YdebWDPopQ1KjaskakAOxQiBf3yi821pBsZRBmhOhBqwe9N26l0ci8B49GuJWmrkyP8
         K0SwPX/V/GoJExVNAdl34snQCAb4vae15WzXlTqGDTaRT16RZYkfZVMcFr/Xvi8SJOi9
         5jjA==
X-Gm-Message-State: APjAAAUGk6VkaKt6Hz1mSSL1sZqwFUm5QxQ9tJ8nN7sx8oEI5eQS9uAO
        oo+Fu9RerowkGQhEihjnn4TfcA==
X-Google-Smtp-Source: APXvYqyKIbWs4Y3boyjYAXcLk2CgyMhKDAHsPob+taOZvGOpsX89CxIujHHpsDtA4DxKLQQ7FYVN9Q==
X-Received: by 2002:a63:c149:: with SMTP id p9mr11350330pgi.50.1568412203692;
        Fri, 13 Sep 2019 15:03:23 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o19sm2524486pjr.23.2019.09.13.15.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 15:03:22 -0700 (PDT)
From:   Dmitry Torokhov <dtor@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] HID: google: whiskers: signal tablet mode on connect
Date:   Fri, 13 Sep 2019 15:03:17 -0700
Message-Id: <20190913220317.58289-3-dtor@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
In-Reply-To: <20190913220317.58289-1-dtor@chromium.org>
References: <20190913220317.58289-1-dtor@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we receive "keyboard position" event from Whiskers we can
conclude that the base is attached, even if we did not get EC event
for that. We may miss EC event because there are some units which
have a lot of leakage on the ADC pins that the EC uses to determine
whether or not a base is attached.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 3dc6116c8f76..31e4a39946f5 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -402,16 +402,16 @@ static int hammer_event(struct hid_device *hid, struct hid_field *field,
 	    usage->hid == WHISKERS_KBD_FOLDED) {
 		spin_lock_irqsave(&cbas_ec_lock, flags);
 
+		/*
+		 * If we are getting events from Whiskers that means that it
+		 * is attached to the lid.
+		 */
+		cbas_ec.base_present = true;
 		cbas_ec.base_folded = value;
 		hid_dbg(hid, "%s: base: %d, folded: %d\n", __func__,
 			cbas_ec.base_present, cbas_ec.base_folded);
 
-		/*
-		 * We should not get event if base is detached, but in case
-		 * we happen to service HID and EC notifications out of order
-		 * let's still check the "base present" flag.
-		 */
-		if (cbas_ec.input && cbas_ec.base_present) {
+		if (cbas_ec.input) {
 			input_report_switch(cbas_ec.input,
 					    SW_TABLET_MODE, value);
 			input_sync(cbas_ec.input);
-- 
2.23.0.237.gc6a4ce50a0-goog

