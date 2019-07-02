Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6700C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA0B2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054712;
	bh=gQX+DVkqG6yaLGDxJKzMrllW8YDLl8e5CRQcMSUTfdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUUHWs+BTqxAYShhXofv2ZwvYQbEmAHhmu6T2eS7p3nj9ajVmoo1bYeLcDSutwVSN
	 xoD/ZSMg7p0BGARiS/v7VqUsSFHZlQM0EwNgRvAEChvP2fF3IJVDtusDs/WdiUrSSE
	 VbJT99b7V/gwUSWNG7Zp79WVvO9hPdXwpi2YbTMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfGBIFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfGBIFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:05:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92A1220659;
        Tue,  2 Jul 2019 08:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054709;
        bh=gQX+DVkqG6yaLGDxJKzMrllW8YDLl8e5CRQcMSUTfdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tx9MjGV2LEqwhRZPF1ptCM33P29LXHvBg2cPQxkqLYEDYrykcJU5V4HhfLgJHG9FL
         iboJnCJJ8qz7jN+PquDfDa6Ii9K9Cpuc9HPXENPCB/eFcZUf85JJPwNEm4hhhYr4ci
         h/F6bI0f9NzEuCrH4M4lA9hgIZhj47Q8VH1jsSFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 33/55] net/packet: fix memory leak in packet_set_ring()
Date:   Tue,  2 Jul 2019 10:01:41 +0200
Message-Id: <20190702080125.852953548@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.103022729@linuxfoundation.org>
References: <20190702080124.103022729@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 55655e3d1197fff16a7a05088fb0e5eba50eac55 ]

syzbot found we can leak memory in packet_set_ring(), if user application
provides buggy parameters.

Fixes: 7f953ab2ba46 ("af_packet: TX_RING support for TPACKET_V3")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4341,7 +4341,7 @@ static int packet_set_ring(struct sock *
 				    req3->tp_sizeof_priv ||
 				    req3->tp_feature_req_word) {
 					err = -EINVAL;
-					goto out;
+					goto out_free_pg_vec;
 				}
 			}
 			break;
@@ -4405,6 +4405,7 @@ static int packet_set_ring(struct sock *
 			prb_shutdown_retire_blk_timer(po, rb_queue);
 	}
 
+out_free_pg_vec:
 	if (pg_vec)
 		free_pg_vec(pg_vec, order, req->tp_block_nr);
 out:


