Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45556C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158B620830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139594;
	bh=2tS9aKPuceuRwJGKin9gwgB9t/sdvi0b8/7Z4+taiqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GIdzWaqAsIwwDfDSfqiXVD6GjpBB/JSb2tVLYrlCjMt/JyE+YkNPrUaa+F/s0lQ36
	 03y8CMurRntWWb3u85Ws4++vKbDpEME1SDyhguuJAQT79OoeFjB3uJgipC66jpAHz5
	 y3mEpUwYSYvj9bsSgLf1HweFL4FfGo1W9MuOGIok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbfDAR0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732018AbfDAR0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:26:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FEA720830;
        Mon,  1 Apr 2019 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139590;
        bh=2tS9aKPuceuRwJGKin9gwgB9t/sdvi0b8/7Z4+taiqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKZffGkEV0ildZ5RuV6YmrCs2D3KmX/YsqU3QUFbbxudPQQPgnRuhEfMV1UPJqYMS
         IRXuAIB0V7X+LLd198z0C0Kp9m1dUBQ7kklRDej55wTPbtfMYXrsURlw/Me7gAV362
         EH+gRAgY4WJMQYEMW9RuqoSL9t3n/rMneNL4dwo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 13/56] sctp: get sctphdr by offset in sctp_compute_cksum
Date:   Mon,  1 Apr 2019 19:02:29 +0200
Message-Id: <20190401170104.645234540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 273160ffc6b993c7c91627f5a84799c66dfe4dee ]

sctp_hdr(skb) only works when skb->transport_header is set properly.

But in Netfilter, skb->transport_header for ipv6 is not guaranteed
to be right value for sctphdr. It would cause to fail to check the
checksum for sctp packets.

So fix it by using offset, which is always right in all places.

v1->v2:
  - Fix the changelog.

Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sctp/checksum.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/sctp/checksum.h
+++ b/include/net/sctp/checksum.h
@@ -60,7 +60,7 @@ static inline __wsum sctp_csum_combine(_
 static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
 					unsigned int offset)
 {
-	struct sctphdr *sh = sctp_hdr(skb);
+	struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
         __le32 ret, old = sh->checksum;
 	const struct skb_checksum_ops ops = {
 		.update  = sctp_csum_update,


