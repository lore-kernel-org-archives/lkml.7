Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8700EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C3F2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049740;
	bh=/Oek1GxVNdEqvkYWgbHYk5VoCzXl7+mtEl6OijchTNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=smgh8PaGP3zTxFazRUb2M+N+6Dm6TJLjoLSHaUihg/vzWYAOWa4O4HxaqtePAJ0iY
	 WPs6p9HDSeBVi1e+4nr+VhX8yyWoUbQ9VQpZfdPUStFMn42TaH7idKHinmKpv2eS0A
	 RLIuJuMm14d3EI1Iv9TTEBfCY/EamixMOvqlE7oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfCHMzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbfCHMze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7075D20449;
        Fri,  8 Mar 2019 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049733;
        bh=/Oek1GxVNdEqvkYWgbHYk5VoCzXl7+mtEl6OijchTNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXalm31QS6cNF4iuHVzefjYCVnu8keRfO42ZUOmVxARhJCKDVYUc3ax2JDRvxyJPy
         1KUZYL7+1y4TFL2okEu98FSsQPZg2mkwO6ddMpTt0o6RQb5sPKwnm3g/N0XXUqLP7A
         pfrRSHOm6tLJOE29Wy6JIb5UL1DqKXbOJd1sMIT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Celik <mail@timurcelik.de>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 48/76] tun: remove unnecessary memory barrier
Date:   Fri,  8 Mar 2019 13:50:00 +0100
Message-Id: <20190308124916.513867376@linuxfoundation.org>
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
@@ -2165,7 +2165,7 @@ static void *tun_ring_recv(struct tun_fi
 		schedule();
 	}
 
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tfile->wq.wait, &wait);
 
 out:


