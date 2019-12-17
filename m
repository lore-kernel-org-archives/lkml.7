Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140F8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B791624655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="p8jscr+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLQRZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:25:17 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:45269 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfLQRZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:25:16 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 844719df;
        Tue, 17 Dec 2019 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=BJdwj6yJFuqILwjC4/F5JGMrUWI=; b=p8jscr+AvKDJllcKhf/z
        MLlGpE8fX0giSC2k1USSnWv0sfm0/llBHa1IIFg81Wytj1i/eDAprIff5+XEa6b+
        em7jNxi+pZdGrTHAxGEyLt7++EFtXOuhFDrBy4D/slt4zNknbuYHnMTwL+yZK+pr
        DdHTnKRnQz4cxXeBg5Y86JtMBpeEfHY6VwvsPJb2A4kzvoBQxSB7vr9+vRXQZv3E
        +gkuhreFX6hjrxiHiEz22y8nydpP4WJAdWSZYklsDWKIM8Va6uGXX+nL3GWF/OGt
        gn145jbL0Gpp6W3zBfRjOHHkLvFcHH4HWPwkylcT2ZEfvJd13s3ELSLbX8/v7gTf
        Mw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cb6a263f (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 17 Dec 2019 16:28:46 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] random: don't forget compat_ioctl on unrandom
Date:   Tue, 17 Dec 2019 18:24:55 +0100
Message-Id: <20191217172455.186395-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, there's been some compat ioctl cleanup, in which large
hardcoded lists were replaced with compat_ptr_ioctl. One of these
changes involved removing the random.c hardcoded list entries and adding
a compat ioctl function pointer to the random.c fops. In the process,
urandom was forgotten about, so this commit fixes that oversight.

Fixes: 507e4e2b430b ("compat_ioctl: remove /dev/random commands")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 909e0c3d82ea..cda12933a17d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2175,6 +2175,7 @@ const struct file_operations urandom_fops = {
 	.read  = urandom_read,
 	.write = random_write,
 	.unlocked_ioctl = random_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
 };
-- 
2.24.1

