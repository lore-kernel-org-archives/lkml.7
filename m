Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1BCC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E401C24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781438;
	bh=SITc7/PEGxVwVplmUK2aVfm5gJJQYv4EfPlG7C40O1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1dGLqj5uTCZJV0wzWZdmCPq2LsCoDf88T3kjaf2qubCTFuqOCivJ97cj5ay2apHty
	 JrRp2EnDDCDr2on7ABPykRM+PC8knuOKxdVQoOq+dahpCae6uDHpFMV3EDsxNMkrS+
	 xbNYjQMHLjsLnjpxjQWlqQ4EQKWevDriCdYhGUyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfLSSuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbfLSSue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:50:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AEE820674;
        Thu, 19 Dec 2019 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781432;
        bh=SITc7/PEGxVwVplmUK2aVfm5gJJQYv4EfPlG7C40O1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2Eeg9shGSdq4AIbs2KQTJdkgsNhmgCLHGeSBbbVyxnDX9ErC5veF5nTzlV6LZFNA
         iQYuJyQSxNwMlYiYUj8mSBvjbpJHaYGX+e3KGtcd16MW2NgJtHfS/GK4ZlWkUaRuiW
         HlYAGeTenlYN+y0fTSU6I/bq8byMk6c9Bmz/R5qQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/36] tcp: tighten acceptance of ACKs not matching a child socket
Date:   Thu, 19 Dec 2019 19:34:26 +0100
Message-Id: <20191219182856.561120120@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182848.708141124@linuxfoundation.org>
References: <20191219182848.708141124@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit cb44a08f8647fd2e8db5cc9ac27cd8355fa392d8 ]

When no synflood occurs, the synflood timestamp isn't updated.
Therefore it can be so old that time_after32() can consider it to be
in the future.

That's a problem for tcp_synq_no_recent_overflow() as it may report
that a recent overflow occurred while, in fact, it's just that jiffies
has grown past 'last_overflow' + TCP_SYNCOOKIE_VALID + 2^31.

Spurious detection of recent overflows lead to extra syncookie
verification in cookie_v[46]_check(). At that point, the verification
should fail and the packet dropped. But we should have dropped the
packet earlier as we didn't even send a syncookie.

Let's refine tcp_synq_no_recent_overflow() to report a recent overflow
only if jiffies is within the
[last_overflow, last_overflow + TCP_SYNCOOKIE_VALID] interval. This
way, no spurious recent overflow is reported when jiffies wraps and
'last_overflow' becomes in the future from the point of view of
time_after32().

However, if jiffies wraps and enters the
[last_overflow, last_overflow + TCP_SYNCOOKIE_VALID] interval (with
'last_overflow' being a stale synflood timestamp), then
tcp_synq_no_recent_overflow() still erroneously reports an
overflow. In such cases, we have to rely on syncookie verification
to drop the packet. We unfortunately have no way to differentiate
between a fresh and a stale syncookie timestamp.

In practice, using last_overflow as lower bound is problematic.
If the synflood timestamp is concurrently updated between the time
we read jiffies and the moment we store the timestamp in
'last_overflow', then 'now' becomes smaller than 'last_overflow' and
tcp_synq_no_recent_overflow() returns true, potentially dropping a
valid syncookie.

Reading jiffies after loading the timestamp could fix the problem,
but that'd require a memory barrier. Let's just accommodate for
potential timestamp growth instead and extend the interval using
'last_overflow - HZ' as lower bound.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -512,7 +512,15 @@ static inline bool tcp_synq_no_recent_ov
 {
 	unsigned long last_overflow = tcp_sk(sk)->rx_opt.ts_recent_stamp;
 
-	return time_after(jiffies, last_overflow + TCP_SYNCOOKIE_VALID);
+	/* If last_overflow <= jiffies <= last_overflow + TCP_SYNCOOKIE_VALID,
+	 * then we're under synflood. However, we have to use
+	 * 'last_overflow - HZ' as lower bound. That's because a concurrent
+	 * tcp_synq_overflow() could update .ts_recent_stamp after we read
+	 * jiffies but before we store .ts_recent_stamp into last_overflow,
+	 * which could lead to rejecting a valid syncookie.
+	 */
+	return !time_between32(jiffies, last_overflow - HZ,
+			       last_overflow + TCP_SYNCOOKIE_VALID);
 }
 
 static inline u32 tcp_cookie_time(void)


