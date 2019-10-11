Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF74EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4962196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTqYPLOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfJKA2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:28:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38229 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfJKA2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id u28so5722556lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IxUitNmcKfvxEmpW+0pRzzeuEr0YPZuYrEHpJHWrZps=;
        b=kTqYPLOm4wkOer6jQLN5gXRo5/W99qjv/h0pNIhkC9Ld+vW4Z+/itjrilnApQ2JV2J
         TTWqfjhzT39OjcRXZQLH8WwhLYpDhXrr+t9IOYUK9UdEhhkN6J015Y57WnoYWF/1Fm4o
         fDOWOcP9H6AQPh3K8REifyxBGiaZJpDkSu4Z0qX5TwElBrZNVKrTnI20OzTm2hNz2+rb
         qh2Mk/1hUCT2Vz3vAbU9o6YoliEGiGn3QBwM+Oiz4PeCvHHS4iE3/pZ11Fgd9NkIKB1v
         eoovDJSYruFUOZDr1MGwaSzpJW23LpPLjxnioiLCQuw5aMuBjU+oURZSl5Q7abTzX1qq
         P5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IxUitNmcKfvxEmpW+0pRzzeuEr0YPZuYrEHpJHWrZps=;
        b=NT0cJAn5nojM/t3hEoVe+G+WMwuiMM76brTioTibR5aYvqEWM1EC231Hb96mn6CUwv
         erPW1z3yKKlzmbX8U7nt0uR0z5wRRihb21+jX1PfJLZ+zRNZZ8YNeHIJu8vQpmYWEYKu
         CbbLHW+E+TqRg27mgCjah380WGKhnuXKQhrlf/3B5b3qhHWaik2XVB1eMxrD3kws2KzK
         JBFJZR6xMrvSOE+72z5RSrJaUuCUMH4dKqh0jXpueuJ5SaBlKn2eqh1wioY96CkFBC4I
         pny/AUlxxtRV1BGTcOmp1pIWbLWPV4d+2d4wVVVM83V3ExXYws+GW4+M5IiB95T+uMy3
         /7Uw==
X-Gm-Message-State: APjAAAU2PAjtA/nlOss9jakKQnSor2Mtm8RGLCJB8W8PsZV92fP/fs66
        xtYoxMxFMvSvMsCU8j2l6ce6Tg==
X-Google-Smtp-Source: APXvYqzHeGSBOiLyOxNG/e1y4z5FSvnF5jGGj+/MXQi9l5yutw8m/8VcVXNMlQMrzLm7F5KTInoUew==
X-Received: by 2002:ac2:42c7:: with SMTP id n7mr4905180lfl.138.1570753710432;
        Thu, 10 Oct 2019 17:28:30 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:29 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 07/15] samples/bpf: add makefile.target for separate CC target build
Date:   Fri, 11 Oct 2019 03:28:00 +0300
Message-Id: <20191011002808.28206-8-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile.target is added only and will be used in
sample/bpf/Makefile later in order to switch cross-compiling to CC
from HOSTCC environment.

The HOSTCC is supposed to build binaries and tools running on the host
afterwards, in order to simplify build or so, like "fixdep" or else.
In case of cross compiling "fixdep" is executed on host when the rest
samples should run on target arch. In order to build binaries for
target arch with CC and tools running on host with HOSTCC, lets add
Makefile.target for simplicity, having definition and routines similar
to ones, used in script/Makefile.host. This allows later add
cross-compilation to samples/bpf with minimum changes.

The tprog stands for target programs built with CC.

Makefile.target contains only stuff needed for samples/bpf, potentially
can be reused later and now needed only for unblocking tricky
samples/bpf cross compilation.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile.target | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 samples/bpf/Makefile.target

diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
new file mode 100644
index 000000000000..7621f55e2947
--- /dev/null
+++ b/samples/bpf/Makefile.target
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Building binaries on the host system
+# Binaries are not used during the compilation of the kernel, and intended
+# to be build for target board, target board can be host of course. Added to
+# build binaries to run not on host system.
+#
+# Sample syntax
+# tprogs-y := xsk_example
+# Will compile xsk_example.c and create an executable named xsk_example
+#
+# tprogs-y    := xdpsock
+# xdpsock-objs := xdpsock_1.o xdpsock_2.o
+# Will compile xdpsock_1.c and xdpsock_2.c, and then link the executable
+# xdpsock, based on xdpsock_1.o and xdpsock_2.o
+#
+# Derived from scripts/Makefile.host
+#
+__tprogs := $(sort $(tprogs-y))
+
+# C code
+# Executables compiled from a single .c file
+tprog-csingle	:= $(foreach m,$(__tprogs), \
+			$(if $($(m)-objs),,$(m)))
+
+# C executables linked based on several .o files
+tprog-cmulti	:= $(foreach m,$(__tprogs),\
+			$(if $($(m)-objs),$(m)))
+
+# Object (.o) files compiled from .c files
+tprog-cobjs	:= $(sort $(foreach m,$(__tprogs),$($(m)-objs)))
+
+tprog-csingle	:= $(addprefix $(obj)/,$(tprog-csingle))
+tprog-cmulti	:= $(addprefix $(obj)/,$(tprog-cmulti))
+tprog-cobjs	:= $(addprefix $(obj)/,$(tprog-cobjs))
+
+#####
+# Handle options to gcc. Support building with separate output directory
+
+_tprogc_flags   = $(TPROGS_CFLAGS) \
+                 $(TPROGCFLAGS_$(basetarget).o)
+
+# $(objtree)/$(obj) for including generated headers from checkin source files
+ifeq ($(KBUILD_EXTMOD),)
+ifdef building_out_of_srctree
+_tprogc_flags   += -I $(objtree)/$(obj)
+endif
+endif
+
+tprogc_flags    = -Wp,-MD,$(depfile) $(_tprogc_flags)
+
+# Create executable from a single .c file
+# tprog-csingle -> Executable
+quiet_cmd_tprog-csingle 	= CC  $@
+      cmd_tprog-csingle	= $(CC) $(tprogc_flags) $(TPROGS_LDFLAGS) -o $@ $< \
+		$(TPROGS_LDLIBS) $(TPROGLDLIBS_$(@F))
+$(tprog-csingle): $(obj)/%: $(src)/%.c FORCE
+	$(call if_changed_dep,tprog-csingle)
+
+# Link an executable based on list of .o files, all plain c
+# tprog-cmulti -> executable
+quiet_cmd_tprog-cmulti	= LD  $@
+      cmd_tprog-cmulti	= $(CC) $(tprogc_flags) $(TPROGS_LDFLAGS) -o $@ \
+			  $(addprefix $(obj)/,$($(@F)-objs)) \
+			  $(TPROGS_LDLIBS) $(TPROGLDLIBS_$(@F))
+$(tprog-cmulti): $(tprog-cobjs) FORCE
+	$(call if_changed,tprog-cmulti)
+$(call multi_depend, $(tprog-cmulti), , -objs)
+
+# Create .o file from a single .c file
+# tprog-cobjs -> .o
+quiet_cmd_tprog-cobjs	= CC  $@
+      cmd_tprog-cobjs	= $(CC) $(tprogc_flags) -c -o $@ $<
+$(tprog-cobjs): $(obj)/%.o: $(src)/%.c FORCE
+	$(call if_changed_dep,tprog-cobjs)
-- 
2.17.1

