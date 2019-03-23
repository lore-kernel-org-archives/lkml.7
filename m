Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45841C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084AE2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UiOmgfaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfCWBxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:53:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43509 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfCWBxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 21:53:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so2649347pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 18:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuNyeUjcjgM9t85Km8UXdB8JIJnuD60U7OVlczqKzp8=;
        b=UiOmgfaFQfn94Vskp+AqrsOVXz65vPeRSQog9WXzKL5CmkHtAgEmGQYDPU+dIIWzp9
         acXhWSwNKV848Lq2IBfVXBXnMdweWXyl4VO1cysm//XXzC3stfmVctvi7Et56aULFY/B
         MdX0/6IAb4RWykiPkSgJtZvRbO/xSkANjSQ9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuNyeUjcjgM9t85Km8UXdB8JIJnuD60U7OVlczqKzp8=;
        b=kBIV+OrMj0i4tTEY+F6a5XNxMXWVCgd1zjPAewmtGrcx8xYCTIxhZqKca2QELBC+G9
         lx54tipKmlQwrmEGCXDYtD3+4oBMtKRAR9hl9O4+XLHo5LplQz+G6BTo1a7A83dLJKUb
         naNejK3bOPPKNkWDvNA3W4UY8sq656HrN+7vhidKS7J4cpOOToZo8+gShINJFXd5b7zh
         luSexERTd2I3uy41TkMMG6dJu672SlXTL0BeS7yRJdiUuTZBzAWbj2tks3l5OtA1Pkc9
         QOT0Ija+oyuAEdWoSiXHQwwq459Ilc8Bu3nEvkG00u74ZRKWX4PVevkfRydK8Q4GRrc7
         wnFw==
X-Gm-Message-State: APjAAAVkUV8yEx9OpFKHxJ52Z0+8/TMimlm9v2tn/OmMVdesIFHUduU4
        ZnBHMnoTxAxEyjqFcm43g9fQ+A==
X-Google-Smtp-Source: APXvYqzXyjOLbHH27GafFdcA8WGUaouBIKHbtqx0THmjk/ToKdES/qvwBOcNhU9yj3iQmoJiWsi1kQ==
X-Received: by 2002:aa7:8ad4:: with SMTP id b20mr5822844pfd.249.1553305983426;
        Fri, 22 Mar 2019 18:53:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m24sm9822534pgv.1.2019.03.22.18.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:53:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in kdb summary
Date:   Fri, 22 Mar 2019 18:52:27 -0700
Message-Id: <20190323015227.245455-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you drop into kdb and type "summary", it prints out a line that
says this:

  ccversion  CCVERSION

...and I don't mean that it actually prints out the version of the C
compiler.  It literally prints out the string "CCVERSION".

The version of the C Compiler is already printed at boot up and it
doesn't seem useful to replicate this in kdb.  Let's just delete it.
We can also delete the bit of the Makefile that called the C compiler
in an attempt to pass this into kdb.  This will remove one extra call
to the C compiler at Makefile parse time and (very slightly) speed up
builds.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/Makefile   | 1 -
 kernel/debug/kdb/kdb_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/debug/kdb/Makefile b/kernel/debug/kdb/Makefile
index d4fc58f4b88d..efac857c5511 100644
--- a/kernel/debug/kdb/Makefile
+++ b/kernel/debug/kdb/Makefile
@@ -6,7 +6,6 @@
 # Copyright (c) 2009 Wind River Systems, Inc. All Rights Reserved.
 #
 
-CCVERSION	:= $(shell $(CC) -v 2>&1 | sed -ne '$$p')
 obj-y := kdb_io.o kdb_main.o kdb_support.o kdb_bt.o gen-kdb_cmds.o kdb_bp.o kdb_debugger.o
 obj-$(CONFIG_KDB_KEYBOARD)    += kdb_keyboard.o
 
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 82a3b32a7cfc..fc96dbf8d9de 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2522,7 +2522,6 @@ static int kdb_summary(int argc, const char **argv)
 	kdb_printf("machine    %s\n", init_uts_ns.name.machine);
 	kdb_printf("nodename   %s\n", init_uts_ns.name.nodename);
 	kdb_printf("domainname %s\n", init_uts_ns.name.domainname);
-	kdb_printf("ccversion  %s\n", __stringify(CCVERSION));
 
 	now = __ktime_get_real_seconds();
 	time64_to_tm(now, 0, &tm);
-- 
2.21.0.392.gf8f6787159e-goog

