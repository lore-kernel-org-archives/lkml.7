Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055CEC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB81621479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7AJOXWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfEMJN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34652 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfEMJN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so6179421plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nd873eP5NtHZE8FJeGYW7SRzcE7yGDzRzVz5Bd0i6VE=;
        b=L7AJOXWznS2bhsSxQ9nJQLeF8CCvkLMQuYAVNhAxBkyE/WaCiRrOZl1/M2dyw9j483
         zFdRJdYSjTnGtqC2N/SguMl/uCii5WbiKG38rrz3LNK8zYmNk2C6QIRpGcOd5WE3Cxux
         BsO9wzBAk/MlpTqF+P+7NgWdXJEOfm3ITqCaunagceD+5NXHlMF/tS3M47AjBOZ1Mmtc
         hUkRb22ELFSZb5mPFomXvlC9BLyw5FxCpHS0bHUxzDV/LkHmKvoEOrgpTHEQl89SXmAU
         SYFyLIOOKBHrhx3aHw8OEwA/U51J/fnQPT2+Vi6eOWLxlXMcsdUyGXPLErw7egi5ubuu
         haHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nd873eP5NtHZE8FJeGYW7SRzcE7yGDzRzVz5Bd0i6VE=;
        b=UGCcW6mJvGVrKOdkpy2ETHRn5TuMiNYtccPpA8bRUyRjgK4XdFpUF4E2vQhO0D4itd
         NEppHG7yfr5urnIOJKgkZhICpZVijh+M6j0mImgaPFPsc/DPSBU20Fwc9qwIJJfoVz+I
         6kF4mfy/UpvykjrNF1sqjSGO+4ikT72E7yELCg85MkPxw0QL0AB8Wa1bKsRLhgRG6T5U
         y6mT6ARvlVB62HKQEyR+w0NtIOVeAx0BdiDJspMG/35XeXo1YRkgaRfISI4Avp+YEYsn
         wuakaMRo+/WhBIWkcRzQUf5Xn/kI2svNe+sTyZAsU9xH53hdlyycHXVmQXyRZnT/aUvH
         jurw==
X-Gm-Message-State: APjAAAVcgNH838AYYGf102o9QY1J5Zq8BzGWPuZzgQpsNvefo0lFzd9B
        7CDIiIoEle1LWO3QDB3Fm3I=
X-Google-Smtp-Source: APXvYqz4BE2qwv5DzVlUVa0yf9+cVKbnti5uOOvZIGkp2hBjmxMEwunu+PhfoPtPVqOb+P5GEZLeng==
X-Received: by 2002:a17:902:765:: with SMTP id 92mr28627007pli.196.1557738837333;
        Mon, 13 May 2019 02:13:57 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:56 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 12/17] locking/lockdep: Remove useless lock type assignment
Date:   Mon, 13 May 2019 17:11:58 +0800
Message-Id: <20190513091203.7299-13-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
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
index 26690f88..c94c105 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3128,13 +3128,6 @@ static int validate_chain(struct task_struct *curr,
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

