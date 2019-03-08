Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B70C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD3C20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050439;
	bh=rr1bfHPL3VAmb4R49VUZVCA4wxKy2Ff0BhG/A1RhPKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WI0GDtWLVh8HGA4eP1CvqvhgUfHUgJDTWVzWiW0mEh6VPu2WVuyRYwCjmkfLoWWDj
	 0lcYasuduvV/ORzaTVUjJKdsyLDa5iVQvPRdyZ1mhBke10xKtHlAtEZVSS/jvx+uJu
	 /lf7arVKtI7UlRhPwbSNNhI2fDpdMKpu7/0jiiLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCHNHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:07:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfCHMy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:54:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1BE220449;
        Fri,  8 Mar 2019 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049668;
        bh=rr1bfHPL3VAmb4R49VUZVCA4wxKy2Ff0BhG/A1RhPKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SN2SlttIYyNvU8XgyVTcqwCK1jtyebyVq6WQ3bBgSq+uj/wDo6mZgk1iDFY7xAGOB
         PIb8IpLBvwSQYLISxmXsREYGthKr4J9Gtzrk15qvzXyiSCYCAkFFCKeD+fG+VspPoT
         05FlfosON/jxiJ9SrGaYrfEfPu1j1do+6Br3MO6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 26/76] sctp: call iov_iter_revert() after sending ABORT
Date:   Fri,  8 Mar 2019 13:49:38 +0100
Message-Id: <20190308124915.714711484@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 901efe12318b1ea8d3e2c88a7b75ed6e6d5d7245 ]

The user msg is also copied to the abort packet when doing SCTP_ABORT in
sctp_sendmsg_check_sflags(). When SCTP_SENDALL is set, iov_iter_revert()
should have been called for sending abort on the next asoc with copying
this msg. Otherwise, memcpy_from_msg() in sctp_make_abort_user() will
fail and return error.

Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL process in sendmsg")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1866,6 +1866,7 @@ static int sctp_sendmsg_check_sflags(str
 
 		pr_debug("%s: aborting association:%p\n", __func__, asoc);
 		sctp_primitive_ABORT(net, asoc, chunk);
+		iov_iter_revert(&msg->msg_iter, msg_len);
 
 		return 0;
 	}


