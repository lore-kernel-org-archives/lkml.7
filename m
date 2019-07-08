Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F409EC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA48321783
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="T0o0S3TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390439AbfGHTD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:03:28 -0400
Received: from first.geanix.com ([116.203.34.67]:59828 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbfGHTDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:03:16 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 572EEA724;
        Mon,  8 Jul 2019 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562612508; bh=RvVOJWjkEeJ3YYiPO/wa5yPU5mMrmddO6c4eYyth5Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T0o0S3TNnyoNYKODjFzhKBNIgIJCd5+ANVjB0KSYw54GzZaW8UFI32nI00aQnixj2
         PsPKTBfYETp/yyK1rQ/RdOST9WYAzaOm5wN7rXb1bFVDrG2jWzVGXtArFm6mJ2XK1V
         rEJEaqBPRqm8K7CKfH9g0aVK/g/QN2EKfNpSJkjbz6ZlonB1PxrogWTY85T7D7k3lN
         UrAiCRmYJTuLy/AJv9rR41Yo+wLwboGrXxHZEbMuHATOFNpXQ9qTNVZE5T4iEaK58E
         U162ehoTMyFHtmKIBbNWqiAoY5E1MaXbtg4Fu8sgQM0w9dUyf55fGH7Hz8mPZe4be6
         Q7uf+Fg+RoZ6A==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCH 3/4] tty: n_gsm: add helper to convert mux-num to/from tty-base
Date:   Mon,  8 Jul 2019 21:02:51 +0200
Message-Id: <20190708190252.24628-3-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708190252.24628-1-martin@geanix.com>
References: <20190708190252.24628-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it obvious how the gsm mux number relates to the virtual tty lines
by using helper function instead of shifting 6 bits.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/tty/n_gsm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c4e16b31f9ab..cba06063c44a 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2171,6 +2171,16 @@ static inline void mux_put(struct gsm_mux *gsm)
 	kref_put(&gsm->ref, gsm_free_muxr);
 }
 
+static inline int mux_num_to_base(struct gsm_mux *gsm)
+{
+	return gsm->num * NUM_DLCI;
+}
+
+static inline unsigned int mux_line_to_num(int line)
+{
+	return line / NUM_DLCI;
+}
+
 /**
  *	gsm_alloc_mux		-	allocate a mux
  *
@@ -2361,7 +2371,7 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	else {
 		/* Don't register device 0 - this is the control channel and not
 		   a usable tty interface */
-		base = gsm->num << 6; /* Base for this MUX */
+		base = mux_num_to_base(gsm); /* Base for this MUX */
 		for (i = 1; i < NUM_DLCI; i++)
 			tty_register_device(gsm_tty_driver, base + i, NULL);
 	}
@@ -2380,7 +2390,7 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
 	int i;
-	int base = gsm->num << 6; /* Base for this MUX */
+	int base = mux_num_to_base(gsm); /* Base for this MUX */
 
 	WARN_ON(tty != gsm->tty);
 	for (i = 1; i < NUM_DLCI; i++)
@@ -2908,7 +2918,7 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	struct gsm_mux *gsm;
 	struct gsm_dlci *dlci;
 	unsigned int line = tty->index;
-	unsigned int mux = line >> 6;
+	unsigned int mux = mux_line_to_num(line);
 	bool alloc = false;
 	int ret;
 
-- 
2.22.0

