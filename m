Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AEE20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050395;
	bh=/DRdxrrOqLWWZNPQADYmdFs3nuoRP9EtlEqLq+XoIYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xls/cPVNYbXYFYlANtll9u5eHIgAzj6F+p82mjkFsBx+/edSIUJNzQ4UFtWNRczpC
	 R54Andqo8J5UX2HL8lrdySC5sQ8Zy8g7X+h0PayumehcgYGfbEDgDuL5/qsR4rA/zy
	 OE6ydNOaCqvFPJh+KF358q+tIBK89GSPCbiSku84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfCHNGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:06:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCHMzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E8E2087C;
        Fri,  8 Mar 2019 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049724;
        bh=/DRdxrrOqLWWZNPQADYmdFs3nuoRP9EtlEqLq+XoIYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3UmzDKOyRhQr1WIFuvfS4Xi24KXoWASWPP3EN4OcDjbUpqDftgKWEk9/jbameJyN
         8XFUrIZgVVC958Ki3VDUUyNT+sdvfK6KSvqhzzuTOS6OcXky0cI8V32Rns2kCi9Tq/
         w10XEQzvbnj1xCk2ulC4cXFvaY5i2Aep3oC13gwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Celik <mail@timurcelik.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 45/76] tun: fix blocking read
Date:   Fri,  8 Mar 2019 13:49:57 +0100
Message-Id: <20190308124916.411730174@linuxfoundation.org>
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
@@ -2147,9 +2147,9 @@ static void *tun_ring_recv(struct tun_fi
 	}
 
 	add_wait_queue(&tfile->wq.wait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
 
 	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		ptr = ptr_ring_consume(&tfile->tx_ring);
 		if (ptr)
 			break;
@@ -2165,7 +2165,7 @@ static void *tun_ring_recv(struct tun_fi
 		schedule();
 	}
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tfile->wq.wait, &wait);
 
 out:


