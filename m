Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9E3C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3013F208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053670;
	bh=UFiHQNYzOBvgg/6HU+6lO8B/JEmfpNhFn9G0j9ouWVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GfXojAp+k8GGr+oilOUs+RCAgb/hQ5Yk5id8s46ZzGm1IovEK0jZyod2EHxBFCl/z
	 lbYotGtkSmQdsYmNct0s5po8SXQ8bt/qnee8TgniQ9MKaVx5hBwLnpFHHRl2F47eVi
	 0uRydgbIrE4KdGkcXJKloRfRghkI+DrR981+A+Sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfFTSBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfFTSBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:01:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E57214AF;
        Thu, 20 Jun 2019 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053664;
        bh=UFiHQNYzOBvgg/6HU+6lO8B/JEmfpNhFn9G0j9ouWVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faF/bTpxExyaIEuj6b1caHtOZZrTTSRPRI2gd03lEqb+cGmNFKU7e4OoDX7xWoG0k
         OrGZMPcbVKmPkBmyfhTbgdLKL1KSxI3i0qfMHhaYsB/aH4osFxgsn2uCnLAReV0Kaf
         /0ZxMNQE/rIw/tnbT9WeRrFnK+jN7qWZZKfB8XiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 40/84] ALSA: seq: Cover unsubscribe_port() in list_mutex
Date:   Thu, 20 Jun 2019 19:56:37 +0200
Message-Id: <20190620174344.288202803@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 7c32ae35fbf9cffb7aa3736f44dec10c944ca18e upstream.

The call of unsubscribe_port() which manages the group count and
module refcount from delete_and_unsubscribe_port() looks racy; it's
not covered by the group list lock, and it's likely a cause of the
reported unbalance at port deletion.  Let's move the call inside the
group list_mutex to plug the hole.

Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_ports.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -550,10 +550,10 @@ static void delete_and_unsubscribe_port(
 		list_del_init(list);
 	grp->exclusive = 0;
 	write_unlock_irq(&grp->list_lock);
-	up_write(&grp->list_mutex);
 
 	if (!empty)
 		unsubscribe_port(client, port, grp, &subs->info, ack);
+	up_write(&grp->list_mutex);
 }
 
 /* connect two ports */


