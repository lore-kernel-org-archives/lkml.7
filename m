Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D9BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A446421775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613420;
	bh=IHzMM2maoLgK/NDRYcIVKcvpPDeFmrfH5TzgT+2Ohak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zHwxacdvGSXrI2bXlaOzTFxa15F9NF4nIkEuNsAu5wk1AbLUb5H/VjUitlYf9CPIp
	 A3ItW/oEzbJqmmPl3U76x9SDJUOjRj+13iGFdtfBx8ojF74pZwMXF7bO5O5J0Q/0f3
	 adZgU2hIHZ1vl1VIo4fJWk79uF/YvC0dh3T7Lh4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfLQUKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbfLQUKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:10:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83AF221D7D;
        Tue, 17 Dec 2019 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613415;
        bh=IHzMM2maoLgK/NDRYcIVKcvpPDeFmrfH5TzgT+2Ohak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNibgwySVqUD4Q8FmmFEf4CV2S85GkLI12AdDkKDQ6ELou+sgzW9FUbvp9pZeagTa
         THPk7gsd4Pz89lhiiVzB0BaXNw4XS2xhg4gUlUUz31jmQRPuTogd1Zmq+UIhsoB2yl
         rdrtdxNSrFIz7jjavPTgOLuRGz4nfYX8nJt2fo1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 12/37] tcp: md5: fix potential overestimation of TCP option space
Date:   Tue, 17 Dec 2019 21:09:33 +0100
Message-Id: <20191217200726.084603820@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
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
@@ -755,8 +755,9 @@ static unsigned int tcp_established_opti
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


