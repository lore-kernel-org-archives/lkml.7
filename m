Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4ECC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE522CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3WLJT6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3HMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:12:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34787 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfH3HMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:12:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so3081122pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YtkAdfW5oGxHpmLw13b9aMdzltlDIZk7K9DdjceyN94=;
        b=Y3WLJT6nT/YMnnBTLStGV+hWADgSPzcQIpnKh9dGYaHGQ7sSyLJE4ePY0fs+msOBqn
         oK4HPrHbznynDfEpd2GXa+N3VMvSD8h/HbjnW+ZjXp5DaSobpMb3OmcI7UDehtqENYEs
         gdj1K53C0O9do9CDWTtu8svP/5xoyi+Mkss4ZdBKCkn0phfU6V/M5NZtJexODvxFCaA2
         FF9SvFN+x3voaQSFtJQE1KO4D7okMjQKj5BkXkq5x87lLVmzK5y5icUXJ8avjBxRtJQv
         4DggxIbCuAedpFxGgoicf7t+7R+Hl4CWCtEJ63oT7RUf6j/MSgx+ej5FiMNdE2gwTK4V
         qRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YtkAdfW5oGxHpmLw13b9aMdzltlDIZk7K9DdjceyN94=;
        b=A57k+BNOPHlJwC/AkvoGBYXT9PJfDLsfCyA3WEHvfosSGo+2TMnjWhjZ89LjB3f2sZ
         icRFNATCvXjRl8rl/StKWug+z+ibjyT2yS5YWh4jgPiaSixhoHW2ShScH3RRrV5sorkd
         P0KYhbjlVwoa1IqF/R/HXO44YyOkt6etdAAgzcN/b45Ls2bkH7pC70RFxU1XHl5Is8Uw
         ClbtbMwFNKaKGZzTkHA7YSuAd0M+n1IBPnl9U7/z2ERyhfTj88NQ4GFj/75BSbeZzTUs
         ydZUlAxdqCKvnE/VMVRwLI92K+xuqSO9XlQJL7iKpoR1FkkExeLSV61yBEl3OA8+XrJS
         Aa/A==
X-Gm-Message-State: APjAAAUaqTLGE/mLPThQp9JssV7RYEPzFE0OvvxkHmBfjZQ8LlExxsvj
        Q6RGuJVls/gdJOWBjCGP0uA=
X-Google-Smtp-Source: APXvYqzDm8qGR33awdHp0I+ce0iS2eYVivILisJDjkzHXkhfLIAd1xsVqUS2kmxN7P/E1d4s5Mf1zw==
X-Received: by 2002:aa7:998f:: with SMTP id k15mr1575923pfh.203.1567149141155;
        Fri, 30 Aug 2019 00:12:21 -0700 (PDT)
Received: from dell-inspiron ([117.220.112.196])
        by smtp.gmail.com with ESMTPSA id b123sm6192778pfg.64.2019.08.30.00.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 00:12:20 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:42:10 +0530
From:   P SAI PRASANTH <saip2823@gmail.com>
To:     gregkh@linuxfoundation.org, kim.jamie.bradley@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Fix checkpath warning
Message-ID: <20190830071210.GA11143@dell-inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpath warning in the file drivers/staging/rts5208/rtsx_transport.c:546

WARNING: line over 80 characters
+                               option = RTSX_SG_VALID | RTSX_SG_END |
RTSX_SG_TRANS_DATA;

Signed-off-by: P SAI PRASANTH <saip2823@gmail.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8277d78..495fa60 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -542,7 +542,8 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 				(unsigned int)addr, len);
 
 			if (j == (sg_cnt - 1))
-				option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
+				option = RTSX_SG_VALID | RTSX_SG_END | 
+					 RTSX_SG_TRANS_DATA;
 			else
 				option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
 
-- 
2.7.4

