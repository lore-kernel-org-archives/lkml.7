Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66479C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4832190F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfJMAfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 20:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfJMAfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 20:35:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8BCA20679;
        Sun, 13 Oct 2019 00:35:04 +0000 (UTC)
Date:   Sat, 12 Oct 2019 20:35:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/7 v2] tracefs: Revert ccbd54ff54e8 ("tracefs: Restrict
 tracefs when the kernel is locked down")
Message-ID: <20191012203502.065258d2@gandalf.local.home>
In-Reply-To: <CAHk-=whE7GjKz9LtEVNw=zEgWr65N1mU7t2rA4MLiia8Zit6DQ@mail.gmail.com>
References: <20191012005747.210722465@goodmis.org>
        <20191012005920.630331484@goodmis.org>
        <CAHk-=whE7GjKz9LtEVNw=zEgWr65N1mU7t2rA4MLiia8Zit6DQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2019 15:56:15 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Oct 11, 2019 at 5:59 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > I bisected this down to the addition of the proxy_ops into tracefs for
> > lockdown. It appears that the allocation of the proxy_ops and then freeing
> > it in the destroy_inode callback, is causing havoc with the memory system.
> > Reading the documentation about destroy_inode and talking with Linus about
> > this, this is buggy and wrong.  
> 
> Can you still add the explanation about the inode memory leak to this message?
> 
> Right now it just says "it's buggy and wrong". True. But doesn't
> explain _why_ it is buggy and wrong.
> 

Sure. The patches just finished my testing (along with other fixes that
I need to send you). I have to make a few other updates in the change
log though, so I'll be rebasing them (but not touching the code), to
clean up the change logs.

-- Steve
