Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91730C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC332183E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfC1QEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfC1QEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:04:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D07C20823;
        Thu, 28 Mar 2019 16:04:18 +0000 (UTC)
Date:   Thu, 28 Mar 2019 12:04:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Slavomir Kaslev <kaslevs@vmware.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.9 20/87] fs: Make splice() and tee() take into
 account O_NONBLOCK flag on pipes
Message-ID: <20190328120417.36bae781@gandalf.local.home>
In-Reply-To: <3c4595fec941c10beaf4bad8df30170b4e950226.camel@vmware.com>
References: <20190327182040.17444-1-sashal@kernel.org>
        <20190327182040.17444-20-sashal@kernel.org>
        <3c4595fec941c10beaf4bad8df30170b4e950226.camel@vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 15:37:49 +0000
Slavomir Kaslev <kaslevs@vmware.com> wrote:

> On Wed, 2019-03-27 at 14:19 -0400, Sasha Levin wrote:
> > From: Slavomir Kaslev <kaslevs@vmware.com>
> > 
> > [ Upstream commit ee5e001196d1345b8fee25925ff5f1d67936081e ]
> > 
> > The current implementation of splice() and tee() ignores O_NONBLOCK
> > set
> > on pipe file descriptors and checks only the SPLICE_F_NONBLOCK flag
> > for
> > blocking on pipe arguments.  This is inconsistent since splice()-ing
> > from/to non-pipe file descriptors does take O_NONBLOCK into
> > consideration.
> > 
> > Fix this by promoting O_NONBLOCK, when set on a pipe, to
> > SPLICE_F_NONBLOCK.  
> 
> Hey Sasha,
> 
> I don't think that this patch should be merged to stable kernels. It's
> more of a feature rather than a bug/regression fix and it changes how
> splice() has been working from day one.
> 
> Can you please drop it from the stable queues?
> 

On the other hand, it keeps stable more in sync with what mainline has.
If someone writes new code against a stable release, and depends on
this behavior, it's less likely to break when they run it on a newer
kernel. Which means its less likely that Linus will revert your
change ;-)

-- Steve
