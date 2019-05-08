Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD278C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD45216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UMMYOu+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfEHS6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:58:53 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50499 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfEHS6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:58:52 -0400
Received: by mail-it1-f194.google.com with SMTP id r17so3356483ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCnKzFh31Wwdd/AAB7X7ETO7DdW6MandrOh0VZJ40fU=;
        b=UMMYOu+TnCjvr7HpeDDUI8FWf3PYnKoHJGjPK3jODFB+8b2ASl1DuqRjenDN7dx3RY
         QF0ppPzNy6FZATtnRi/tuPAbB8M/lT1RncpOIvxkm/uu+rw0ghML3PAEMgxArDsviqJZ
         oNCCi3HCfSSdDHdis+Uq0DNGqP1RA35laMarc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCnKzFh31Wwdd/AAB7X7ETO7DdW6MandrOh0VZJ40fU=;
        b=Fjvk19qK4y6Ya3LW4+QHqGWOZ24hfo/PqELhVgVuAkW8OLULwqtyo2QyXfg+6atmBQ
         mKdPwaVBgfAj1K1Wggj9s1ojGrBOdWo7sjlCSc8HJqquo1aPkh6wJeV157qO4J5SLlie
         ep/lK8jeyELzbUifzmNtLdOMjF3HoCYuLCdQO9mRKPLiTQd17FfwLHDQvqHc1NyHLpCQ
         OKsm1A0DnzGN8NgUZshZua4y0R4UziGlo0BuhF/I5kvr6uRxzlM2jUT5h4cV/twDaCYH
         iACBUBZDDMGjcycZOkxVoBOIfnYaSCAW8MflaKS9HCezsma7pDz5L+2waEihOXxNL/pO
         6cYA==
X-Gm-Message-State: APjAAAXBLs3eD/hB9XLVkDZ2iM7ez/845kQnoIL3DmmCDVTS8zj1frYU
        AylsKVr0Kpy2T3PwlnQ6/fkATw==
X-Google-Smtp-Source: APXvYqzVPxdkQ3y/Gw15wAAWsmqtydkegL/enWf5bZh6pk/nfAm65reK5m7rkDY8Cj3NDr2unbR/mQ==
X-Received: by 2002:a24:d88b:: with SMTP id b133mr4596740itg.40.1557341931453;
        Wed, 08 May 2019 11:58:51 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id y190sm1427494itc.4.2019.05.08.11.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:58:51 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: v4.14: Kill the request if the queuedata has been removed
Date:   Wed,  8 May 2019 12:58:33 -0600
Message-Id: <20190508185833.187068-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190508185833.187068-1-rrangel@chromium.org>
References: <20190508185833.187068-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No reason to even try processing the request if the queue is shutting
down.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
This commit applies to v4.14.116.

This doesn't apply to 5.1 since mmc has been migrated to blk-mq.

 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4bf1a9c6440b..28c9646a4de9 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -30,7 +30,7 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 {
 	struct mmc_queue *mq = q->queuedata;
 
-	if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
+	if (!mq || mmc_card_removed(mq->card) || mmc_access_rpmb(mq))
 		return BLKPREP_KILL;
 
 	req->rq_flags |= RQF_DONTPREP;
-- 
2.21.0.1020.gf2820cf01a-goog

