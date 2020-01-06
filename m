Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F4C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24C5207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2itK/10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgAFTTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50323 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgAFTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so16213407wmb.0;
        Mon, 06 Jan 2020 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G1EFNMDUzTeZnk/VjF52QA1icduulaXMjExrVxZh1z4=;
        b=p2itK/10UtqIJi99hHQPcrVU9j3avjoeukfC6iDjkhkNUeL/mL+O5z2y/hxiFNLnVO
         cA8SAWV8a/ARIBSZTKOaJAgpCcBkqZhqFrcKpXB3Tqi0ewwH0qADNdazDHDQAufouMME
         n5jYASPo/E2PK7A0oTp7gZzm2wKJ23ZaWA8J9Mc2LZCWVigF5260DE3L84Iyq2JeAU3o
         2MWYmNHHRKuEiRiZnx7KE4wXmAF6xj1um1JRzrOA0cvOJiKDNAmRmPo0nFVPXxpRy+Gx
         rjfZR98mCoxNZFLIVF1xW4O6hDXgHxvIxpZybK9qlS4OmeEUquDsNcbMwMsN7OYhjYzj
         HlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G1EFNMDUzTeZnk/VjF52QA1icduulaXMjExrVxZh1z4=;
        b=d/1srB665GY6hNkK0Neks0DG2S2dRV+vCd6aFQOB8spdUDyPvVTYCKpWopFG2Nvu3t
         B/S+KPcG1vO8TiiYhdAv8lEM1q3puFjerxZmnUMGUvQpjxmzMOjjg8n4qUUxJKutbjH3
         ZDdo8f8B+VFmDhdmtlVUQI26NpIAswYP/6ReFpATV58kdberxUN1eVpSHsylOMd0aJf9
         i9w/BZmhRRPS02aFTKq1dRFWdET8RIs6Kt/VTt0Z6saBp+SrsI+I+ybmBfsVmDFX6EOW
         F2mnhVTwH/CeeP9K/Ti6eE+LX8KhZekSKYoR0C46rWjUFRheMVMTyry2CQmfD2D4kEG+
         VvnA==
X-Gm-Message-State: APjAAAWg+jgnZ6jzBNb8eTASkBOm+hTpvFSF1hAWFjjpaDqJ7jWIqgnB
        vFJKhmg1SmvDU0xsybqO+c0=
X-Google-Smtp-Source: APXvYqz0CFTcLEYEW///OPvpRwaDxUdM994GrzguZ745v1OqmJilo8qWJ6UFHHZ96LOh1bQZg95m+Q==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr37311106wml.71.1578338355944;
        Mon, 06 Jan 2020 11:19:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id o4sm72041756wrx.25.2020.01.06.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:15 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 5/7] doc/RCU/rcu: Use absolute paths for non-rst files
Date:   Mon,  6 Jan 2020 20:18:50 +0100
Message-Id: <20200106191852.22973-6-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191852.22973-1-sjpark@amazon.de>
References: <20200106191852.22973-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/rcu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index a1dd71d01862..2a830c51477e 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -75,7 +75,7 @@ Frequently Asked Questions
 - I hear that RCU is patented?  What is with that?
 
   Yes, it is.  There are several known patents related to RCU,
-  search for the string "Patent" in RTFP.txt to find them.
+  search for the string "Patent" in Documentation/RCU/RTFP.txt to find them.
   Of these, one was allowed to lapse by the assignee, and the
   others have been contributed to the Linux kernel under GPL.
   There are now also LGPL implementations of user-level RCU
@@ -88,5 +88,5 @@ Frequently Asked Questions
 
 - Where can I find more information on RCU?
 
-  See the RTFP.txt file in this directory.
+  See the Documentation/RCU/RTFP.txt file.
   Or point your browser at (http://www.rdrop.com/users/paulmck/RCU/).
-- 
2.17.1

