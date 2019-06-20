Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9B1C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9388B20679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvjgVLfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbfFTOLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:11:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42725 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbfFTOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:10:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so2536204lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fsCelw2dLPJ1ORBNoEE6eWPI8VGcaISo9+6FUYIM0LQ=;
        b=XvjgVLfv8hQ+wdI3qrx62+r/UDCMLgdPduOwm26f6h/BAFUqS6R9g80MXNccbkyAF0
         cgvLW9Iv2rCGMNHGBz4YRPhuiZHw/olI9TxJYmZNCMBs1Av399kWuoq68B61Ktqy+IRG
         E+vcAw2pYEnx2ia+iwa2qFwUpKh5aEpr/iun2qqe+2XhgJh/lpORElaPhwfr/MbrdOw4
         05pEG1ceVgyZXIMezZPO0jHsWNrNFGg+jR7s64rrBBSFBx5iW9/qlzMN5i22eCZpgFnJ
         UMlga6aUpR55R7wIt7y65pE6Bnd2gsDZiP78meDs/TaZ2n+aPus1fUZuauNZtneVoN31
         PcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fsCelw2dLPJ1ORBNoEE6eWPI8VGcaISo9+6FUYIM0LQ=;
        b=OUEYHY13Rw3Uv1yUzU9qTMdoD0TZck6oyz/5rM/C9FyuT2JqKCAmOQhw9YElvJGgB9
         4cAdOtMg8auMpuj+iKlEyAU/cAe32WPfxiNztWq//ajAl/my84GuGUMbleBN6j+Gh9m2
         qBq8H6UJ3zgVrUx3Dj2v4s7g0G/dh2YPYKufh4FCEIdpNsTxbHvfSsheLO3yyLIWNou8
         E4pmIm76UrhuYiMPp+HMwlkqJCSOnOfKdLuZk3685TpICEwA5OCICBGASxm/RZOUlRRR
         KOzqH8fcd/FioW2pEa6TD6pnUdNySmtdpHFgT3bzNcWotshMZ8/ZlRWTECXn6zz4BxlI
         nbkw==
X-Gm-Message-State: APjAAAW0fv6g6ToXvETmy0E86aPXEALgarbnFDIa6AOf+N+eL2ZMcGZy
        1YVwZdxpYLAfNYYuSMCv4tV+o5n6
X-Google-Smtp-Source: APXvYqwf7wiEsirhA4ugfBQ/5LIQOkuGm6vAXD++ptGp7pIxHpcwAi1hazMtDpDvHZ6Kj5ytdFKkNQ==
X-Received: by 2002:a19:e308:: with SMTP id a8mr7387107lfh.69.1561039854562;
        Thu, 20 Jun 2019 07:10:54 -0700 (PDT)
Received: from localhost.localdomain (v902-804.aalto.fi. [130.233.11.55])
        by smtp.gmail.com with ESMTPSA id 27sm3524684ljw.97.2019.06.20.07.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 07:10:54 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 5/7] rslib: Fix handling of of caller provided syndrome
Date:   Thu, 20 Jun 2019 17:10:37 +0300
Message-Id: <20190620141039.9874-6-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the syndrome provided by the caller is zero, and act
accordingly.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/decode_rs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 78629bbe6590..b7264a712d46 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -42,8 +42,18 @@
 	BUG_ON(pad < 0 || pad >= nn - nroots);
 
 	/* Does the caller provide the syndrome ? */
-	if (s != NULL)
-		goto decode;
+	if (s != NULL) {
+		for (i = 0; i < nroots; i++) {
+			/* The syndrome is in index form,
+			 * so nn represents zero
+			 */
+			if (s[i] != nn)
+				goto decode;
+		}
+
+		/* syndrome is zero, no errors to correct  */
+		return 0;
+	}
 
 	/* form the syndromes; i.e., evaluate data(x) at roots of
 	 * g(x) */
-- 
2.17.2

