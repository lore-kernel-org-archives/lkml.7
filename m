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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4364C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F546206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzB/GDzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfFTRvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:51:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43300 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfFTRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:51:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so3044014lfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AsRTx4UMMXAfahNHVbziSWvG8kO/9PcJpiP01Kyu5Js=;
        b=tzB/GDzWW4jmxpmIFCkF95zygclqgkxQJoRNoMuLL/EegtZpxURbz6ZhhwfpYvw2Mn
         OOFzJuzbx+t4wIabY1fafDcWapP8wR4H++suVOEVSASIpqlo7kjhSOTz37k2t4DV3mhK
         1OFtMS7nVO3YmC5LYPmKX/ZOrwyqsqKHkQNWeiSMmVgN+iWDVgh1+B20FG2kXQFNsphi
         aDtbsTIVgKLs5K8nXbk6czH2pJlyQES4YmPjXv6d8NF4U8WeCLQigA/muZQuMQnnyp+9
         TCqBs7O4xS2goCMn+iYpbeRM7mvLgR7820spsONideUN2vcR84H9/58pV/k5h2B0moZE
         7wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AsRTx4UMMXAfahNHVbziSWvG8kO/9PcJpiP01Kyu5Js=;
        b=gs3/3lVHNmi3OJQ7I7eGkeoijNoRC9QK9cuRk8YC29x5/kfTLSh9w746R6dIw+d2cQ
         imZ0xQr1zvlmD113Gvumm08O99yu+qhG1StgLEnVbIrCIX2SaGuQH0PG2sfYSUgOYige
         esz1cicirai6EHdzZI/pBxSRZub2swUK5m8mncsaSR1I1y9IYh2E/Jz3MBH5tPg8ffcy
         56YmidceFX8ZfjZoTXeaaQ5MTc3fi8mte8bmWNeX+jRyFh+mpg8MFgjhegP0NyyR+ild
         +yB8eCZ23AIJq+2p5IumRX8qGBdV/2DH+NT4MTzXzYEkAbnmzdlw/1zs7Ie3p1YxNdnf
         bEJw==
X-Gm-Message-State: APjAAAXnmBORCvWlt5GZR9ulKoYXpLQx43CCrvTUB0qjKlaO9kZfyiiH
        AOpt8RVufm0MrJnsBIQwdgQ=
X-Google-Smtp-Source: APXvYqyqJWJnaIZUD++ayUZE/WMaQlPYn3FaFe+T+Uomi2M9CfPKiUcqIQS6VpKQDy2uBV4oww56AA==
X-Received: by 2002:ac2:4152:: with SMTP id c18mr15303553lfi.144.1561053064829;
        Thu, 20 Jun 2019 10:51:04 -0700 (PDT)
Received: from localhost.localdomain (mm-56-110-44-37.mgts.dynamic.pppoe.byfly.by. [37.44.110.56])
        by smtp.gmail.com with ESMTPSA id d5sm44341lfc.96.2019.06.20.10.51.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 10:51:04 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] dm: Update comment
Date:   Thu, 20 Jun 2019 20:50:50 +0300
Message-Id: <08f06799d0336322ae85b3f8ba3acfb68180a96d.1561052999.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Since Commit a1ce35fa49852db60fc6e268 ("block: remove dead elevator
code") blk_end_request() has been replaced with blk_mq_end_request().
Update comment

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/md/dm-rq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 5f7063f05ae0..c9e44ac1f9a6 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -115,7 +115,7 @@ static void end_clone_bio(struct bio *clone)
 
 	/*
 	 * Update the original request.
-	 * Do not use blk_end_request() here, because it may complete
+	 * Do not use blk_mq_end_request() here, because it may complete
 	 * the original request before the clone, and break the ordering.
 	 */
 	if (is_last)
-- 
2.22.0

