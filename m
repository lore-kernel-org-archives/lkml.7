Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8DBC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D491F206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i3N79/VK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfLMAHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:07:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33905 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731372AbfLMAHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so397400pln.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+W8tZR+76/3SOEa+yCA+TFETq/gLuUJazhWoeKEcbQ=;
        b=i3N79/VKKM5s+vuErhxyPFH5bQWSHeXA7dzOioNNqQpkir2N5+BcII8q7Z85CHtZR9
         cmnu8v+bXt2Fo3lRQk35XyFJcyBlWAf+qA4hJYB1sigpRgaPgvdr34XstOXB8ATnax79
         fpiGtaRi61A2DgyNt9jeuujGe7szkfj/E/b2/rhZkn6ecUEwTbpUJi6l+H8xpfhITkby
         7Ls/zPKjLeJe5BIqnS5cOnxhUzfrYAI6TNBarGsAzXk1xI67msEcvgnfCBQH4u0+50PW
         CIbjkkkHXP6hvxivvbDRKRS6vWZIw/3p/HHA2b8nJ4rrVT4hAjcosYTc07lGvg9PPo6c
         kDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+W8tZR+76/3SOEa+yCA+TFETq/gLuUJazhWoeKEcbQ=;
        b=ZuQiFKUa1h1+tp4CKxCsM1Sev19uIw+5iLdE7PkOMkJMsroes+0/+ASA1Ho7q9MIKg
         nWgHfXCgeoBD9uMUyAqLB1IvQ2r8E40dzdBBgU3OZhcF4GVeyeMmKtm++anJrkkO70+l
         XDTQbLoe34pCMlhdIqZDM0+cILxT6Dq6IHKPsQjeVIadsdaLvLFwfrzKWln5QK7Fq2TM
         Nms4fDEI9Nj+u0eXbDm9dqLrgcTgtUN0HvoAdw+tTNfNJPFu5PInDOwI+0ric9Z+dTIh
         jxkz20TrCLImCbLHYCJYQzQsswKcF6PD6Yd67XHb3jd5mhOPuC7R7qtTiLzldKyLBGRf
         Ulhg==
X-Gm-Message-State: APjAAAW4RshKHffQ5VvcNQh4uEeLWkstn3HlBWld1aYfjs2A6a5FKhRT
        HNiDZ1Vygb8R6X5dz4fK8lVWhAA7e/8=
X-Google-Smtp-Source: APXvYqyglcgVG8uTykPs/RtK48/8yucBhmlIsLJ1Wb8fQ0sFonGvHKKNmoEjySIwxVpAokjOuYlHzQ==
X-Received: by 2002:a17:90a:948a:: with SMTP id s10mr12947165pjo.140.1576195637309;
        Thu, 12 Dec 2019 16:07:17 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:16 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 01/58] sysrq: Remove sysrq_handler_registered
Date:   Fri, 13 Dec 2019 00:06:00 +0000
Message-Id: <20191213000657.931618-2-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysrq_toggle_support() can be called in parallel, in return calling
input_(un)register_handler(), which fortunately is safe to call
in parallel and regardless of registered/unregistered status of
sysrq_handler.
Remove sysrq_handler_registered as it doesn't have any function there
and may confuse reader about possible race.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/sysrq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 573b2055173c..1d4f317a0e42 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -967,8 +967,6 @@ static struct input_handler sysrq_handler = {
 	.id_table	= sysrq_ids,
 };
 
-static bool sysrq_handler_registered;
-
 static inline void sysrq_register_handler(void)
 {
 	int error;
@@ -978,16 +976,11 @@ static inline void sysrq_register_handler(void)
 	error = input_register_handler(&sysrq_handler);
 	if (error)
 		pr_err("Failed to register input handler, error %d", error);
-	else
-		sysrq_handler_registered = true;
 }
 
 static inline void sysrq_unregister_handler(void)
 {
-	if (sysrq_handler_registered) {
-		input_unregister_handler(&sysrq_handler);
-		sysrq_handler_registered = false;
-	}
+	input_unregister_handler(&sysrq_handler);
 }
 
 static int sysrq_reset_seq_param_set(const char *buffer,
-- 
2.24.0

