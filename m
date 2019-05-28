Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F792C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4539F2081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfE1Mxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:53:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfE1Mxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:53:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D58D307887C;
        Tue, 28 May 2019 12:53:41 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-29.phx2.redhat.com [10.3.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA9526B8C8;
        Tue, 28 May 2019 12:52:57 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 2E209109; Tue, 28 May 2019 09:53:03 -0300 (BRT)
Date:   Tue, 28 May 2019 09:53:03 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Luis =?iso-8859-1?Q?Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>
Subject: Re: [PATCH 25/44] tools headers UAPI: Sync drm/drm.h with the kernel
Message-ID: <20190528125303.GA2935@redhat.com>
References: <20190527223730.11474-1-acme@kernel.org>
 <20190527223730.11474-26-acme@kernel.org>
 <9dac0e36-237f-34a5-1791-e5e45e0dcc4e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dac0e36-237f-34a5-1791-e5e45e0dcc4e@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 28 May 2019 12:53:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 28, 2019 at 09:07:03AM +0100, Lionel Landwerlin escreveu:
> On 27/05/2019 23:37, Arnaldo Carvalho de Melo wrote:
> >From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> >To pick up the changes in these csets:
> >
> >   060cebb20cdb ("drm: introduce a capability flag for syncobj timeline support")
> >   50d1ebef79ef ("drm/syncobj: add timeline signal ioctl for syncobj v5")
> >   ea569910cbab ("drm/syncobj: add transition iotcls between binary and timeline v2")
> >   27b575a9aa2f ("drm/syncobj: add timeline payload query ioctl v6")
> >   01d6c3578379 ("drm/syncobj: add support for timeline point wait v8")
> >   783195ec1cad ("drm/syncobj: disable the timeline UAPI for now v2")
> >   48197bc564c7 ("drm: add syncobj timeline support v9")
> >
> >Which automagically results in the following new ioctls being recognized
> >by the 'perf trace' ioctl cmd arg beautifier:
> >
> >   $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/before
> >   $ cp include/uapi/drm/drm.h tools/include/uapi/drm/drm.h
> >   $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/after
> >   $ diff -u /tmp/before /tmp/after
> >   --- /tmp/before	2019-05-22 10:25:31.443151182 -0300
> >   +++ /tmp/after	2019-05-22 10:25:46.449354819 -0300
> >   @@ -103,6 +103,10 @@
> >    	[0xC7] = "MODE_LIST_LESSEES",
> >    	[0xC8] = "MODE_GET_LEASE",
> >    	[0xC9] = "MODE_REVOKE_LEASE",
> >   +	[0xCA] = "SYNCOBJ_TIMELINE_WAIT",
> >   +	[0xCB] = "SYNCOBJ_QUERY",
> >   +	[0xCC] = "SYNCOBJ_TRANSFER",
> >   +	[0xCD] = "SYNCOBJ_TIMELINE_SIGNAL",
> >    	[DRM_COMMAND_BASE + 0x00] = "I915_INIT",
> >    	[DRM_COMMAND_BASE + 0x01] = "I915_FLUSH",
> >    	[DRM_COMMAND_BASE + 0x02] = "I915_FLIP",
> >     $
> >
> >I.e. the strace like raw_tracepoint:sys_enter handler in 'perf trace'
> >will get the cmd integer value and map it to the string.
> >
> >At some point it should be possible to translate from string to integer
> >and use to filter using expressions such as:
> >
> >    # perf trace -e ioctl/cmd==DRM_IOCTL_SYNCOBJ*/
> >
> >Or some more suitable syntax to express that only these ioctls when
> >acting on DRM fds should be shown.
> >
> >Cc: Adrian Hunter <adrian.hunter@intel.com>
> >Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
> >Cc: Christian König <christian.koenig@amd.com>
> >Cc: Chunming Zhou <david1.zhou@amd.com>
> >Cc: Dave Airlie <airlied@redhat.com>
> >Cc: Jiri Olsa <jolsa@kernel.org>
> >Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> >Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> >Cc: Namhyung Kim <namhyung@kernel.org>
> >Link: https://lkml.kernel.org/n/tip-jrc9ogw33w4zgqc3pu7o1l3g@git.kernel.org
> >Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> 
> Acked-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>

Thank, added since I'll have to resubmit this branch.

- Arnaldo
 
> 
> >---
> >  tools/include/uapi/drm/drm.h | 37 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> >diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
> >index 300f336633f2..661d73f9a919 100644
> >--- a/tools/include/uapi/drm/drm.h
> >+++ b/tools/include/uapi/drm/drm.h
> >@@ -649,6 +649,7 @@ struct drm_gem_open {
> >  #define DRM_CAP_PAGE_FLIP_TARGET	0x11
> >  #define DRM_CAP_CRTC_IN_VBLANK_EVENT	0x12
> >  #define DRM_CAP_SYNCOBJ		0x13
> >+#define DRM_CAP_SYNCOBJ_TIMELINE	0x14
> >  /** DRM_IOCTL_GET_CAP ioctl argument type */
> >  struct drm_get_cap {
> >@@ -735,8 +736,18 @@ struct drm_syncobj_handle {
> >  	__u32 pad;
> >  };
> >+struct drm_syncobj_transfer {
> >+	__u32 src_handle;
> >+	__u32 dst_handle;
> >+	__u64 src_point;
> >+	__u64 dst_point;
> >+	__u32 flags;
> >+	__u32 pad;
> >+};
> >+
> >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
> >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
> >+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
> >  struct drm_syncobj_wait {
> >  	__u64 handles;
> >  	/* absolute timeout */
> >@@ -747,12 +758,33 @@ struct drm_syncobj_wait {
> >  	__u32 pad;
> >  };
> >+struct drm_syncobj_timeline_wait {
> >+	__u64 handles;
> >+	/* wait on specific timeline point for every handles*/
> >+	__u64 points;
> >+	/* absolute timeout */
> >+	__s64 timeout_nsec;
> >+	__u32 count_handles;
> >+	__u32 flags;
> >+	__u32 first_signaled; /* only valid when not waiting all */
> >+	__u32 pad;
> >+};
> >+
> >+
> >  struct drm_syncobj_array {
> >  	__u64 handles;
> >  	__u32 count_handles;
> >  	__u32 pad;
> >  };
> >+struct drm_syncobj_timeline_array {
> >+	__u64 handles;
> >+	__u64 points;
> >+	__u32 count_handles;
> >+	__u32 pad;
> >+};
> >+
> >+
> >  /* Query current scanout sequence number */
> >  struct drm_crtc_get_sequence {
> >  	__u32 crtc_id;		/* requested crtc_id */
> >@@ -909,6 +941,11 @@ extern "C" {
> >  #define DRM_IOCTL_MODE_GET_LEASE	DRM_IOWR(0xC8, struct drm_mode_get_lease)
> >  #define DRM_IOCTL_MODE_REVOKE_LEASE	DRM_IOWR(0xC9, struct drm_mode_revoke_lease)
> >+#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT	DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)
> >+#define DRM_IOCTL_SYNCOBJ_QUERY		DRM_IOWR(0xCB, struct drm_syncobj_timeline_array)
> >+#define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
> >+#define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
> >+
> >  /**
> >   * Device specific ioctls should only be in their respective headers
> >   * The device specific ioctl range is from 0x40 to 0x9f.
> 
