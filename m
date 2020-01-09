Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235CFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE9C2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cF6PUF7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgAINRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:17:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38643 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgAINRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:17:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so2795607wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+P78WIdEcS4H0Uk5GUvEb/cSiKEiWQERVk73RDHQDE=;
        b=cF6PUF7Ph4300k0j8Xt3/Gcernc1Cz0/4wa/JmarFAErldaKJO5Jimr0wW78wUtfUt
         hJhX8wL4utw2SSavbzPGAsftylu6KqOphEILoAyFmEpnWiyRsHZGyjQJyfWxT/MMDkD6
         Q0Z9DF22EuBiUrIP1FLJe5jny/yViUWK4eAMcPsDxKiOMHK3FzmFnwhSVQTsXHZATAaW
         JFZ3I4B5JpihhjH/NcScmUun2zbIhtszPKLcZpc0ZjxHEpNH9fnmeMBBV0xtOyr4nsDx
         7tvSn0XEs6cr9JNDGv7BsunmWZb0tDSoUGcoeI6AtUy+POd2ngiOGKjzi00ZtoYuWWuQ
         2QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+P78WIdEcS4H0Uk5GUvEb/cSiKEiWQERVk73RDHQDE=;
        b=R9rzlf7RBBPGhJM2YvbYUOvBL3M3gCdp8osDC2gKMLIQkRoDugcbf4eCAsrFSIJi5/
         agVkGkbMlHrua/cUCCGtkOcBZcZNqVm5+rPUCUb3mvZNJCnxlNpax63mKgdGJM0ITh++
         +4Z8gQgR4iACooVUTLWchOMW+wNXbJmlQMP6EUpu2eFkemQfCO9DHOJEXYI3eTsVXI3S
         4iFZq41+lidyT9r22m6WWPBssKsK8O/+tMird0r6Tf84hJ8cr63NBTpfPhLnpjHZEEeO
         CDb4/a8OobTZL3PCOZumXKvL27PId3SrYRXhThJt048C9EgiHutp8TBBBQS3zMUMoe/Q
         A2aA==
X-Gm-Message-State: APjAAAWsp5luRmfLgep+kR2xPmee7iAqhf2RvaOgsnQzxRL22JrhjYvb
        P7vE9aULhi8eM++5jmIyOXDPgw==
X-Google-Smtp-Source: APXvYqzK9q+4v/pO6c66sFBk/G0liZBd0UplDRzs3BO0TJCLmJnpsxEmpojpgkiIea9vZqeAvNt+bQ==
X-Received: by 2002:a1c:9e15:: with SMTP id h21mr4585262wme.95.1578575818590;
        Thu, 09 Jan 2020 05:16:58 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id u22sm8172989wru.30.2020.01.09.05.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 05:16:57 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 1/2] usb: gadget: f_ncm: Use atomic_t to track in-flight request
Date:   Thu,  9 Jan 2020 13:17:21 +0000
Message-Id: <20200109131722.4090238-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200109131722.4090238-1-bryan.odonoghue@linaro.org>
References: <20200109131722.4090238-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ncm->notify_req is used to flag when a request is in-flight.
ncm->notify_req is set to NULL and when a request completes it is
subsequently reset.

This is fundamentally buggy in that the unbind logic of the NCM driver will
unconditionally free ncm->notify_req leading to a NULL pointer dereference.

Fixes: 40d133d7f5426 ("usb: gadget: f_ncm: convert to new function interface
with backward compatibility")

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/gadget/function/f_ncm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 2d6e76e4cffa..1d900081b1f0 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -53,6 +53,7 @@ struct f_ncm {
 	struct usb_ep			*notify;
 	struct usb_request		*notify_req;
 	u8				notify_state;
+	atomic_t			notify_count;
 	bool				is_open;
 
 	const struct ndp_parser_opts	*parser_opts;
@@ -547,7 +548,7 @@ static void ncm_do_notify(struct f_ncm *ncm)
 	int				status;
 
 	/* notification already in flight? */
-	if (!req)
+	if (atomic_read(&ncm->notify_count))
 		return;
 
 	event = req->buf;
@@ -587,7 +588,8 @@ static void ncm_do_notify(struct f_ncm *ncm)
 	event->bmRequestType = 0xA1;
 	event->wIndex = cpu_to_le16(ncm->ctrl_id);
 
-	ncm->notify_req = NULL;
+	atomic_inc(&ncm->notify_count);
+
 	/*
 	 * In double buffering if there is a space in FIFO,
 	 * completion callback can be called right after the call,
@@ -597,7 +599,7 @@ static void ncm_do_notify(struct f_ncm *ncm)
 	status = usb_ep_queue(ncm->notify, req, GFP_ATOMIC);
 	spin_lock(&ncm->lock);
 	if (status < 0) {
-		ncm->notify_req = req;
+		atomic_dec(&ncm->notify_count);
 		DBG(cdev, "notify --> %d\n", status);
 	}
 }
@@ -632,17 +634,19 @@ static void ncm_notify_complete(struct usb_ep *ep, struct usb_request *req)
 	case 0:
 		VDBG(cdev, "Notification %02x sent\n",
 		     event->bNotificationType);
+		atomic_dec(&ncm->notify_count);
 		break;
 	case -ECONNRESET:
 	case -ESHUTDOWN:
+		atomic_set(&ncm->notify_count, 0);
 		ncm->notify_state = NCM_NOTIFY_NONE;
 		break;
 	default:
 		DBG(cdev, "event %02x --> %d\n",
 			event->bNotificationType, req->status);
+		atomic_dec(&ncm->notify_count);
 		break;
 	}
-	ncm->notify_req = req;
 	ncm_do_notify(ncm);
 	spin_unlock(&ncm->lock);
 }
@@ -1649,6 +1653,11 @@ static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
 	ncm_string_defs[0].id = 0;
 	usb_free_all_descriptors(f);
 
+	if (atomic_read(&ncm->notify_count)) {
+		usb_ep_dequeue(ncm->notify, ncm->notify_req);
+		atomic_set(&ncm->notify_count, 0);
+	}
+
 	kfree(ncm->notify_req->buf);
 	usb_ep_free_request(ncm->notify, ncm->notify_req);
 }
-- 
2.24.0

