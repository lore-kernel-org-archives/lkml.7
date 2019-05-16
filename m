Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CBEC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55013205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMiUG6sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfEPIBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:01:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34153 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:01:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so1433290pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MW/Nbpb+BrjZOlwi2QZ97N5TYhyjqGhZpc+C8rcgIWc=;
        b=OMiUG6shKWB8a14dG9E4RT+Z2btKr06bdLOblSA1t2QK0wyfKJTtYF3a73ZW4gqOuS
         vZGa4uPPU8EvD+ENMSEdp9EV9MErMUbIeHp9dadGh/sZxggcjEJH9EAXsPuxEzlGzrk/
         zMsjLvPyBbcwhqiBt/z6QmeGOukvA6J1AbXIVI7KYL4f7v5AXID07f4QpuTzPT4HwOlR
         lLn97UPaMBExRzYX/muQrGzG0dNkzX8PxKMWhb9WOGnfb2BJ5fsbCS4B2o11D5cO3FeF
         RanlpZxAAEuyJRVKDlHnyD+sQbQtbr/r2n2buX5696tx5WDw+/fMq9G12IOxDJaFGKCs
         GPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MW/Nbpb+BrjZOlwi2QZ97N5TYhyjqGhZpc+C8rcgIWc=;
        b=tU0G8+jgg7kkNAil1N1LQ/NBMuF4C1d4RYnm9jSKbbL5u2oR3FD/SzZqT4TNPsWwkU
         I/a/amuF2i8kJD7RVOsnzrh69KAQTfcysbgjBeofyDVzv5vZa5EM2BSHOP2/7iuasYSh
         mPQ5rlLnAmw7f+IEmNgbLzfoc4G9OGQxBmYoJTsZyzVhRfyYmYmaUtpx+ku725xQWL3A
         Hsr3hA3tLBAm577KzW5Ay+c0p9pGdHOsdUh37MKjtC7I2NxUoo8HVhS/JLNuENlVkX+v
         LMpQe1CWkqCZlUvDp516jM1M+b3gdj4dtTLYOebQxTJUrUthUZFHg+2HUEoDzZIA43iR
         EQxA==
X-Gm-Message-State: APjAAAXdYOeKfQ8nWvaC22vEz8yddWWNu6EkhgamLSzvk7Xr8r+c4aHJ
        rUPrvfPnz2lMB/vdMLsbjBU=
X-Google-Smtp-Source: APXvYqw91gdPYp3nGpWH+dNlCqwECN6zuLZ7LDlbPthEnelzXXvy8g9ANboFjtqSupdsG3rsSIYe5Q==
X-Received: by 2002:a63:b507:: with SMTP id y7mr49047514pge.237.1557993666518;
        Thu, 16 May 2019 01:01:06 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:01:06 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 12/17] locking/lockdep: Remove useless lock type assignment
Date:   Thu, 16 May 2019 16:00:10 +0800
Message-Id: <20190516080015.16033-13-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next lock to acquire has the lock type set already. There is no need to
reassign it when it is recursive read. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d5a874b..ce79b5a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3132,13 +3132,6 @@ static int validate_chain(struct task_struct *curr,
 		if (!ret)
 			return 0;
 		/*
-		 * Mark recursive read, as we jump over it when
-		 * building dependencies (just like we jump over
-		 * trylock entries):
-		 */
-		if (ret == LOCK_TYPE_RECURSIVE)
-			hlock->read = LOCK_TYPE_RECURSIVE;
-		/*
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
-- 
1.8.3.1

