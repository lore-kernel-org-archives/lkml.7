Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E29C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C4F20659
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbfJDOsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388870AbfJDOs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:48:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49FF318C4298;
        Fri,  4 Oct 2019 14:48:29 +0000 (UTC)
Received: from [10.3.112.17] (ovpn-112-17.phx2.redhat.com [10.3.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAF9360C80;
        Fri,  4 Oct 2019 14:48:25 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: Re: printk meeting at LPC
To:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        David Lehman <dlehman@redhat.com>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
From:   Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <30f29fe6-8445-0016-8cdc-3ef99d43fbf5@redhat.com>
Date:   Fri, 4 Oct 2019 09:48:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87k1acz5rx.fsf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 04 Oct 2019 14:48:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/19 8:26 AM, John Ogness wrote:
> 9. Support for printk dictionaries will be discontinued. I will look
> into who is using this and why. If printk dictionaries are important for
> you, speak up now!

I think this functionality is important.

I've been experimenting with a change which adds dictionary data to
storage related printk messages so that a persistent durable id is
associated with them for filtering, eg.

$ journalctl -r _KERNEL_DURABLE_NAME=naa.0000000000bc614e

This has the advantage that when the device attachment changes across
reboots or detach/reattach cycles you can easily find its messages
throughout it's recorded history.

Other reasons were outlined when introduced, ref.
https://lwn.net/Articles/490690/

I believe this functionality hasn't been leveraged to its full potential
yet.

-Tony
