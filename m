Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E7FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357CA20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnOflMOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgAINRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:17:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33343 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730695AbgAINRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:17:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so7428763wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cw0YAnK06txM/JsrjQ+gtJRtA2/PXI58iStpISQaGi0=;
        b=PnOflMOOcnWRx3hUQ6D0AwQJUdeP5krpDqFFKN7HDTxpMD6/N2c/qdLBEveCH0irfj
         Eg3OnJumPG4H8a+d65Cziey5bqcpF+Dny+3AqVOZ+CitWhW9TCrToGS5V2I0euhuNqbn
         6EHbnHzBrpjh3tZd/jYf1jRWeNoQADbpcxQLnjEgDOAt0RBQktrxhnOwIzx2EuGBHRPW
         zF6XfsUX4NFsDiPz5qfI9OTg2hN66t5f+pntQTiXJHIsAKPyWEbiSuX/LeBbTnovIeFE
         ZWEi56LWMCfvRtZCdgaqkWpScA/J5ooQoBpl1lOpviTYYN4JuGnHRmK03EbCPwCoQyi5
         ApmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cw0YAnK06txM/JsrjQ+gtJRtA2/PXI58iStpISQaGi0=;
        b=FGbv8wdFq5VWKSC7UuS8aflgJgjVLrnsTleM/U3avMtOBKsGnyE+f3l3Jk95JggAAM
         FDpx/xscnZz0AtRcMNbOPhEGeAWTgqFFJGfjb7GvlrLiMl39maB/K/zQ3yjFwLLanbhe
         bJhXxleyY+++gvbRXuxZPhmghbL4E0fnKvY/lyLJNRT8lxqdbv2xtibDMPUq4NgNnsFv
         YDCP+nV+x6/248RNL7igQP088Vc7FBT3M52AqoCOGmA3lP3LO5b2SFEGh/R0Rf8m9iSq
         r64ndPJAzlFkV7MoQ6UB+t3OA5RDEFRNtkTmBJgA0KkEdTL3oduHDhwPQJ9Mrsnko6FC
         Uoig==
X-Gm-Message-State: APjAAAWt6iI56psuW1FmLqNmXQ6fzKDBc3mxncu9GeaQa6WZz1zIAySB
        FaF9KYWWspR2ukVZAmu7YHWAZA==
X-Google-Smtp-Source: APXvYqwzvjxqez9GknsRtXqXmkLrtMB5BUvUCUvukArwsdIzX2tRl7fPf86bgHdvFU2YN7WxsHUKDw==
X-Received: by 2002:adf:b648:: with SMTP id i8mr11163272wre.91.1578575819762;
        Thu, 09 Jan 2020 05:16:59 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id u22sm8172989wru.30.2020.01.09.05.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 05:16:59 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 2/2] usb: gadget: f_ecm: Use atomic_t to track in-flight request
Date:   Thu,  9 Jan 2020 13:17:22 +0000
Message-Id: <20200109131722.4090238-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200109131722.4090238-1-bryan.odonoghue@linaro.org>
References: <20200109131722.4090238-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ecm->notify_req is used to flag when a request is in-flight.
ecm->notify_req is set to NULL and when a request completes it is
subsequently reset.

This is fundamentally buggy in that the unbind logic of the ECM driver will
unconditionally free ecm->notify_req leading to a NULL pointer dereference.

Fixes: da741b8c56d61 ("usb ethernet gadget: split CDC Ethernet function")

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/gadget/function/f_ecm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index 460d5d7c984f..7f5cf488b2b1 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -52,6 +52,7 @@ struct f_ecm {
 	struct usb_ep			*notify;
 	struct usb_request		*notify_req;
 	u8				notify_state;
+	atomic_t			notify_count;
 	bool				is_open;
 
 	/* FIXME is_open needs some irq-ish locking
@@ -380,7 +381,7 @@ static void ecm_do_notify(struct f_ecm *ecm)
 	int				status;
 
 	/* notification already in flight? */
-	if (!req)
+	if (atomic_read(&ecm->notify_count))
 		return;
 
 	event = req->buf;
@@ -420,10 +421,10 @@ static void ecm_do_notify(struct f_ecm *ecm)
 	event->bmRequestType = 0xA1;
 	event->wIndex = cpu_to_le16(ecm->ctrl_id);
 
-	ecm->notify_req = NULL;
+	atomic_inc(&ecm->notify_count);
 	status = usb_ep_queue(ecm->notify, req, GFP_ATOMIC);
 	if (status < 0) {
-		ecm->notify_req = req;
+		atomic_dec(&ecm->notify_count);
 		DBG(cdev, "notify --> %d\n", status);
 	}
 }
@@ -448,17 +449,19 @@ static void ecm_notify_complete(struct usb_ep *ep, struct usb_request *req)
 	switch (req->status) {
 	case 0:
 		/* no fault */
+		atomic_dec(&ecm->notify_count);
 		break;
 	case -ECONNRESET:
 	case -ESHUTDOWN:
+		atomic_set(&ecm->notify_count, 0);
 		ecm->notify_state = ECM_NOTIFY_NONE;
 		break;
 	default:
 		DBG(cdev, "event %02x --> %d\n",
 			event->bNotificationType, req->status);
+		atomic_dec(&ecm->notify_count);
 		break;
 	}
-	ecm->notify_req = req;
 	ecm_do_notify(ecm);
 }
 
@@ -907,6 +910,11 @@ static void ecm_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	usb_free_all_descriptors(f);
 
+	if (atomic_read(&ecm->notify_count)) {
+		usb_ep_dequeue(ecm->notify, ecm->notify_req);
+		atomic_set(&ecm->notify_count, 0);
+	}
+
 	kfree(ecm->notify_req->buf);
 	usb_ep_free_request(ecm->notify, ecm->notify_req);
 }
-- 
2.24.0

