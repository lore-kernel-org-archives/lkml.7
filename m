Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC869ECE596
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51A521D7E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKt173H8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfJIUl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:41:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38747 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbfJIUly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so3880560ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OsXgBugq9yBTYp2TWj7gghCrTtBB47X9YeLV9E3YhNo=;
        b=XKt173H8wj8IKIt4DSevJv+kXD2QtQYilXS8zfwcM9SF+6OorOJJ3SmvoU7IACx3N5
         ZD4/UL/3p86LvvBJV/yGSkWEyRdtqTpfMBJxpHO+ck6akQ2JdmFtBmoy7w3Ci0j5MNfD
         7iatnjl5O8In1S22aDEa0gNv47xnsUTG4FhY67C5Wp4Yde6cgVue2NsEVNcETOtarJDt
         PE5ipS2g0wOPpz4f84UV0CtrbwKOFXWdySlA/CO/sr6CDtBjDHIjVYO8596kQW+ndpi1
         XOrbcWeIxekD8aI7aComYtS7I2L5V6w7+5MYsOTBISOvFA2UYk/Xr5Y4IpEQMDDqn4ym
         q65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OsXgBugq9yBTYp2TWj7gghCrTtBB47X9YeLV9E3YhNo=;
        b=omnRr5soxJIauJzipNQVVdETn/ngq6Qk9CEwpr3PXh80mhR/eCHeNKRRJSEQOklZNS
         7tBAJdEWhA0MKINuIohEF/sY+Bg/GrqxtC81cpWDujmAbEgv791DajZsMz1gcHofUnK2
         aJrbL55wG6GMEJDP6D/0pwrPmf0pcMP9/Z80A2VPreJSHQz3BXXxnS+TIjsIAJ+7qmhs
         IVFOybyKJv7MOXvchbg3MXe0MeNnhhDnVYJDrnj3ARQv3mGSuGrXDzB+1BFfa4eHNXl0
         8nLUU6Vua3kNQkEF0VNhfzyu3KtR++1htLSAwf6+PvcVUVCSvSzG9kp58TfUJM0MfOuo
         Cu5g==
X-Gm-Message-State: APjAAAX5OGoqjIFjMASuQ+Lnnnf3cvVPBU1cl+Inh8g+Yhvh79YQlPR+
        OZ8EObD6vGLQeN/9mRWavKKrpg==
X-Google-Smtp-Source: APXvYqyKSVYA9IYS07/s7Tz9nGuH4Qj6X8tIMaQkbg3VmhvMOSJ5DehlnN9a0rFAYF6qMZNs9/iBSA==
X-Received: by 2002:a2e:9958:: with SMTP id r24mr3544709ljj.61.1570653712166;
        Wed, 09 Oct 2019 13:41:52 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:51 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 09/15] samples/bpf: use own flags but not HOSTCFLAGS
Date:   Wed,  9 Oct 2019 23:41:28 +0300
Message-Id: <20191009204134.26960-10-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling natively, the host's cflags and ldflags are equal to
ones used from HOSTCFLAGS and HOSTLDFLAGS. When cross compiling it
should have own, used for target arch. While verification, for arm,
arm64 and x86_64 the following flags were used always:

-Wall -O2
-fomit-frame-pointer
-Wmissing-prototypes
-Wstrict-prototypes

So, add them as they were verified and used before adding
Makefile.target and lets omit "-fomit-frame-pointer" as were
proposed while review, as no sense in such optimization for samples.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 91bfb421c278..57a15ff938a6 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -176,8 +176,10 @@ BPF_EXTRA_CFLAGS := $(ARM_ARCH_SELECTOR)
 TPROGS_CFLAGS += $(ARM_ARCH_SELECTOR)
 endif
 
-TPROGS_LDLIBS := $(KBUILD_HOSTLDLIBS)
-TPROGS_CFLAGS += $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS)
+TPROGS_CFLAGS += -Wall -O2
+TPROGS_CFLAGS += -Wmissing-prototypes
+TPROGS_CFLAGS += -Wstrict-prototypes
+
 TPROGS_CFLAGS += -I$(objtree)/usr/include
 TPROGS_CFLAGS += -I$(srctree)/tools/lib/bpf/
 TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
-- 
2.17.1

