Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED529C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DD42067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVRd2kDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJJVD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:03:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37331 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfJJVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:03:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so8134895wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tcMFZrYzkXthDN2tPL7urUoh2Atq6M3SFm7VW5KGajA=;
        b=qVRd2kDXCGuHdq8Rioqkm/y4Cvp9wC2SLvitOm4/CLfVHMGQqMy2abS2ta8PQvL9qr
         K010P7Ka3y6HWE4Z8etiFd1izU85wjvQ0Mkk1UdSxKeMJEzUtazw8VrKoFLAU46lip/j
         5BFvtyW2YvTb7GzTIOfe+V87z1d3FP6zO4dJvNG5TEHCQ49/lqWErlJoBlfopTyTEHVn
         zIO2MtL2OKXg9Udi9yVreXCgRYrlVJli36CI8yAtk9IVy4UdLvegxZgpMtPWfTNfIKF0
         q3gjl1gJI3ekM8DeJ9bkxz+sEhUXyUWyzMYKd/nWk1HgkN4dI0KfENmXxVCFkYJXIiX+
         Rj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tcMFZrYzkXthDN2tPL7urUoh2Atq6M3SFm7VW5KGajA=;
        b=oXMShOlXc7tKJjPnjM2DYhIY66F7Ni9UMC7Lwqpv/CIHe7kXhu17t0C/MEHrcuOSPT
         KcHkO1cznxUPnK/rEc9I/r/6q9BvVERYP1Q7MC+mgI8DaSzEXRpy41IvO7Fg/bPnlowO
         YwObbK81EpZ8DcpAUUN8tDsNi2N61qCBt1+5vFExcVZb+7ZqPsJHMYhRLNkbVRfkX6z0
         KXvrWd9omGg7DWOYMK2l8CspDeEaiPNOkaCjjljX5X1rOOU5R5IO33RB3NxIh1iTuQCq
         wS/RUDNgSlKurualb+EB3lDQmcT7opQvCpneEpx3m5m0COb9K/WLL7Rn38GlBlNGt+kx
         AQpg==
X-Gm-Message-State: APjAAAWyI54tX3rWYJ1feoUGsrKzU4HIkKxNdRksoZf00SRRG0qbpPOY
        aTnsI3bUP0LlwPHJd4BNpcTTe6xpg4Vt
X-Google-Smtp-Source: APXvYqz0CM2JtiTfpCjI5u0fQ8+cg4SkIMbuZYG1W9BH7jH2mDkeZoTKdn7uEeV4HB04kOdnZeG35w==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr374827wmq.92.1570741436053;
        Thu, 10 Oct 2019 14:03:56 -0700 (PDT)
Received: from ninjahub.org.net ([94.119.64.0])
        by smtp.googlemail.com with ESMTPSA id w125sm14908956wmg.32.2019.10.10.14.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:03:55 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Jules Irenge <jbi.octave@gmail.com>
Subject: [RESEND PATCH v1 1/5] staging: qlge: correct a misspelled word
Date:   Thu, 10 Oct 2019 22:02:52 +0100
Message-Id: <20191010210256.22522-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010210256.22522-1-jbi.octave@gmail.com>
References: <20191010210256.22522-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "several" detected by checkpatch

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index 5599525a19d5..28fc974ce982 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -354,7 +354,7 @@ static int ql_get_xgmac_regs(struct ql_adapter *qdev, u32 *buf,
 
 	for (i = PAUSE_SRC_LO; i < XGMAC_REGISTER_END; i += 4, buf++) {
 		/* We're reading 400 xgmac registers, but we filter out
-		 * serveral locations that are non-responsive to reads.
+		 * several locations that are non-responsive to reads.
 		 */
 		if ((i == 0x00000114) ||
 			(i == 0x00000118) ||
-- 
2.21.0

