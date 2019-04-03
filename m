Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F08C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDC5206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDCPsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:48:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36957 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:48:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so4172481pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qBTnkVDEmLsIHEc+VaMqVLGDhPhNWzAH/tbHwbyKS4=;
        b=mYz9+EeYTW9AMKrk8Aiws2yduG2yz+yQH5YZi0BKExsc7UGwbV4sEw24N/q2dAxk3E
         YpwA3+q1t+T5T3aR9TE1XHzFtjf3AZvwcBn0N7duokNjA/NhGPW5ujEDTigx2NIKcAW+
         fH3ycwtt9ikYbS68BDeqZS5F4cVL6hmmPkK8Ktt2q/p5kA4zl+g2VOo92+HnD2P0e5AN
         W2aLlwjWwx2T+qCWy1MSff+9a2tNOaU0HngdAU8wiqNc7yFJw4Cbtk+92JcHAfQXoFTD
         XvAdraNDz5JuSrRSekSizENu+bQl15W6nk9iEjtNNL5fNyEyMNuzw+uFiUmWttOz88ir
         vfKA==
X-Gm-Message-State: APjAAAURSlCSgInCNx7P8vOv6Yxb+anDfG859ssAqJSoqVLcBZPwg6TY
        pWi0ZdKwJZrKpsRd/Xq1IjA=
X-Google-Smtp-Source: APXvYqzKsKCOko6vgnbXd8NRJHEmiZd/CqWVuFvwEApc6beTCDb7xitbO7M7D7MO0dPYqK13iNhKDg==
X-Received: by 2002:aa7:85d9:: with SMTP id z25mr102080pfn.31.1554306485392;
        Wed, 03 Apr 2019 08:48:05 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 17sm24238669pgz.52.2019.04.03.08.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:48:04 -0700 (PDT)
Message-ID: <1554306482.118779.198.camel@acm.org>
Subject: Re: [PATCH] locking/lockdep: Zap lock classes even with lock
 debugging disabled
From:   Bart Van Assche <bvanassche@acm.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        shenghui <shhuiw@foxmail.com>
Date:   Wed, 03 Apr 2019 08:48:02 -0700
In-Reply-To: <20190403124410.GE16362@fuggles.cambridge.arm.com>
References: <20190326195912.43316-1-bvanassche@acm.org>
         <20190403124410.GE16362@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 13:44 +-0100, Will Deacon wrote:
+AD4 On Tue, Mar 26, 2019 at 12:59:12PM -0700, Bart Van Assche wrote:
+AD4 +AD4 Commit a0b0fd53e1e6 (+ACI-locking/lockdep: Free lock classes that are no longer
+AD4 +AD4 in use+ACI) changed the behavior of lockdep+AF8-free+AF8-key+AF8-range() from
+AD4 +AD4 unconditionally zapping lock classes into only zapping lock classes if
+AD4 +AD4 debug+AF8-lock +AD0APQ true. Since the new behavior can cause cat /proc/lockdep to
+AD4 +AD4 crash due to a NULL pointer dereference, restore the pre-v5.1 behavior.
+AD4 
+AD4 Can you elaborate on this NULL dereference please, and why this patch fixes
+AD4 it?

Hi Will,

Not zapping lock classes if debug+AF8-lock +AD0APQ false leaves dangling pointers in
several lockdep datastructures, e.g. lock+AF8-class::name in the all+AF8-lock+AF8-classes
list. The shell command +ACI-cat /proc/lockdep+ACI causes the kernel to iterate the
all+AF8-lock+AF8-classes list. Hence the +ACI-unable to handle kernel paging request+ACI
issue that Shenghui encountered by running cat /proc/lockdep. Please let me
know if you would like me to repost this patch with a more detailed
description.

+AD4 +AD4 Cc: Thomas Gleixner +ADw-tglx+AEA-linutronix.de+AD4
+AD4 +AD4 Cc: Will Deacon +ADw-will.deacon+AEA-arm.com+AD4
+AD4 +AD4 Cc: Waiman Long +ADw-longman+AEA-redhat.com+AD4
+AD4 +AD4 Cc: shenghui +ADw-shhuiw+AEA-foxmail.com+AD4
+AD4 +AD4 Reported-by: shenghui +ADw-shhuiw+AEA-foxmail.com+AD4
+AD4 +AD4 Fixes: a0b0fd53e1e6 (+ACI-locking/lockdep: Free lock classes that are no longer in use+ACI) +ACM v5.1-rc1.
+AD4 +AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 +AD4 ---
+AD4 +AD4  kernel/locking/lockdep.c +AHw 23 +-+-+-+-+-+------------------
+AD4 +AD4  1 file changed, 6 insertions(+-), 17 deletions(-)
+AD4 +AD4 
+AD4 +AD4 diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
+AD4 +AD4 index 34cdcbedda49..70480e4f8f5d 100644
+AD4 +AD4 --- a/kernel/locking/lockdep.c
+AD4 +AD4 +-+-+- b/kernel/locking/lockdep.c
+AD4 +AD4 +AEAAQA -4689,8 +-4689,7 +AEAAQA static void free+AF8-zapped+AF8-rcu(struct rcu+AF8-head +ACo-ch)
+AD4 +AD4  		return+ADs
+AD4 +AD4  
+AD4 +AD4  	raw+AF8-local+AF8-irq+AF8-save(flags)+ADs
+AD4 +AD4 -	if (+ACE-graph+AF8-lock())
+AD4 +AD4 -		goto out+AF8-irq+ADs
+AD4 +AD4 +-	arch+AF8-spin+AF8-lock(+ACY-lockdep+AF8-lock)+ADs
+AD4 
+AD4 This also throws out the recursion counting. Is that ok?

I think that that's OK. My understanding is that lockdep keeps track of
recursion to avoid that lockdep+AF8-lock is locked recursively. However, none
of the functions modified by this patch are called with that lock held.

Thanks,

Bart.


