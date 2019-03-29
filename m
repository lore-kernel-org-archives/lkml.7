Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C61C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE638218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553817912;
	bh=ArcGIucQXiy8vIZ0oY6G2rrKIztzKnNxJNPq6tvzvKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=agisj4ScazImDE7YRiLbfcsYCpkLbh6HlAvGoSSEUcuEgwn71A2WD+a89Z0WWJx9c
	 x9cESVhtnxd8QcmIH0rPAOiEZcvbzuh9M9JCkTxIxVAPvn7bcJF8NAAMZ8jkVzjq6O
	 mm4z9sRQbLEd5T8M/iEiRXvptV4FHP15nE1NJkIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfC2AFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbfC2AFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:05:08 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F9F218AE;
        Fri, 29 Mar 2019 00:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553817908;
        bh=ArcGIucQXiy8vIZ0oY6G2rrKIztzKnNxJNPq6tvzvKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMfB4MN+636MOFX3cDJC3oJTLlPbLgugUq8CoWv9N35l6Ng4w0cSJ4spQn8VoVpXX
         vbFQLQkCeRXnPeGFoxOAWoiDS4H/tvl3EG/K+ceI6nw22HYr3TOL7hN3X9M+k5vkxe
         vFSd3D7uj+IrUj2q+TWj6K1Vdqm/m+YVDOfjZIpQ=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com,
        hverkuil@xs4all.nl
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v13 3/6] media: media.h: Enable ALSA MEDIA_INTF_T* interface types
Date:   Thu, 28 Mar 2019 18:04:58 -0600
Message-Id: <4324ac217b1f2e2b99fe91760b5d50f612671f5c.1553814518.git.shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1553814518.git.shuah@kernel.org>
References: <cover.1553814518.git.shuah@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move PCM_CAPTURE, PCM_PLAYBACK, and CONTROL ALSA MEDIA_INTF_T* interface
types back into __KERNEL__ scope to get ready for adding ALSA support for
these to the media controller.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 include/uapi/linux/media.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index e5d0c5c611b5..9aedb187bc48 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -262,6 +262,11 @@ struct media_links_enum {
 #define MEDIA_INTF_T_V4L_SWRADIO		(MEDIA_INTF_T_V4L_BASE + 4)
 #define MEDIA_INTF_T_V4L_TOUCH			(MEDIA_INTF_T_V4L_BASE + 5)
 
+#define MEDIA_INTF_T_ALSA_BASE			0x00000300
+#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
+#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
+#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
+
 #if defined(__KERNEL__)
 
 /*
@@ -413,19 +418,19 @@ struct media_v2_topology {
 #define MEDIA_ENT_F_DTV_DECODER			MEDIA_ENT_F_DV_DECODER
 
 /*
- * There is still no ALSA support in the media controller. These
+ * There is still no full ALSA support in the media controller. These
  * defines should not have been added and we leave them here only
  * in case some application tries to use these defines.
+ *
+ * The ALSA defines that are in use have been moved into __KERNEL__
+ * scope. As support gets added to these interface types, they should
+ * be moved into __KERNEL__ scope with the code that uses them.
  */
-#define MEDIA_INTF_T_ALSA_BASE			0x00000300
-#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
-#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
-#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
-#define MEDIA_INTF_T_ALSA_COMPRESS		(MEDIA_INTF_T_ALSA_BASE + 3)
-#define MEDIA_INTF_T_ALSA_RAWMIDI		(MEDIA_INTF_T_ALSA_BASE + 4)
-#define MEDIA_INTF_T_ALSA_HWDEP			(MEDIA_INTF_T_ALSA_BASE + 5)
-#define MEDIA_INTF_T_ALSA_SEQUENCER		(MEDIA_INTF_T_ALSA_BASE + 6)
-#define MEDIA_INTF_T_ALSA_TIMER			(MEDIA_INTF_T_ALSA_BASE + 7)
+#define MEDIA_INTF_T_ALSA_COMPRESS             (MEDIA_INTF_T_ALSA_BASE + 3)
+#define MEDIA_INTF_T_ALSA_RAWMIDI              (MEDIA_INTF_T_ALSA_BASE + 4)
+#define MEDIA_INTF_T_ALSA_HWDEP                (MEDIA_INTF_T_ALSA_BASE + 5)
+#define MEDIA_INTF_T_ALSA_SEQUENCER            (MEDIA_INTF_T_ALSA_BASE + 6)
+#define MEDIA_INTF_T_ALSA_TIMER                (MEDIA_INTF_T_ALSA_BASE + 7)
 
 /* Obsolete symbol for media_version, no longer used in the kernel */
 #define MEDIA_API_VERSION			((0 << 16) | (1 << 8) | 0)
-- 
2.17.1

