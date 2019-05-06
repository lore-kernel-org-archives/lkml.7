Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E5C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669492082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557131789;
	bh=eiHzQyhOzQwPHF0TrCSrS4fRs0LrHViKmLji29sFVz4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gxMzR1aTqQOYEPZ2RBXVi3pRitLOtzRLxHR863Lk0w5Zbs3ihBFCXpHb8a7XbzWV3
	 2xH6Dw6yTIEwHyuCUWrbvnCjTjGxMeOD7lIIWcHzo4v3x2NaTeGldeSclq2YW0CUy1
	 Jk0IlbN4g1mJPfZGqjH8kimjUjTKrOvb3vWK4bOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEFIg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:36:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53592 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfEFIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:36:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so14648748wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Vr3HSOZeAFS/QzpsD/zE0Dg61yyqMnbP1Rtp6v4+Bo4=;
        b=q/wFSA13l9AHYurSqWKz8gSkgWJKFqFqPqTY7pGTEAkCzrS2NP0P8AIiMjjEg72bdx
         JJYgyc59sa3+jUuAmbgLtAnkbJQEtKUolzzgCRKkMJVTJC6YSkr0DEFQeFpkTOoT8wYk
         QQrXdvs4RjNt0dhgWelew2XHncY0TomnJ46V4imqzboMfJT9OAJuekWppUASURsMPXMp
         fkYZydYI6KArKCGwiP1Gu6XuX496iv6m5GOb25B5ON1QJ5Rld3wLRSmvvmyw2gMVPv5a
         fQfTHfxi+c9p+Ns87LLVfdJRvr4aWlQSHqpDVQAKcA/ts4E26VPlj4EpbT7IstpX6LSl
         jQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Vr3HSOZeAFS/QzpsD/zE0Dg61yyqMnbP1Rtp6v4+Bo4=;
        b=iZgD09RhYHSlXwOtaHcHom3xFlDvFHYZ8j6/9GNsZ2dAzLEXk5l7FMyAfFcf/sRMpp
         1MfDLnRi5TUz3rfjSGtRNi0hqOe7qnjNQDmIU+8T856lamz3FfyR2nwvIXpCtm1z4ZDi
         da1J8SEor43j20rtGi5JS7dbM7KgT0ox/qvlTJk2o+tU6Vx3EE6PO+zzi7KMZCVFs3Pn
         YS7WUtwjhfeU9zP6t5v9Qk/GQmcJVL83BIfiGgR9/P81GMbJj93etdA9/RfH9ZjCCFvO
         BZCH7iPi/acXrK714KMMG7Qx+7ahX/d4Ezq1UlH4YonNzRtSZocdsRhuEYl2+c7d80A5
         6W+Q==
X-Gm-Message-State: APjAAAUkDszO80xnz2DIzkYmQWuNzQZAZfrmNObG/TUSXa5urbLXkWk5
        jO5JcVKNK/ISY6EjBqLguOg=
X-Google-Smtp-Source: APXvYqxitRNtPsDM1X2YoD8ZGSnklPNKoyNHD0b+8IrdzNlgdCvzBe1TxZVSwCh4OxYpSesT9ggwCw==
X-Received: by 2002:a1c:cf83:: with SMTP id f125mr14620192wmg.96.1557131785957;
        Mon, 06 May 2019 01:36:25 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y184sm9420014wmg.7.2019.05.06.01.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 01:36:25 -0700 (PDT)
Date:   Mon, 6 May 2019 10:36:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] IRQ changes for v5.2
Message-ID: <20190506083623.GA127408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

   # HEAD: 471ba0e686cb13752bc1ff3216c54b69a2d250ea irq_work: Do not raise an IPI when queueing work on the local CPU

The changes in this cycle were:

 - Remove the irq timings/variance statistics code that tried to predict 
   when the next interrupt would occur, which didn't work out as hoped 
   and will is replaced by another mechanism.

 - This new mechanism is the 'array suffix computation' estimate, which 
   is superior to the previous one as it can detect not just a single 
   periodic pattern, but independent periodic patterns along a log-2 
   scale of bucketing and exponential moving average. The comments are 
   longer than the code - and it works better at predicting various 
   complex interrupt patterns from real-world devices than the previous 
   estimate.

 - avoid IRQ-work self-IPIs on the local CPU

 - fix work-list corruption in irq_set_affinity_notifier()

 Thanks,

	Ingo

------------------>
Daniel Lezcano (2):
      genirq/timings: Remove variance computation code
      genirq/timings: Add array suffix computation code

Gustavo A. R. Silva (1):
      genirq/devres: Use struct_size() in devm_kzalloc()

Nicholas Piggin (1):
      irq_work: Do not raise an IPI when queueing work on the local CPU

Prasad Sodagudi (1):
      genirq: Prevent use-after-free and work list corruption


 kernel/irq/devres.c  |   3 +-
 kernel/irq/manage.c  |   4 +-
 kernel/irq/timings.c | 522 +++++++++++++++++++++++++++++++++++----------------
 kernel/irq_work.c    |  75 ++++----
 4 files changed, 409 insertions(+), 195 deletions(-)
