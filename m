Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA465C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2954217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411016;
	bh=2U0Acx/tVmXNoFfRpGFrOgrq9i1/qogXMqkI6hCeFk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PEUTF0F7SSfZ2juW0DHa1bODcpxxt81ZNBfvYbkj3uVhJz260C+esWizQie/T3oMf
	 t6Q4A9ClnZCUaS/WCyC1+3XIX+BMS8r5YsD6PcaTGIft9fJ9txYd8r+5L1iuiyfdTB
	 mr4oz3DE7LC3m2fDNzYvc/fWJJ/yqyGPxQTftVr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfCLRQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbfCLRPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:51 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0392087C;
        Tue, 12 Mar 2019 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410951;
        bh=2U0Acx/tVmXNoFfRpGFrOgrq9i1/qogXMqkI6hCeFk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmRpF7kAzougjx2/UDQf1kztI9BMs2S86y6zWjHB2i4RUnhJiSN5gbo/h7SOqWaWo
         dIH9k+8wF3l7exsagUTWPEWWO3klH/B+AXBoZWeWqlo9UcGYlcQvcwMg+THNsN4p7Q
         swGivCi8oYXrc0qvOm08P8V4V81yb+Uqg1n6v+7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Celik <mail@timurcelik.de>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 032/135] tun: remove unnecessary memory barrier
Date:   Tue, 12 Mar 2019 10:07:59 -0700
Message-Id: <20190312170344.091432513@linuxfoundation.org>
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

[ Upstream commit ecef67cb10db7b83b3b71c61dbb29aa070ab0112 ]

Replace set_current_state with __set_current_state since no memory
barrier is needed at this point.

Signed-off-by: Timur Celik <mail@timurcelik.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1732,7 +1732,7 @@ static struct sk_buff *tun_ring_recv(str
 		schedule();
 	}
 
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tfile->wq.wait, &wait);
 
 out:


