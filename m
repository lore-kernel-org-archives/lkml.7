Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F398C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F51206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100800;
	bh=IbT8X3DgZm5nk+OV3IJ5ml/dTNHDkUuw6SOafKmU2Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ga6WWrKgXgMsR304br5PCy/rbBDCjC7/pe7otwccPuax2tXMSkCyaqAPbK+I5XZNg
	 DwFY0qzHXbljxO3n0jzpoc6ULIsENqUl1jAMDd8A05O7o1L48pugt3Vc6hmP62LTey
	 FvIdAIDpdn31MJEbZVZtCmC5zbnww2v3/XLyHRpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfFIRT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731071AbfFIQsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:48:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B79FA206C3;
        Sun,  9 Jun 2019 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098883;
        bh=IbT8X3DgZm5nk+OV3IJ5ml/dTNHDkUuw6SOafKmU2Gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPeHn/dl919QWKg/4JDXQJRVsg5Ab/+X0Y//JY2Len1Yj3ntHdd3Tm0CFhdUoqlfg
         73vFut+Kcn2xYTXEHTtlpBfwTptknLSGhIo67NM2E0OZeCDu3gDtIZxVhhS0/jR01b
         R2bgLGaDAXdCv5q2zwZLqgrmk44KB8ki+aMpFBrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 4.19 23/51] pstore: Remove needless lock during console writes
Date:   Sun,  9 Jun 2019 18:42:04 +0200
Message-Id: <20190609164128.456426716@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
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
@@ -476,31 +476,14 @@ static void pstore_unregister_kmsg(void)
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


