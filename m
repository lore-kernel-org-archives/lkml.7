Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB68C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FF421920
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569838025;
	bh=F7PU0XTzulJyYozp4p3TKjIBYzu0jmLbK1kiwEtvVSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z8FixojHaR9LibGgNNuqWJGY+32/YFwLPIvhkrO3PtcXfITcQUi9zHECEDCiO0WVd
	 uMXjPncCCRDl8tQiuJg/4vxp2j8uhozDNDAfN8qnvhVKQN9bNVomuBnaUsl9ueY9Pi
	 BO5KCYzlJKYuk8mthuhIyI+Wu5sgRTsc84RE1hPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfI3KHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:07:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37485 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbfI3KGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:06:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so6551997lff.4;
        Mon, 30 Sep 2019 03:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6PH07eWhP9yLzHtDWmI6SB0uTSpZSpElPRT+7mhohA=;
        b=I5kSGWKl5uvi11jzWNbvyGAwY22JtnD+UbPNRDIcCvtQGB9cZvxMbgkVX0Nyff9Jb+
         Ek5EFkxaMHktstBAxh5bC2reLysY4lHBIDiqAxzpWFrlwUMZraPrgPzxgLT6DlsYGBZw
         3GP/9GJNUUwazWRBwOsgSnN+uFmjwFZhtFCunRwPs9fBL4HmUWuseKZyoz5Afo138pXT
         AmB6jEYL/8zFQvzXPY2SsJ74KQLAn/r5GAY6GGrw6GVOvE0cxP87jth32EsdGAMvraYQ
         x4HdY7BbXToMw0KAjbKOmF6I8JAOfkitXQi2pWnzATnhad4qfrSYHRTJfX4/70I9T2if
         GkyA==
X-Gm-Message-State: APjAAAXJ9Ni6nbi3wvqKFXO8L0iFPGNo41rd0DDJV+xddSWsjUvMvVUg
        wJmdxOtEklrN5bwBLsOCFhg=
X-Google-Smtp-Source: APXvYqypY2QkKQ5WMOWTdcrWUY3bxFzsaKGZx2iwIq/euM6byPcQHqviu/TZGZMEgyMVwcBTrGiMJg==
X-Received: by 2002:ac2:5dd0:: with SMTP id x16mr11009575lfq.38.1569838011426;
        Mon, 30 Sep 2019 03:06:51 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id z72sm3091580ljb.98.2019.09.30.03.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:06:50 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v7 7/8] media: v4l2-ctrl: Add new helper v4l2_ctrl_ptr_from_void
Date:   Mon, 30 Sep 2019 12:06:35 +0200
Message-Id: <20190930100636.18318-8-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930100636.18318-1-ribalda@kernel.org>
References: <20190930100636.18318-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper function simplifies the code by not needing a union
v4l2_ctrl_ptr and an assignment every time we need to use
a ctrl_ptr.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 include/media/v4l2-ctrls.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index c42f164e2c9e..d69cfdffd41d 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -73,6 +73,17 @@ union v4l2_ctrl_ptr {
 	void *p;
 };
 
+/**
+ * v4l2_ctrl_ptr() - Helper function to return a v4l2_ctrl_ptr from a
+ * void pointer
+ * @ptr:	The void pointer
+ */
+static inline union v4l2_ctrl_ptr v4l2_ctrl_ptr_from_void(void *ptr)
+{
+	BUILD_BUG_ON(sizeof(union v4l2_ctrl_ptr) != sizeof(void *));
+	return (union v4l2_ctrl_ptr) ptr;
+}
+
 /**
  * struct v4l2_ctrl_ops - The control operations that the driver has to provide.
  *
-- 
2.23.0

