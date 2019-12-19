Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9BCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F36222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781571;
	bh=MSTmn19y5LfHBUQ5A/ONZHHDbesMDuEavtreafrtXao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aopLdZYGDm5z1Ju04RTGUAqfxqpJtS3118t9R1jvFp1pSShi5cCruku+T/8HRGy2S
	 5bo8Ghei1FccX4nUCQkKrTeI+pyu1p4Ono/9RUmOST2B/nYa3YDUPuqKtXXbAm+DcT
	 7d2Jooohc1R9Cv5yMCFHAEcB9tgXNFwVybO41pmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfLSSwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbfLSSwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:52:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00C6222C2;
        Thu, 19 Dec 2019 18:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781566;
        bh=MSTmn19y5LfHBUQ5A/ONZHHDbesMDuEavtreafrtXao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1sChXQmsQOCN+F1sF4XPcJUqEo87zUxBpngRwCRy16mTr0J3ApR6LE8EWjMLHmyX
         u7yjtJgvaRefJNpZ0+7UEe4kAt3VtEKi7AXzjdWhR8UB/PI1ZnlUUmNqrXUhNrhepG
         gDAX+RuUvR/wJl2It06Qtr/sxxmWpzvCmlsPhFxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 09/47] tcp: md5: fix potential overestimation of TCP option space
Date:   Thu, 19 Dec 2019 19:34:23 +0100
Message-Id: <20191219182906.185214546@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182857.659088743@linuxfoundation.org>
References: <20191219182857.659088743@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9424e2e7ad93ffffa88f882c9bc5023570904b55 ]

Back in 2008, Adam Langley fixed the corner case of packets for flows
having all of the following options : MD5 TS SACK

Since MD5 needs 20 bytes, and TS needs 12 bytes, no sack block
can be cooked from the remaining 8 bytes.

tcp_established_options() correctly sets opts->num_sack_blocks
to zero, but returns 36 instead of 32.

This means TCP cooks packets with 4 extra bytes at the end
of options, containing unitialized bytes.

Fixes: 33ad798c924b ("tcp: options clean up")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -740,8 +740,9 @@ static unsigned int tcp_established_opti
 			min_t(unsigned int, eff_sacks,
 			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
 			      TCPOLEN_SACK_PERBLOCK);
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(opts->num_sack_blocks))
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
 	}
 
 	return size;


