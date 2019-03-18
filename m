Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7210C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EC22175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901514;
	bh=qDXkqR7znAsSdaszumKSUWVu1ix8LazTfMXTgaxxrcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lcp+JiBFOfQ7+isC5yZoHtBxJPPGcgQzdBipc0GUOVziQsxiab8rLsHikBCmx18LX
	 DJxvOmBqUX1qbFEdQdujqmzDZIkNbaSCtkhge+k6FEeZcUCHpq8VjGCaAHvTUFpES+
	 gxDP0byB4YsOmLXCeYWM3HiiFWIJ3gdhBDJgYAjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfCRJbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbfCRJbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:31:51 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4E02075C;
        Mon, 18 Mar 2019 09:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901510;
        bh=qDXkqR7znAsSdaszumKSUWVu1ix8LazTfMXTgaxxrcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwivgO1J0oNNlCh56oaBbsf+Qje9h2cI5aB2CEDXwOh53eFYuPBZsOytKoUX7m2QJ
         Sg3xgS2/6uchFXXUQ887X9tLUOG+L4EprqTtzSg4ICff5sqOZJa2TegbpwZl+QIrGJ
         4BpMkzV/ZaHHmVLRWJBD6N5Dqg01/ss60DIPOl4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 16/52] sctp: remove sched init from sctp_stream_init
Date:   Mon, 18 Mar 2019 10:25:13 +0100
Message-Id: <20190318084015.477615186@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

[ Upstream commit 2e990dfd13974d9eae493006f42ffb48707970ef ]

syzbot reported a NULL-ptr deref caused by that sched->init() in
sctp_stream_init() set stream->rr_next = NULL.

  kasan: GPF could be caused by NULL-ptr deref or user memory access
  RIP: 0010:sctp_sched_rr_dequeue+0xd3/0x170 net/sctp/stream_sched_rr.c:141
  Call Trace:
    sctp_outq_dequeue_data net/sctp/outqueue.c:90 [inline]
    sctp_outq_flush_data net/sctp/outqueue.c:1079 [inline]
    sctp_outq_flush+0xba2/0x2790 net/sctp/outqueue.c:1205

All sched info is saved in sout->ext now, in sctp_stream_init()
sctp_stream_alloc_out() will not change it, there's no need to
call sched->init() again, since sctp_outq_init() has already
done it.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Reported-by: syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -230,8 +230,6 @@ int sctp_stream_init(struct sctp_stream
 	for (i = 0; i < stream->outcnt; i++)
 		SCTP_SO(stream, i)->state = SCTP_STREAM_OPEN;
 
-	sched->init(stream);
-
 in:
 	sctp_stream_interleave_init(stream);
 	if (!incnt)


