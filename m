Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84807C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5007E20715
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efp7Y13E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKUJm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:42:28 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35158 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUJm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:42:27 -0500
Received: by mail-pj1-f67.google.com with SMTP id s8so1221462pji.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jlEFsPSyQfklMXQiO7TZHJePMQppbvYfAggjx8UnLsA=;
        b=Efp7Y13ER5e4QmUg+juqCnZvYUMTXk79HRofQq2tOrAu+hBwf8Je8dhdPzV+Jusvlo
         xYHHRdVBtgEzzUPTcsszBGHByAtkzx2ovroo5IdpgOqJPTrTWBPM3RVo43+px3BuPx/f
         o7eJe9assWPAVaC7dCdeXVQIGLD0CSPnpWJoyjnqEiNI4ac6gOZ3vLGgplY933GB6KcB
         nInBdywVDlHs4LCRZHD2zsAahh6/UwbyQa8kLT00fjcBfvntwCPdRrOc0QpqTR70WsW/
         Ye4Y5DYyNVz51O5jRH2OjR8xJXTb1f3irB9BZ3upWa7P5HZ12YoDwAi6TDwjtF4vbfYA
         eTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jlEFsPSyQfklMXQiO7TZHJePMQppbvYfAggjx8UnLsA=;
        b=dTMFeg1IhKBQK4tZc49PIXP0kmt2d93lO4xIEnKwjLscdhITjQnTSbuHIyNeBo1H30
         34IV1TE6ut5UU2Q3s38ceVjb5mFpSwlJH3xeRh7EwsQNvgCWIwKWhknOkW2yLWRWjTFo
         CI4x2y6haQSbY2tns71wm35YAYR3XrGoThYV7j6skeOUljjvYTZ2361mozObocXggjvV
         vv8QMbxt0QsPBHwRZ5bAWQ7ypD3z2faqdXk4RvvmXku4/UluiwmO2Iey2PrL++CrHGWp
         fPvph+XAiKfE3LQt9MntgFMItsq4613TzIh7zM3p8nwZd/hpvapzPOQmWVCYCMYcj7ok
         5hzw==
X-Gm-Message-State: APjAAAWI03CEwpg5DoNgXLhnKLlRto8O57Q74QGc0WwbRLCcQHfaLrlo
        FzK8Zgf1B4eqyoIg97bPupsIAJuCWFU=
X-Google-Smtp-Source: APXvYqw3LI8P4btGJVE6BONou86XZ3BBTganShVFEckMPDCoMhjNDN3vIGO8hI4CiijAfmUQupMTgQ==
X-Received: by 2002:a17:90a:353:: with SMTP id 19mr10763183pjf.128.1574329345665;
        Thu, 21 Nov 2019 01:42:25 -0800 (PST)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id t15sm2457105pgb.0.2019.11.21.01.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 01:42:25 -0800 (PST)
From:   green.hu@gmail.com
To:     green.hu@gmail.com, linux-kernel@vger.kernel.org,
        nickhu@andestech.com, arnd@arndb.de
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH] MAINTAINERS: add nds32 maintainer
Date:   Thu, 21 Nov 2019 17:42:20 +0800
Message-Id: <20191121094220.1127-1-green.hu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greentime Hu <greentime.hu@sifive.com>

Nick implements many features of nds32 such as perf, power management and
unaligned access handler. Let's add him as a maintainer.

Signed-off-by: Greentime Hu <green.hu@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f170d8bc29..e439bcce21bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1040,6 +1040,7 @@ F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
 ANDES ARCHITECTURE
+M:	Nick Hu <nickhu@andestech.com>
 M:	Greentime Hu <green.hu@gmail.com>
 M:	Vincent Chen <deanbo422@gmail.com>
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
-- 
2.17.1

