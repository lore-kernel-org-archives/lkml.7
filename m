Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE7BC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039DB20733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfKONiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:38:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:32864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfKONiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:38:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED34820732;
        Fri, 15 Nov 2019 13:38:14 +0000 (UTC)
Date:   Fri, 15 Nov 2019 08:38:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for
 'dentry_d_lock_class'
Message-ID: <20191115083813.65f5523c@gandalf.local.home>
In-Reply-To: <20191115131625.GO26530@ZenIV.linux.org.uk>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
        <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
        <20191115032759.GA795729@kroah.com>
        <20191115041243.GN26530@ZenIV.linux.org.uk>
        <20191115072011.GA1203354@kroah.com>
        <20191115131625.GO26530@ZenIV.linux.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 13:16:25 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> I want to understand the overall situation.  No argument, list_empty()
> in there is BS, for many reasons.  But I wonder if trying to keep the
> current structure of the iterator _and_ the use of simple_rmdir()/simple_unlink()
> is the right approach.

My guess is that debugfs was written to be as simple as possible.
Nothing too complex. And in doing so, may have issues as you are
pointing out. Just a way to allow communications between user space and
kernel space (as tracefs started out).

BTW, what do you mean by "can debugfs_remove_recursive() rely upon the
lack of attempts to create new entries inside the subtree it's trying
to kill?"

-- Steve
