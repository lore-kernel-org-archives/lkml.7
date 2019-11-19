Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B79C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933482241E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVN/i5s/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKSS5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:57:53 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33110 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfKSS5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:57:53 -0500
Received: by mail-wr1-f53.google.com with SMTP id w9so25207622wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AlF55tHmwaf4MqjtYLnLUKyMqEVxUolFQJuCOS0Pms8=;
        b=VVN/i5s/Renk6ZqhXJHaifiNV0eK1Jv06CHOHabk7FjtFCrzdto980JIjcUBDomjqM
         2A3EDvrgK9aI4+xOrwBDTWjBH4bEhmLybHc1QTD89S7FBq0MuMsCfSHSdSrZLofkEoN3
         2PCk7LR7nC0lbkAks/IoIDI4AYg2DitsMp4WJsYGQFJ/2mPq1A/m6GJdFeIUxbXPF7dP
         /k9b1m0YOxfF/5x8oY77VoGo6O4mI8EVaCqEE/7UHpsRGC+0Ud+fnuwbV+B5kmx4Fnqb
         90EjuR0Ow6UQuudhzobkic1iUk8oJ+OvIgYiNsZmfcDMpbhn3whol1ZZ0S1YcR56nr8+
         pgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AlF55tHmwaf4MqjtYLnLUKyMqEVxUolFQJuCOS0Pms8=;
        b=qYmRhuXcW0slFrPPlRU+sQGoTYgMzcXCn6WgP18/ohsmtrW4SW+a5IiyrsIp9TEsR1
         jmT7RoV6Rj6d8HAtzeOT+4kWlgMogPB4H+Bt+s5x2Tr8I+7Mre3ba/ZYAvWX9qvPq4XV
         RUbn13kx5lgvJcjlfelndAOI+MNM7AG+/DuXPcylG542OVuelTk7Jbsus2o5T0Y4EEPg
         sIbxGiVTpAoPx/5yCnLuxSA83RgPTSVhgzsk9YDMTpt4JEIzDihAlHxPnNavw5Z/uF3i
         IQzU5+rrJbIpImliWqaFYCaXSstXlSU9SLJ2jlhj9JMpur3f93FGqNJSMcQpo7skVAnR
         EeQg==
X-Gm-Message-State: APjAAAWAAJIfTScPovVYCG3/QIiYGp6ikR1ErcvV8Dl5RBwMNSPa9RYm
        +q1a2aBQTSJ/a2dvvijp2ecHQ1QwlhOALw==
X-Google-Smtp-Source: APXvYqx44dVWxeofUPw2ECrAUt9b+aQ0z04SPU2FAjq5d9VN80N7u2IjvfOMQ9+ajcMmquhIBsKI7Q==
X-Received: by 2002:adf:ed4e:: with SMTP id u14mr40406481wro.132.1574189868998;
        Tue, 19 Nov 2019 10:57:48 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id 19sm31875516wrc.47.2019.11.19.10.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:57:48 -0800 (PST)
Date:   Tue, 19 Nov 2019 19:57:42 +0100
From:   Marco Elver <elver@google.com>
To:     Marco Elver <elver@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH -next] kcsan, ubsan: Make KCSAN+UBSAN work together
Message-ID: <20191119185742.GB68739@google.com>
References: <20191119194658.39af50d0@canb.auug.org.au>
 <e75be639-110a-c615-3ec7-a107318b7746@infradead.org>
 <CANpmjNMpnY54kDdGwOPOD84UDf=Fzqtu62ifTds2vZn4t4YigQ@mail.gmail.com>
 <fb7e25d8-aba4-3dcf-7761-cb7ecb3ebb71@infradead.org>
 <20191119183407.GA68739@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119183407.GA68739@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context:
http://lkml.kernel.org/r/fb7e25d8-aba4-3dcf-7761-cb7ecb3ebb71@infradead.org

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/Makefile | 1 +
 lib/Makefile          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index dd15b62ec0b5..df6b7799e492 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 KCSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
+UBSAN_SANITIZE := n
 
 CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
 
diff --git a/lib/Makefile b/lib/Makefile
index 778ab704e3ad..9d5bda950f5f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -279,6 +279,7 @@ obj-$(CONFIG_UBSAN) += ubsan.o
 
 UBSAN_SANITIZE_ubsan.o := n
 KASAN_SANITIZE_ubsan.o := n
+KCSAN_SANITIZE_ubsan.o := n
 CFLAGS_ubsan.o := $(call cc-option, -fno-stack-protector) $(DISABLE_STACKLEAK_PLUGIN)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
-- 
2.24.0.432.g9d3f5f5b63-goog
