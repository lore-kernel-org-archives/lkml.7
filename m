Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEE7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0128B2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvUYi924"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbfDQRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:53:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38984 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbfDQRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:53:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id a96so12378451pla.6;
        Wed, 17 Apr 2019 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=y9rf2VbQ19opfqPjdZnguxWyfymBk0j8jACOfJPVGDU=;
        b=QvUYi924emJGksEr2foZ1lKY+boQEAnIQd8Yvqm3uc2Xx0nijMzVFlSkERP0TP1HSI
         cf4s+i64cxltbSE2a+lw3LwmtctuwpUlvdSaQXGSdUf01n21iMX8wTfFbklb5dwpgJ8w
         w5WfpHixPYEe/v5A69r52L3LDnDdqbey8q3BTMBwrgs7TdUmkhzlKaVLV21mHR6fIyeb
         GyaWv3dU/jt3AMbWkiuyl9pv7VVI3MroMn8mcgKGwthHissWSQvn1IbMiC454aLn1une
         p0L1yHclC8XTq68H8CeBdZvwQpaiOaAkSof8QOoDd5RTvuMdy8/CBMx2z3Wh05whIX0+
         Ganw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=y9rf2VbQ19opfqPjdZnguxWyfymBk0j8jACOfJPVGDU=;
        b=UfAjFB7RTlij5y80DGuhFp4LhjlunxHZH08XT3s8hx0DxYAhQQSEv0SHlzY/z8VaJW
         E6JxDI4/hjA8LEco/LNKuVX816BfI+2iC/9LLhs/4vzbYoYyN/NjzUbX3mI8x2a3yIYJ
         1Owsm+9P5R3t66eb1pTEJ34BljBnPZU6O63TC2xyBhVU9qXjLtBQ9CShB9LGZ+JvhXat
         dSg2qH6PP2T77oF1JFGKXUXtzkaHCWmzwaE2ImFnpsHyGSb11uAIu3VbTQOQhf/zc9qa
         /IbEOVZBaWStlrJ9m86jzzaY1HsM3GERXsRW09r5VOHAV6TnXLqKC6n38eHU36rCTvCX
         x7KA==
X-Gm-Message-State: APjAAAWEuR3KFc3QSIl42nLan7JrIm9W+GEjKhcOuLWxxuUmsX3cQZ4y
        3J6I+tptlOQYgw1derzbOoC1H8NH
X-Google-Smtp-Source: APXvYqxDFNlYhFWIOa2FNYjWV4pGCLNNv5h4Cp6AFf9F+P3GSOWsA+xTq+7WFUs66PefE0SazFoZxw==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr90506705plo.0.1555523615459;
        Wed, 17 Apr 2019 10:53:35 -0700 (PDT)
Received: from udknight.localhost ([59.57.228.71])
        by smtp.gmail.com with ESMTPSA id d25sm73973725pfn.154.2019.04.17.10.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:53:34 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id x3HHmmbt016727;
        Thu, 18 Apr 2019 01:48:48 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id x3HHmddJ016691;
        Thu, 18 Apr 2019 01:48:39 +0800
Date:   Thu, 18 Apr 2019 01:48:39 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: fix compile errors with older glibc
Message-ID: <20190417174839.GA16679@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The older glibc (for example, 2.23) doesn't handle __UAPI_DEF_*
in libc-compat.h properly, and it bring below compile errors:
"
In file included from test_tcpnotify_kern.c:12:
/usr/include/netinet/in.h:101:5: error: expected identifier
    IPPROTO_HOPOPTS = 0,   /* IPv6 Hop-by-Hop options.  */
    ^
/usr/include/linux/in6.h:131:26: note: expanded from macro 'IPPROTO_HOPOPTS'
                                ^
In file included from test_tcpnotify_kern.c:12:
/usr/include/netinet/in.h:103:5: error: expected identifier
    IPPROTO_ROUTING = 43,  /* IPv6 routing header.  */
    ^
/usr/include/linux/in6.h:132:26: note: expanded from macro 'IPPROTO_ROUTING'
                                ^
In file included from test_tcpnotify_kern.c:12:
/usr/include/netinet/in.h:105:5: error: expected identifier
    IPPROTO_FRAGMENT = 44, /* IPv6 fragmentation header.  */
    ^
/usr/include/linux/in6.h:133:26: note: expanded from macro 'IPPROTO_FRAGMENT'
"
The same compile errors are reported for test_tcpbpf_kern.c too.

This patch fixes the compile errors by moving <netinet/in.h> to before the
<linux/*.h>.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c    | 2 +-
 tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index 74f73b3..c7c3240 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stddef.h>
 #include <string.h>
+#include <netinet/in.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
@@ -9,7 +10,6 @@
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/tcp.h>
-#include <netinet/in.h>
 #include "bpf_helpers.h"
 #include "bpf_endian.h"
 #include "test_tcpbpf.h"
diff --git a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
index edbca20..ec6db6e 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stddef.h>
 #include <string.h>
+#include <netinet/in.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
@@ -9,7 +10,6 @@
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/tcp.h>
-#include <netinet/in.h>
 #include "bpf_helpers.h"
 #include "bpf_endian.h"
 #include "test_tcpnotify.h"
-- 
1.8.5.6.2.g3d8a54e.dirty
