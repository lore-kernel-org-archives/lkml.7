Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85612C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF082087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfEOUJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfEOUJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:09:10 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D5382084F;
        Wed, 15 May 2019 20:09:08 +0000 (UTC)
Date:   Wed, 15 May 2019 16:09:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for
 Android
Message-ID: <20190515160906.4ce25c8e@oasis.local.home>
In-Reply-To: <20190515185257.GC2888@sultan-box.localdomain>
References: <20190507021622.GA27300@sultan-box.localdomain>
        <20190507153154.GA5750@redhat.com>
        <20190507163520.GA1131@sultan-box.localdomain>
        <20190509155646.GB24526@redhat.com>
        <20190509183353.GA13018@sultan-box.localdomain>
        <20190510151024.GA21421@redhat.com>
        <20190513164555.GA30128@sultan-box.localdomain>
        <20190515145831.GD18892@redhat.com>
        <20190515172728.GA14047@sultan-box.localdomain>
        <20190515143248.17b827d0@oasis.local.home>
        <20190515185257.GC2888@sultan-box.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 11:52:57 -0700
Sultan Alsawaf <sultan@kerneltoast.com> wrote:

> On Wed, May 15, 2019 at 02:32:48PM -0400, Steven Rostedt wrote:
> > I'm confused why you did this?  
> 
> Oleg said that debug_locks_off() could've been called and thus prevented
> lockdep complaints about simple_lmk from appearing. To eliminate any possibility
> of that, I disabled debug_locks_off().

But I believe that when lockdep discovers an issue, the data from then
on is not reliable. Which is why we turn it off. But just commenting
out the disabling makes lockdep unreliable, and is not a proper way to
test your code.

Yes, it can then miss locking issues after one was discovered. Thus,
you are not properly testing the locking in your code.

-- Steve
