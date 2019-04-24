Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FCAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16ECF20675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127509;
	bh=Z6PeYcYC9ZRi6YMHrIEHW26rZfHvdXYkip5E8n3YpPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NJTdkAZGyHFgKHQ/b6fRLuluwrbPOYFi52+haae5cLG5W9m97EXxqMbBKt3RhXejr
	 GMiIj4itqNH7dp0a4dTgCQvZ98NRE3iRG298ZYJmKIsNsMtJKLpLCcpClhe5NUfEPt
	 tiq3q/y5miXPrnoY6pzPvFP2+pYi9ra0ZSx0kCEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392413AbfDXRi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392399AbfDXRiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:23 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE7721909;
        Wed, 24 Apr 2019 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127503;
        bh=Z6PeYcYC9ZRi6YMHrIEHW26rZfHvdXYkip5E8n3YpPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+Dy/oRNOVT6KGHuGQnPRoJgA2QSOeq9xMA7QIsJadVcmtooZpsitfAAgvoBI5Eet
         D3ECut8RzoBCVZ0u0E3jF+4AHaa+UJIO/9hlowpQl/08Si7/k9uLNiU6wR0GQAMBFX
         ZVcytGinay3i09sVQwUoYdt+ru9WReWUGFXJ810w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+48df349490c36f9f54ab@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 114/115] ALSA: info: Fix racy addition/deletion of nodes
Date:   Wed, 24 Apr 2019 19:10:50 +0200
Message-Id: <20190424170931.320177910@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 8c2f870890fd28e023b0fcf49dcee333f2c8bad7 upstream.

The ALSA proc helper manages the child nodes in a linked list, but its
addition and deletion is done without any lock.  This leads to a
corruption if they are operated concurrently.  Usually this isn't a
problem because the proc entries are added sequentially in the driver
probe procedure itself.  But the card registrations are done often
asynchronously, and the crash could be actually reproduced with
syzkaller.

This patch papers over it by protecting the link addition and deletion
with the parent's mutex.  There is "access" mutex that is used for the
file access, and this can be reused for this purpose as well.

Reported-by: syzbot+48df349490c36f9f54ab@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/info.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -722,8 +722,11 @@ snd_info_create_entry(const char *name,
 	INIT_LIST_HEAD(&entry->children);
 	INIT_LIST_HEAD(&entry->list);
 	entry->parent = parent;
-	if (parent)
+	if (parent) {
+		mutex_lock(&parent->access);
 		list_add_tail(&entry->list, &parent->children);
+		mutex_unlock(&parent->access);
+	}
 	return entry;
 }
 
@@ -805,7 +808,12 @@ void snd_info_free_entry(struct snd_info
 	list_for_each_entry_safe(p, n, &entry->children, list)
 		snd_info_free_entry(p);
 
-	list_del(&entry->list);
+	p = entry->parent;
+	if (p) {
+		mutex_lock(&p->access);
+		list_del(&entry->list);
+		mutex_unlock(&p->access);
+	}
 	kfree(entry->name);
 	if (entry->private_free)
 		entry->private_free(entry);


