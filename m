Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AC4C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07DE2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfENQo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfENQo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:44:56 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D709B2084F;
        Tue, 14 May 2019 16:44:54 +0000 (UTC)
Date:   Tue, 14 May 2019 12:44:53 -0400
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
Message-ID: <20190514124453.6fb1095d@oasis.local.home>
In-Reply-To: <20190513164555.GA30128@sultan-box.localdomain>
References: <20190319221415.baov7x6zoz7hvsno@brauner.io>
        <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
        <20190319231020.tdcttojlbmx57gke@brauner.io>
        <20190320015249.GC129907@google.com>
        <20190507021622.GA27300@sultan-box.localdomain>
        <20190507153154.GA5750@redhat.com>
        <20190507163520.GA1131@sultan-box.localdomain>
        <20190509155646.GB24526@redhat.com>
        <20190509183353.GA13018@sultan-box.localdomain>
        <20190510151024.GA21421@redhat.com>
        <20190513164555.GA30128@sultan-box.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 09:45:55 -0700
Sultan Alsawaf <sultan@kerneltoast.com> wrote:

> On Fri, May 10, 2019 at 05:10:25PM +0200, Oleg Nesterov wrote:
> > I am starting to think I am ;)
> > 
> > If you have task1 != task2 this code
> > 
> > 	task_lock(task1);
> > 	task_lock(task2);
> > 
> > should trigger print_deadlock_bug(), task1->alloc_lock and task2->alloc_lock are
> > the "same" lock from lockdep pov, held_lock's will have the same hlock_class().  

OK, this has gotten my attention.

This thread is quite long, do you have a git repo I can look at, and
also where is the first task_lock() taken before the
find_lock_task_mm()?

-- Steve

