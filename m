Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B0C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0696C21848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VmUcEtSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKHF6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:58:41 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:38701 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHF6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:58:41 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id xA85wEFE032227;
        Fri, 8 Nov 2019 14:58:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com xA85wEFE032227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573192695;
        bh=C6AGQ4ZhToMyLia08WQzoZyBptTxN4AsuUDH8eYeGzY=;
        h=From:To:Cc:Subject:Date:From;
        b=VmUcEtSzmV/7WNU5m3yOAxTSaW+TgijTWm5aldVprDa0ZcZDfeEBPkrwtWPef+cod
         Cs/NEUrZMwqMXgOJivtnQK7MpJ9ZFSrtdE82Xm97UXzbkqI60xzoCbMaSKsC3gAgKl
         rVlEwZ9P/VoDGHWlo/iA6Qo5rQtKUgf0357I4DsbDIVWbA6yCmrH5Ds/0RE6SByOrA
         N4sVb1fYxUOdSmeS5m0vl7Yt41OkBjVBrxYGMISzoQ1AwEZTJ/1YO7XN9vqKINYPQo
         5dIOGLjmJ3Ta6T2dwTXjFVrEfM8fugSCl2MjsehIi781Xv/8UyzvcPbK4ZK/jDQ007
         2uEwhYkWLzh+g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] linux/scc.h: make uapi linux/scc.h self-contained
Date:   Fri,  8 Nov 2019 14:58:08 +0900
Message-Id: <20191108055809.26969-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace cannot compile <linux/scc.h>

  CC      usr/include/linux/scc.h.s
In file included from <command-line>:32:0:
./usr/include/linux/scc.h:20:20: error: ‘SIOCDEVPRIVATE’ undeclared here (not in a function)
  SIOCSCCRESERVED = SIOCDEVPRIVATE,
                    ^~~~~~~~~~~~~~

Include <linux/sockios.h> to make it self-contained, and add it to
the compile-test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/linux/scc.h | 1 +
 usr/include/Makefile     | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/scc.h b/include/uapi/linux/scc.h
index c5bc7f747755..947edb17ce9d 100644
--- a/include/uapi/linux/scc.h
+++ b/include/uapi/linux/scc.h
@@ -4,6 +4,7 @@
 #ifndef _UAPI_SCC_H
 #define _UAPI_SCC_H
 
+#include <linux/sockios.h>
 
 /* selection of hardware types */
 
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 107d04bd5ee3..b469e39eafc8 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -41,7 +41,6 @@ header-test- += linux/omapfb.h
 header-test- += linux/patchkey.h
 header-test- += linux/phonet.h
 header-test- += linux/reiserfs_xattr.h
-header-test- += linux/scc.h
 header-test- += linux/sctp.h
 header-test- += linux/signal.h
 header-test- += linux/sysctl.h
-- 
2.17.1

