Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E235C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D4C20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfDDHqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:46:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43747 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:46:00 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hBx4N-0000LU-0T; Thu, 04 Apr 2019 09:45:55 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH] sched: Document that RT task priorities are
 =?utf-8?Q?1=E2=80=A699?=
References: <20190403210821.10916-1-bigeasy@linutronix.de>
        <87sguypz3z.fsf@linutronix.de>
Date:   Thu, 04 Apr 2019 09:45:53 +0200
In-Reply-To: <87sguypz3z.fsf@linutronix.de> (John Ogness's message of "Wed, 03
        Apr 2019 23:17:52 +0200")
Message-ID: <87o95m8b7y.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-03, John Ogness <john.ogness@linutronix.de> wrote:
> IMHO it is a bit crazy that userspace RT prio 99 maps to kernel prio
> 0. This leaves a hole at kernel prio 99. Wouldn't it be better just to
> map userspace RT prio 1-99 to kernel prio 99-1?

FWIW, the current mapping:

    userspace         kernel
    ---------         ------
    rt 1...99         98...0
    nice -20...+19    100...139

has been in place since the introduction of Ingo's scalable scheduler:

Author: linus1 <torvalds@athlon.transmeta.com>
Date:   Sun Dec 16 12:00:00 2001 -0800

    v2.5.1.9 -> v2.5.1.10
    
    - Kai Germaschewski: ISDN updates
    - Al Viro: start moving buffer cache indexing to "struct
    - block_device *"
    - Greg KH: USB update
    - Russell King: fix up some ARM merge issues
    - Ingo Molnar: scalable scheduler

With that commit, the then separate nice and rt_priority task_struct
fields were combined to the new prio field, and thus the mapping was
born.

John Ogness
