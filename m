Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C3DC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EEA205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098860;
	bh=CTjBzB+KJIVMPus7iBajhkmtdUk36gXw7ErqSCDYUOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NCFhyRKoeCMpzR7MBVeW/IIhRJOcIx9Yu5oYkC4S85B4fqYyco+SIvk/m6iQ6atS3
	 lvdFIRBE3hdnDwGW9SF1tb2Ee+nvF7p0yFuE4D6TqT4D5QGUexeY8PkibykmSSeIum
	 CN1QmHrvwEFMMgcZmltcyEY6xL6f/mW9cMp4W1ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfFIQrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbfFIQr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:47:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C95205ED;
        Sun,  9 Jun 2019 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098845;
        bh=CTjBzB+KJIVMPus7iBajhkmtdUk36gXw7ErqSCDYUOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+iR1uO2yQm0uVQupat/I07OuGlrMxYDrBa8vcioljaVXQMkbaPDYj2MRn+LifvIA
         ucCLILMVwtzz/5RBbAEsR+fkIPqGeM6WRv6SbLC3XpAoJNF/zAnldqf+fVVTyq57L6
         Ea8Y1yRG8Fa88RGf+M0VBAOwM1Yp82DsYe72IJjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 4.19 12/51] packet: unconditionally free po->rollover
Date:   Sun,  9 Jun 2019 18:41:53 +0200
Message-Id: <20190609164127.826684331@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit afa0925c6fcc6a8f610e996ca09bc3215048033c ]

Rollover used to use a complex RCU mechanism for assignment, which had
a race condition. The below patch fixed the bug and greatly simplified
the logic.

The feature depends on fanout, but the state is private to the socket.
Fanout_release returns f only when the last member leaves and the
fanout struct is to be freed.

Destroy rollover unconditionally, regardless of fanout state.

Fixes: 57f015f5eccf2 ("packet: fix crash in fanout_demux_rollover()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Diagnosed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3017,8 +3017,8 @@ static int packet_release(struct socket
 
 	synchronize_net();
 
+	kfree(po->rollover);
 	if (f) {
-		kfree(po->rollover);
 		fanout_release_data(f);
 		kfree(f);
 	}


