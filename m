Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3935CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C7C20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfDPQus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:50:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:38558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728093AbfDPQus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:50:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AAE6B0B8;
        Tue, 16 Apr 2019 16:50:47 +0000 (UTC)
Date:   Tue, 16 Apr 2019 09:50:38 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 10/16] locking/rwsem: Wake up almost all readers in
 wait queue
Message-ID: <20190416165038.xfjserwdhli6p222@linux-r8p5>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-11-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-11-longman@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019, Waiman Long wrote:
>+/*
>+ * We limit the maximum number of readers that can be woken up for a
>+ * wake-up call to not penalizing the waking thread for spending too
>+ * much time doing it.
>+ */
>+#define MAX_READERS_WAKEUP	0x100

Although with wake_q this is not really so... Could it at least be
rewritten, dunno something like so:

/*
 * Magic number to batch-wakeup waiting readers, even when writers
 * are also present in the queue. This both limits the amount of
 * work the waking thread must do (albeit wake_q)  and also prevents
 * any potential counter overflow, however unlikely.
 */

I'm still not crazy about this artificial limit for the readers-only
case, but won't argue. I certainly like the reader/writer case.

Thanks,
Davidlohr
