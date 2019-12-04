Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F028FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42FB2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfLDN3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:29:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfLDN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:29:07 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1icUi2-0000ZT-Cy; Wed, 04 Dec 2019 14:28:50 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 2/3] printk-rb: new printk ringbuffer implementation (reader)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191128015235.12940-3-john.ogness@linutronix.de>
        <20191203120622.zux33do54rmjafns@pathway.suse.cz>
        <87pnh5bjz4.fsf@linutronix.de>
        <20191204125450.ob5b7xi3gevor4qz@pathway.suse.cz>
Date:   Wed, 04 Dec 2019 14:28:48 +0100
In-Reply-To: <20191204125450.ob5b7xi3gevor4qz@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 4 Dec 2019 13:54:50 +0100")
Message-ID: <87a788fcdr.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-04, Petr Mladek <pmladek@suse.com> wrote:
>> +	} else if ((DATA_WRAPS(data_ring, blk_lpos->begin) + 1 ==
>> +		    DATA_WRAPS(data_ring, blk_lpos->next)) ||
>> +		   ((DATA_WRAPS(data_ring, blk_lpos->begin) ==
>> +		     DATA_WRAPS(data_ring, -1UL)) &&
>> +		    (DATA_WRAPS(data_ring, blk_lpos->next) == 0))) {
>
> I wonder if the following might be easier to understand even for
> people like me ;-)
>
> 	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
> 		    DATA_WRAPS(data_ring, blk_lpos->next)) {

Yes, this is clear and covers both cases. Thanks.

John
