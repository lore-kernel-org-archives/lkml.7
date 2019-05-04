Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53574C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28110206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="JwDbYsTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfEDSkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:40:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35063 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfEDSim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id z26so3037275ljj.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3843mVBw2aKQSM14ec6tRYSSMjiPOntWSMzut81TFAY=;
        b=JwDbYsTFb4yxp4ZUBe6/DXzDMyAvDefOOAFD/TtIa5KpnOttK7KaVLYSitUMzO0Z55
         u0DBNjm1M5FH31OgE8XJFmHUtJ48ZkyGtMFOVoIouaNTy3Sm8hU71qpnN1HG3He0mLVW
         Zre5Jjcdvj5TunVqlX8Os/yRHDSJgZrgpf8t1bVlNi2tURj3P6c8ZKbFnY+uqvtMFsoq
         eehK2IYREB4u256xbI7iwBkwJ0ved7JfS0nqQ2VET2dU0+LqTGBcUTvpuoJpCThbcMZ3
         tCZj4Jdgj+58tXebL1RhxjgO69rCJPMli2DCuPkcMRT/DZgkkIwxMePZo1BCnbYDyoiK
         lLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3843mVBw2aKQSM14ec6tRYSSMjiPOntWSMzut81TFAY=;
        b=t5aHBhD5ubsOUdCI2jH86i/4lGTRDz2f+eW3OGjPJZWsm6XFVWGGHzZ/kKJEttCG8h
         VoFJlO6WNQ+v9bl3qQhoOewmjAXePpAoWRV/vamiucJDB+ortlto8pY7bsX7kQEi02Uz
         /5iEAoJygB7JM43y2JdPNEDrzzEJELNatl2q+AmOLKLMtvR8iCrHaZJWvDfavys9dJbG
         12In1+1Q3HwrMwWLhYA5PbyUcmE8DKtkzMJdG26tD9a99NfDT4YtplJrkcBiTqFKC+zj
         wFjulMZesO/rQxZlxIzjcBDyjRX18aqLAuds7zetdW5JEZX9U4GR6qBe41Pq94mqW1aW
         1ALw==
X-Gm-Message-State: APjAAAX4ww2k5v44zVZcKczjMMTGWAmtucAPlBNDfJhjeJ/+3GhS3ENU
        F9ziym27p7vKp9ckZSoRtCiZ+A==
X-Google-Smtp-Source: APXvYqztbPkqlrOfQRcm5dTJdYEtSFLQQq5jpQMMbr9aVHMNr+Tyk33CA9pRAdKnB2aUm7BUzAuGEA==
X-Received: by 2002:a2e:9216:: with SMTP id k22mr8846076ljg.179.1556995120087;
        Sat, 04 May 2019 11:38:40 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:39 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 15/26] lightnvm: pblk: kick writer on write recovery path
Date:   Sat,  4 May 2019 20:38:00 +0200
Message-Id: <20190504183811.18725-16-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

In case of write recovery path, there is a chance that writer thread
is not active, kick immediately instead of waiting for timer.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 6593deab52da..4e63f9b5954c 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -228,6 +228,7 @@ static void pblk_submit_rec(struct work_struct *work)
 	mempool_free(recovery, &pblk->rec_pool);
 
 	atomic_dec(&pblk->inflight_io);
+	pblk_write_kick(pblk);
 }
 
 
-- 
2.19.1

