Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1FBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7298522440
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj73GC1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKTAKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:10:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKTAKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:10:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so25996235wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 16:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EH7rOnQ7g6xPGxYOwqh1Gb8uspMXNY2i4VwFx06HJEE=;
        b=dj73GC1F5Fh5Tf3zQbbpg8WiBBNCBI3GCwlAk7sbVtz/KGpA3Bl/qOtb4j1jlrwe6f
         WX/qK5P9zKIAHUOmL/24N9pEaD5Lu7JyQtUETJnPgfHYjuctotFxIS4pSJ1F4Fpr6pbL
         /xbaIUIKf5yul2X/njsqyr9urCeIa+OzqvcJs0F/wiXd54jGeB2IsjJ8OL2A7EDkwaKG
         Eoh9qYopGQbz6f6g6HgG5Df+9vGNlfxP0ruoOCjh3i46OYkw/YxTk8KJWq8RjMQO8Abk
         nVra8/gxx1XwTpeRXkdkmTnhu7Jhx8pmPBma7I5mXkYXn9XcGYq5HTvR9OMqTFxF7cQ1
         23KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EH7rOnQ7g6xPGxYOwqh1Gb8uspMXNY2i4VwFx06HJEE=;
        b=Cfm7k9FfWzDagdl7JP++nlfpuRQhwagrKI6NMoll1e3QLNrINNhl0q3xDgYuxLoHyF
         0xnUwwIQSyrgD3yHFom2GNuIu0mXkT9BPivFKjXHjQSrayo5pH242qt1VYrtlrTstwH4
         W92Uo5fA1QWnCSkb3aa4U3rfLp56BhOD9BRIgoj1VlAnxo3f8AXjIZz37nYOXE59QF12
         g+J+kwd3l9hHf0g/BEL4on8e4wSnS5Wc9xVIFo+a6zPD6SnZ8voWrcqkuHD8lZ9YZgFl
         vaS7C91Y63Fq7UqG02kQUqLRSIWtJo1+cnOi8My+ycevFfcYLLon+1FIZtZiC8jveTUC
         HcUA==
X-Gm-Message-State: APjAAAWRN3EbrbmowfwDqNxTVq87Px1kTSvC0DyGGKjz3Hm3WKr9ybal
        VvFa1jRCLdv3O84+oTE3Y8oyHSe8
X-Google-Smtp-Source: APXvYqx12mAfe3E0Nz/Y65wRQjUhBvnRjTAULFvi/WFX6XDC722MHUUyEcNbvSf+N7QNC50xlpmWBQ==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr134122wrp.266.1574208598025;
        Tue, 19 Nov 2019 16:09:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40e1:9900:5dce:1599:e3b5:7d61])
        by smtp.gmail.com with ESMTPSA id n23sm4907947wmc.18.2019.11.19.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:09:57 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/crc-debugfs: fix crtc_crc_poll()'s return type
Date:   Wed, 20 Nov 2019 01:07:54 +0100
Message-Id: <20191120000754.30710-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crtc_crc_poll() is defined as returning 'unsigned int' but the
.poll method is declared as returning '__poll_t', a bitwise type.

Fix this by using the proper return type and using the EPOLL
constants instead of the POLL ones, as required for __poll_t.

CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC: Maxime Ripard <mripard@kernel.org>
CC: Sean Paul <sean@poorly.run>
CC: David Airlie <airlied@linux.ie>
CC: Daniel Vetter <daniel@ffwll.ch>
CC: dri-devel@lists.freedesktop.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/drm_debugfs_crc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index be1b7ba92ffe..0bb0aa0ebbca 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -334,17 +334,17 @@ static ssize_t crtc_crc_read(struct file *filep, char __user *user_buf,
 	return LINE_LEN(crc->values_cnt);
 }
 
-static unsigned int crtc_crc_poll(struct file *file, poll_table *wait)
+static __poll_t crtc_crc_poll(struct file *file, poll_table *wait)
 {
 	struct drm_crtc *crtc = file->f_inode->i_private;
 	struct drm_crtc_crc *crc = &crtc->crc;
-	unsigned ret;
+	__poll_t ret;
 
 	poll_wait(file, &crc->wq, wait);
 
 	spin_lock_irq(&crc->lock);
 	if (crc->source && crtc_crc_data_count(crc))
-		ret = POLLIN | POLLRDNORM;
+		ret = EPOLLIN | EPOLLRDNORM;
 	else
 		ret = 0;
 	spin_unlock_irq(&crc->lock);
-- 
2.24.0

