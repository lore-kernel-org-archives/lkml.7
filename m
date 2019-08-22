Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3289C41514
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D882064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495045;
	bh=S5fq1gyPpjlzADyaUeZ9auniopys715Ee8R+VyyfMuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WYmWYegbC9NJ90uRuxCgemf9EK9IlXhggGmZ/0p9sTv4E8p5V5KJmVfaA54mCIG9z
	 pjcUFsCecdqNy01SX1jmMJsdjC0IJNQBj4smX7HfzyhztyjDg/60BP9YD90zWOdvVV
	 xcQ+4hGjVNI4hbqLvtRPspbuFPGG1MthtH11JnwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404614AbfHVR0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391807AbfHVRZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:02 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F202341D;
        Thu, 22 Aug 2019 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494701;
        bh=S5fq1gyPpjlzADyaUeZ9auniopys715Ee8R+VyyfMuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmy8lxaHn6PVpB67W6GFWNrBIW2qQ31ILIlD2PehwaRSErcXR7g43dPYV8GGcP7R4
         UFtLwacvhq7x2nEyA3OH/af+y0IQDU7roffF3zhn48mKFs9yI/xy1frhrQM5L/RVM4
         GucrznWwpMZX9rs4NvO8jt0Ne4nbpoumXBUdziCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 55/71] Revert "tcp: Clear sk_send_head after purging the write queue"
Date:   Thu, 22 Aug 2019 10:19:30 -0700
Message-Id: <20190822171730.183440197@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e99e7745d03fc50ba7c5b7c91c17294fee2d5991.

Ben Hutchings writes:

>Sorry, this is the same issue that was already fixed by "tcp: reset
>sk_send_head in tcp_write_queue_purge".  You can drop my version from
>the queue for 4.4 and 4.9 and revert it for 4.14.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9de2c8cdcc512..7994e569644e0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1613,8 +1613,6 @@ static inline void tcp_init_send_head(struct sock *sk)
 	sk->sk_send_head = NULL;
 }
 
-static inline void tcp_init_send_head(struct sock *sk);
-
 /* write queue abstraction */
 static inline void tcp_write_queue_purge(struct sock *sk)
 {
@@ -1623,7 +1621,6 @@ static inline void tcp_write_queue_purge(struct sock *sk)
 	tcp_chrono_stop(sk, TCP_CHRONO_BUSY);
 	while ((skb = __skb_dequeue(&sk->sk_write_queue)) != NULL)
 		sk_wmem_free_skb(sk, skb);
-	tcp_init_send_head(sk);
 	sk_mem_reclaim(sk);
 	tcp_clear_all_retrans_hints(tcp_sk(sk));
 	tcp_init_send_head(sk);
-- 
2.20.1



