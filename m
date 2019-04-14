Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2DCC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053DF2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI1GqRip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfDNLYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 07:24:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40395 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfDNLYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 07:24:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so7236597pgl.7;
        Sun, 14 Apr 2019 04:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8bh7E92XwAQY9Rdt0I1FjHX4WCuQLkN46aALYSHpo68=;
        b=PI1GqRip2CPbVtvq39Ix+q/D9uJvG7psnU60Ew+qfhmxytg189GtDF7U0y+yK0FPbm
         CST1lKgXywnptMMsb9v3hEmO+8ntAm9IqvrAeDgEL7SX/UdDYhtIFn6vI4BUYI/f6C7c
         vtokqAjhLIQXe4gLPkx1h9c166TfUEVbjf4u3mePpI+aTxXpzuAT9HVKwWEnFPlbR+Ig
         S5xM0op2xWQMDw7bx+/mL/dAKxjNJQdGrM07I9V79Lm9KigKNhRiqIx2L3/mb3quAMNC
         mfRPgDzn11gvfxoW2xYpTDCsrTH2Ku3hJ43LHkzTfCHG0/FMzhGfP1Sjpq4f+9bZNAij
         zAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8bh7E92XwAQY9Rdt0I1FjHX4WCuQLkN46aALYSHpo68=;
        b=sNrAU1GcLbjXWtUwVbVc9HO86Pq11y1CGqKGG3P2IZqTBS1E2JOtMfKiKnUO/kdsoR
         WHGk62IRHG244AisRMNWaS7NMX+FuwXH046ZJrA2hcjvab4LG2GQFs7eS5qCC3onOk39
         YsnMGD7ndHt5dXcWRR8molJFmuGt21z2xYeJGtnGtiZqpyC/9PMKiqBExh7YbxfuSisN
         l9SIPglrgiNhrqoressdSQQ1WD33JIDqBaGZJzue3w4ITSLyQ1eoO95q7mIFd1I9R8i8
         z9xDnTA3jaKA7q2vpQB0jbTWC46yL5ZPYNXdXtAz7i2goBEQor4jUFku+oQl6kQnaaO9
         E75Q==
X-Gm-Message-State: APjAAAVJsJyl1LXl3+K5M24fe9qe06ssiE2qFnoIoVXCb4MV34raaHv0
        gbiWzxcR8F9t9IN79xIJPuA=
X-Google-Smtp-Source: APXvYqzzuXXGTo57vSgQ8+EqFKQmr4J/0+4OIfvwTjlEKH6vdDOVBqkJmCfjTiOsIk8Gh28fvrUAOQ==
X-Received: by 2002:a63:d709:: with SMTP id d9mr61543743pgg.38.1555241085856;
        Sun, 14 Apr 2019 04:24:45 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.36])
        by smtp.gmail.com with ESMTPSA id a17sm76050235pfj.123.2019.04.14.04.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 04:24:45 -0700 (PDT)
Date:   Sun, 14 Apr 2019 16:54:38 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     keescook@chromium.org, jack@suse.cz, arnd@arndb.de,
        akpm@linux-foundation.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/reiserfs/journal.c: Make remove_journal_hash static
Message-ID: <20190414112438.GA23266@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the -WDecl sparse warning in journal.c. Function was declared
as static void but the definition was void.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/reiserfs/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 8a76f9d..36346dc 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -1844,7 +1844,7 @@ static int flush_used_journal_lists(struct super_block *s,
  * removes any nodes in table with name block and dev as bh.
  * only touchs the hnext and hprev pointers.
  */
-void remove_journal_hash(struct super_block *sb,
+static void remove_journal_hash(struct super_block *sb,
 			 struct reiserfs_journal_cnode **table,
 			 struct reiserfs_journal_list *jl,
 			 unsigned long block, int remove_freed)
-- 
2.7.4

