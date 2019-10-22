Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64F3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77482075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfJVM76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:59:58 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55767 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389138AbfJVM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:59:53 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iMtl1-0002WG-UN; Tue, 22 Oct 2019 13:59:28 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iMtl1-0002kH-6c; Tue, 22 Oct 2019 13:59:27 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xdp: fix type of string pointer in __XDP_ACT_SYM_TAB
Date:   Tue, 22 Oct 2019 13:59:25 +0100
Message-Id: <20191022125925.10508-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The table entry in __XDP_ACT_SYM_TAB for the last item is set
to { -1, 0 } where it should be { -1, NULL } as the second item
is a pointer to a string.

Fixes the following sparse warnings:

./include/trace/events/xdp.h:28:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:53:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:82:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:140:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:155:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:190:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:225:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:260:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:318:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:356:1: warning: Using plain integer as NULL pointer
./include/trace/events/xdp.h:390:1: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/trace/events/xdp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index 8c8420230a10..c7e3c9c5bad3 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -22,7 +22,7 @@
 #define __XDP_ACT_SYM_FN(x)	\
 	{ XDP_##x, #x },
 #define __XDP_ACT_SYM_TAB	\
-	__XDP_ACT_MAP(__XDP_ACT_SYM_FN) { -1, 0 }
+	__XDP_ACT_MAP(__XDP_ACT_SYM_FN) { -1, NULL }
 __XDP_ACT_MAP(__XDP_ACT_TP_FN)
 
 TRACE_EVENT(xdp_exception,
-- 
2.23.0

