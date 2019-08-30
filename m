Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8590EC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5037D21726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nauxkLeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfH3Au4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:50:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40340 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfH3Aux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id u29so3963106lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ia9Iohgefzn/RbnoIHs2aN928PonhCPU+GJ0mIg1xw0=;
        b=nauxkLeh1ZIxd8fP3xfh92I409w8DtNf/fnJmlw8/s9VqlgjubltPx0An1YWZH63Gp
         /TU66tFs3h09+jwh0GQFAkphSKeFfuTA4fyRKiDv+BGn8HEGJ0GQ8uWN5KtYMp4+0+Wt
         yeefhppCuIPIX3qDij/rrFlPldmQRE59HGCtjQQbAIwZDsunfz9iBC10S7GurulzO27V
         lVzBOobQwYJfYUmGpSLW5FCPoxlnTesIic63c8f9+TL2Fa3O+RTzLMrhS7+qwAGYHToD
         NhKirRP5II5myOl4O26T3M66TxYAY2Bdx9hqZThpHbkaBfucoIK/qhsrs16aksO8dxvB
         f0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ia9Iohgefzn/RbnoIHs2aN928PonhCPU+GJ0mIg1xw0=;
        b=eJoglP73tI3erOG38/sNjx+/0AMXnksNG9WsyXI2D6F9iDcbfu+T/ZNylYEyd7eFSR
         ZtZ4PFQVMoH8MjqBBPV8hwlJLSxrJuLOyE22ATsRTdPW6NrJGq3PZISf7LOBZ48PY4XM
         0fN5DHxD7TzsDJP4vEQYykKlkoo5lLNQgalsDM+gxfMGwDq0dzuAX/HFY14UDT5/jcb/
         13sa0G7cv0IEAAeCvfezf3xcoC58ClItoZmeZM+nAamUCsLWMuyBFdiNHjI9DOEE58vu
         iAvmH2KyksqtW8evJw3s1oMlzXTFy5LSSgt+RFNsgxDTCd7h3Q8pMDOoUgLa49FyC9xj
         2FEA==
X-Gm-Message-State: APjAAAVB6IiE9n2LsOy/ehTGZxCAgByz5/LBy7Cx/X+IAr6rodwx6sRS
        qXwb+U7G569Y5oag4TxDuBHCVg==
X-Google-Smtp-Source: APXvYqy1+wbSVRXaVz0I1Wy246SkFUj+yZxpo8NGJNvbTRSJX75MH0Q94N5wXdG//lglqP0UWSKwdg==
X-Received: by 2002:ac2:5608:: with SMTP id v8mr7690120lfd.95.1567126250684;
        Thu, 29 Aug 2019 17:50:50 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:50 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 07/10] samples: bpf: add makefile.prog for separate CC build
Date:   Fri, 30 Aug 2019 03:50:34 +0300
Message-Id: <20190830005037.24004-8-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HOSTCC is supposed to build binaries and tools running on the host
afterwards, in order to simplify build or so, like "fixdep" or else.
In case of cross compiling "fixdep" is executed on host when the rest
samples should run on target arch. In order to build binaries for
target arch with CC and tools running on host with HOSTCC, lets add
Makefile.prog for simplicity, having definition and routines similar
to ones, used in script/Makefile.host. That allows later add
cross-compilation to samples/bpf with minimum changes.

Makefile.prog contains only stuff needed for samples/bpf, potentially
can be reused and sophisticated for other prog sets later and now
needed only for unblocking tricky samples/bpf cross compilation.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile.prog | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 samples/bpf/Makefile.prog

diff --git a/samples/bpf/Makefile.prog b/samples/bpf/Makefile.prog
new file mode 100644
index 000000000000..d5d02fbb5e6e
--- /dev/null
+++ b/samples/bpf/Makefile.prog
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Building binaries on the host system
+# Binaries are not used during the compilation of the kernel, and intendent to
+# be build for target board, target board can be host ofc. Added to build
+# binaries to run not on host system.
+#
+# Both C and C++ are supported, but preferred language is C for such utilities.
+#
+# Sample syntax (see Documentation/kbuild/makefiles.rst for reference)
+# progs-y := xdpsock_example
+# Will compile xdpsock_example.c and create an executable named xdpsock_example
+#
+# progs-y    := xdpsock
+# xdpsock-objs := xdpsock_user.o xdpsock_user2.o
+# Will compile xdpsock.c and xdpsock.c, and then link the executable
+# xdpsock, based on xdpsock_user.o and xdpsock_user2.o
+#
+# Inherited from scripts/Makefile.host
+#
+__progs := $(sort $(progs-y))
+
+# C code
+# Executables compiled from a single .c file
+prog-csingle	:= $(foreach m,$(__progs), \
+			$(if $($(m)-objs)$($(m)-cxxobjs),,$(m)))
+
+# C executables linked based on several .o files
+prog-cmulti	:= $(foreach m,$(__progs),\
+		   $(if $($(m)-cxxobjs),,$(if $($(m)-objs),$(m))))
+
+# Object (.o) files compiled from .c files
+prog-cobjs	:= $(sort $(foreach m,$(__progs),$($(m)-objs)))
+
+prog-csingle	:= $(addprefix $(obj)/,$(prog-csingle))
+prog-cmulti	:= $(addprefix $(obj)/,$(prog-cmulti))
+prog-cobjs	:= $(addprefix $(obj)/,$(prog-cobjs))
+
+#####
+# Handle options to gcc. Support building with separate output directory
+
+_progc_flags   = $(PROGS_CFLAGS) \
+                 $(PROGCFLAGS_$(basetarget).o)
+
+# $(objtree)/$(obj) for including generated headers from checkin source files
+ifeq ($(KBUILD_EXTMOD),)
+ifdef building_out_of_srctree
+_progc_flags   += -I $(objtree)/$(obj)
+endif
+endif
+
+progc_flags    = -Wp,-MD,$(depfile) $(_progc_flags)
+
+# Create executable from a single .c file
+# prog-csingle -> Executable
+quiet_cmd_prog-csingle 	= CC  $@
+      cmd_prog-csingle	= $(CC) $(progc_flags) $(PROGS_LDFLAGS) -o $@ $< \
+		$(PROGS_LDLIBS) $(PROGLDLIBS_$(@F))
+$(prog-csingle): $(obj)/%: $(src)/%.c FORCE
+	$(call if_changed_dep,prog-csingle)
+
+# Link an executable based on list of .o files, all plain c
+# prog-cmulti -> executable
+quiet_cmd_prog-cmulti	= LD  $@
+      cmd_prog-cmulti	= $(CC) $(progc_flags) $(PROGS_LDFLAGS) -o $@ \
+			  $(addprefix $(obj)/,$($(@F)-objs)) \
+			  $(PROGS_LDLIBS) $(PROGLDLIBS_$(@F))
+$(prog-cmulti): $(prog-cobjs) FORCE
+	$(call if_changed,prog-cmulti)
+$(call multi_depend, $(prog-cmulti), , -objs)
+
+# Create .o file from a single .c file
+# prog-cobjs -> .o
+quiet_cmd_prog-cobjs	= CC  $@
+      cmd_prog-cobjs	= $(CC) $(progc_flags) -c -o $@ $<
+$(prog-cobjs): $(obj)/%.o: $(src)/%.c FORCE
+	$(call if_changed_dep,prog-cobjs)
-- 
2.17.1

