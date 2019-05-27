Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8F5C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71BB20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996783;
	bh=116yu8MGJ6NmEZeZ3X44z8dgy57jsma0a24KeYgeLRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZXsf8n1wZ3kM54vH/VWPIYLzpgXgGp5MPfh/vTpGzF4af78lWPMOpJBizyuxkC2H8
	 extBO7rOU7SUpUWHcW0Wsf+irsJHomAExSVjSa3Ksj2knXNi1nI2kt8Tio0mUhuIPs
	 3l0y7PSZA82DFY9n/UwpM7zPpey/U30ZvfEwSslA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfE0Wjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbfE0Wjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:39:41 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B8E208C3;
        Mon, 27 May 2019 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996780;
        bh=116yu8MGJ6NmEZeZ3X44z8dgy57jsma0a24KeYgeLRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlT94mmexrSXK420MD+MrPX6UPOaOrs/RoEszSThr7UXdvxkrifVTgYmymVGRIfKW
         V+CNYTR3UXYK7HCQoMiC/bhEZhRideIBhy0qgVqXqLCBvOzKtpJSCCd+cbAxPYCy16
         EPAI6RZczdc+WMKwc7mWAING7YRPqZg3HPftEA7U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 25/44] tools headers UAPI: Sync drm/drm.h with the kernel
Date:   Mon, 27 May 2019 19:37:11 -0300
Message-Id: <20190527223730.11474-26-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in these csets:

  060cebb20cdb ("drm: introduce a capability flag for syncobj timeline support")
  50d1ebef79ef ("drm/syncobj: add timeline signal ioctl for syncobj v5")
  ea569910cbab ("drm/syncobj: add transition iotcls between binary and timeline v2")
  27b575a9aa2f ("drm/syncobj: add timeline payload query ioctl v6")
  01d6c3578379 ("drm/syncobj: add support for timeline point wait v8")
  783195ec1cad ("drm/syncobj: disable the timeline UAPI for now v2")
  48197bc564c7 ("drm: add syncobj timeline support v9")

Which automagically results in the following new ioctls being recognized
by the 'perf trace' ioctl cmd arg beautifier:

  $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/before
  $ cp include/uapi/drm/drm.h tools/include/uapi/drm/drm.h
  $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/after
  $ diff -u /tmp/before /tmp/after
  --- /tmp/before	2019-05-22 10:25:31.443151182 -0300
  +++ /tmp/after	2019-05-22 10:25:46.449354819 -0300
  @@ -103,6 +103,10 @@
   	[0xC7] = "MODE_LIST_LESSEES",
   	[0xC8] = "MODE_GET_LEASE",
   	[0xC9] = "MODE_REVOKE_LEASE",
  +	[0xCA] = "SYNCOBJ_TIMELINE_WAIT",
  +	[0xCB] = "SYNCOBJ_QUERY",
  +	[0xCC] = "SYNCOBJ_TRANSFER",
  +	[0xCD] = "SYNCOBJ_TIMELINE_SIGNAL",
   	[DRM_COMMAND_BASE + 0x00] = "I915_INIT",
   	[DRM_COMMAND_BASE + 0x01] = "I915_FLUSH",
   	[DRM_COMMAND_BASE + 0x02] = "I915_FLIP",
    $

I.e. the strace like raw_tracepoint:sys_enter handler in 'perf trace'
will get the cmd integer value and map it to the string.

At some point it should be possible to translate from string to integer
and use to filter using expressions such as:

   # perf trace -e ioctl/cmd==DRM_IOCTL_SYNCOBJ*/

Or some more suitable syntax to express that only these ioctls when
acting on DRM fds should be shown.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-jrc9ogw33w4zgqc3pu7o1l3g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 300f336633f2..661d73f9a919 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -649,6 +649,7 @@ struct drm_gem_open {
 #define DRM_CAP_PAGE_FLIP_TARGET	0x11
 #define DRM_CAP_CRTC_IN_VBLANK_EVENT	0x12
 #define DRM_CAP_SYNCOBJ		0x13
+#define DRM_CAP_SYNCOBJ_TIMELINE	0x14
 
 /** DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {
@@ -735,8 +736,18 @@ struct drm_syncobj_handle {
 	__u32 pad;
 };
 
+struct drm_syncobj_transfer {
+	__u32 src_handle;
+	__u32 dst_handle;
+	__u64 src_point;
+	__u64 dst_point;
+	__u32 flags;
+	__u32 pad;
+};
+
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
 struct drm_syncobj_wait {
 	__u64 handles;
 	/* absolute timeout */
@@ -747,12 +758,33 @@ struct drm_syncobj_wait {
 	__u32 pad;
 };
 
+struct drm_syncobj_timeline_wait {
+	__u64 handles;
+	/* wait on specific timeline point for every handles*/
+	__u64 points;
+	/* absolute timeout */
+	__s64 timeout_nsec;
+	__u32 count_handles;
+	__u32 flags;
+	__u32 first_signaled; /* only valid when not waiting all */
+	__u32 pad;
+};
+
+
 struct drm_syncobj_array {
 	__u64 handles;
 	__u32 count_handles;
 	__u32 pad;
 };
 
+struct drm_syncobj_timeline_array {
+	__u64 handles;
+	__u64 points;
+	__u32 count_handles;
+	__u32 pad;
+};
+
+
 /* Query current scanout sequence number */
 struct drm_crtc_get_sequence {
 	__u32 crtc_id;		/* requested crtc_id */
@@ -909,6 +941,11 @@ extern "C" {
 #define DRM_IOCTL_MODE_GET_LEASE	DRM_IOWR(0xC8, struct drm_mode_get_lease)
 #define DRM_IOCTL_MODE_REVOKE_LEASE	DRM_IOWR(0xC9, struct drm_mode_revoke_lease)
 
+#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT	DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)
+#define DRM_IOCTL_SYNCOBJ_QUERY		DRM_IOWR(0xCB, struct drm_syncobj_timeline_array)
+#define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
+#define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
+
 /**
  * Device specific ioctls should only be in their respective headers
  * The device specific ioctl range is from 0x40 to 0x9f.
-- 
2.20.1

