Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0DDC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1D9208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlmN9OXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfEAOiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:38:17 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34837 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEAOiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:38:16 -0400
Received: by mail-it1-f193.google.com with SMTP id l140so8825677itb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cI0F8wRwu0fEyj22FjTXNrCgEdAQZ+e+m8fsh/HMJP0=;
        b=QlmN9OXbl70ygTYnVQ1m080vaU5Xb09/V8O6NTERO74GoLtQzR2wuMdATpGLgA/6mR
         vQAbVNVA9ged2JMgrW+eVv/Q2a7LYhlsmpYV5rhAfJuuM2Tmu2QERU8ZPnyxCDBBhoBV
         f230QOPkSyHC2KSLLbKD9lpLXf6A64eWtA06MzpeY62Dop6gp3kLWSj07xxClxSE5RDv
         euqiccsyUKmOL6xN1uHGcQ37HaLGrXMsl0AEbh0BfdjI4Zed2Cdpv7kIH1RP4Uuza4Oc
         xLvk0vBiNzxdHelwLBhqAC7v5sw+mycJGJslzmR6kMqQ0Fjz774ZEbC5ICgpcAAmpatX
         OO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cI0F8wRwu0fEyj22FjTXNrCgEdAQZ+e+m8fsh/HMJP0=;
        b=BV8Cn5gCojQmWSkNm4lhdsGa1T8HjUoz1Nw5fGRvy6B4GlfTA2wIHB6dC9NsoXgv6X
         fTB7Y4wGGS1mn9sV8WNTo6G2XQNGQAJ++kBQNS1VP7E82sX2hFTxuOJqR+jGnqLWlHuE
         IelJ+xquewZx5EM3ybHPWW8mvVquwMpSJ9xjziaqduIocg6T785bdvUfdYtNzzlIZ+c0
         lALpijMz9/REgjyeIqDsdUDY9xbjkcnrt7e4382C6bC4E8ZmtV4bBOnBpuVm3SOyFW0M
         Eju9dZV7Z4TiWHk8zCbGOx+NJAQ7Uj5/gXg8M+nnYY7hCMEwws31L8SozdXYFNDHM2Ue
         o+kA==
X-Gm-Message-State: APjAAAXlLJ7BeO9fcZq9p5ll33/tWfbFKIZgsJQ9PDxqJ33kEDhF41rS
        R4gNWN3dxy1VxbDrItQl5og=
X-Google-Smtp-Source: APXvYqwHzdWNVJFXYbV2rDEG/39h99taIsvEPBtAHNTmcHtPSkZijtdScWJSiwMfrcCfxbTu8vLtKQ==
X-Received: by 2002:a24:6416:: with SMTP id t22mr8259204itc.176.1556721495770;
        Wed, 01 May 2019 07:38:15 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id w184sm2957224ita.9.2019.05.01.07.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 07:38:15 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] staging: fieldbus: anybus-s: fix wait_for_completion_timeout return handling
Date:   Wed,  1 May 2019 10:38:12 -0400
Message-Id: <20190501143812.7672-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

wait_for_completion_timeout() returns unsigned long (0 on timeout or
remaining jiffies) not int. Assigning this return value to int may
theoretically overflow (though not in this case where TIMEOUT is
only HZ*2).

Fix this inconsistency by wrapping the wait_for_completion_timeout
into the if().

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/staging/fieldbus/anybuss/host.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
index e34d4249f5a7..a64fe03b61fa 100644
--- a/drivers/staging/fieldbus/anybuss/host.c
+++ b/drivers/staging/fieldbus/anybuss/host.c
@@ -1325,11 +1325,10 @@ anybuss_host_common_probe(struct device *dev,
 	 *   interrupt came in: ready to go !
 	 */
 	reset_deassert(cd);
-	ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
-	if (ret == 0)
+	if (!wait_for_completion_timeout(&cd->card_boot, TIMEOUT)) {
 		ret = -ETIMEDOUT;
-	if (ret < 0)
 		goto err_reset;
+	}
 	/*
 	 * according to the anybus docs, we're allowed to read these
 	 * without handshaking / reserving the area
-- 
2.17.1

