Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2D5C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AFF257C8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Xc6ptHCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfE3IBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:01:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:01:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U81h4I2901019
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:01:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U81h4I2901019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203304;
        bh=LEOMd94BenxdEtwqFLTmslx5utWDPUlRykBss8Vy6XU=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Xc6ptHCI0ijACBBiHqiY9eLfkIwRfdaL0Kq8hXRakBguTPnM6XndgOopfJjsjkmLj
         rKrWMa7P3CTD+IqjSQoe9n55u6SRMhvRELdUCTEjV4DBXpiaqJEBKH9KwYLaNR9nWr
         x8wzYnpL84pUO2uVlPD/twojbbcXhUUikIHa0okyUdeJJC52aEwpYNkUn2zBQnpOgE
         EpGgxwA8Py6s6eH0uIYmAaKOkVxEOoxyGHk1v2TLd+tKqk9ITmcX0aGxLFRXFRQYKi
         QTxF1JiVDyEVLyx0qqnXLr73eG5W7ybldU/nMSzOVuUgIxIQJYRNPZdyKIHxfBBpdc
         bHdM9lPlW6H4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U81g7N2901016;
        Thu, 30 May 2019 01:01:42 -0700
Date:   Thu, 30 May 2019 01:01:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-fb04b76cm59zfuv1wzu40uxy@git.kernel.org>
Cc:     viro@zeniv.linux.org.uk, brendan.d.gregg@gmail.com,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, lclaudio@redhat.com, adrian.hunter@intel.com
Reply-To: lclaudio@redhat.com, viro@zeniv.linux.org.uk, jolsa@kernel.org,
          brendan.d.gregg@gmail.com, namhyung@kernel.org, acme@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Beautify 'fsconfig' arguments
Git-Commit-ID: dcc6fd64f2e9448ccc1c3e1ccd46a9ff5286b861
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dcc6fd64f2e9448ccc1c3e1ccd46a9ff5286b861
Gitweb:     https://git.kernel.org/tip/dcc6fd64f2e9448ccc1c3e1ccd46a9ff5286b861
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 15:36:44 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf trace: Beautify 'fsconfig' arguments

Use existing beautifiers for the first arg, fd, assigned using the
heuristic that looks for syscall arg names and associates SCA_FD with
'fd' named argumes, and wire up the recently introduced fsconfig cmd
table generator.

Now it should be possible to just use:

   perf trace -e fsconfig

As root and see all fsconfig syscalls with its args beautified, more
work needed to look at the command and according to it handle the 'key',
'value' and 'aux' args, using the 'fcntl' and 'futex' beautifiers as a
starting point to see how to suppress sets of these last three args that
may not be used by the 'cmd' arg, etc.

  # cat sys_fsconfig.c
  #define _GNU_SOURCE         /* See feature_test_macros(7) */
  #include <unistd.h>
  #include <sys/syscall.h>   /* For SYS_xxx definitions */
  #include <fcntl.h>

  #define __NR_fsconfig 431

  enum fsconfig_command {
  	FSCONFIG_SET_FLAG	= 0,	/* Set parameter, supplying no value */
  	FSCONFIG_SET_STRING	= 1,	/* Set parameter, supplying a string value */
  	FSCONFIG_SET_BINARY	= 2,	/* Set parameter, supplying a binary blob value */
  	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
  	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
  	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
  	FSCONFIG_CMD_CREATE	= 6,	/* Invoke superblock creation */
  	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
  };

  static inline int sys_fsconfig(int fd, int cmd, const char *key, const void *value, int aux)
  {
  	syscall(__NR_fsconfig, fd, cmd, key, value, aux);
  }

  int main(int argc, char *argv[])
  {
  	int fd = 0, aux = 0;

  	open("/foo", 0);
  	sys_fsconfig(fd++, FSCONFIG_SET_FLAG,	     "/foo1", "/bar1", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_STRING,	     "/foo2", "/bar2", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_BINARY,	     "/foo3", "/bar3", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_PATH,	     "/foo4", "/bar4", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_PATH_EMPTY,  "/foo5", "/bar5", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_FD,	     "/foo6", "/bar6", aux++);
  	sys_fsconfig(fd++, FSCONFIG_CMD_CREATE,	     "/foo7", "/bar7", aux++);
  	sys_fsconfig(fd++, FSCONFIG_CMD_RECONFIGURE, "/foo8", "/bar8", aux++);
  	return 0;
  }
  # trace -e fsconfig ./sys_fsconfig
  fsconfig(0, FSCONFIG_SET_FLAG, 0x40201b, 0x402015, 0) = -1 EINVAL (Invalid argument)
  fsconfig(1, FSCONFIG_SET_STRING, 0x402027, 0x402021, 1) = -1 EINVAL (Invalid argument)
  fsconfig(2, FSCONFIG_SET_BINARY, 0x402033, 0x40202d, 2) = -1 EINVAL (Invalid argument)
  fsconfig(3, FSCONFIG_SET_PATH, 0x40203f, 0x402039, 3) = -1 EBADF (Bad file descriptor)
  fsconfig(4, FSCONFIG_SET_PATH_EMPTY, 0x40204b, 0x402045, 4) = -1 EBADF (Bad file descriptor)
  fsconfig(5, FSCONFIG_SET_FD, 0x402057, 0x402051, 5) = -1 EINVAL (Invalid argument)
  fsconfig(6, FSCONFIG_CMD_CREATE, 0x402063, 0x40205d, 6) = -1 EINVAL (Invalid argument)
  fsconfig(7, FSCONFIG_CMD_RECONFIGURE, 0x40206f, 0x402069, 7) = -1 EINVAL (Invalid argument)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fb04b76cm59zfuv1wzu40uxy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf   | 8 ++++++++
 tools/perf/builtin-trace.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index fe93f8c46080..22e92a9ee871 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -425,6 +425,12 @@ fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
 $(fspick_arrays): $(linux_uapi_dir)/fs.h $(fspick_tbls)
 	$(Q)$(SHELL) '$(fspick_tbls)' $(linux_uapi_dir) > $@
 
+fsconfig_arrays := $(beauty_outdir)/fsconfig_arrays.c
+fsconfig_tbls := $(srctree)/tools/perf/trace/beauty/fsconfig.sh
+
+$(fsconfig_arrays): $(linux_uapi_dir)/fs.h $(fsconfig_tbls)
+	$(Q)$(SHELL) '$(fsconfig_tbls)' $(linux_uapi_dir) > $@
+
 pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
 asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
 pkey_alloc_access_rights_tbl := $(srctree)/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -640,6 +646,7 @@ build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
 	$(fadvise_advice_array) \
+	$(fsconfig_arrays) \
 	$(fspick_arrays) \
 	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
@@ -936,6 +943,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
 		$(OUTPUT)$(fadvise_advice_array) \
+		$(OUTPUT)$(fsconfig_arrays) \
 		$(OUTPUT)$(fspick_arrays) \
 		$(OUTPUT)$(madvise_behavior_array) \
 		$(OUTPUT)$(mmap_flags_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1643da631699..87b6dd3c33f5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -482,6 +482,10 @@ static const char *bpf_cmd[] = {
 };
 static DEFINE_STRARRAY(bpf_cmd, "BPF_");
 
+#include "trace/beauty/generated/fsconfig_arrays.c"
+
+static DEFINE_STRARRAY(fsconfig_cmds, "FSCONFIG_");
+
 static const char *epoll_ctl_ops[] = { "ADD", "DEL", "MOD", };
 static DEFINE_STRARRAY_OFFSET(epoll_ctl_ops, "EPOLL_CTL_", 1);
 
@@ -713,6 +717,8 @@ static struct syscall_fmt {
 		   [2] = { .scnprintf =  SCA_FCNTL_ARG, /* arg */ }, }, },
 	{ .name	    = "flock",
 	  .arg = { [1] = { .scnprintf = SCA_FLOCK, /* cmd */ }, }, },
+	{ .name     = "fsconfig",
+	  .arg = { [1] = STRARRAY(cmd, fsconfig_cmds), }, },
 	{ .name     = "fspick",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dfd */ },
 		   [1] = { .scnprintf = SCA_FILENAME,	  /* path */ },
