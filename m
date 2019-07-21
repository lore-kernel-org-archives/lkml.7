Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D7C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001EB2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agbSGPgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfGURrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 13:47:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44729 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfGURrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 13:47:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so16211831pfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wfPtSDK6aeQ/5qCMCN3mM+awlrKw6JZ3Ltnav27AGWE=;
        b=agbSGPgYAkz8RINO8A9YIX3aoh13aW/Egoh5xl7JWIHhrbb13bKHL6CZXdU81vEdoY
         ZPRPk68EB/1nhGApq8ABJlq/NBW4UOk0aai4BGyImZSoZsLjWWuV26JaHFPLvW9ITm67
         JzvwIh08zHxx764XxY5kKGTb+5GJ53qIwrZSEAIHB/oYHvj8zrBrdvePkOSrqv5WtuhE
         38cxfb4tpbb1AXz2kSf44eXcBIqCrHWJeq06wwKFAgv9ZKAOGUGO4jBKJZfqhMVkZ0XU
         ejgWqCK1OkR/q/EohlmeZuAl8DRZWcHfED79ixq59S1SETR8AkSIgngfFK0ssc81vOe5
         /K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wfPtSDK6aeQ/5qCMCN3mM+awlrKw6JZ3Ltnav27AGWE=;
        b=PNVDhAuhR7XjShroTQ+KYtigihahhk3KjsueQ21xDol054QxCUKBozwGk6TVkGf6qW
         B61vEI3rCQWLCDPfos4hT44K2wDDLsz0PcPsaeQvrD7N+wS3TGhmwYhH/HCc/wEUaP/Q
         WlE4ztarB1ZhlfIKiWZJGSTpr4vgP202qOW3ahKDFOYqHavzkJf6JoBEpxVZ4dojF3B8
         qJyUHgQFzVbdTO6Lqxuqaesvvyyu1fHNZ60oArQiq+qWbi/dAoEB1d7wnhzAwDnySgUg
         d3JZS12fFv/s0YdsFG5OANsR+m86iAxqdcbMkP5ws5v+BWCEO4ScF0QnDZuvCzAlPqhI
         eq/g==
X-Gm-Message-State: APjAAAUwiCra84UKyq/COw4luh2S/H65cIfrNtMGVTKeDXRf2tBGc3wJ
        qMaw7HMyRl88frjCglpZPANmHcOh
X-Google-Smtp-Source: APXvYqwf7V9YESE5laxDZ8XK4KR1yCREzPtDTl5Mzg1CZSfoQAVoEeaqqGA40xxdYJMVNrpbuJ/5uw==
X-Received: by 2002:a63:de43:: with SMTP id y3mr4432535pgi.211.1563731241085;
        Sun, 21 Jul 2019 10:47:21 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id u16sm36964292pjb.2.2019.07.21.10.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 10:47:20 -0700 (PDT)
Date:   Sun, 21 Jul 2019 23:17:15 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: fix duplicated argument to ||
Message-ID: <20190721174715.GA10747@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate argument SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION.

fix below issue reported by coccicheck
./drivers/slimbus/slimbus.h:440:3-46: duplicated argument to && or ||

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/slimbus/slimbus.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 9be4108..46a6441 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -438,8 +438,7 @@ static inline bool slim_tid_txn(u8 mt, u8 mc)
 	return (mt == SLIM_MSG_MT_CORE &&
 		(mc == SLIM_MSG_MC_REQUEST_INFORMATION ||
 		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION ||
-		 mc == SLIM_MSG_MC_REQUEST_VALUE ||
-		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION));
+		 mc == SLIM_MSG_MC_REQUEST_VALUE));
 }
 
 static inline bool slim_ec_txn(u8 mt, u8 mc)
-- 
2.7.4

