Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B07EC46476
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CD520825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbtRyWfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFGGAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:00:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40110 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfFGGAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:00:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so982171qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 23:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dWh46ehTtF7XrRzrQS4UMj2mqF99ZWlKh15WhZd7opk=;
        b=VbtRyWfh0kvCsghw4vQkoSYYEJBJkt40e8F3tOl//OUPrA30px/R4n4WjhT78ROsUA
         RfCJm1xFS7KHaK1mntORy62MwR9gLl8grdBsBe5RP8LuwhaG+HIZn2khfCURtIO7AZxx
         cCs5A53qGsXNDKFkG3YP/o8ywR7izGCE+VyssZEct9M+fZT1mUlT4kQkiioRVFvt7uQv
         fUoNYVJPIClMm9wdHC4KYfsNYkVHqRKQyguBFf80v8ppKP1kUYsC8bT0o62Yzz91avTm
         wvluBd/3/FkBJ1D+ZpnQmXK/MLJ4DdSLBCrLaXjSIBQU5MLCMoOHMvZV6tK2bNZtdvPp
         tSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dWh46ehTtF7XrRzrQS4UMj2mqF99ZWlKh15WhZd7opk=;
        b=NOfvcHzZgI8Rcg7SESvvuqwnfva3kk5lFBtyJo7n+zUewYZKGi8IeAmlPSk2SbFy6k
         fl4XwsRfOVb6cXE2+csCY+Dh3Kx9r5Jl2QXsorGaT9gv8NqA3ie5mZdDUulWdLFoaw4k
         RmaX3wfRxIQBxO80ix0EiSQnVPXa++5NxtIWUAcrpY3p30q7MH3IQ3IKCxbpbszEnb81
         RIWvXc4OsBusaldX0QfxvpW6EJL+f/IXKuzk2MPwmS01JyZcBzAF99UPI2RKBNU5hGRT
         Ct+1sZLBotq5ZydLpkTn/UWKkvPULUoIIXdxdVtJ5423I0KFmCGs7QAaJEcw4kH1EFOQ
         7LEw==
X-Gm-Message-State: APjAAAWbcE3fUuhXzKt82Vl/VijWfBft0D02Dlxjr1N0XiLUvWXiIZSy
        mHso1UOsLVf9lAJzVajeiHc=
X-Google-Smtp-Source: APXvYqzzmpJUF9IoRPMUxjasE/Eq5+9Yg1niCvXE8klMRI1pm12EcDjmShlXCjNiKSzkC3RmZoPNvA==
X-Received: by 2002:aed:3ed5:: with SMTP id o21mr42958105qtf.369.1559887248462;
        Thu, 06 Jun 2019 23:00:48 -0700 (PDT)
Received: from ROOT.localdomain (modemcable124.134-176-173.mc.videotron.ca. [173.176.134.124])
        by smtp.gmail.com with ESMTPSA id 39sm633787qtx.71.2019.06.06.23.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 23:00:48 -0700 (PDT)
From:   Maxime Desroches <desroches.maxime@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Maxime Desroches <desroches.maxime@gmail.com>
Subject: [PATCH] Staging: vc04_services : vchiq_core: Fix a brace issue
Date:   Fri,  7 Jun 2019 01:59:45 -0400
Message-Id: <20190607055945.21769-1-desroches.maxime@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces in a single line if statement in the vchiq_core.c file

Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 44f0eb64952a..0dca6e834ffa 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3100,9 +3100,8 @@ VCHIQ_STATUS_T vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 			       QMFLAGS_IS_BLOCKING |
 			       QMFLAGS_NO_MUTEX_LOCK |
 			       QMFLAGS_NO_MUTEX_UNLOCK);
-	if (status != VCHIQ_SUCCESS) {
+	if (status != VCHIQ_SUCCESS)
 		goto unlock_both_error_exit;
-	}
 
 	queue->local_insert++;
 
-- 
2.17.1

