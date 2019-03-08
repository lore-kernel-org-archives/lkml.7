Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F550C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641EC20449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050064;
	bh=KkyznvAUP5JahSTC0njIH3MvJKMsyDA5XGUom70z5i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t/hCSOoh9ZbeL9CUBorkJX1jV0wyz70IHeEJAsCGecFDRz3PwqgareCx62wml8Diq
	 kyrEsR5bx7+YQUBMzHAoaJJAYGI1ZLvnigTKmZBJgq8F8OhyVavRXcH6Auw/ToXfuX
	 uRLHX/B/ydwtfTO82uDRAOj24xENZXHAbau47Ezw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfCHNBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbfCHNA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7435320449;
        Fri,  8 Mar 2019 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050059;
        bh=KkyznvAUP5JahSTC0njIH3MvJKMsyDA5XGUom70z5i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trBRfJo765RRVvYw3y69pzaWy1bERmhAeVb2QIZNSHzzRbJGYjDwAkWXAaVYhVuTn
         dPdqEu3/3t4k6ycmFPhzAwUwAQPucBym3JIlvIFkJ6V7n3mardbmtI/NvkbNgg8fOG
         3mcply8Ccs8po5vdgl5D20NaUtJsXZVmLtXSkn/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Celik <mail@timurcelik.de>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 41/68] tun: remove unnecessary memory barrier
Date:   Fri,  8 Mar 2019 13:50:11 +0100
Message-Id: <20190308124912.730840230@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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
@@ -2140,7 +2140,7 @@ static void *tun_ring_recv(struct tun_fi
 		schedule();
 	}
 
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tfile->wq.wait, &wait);
 
 out:


