Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD24C32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 11:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267FB2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 11:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FSc16+76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfI2Lqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 07:46:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59526 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfI2Lqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 07:46:55 -0400
Received: from zn.tnic (p200300EC2F29D100A9406882CEAF9B26.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:d100:a940:6882:ceaf:9b26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA5691EC014A;
        Sun, 29 Sep 2019 13:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569757613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=TTpdTy/wUW3TvdNYJzX7LaEfTn9yvK+lRQ3XB8x1IB0=;
        b=FSc16+76ii0A4sPyBkg5fsiku2eQXdPzoGGKvBSVaoCbGAOnlytm/88AVztnthZKYirR1T
        i0qQZM5xpH/lQG628Sqk/ke9s+4Xs/aANq5URSyR6Mfeww23Oz9Mt2uh5KydC06mncaTkE
        PVGbwzNzhBu141USQcgQ6HJpKRaJg2Q=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog/sbc7240_wdt: Fix yet another -Wimplicit-fallthrough warning
Date:   Sun, 29 Sep 2019 13:46:49 +0200
Message-Id: <20190929114649.22740-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... by moving the fall through comment outside of the code block so that
gcc sees it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/sbc7240_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/sbc7240_wdt.c b/drivers/watchdog/sbc7240_wdt.c
index 12cdee7d5069..90d67e6d8e8b 100644
--- a/drivers/watchdog/sbc7240_wdt.c
+++ b/drivers/watchdog/sbc7240_wdt.c
@@ -194,9 +194,8 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 		if (wdt_set_timeout(new_timeout))
 			return -EINVAL;
-
-		/* Fall through */
 	}
+	/* Fall through */
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout, (int __user *)arg);
 	default:
-- 
2.21.0

