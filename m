Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF1DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B2221773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412130;
	bh=OjqWwYMO5xE/tInpKW9KcmandjJF28+2Rv6Sw6bkFBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nz6KLyWCuYy83PGL/+UWUkq0iWUp5xmRRls3tOPfguijbNUjPOBdG1Jy1FT8VoYDV
	 h5TbWSuOBIWxFKA33zMx4KgDhWbusK424C1ava+zrUCEbSI07X2/L+8D1tmgfrUApx
	 Ah7kPMt6QIj7MqGgKtzM3TZA++UPhh0BRdJm/6L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfCLRQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbfCLRPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:50 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE0221850;
        Tue, 12 Mar 2019 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410950;
        bh=OjqWwYMO5xE/tInpKW9KcmandjJF28+2Rv6Sw6bkFBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0/DUjC+1yL3nLuKyoeTLIoeBUwjD3fpBeRXZqW2Ax3bygA+fkudehlwpNTDE40ry
         2pmNLg66B+g91Z9Y1MfWbRpGN2qJwHrNFaQwztP1WbKukOZp9OE4AXGMhJWINjlRPE
         zwK41U+B87wB/Ts2y2PDzsj2EyD4paqdeOEaFJOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Celik <mail@timurcelik.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 031/135] tun: fix blocking read
Date:   Tue, 12 Mar 2019 10:07:58 -0700
Message-Id: <20190312170344.005209586@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Celik <mail@timurcelik.de>

[ Upstream commit 71828b2240692cec0e68b8d867bc00e1745e7fae ]

This patch moves setting of the current state into the loop. Otherwise
the task may end up in a busy wait loop if none of the break conditions
are met.

Signed-off-by: Timur Celik <mail@timurcelik.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1714,9 +1714,9 @@ static struct sk_buff *tun_ring_recv(str
 	}
 
 	add_wait_queue(&tfile->wq.wait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
 
 	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		skb = skb_array_consume(&tfile->tx_array);
 		if (skb)
 			break;
@@ -1732,7 +1732,7 @@ static struct sk_buff *tun_ring_recv(str
 		schedule();
 	}
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tfile->wq.wait, &wait);
 
 out:


