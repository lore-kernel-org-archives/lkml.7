Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C814E206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKNCvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 21:51:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfKNCvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 21:51:37 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B292E206E4;
        Thu, 14 Nov 2019 02:43:08 +0000 (UTC)
Date:   Wed, 13 Nov 2019 21:43:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <oleg@redhat.com>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>
Subject: Re: [PATCH] debugfs: fix potential infinite loop in
 debugfs_remove_recursive
Message-ID: <20191113214307.29a8d001@oasis.local.home>
In-Reply-To: <a399ae58-a467-3ff9-5a01-a4a2cdcf4fd6@huawei.com>
References: <1572528884-67565-1-git-send-email-yukuai3@huawei.com>
        <20191113151755.7125e914@gandalf.local.home>
        <a399ae58-a467-3ff9-5a01-a4a2cdcf4fd6@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 10:01:23 +0800
"yukuai (C)" <yukuai3@huawei.com> wrote:


> Do you agree with that list_empty(&chile->d_subdirs) here is not 
> appropriate? Since it can't skip the subdirs that is not 
> simple_positive(simple_positive() will return false), which is the 
> reason of infinite loop.

I do agree that simple_empty() is wrong, for the reasons you pointed out.

> >> +		if (!simple_empty(child)) {  
> > 
> > Have you tried this with lockdep enabled? I'm thinking that you might
> > get a splat with holding parent->d_lock and simple_empty(child) taking
> > the child->d_lock.  
> The locks are taken and released in the right order:
> take parent->d_lock
> 	take child->d_lock
> 		list_for_each_entry(c, &child->d_sundirs, d_child)
> 			take c->d_lock
> 			release c->d_lock
> 	release child->d_lock
> release parent->d_lock
> I don't see anything wrong, am I missing something?

It should be fine, my worry is that we may be missing a lockdep
annotation, that might confuse lockdep, as lockdep may see this as the
same type of lock being taken, and wont know the order.

Have you tried this patch with lockdep enabled and tried to hit this
code path?

-- Steve
