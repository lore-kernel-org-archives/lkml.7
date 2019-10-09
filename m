Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B67EECE59B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4556A2190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pzdPyL78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbfJIUmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:42:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40789 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732171AbfJIUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:42:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so3869102ljw.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZSbYJ+tLtfDuMSVqb7LwJbRD3u314/MfD3p1keHf2Mw=;
        b=pzdPyL78q/gbChT77HCP7gSmJXWVdEWKYJQzr4nN7gdvvWnYwHoI8e+zFj+6pgj6yb
         K8kXXGGo9S629wH2TsCb/WtRqZmXgJJ70q3HTxWrCTT/7iMCwuiKj7zudoSmlfGB+PAI
         /45wQ4KP7k11v6we53lk8hhEeehY1QX9SjVDv/VQv1jaHINDd6U4g/QtWhYfubjHDXgp
         XTVVibyKnEQzXFUc37axnMinQOpbyw7ku8dOxYuTW/BDJAeS00IL5E1xmBcZliiAeCXU
         ntHfGa4HfaPvseNHg7XszDFS0voyh5uMx9tMPpL6EIkU9r4TMaGMpMFzfb6wZW5PrWf4
         cALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZSbYJ+tLtfDuMSVqb7LwJbRD3u314/MfD3p1keHf2Mw=;
        b=bd8gtaTcmZ32RyRIyMfqo7YgeCqZA0SlAiemDECZq587mxybdDWuuKsNQLioo6gnIr
         UFk/koPA+I6raq09dowKXyThq17cn9aH9HE9tNE1IDoKICTYsS7jUM2xcix5ma0xKirh
         W3wtwu63ecSn7mDWv5rqHv8jGOMcfjGCtZ6mswDC/KFqPwDFdMXJe8Gm31fdmocir8yw
         9ufiuVHSr8zjVMkYGvyInPQLmKE+Hv+x9iKZHvxqMORccMrCjJhQpnu0L/uj9n0K4kFV
         zAPo03IHlV2aK0wgksBpP1EMPaC3MJyzeHvch1PTdYVjwCrBcTw9L10qDB+EqCvOgpYG
         XQjQ==
X-Gm-Message-State: APjAAAW6jVaSQZdfs6aa/zZQxJFqw87c+MJrbHJzYIDcYtQlHFjG8twO
        Hm+YU2L+LiquGJ4NuLGbousoZg==
X-Google-Smtp-Source: APXvYqw28C/ieWvRsyR1+UMEt2bz2E5FWkQj5sxBQdPyN7lcnh1XII6n052wtVOlBKbSfxiLGW1YSg==
X-Received: by 2002:a2e:86cd:: with SMTP id n13mr3689328ljj.252.1570653718918;
        Wed, 09 Oct 2019 13:41:58 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:58 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 14/15] samples/bpf: add sysroot support
Date:   Wed,  9 Oct 2019 23:41:33 +0300
Message-Id: <20191009204134.26960-15-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basically it only enables that was added by previous couple fixes.
Sysroot contains correct libs installed and its headers. Useful when
working with NFC or virtual machine.

Usage example:

clean (on demand)
    make ARCH=arm -C samples/bpf clean
    make ARCH=arm -C tools clean
    make ARCH=arm clean

configure and install headers:

    make ARCH=arm defconfig
    make ARCH=arm headers_install

build samples/bpf:
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- samples/bpf/ \
    SYSROOT="path/to/sysroot"

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 6b161326ac67..4df11ddb9c75 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -187,6 +187,11 @@ TPROGS_CFLAGS += -I$(srctree)/tools/lib/
 TPROGS_CFLAGS += -I$(srctree)/tools/include
 TPROGS_CFLAGS += -I$(srctree)/tools/perf
 
+ifdef SYSROOT
+TPROGS_CFLAGS += --sysroot=$(SYSROOT)
+TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
+endif
+
 TPROGCFLAGS_bpf_load.o += -Wno-unused-variable
 
 TPROGS_LDLIBS			+= $(LIBBPF) -lelf
-- 
2.17.1

