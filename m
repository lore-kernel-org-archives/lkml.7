Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38D021925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138792;
	bh=T/bw5cz5xcieSnScfE3ocFzXCHAhH79QBN7+YULZ5gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lXmq4fm2N9m/UX3QCDFLTXGdG/HgGxc65RD3MKOVJOd4+MeSw8F3JyXOAHq9V3VZi
	 PdgblaKp1s+dOnUaTUNnkWGEzYoMbcoXvFNvy7KXs2d/hotqKroId7HOiisxGzxK1o
	 rdwAMjoQwEdMrAsIgSNosPd74yOh6BnJl8Fdtf3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfDARNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbfDARNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4AB20883;
        Mon,  1 Apr 2019 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138785;
        bh=T/bw5cz5xcieSnScfE3ocFzXCHAhH79QBN7+YULZ5gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWm9BRcXw5kPiOKO8lbUkOGl+IDfEMU4ZX5Z+tLTOSB/6s2J1IXMcegQ86eupI6mL
         wxvjO0OzOryFq7DCdQLH2MlqUtnPFm0vDtHtr6mQPGvdDAMEWvhCgzB19YBlzSUReg
         w1J/aiSrpJIEk6xiqlnS0shlUW9g2swIjS86OWOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 020/134] sctp: use memdup_user instead of vmemdup_user
Date:   Mon,  1 Apr 2019 19:00:56 +0200
Message-Id: <20190401170046.453135159@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit ef82bcfa671b9a635bab5fa669005663d8b177c5 ]

In sctp_setsockopt_bindx()/__sctp_setsockopt_connectx(), it allocates
memory with addrs_size which is passed from userspace. We used flag
GFP_USER to put some more restrictions on it in Commit cacc06215271
("sctp: use GFP_USER for user-controlled kmalloc").

However, since Commit c981f254cc82 ("sctp: use vmemdup_user() rather
than badly open-coding memdup_user()"), vmemdup_user() has been used,
which doesn't check GFP_USER flag when goes to vmalloc_*(). So when
addrs_size is a huge value, it could exhaust memory and even trigger
oom killer.

This patch is to use memdup_user() instead, in which GFP_USER would
work to limit the memory allocation with a huge addrs_size.

Note we can't fix it by limiting 'addrs_size', as there's no demand
for it from RFC.

Reported-by: syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com
Fixes: c981f254cc82 ("sctp: use vmemdup_user() rather than badly open-coding memdup_user()")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1017,7 +1017,7 @@ static int sctp_setsockopt_bindx(struct
 	if (unlikely(addrs_size <= 0))
 		return -EINVAL;
 
-	kaddrs = vmemdup_user(addrs, addrs_size);
+	kaddrs = memdup_user(addrs, addrs_size);
 	if (unlikely(IS_ERR(kaddrs)))
 		return PTR_ERR(kaddrs);
 
@@ -1025,7 +1025,7 @@ static int sctp_setsockopt_bindx(struct
 	addr_buf = kaddrs;
 	while (walk_size < addrs_size) {
 		if (walk_size + sizeof(sa_family_t) > addrs_size) {
-			kvfree(kaddrs);
+			kfree(kaddrs);
 			return -EINVAL;
 		}
 
@@ -1036,7 +1036,7 @@ static int sctp_setsockopt_bindx(struct
 		 * causes the address buffer to overflow return EINVAL.
 		 */
 		if (!af || (walk_size + af->sockaddr_len) > addrs_size) {
-			kvfree(kaddrs);
+			kfree(kaddrs);
 			return -EINVAL;
 		}
 		addrcnt++;
@@ -1072,7 +1072,7 @@ static int sctp_setsockopt_bindx(struct
 	}
 
 out:
-	kvfree(kaddrs);
+	kfree(kaddrs);
 
 	return err;
 }
@@ -1347,7 +1347,7 @@ static int __sctp_setsockopt_connectx(st
 	if (unlikely(addrs_size <= 0))
 		return -EINVAL;
 
-	kaddrs = vmemdup_user(addrs, addrs_size);
+	kaddrs = memdup_user(addrs, addrs_size);
 	if (unlikely(IS_ERR(kaddrs)))
 		return PTR_ERR(kaddrs);
 
@@ -1367,7 +1367,7 @@ static int __sctp_setsockopt_connectx(st
 	err = __sctp_connect(sk, kaddrs, addrs_size, flags, assoc_id);
 
 out_free:
-	kvfree(kaddrs);
+	kfree(kaddrs);
 
 	return err;
 }


