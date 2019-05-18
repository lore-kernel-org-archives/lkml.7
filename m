Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDFDC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 13:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4092087B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 13:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkuUTahe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfERNja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 09:39:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44570 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfERNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 09:39:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id w25so6152484qkj.11;
        Sat, 18 May 2019 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cU+qKwhZqv/9+fPze2fRcTZthDOWPHKe3C4Tb0IYpw8=;
        b=KkuUTahei+R1PJk1d7z2j6n11wdQG7SsSjNhNGcmBcGeQIgCIm+NjmzigzWZNrxK9b
         dN5Rp/cjL4AE61XggsRU1VmoJdj0z/57Tu2hOSMFq6/6PwpRc/eM5Adsn9aCMUGwlwym
         0LrJEDibsCn8gx5nMBAuWUY7EUoogTH1yLszU52MOPVwwLo1ehUG+F2xbHUDH5AqdCDt
         FSCbLMOlyg15CFnBnlOsMe/VKqEnZ/RLN0g+kYsQsx9t8ksd33jn7Ekvp2lhwTxDEahr
         DXDpMrscv8plhjXxSJmGf4Ur9HrO5VqenFsTkF4GVFVDE5U+CUHPVPma9y22egED+jBA
         B1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cU+qKwhZqv/9+fPze2fRcTZthDOWPHKe3C4Tb0IYpw8=;
        b=seOz4utxzh3S1TNdF8s4E5QAn/pcU35D3wSnerytizd4KbWrf17xLxf+uVVJd3Mxku
         JF5avXwilssyFR1s+26a+Aiwn3o10Dph5K+Y7IIm+Ny7AIO3i6DcJCBdXtzws9YWU5Ic
         1BhOUSciSClWa1RI416QJcpYwRULMp1oDy/hEK2njw73caURhg74b4ZgQD5DW9d4X/Qx
         pduEAl1IziQ3qQGWIYWoqnq0HghYjSA5dqzE3JAVruEYSaQewCao12mr1HDGkDNg6tJC
         sP0LIVr3BC+qyYejqIMGjQGHt5gehr8S4SRRLGpZQmUSruxobZqIWU83X7iISBx8bQBq
         mLsg==
X-Gm-Message-State: APjAAAVAXGVLQGF+AmY398eiupWJqDwoFp8Gr2rXAlhwASD9TrUh5Evo
        iXrePyIO9HVN1wtRMD/Py98=
X-Google-Smtp-Source: APXvYqwiq5iV6Kqrkh/uVWu1ECOgYUDS+OpqoUZP5M/gf/dxL9N/eaRCWhhkY6qPOMF1LMm4wGmx+Q==
X-Received: by 2002:a37:b1c5:: with SMTP id a188mr28612724qkf.51.1558186767619;
        Sat, 18 May 2019 06:39:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id s7sm5394578qkg.70.2019.05.18.06.39.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 06:39:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F1F83404A1; Sat, 18 May 2019 10:39:23 -0300 (-03)
Date:   Sat, 18 May 2019 10:39:23 -0300
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Donald Yandt <donald.yandt@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <ren_guo@c-sky.com>, Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mao Han <han_mao@c-sky.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] tools/headers: Synchronize kernel ABI headers
Message-ID: <20190518133923.GA7969@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
 <20190518084223.GB85914@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518084223.GB85914@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 18, 2019 at 10:42:23AM +0200, Ingo Molnar escreveu:
> Pick up the latest v5.2-to-be kernel ABI headers and synchronize them with tooling:
> 
>  - arch/x86/entry/syscalls/syscall_64.tbl   => tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  # new syscalls
>  - arch/x86/include/asm/cpufeatures.h       => tools/arch/x86/include/asm/cpufeatures.h           # new CPUID flags
>  - include/uapi/drm/drm.h                   => tools/include/uapi/drm/drm.h                       # new 'syncobj' DRM ABI
>  - include/uapi/drm/i915_drm.h              => tools/include/uapi/drm/i915_drm.h                  # new extensible DRM ABI
>  - include/uapi/linux/fcntl.h               => tools/include/uapi/linux/fcntl.h                   # new AT_RECURSIVE
>  - include/uapi/linux/fs.h                  => tools/include/uapi/linux/fs.h                      # new SYNC_FILE_RANGE_WRITE_AND_WAIT
>  - include/uapi/linux/mount.h               => tools/include/uapi/linux/mount.h                   # new VFS system calls: fspick, fsmount, fsconfig, fsopen, move_mount, open_tree
>  - include/uapi/linux/sched.h               => tools/include/uapi/linux/sched.h                   # new CLONE_PIDFD
> 
> All of these are new ABI additions with no impact on existing tooling,

There is some impact in a number of them, for instance:

[acme@quaco perf]$ diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
--- tools/perf/arch/x86/entry/syscalls/syscall_64.tbl	2019-05-13 14:46:03.915894924 -0300
+++ arch/x86/entry/syscalls/syscall_64.tbl	2019-05-18 10:27:04.273395657 -0300
@@ -343,6 +343,12 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+335	common	open_tree		__x64_sys_open_tree
+336	common	move_mount		__x64_sys_move_mount
+337	common	fsopen			__x64_sys_fsopen
+338	common	fsconfig		__x64_sys_fsconfig
+339	common	fsmount			__x64_sys_fsmount
+340	common	fspick			__x64_sys_fspick
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
[acme@quaco perf]$

These will enable 'perf trace' to know about these syscalls, i.e. we
will be able to say:

    perf trace -e fs*

And have it trace just those fsopen, fsconfig, fsmount and fspick
syscalls (or any other that starts with fs, that is). Looking at this
makes one think if we should have a new syscall group like we have here:

[acme@quaco perf]$ ls -la tools/perf/trace/strace/groups/
total 16
drwxrwxr-x. 2 acme acme 4096 May 13 14:46 .
drwxrwxr-x. 3 acme acme 4096 Apr 10 10:20 ..
-rw-rw-r--. 1 acme acme  136 May 13 14:46 file
-rw-rw-r--. 1 acme acme  584 May 13 14:46 string
[acme@quaco perf]$ 

One for file oriented syscalls, the other for syscalls that operate on
strings (pathnames, etc).

That i915_drm.h looks related to:

[acme@quaco perf]$ tools/perf/trace/beauty/drm_ioctl.sh  | head
#ifndef DRM_COMMAND_BASE
#define DRM_COMMAND_BASE                0x40
#endif
static const char *drm_ioctl_cmds[] = {
	[0x00] = "VERSION",
	[0x01] = "GET_UNIQUE",
	[0x02] = "GET_MAGIC",
	[0x03] = "IRQ_BUSID",
	[0x04] = "GET_MAP",
	[0x05] = "GET_CLIENT",
[acme@quaco perf]$ tools/perf/trace/beauty/drm_ioctl.sh  | tail
	[DRM_COMMAND_BASE + 0x31] = "I915_REG_READ",
	[DRM_COMMAND_BASE + 0x32] = "I915_GET_RESET_STATS",
	[DRM_COMMAND_BASE + 0x33] = "I915_GEM_USERPTR",
	[DRM_COMMAND_BASE + 0x34] = "I915_GEM_CONTEXT_GETPARAM",
	[DRM_COMMAND_BASE + 0x35] = "I915_GEM_CONTEXT_SETPARAM",
	[DRM_COMMAND_BASE + 0x36] = "I915_PERF_OPEN",
	[DRM_COMMAND_BASE + 0x37] = "I915_PERF_ADD_CONFIG",
	[DRM_COMMAND_BASE + 0x38] = "I915_PERF_REMOVE_CONFIG",
	[DRM_COMMAND_BASE + 0x39] = "I915_QUERY",
};
[acme@quaco perf]$

So I'll check that tools/perf/trace/beauty/drm_ioctl.sh is sane wrt any
new additions to that header, ditto for the other headers, I'll go thru
them soon.

- Arnaldo


> so we copy the kernel headers with no other changes necessary.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  tools/arch/x86/include/asm/cpufeatures.h          |   3 +
>  tools/include/uapi/drm/drm.h                      |  37 ++++
>  tools/include/uapi/drm/i915_drm.h                 | 254 +++++++++++++++-------
>  tools/include/uapi/linux/fcntl.h                  |   2 +
>  tools/include/uapi/linux/fs.h                     |   3 +
>  tools/include/uapi/linux/mount.h                  |  62 ++++++
>  tools/include/uapi/linux/sched.h                  |   1 +
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |   6 +
>  8 files changed, 295 insertions(+), 73 deletions(-)
> 
> diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
> index 981ff9479648..75f27ee2c263 100644
> --- a/tools/arch/x86/include/asm/cpufeatures.h
> +++ b/tools/arch/x86/include/asm/cpufeatures.h
> @@ -344,6 +344,7 @@
>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
>  #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
>  #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
> +#define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
>  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
>  #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
>  #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
> @@ -382,5 +383,7 @@
>  #define X86_BUG_SPECTRE_V2		X86_BUG(16) /* CPU is affected by Spectre variant 2 attack with indirect branches */
>  #define X86_BUG_SPEC_STORE_BYPASS	X86_BUG(17) /* CPU is affected by speculative store bypass attack */
>  #define X86_BUG_L1TF			X86_BUG(18) /* CPU is affected by L1 Terminal Fault */
> +#define X86_BUG_MDS			X86_BUG(19) /* CPU is affected by Microarchitectural data sampling */
> +#define X86_BUG_MSBDS_ONLY		X86_BUG(20) /* CPU is only affected by the  MSDBS variant of BUG_MDS */
>  
>  #endif /* _ASM_X86_CPUFEATURES_H */
> diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
> index 300f336633f2..661d73f9a919 100644
> --- a/tools/include/uapi/drm/drm.h
> +++ b/tools/include/uapi/drm/drm.h
> @@ -649,6 +649,7 @@ struct drm_gem_open {
>  #define DRM_CAP_PAGE_FLIP_TARGET	0x11
>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT	0x12
>  #define DRM_CAP_SYNCOBJ		0x13
> +#define DRM_CAP_SYNCOBJ_TIMELINE	0x14
>  
>  /** DRM_IOCTL_GET_CAP ioctl argument type */
>  struct drm_get_cap {
> @@ -735,8 +736,18 @@ struct drm_syncobj_handle {
>  	__u32 pad;
>  };
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
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
> +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
>  struct drm_syncobj_wait {
>  	__u64 handles;
>  	/* absolute timeout */
> @@ -747,12 +758,33 @@ struct drm_syncobj_wait {
>  	__u32 pad;
>  };
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
>  struct drm_syncobj_array {
>  	__u64 handles;
>  	__u32 count_handles;
>  	__u32 pad;
>  };
>  
> +struct drm_syncobj_timeline_array {
> +	__u64 handles;
> +	__u64 points;
> +	__u32 count_handles;
> +	__u32 pad;
> +};
> +
> +
>  /* Query current scanout sequence number */
>  struct drm_crtc_get_sequence {
>  	__u32 crtc_id;		/* requested crtc_id */
> @@ -909,6 +941,11 @@ extern "C" {
>  #define DRM_IOCTL_MODE_GET_LEASE	DRM_IOWR(0xC8, struct drm_mode_get_lease)
>  #define DRM_IOCTL_MODE_REVOKE_LEASE	DRM_IOWR(0xC9, struct drm_mode_revoke_lease)
>  
> +#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT	DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)
> +#define DRM_IOCTL_SYNCOBJ_QUERY		DRM_IOWR(0xCB, struct drm_syncobj_timeline_array)
> +#define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
> +#define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
> +
>  /**
>   * Device specific ioctls should only be in their respective headers
>   * The device specific ioctl range is from 0x40 to 0x9f.
> diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
> index 397810fa2d33..3a73f5316766 100644
> --- a/tools/include/uapi/drm/i915_drm.h
> +++ b/tools/include/uapi/drm/i915_drm.h
> @@ -62,6 +62,28 @@ extern "C" {
>  #define I915_ERROR_UEVENT		"ERROR"
>  #define I915_RESET_UEVENT		"RESET"
>  
> +/*
> + * i915_user_extension: Base class for defining a chain of extensions
> + *
> + * Many interfaces need to grow over time. In most cases we can simply
> + * extend the struct and have userspace pass in more data. Another option,
> + * as demonstrated by Vulkan's approach to providing extensions for forward
> + * and backward compatibility, is to use a list of optional structs to
> + * provide those extra details.
> + *
> + * The key advantage to using an extension chain is that it allows us to
> + * redefine the interface more easily than an ever growing struct of
> + * increasing complexity, and for large parts of that interface to be
> + * entirely optional. The downside is more pointer chasing; chasing across
> + * the __user boundary with pointers encapsulated inside u64.
> + */
> +struct i915_user_extension {
> +	__u64 next_extension;
> +	__u32 name;
> +	__u32 flags; /* All undefined bits must be zero. */
> +	__u32 rsvd[4]; /* Reserved for future use; must be zero. */
> +};
> +
>  /*
>   * MOCS indexes used for GPU surfaces, defining the cacheability of the
>   * surface data and the coherency for this data wrt. CPU vs. GPU accesses.
> @@ -99,9 +121,23 @@ enum drm_i915_gem_engine_class {
>  	I915_ENGINE_CLASS_VIDEO		= 2,
>  	I915_ENGINE_CLASS_VIDEO_ENHANCE	= 3,
>  
> +	/* should be kept compact */
> +
>  	I915_ENGINE_CLASS_INVALID	= -1
>  };
>  
> +/*
> + * There may be more than one engine fulfilling any role within the system.
> + * Each engine of a class is given a unique instance number and therefore
> + * any engine can be specified by its class:instance tuplet. APIs that allow
> + * access to any engine in the system will use struct i915_engine_class_instance
> + * for this identification.
> + */
> +struct i915_engine_class_instance {
> +	__u16 engine_class; /* see enum drm_i915_gem_engine_class */
> +	__u16 engine_instance;
> +};
> +
>  /**
>   * DOC: perf_events exposed by i915 through /sys/bus/event_sources/drivers/i915
>   *
> @@ -319,6 +355,7 @@ typedef struct _drm_i915_sarea {
>  #define DRM_I915_PERF_ADD_CONFIG	0x37
>  #define DRM_I915_PERF_REMOVE_CONFIG	0x38
>  #define DRM_I915_QUERY			0x39
> +/* Must be kept compact -- no holes */
>  
>  #define DRM_IOCTL_I915_INIT		DRM_IOW( DRM_COMMAND_BASE + DRM_I915_INIT, drm_i915_init_t)
>  #define DRM_IOCTL_I915_FLUSH		DRM_IO ( DRM_COMMAND_BASE + DRM_I915_FLUSH)
> @@ -367,6 +404,7 @@ typedef struct _drm_i915_sarea {
>  #define DRM_IOCTL_I915_GET_SPRITE_COLORKEY DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GET_SPRITE_COLORKEY, struct drm_intel_sprite_colorkey)
>  #define DRM_IOCTL_I915_GEM_WAIT		DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_WAIT, struct drm_i915_gem_wait)
>  #define DRM_IOCTL_I915_GEM_CONTEXT_CREATE	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_CREATE, struct drm_i915_gem_context_create)
> +#define DRM_IOCTL_I915_GEM_CONTEXT_CREATE_EXT	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_CREATE, struct drm_i915_gem_context_create_ext)
>  #define DRM_IOCTL_I915_GEM_CONTEXT_DESTROY	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_DESTROY, struct drm_i915_gem_context_destroy)
>  #define DRM_IOCTL_I915_REG_READ			DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_REG_READ, struct drm_i915_reg_read)
>  #define DRM_IOCTL_I915_GET_RESET_STATS		DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GET_RESET_STATS, struct drm_i915_reset_stats)
> @@ -476,6 +514,7 @@ typedef struct drm_i915_irq_wait {
>  #define   I915_SCHEDULER_CAP_ENABLED	(1ul << 0)
>  #define   I915_SCHEDULER_CAP_PRIORITY	(1ul << 1)
>  #define   I915_SCHEDULER_CAP_PREEMPTION	(1ul << 2)
> +#define   I915_SCHEDULER_CAP_SEMAPHORES	(1ul << 3)
>  
>  #define I915_PARAM_HUC_STATUS		 42
>  
> @@ -559,6 +598,8 @@ typedef struct drm_i915_irq_wait {
>   */
>  #define I915_PARAM_MMAP_GTT_COHERENT	52
>  
> +/* Must be kept compact -- no holes and well documented */
> +
>  typedef struct drm_i915_getparam {
>  	__s32 param;
>  	/*
> @@ -574,6 +615,7 @@ typedef struct drm_i915_getparam {
>  #define I915_SETPARAM_TEX_LRU_LOG_GRANULARITY             2
>  #define I915_SETPARAM_ALLOW_BATCHBUFFER                   3
>  #define I915_SETPARAM_NUM_USED_FENCES                     4
> +/* Must be kept compact -- no holes */
>  
>  typedef struct drm_i915_setparam {
>  	int param;
> @@ -972,7 +1014,7 @@ struct drm_i915_gem_execbuffer2 {
>  	 * struct drm_i915_gem_exec_fence *fences.
>  	 */
>  	__u64 cliprects_ptr;
> -#define I915_EXEC_RING_MASK              (7<<0)
> +#define I915_EXEC_RING_MASK              (0x3f)
>  #define I915_EXEC_DEFAULT                (0<<0)
>  #define I915_EXEC_RENDER                 (1<<0)
>  #define I915_EXEC_BSD                    (2<<0)
> @@ -1120,32 +1162,34 @@ struct drm_i915_gem_busy {
>  	 * as busy may become idle before the ioctl is completed.
>  	 *
>  	 * Furthermore, if the object is busy, which engine is busy is only
> -	 * provided as a guide. There are race conditions which prevent the
> -	 * report of which engines are busy from being always accurate.
> -	 * However, the converse is not true. If the object is idle, the
> -	 * result of the ioctl, that all engines are idle, is accurate.
> +	 * provided as a guide and only indirectly by reporting its class
> +	 * (there may be more than one engine in each class). There are race
> +	 * conditions which prevent the report of which engines are busy from
> +	 * being always accurate.  However, the converse is not true. If the
> +	 * object is idle, the result of the ioctl, that all engines are idle,
> +	 * is accurate.
>  	 *
>  	 * The returned dword is split into two fields to indicate both
> -	 * the engines on which the object is being read, and the
> -	 * engine on which it is currently being written (if any).
> +	 * the engine classess on which the object is being read, and the
> +	 * engine class on which it is currently being written (if any).
>  	 *
>  	 * The low word (bits 0:15) indicate if the object is being written
>  	 * to by any engine (there can only be one, as the GEM implicit
>  	 * synchronisation rules force writes to be serialised). Only the
> -	 * engine for the last write is reported.
> +	 * engine class (offset by 1, I915_ENGINE_CLASS_RENDER is reported as
> +	 * 1 not 0 etc) for the last write is reported.
>  	 *
> -	 * The high word (bits 16:31) are a bitmask of which engines are
> -	 * currently reading from the object. Multiple engines may be
> +	 * The high word (bits 16:31) are a bitmask of which engines classes
> +	 * are currently reading from the object. Multiple engines may be
>  	 * reading from the object simultaneously.
>  	 *
> -	 * The value of each engine is the same as specified in the
> -	 * EXECBUFFER2 ioctl, i.e. I915_EXEC_RENDER, I915_EXEC_BSD etc.
> -	 * Note I915_EXEC_DEFAULT is a symbolic value and is mapped to
> -	 * the I915_EXEC_RENDER engine for execution, and so it is never
> +	 * The value of each engine class is the same as specified in the
> +	 * I915_CONTEXT_SET_ENGINES parameter and via perf, i.e.
> +	 * I915_ENGINE_CLASS_RENDER, I915_ENGINE_CLASS_COPY, etc.
>  	 * reported as active itself. Some hardware may have parallel
>  	 * execution engines, e.g. multiple media engines, which are
> -	 * mapped to the same identifier in the EXECBUFFER2 ioctl and
> -	 * so are not separately reported for busyness.
> +	 * mapped to the same class identifier and so are not separately
> +	 * reported for busyness.
>  	 *
>  	 * Caveat emptor:
>  	 * Only the boolean result of this query is reliable; that is whether
> @@ -1412,65 +1456,17 @@ struct drm_i915_gem_wait {
>  };
>  
>  struct drm_i915_gem_context_create {
> -	/*  output: id of new context*/
> -	__u32 ctx_id;
> -	__u32 pad;
> -};
> -
> -struct drm_i915_gem_context_destroy {
> -	__u32 ctx_id;
> +	__u32 ctx_id; /* output: id of new context*/
>  	__u32 pad;
>  };
>  
> -struct drm_i915_reg_read {
> -	/*
> -	 * Register offset.
> -	 * For 64bit wide registers where the upper 32bits don't immediately
> -	 * follow the lower 32bits, the offset of the lower 32bits must
> -	 * be specified
> -	 */
> -	__u64 offset;
> -#define I915_REG_READ_8B_WA (1ul << 0)
> -
> -	__u64 val; /* Return value */
> -};
> -/* Known registers:
> - *
> - * Render engine timestamp - 0x2358 + 64bit - gen7+
> - * - Note this register returns an invalid value if using the default
> - *   single instruction 8byte read, in order to workaround that pass
> - *   flag I915_REG_READ_8B_WA in offset field.
> - *
> - */
> -
> -struct drm_i915_reset_stats {
> -	__u32 ctx_id;
> -	__u32 flags;
> -
> -	/* All resets since boot/module reload, for all contexts */
> -	__u32 reset_count;
> -
> -	/* Number of batches lost when active in GPU, for this context */
> -	__u32 batch_active;
> -
> -	/* Number of batches lost pending for execution, for this context */
> -	__u32 batch_pending;
> -
> -	__u32 pad;
> -};
> -
> -struct drm_i915_gem_userptr {
> -	__u64 user_ptr;
> -	__u64 user_size;
> +struct drm_i915_gem_context_create_ext {
> +	__u32 ctx_id; /* output: id of new context*/
>  	__u32 flags;
> -#define I915_USERPTR_READ_ONLY 0x1
> -#define I915_USERPTR_UNSYNCHRONIZED 0x80000000
> -	/**
> -	 * Returned handle for the object.
> -	 *
> -	 * Object handles are nonzero.
> -	 */
> -	__u32 handle;
> +#define I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS	(1u << 0)
> +#define I915_CONTEXT_CREATE_FLAGS_UNKNOWN \
> +	(-(I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS << 1))
> +	__u64 extensions;
>  };
>  
>  struct drm_i915_gem_context_param {
> @@ -1491,6 +1487,28 @@ struct drm_i915_gem_context_param {
>  	 * drm_i915_gem_context_param_sseu.
>  	 */
>  #define I915_CONTEXT_PARAM_SSEU		0x7
> +
> +/*
> + * Not all clients may want to attempt automatic recover of a context after
> + * a hang (for example, some clients may only submit very small incremental
> + * batches relying on known logical state of previous batches which will never
> + * recover correctly and each attempt will hang), and so would prefer that
> + * the context is forever banned instead.
> + *
> + * If set to false (0), after a reset, subsequent (and in flight) rendering
> + * from this context is discarded, and the client will need to create a new
> + * context to use instead.
> + *
> + * If set to true (1), the kernel will automatically attempt to recover the
> + * context by skipping the hanging batch and executing the next batch starting
> + * from the default context state (discarding the incomplete logical context
> + * state lost due to the reset).
> + *
> + * On creation, all new contexts are marked as recoverable.
> + */
> +#define I915_CONTEXT_PARAM_RECOVERABLE	0x8
> +/* Must be kept compact -- no holes and well documented */
> +
>  	__u64 value;
>  };
>  
> @@ -1519,8 +1537,7 @@ struct drm_i915_gem_context_param_sseu {
>  	/*
>  	 * Engine class & instance to be configured or queried.
>  	 */
> -	__u16 engine_class;
> -	__u16 engine_instance;
> +	struct i915_engine_class_instance engine;
>  
>  	/*
>  	 * Unused for now. Must be cleared to zero.
> @@ -1553,6 +1570,96 @@ struct drm_i915_gem_context_param_sseu {
>  	__u32 rsvd;
>  };
>  
> +struct drm_i915_gem_context_create_ext_setparam {
> +#define I915_CONTEXT_CREATE_EXT_SETPARAM 0
> +	struct i915_user_extension base;
> +	struct drm_i915_gem_context_param param;
> +};
> +
> +struct drm_i915_gem_context_destroy {
> +	__u32 ctx_id;
> +	__u32 pad;
> +};
> +
> +/*
> + * DRM_I915_GEM_VM_CREATE -
> + *
> + * Create a new virtual memory address space (ppGTT) for use within a context
> + * on the same file. Extensions can be provided to configure exactly how the
> + * address space is setup upon creation.
> + *
> + * The id of new VM (bound to the fd) for use with I915_CONTEXT_PARAM_VM is
> + * returned in the outparam @id.
> + *
> + * No flags are defined, with all bits reserved and must be zero.
> + *
> + * An extension chain maybe provided, starting with @extensions, and terminated
> + * by the @next_extension being 0. Currently, no extensions are defined.
> + *
> + * DRM_I915_GEM_VM_DESTROY -
> + *
> + * Destroys a previously created VM id, specified in @id.
> + *
> + * No extensions or flags are allowed currently, and so must be zero.
> + */
> +struct drm_i915_gem_vm_control {
> +	__u64 extensions;
> +	__u32 flags;
> +	__u32 vm_id;
> +};
> +
> +struct drm_i915_reg_read {
> +	/*
> +	 * Register offset.
> +	 * For 64bit wide registers where the upper 32bits don't immediately
> +	 * follow the lower 32bits, the offset of the lower 32bits must
> +	 * be specified
> +	 */
> +	__u64 offset;
> +#define I915_REG_READ_8B_WA (1ul << 0)
> +
> +	__u64 val; /* Return value */
> +};
> +
> +/* Known registers:
> + *
> + * Render engine timestamp - 0x2358 + 64bit - gen7+
> + * - Note this register returns an invalid value if using the default
> + *   single instruction 8byte read, in order to workaround that pass
> + *   flag I915_REG_READ_8B_WA in offset field.
> + *
> + */
> +
> +struct drm_i915_reset_stats {
> +	__u32 ctx_id;
> +	__u32 flags;
> +
> +	/* All resets since boot/module reload, for all contexts */
> +	__u32 reset_count;
> +
> +	/* Number of batches lost when active in GPU, for this context */
> +	__u32 batch_active;
> +
> +	/* Number of batches lost pending for execution, for this context */
> +	__u32 batch_pending;
> +
> +	__u32 pad;
> +};
> +
> +struct drm_i915_gem_userptr {
> +	__u64 user_ptr;
> +	__u64 user_size;
> +	__u32 flags;
> +#define I915_USERPTR_READ_ONLY 0x1
> +#define I915_USERPTR_UNSYNCHRONIZED 0x80000000
> +	/**
> +	 * Returned handle for the object.
> +	 *
> +	 * Object handles are nonzero.
> +	 */
> +	__u32 handle;
> +};
> +
>  enum drm_i915_oa_format {
>  	I915_OA_FORMAT_A13 = 1,	    /* HSW only */
>  	I915_OA_FORMAT_A29,	    /* HSW only */
> @@ -1714,6 +1821,7 @@ struct drm_i915_perf_oa_config {
>  struct drm_i915_query_item {
>  	__u64 query_id;
>  #define DRM_I915_QUERY_TOPOLOGY_INFO    1
> +/* Must be kept compact -- no holes and well documented */
>  
>  	/*
>  	 * When set to zero by userspace, this is filled with the size of the
> diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
> index a2f8658f1c55..1d338357df8a 100644
> --- a/tools/include/uapi/linux/fcntl.h
> +++ b/tools/include/uapi/linux/fcntl.h
> @@ -91,5 +91,7 @@
>  #define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
>  #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
>  
> +#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
> +
>  
>  #endif /* _UAPI_LINUX_FCNTL_H */
> diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
> index 121e82ce296b..59c71fa8c553 100644
> --- a/tools/include/uapi/linux/fs.h
> +++ b/tools/include/uapi/linux/fs.h
> @@ -320,6 +320,9 @@ struct fscrypt_key {
>  #define SYNC_FILE_RANGE_WAIT_BEFORE	1
>  #define SYNC_FILE_RANGE_WRITE		2
>  #define SYNC_FILE_RANGE_WAIT_AFTER	4
> +#define SYNC_FILE_RANGE_WRITE_AND_WAIT	(SYNC_FILE_RANGE_WRITE | \
> +					 SYNC_FILE_RANGE_WAIT_BEFORE | \
> +					 SYNC_FILE_RANGE_WAIT_AFTER)
>  
>  /*
>   * Flags for preadv2/pwritev2:
> diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
> index 3f9ec42510b0..96a0240f23fe 100644
> --- a/tools/include/uapi/linux/mount.h
> +++ b/tools/include/uapi/linux/mount.h
> @@ -55,4 +55,66 @@
>  #define MS_MGC_VAL 0xC0ED0000
>  #define MS_MGC_MSK 0xffff0000
>  
> +/*
> + * open_tree() flags.
> + */
> +#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
> +#define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
> +
> +/*
> + * move_mount() flags.
> + */
> +#define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */
> +#define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
> +#define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
> +#define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
> +#define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
> +#define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
> +#define MOVE_MOUNT__MASK		0x00000077
> +
> +/*
> + * fsopen() flags.
> + */
> +#define FSOPEN_CLOEXEC		0x00000001
> +
> +/*
> + * fspick() flags.
> + */
> +#define FSPICK_CLOEXEC		0x00000001
> +#define FSPICK_SYMLINK_NOFOLLOW	0x00000002
> +#define FSPICK_NO_AUTOMOUNT	0x00000004
> +#define FSPICK_EMPTY_PATH	0x00000008
> +
> +/*
> + * The type of fsconfig() call made.
> + */
> +enum fsconfig_command {
> +	FSCONFIG_SET_FLAG	= 0,	/* Set parameter, supplying no value */
> +	FSCONFIG_SET_STRING	= 1,	/* Set parameter, supplying a string value */
> +	FSCONFIG_SET_BINARY	= 2,	/* Set parameter, supplying a binary blob value */
> +	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
> +	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
> +	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
> +	FSCONFIG_CMD_CREATE	= 6,	/* Invoke superblock creation */
> +	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
> +};
> +
> +/*
> + * fsmount() flags.
> + */
> +#define FSMOUNT_CLOEXEC		0x00000001
> +
> +/*
> + * Mount attributes.
> + */
> +#define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
> +#define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
> +#define MOUNT_ATTR_NODEV	0x00000004 /* Disallow access to device special files */
> +#define MOUNT_ATTR_NOEXEC	0x00000008 /* Disallow program execution */
> +#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
> +#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
> +#define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
> +#define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
> +#define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
> +
>  #endif /* _UAPI_LINUX_MOUNT_H */
> diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
> index 22627f80063e..ed4ee170bee2 100644
> --- a/tools/include/uapi/linux/sched.h
> +++ b/tools/include/uapi/linux/sched.h
> @@ -10,6 +10,7 @@
>  #define CLONE_FS	0x00000200	/* set if fs info shared between processes */
>  #define CLONE_FILES	0x00000400	/* set if open files shared between processes */
>  #define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
> +#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in parent */
>  #define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
>  #define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
>  #define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> index 92ee0b4378d4..64ca0d06259a 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -343,6 +343,12 @@
>  332	common	statx			__x64_sys_statx
>  333	common	io_pgetevents		__x64_sys_io_pgetevents
>  334	common	rseq			__x64_sys_rseq
> +335	common	open_tree		__x64_sys_open_tree
> +336	common	move_mount		__x64_sys_move_mount
> +337	common	fsopen			__x64_sys_fsopen
> +338	common	fsconfig		__x64_sys_fsconfig
> +339	common	fsmount			__x64_sys_fsmount
> +340	common	fspick			__x64_sys_fspick
>  # don't use numbers 387 through 423, add new calls after the last
>  # 'common' entry
>  424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal

-- 

- Arnaldo
