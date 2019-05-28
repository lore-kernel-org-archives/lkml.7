Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F044C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A09520883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfE1IHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:07:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:42867 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfE1IHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:07:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 01:07:07 -0700
X-ExtLoop1: 1
Received: from kjoyce-mobl.ger.corp.intel.com (HELO [10.252.14.75]) ([10.252.14.75])
  by fmsmga004.fm.intel.com with ESMTP; 28 May 2019 01:07:04 -0700
Subject: Re: [PATCH 25/44] tools headers UAPI: Sync drm/drm.h with the kernel
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        =?UTF-8?Q?Luis_Cl=c3=a1udio_Gon=c3=a7alves?= <lclaudio@redhat.com>
References: <20190527223730.11474-1-acme@kernel.org>
 <20190527223730.11474-26-acme@kernel.org>
From:   Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
 Swindon SN3 1RJ
Message-ID: <9dac0e36-237f-34a5-1791-e5e45e0dcc4e@intel.com>
Date:   Tue, 28 May 2019 09:07:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190527223730.11474-26-acme@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2019 23:37, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> To pick up the changes in these csets:
>
>    060cebb20cdb ("drm: introduce a capability flag for syncobj timeline support")
>    50d1ebef79ef ("drm/syncobj: add timeline signal ioctl for syncobj v5")
>    ea569910cbab ("drm/syncobj: add transition iotcls between binary and timeline v2")
>    27b575a9aa2f ("drm/syncobj: add timeline payload query ioctl v6")
>    01d6c3578379 ("drm/syncobj: add support for timeline point wait v8")
>    783195ec1cad ("drm/syncobj: disable the timeline UAPI for now v2")
>    48197bc564c7 ("drm: add syncobj timeline support v9")
>
> Which automagically results in the following new ioctls being recognized
> by the 'perf trace' ioctl cmd arg beautifier:
>
>    $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/before
>    $ cp include/uapi/drm/drm.h tools/include/uapi/drm/drm.h
>    $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/after
>    $ diff -u /tmp/before /tmp/after
>    --- /tmp/before	2019-05-22 10:25:31.443151182 -0300
>    +++ /tmp/after	2019-05-22 10:25:46.449354819 -0300
>    @@ -103,6 +103,10 @@
>     	[0xC7] = "MODE_LIST_LESSEES",
>     	[0xC8] = "MODE_GET_LEASE",
>     	[0xC9] = "MODE_REVOKE_LEASE",
>    +	[0xCA] = "SYNCOBJ_TIMELINE_WAIT",
>    +	[0xCB] = "SYNCOBJ_QUERY",
>    +	[0xCC] = "SYNCOBJ_TRANSFER",
>    +	[0xCD] = "SYNCOBJ_TIMELINE_SIGNAL",
>     	[DRM_COMMAND_BASE + 0x00] = "I915_INIT",
>     	[DRM_COMMAND_BASE + 0x01] = "I915_FLUSH",
>     	[DRM_COMMAND_BASE + 0x02] = "I915_FLIP",
>      $
>
> I.e. the strace like raw_tracepoint:sys_enter handler in 'perf trace'
> will get the cmd integer value and map it to the string.
>
> At some point it should be possible to translate from string to integer
> and use to filter using expressions such as:
>
>     # perf trace -e ioctl/cmd==DRM_IOCTL_SYNCOBJ*/
>
> Or some more suitable syntax to express that only these ioctls when
> acting on DRM fds should be shown.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Chunming Zhou <david1.zhou@amd.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-jrc9ogw33w4zgqc3pu7o1l3g@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>


Acked-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>


> ---
>   tools/include/uapi/drm/drm.h | 37 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
> index 300f336633f2..661d73f9a919 100644
> --- a/tools/include/uapi/drm/drm.h
> +++ b/tools/include/uapi/drm/drm.h
> @@ -649,6 +649,7 @@ struct drm_gem_open {
>   #define DRM_CAP_PAGE_FLIP_TARGET	0x11
>   #define DRM_CAP_CRTC_IN_VBLANK_EVENT	0x12
>   #define DRM_CAP_SYNCOBJ		0x13
> +#define DRM_CAP_SYNCOBJ_TIMELINE	0x14
>   
>   /** DRM_IOCTL_GET_CAP ioctl argument type */
>   struct drm_get_cap {
> @@ -735,8 +736,18 @@ struct drm_syncobj_handle {
>   	__u32 pad;
>   };
>   
> +struct drm_syncobj_transfer {
> +	__u32 src_handle;
> +	__u32 dst_handle;
> +	__u64 src_point;
> +	__u64 dst_point;
> +	__u32 flags;
> +	__u32 pad;
> +};
> +
>   #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>   #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
> +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
>   struct drm_syncobj_wait {
>   	__u64 handles;
>   	/* absolute timeout */
> @@ -747,12 +758,33 @@ struct drm_syncobj_wait {
>   	__u32 pad;
>   };
>   
> +struct drm_syncobj_timeline_wait {
> +	__u64 handles;
> +	/* wait on specific timeline point for every handles*/
> +	__u64 points;
> +	/* absolute timeout */
> +	__s64 timeout_nsec;
> +	__u32 count_handles;
> +	__u32 flags;
> +	__u32 first_signaled; /* only valid when not waiting all */
> +	__u32 pad;
> +};
> +
> +
>   struct drm_syncobj_array {
>   	__u64 handles;
>   	__u32 count_handles;
>   	__u32 pad;
>   };
>   
> +struct drm_syncobj_timeline_array {
> +	__u64 handles;
> +	__u64 points;
> +	__u32 count_handles;
> +	__u32 pad;
> +};
> +
> +
>   /* Query current scanout sequence number */
>   struct drm_crtc_get_sequence {
>   	__u32 crtc_id;		/* requested crtc_id */
> @@ -909,6 +941,11 @@ extern "C" {
>   #define DRM_IOCTL_MODE_GET_LEASE	DRM_IOWR(0xC8, struct drm_mode_get_lease)
>   #define DRM_IOCTL_MODE_REVOKE_LEASE	DRM_IOWR(0xC9, struct drm_mode_revoke_lease)
>   
> +#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT	DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)
> +#define DRM_IOCTL_SYNCOBJ_QUERY		DRM_IOWR(0xCB, struct drm_syncobj_timeline_array)
> +#define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
> +#define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
> +
>   /**
>    * Device specific ioctls should only be in their respective headers
>    * The device specific ioctl range is from 0x40 to 0x9f.


