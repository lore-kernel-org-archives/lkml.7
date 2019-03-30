Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8200C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B403B2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553910874;
	bh=ArcGIucQXiy8vIZ0oY6G2rrKIztzKnNxJNPq6tvzvKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IP22oxN/UXxcMqGvSaCkponBb+1FlX5NuTDAro2siZ1jit6Sdwl2Nkgyv7lIm6NvI
	 XQZesugoGukyeZlti5O6ar5DwF6rQrMl0DMVq9no08FCU1b8krvtH3Kj6BqQWcZqQu
	 BxGv1SQPvV9H3kTT7z9OshyMVnNTl59oe24c4ADY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfC3Byd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbfC3ByG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:54:06 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F06218FD;
        Sat, 30 Mar 2019 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553910846;
        bh=ArcGIucQXiy8vIZ0oY6G2rrKIztzKnNxJNPq6tvzvKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2QGIZRIfDoKYrBtslYsiRR1FuupmI57ejxBOROi6JS+sFkL1iUMDlThgDAOJHNsA7
         GgkWxw2T3Is39S0udwOpHmFIRoas/O6izvwiivSuuCyAQfCyz7O1qbH+OJmO4YvyO7
         oQSHAJQsrk5mpo8nFw4ePqtgEem3WGT5PYdqlltM=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com,
        hverkuil@xs4all.nl
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v14 3/6] media: media.h: Enable ALSA MEDIA_INTF_T* interface types
Date:   Fri, 29 Mar 2019 19:53:58 -0600
Message-Id: <f075c37162ad557102e420a94e8ff000061cc4d4.1553909893.git.shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1553909892.git.shuah@kernel.org>
References: <cover.1553909892.git.shuah@kernel.org>
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

