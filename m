Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C8CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C364A214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBpmXphy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391465AbfDRSW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:22:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34828 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391518AbfDRSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so1468914pfh.2;
        Thu, 18 Apr 2019 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=vYr4TTvTItyCC0XodL84g9xeo3aF20lLGRsMcAPXUEg=;
        b=IBpmXphyb71eJuHKD53RamnFK71RtaRfk+lvNZ4VwpLouZ5Iz6gfW2yNpaCJicBE7f
         zwAOsGPnlWCEXubP3ZmXazWaDcq9sIM1qR/ZfDeMIAfjs+8z2fJB8rC68qLLVG3bO2XM
         rf6ROlmnQgyafTFQnmcBtfFEs7tNC7K55RAHR5x7HBYDcTpNhJkJHdOoebGB7Rth9w3f
         eS07cYzdNbe8lfvL3Bw9aU52pAKINP1DSnh7+jovfuMyH9MqOiB722Ow9zVbGDYN2r7q
         dyGsMnyJk5l92GaYARUYclcXnNjezuwnoKqinqhRuFhnS1Agv4sIOAW60bO9z7+jvQRY
         IStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=vYr4TTvTItyCC0XodL84g9xeo3aF20lLGRsMcAPXUEg=;
        b=gbg24NCP9xayOkagZps1B+YOdj/HgTLhNLyv1SpNz6nRfBlMd6/tRWPbV4G0iDAyak
         wl9oRMLc6iu+ZMEMLYF/yUsLIVz1bwTUKXNFvTpiKcwve1UKIU/5N5y+SKQCgmrztF5H
         D+xz+q58fYwc6RtPYRqd6Hbj8sh8H+w3N1mMo/f+euFIhSFUKU51vqr1YIInZaP6SJeC
         +uchO2KL3mNN3+KPdRY1vDz+npZCHG5Pj1J9uA7/vd8UYvd/mUEDF9KBej5+sq76v711
         vc9wz3x5sKZ8JUdhezcyGqmfb7l/3nI5EzEh9CmFk6l1Qk/RKHQxg+amTgFZ5ME0Eoy7
         iR5Q==
X-Gm-Message-State: APjAAAVU7MT+Gb6fFx6CdYgh1iVkhg+v9NPisy0ZFQXI7j5wFkezpqR8
        rgWYkHfhWYwDoPwgi2Aul+ZLk7Uk
X-Google-Smtp-Source: APXvYqxHMHY7CDM7sTRWGhvwN9D7uidBsQmjGNfiW7mTJDEaS0ItQsGXl5mfRS/Whd5iqYj1UAZ4CQ==
X-Received: by 2002:aa7:96c6:: with SMTP id h6mr7585608pfq.239.1555610801860;
        Thu, 18 Apr 2019 11:06:41 -0700 (PDT)
Received: from udknight.localhost ([59.57.228.71])
        by smtp.gmail.com with ESMTPSA id k1sm5172670pfc.83.2019.04.18.11.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 11:06:40 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id x3II5EOV004878;
        Fri, 19 Apr 2019 02:05:14 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id x3II5D4W004875;
        Fri, 19 Apr 2019 02:05:13 +0800
Date:   Fri, 19 Apr 2019 02:05:13 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fix compile errors due to unsync linux/in6.h and
 netinet/in.h
Message-ID: <20190418180513.GA4863@udknight>
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

I meet below compile errors:
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

My environment:
lsb_release -a:
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 16.04.6 LTS
Release:        16.04
Codename:       xenial

dpkg -l | grep libc-dev:
ii  libc-dev-bin              2.23-0ubuntu11           amd64        GNU C Library: Development binaries
ii  linux-libc-dev:amd64      4.4.0-145.171            amd64        Linux Kernel Headers for development.

The reason is linux/in6.h and netinet/in.h aren't synchronous about how to
handle the same definitions, IPPROTO_HOPOPTS, etc.

This patch fixes the compile errors by moving <netinet/in.h> to before the
<linux/*.h>.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Changes
 v1-v2:
 1:Rewrite the changelog.

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
