Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84508C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED1C2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121775;
	bh=CHkZLjem3nkE1m3RRY4Ods+xDIlfZDJEQ8AWlDXFenE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZuASN6xLJ96U0DnelZUaaxi6VevRWVl64obBC5cwGrXs1VyZvbdFme3yNNR6v4ofS
	 fZAsxWa4Yd3mOXFrvPUVSJw02GbZenvtRkP8YytcwVylabyWzYQYkER4OUbTxYht1J
	 Hrldl+ZbVaa1i3H7fUQg9Whz3b5EC39W7jMIne9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393273AbfJCQ4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393150AbfJCQv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:51:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37129222C2;
        Thu,  3 Oct 2019 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121485;
        bh=CHkZLjem3nkE1m3RRY4Ods+xDIlfZDJEQ8AWlDXFenE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0O3+SPqmlkdgM1q76S4VPNBNwFb+lgJ5MTIpqys+k2jOJzsATkcltaoOrhNIkO2Kq
         o+8WKN6K4G57jfefjGqQC40MdQQH+qlu4DVFGDKTBvTslV6CwXJw/auuy8ofMcgwjp
         FFJvP7AXfyiD4lf3X6XqZVw5WWRy0AaqWreOOZCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Rodgman <dave.rodgman@arm.com>,
        "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.3 295/344] lib/lzo/lzo1x_compress.c: fix alignment bug in lzo-rle
Date:   Thu,  3 Oct 2019 17:54:20 +0200
Message-Id: <20191003154608.731764678@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Rodgman <dave.rodgman@arm.com>

commit 09b35b4192f6682dff96a093ab1930998cdb73b4 upstream.

Fix an unaligned access which breaks on platforms where this is not
permitted (e.g., Sparc).

Link: http://lkml.kernel.org/r/20190912145502.35229-1-dave.rodgman@arm.com
Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
Cc: Dave Rodgman <dave.rodgman@arm.com>
Cc: Markus F.X.J. Oberhumer <markus@oberhumer.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/lzo/lzo1x_compress.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -83,17 +83,19 @@ next:
 					ALIGN((uintptr_t)ir, 4)) &&
 					(ir < limit) && (*ir == 0))
 				ir++;
-			for (; (ir + 4) <= limit; ir += 4) {
-				dv = *((u32 *)ir);
-				if (dv) {
+			if (IS_ALIGNED((uintptr_t)ir, 4)) {
+				for (; (ir + 4) <= limit; ir += 4) {
+					dv = *((u32 *)ir);
+					if (dv) {
 #  if defined(__LITTLE_ENDIAN)
-					ir += __builtin_ctz(dv) >> 3;
+						ir += __builtin_ctz(dv) >> 3;
 #  elif defined(__BIG_ENDIAN)
-					ir += __builtin_clz(dv) >> 3;
+						ir += __builtin_clz(dv) >> 3;
 #  else
 #    error "missing endian definition"
 #  endif
-					break;
+						break;
+					}
 				}
 			}
 #endif


