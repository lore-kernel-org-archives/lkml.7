Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120432084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfDZO75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:59:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35537 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfDZO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:59:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so4862531wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0F1ut/UAEkuWPG6wyrTkb2MOpdQOgWB7mvJpKTT59BU=;
        b=cbZF2mealvJmkaoI/VLTVN/tRLIg6rBlqW1aF2UT96drS7lZo/sO4Hhj3Xrnj2+6pf
         B33nQjyZhp7EJ3j34ucYdz4JOk1bm1HerEQzZ2beceuXVdHz5RKemEV0WZlxqtcujptk
         MqyIbGYVvBFt/nfgqPReroeMxKsCdpSsJYf+Yr/iqh2zM2LMCNgZeE2WLGUJRKE/IUqL
         pLDf/NN9m6I0m3hxW0VxU7eZlzqbdBBfS3O6kTtl1E7BaTrF1+MrH2uTtAZoqRNMjH7I
         WJMz4buupEVtDKcpQQfW75Y533L7yIs8D+wIBcOGnCFF3C0uD9IwYYrNUFdhq4pKfsXo
         hZ7Q==
X-Gm-Message-State: APjAAAWMnY5mET839r3yVuzRanAFKXIWm3fXu3hSYuIv48U8GSbw39dc
        ac++5T8QxoPUMashssKnYUioMrlEly9zCQ==
X-Google-Smtp-Source: APXvYqxEDHX3RX1VU3ahGAdeJZGdA9q1eCc3kzTBPkzej1x+UXiJVhjEQMMD3k/lpzctoYR3HN2EUg==
X-Received: by 2002:a7b:c053:: with SMTP id u19mr7711277wmc.63.1556290795318;
        Fri, 26 Apr 2019 07:59:55 -0700 (PDT)
Received: from dhcp129-106.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.googlemail.com with ESMTPSA id h123sm6572282wme.6.2019.04.26.07.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:59:54 -0700 (PDT)
From:   Grzegorz Halat <ghalat@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-fbdev@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>
Subject: [PATCH] vt/fbcon: deinitialize resources in visual_init() after failed memory allocation
Date:   Fri, 26 Apr 2019 16:59:46 +0200
Message-Id: <20190426145946.26537-1-ghalat@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After memory allocation failure vc_allocate() doesn't clean up data
which has been initialized in visual_init(). In case of fbcon this
leads to divide-by-0 in fbcon_init() on next open of the same tty.

memory allocation in vc_allocate() may fail here:
1097:     vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);

on next open() fbcon_init() skips vc_font.data initialization:
1088:     if (!p->fontdata) {

division by zero in fbcon_init() happens here:
1149:     new_cols /= vc->vc_font.width;

Additional check is needed in fbcon_deinit() to prevent
usage of uninitialized vc_screenbuf:

1251:        if (vc->vc_hi_font_mask && vc->vc_screenbuf)
1252:                set_vc_hi_font(vc, false);

Crash:

 #6 [ffffc90001eafa60] divide_error at ffffffff81a00be4
    [exception RIP: fbcon_init+463]
    RIP: ffffffff814b860f  RSP: ffffc90001eafb18  RFLAGS: 00010246
...
 #7 [ffffc90001eafb60] visual_init at ffffffff8154c36e
 #8 [ffffc90001eafb80] vc_allocate at ffffffff8154f53c
 #9 [ffffc90001eafbc8] con_install at ffffffff8154f624
...

Signed-off-by: Grzegorz Halat <ghalat@redhat.com>
---
 drivers/tty/vt/vt.c              | 11 +++++++++--
 drivers/video/fbdev/core/fbcon.c |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 650c66886c80..ec85d195678f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1056,6 +1056,13 @@ static void visual_init(struct vc_data *vc, int num, int init)
 	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
 }
 
+
+static void visual_deinit(struct vc_data *vc)
+{
+	vc->vc_sw->con_deinit(vc);
+	module_put(vc->vc_sw->owner);
+}
+
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
 {
 	struct vt_notifier_param param;
@@ -1103,6 +1110,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 
 	return 0;
 err_free:
+	visual_deinit(vc);
 	kfree(vc);
 	vc_cons[currcons].d = NULL;
 	return -ENOMEM;
@@ -1331,9 +1339,8 @@ struct vc_data *vc_deallocate(unsigned int currcons)
 		param.vc = vc = vc_cons[currcons].d;
 		atomic_notifier_call_chain(&vt_notifier_list, VT_DEALLOCATE, &param);
 		vcs_remove_sysfs(currcons);
-		vc->vc_sw->con_deinit(vc);
+		visual_deinit(vc);
 		put_pid(vc->vt_pid);
-		module_put(vc->vc_sw->owner);
 		vc_uniscr_set(vc, NULL);
 		kfree(vc->vc_screenbuf);
 		vc_cons[currcons].d = NULL;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cd059a801662..c59b23f6e9ba 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1248,7 +1248,7 @@ static void fbcon_deinit(struct vc_data *vc)
 	if (free_font)
 		vc->vc_font.data = NULL;
 
-	if (vc->vc_hi_font_mask)
+	if (vc->vc_hi_font_mask && vc->vc_screenbuf)
 		set_vc_hi_font(vc, false);
 
 	if (!con_is_bound(&fb_con))
-- 
2.20.1

