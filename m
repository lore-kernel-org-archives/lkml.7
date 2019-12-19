Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0515C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D79B24682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781352;
	bh=tc9iaH0QKNlux55ZJu8yFPkzOJn+awv5dQxmAPwZQUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLpkDNuMHxML/VVIHB0mqWk9wmD8EO2bCq7WcMMW/sgVD0keMcDNMhHJmibmaOESW
	 WCBgED0fIrrRxRzAkhjkOKaS1A2oDWsdKqyAfljZyXrIXIIyUq0zAwoWgtNmMHgRSS
	 kSTNyPH9WX+3aeS5OwXL19nB2Ff9s/0FPb/xHegM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfLSStL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbfLSStH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:49:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B227224676;
        Thu, 19 Dec 2019 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781347;
        bh=tc9iaH0QKNlux55ZJu8yFPkzOJn+awv5dQxmAPwZQUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WP2oTLsi4y6qaJgvaCxfm9GVE6Id3Lxy/Iu3PCrGU9CDiUrpJgXrsV4g3YZrirP6G
         E2qb7EBgPubQarM3MWxK0DG+igjukfwom4Ht96kLeij6Z5IhtkhUjXTTpciPtxyyil
         nWaGEGYc4kcZWmh9o0lyyfizjXBHGFNYA47pBhys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 184/199] tcp: Protect accesses to .ts_recent_stamp with {READ,WRITE}_ONCE()
Date:   Thu, 19 Dec 2019 19:34:26 +0100
Message-Id: <20191219183225.848766336@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit 721c8dafad26ccfa90ff659ee19755e3377b829d ]

Syncookies borrow the ->rx_opt.ts_recent_stamp field to store the
timestamp of the last synflood. Protect them with READ_ONCE() and
WRITE_ONCE() since reads and writes aren't serialised.

Use of .rx_opt.ts_recent_stamp for storing the synflood timestamp was
introduced by a0f82f64e269 ("syncookies: remove last_synq_overflow from
struct tcp_sock"). But unprotected accesses were already there when
timestamp was stored in .last_synq_overflow.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -494,17 +494,17 @@ struct sock *cookie_v4_check(struct sock
  */
 static inline void tcp_synq_overflow(const struct sock *sk)
 {
-	unsigned long last_overflow = tcp_sk(sk)->rx_opt.ts_recent_stamp;
+	unsigned long last_overflow = READ_ONCE(tcp_sk(sk)->rx_opt.ts_recent_stamp);
 	unsigned long now = jiffies;
 
 	if (!time_between32(now, last_overflow, last_overflow + HZ))
-		tcp_sk(sk)->rx_opt.ts_recent_stamp = now;
+		WRITE_ONCE(tcp_sk(sk)->rx_opt.ts_recent_stamp, now);
 }
 
 /* syncookies: no recent synqueue overflow on this listening socket? */
 static inline bool tcp_synq_no_recent_overflow(const struct sock *sk)
 {
-	unsigned long last_overflow = tcp_sk(sk)->rx_opt.ts_recent_stamp;
+	unsigned long last_overflow = READ_ONCE(tcp_sk(sk)->rx_opt.ts_recent_stamp);
 
 	/* If last_overflow <= jiffies <= last_overflow + TCP_SYNCOOKIE_VALID,
 	 * then we're under synflood. However, we have to use


