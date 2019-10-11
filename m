Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A7C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD1C214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHN9i8uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfJKA2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:28:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35505 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfJKA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so8057317lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pOlOkzzU0bwqDGQkGWa87uAZFQ6B6XzFeEn3c66o8lU=;
        b=QHN9i8ukUhuJBaTW1UkwsHCf7J5j7HE4qIMcwKRdrirpcaAonzp03YiEqPSRwe3zx/
         xA0MoKbGih4p4DFXZwDwFBVobJyP2faVBo7sSRFrH+xMkpC/PIjgjau5tDOW+sFmwLwz
         g1hsnFO0QNDJkY3FkwUuMwhUKVchwkKKVMSTy0IBQDH2rghXK2Kb+YMjb+e9v4KFDu0l
         5++1qegXGXuL7utw193IWXAe67LN2wicnj/KIR+LUI+F5L2i9Y7eBDqDrS+Yn4GQu+Dy
         0MUQU2rjtqKV6psnZKCzGon4ksn3ln70MKD8EGIAdfYhyEuOTccCJajTz1HJ7wxhCkN3
         Ez7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pOlOkzzU0bwqDGQkGWa87uAZFQ6B6XzFeEn3c66o8lU=;
        b=EH3EpfbJOXJC+fnixrLcl3kHwNwCaOB8wIORDYdPzAybsIn8X3pIq7gCTGxkEKu3tX
         KG1Hp8Dy8FgXnrt1wUjDORSsa5Wnxr+lXNYLRtp5IXLFMcJhfMYorQF93l64ySy9bVqW
         PVO/mj2g3ZDwg/+x1l7jd8PtWK+fwxQpzHsLNN39YA0pRzoQFHm0gxrHBXr1nnS93c85
         xMymFqT4pOK0C+I1CFBJ98flhaQPvLC7cp8zsuMbPPtePGMTHJk7nLBlyPtLva+GaSLw
         0CSk5KYtoE8xGjCo5KxJxcwzyI8Wbv8axGNxybR8AE+XbfdBFOoCMzBqrUaHhLKmlc1d
         Sf4A==
X-Gm-Message-State: APjAAAVBIVmAfHpacnHUc1BZutww8JxmJBVtQLF3SVeZQNjt9Ke0ecxN
        Wh0n5lQXA6cMDv6EoJcdK3bZAQ==
X-Google-Smtp-Source: APXvYqx/hZhkYlHMDs/0fYgLREAPdm0Rklj16fXnm+aBEBcqoa/exgzworlTmmiIrWj0rsP8Zh/sXw==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr7479171ljm.83.1570753721062;
        Thu, 10 Oct 2019 17:28:41 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:40 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 15/15] samples/bpf: add preparation steps and sysroot info to readme
Date:   Fri, 11 Oct 2019 03:28:08 +0300
Message-Id: <20191011002808.28206-16-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add couple preparation steps: clean and configuration. Also add newly
added sysroot support info to cross-compile section.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/README.rst | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 5f27e4faca50..cc1f00a1ee06 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -14,6 +14,20 @@ Compiling requires having installed:
 Note that LLVM's tool 'llc' must support target 'bpf', list version
 and supported targets with command: ``llc --version``
 
+Clean and configuration
+-----------------------
+
+It can be needed to clean tools, samples or kernel before trying new arch or
+after some changes (on demand)::
+
+ make -C tools clean
+ make -C samples/bpf clean
+ make clean
+
+Configure kernel, defconfig for instance::
+
+ make defconfig
+
 Kernel headers
 --------------
 
@@ -68,9 +82,26 @@ It is also possible to point make to the newly compiled 'llc' or
 Cross compiling samples
 -----------------------
 In order to cross-compile, say for arm64 targets, export CROSS_COMPILE and ARCH
-environment variables before calling make. This will direct make to build
-samples for the cross target.
+environment variables before calling make. But do this before clean,
+cofiguration and header install steps described above. This will direct make to
+build samples for the cross target::
+
+ export ARCH=arm64
+ export CROSS_COMPILE="aarch64-linux-gnu-"
+
+Headers can be also installed on RFS of target board if need to keep them in
+sync (not necessarily and it creates a local "usr/include" directory also)::
+
+ make INSTALL_HDR_PATH=~/some_sysroot/usr headers_install
+
+Pointing LLC and CLANG is not necessarily if it's installed on HOST and have
+in its targets appropriate arm64 arch (usually it has several arches).
+Build samples::
+
+ make samples/bpf/
+
+Or build samples with SYSROOT if some header or library is absent in toolchain,
+say libelf, providing address to file system containing headers and libs,
+can be RFS of target board::
 
-export ARCH=arm64
-export CROSS_COMPILE="aarch64-linux-gnu-"
-make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
+ make samples/bpf/ SYSROOT=~/some_sysroot
-- 
2.17.1

