Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE8C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5478421743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOIWHq0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfEUHIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:08:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39651 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfEUHIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:08:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so7967791plm.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A8bF2ejZjjy7bxespI+FQi5n+qw3qJ6gtn5NOfZAa/A=;
        b=WOIWHq0ZYYZ7arz7igF+wnqWq6y0cSKaU30mnV+D7soO7uJwVqmTONUOcCkE9Q3+ug
         Gz/FY2MgPUhCjFaPCkXz7jCchDVTpJi0tr2aVRveloRo2GY6catX/DCuU4LHb+JcqOca
         6WLffoUAzdlEFtlvSicRUXfx6NxBdPtyVxvAVdQNlVKRlnL8sq5VkiCR3LZPSDCdQFTr
         uLsuWlb5wqjPUADdHvVNrjQREgnguclvcvb6q38YjUGsj8HkMQaNtxus+nsba+bhogYo
         UvQr2bYsmbmejaruF9OcQeSUUnhGASx/oTxbB6HFfMf22sCw+zf+rvjZRMRplVQS19Ht
         reUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A8bF2ejZjjy7bxespI+FQi5n+qw3qJ6gtn5NOfZAa/A=;
        b=rCnjYWpuxWilai0tioSrcVdKIjkNtM91qAyleRdeNuS76qxeSaIeGtgtZLu4PCj+Gv
         Z9lbw4ou+dx/L16Q0fyORh1USBecPiIlPgiJYT6PU/tUUloCjjlb/UGBzUA/PQ58dQLI
         xTLniUJEzyvudkJbTpRz6YysCZooWTT+qZD69+J4ePhihCqhXhfqIqRZ7JJmQmKAAYup
         R1Ytr3o7SLZWl3kCWzmIxlVHR0qG0OlJNjm+5GtqNGQbMdp1b2TmakrRKtYSYelC4OdK
         6On3Ugzn/grzyxa9/S1RGlbjwqnD342Eyv0tDtCpN1gqXGElniChHauWbr0c+L1yKpMg
         aUug==
X-Gm-Message-State: APjAAAX/xPlhvlHQdtsYkpwwxS8//4D63LrOw8GMxD/ZstN4YYwZU9Gv
        xR/FqI5XaNTYWRoHJs6rqyLFtl92
X-Google-Smtp-Source: APXvYqxvr2RAsirxIAk5TCSOVtC9KOnMMhHqwuS7qgyhCps096HD2EoUmsc94H/7kyPZbf6F/vvHnA==
X-Received: by 2002:a17:902:b695:: with SMTP id c21mr81179838pls.160.1558422491852;
        Tue, 21 May 2019 00:08:11 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q193sm30033885pfc.52.2019.05.21.00.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 00:08:11 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/1] lockdep: fix warning: print_lock_trace defined but not used
Date:   Tue, 21 May 2019 00:08:07 -0700
Message-Id: <20190521070808.3536-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

This is a second attempt to send this. The first attempt [1]
went via mailgw.nvidia.com, and did not receive a DKIM signature,
so I think it probably got discarded by many systems.

This one goes via gmail, which is what I was using before. We'll keep
working on getting the NVIDIA outgoing email servers working
with mailing lists, but meanwhile I'm back to using "envelope"
techniques, I guess. I was hoping to use a "native" email
address, but not quite there yet. :)

Anyway, here's the original cover letter:

I ran across this minor warning while building against today's linux.git.

The proposed trivial fix leaves it a little fragile from a "what if someone
adds a new call to print_lock_trace()" point of view, but I believe that it
makes the current combination of ifdefs accurate, anyway.

[1] https://lkml.org/lkml/2019/5/19/60

Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>

John Hubbard (1):
  lockdep: fix warning: print_lock_trace defined but not used

 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.21.0

