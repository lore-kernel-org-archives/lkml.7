Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C4C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5463D21771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqrDtNi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfK1Oxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:53:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37700 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726594AbfK1Oxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574952810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rSRdu36kdw7cp4aj5uiQyY93zJOiHwsJ9kURwhoRP88=;
        b=OqrDtNi/w4ql95WxW9pAzMfWN2FB4wzJHck8v9lqrjTxFwwDM+RFJfKYdri4YkS5F2PBd2
        +MfdGd3i9yBmjEr88uTAFyH9sieB6Mx9to2GEtrbf77Qu0/GV9qrx4+xWCm1cF014QgeNt
        4FenBwfDlO+oSSvne8SeqPHpUC55ZsY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-KJXzcXpOOFC5p361d-hRKA-1; Thu, 28 Nov 2019 09:53:28 -0500
Received: by mail-lj1-f198.google.com with SMTP id o20so5096816ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFfjqzHfd87DTRbEbayt6s48Ee8N6vIkSod5kqZnQ5Y=;
        b=CR9hzg6ZHwcpIeA4bKpRY1qFqJf1/dIDlGObdiwCpLEVLRRwr0pRgHH24Y7Quqr+o5
         E0Q4Jhh8yhc1y3AgJauPcUmpTrDUYrnNxJwDil76NjwccygL+3XN0JkuSCub5t82YQK/
         lMQFFZkIEeCYSPBS+zg7t9m0uOuRtkXLyO/2yTuXrlFOKRm5L5urUKn8phnyJPyrQl4P
         lKQg6hwoVC15+st+KhNh+slV3cgcR5AwQNBcOvXQeQkFV7l7Lc+iUwsLyG74xcO78aMs
         f/TV88eDlwe1i8fsHF22EvnmbNUZL6Q/jAtp6h+XmG3JhjPQynSmjxj+HYFhPQhTBPiY
         0xZg==
X-Gm-Message-State: APjAAAWlYD9jmYSUbNiBCA4EJT6KYQx3iu0wI6R07K3oi7pw3qEz4VZs
        Rptox/wJmfaRaeUASPu+NA1uv7P6ECm8m+sQro3PBwgQZGfFt4juLrfikGME7yOmL+i7ZWbaznP
        C9O1KdJnhGU5+VsqIninpt0sw
X-Received: by 2002:a2e:b007:: with SMTP id y7mr34551252ljk.69.1574952807522;
        Thu, 28 Nov 2019 06:53:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyX6WbETt4gMUWpV0wZ/2Py0Q2dWzIgwkCGxTImfwQqW1dKylmOb5oxrAJ6cM1GAIE8WjpyYQ==
X-Received: by 2002:a2e:b007:: with SMTP id y7mr34551238ljk.69.1574952807282;
        Thu, 28 Nov 2019 06:53:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k10sm8611145lfo.76.2019.11.28.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:53:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 62FC9180339; Thu, 28 Nov 2019 15:53:24 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf v2] bpftool: Allow to link libbpf dynamically
Date:   Thu, 28 Nov 2019 15:53:16 +0100
Message-Id: <20191128145316.1044912-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127094837.4045-1-jolsa@kernel.org>
References: 
MIME-Version: 1.0
X-MC-Unique: KJXzcXpOOFC5p361d-hRKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we support only static linking with kernel's libbpf
(tools/lib/bpf). This patch adds LIBBPF_DYNAMIC compile variable
that triggers libbpf detection and bpf dynamic linking:

  $ make -C tools/bpf/bpftool make LIBBPF_DYNAMIC=3D1

If libbpf is not installed, build (with LIBBPF_DYNAMIC=3D1) stops with:

  $ make -C tools/bpf/bpftool LIBBPF_DYNAMIC=3D1
    Auto-detecting system features:
    ...                        libbfd: [ on  ]
    ...        disassembler-four-args: [ on  ]
    ...                          zlib: [ on  ]
    ...                        libbpf: [ OFF ]

  Makefile:102: *** Error: No libbpf devel library found, please install-de=
vel or libbpf-dev.

Adding LIBBPF_DIR compile variable to allow linking with
libbpf installed into specific directory:

  $ make -C tools/lib/bpf/ prefix=3D/tmp/libbpf/ install_lib install_header=
s
  $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/tmp/libbpf/

It might be needed to clean build tree first because features
framework does not detect the change properly:

  $ make -C tools/build/feature clean
  $ make -C tools/bpf/bpftool/ clean

Since bpftool uses bits of libbpf that are not exported as public API in
the .so version, we also pass in libbpf.a to the linker, which allows it to
pick up the private functions from the static library without having to
expose them as ABI.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
v2:
  - Pass .a file to linker when dynamically linking, so bpftool can use
    private functions from libbpf without exposing them as API.
   =20
 tools/bpf/bpftool/Makefile | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 39bc6f0f4f0b..397051ed9e41 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
+# LIBBPF_DYNAMIC to enable libbpf dynamic linking.
+
 include ../../scripts/Makefile.include
 include ../../scripts/utilities.mak
+include ../../scripts/Makefile.arch
+
+ifeq ($(LP64), 1)
+  libdir_relative =3D lib64
+else
+  libdir_relative =3D lib
+endif
=20
 ifeq ($(srctree),)
 srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
@@ -55,7 +64,7 @@ ifneq ($(EXTRA_LDFLAGS),)
 LDFLAGS +=3D $(EXTRA_LDFLAGS)
 endif
=20
-LIBS =3D $(LIBBPF) -lelf -lz
+LIBS =3D -lelf -lz
=20
 INSTALL ?=3D install
 RM ?=3D rm -f
@@ -63,6 +72,19 @@ RM ?=3D rm -f
 FEATURE_USER =3D .bpftool
 FEATURE_TESTS =3D libbfd disassembler-four-args reallocarray zlib
 FEATURE_DISPLAY =3D libbfd disassembler-four-args zlib
+ifdef LIBBPF_DYNAMIC
+  FEATURE_TESTS   +=3D libbpf
+  FEATURE_DISPLAY +=3D libbpf
+
+  # for linking with debug library run:
+  # make LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/opt/libbpf
+  ifdef LIBBPF_DIR
+    LIBBPF_CFLAGS  :=3D -I$(LIBBPF_DIR)/include
+    LIBBPF_LDFLAGS :=3D -L$(LIBBPF_DIR)/$(libdir_relative)
+    FEATURE_CHECK_CFLAGS-libbpf  :=3D $(LIBBPF_CFLAGS)
+    FEATURE_CHECK_LDFLAGS-libbpf :=3D $(LIBBPF_LDFLAGS)
+  endif
+endif
=20
 check_feat :=3D 1
 NON_CHECK_FEAT_TARGETS :=3D clean uninstall doc doc-clean doc-install doc-=
uninstall
@@ -88,6 +110,20 @@ ifeq ($(feature-reallocarray), 0)
 CFLAGS +=3D -DCOMPAT_NEED_REALLOCARRAY
 endif
=20
+ifdef LIBBPF_DYNAMIC
+  ifeq ($(feature-libbpf), 1)
+    # bpftool uses non-exported functions from libbpf, so pass both dynami=
c and
+    # static versions and let the linker figure it out
+    LIBS    :=3D -lbpf $(LIBBPF) $(LIBS)
+    CFLAGS  +=3D $(LIBBPF_CFLAGS)
+    LDFLAGS +=3D $(LIBBPF_LDFLAGS)
+  else
+    dummy :=3D $(error Error: No libbpf devel library found, please instal=
l-devel or libbpf-dev.)
+  endif
+else
+  LIBS :=3D $(LIBBPF) $(LIBS)
+endif
+
 include $(wildcard $(OUTPUT)*.d)
=20
 all: $(OUTPUT)bpftool
--=20
2.24.0

