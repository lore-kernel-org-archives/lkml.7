Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBD9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F043E206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404032AbfIEVKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:10:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44656 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfIEVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:10:55 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i5z1Z-00024X-Hf; Thu, 05 Sep 2019 23:10:37 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "contact\@linuxplumbersconf.org" <contact@linuxplumbersconf.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
        <20190905121101.60c78422@oasis.local.home>
Date:   Thu, 05 Sep 2019 23:10:34 +0200
In-Reply-To: <20190905121101.60c78422@oasis.local.home> (Steven Rostedt's
        message of "Thu, 5 Sep 2019 12:11:01 -0400")
Message-ID: <87ef0u4fg5.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-05, Steven Rostedt <rostedt@goodmis.org> wrote:
>>> But per the above argument of needing the CPU serialization
>>> _anyway_, I don't see a compelling reason not to use it.
>>> 
>>> It is simple, it works. Let's use it.
>>> 
>>> If you really fancy a multi-writer buffer, you can always switch to
>>> one later, if you can convince someone it actually brings benefits
>>> and not just head-aches.
>> 
>> Can we please grab one of the TBD slots at kernel summit next week,
>> sit down in a room and hash that out?
>>
>
> We should definitely be able to find a room that will be available
> next week.

FWIW, on Monday at 12:45 I am giving a talk[0] on the printk
rework. I'll be dedicating a few slides to presenting the lockless
multi-writer design, but will also talk about the serialized CPU
approach from RFCv1.

John Ogness

[0] https://www.linuxplumbersconf.org/event/4/contributions/290/
