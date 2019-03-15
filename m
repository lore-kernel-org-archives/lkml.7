Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D425C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321D3218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCODQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCODQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:16:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F404321873;
        Fri, 15 Mar 2019 03:16:45 +0000 (UTC)
Date:   Thu, 14 Mar 2019 23:16:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for
 Android
Message-ID: <20190314231641.5a37932b@oasis.local.home>
In-Reply-To: <20190314204911.GA875@sultan-box.localdomain>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
        <20190311174320.GC5721@dhcp22.suse.cz>
        <20190311175800.GA5522@sultan-box.localdomain>
        <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
        <20190311204626.GA3119@sultan-box.localdomain>
        <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
        <20190312080532.GE5721@dhcp22.suse.cz>
        <20190312163741.GA2762@sultan-box.localdomain>
        <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
        <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
        <20190314204911.GA875@sultan-box.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 13:49:11 -0700
Sultan Alsawaf <sultan@kerneltoast.com> wrote:

> Perhaps I'm missing something, but if you want to know when a process has died
> after sending a SIGKILL to it, then why not just make the SIGKILL optionally
> block until the process has died completely? It'd be rather trivial to just
> store a pointer to an onstack completion inside the victim process' task_struct,
> and then complete it in free_task().

How would you implement such a method in userspace? kill() doesn't take
any parameters but the pid of the process you want to send a signal to,
and the signal to send. This would require a new system call, and be
quite a bit of work. If you can solve this with an ebpf program, I
strongly suggest you do that instead.

-- Steve
