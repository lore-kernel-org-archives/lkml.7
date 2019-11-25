Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C35C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7482068E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574679626;
	bh=1ddaNvuIL1vtddddKJ54+TEs7vppN8CMnBtMIJBbE+I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fSOTjkPuHb8hJ6X3MScJL83gjBVgghoShKSdmjc5YBVa8TU+UPRi9wSNWEcR4wQXv
	 xExYCLjeGDUjWbTy4zx3H7pQ1kSciyUsrXoueIWPnoRk1IJ5FRPNiyJXZMGYuIwux0
	 d4nSjcp9pNVWLFjDCJV4cIH30pa/PKyyBah10B6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKYLAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:00:24 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37596 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKYLAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:00:24 -0500
Received: by mail-wm1-f46.google.com with SMTP id f129so14021002wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 03:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gS84IIxPGaUBR9X9Mk2rkH83WR7vlZdxI/N0xiyIvDY=;
        b=VNS/NxQVW/kfFovWuHio4KoDkERNwyOfkjSCpKtY8BLpmCcF1ubYBRo86wh4SXgX3w
         m+7wiIq1ZghfbTd1PuDhgxDqzhFiJ+wFxs713paIuOldrsFvzz+lcfmW+iy0M6P6nbXY
         7fRoVU04sv6MM8E7P4FclfUfW+NnAxKQzVyFN7xCiSI9kUuayiiMbORilh3+VysF8wq1
         SR5x266P7vX8gLA6FizRNX8aZNdOmfU8vavnzKhzqmKI+mGN6vcODAMTdOItPDB4mxMx
         5jA6L8Ki7jxNBZlGAvPZu2Ey41d7u8QQx5sJUhOI/74bIfCZEqVzjVFlHqDDtWSzB7Bn
         8Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=gS84IIxPGaUBR9X9Mk2rkH83WR7vlZdxI/N0xiyIvDY=;
        b=FMYNPSP6i5qcq7bn/HHlL6N7F0ZJT2XNjX7Xt9DRU7xFPZ2zhY2eEso9U484TEoVJi
         D0m5NNHvphqozOiKiAi2wwq5+8wnHIp0xn2CozzLwneaF6LXoNQVBOrv50hpslQ3COJV
         pwv73RZig8KB+KqFlfh6f+OvcYQqRgMWcOzxkfP3uMvyTSUOnvnw3KmbaLjBph3wCHUZ
         sEnPLQIdCVmG+62xpAVKnZb+5iezyjsWmT9rlYYbZMwhV/XRq4wFTtO5o1UoxnG81zcM
         KsoZwRc9clWBXuFhLLfRp+CPnQGtw0F1z1qGwRD0h9RqBzeP2dHG+cfYOXcYPrVXII0O
         KQAQ==
X-Gm-Message-State: APjAAAXP/vV5fZlIWpr4yIypGJwEtCChQZTj4t3f4K2huFIixTq5sbNQ
        lpfkZ5tm5DwDQKvlC3B2z/A=
X-Google-Smtp-Source: APXvYqzHa5XBPQW0lbrQOSeD5AxZKgOmsAbQpH9nO8/tE/7q4Rp0RAad4MAEIimQDM/H5NfLvP3nVw==
X-Received: by 2002:a1c:96c9:: with SMTP id y192mr29211272wmd.8.1574679621886;
        Mon, 25 Nov 2019 03:00:21 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y2sm8346182wmy.2.2019.11.25.03.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 03:00:21 -0800 (PST)
Date:   Mon, 25 Nov 2019 12:00:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/stacktrace cleanup for v5.5
Message-ID: <20191125110019.GA117271@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-stacktrace-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-stacktrace-for-linus

   # HEAD: 4b48512c2e9c63b62d7da23563cdb224b4d61d72 stacktrace: Get rid of unneeded '!!' pattern

A minor cleanup.

 Thanks,

	Ingo

------------------>
Jiri Slaby (1):
      stacktrace: Get rid of unneeded '!!' pattern


 kernel/stacktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index c9ea7eb2cb1a..2af66e449aa6 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -142,7 +142,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
 		.store	= store,
 		.size	= size,
 		/* skip this function if they are tracing us */
-		.skip	= skipnr + !!(current == tsk),
+		.skip	= skipnr + (current == tsk),
 	};
 
 	if (!try_get_task_stack(tsk))
@@ -300,7 +300,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *task,
 		.entries	= store,
 		.max_entries	= size,
 		/* skip this function if they are tracing us */
-		.skip	= skipnr + !!(current == task),
+		.skip	= skipnr + (current == task),
 	};
 
 	save_stack_trace_tsk(task, &trace);
