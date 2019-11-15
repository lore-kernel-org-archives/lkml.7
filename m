Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A6FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7582520729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKOBxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:53:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfKOBxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:53:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D6FF20727;
        Fri, 15 Nov 2019 01:53:13 +0000 (UTC)
Date:   Thu, 14 Nov 2019 20:53:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <oleg@redhat.com>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>,
        "Al Viro" <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] debugfs: fix potential infinite loop in
 debugfs_remove_recursive
Message-ID: <20191114205311.3ce9c7ac@gandalf.local.home>
In-Reply-To: <6ac793b1-5472-6a39-fe94-348ad6a4e2be@huawei.com>
References: <1572528884-67565-1-git-send-email-yukuai3@huawei.com>
        <20191113151755.7125e914@gandalf.local.home>
        <a399ae58-a467-3ff9-5a01-a4a2cdcf4fd6@huawei.com>
        <20191113214307.29a8d001@oasis.local.home>
        <0ceb4529-5238-e7fc-2b5b-d2f0bdeb706e@huawei.com>
        <20191114093410.15f10eda@gandalf.local.home>
        <6ac793b1-5472-6a39-fe94-348ad6a4e2be@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 09:47:38 +0800
"yukuai (C)" <yukuai3@huawei.com> wrote:

> On 2019/11/14 22:34, Steven Rostedt wrote:
> > On Thu, 14 Nov 2019 14:59:04 +0800
> > "yukuai (C)" <yukuai3@huawei.com> wrote:
> >   
> >>> Have you tried this patch with lockdep enabled and tried to hit this
> >>> code path?
> >>>  
> >   
> >>>      
> >> You are right, I get the results with lockdep enabled:  
> > 
> > That was what I was afraid of :-(
> >   
> >> [   64.314748] ============================================
> >> [   64.315568] WARNING: possible recursive locking detected
> >> [   64.316549] 5.4.0-rc7-dirty #5 Tainted: G           O
> >> [   64.317398] --------------------------------------------
> >> [   64.318230] rmmod/2607 is trying to acquire lock:  
> >   
> >>
> >> The warning will disappeare by adding
> >> lockdep_set_novalidate_class(&child->d_lock) before calling
> >> simple_empty(child). But I'm not sure It's the right modfication.  
> > 
> > I'm wondering if we should add a simple_empty_unlocked() that does
> > simple_empty() without taking the lock, to allow us to call
> > spin_lock_nested() on the child. Of course, I don't know how much
> > nesting we allow as it calls the nesting too.  
> Do you think we can do this:
> 1. add a new enum type for dentry_d_lock_class:
> enum dentry_d_lock_class
> {
> 	DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
> 	DENTRY_D_LOCK_NESTED
> 	DENTRY_D_LOCK_NESTED_1 /* maybe another name */
> };
> 2. use the new enum type in simple_empty
> int simple_empty(struct dentry *dentry)
> {
> 	spin_lock(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> 	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
> 		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED_1);
> }
> 
> If you agree, I'll try to send a patch or patchset(with modification in 
> debugfs_remove_recursive).
> 

It sounds fine to me, but I think the decision needs to be with the
debugfs and vfs maintainers.

-- Steve
