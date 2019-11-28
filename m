Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AB6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6190721739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn+imX7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfK1QHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:07:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbfK1QHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574957254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+labIS8D1zO/EBrfo58WwyeK4b86yr4Ay45+sKAX7XA=;
        b=Mn+imX7PLIFzqrsC8zwQb/uwvwocn/4GRi41fQ6GvmhEmNKEXqE/sHCskCmkfm06ntTSKS
        leffiYj/Rw/aIBPisr3ALf7BZACHHgpVU4JIWUk1pZlIBwFITPEcSF8ryUXsKiSM4cCYco
        5LF8LBzPhR+QiGMQIP/u344naIj3jwQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-mO-y99JUPIOowkQx_Vooag-1; Thu, 28 Nov 2019 11:07:31 -0500
Received: by mail-lj1-f199.google.com with SMTP id j13so1177297ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7L035tT9zykqVz7rUhyuDfOzoQMwHGJVTJTz8M7cNU=;
        b=EI7Ck0ri6K8JrcUg7kud0rzWz2rLHQcq2s6YMy05GQEsz+PyRz69eYwQLCCxeOdNyf
         t2zqfvA5opekwTazFQWKzT4NVU2RdjPYUXm3j9jwJuIYkfB1p9Z4YG//giWhYWnPsFLf
         6ux4x1y1b8bGZPMcd6quS48SWG3HS9OVXjA6T5AUY4I6YdoQsoGvnLjboI3S3PuzSZlx
         udbVn5/G9Z6ujOKh+ga4tIojjDZMp75u/9Q0tRskXELslDiNvxWm9qemviHGxqZxJFCL
         oM3X9fDKFrIx+6l8FV2a242SumPRaOHO+P0O5JC2c7PHyRkSBQ+xgyfBxuIX9qNVxv14
         MRJA==
X-Gm-Message-State: APjAAAUS5mlXcjuCO6wBdHV0ub3c9FdzrpDweTq50uvno9EY9fNTo/h1
        NqzcHe2Um47y/lIAKJnRm+IeeAAS7/vNwOK17QSs2bOGmrYmg89iCTSkIGA/nJnFAEapTeKGyDU
        Den8YKPWC8b0pVIOFKOjMS5Av
X-Received: by 2002:a2e:94d6:: with SMTP id r22mr34524939ljh.7.1574957250205;
        Thu, 28 Nov 2019 08:07:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJfSZr/Clsrrcc/gC5NElQhCN1vMNa6l6YoOgiWGNNGSFJcqbgQqbvCxN1lg2chuuA5mTwPA==
X-Received: by 2002:a2e:94d6:: with SMTP id r22mr34524914ljh.7.1574957249922;
        Thu, 28 Nov 2019 08:07:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q24sm8877350ljm.76.2019.11.28.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:07:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9229C180339; Thu, 28 Nov 2019 17:07:28 +0100 (CET)
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
Subject: [PATCH bpf v3] bpftool: Allow to link libbpf dynamically
Date:   Thu, 28 Nov 2019 17:07:12 +0100
Message-Id: <20191128160712.1048793-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128145316.1044912-1-toke@redhat.com>
References: 
MIME-Version: 1.0
X-MC-Unique: mO-y99JUPIOowkQx_Vooag-1
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

  Makefile:102: *** Error: No libbpf devel library found, please install li=
bbpf-devel or libbpf-dev.

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
v3:
  - Keep $(LIBBPF) in $LIBS, and just add -lbpf on top
  - Fix typo in error message
v2:
  - Pass .a file to linker when dynamically linking, so bpftool can use
    private functions from libbpf without exposing them as API.

 tools/bpf/bpftool/Makefile | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 39bc6f0f4f0b..15052dcaa39b 100644
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
@@ -88,6 +110,18 @@ ifeq ($(feature-reallocarray), 0)
 CFLAGS +=3D -DCOMPAT_NEED_REALLOCARRAY
 endif
=20
+ifdef LIBBPF_DYNAMIC
+  ifeq ($(feature-libbpf), 1)
+    # bpftool uses non-exported functions from libbpf, so just add the dyn=
amic
+    # version of libbpf and let the linker figure it out
+    LIBS    :=3D -lbpf $(LIBS)
+    CFLAGS  +=3D $(LIBBPF_CFLAGS)
+    LDFLAGS +=3D $(LIBBPF_LDFLAGS)
+  else
+    dummy :=3D $(error Error: No libbpf devel library found, please instal=
l libbpf-devel or libbpf-dev.)
+  endif
+endif
+
 include $(wildcard $(OUTPUT)*.d)
=20
 all: $(OUTPUT)bpftool
--=20
2.24.0

