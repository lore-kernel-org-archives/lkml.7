Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA01C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434FA2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdmnXcSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCSCVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:21:06 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34742 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfCSCUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:42 -0400
Received: by mail-it1-f196.google.com with SMTP id l4so11288994ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opQU8mLcrkdsLOJBAGLatk/nt77mIDZMo/hGDIXaxL0=;
        b=qdmnXcScKYJTJXZAHR6Qpx2Lrr52Tjm4zHamWUqJ3LRwTmyiBvGONi6435fFVeVP2Z
         j/3bZubAUtzZg3DTfUbKo4d9h+Hw7nqHVNQV+KlP4eDlrBh+f7tioNzhhf7hO9KTlZsX
         H/eQazyk/IuwA0EakFmAiU8sOEsxPgK9wx91GfSRJPsjZ+jYbLvYijlA0QOHAJAi0pMj
         p1AbORPZsylgTE6RAr2NyKOgGHwvmOX8pGIi7Yv+Qc4L9vo+0u5mayJGBr4RzO3vydOm
         SUhemOXU3w4KFv6SXFn/2bp+tD1hg2VW0phFNVQx2dc67d4es2VrKuc9X4oPRFJ0aM4L
         +MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opQU8mLcrkdsLOJBAGLatk/nt77mIDZMo/hGDIXaxL0=;
        b=Mfaoes0Vr0zYIw+sZCTZYxehQcRiZHTbM+6ViDK3GDBCSUkuEFamOzODsK54Gg8P0z
         ifRBhGA44DLWNKZbkOQYNSkCZSBZWWfHekJPTOg9i2L8+Yjd40Daqmr9FMpt54sOKzho
         dltqP7e0fQZEUzvP2YP6eqlp6yJFo4gY6O1JOE9JG8aeZF6cgu7OBATXWxVBnMLjo4BQ
         UYaO0V1lEzLd3rd46Bv4L/LSwHkZpzBhZVPWwp8rwj0A3b+kR5dCWpqkM/zkshXxJaJd
         LEeOro24j1ot8gxkxcqBFJLb3HYbcsn3jqIh8R2/UdnjIzZfvmeK6B9pUmshkCHVUupP
         GmBQ==
X-Gm-Message-State: APjAAAVG/+jRZFAJPaqmDKVZ1AFDHL+2JA3o8VcGy8b0s2wnmILxKxK4
        DFQa96ySIlDkpjJfEcYWkpY=
X-Google-Smtp-Source: APXvYqyqvk3OcES9dEFjKFQvcw1BIUp5XNJ3HM7Eb9V31ToqgxaGjkMFA5MoZmlUSGYUy99bQ/1hAA==
X-Received: by 2002:a05:660c:46:: with SMTP id p6mr37759itk.93.1552962041606;
        Mon, 18 Mar 2019 19:20:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:41 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 08/11] staging: mt7621-mmc: Remove redundant host->mmc->f_max write
Date:   Mon, 18 Mar 2019 20:20:09 -0600
Message-Id: <20190319022012.11051-9-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is set once during initialization and never changed.  Don't bother
setting it again in the interrupt handler.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 31c5b44bd29f..df85888f3a03 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -209,7 +209,6 @@ static void msdc_tasklet_card(struct work_struct *work)
 	host->card_inserted = inserted;
 
 	if (!host->suspend) {
-		host->mmc->f_max = HOST_MAX_MCLK;
 		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
 	}
 
-- 
2.21.0

