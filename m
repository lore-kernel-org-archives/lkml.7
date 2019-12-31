Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1515C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C551F206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaF2LbkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfLaPQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:16:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55268 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfLaPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:16:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so2048089wmj.4;
        Tue, 31 Dec 2019 07:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V2G0IIz6PcMHsLxOWfvVq8qGDWQifeiMnhGJx0KlTEE=;
        b=BaF2LbkZ0P5Ts9drkbMuHOvzHt5Ooh4QNvUsZgigepGufNFTaHEf65AlGfd/rhlrAJ
         LM0sA5AHX20lY26/dIioDr5VHop19AEpxBktINChZjJ1BRwia5ktn+ysatWqvZcHbRrV
         PHvXxJ5AtN5/xgQdbmHpjBKyb1MPjYsUPVNcfJkSFnDaP+c8zVo5gUQ4cWu0qGujUmDt
         RjD6Wznj+xCVXqAd4tFjY6qlFJ077ZTbRVy743vadtGfPqV/C4jkKEx7rDoo+AZlfLeU
         o6q5uNMC1j+Z10WTAZoVd7Dg4YUEbH2209++PfQBKKZBx9pNDYlSXdkE2HInXHiW4jrJ
         fxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V2G0IIz6PcMHsLxOWfvVq8qGDWQifeiMnhGJx0KlTEE=;
        b=S5jFXsDD1YnsZcJZ0qkRpv/idp2YvxEDMlcgRBQ4X8vd8m30AKGSp1H6O2ueGcShIa
         7bc/H6zb0D0FG3ld7QOOoq07bE0Yrj160adQP+AvSgeqMXxKkFmZ3zWD2LgYt+nyeBtv
         9dgYHmu1kLR+uVhWAL6mw0yBueNKjgZWaCs4pl2ytdIm0u6hZeIzd2dfPnTMn9/ppGNg
         KRsgIEes0vIaMkvSDmFlG0VQtYYTDPaPbm9KDx5SKg2oZOsnLSTQxIdkfNuCI6sGu75H
         giJ/VF9EALun4cT7HjnB3t5rI2hUhxus6xVKQF8qsbAdDgC2ofSZ9mwI9LaT7geZfvmY
         8DfA==
X-Gm-Message-State: APjAAAXvOv7Pb76jtza8Llm6MaUybxPb6DQmI34OFORgsGLbNkpa6Ad9
        NqqQWs3eDlEur0DjLBy2Ja4=
X-Google-Smtp-Source: APXvYqyH4EmxY/t3g79B3jzE6Pn3KtZw9m+3YI1G7IaAGyxpEkeOy1+NmQpGPp5/lkzy+1b9n0CGEw==
X-Received: by 2002:a05:600c:1003:: with SMTP id c3mr4731764wmc.120.1577805365512;
        Tue, 31 Dec 2019 07:16:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:45f9:d1e3:14f9:8ba2])
        by smtp.gmail.com with ESMTPSA id e12sm49228468wrn.56.2019.12.31.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 07:16:05 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 5/7] doc/RCU/rcu: Use absolute paths for non-rst files
Date:   Tue, 31 Dec 2019 16:15:47 +0100
Message-Id: <20191231151549.12797-6-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231151549.12797-1-sjpark@amazon.de>
References: <20191231151549.12797-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

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

