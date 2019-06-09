Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A55C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6417E20652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100699;
	bh=vDL9p9nzS5Xtfyd1kVhUcL7tNjY01X5WTJe5ER2lxtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zw5g2pZZTWI7PFDZparrcon1YSnlUe01YYFu7S5Uy41SxdQnqYI+kkcy803Hs62Lm
	 ZvfuWRsirzzB/gxoH4gBNpOOoczuMmAnSI5fgVQ0OGkvriaFAv5NYb3WZy1pJ02fdG
	 JDecRbdJkSwBsQ4JhOrws+ppCTo2SzYWsZ9hTcJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfFIQun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731731AbfFIQua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:50:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01A0206DF;
        Sun,  9 Jun 2019 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099030;
        bh=vDL9p9nzS5Xtfyd1kVhUcL7tNjY01X5WTJe5ER2lxtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjJEzpK9i6/T0iAWK3eOuLHwkfrdx7Z75Ry3/q/xnnLcyuPA2pQ3vZW1u8MoCTIcX
         9mtHtdgL/xInSc2MdialTa3oyseoFgZyhS+S1zSdiDPjqLneXS2Hd28fs5DsQbfyQe
         n3p1HllaKBUTWJPjSB9pT8sSo/Gh6uNnHmFAqNio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 4.14 16/35] pstore: Remove needless lock during console writes
Date:   Sun,  9 Jun 2019 18:42:22 +0200
Message-Id: <20190609164126.457142600@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164125.377368385@linuxfoundation.org>
References: <20190609164125.377368385@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit b77fa617a2ff4d6beccad3d3d4b3a1f2d10368aa upstream.

Since the console writer does not use the preallocated crash dump buffer
any more, there is no reason to perform locking around it.

Fixes: 70ad35db3321 ("pstore: Convert console write to use ->write_buf")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pstore/platform.c |   29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -597,31 +597,14 @@ static void pstore_unregister_kmsg(void)
 #ifdef CONFIG_PSTORE_CONSOLE
 static void pstore_console_write(struct console *con, const char *s, unsigned c)
 {
-	const char *e = s + c;
+	struct pstore_record record;
 
-	while (s < e) {
-		struct pstore_record record;
-		unsigned long flags;
+	pstore_record_init(&record, psinfo);
+	record.type = PSTORE_TYPE_CONSOLE;
 
-		pstore_record_init(&record, psinfo);
-		record.type = PSTORE_TYPE_CONSOLE;
-
-		if (c > psinfo->bufsize)
-			c = psinfo->bufsize;
-
-		if (oops_in_progress) {
-			if (!spin_trylock_irqsave(&psinfo->buf_lock, flags))
-				break;
-		} else {
-			spin_lock_irqsave(&psinfo->buf_lock, flags);
-		}
-		record.buf = (char *)s;
-		record.size = c;
-		psinfo->write(&record);
-		spin_unlock_irqrestore(&psinfo->buf_lock, flags);
-		s += c;
-		c = e - s;
-	}
+	record.buf = (char *)s;
+	record.size = c;
+	psinfo->write(&record);
 }
 
 static struct console pstore_console = {


