Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B061DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656120674
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575292747;
	bh=yt3pVb7qx4tIwwEFwVyuY4tgo/idFLagGbe7s2O5e9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zFr0VCNyPjoaaikqbNUBb2soc3RFgZlMRM/XpO2Xzh36oozux/ydoiYJY8ILHngWa
	 JUISnJiPmH2mJYW9OXQiDRv81FCCXrkGa+kYSVhhwUrkQyK9Ka/POe+LUxrdGdAnTo
	 t0wN9mmvA5TmgNJofDuBlwxU7W6mTQPiVPLxxPO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLBNTG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:19:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37209 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727398AbfLBNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:19:04 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-NRPZF_c0PLuMKmVQmC_W2A-1; Mon, 02 Dec 2019 08:19:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CF7910054E3;
        Mon,  2 Dec 2019 13:18:59 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26DB5600C8;
        Mon,  2 Dec 2019 13:18:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 1/6] perf tools: Allow to specify libbpf install directory
Date:   Mon,  2 Dec 2019 14:18:41 +0100
Message-Id: <20191202131847.30837-2-jolsa@kernel.org>
In-Reply-To: <20191202131847.30837-1-jolsa@kernel.org>
References: <20191202131847.30837-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NRPZF_c0PLuMKmVQmC_W2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding LIBBPF_DIR compile variable to allow linking with
libbpf installed into specific directory:

  $ make -C tools/lib/bpf/ prefix=/tmp/libbpf/ install_lib install_headers
  $ make -C tools/perf/ LIBBPF_DYNAMIC=1 LIBBPF_DIR=/tmp/libbpf/ VF=1

It might be needed to clean build tree first because features
framework does not detect the change properly:

  $ make -C tools/build/feature clean
  $ make -C tools/perf/ clean

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.config | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c90f4146e5a2..eb9d9b70b7d3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -22,6 +22,14 @@ include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,SRCARCH)
 
+ifndef lib
+  ifeq ($(SRCARCH)$(IS_64_BIT), x861)
+    lib = lib64
+  else
+    lib = lib
+  endif
+endif # lib
+
 NO_PERF_REGS := 1
 NO_SYSCALL_TABLE := 1
 
@@ -484,11 +492,22 @@ ifndef NO_LIBELF
       CFLAGS += -DHAVE_LIBBPF_SUPPORT
       $(call detected,CONFIG_LIBBPF)
 
+      # for linking with debug library run:
+      # make DEBUG=1 LIBBPF_DIR=/opt/libbpf
+      ifdef LIBBPF_DIR
+        LIBBPF_CFLAGS  := -I$(LIBBPF_DIR)/include
+        LIBBPF_LDFLAGS := -L$(LIBBPF_DIR)/$(lib)
+        FEATURE_CHECK_CFLAGS-libbpf  := $(LIBBPF_CFLAGS)
+        FEATURE_CHECK_LDFLAGS-libbpf := $(LIBBPF_LDFLAGS)
+      endif
+
       # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
       $(call feature_check,libbpf)
       ifdef LIBBPF_DYNAMIC
         ifeq ($(feature-libbpf), 1)
           EXTLIBS += -lbpf
+          CFLAGS  += $(LIBBPF_CFLAGS)
+          LDFLAGS += $(LIBBPF_LDFLAGS)
         else
           dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
         endif
@@ -1037,13 +1056,6 @@ else
 sysconfdir = $(prefix)/etc
 ETC_PERFCONFIG = etc/perfconfig
 endif
-ifndef lib
-ifeq ($(SRCARCH)$(IS_64_BIT), x861)
-lib = lib64
-else
-lib = lib
-endif
-endif # lib
 libdir = $(prefix)/$(lib)
 
 # Shell quote (do not use $(call) to accommodate ancient setups);
@@ -1108,6 +1120,7 @@ ifeq ($(VF),1)
   $(call print_var,LIBUNWIND_DIR)
   $(call print_var,LIBDW_DIR)
   $(call print_var,JDIR)
+  $(call print_var,LIBBPF_DIR)
 
   ifeq ($(dwarf-post-unwind),1)
     $(call feature_print_text,"DWARF post unwind library", $(dwarf-post-unwind-text))
-- 
2.21.0

