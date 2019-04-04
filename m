Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0632DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD452206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfDDTJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:09:03 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41540 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729848AbfDDTJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:09:03 -0400
Received: (qmail 27278 invoked by uid 2102); 4 Apr 2019 15:09:02 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Apr 2019 15:09:02 -0400
Date:   Thu, 4 Apr 2019 15:09:02 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Joel Fernandes <joel@joelfernandes.org>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
In-Reply-To: <20190404180842.GB183378@google.com>
Message-ID: <Pine.LNX.4.44L0.1904041504500.1288-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019, Joel Fernandes wrote:

> FWIW, thought to mention (feel free ignore the suggestion if its
> meaningless): If there is any chance that the outcome can be better
> outputted, like r1=X; x=1; Where X stands for the result of a data race, that
> would be lovely.  I don't know much about herd internals (yet) to say if the
> suggestion makes sense but as a user, it would certainly help reduce
> confusion.

I don't think that is feasible.  For one thing, according to the C 
Standard, in the presence of a data race a program is allowed to do 
anything at all.  There's no point trying to display all possible 
outcomes of an execution!

If we adopted the proposal that certain kinds of data races only result
in undefined values, things would be a little better.  It's possible
that the herd program could be changed to support undefined values.  
At present, however, it does not.

Alan Stern

