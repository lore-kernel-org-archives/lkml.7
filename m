Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2114C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D65924650
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfLQPau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:30:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46608 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfLQPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:30:50 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihEo9-00065R-R5; Tue, 17 Dec 2019 15:30:45 +0000
Date:   Tue, 17 Dec 2019 15:30:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     qiwuchen55@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [RESEND PATCH] fput: Use unbound workqueue for scheduling
 delayed fput works
Message-ID: <20191217153045.GZ4203@ZenIV.linux.org.uk>
References: <1576595472-27341-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576595472-27341-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:11:12PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> There is a potential starvation that the number of delayed fput works
> increase rapidly if task exit storm or fs unmount issue happens.

Err...  Details, please, ideally along with a reproducer.  In particular,
I would like to understand what does any of that have to do with umount.
Or to task exits, for that matter - exit_files() is called before
exit_task_work(), so you shouldn't normally be seeing task_work_add()
failures when files get closed on exit(2)...

If you are really observing such problems, it might be worth looking
into the underlying situation - something odd appears to be going
on and I'd rather understand what it is.
