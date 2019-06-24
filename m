Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD09C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB42321473
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370740;
	bh=sLCeOjCrzZWFX3mgX9qYm4q7YOx5AuqolYxd8ZsyC4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OJ0j3FgVec75oIwexeHSgfWQPJ+ARHgvqrN2zNoEvi4AeomrAmsgOBibqcc2uxv8f
	 fC8HfsrG0RJeUrw4JA0VFY7zexybaaxrv20vAFCCdFeM/lawv2f+uAjqOmpOoL9L1x
	 quKEnmlY1rS9GkTxwAwHwe0Br7qgqw7CZYyfp3Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfFXKFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729944AbfFXKFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:05:34 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ADF1208E3;
        Mon, 24 Jun 2019 10:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370733;
        bh=sLCeOjCrzZWFX3mgX9qYm4q7YOx5AuqolYxd8ZsyC4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EwPM7zXE7xlEZ779FYdOEBlFshbMmDWAaZuo7a93YBxQAdYwbunYKyYokI8mejLBf
         vDU1dKh2PGZQrEK7K1FXmzATXrNUrEdQ+NsMs9PDNsN4aB3E7AeQcTPv2zFriIO+9g
         CdjBwkCVUCP+1X1+FPs/8yoMxL0ipLU4a82mp3Fc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 71/90] can: purge socket error queue on sock destruct
Date:   Mon, 24 Jun 2019 17:57:01 +0800
Message-Id: <20190624092318.678635319@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

commit fd704bd5ee749d560e86c4f1fd2ef486d8abf7cf upstream.

CAN supports software tx timestamps as of the below commit. Purge
any queued timestamp packets on socket destroy.

Fixes: 51f31cabe3ce ("ip: support for TX timestamps on UDP and RAW sockets")
Reported-by: syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/can/af_can.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -105,6 +105,7 @@ EXPORT_SYMBOL(can_ioctl);
 static void can_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge(&sk->sk_error_queue);
 }
 
 static const struct can_proto *can_get_proto(int protocol)


