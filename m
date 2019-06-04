Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4176EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC57206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559691191;
	bh=D7/5dMo/UCZnQ0TVCk6RXHAn7vkRkagf2wi01fq/t5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o4nLO6gylJSM/RJKwk6BQuhchTLdKFO2VGTrk7JVJ22tTIDV8i1mhiFhHFN0kqtz7
	 q2gXU8ICgFtvyOFWxH6O+P7umxIqZtcq8eO2vOgUlNNRp9d8KhJ0chCWbuqKsCFMDU
	 2qwfOinh/vDOq8v6jPSlcukKhSXU0ipV14jVcziQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfFDXW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbfFDXW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:22:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 152D2206C1;
        Tue,  4 Jun 2019 23:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690545;
        bh=D7/5dMo/UCZnQ0TVCk6RXHAn7vkRkagf2wi01fq/t5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MY/cln08/OBGIElrPN2o1BAXBFxWeT+w0BvesIgbxDHY5Q47gl/4eMmlo9g7COyKu
         gdJM7hZcOyoQtyephnqSx2Y3t6ssZcB5gukvv9175QMKA7nCdd6B0+WkkauDpZYakC
         mrFFg2UJVfp5Ubk2WNy8oWiy1GV5c24rodR8fK9E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 05/60] ALSA: seq: Cover unsubscribe_port() in list_mutex
Date:   Tue,  4 Jun 2019 19:21:15 -0400
Message-Id: <20190604232212.6753-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7c32ae35fbf9cffb7aa3736f44dec10c944ca18e ]

The call of unsubscribe_port() which manages the group count and
module refcount from delete_and_unsubscribe_port() looks racy; it's
not covered by the group list lock, and it's likely a cause of the
reported unbalance at port deletion.  Let's move the call inside the
group list_mutex to plug the hole.

Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_ports.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index a31e16cc012e..16289aefb443 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -550,10 +550,10 @@ static void delete_and_unsubscribe_port(struct snd_seq_client *client,
 		list_del_init(list);
 	grp->exclusive = 0;
 	write_unlock_irq(&grp->list_lock);
-	up_write(&grp->list_mutex);
 
 	if (!empty)
 		unsubscribe_port(client, port, grp, &subs->info, ack);
+	up_write(&grp->list_mutex);
 }
 
 /* connect two ports */
-- 
2.20.1

