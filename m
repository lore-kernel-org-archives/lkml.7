Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FFDC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07B6206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfLaPCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:02:33 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:60318 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfLaPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:02:32 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F3BBC2005E4;
        Tue, 31 Dec 2019 15:02:30 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id AC6A920EB0; Tue, 31 Dec 2019 16:02:26 +0100 (CET)
Date:   Tue, 31 Dec 2019 16:02:26 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        youling257@gmail.com
Subject: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20191231150226.GA523748@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If force_o_largefile() is true, /dev/console used to be opened
with O_LARGEFILE. Retain that behaviour.

Fixes: 8243186f0cc7 ("fs: remove ksys_dup()")
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/init/main.c b/init/main.c
index 1ecfd43ed464..d12777775cb0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1162,7 +1162,8 @@ void console_on_rootfs(void)
 	unsigned int i;
 
 	/* Open /dev/console in kernelspace, this should never fail */
-	file = filp_open("/dev/console", O_RDWR, 0);
+	file = filp_open("/dev/console",
+			  O_RDWR | (force_o_largefile() ? O_LARGEFILE : 0), 0);
 	if (IS_ERR(file))
 		goto err_out;
 
