Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40D8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABA420640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjQmbbIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfJUOVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:21:20 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:34483 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbfJUOVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:21:19 -0400
Received: by mail-wm1-f73.google.com with SMTP id o128so7419904wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jJrAgqlpvuBPJgHHfjlb9pSf3SBUtlgCGQgAJchUub0=;
        b=qjQmbbITFUt2D/FTw+FbgTnQYQD1w10My5T/IQ/ls1RkPXwiuwPGovJl6qEe2ePCXJ
         JkZj1F7AuI5MgGcG9DC9rsXYuADo6uF+tq6+pJTBYZ5ol8Vl2pNI3ATKlQkIAG9eZmK3
         xsK7Od75N9arZD5gNyXYEgxS4qF2hgHB1o7hLYtpFYj3+HpaTvP+4tz2IKriAMg3mV3G
         qaqFVouJq9HuV9ICRw3rACqT7d/K9PW62QDwWGfUZ0FhgwZNOcYhvF4ScIT2I+iB0awN
         ueJv0uTk9L0sxi4kAQLZ1W8cCDr3IIfT1uRpwDDua1vb1AFXo1nLap3/qkrvEp8s/4Va
         xt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jJrAgqlpvuBPJgHHfjlb9pSf3SBUtlgCGQgAJchUub0=;
        b=CE/Q1CK+SmLub83G1C+kUb3YMomwT1pMzoZ9tYo0EgGp+QGGbveYfWGrmpcUQBKQQz
         V3lIiqj07E7nwQ6hQ9QJ1BkafqqO+SWIeZjM2yEQOJvNbNw4i92gQ7Sr7d3oOskjg4BG
         /dPP69BaFZUrYFRHopUSmlmwAWggQhK0fV9e2p59C7ET3o2D+I7PwAN78nxhbx+mgaCP
         HWSb5RkvlwM49INHfJsF7iNxjefYVCeSNVpLS/XRby0i9eQs4JJtOtDDqWz0rm1CsFLL
         DcXjjPfofOxDeRiTQjKIzimuGIY8xVQXjLXKc3Sf9Ec6dgFR1lt1Rb4Pagf0AL6aLxj9
         /pNA==
X-Gm-Message-State: APjAAAXyWX3cJFUT3rNmoW39DqFdOIOoz6dFggXM5PoLrUr4rv17xWE+
        fjhgx0yELe3ChS72sy0SmYw6lE6LxAwT6vTD
X-Google-Smtp-Source: APXvYqwdd7t7IaswdXyXqA5kjVNYhyBSPsRl+F3RcDqT8xR7RAGjsPpuXPlsZ6sBEqwNKnhes7lh55vTla8gEiIU
X-Received: by 2002:a05:6000:11c4:: with SMTP id i4mr19839228wrx.277.1571667676755;
 Mon, 21 Oct 2019 07:21:16 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:20:59 +0200
In-Reply-To: <cover.1571667489.git.andreyknvl@google.com>
Message-Id: <4ae9e68ebca02f08a93ac61fe065057c9a01f0a8.1571667489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1571667489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 2/2] USB: dummy-hcd: use usb_urb_dir_in instead of usb_pipein
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fea3409112a9 ("USB: add direction bit to urb->transfer_flags") has
added a usb_urb_dir_in() helper function that can be used to determine
the direction of the URB. With that patch USB_DIR_IN control requests with
wLength == 0 are considered out requests by real USB HCDs. This patch
changes dummy-hcd to use the usb_urb_dir_in() helper to match that
behavior.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index a8f1e5707c14..4c9d1e49d5ed 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1321,7 +1321,7 @@ static int dummy_perform_transfer(struct urb *urb, struct dummy_request *req,
 	u32 this_sg;
 	bool next_sg;
 
-	to_host = usb_pipein(urb->pipe);
+	to_host = usb_urb_dir_in(urb);
 	rbuf = req->req.buf + req->req.actual;
 
 	if (!urb->num_sgs) {
@@ -1409,7 +1409,7 @@ static int transfer(struct dummy_hcd *dum_hcd, struct urb *urb,
 
 		/* FIXME update emulated data toggle too */
 
-		to_host = usb_pipein(urb->pipe);
+		to_host = usb_urb_dir_in(urb);
 		if (unlikely(len == 0))
 			is_short = 1;
 		else {
@@ -1830,7 +1830,7 @@ static void dummy_timer(struct timer_list *t)
 
 		/* find the gadget's ep for this request (if configured) */
 		address = usb_pipeendpoint (urb->pipe);
-		if (usb_pipein(urb->pipe))
+		if (usb_urb_dir_in(urb))
 			address |= USB_DIR_IN;
 		ep = find_endpoint(dum, address);
 		if (!ep) {
@@ -2385,7 +2385,7 @@ static inline ssize_t show_urb(char *buf, size_t size, struct urb *urb)
 			s = "?";
 			break;
 		 } s; }),
-		ep, ep ? (usb_pipein(urb->pipe) ? "in" : "out") : "",
+		ep, ep ? (usb_urb_dir_in(urb) ? "in" : "out") : "",
 		({ char *s; \
 		switch (usb_pipetype(urb->pipe)) { \
 		case PIPE_CONTROL: \
-- 
2.23.0.866.gb869b98d4c-goog

