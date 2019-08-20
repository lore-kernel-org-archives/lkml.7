Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773B5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D34122CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566294041;
	bh=i99KwOAygiGJojcIo7pV3IW0ClMi5lnMrChCPAboa5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nis+GAqJ5o7DtEs3Zn1nQbSfwSFNT1r7ECUSYJRyzsUdQlbRW8JccYlCGmN7mR+Mt
	 JBC/vV6x8j7tUIYhxlE+45GVN6sOF8gS17r8ptOk7hJUNptLE1rMy/QjZatK6UxFzw
	 KlX5R5vAP6E9V++d98fcTPx6VXCGZLiqPkmGuM28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfHTJkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:40:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33336 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfHTJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:40:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id s15so5568430edx.0;
        Tue, 20 Aug 2019 02:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMUXCb5+TixoCdCe/Ddi5TGh1mQeTH0yMrCUcqjfwn4=;
        b=piMRqED2uS4uYJQ6IO5ZBxEwvMqZitaeHWyFvn5k6O690JkO1+NxhrBlPgcBauckAg
         XZK4jN3v+cqQl9fRkU47ntfmhkFngX1TXwcmi2v4nsMJIc6Dnko0kwGHHZdMAwXJ13Gh
         M3bm61Jhvv8J6+6fIhBo+lHCu0AJdY441+y5fdwyLAn9MlOqrfggzf5c6aX4PpTK68Va
         OrZaORPRKdnGRaWs7YNfSuByqZpoPlOwqf+F3ugS03ri7ilkj+57Bx8KEg9znrY3n5nn
         5dTcmbvs521rNH7M8XpU/2FwK0GxVcd/urEtcFb2a8Y2h+e8C3jvA59CKkNvVwD3vRc9
         nsXQ==
X-Gm-Message-State: APjAAAXclE4sOle8IDPvJkYcz6Lgh0/0LEEh3cBfYe7GMpwp/qiv2FDi
        FlfaDuqDTnv2lkRdvFSPyxo=
X-Google-Smtp-Source: APXvYqyEqw/zlmW3qrpIUevhkSUtrQM3Brcy0GT+8gIBrauXNcPT8NadK8e40XErlzeDsC2RrD4bfQ==
X-Received: by 2002:a17:906:1303:: with SMTP id w3mr25512694ejb.143.1566294031409;
        Tue, 20 Aug 2019 02:40:31 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id j37sm3354259ede.23.2019.08.20.02.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:40:30 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v2 2/3] Documentation: media: Describe V4L2_CID_UNIT_CELL_SIZE
Date:   Tue, 20 Aug 2019 11:40:26 +0200
Message-Id: <20190820094027.4144-2-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820094027.4144-1-ribalda@kernel.org>
References: <20190820094027.4144-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New control to pass to userspace the width/height of a pixel. Which is
needed for calibration and lens selection.

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 Documentation/media/uapi/v4l/ext-ctrls-camera.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
index 51c1d5c9eb00..b43047d4e7a1 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
@@ -510,6 +510,14 @@ enum v4l2_scene_mode -
     value down. A value of zero stops the motion if one is in progress
     and has no effect otherwise.
 
+``V4L2_CID_UNIT_CELL_SIZE (struct)``
+    This control returns the unit cell size in nanometres. The struct provides
+    the width and the height in separated fields to take into consideration
+    asymmetric pixels and/or hardware binning.
+    The unit cell consist on the whole area of the pixel, sensitive and
+    non-sensitive.
+    This control is required for automatic calibration sensors/cameras.
+
 .. [#f1]
    This control may be changed to a menu control in the future, if more
    options are required.
-- 
2.23.0.rc1

