Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7589C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF18217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EgPw0s1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbfEXIz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:55:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39283 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389991AbfEXIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so13342585edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFqlt6mo9F4Pd9G7O8MT8qo6u/5jZNMJ/2yl3qsAQiY=;
        b=EgPw0s1XuffFZvuQmIb+u1grhbjqLNzg/527P2g071z9I1Srgh63ZYAtIrTqJ9/3WB
         4fGr4+vWcQgnQhJwsaUixthTYD4PW/g7mB8dJEg2qZkoDJYIjq9AS/XYnSozEbuQlWH0
         0XPhcaEJ9eNRxGY5BRpufgjXn4h9qrDKGVZ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFqlt6mo9F4Pd9G7O8MT8qo6u/5jZNMJ/2yl3qsAQiY=;
        b=tR+J1tlM3Xco3kJ4DC8vMwo+OJJIZDKgj/+sjAVLFcK9Nibu3I/xKQ8gwuX1tNbVW3
         j2E4mGm9vgczK2C+XE+dpR9hJH9RgMaVZ2QPhuVvvuxfvquvUpOdjddj6wF3SWpKnL76
         XiZlBLeVZgw1B9sCEEAVdnEzSAm0HCUms/TdnmpfCjXBjkMq1HvAyf7nT4YuTN6jjAVj
         AHqLD4n3lBL5V+VTIE97xTgPXy7EmfgpXB5OEn7V5cCICTmHMhNEJsFZ+4VzvOeyT/5v
         Ko9O5ah77x4t9hElcO6Jaz879a6RRzNYhxrlJUI8WHZHUoq0xtc7YFgru88rGChHuB2M
         Dqpg==
X-Gm-Message-State: APjAAAXfIQItPVkd1wTnsLmt+WG8BMVzTJuwsBiyQjXidCQo0awASe+n
        bigwhQgb6CAEGjeX4btujcLV645O4HM=
X-Google-Smtp-Source: APXvYqxfH4m8cM3kQ2a9m5Bu7sZt3awOs0EZLiDpP3Rw5DPOFSPeezL+a7RRX9L5t0jF0ChIS5R+Zw==
X-Received: by 2002:a50:908a:: with SMTP id c10mr102215126eda.226.1558688060655;
        Fri, 24 May 2019 01:54:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:19 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: [PATCH 14/33] staging/olpc: lock_fb_info can't fail
Date:   Fri, 24 May 2019 10:53:35 +0200
Message-Id: <20190524085354.27411-15-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply because olpc never unregisters the damn thing. It also
registers the framebuffer directly by poking around in fbdev
core internals, so it's all around rather broken.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 6b714f740ac3..a254238be181 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -250,11 +250,7 @@ static bool dcon_blank_fb(struct dcon_priv *dcon, bool blank)
 	int err;
 
 	console_lock();
-	if (!lock_fb_info(dcon->fbinfo)) {
-		console_unlock();
-		dev_err(&dcon->client->dev, "unable to lock framebuffer\n");
-		return false;
-	}
+	lock_fb_info(dcon->fbinfo);
 
 	dcon->ignore_fb_events = true;
 	err = fb_blank(dcon->fbinfo,
-- 
2.20.1

