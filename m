Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8483C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC32420844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="YA2DhzBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfGJT1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:27:09 -0400
Received: from first.geanix.com ([116.203.34.67]:39912 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfGJT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:27:06 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 7D0B1A735;
        Wed, 10 Jul 2019 19:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562786821; bh=v4q1Pb3FKtr/egLf2/n7EYF/e9kRnCGlqq4gR1jyuio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YA2DhzBg7DAP2IaCCgT67I3qzvIWWYQ7jyZdTHzr4ksu9ArIgFHWnGFDl5PVA2J/r
         y2FO5emCmf4qsWaw1DyxKXTmwKKgGj9MnUcaF05tWJWgc5HLh4xWixnLYn/DIF88LR
         0iSMBvy72H5nflaJ4Ie6lYzlRE9mGy/z5V+VjKNP4mAMDlZsryA5yPIJMLrUBPZax5
         Y4FfE9vn0W+mVfd1Iv9rq1E9rpCEso9tr1lNxonp3ZAPnV3/aF19bOGN3K5KxMstF6
         Np3bYOKD6cnSV7Vpqn7OtQKYACuECv7o8pPxLaxuFLgh6ZBrFYenJn2YU6GKVAqQwI
         RiRYoWbVtBNPQ==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCHv3 3/4] tty: n_gsm: add helpers to convert mux-num to/from tty-base
Date:   Wed, 10 Jul 2019 21:26:55 +0200
Message-Id: <20190710192656.60381-3-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710192656.60381-1-martin@geanix.com>
References: <20190710192656.60381-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it obvious how the gsm mux number relates to the virtual tty lines
by using helper functions instead of shifting 6 bits.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---

Changes since v2:
 * use unsigned integers in both helper functions

 drivers/tty/n_gsm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c4e16b31f9ab..a60be591f1fc 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2171,6 +2171,16 @@ static inline void mux_put(struct gsm_mux *gsm)
 	kref_put(&gsm->ref, gsm_free_muxr);
 }
 
+static inline unsigned int mux_num_to_base(struct gsm_mux *gsm)
+{
+	return gsm->num * NUM_DLCI;
+}
+
+static inline unsigned int mux_line_to_num(unsigned int line)
+{
+	return line / NUM_DLCI;
+}
+
 /**
  *	gsm_alloc_mux		-	allocate a mux
  *
@@ -2351,7 +2361,8 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 
 static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
-	int ret, i, base;
+	unsigned int base;
+	int ret, i;
 
 	gsm->tty = tty_kref_get(tty);
 	gsm->output = gsmld_output;
@@ -2361,7 +2372,7 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	else {
 		/* Don't register device 0 - this is the control channel and not
 		   a usable tty interface */
-		base = gsm->num << 6; /* Base for this MUX */
+		base = mux_num_to_base(gsm); /* Base for this MUX */
 		for (i = 1; i < NUM_DLCI; i++)
 			tty_register_device(gsm_tty_driver, base + i, NULL);
 	}
@@ -2379,8 +2390,8 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 
 static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
+	unsigned int base = mux_num_to_base(gsm); /* Base for this MUX */
 	int i;
-	int base = gsm->num << 6; /* Base for this MUX */
 
 	WARN_ON(tty != gsm->tty);
 	for (i = 1; i < NUM_DLCI; i++)
@@ -2908,7 +2919,7 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	struct gsm_mux *gsm;
 	struct gsm_dlci *dlci;
 	unsigned int line = tty->index;
-	unsigned int mux = line >> 6;
+	unsigned int mux = mux_line_to_num(line);
 	bool alloc = false;
 	int ret;
 
-- 
2.22.0

