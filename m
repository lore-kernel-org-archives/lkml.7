Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDADCA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6218A20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPQddsZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfJ3IIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:08:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33328 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfJ3IIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:08:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id c184so1057320pfb.0;
        Wed, 30 Oct 2019 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZMISj/ns6B4cF3UhPoAMo+kmbpNZlZvaXYeyqScyGFM=;
        b=gPQddsZE9bsl5uNjvCgbqdth67MQP3Qtt+YqM73jh/W5xsp2tzkoj0/mibl3pfrwzT
         iWqmSXaf1dmbkXZhdlLTqo9OVlNQMk/PbwGk3My+1ByP3dLacdwAf0MUZvwQ6WNvHBtV
         OmDvO0rNUhtooTqI4MnwbDj6GWWuoWjjZgbeMiRIKNat1/evUm37tipgKHqLTNbaysVI
         kCfIT8ZSvQHO+nAQ7pBVACAPiY8YIdnI1BhgkjXLuYuawVQfG35lbO/b2o1HszAoMf5n
         7mjgXO52exBNvQ+9rog9gi/wszb8ATyVWAB7kWAKpQt7b2w9GMw/zTIbxUSbkE6kuulU
         U7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZMISj/ns6B4cF3UhPoAMo+kmbpNZlZvaXYeyqScyGFM=;
        b=Ebtr4t3GO7rZGcqJw4bYNu4Axv++9nzgZ35oNpq/Z4Au3pJyZ6R4woKio9fOOON5g+
         IqT4p8O6ruodtAiBl0/sLLWiP4C87Br/Yc7GlmUC6yyGXpa8sD9JIRPDvKpwlZQM8Mwd
         ox0Jwd4EpIpxUkvsaVq2N510nu4nTWnA0iG6sHJ4VdQ8+w8a1mfRCMrNv5JlqGq/6H6A
         sz9f2q2AlhOjR8wLuNJlheIOEhNCy8e0ogSoqbHy+E3EIZKYz5nOw3+rn7mPzfN9CWlN
         WoRPodIKbVUTVlPmYZbXd15ZTFZxtULfPXn0TU9bFwfDG23zE6EUrTec8NWVkG5LDPD5
         K9/Q==
X-Gm-Message-State: APjAAAWMQXD76mPxxCTT/6n51qE+lBE8e5nyNdq61Suq6kMb6bnKrR0k
        xPDLGy63aLXFZR2tZqX1/bQ=
X-Google-Smtp-Source: APXvYqzE9e1rdKwPzXpv8ZeTxli7VKdejkS4sb4tOMCYGPkpkK0oCg8f28IClskVmrJekjNbiVKNiw==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr32369447pgb.22.1572422890492;
        Wed, 30 Oct 2019 01:08:10 -0700 (PDT)
Received: from centOS76.localdomain ([131.228.66.14])
        by smtp.gmail.com with ESMTPSA id z13sm2062923pgz.42.2019.10.30.01.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 01:08:09 -0700 (PDT)
From:   Wally Zhao <wallyzhao@gmail.com>
To:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, davem@davemloft.net,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wally.zhao@nokia-sbell.com, Wally Zhao <wallyzhao@gmail.com>
Subject: [PATCH] sctp: set ooo_okay properly for Transmit Packet Steering
Date:   Wed, 30 Oct 2019 12:07:17 -0400
Message-Id: <1572451637-14085-1-git-send-email-wallyzhao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike tcp_transmit_skb,
sctp_packet_transmit does not set ooo_okay explicitly,
causing unwanted Tx queue switching when multiqueue is in use;
Tx queue switching may cause out-of-order packets.
Change sctp_packet_transmit to allow Tx queue switching only for
the first in flight packet, to avoid unwanted Tx queue switching.

Signed-off-by: Wally Zhao <wallyzhao@gmail.com>
---
 net/sctp/output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/output.c b/net/sctp/output.c
index dbda7e7..5ff75cc 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -626,6 +626,10 @@ int sctp_packet_transmit(struct sctp_packet *packet, gfp_t gfp)
 	/* neighbour should be confirmed on successful transmission or
 	 * positive error
 	 */
+
+	/* allow switch tx queue only for the first in flight pkt */
+	head->ooo_okay = asoc->outqueue.outstanding_bytes == 0;
+
 	if (tp->af_specific->sctp_xmit(head, tp) >= 0 &&
 	    tp->dst_pending_confirm)
 		tp->dst_pending_confirm = 0;
-- 
1.8.3.1

