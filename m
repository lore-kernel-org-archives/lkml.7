Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71298C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC232077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FvfP3DHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbfKGKK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:10:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40188 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387725AbfKGKK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:10:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id r4so2337594pfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umQYThIuCS7c9882fJTWJaLRcdLby63dTiBGU/XLOo4=;
        b=FvfP3DHO59Af1GlUM7aPeBB7H7WxgIS5YP1WOSD3ZobUgr1QxUERE7HZKul/eJkFCq
         AYC4xme6fkjU8lCSc2cLPn+hHoLUzOtjllxy+9r5XOR2yG/h5cvTsBV2D2MvzZeyHvNY
         aaiCP4p0EnCdKS20kHjpzHftOYu/zT5JD+9Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umQYThIuCS7c9882fJTWJaLRcdLby63dTiBGU/XLOo4=;
        b=VCWoY4kQTZwd3ntvwhXCPvpEHV+F7tF94ITTbPyEdDQxDsgMllb5c9zmlC8XJC//s/
         MTjYWqZSikWJNF+4MO+B3CmSjltecyroJ0AmKKfCHWZp4iJdMEvi/NGQIke3Vbg0mWUV
         VIA3COsJmJ9jpINUbB8ksjzqHCkRxeqQ6wBTxy6wLNxkdJEDDToDgXhfexh7wq9aj7EA
         eDe3bKL9I0Q3pq+CsVFzCC5rfmzejRvzR62fZ5JCJX4YuCaDXu/RBGl62nBkPTogHHVG
         5RAJ5WBMMNUvsN/2FdsprxyiYm2ueEIn055eUiSWiS7mNMujEsweNAVFTCnFqwxWyIqX
         TRQQ==
X-Gm-Message-State: APjAAAXkUHSyiGc+Ch34QFa7VWf/J/qovc5/kJqAh9MyWApe/odCygLh
        6VnNzf/T99BfW2GhnyhJhHDSKg==
X-Google-Smtp-Source: APXvYqzB390EEhabtZNegLu+AcF5HDph81Kp+QvNUBavqnqvJD61yaAO317SbJiRCO/+mp9kk980OQ==
X-Received: by 2002:a65:5a06:: with SMTP id y6mr3518613pgs.9.1573121457287;
        Thu, 07 Nov 2019 02:10:57 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id s11sm1465590pjp.26.2019.11.07.02.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 02:10:56 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        sumitg <sumitg@nvidia.com>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: v4l2-ctrl: Lock main_hdl on operations of requests_queued.
Date:   Thu,  7 Nov 2019 18:10:14 +0800
Message-Id: <20191107101016.137186-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a race condition between the list_del_init in the
v4l2_ctrl_request_complete, and the list_add_tail in the
v4l2_ctrl_request_queue, since they can be called in different thread
and the requests_queued list is not protected by a lock. This can lead
to that the v4l2_ctrl_handler is still in the requests_queued list while
the request_is_queued is already set to false, which would cause
use-after-free if the v4l2_ctrl_handler is later released.

Fix this by locking the ->lock of main_hdl (which is the owner of the
requests_queued list) when doing list operations on the
->requests_queued list.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index b4caf2d4d076..22e6c82d58b9 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -3301,6 +3301,7 @@ static void v4l2_ctrl_request_queue(struct media_request_object *obj)
 	struct v4l2_ctrl_handler *prev_hdl = NULL;
 	struct v4l2_ctrl_ref *ref_ctrl, *ref_ctrl_prev = NULL;
 
+	mutex_lock(main_hdl->lock);
 	if (list_empty(&main_hdl->requests_queued))
 		goto queue;
 
@@ -3332,18 +3333,22 @@ static void v4l2_ctrl_request_queue(struct media_request_object *obj)
 queue:
 	list_add_tail(&hdl->requests_queued, &main_hdl->requests_queued);
 	hdl->request_is_queued = true;
+	mutex_unlock(main_hdl->lock);
 }
 
 static void v4l2_ctrl_request_unbind(struct media_request_object *obj)
 {
 	struct v4l2_ctrl_handler *hdl =
 		container_of(obj, struct v4l2_ctrl_handler, req_obj);
+	struct v4l2_ctrl_handler *main_hdl = obj->priv;
 
 	list_del_init(&hdl->requests);
+	mutex_lock(main_hdl->lock);
 	if (hdl->request_is_queued) {
 		list_del_init(&hdl->requests_queued);
 		hdl->request_is_queued = false;
 	}
+	mutex_unlock(main_hdl->lock);
 }
 
 static void v4l2_ctrl_request_release(struct media_request_object *obj)
@@ -4297,9 +4302,11 @@ void v4l2_ctrl_request_complete(struct media_request *req,
 		v4l2_ctrl_unlock(ctrl);
 	}
 
+	mutex_lock(main_hdl->lock);
 	WARN_ON(!hdl->request_is_queued);
 	list_del_init(&hdl->requests_queued);
 	hdl->request_is_queued = false;
+	mutex_unlock(main_hdl->lock);
 	media_request_object_complete(obj);
 	media_request_object_put(obj);
 }

base-commit: dcd34bd234181ec74f081c7d0025204afe6b213e
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

