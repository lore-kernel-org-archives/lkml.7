Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC95ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B552190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPel8NhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfJIUmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:42:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33098 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbfJIUl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so3917706ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPicZ6dKiXggVDaTmZsHbexmmGF0NBX0XkLCl2NE9e8=;
        b=kPel8NhRVnyQDF2w6QWADNKWtsbDrjQPr/EdHwNRDl4cLpDTWXyvgReDZ91tE3VFXh
         dXHtbNI4k24um1FnMS7LDF9GQriPKlXm2AfN93wb6AlJCjBcZ+1ovPI3gmCbHjz7YiUG
         VTdR6WGa4vqentsck08qtxZzbc8hvVkqXMbD3LMwWWynxWghejtOT4tGdHljpAs/7Ago
         p43hmGYeoMy4u8J0oJUns/wP/+M+48aW9ccDLPcj4/rU/oCy+pYw5NM9CgumGq3C6Bar
         V0Sd3jBn0QjysTdCA5u0gfWo6eZSg9xv2soEhRb0SroRn5shjSsYspO+3Hs+E+nHixXg
         0/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPicZ6dKiXggVDaTmZsHbexmmGF0NBX0XkLCl2NE9e8=;
        b=DGNyFy86tymfxMH7Fn0dj8x55v8mqhshHZTHDfmh+2FCbgSw3r2e9J2WCX0go9PkP+
         DIBIrn6xCpUAh+3QwOx3ZCr6EZpAaoT61sJJkhJtmhUoa1ERwGAtaboA+A5UVF2KvrEj
         TuuL4/iYETBiipJOxMEQXtqu2zvU2TsKJSWgre0gGp7eYRXob0YM3vnoTa3EG1xEUY/S
         /RsdBeLlBY4r8Sy58DoilkXa8+D/aDP6GmECkNZaGBVt0q1yPb0hTWZ1fzg4VpUMvIsd
         P3Fh/yu+oQ5ElLKFnEZvw8AuRbNUPj1QR7oEMafqbRrnZLoeZhLaWu9wVZdpt2tpu6BQ
         bU7Q==
X-Gm-Message-State: APjAAAXii1k/Nj4G29sGlDBgwDXBmWCiLmUQ3vo82253dtUbgUOEdwxY
        pJQlHXvsQXeJokjnOaUTLSvjPQ==
X-Google-Smtp-Source: APXvYqzwWGi4GRBV7LqCTbrCRo2MAQiJrRU4pTiOllSLBVV5JYfE6TfutDsHiizQlpYTCl6wwSaK9Q==
X-Received: by 2002:a2e:2943:: with SMTP id u64mr3622095lje.241.1570653716268;
        Wed, 09 Oct 2019 13:41:56 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:55 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 12/15] libbpf: add C/LDFLAGS to libbpf.so and test_libpf targets
Date:   Wed,  9 Oct 2019 23:41:31 +0300
Message-Id: <20191009204134.26960-13-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of C/LDFLAGS there is no way to pass them correctly to build
command, for instance when --sysroot is used or external libraries
are used, like -lelf, wich can be absent in toolchain. This can be
used for samples/bpf cross-compiling allowing to get elf lib from
sysroot.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 46280b5ad48d..75b538577c17 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -174,8 +174,9 @@ bpf_helper_defs.h: $(srctree)/include/uapi/linux/bpf.h
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
-				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
+	$(QUIET_LINK)$(CC) $(LDFLAGS) \
+		--shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
+		-Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
 	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(LIBBPF_MAJOR_VERSION)
 
@@ -183,7 +184,7 @@ $(OUTPUT)libbpf.a: $(BPF_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
 $(OUTPUT)test_libbpf: test_libbpf.c $(OUTPUT)libbpf.a
-	$(QUIET_LINK)$(CC) $(INCLUDES) $^ -lelf -o $@
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(INCLUDES) $^ -lelf -o $@
 
 $(OUTPUT)libbpf.pc:
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
-- 
2.17.1

