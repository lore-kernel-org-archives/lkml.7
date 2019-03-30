Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC7D2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWDl7DJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfC3Sai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:30:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44517 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbfC3SaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id u9so3532819lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FurKqlti6iolFnGNzTOVMo3Q5vZlOYrmsUdCDGaEJfs=;
        b=qWDl7DJwFa8EKzxPDmPuC2RcaWihI4Y4TX3HR5qydmDvFpNctZqp6UEYIzyW8UaDdZ
         LKyG1GrP/s9F2UtHIL/7lGpdSHEEIVmTu0/d+7hXYnkwBRroY5CiC7BGxslEBZiwsIgl
         h+JFGVzYqpUnY+TPXdbR557MaEC2zXGVjtgHhNQsB/GIgrGzpLWjLMv1BEq+Q6U0Bjmo
         gbkFhk/N8G2K1al9y5rFA8ZPxaeq2Pi5ElHDsTzqBdnR2SCIPFSf1jVDGP5tVgpYrEAh
         dG5jz4FBRmOssWCBHFH10Cr+AscBPjV5xXqQH/hxXGyHW/EiuCmNMpZU95B8mXY6zgzw
         aX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FurKqlti6iolFnGNzTOVMo3Q5vZlOYrmsUdCDGaEJfs=;
        b=Doh6a42AOIX8b56QUggKYzp7zTz5ayCKyqJSYImCfx3/cA4avA4mDT12RRXqvSeVRJ
         /Tx01C2Z+Os1JerrM5oe8VczrcGgrW9dJ6IGPCy+J0oDvhvkhMWC3rsRIfUVDrlAvKC1
         6yEm5qBHjEaK3WccnTFy1xZGxxPWvRlkQe2tk6bQdJTuK1ENxsLA/Tg54Kn5mQG/RZaG
         uFspxFZYrOzZNMSbXLRTJ9aGhwbl6tnvAzBQYKzXaKllhuHquez5L9HgUfoAJmMG+Ak0
         AcuxQaXHGu2thYG0fIiRt/+DnnISkynICXue3zP+a7Zvl6xzImmKghtAHuWRhseAsEBf
         E3Gg==
X-Gm-Message-State: APjAAAW1JhcgTtxXXyOkeN0Xn2vEqe/4piWrYFq+uZS+fdxGa69+cqAs
        OxBBlf/RPQFdjGFJbZU42mt3cTYz
X-Google-Smtp-Source: APXvYqxpxnfDyg3KgZZDIhvMyKBIwTco37hNNa/jAKuyDLwmVhgtJCtBM0zsIry7EcJwGKH1nqCFNQ==
X-Received: by 2002:a19:9145:: with SMTP id y5mr30373021lfj.35.1553970614323;
        Sat, 30 Mar 2019 11:30:14 -0700 (PDT)
Received: from localhost.localdomain (v902-731.aalto.fi. [130.233.10.238])
        by smtp.gmail.com with ESMTPSA id o7sm1060058ljj.23.2019.03.30.11.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:30:13 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 5/7] rslib: Fix handling of of caller provided syndrome
Date:   Sat, 30 Mar 2019 20:29:45 +0200
Message-Id: <20190330182947.8823-6-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the syndrome provided by the caller is zero, and act
accordingly.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/decode_rs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 78629bbe6590..7ecc449e57e9 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -42,8 +42,16 @@
 	BUG_ON(pad < 0 || pad >= nn - nroots);
 
 	/* Does the caller provide the syndrome ? */
-	if (s != NULL)
-		goto decode;
+	if (s != NULL) {
+	    for (i = 0; i < nroots; i++) {
+		    /* The syndrome is in index form, so nn represents zero */
+		    if (s[i] != nn)
+			    goto decode;
+	    }
+
+	    /* syndrome is zero, no errors to correct  */
+	    return 0;
+	}
 
 	/* form the syndromes; i.e., evaluate data(x) at roots of
 	 * g(x) */
-- 
2.17.2

