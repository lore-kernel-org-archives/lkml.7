Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59813C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269DE206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfHFG0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:26:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34130 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbfHFG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:26:46 -0400
Received: from localhost (unknown [IPv6:2804:431:c7f4:594:fd52:920a:1b6d:89c5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 71D7728A74B;
        Tue,  6 Aug 2019 07:26:44 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Zebediah Figura <z.figura12@gmail.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        viro@zeniv.linux.org.uk, jannh@google.com
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of several futexes
Organization: Collabora
References: <20190730220602.28781-1-krisman@collabora.com>
        <20190730220602.28781-2-krisman@collabora.com>
        <20190731120600.GT31381@hirez.programming.kicks-ass.net>
Date:   Tue, 06 Aug 2019 02:26:38 -0400
In-Reply-To: <20190731120600.GT31381@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 31 Jul 2019 14:06:00 +0200")
Message-ID: <85imra6c81.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

>
>> +static int futex_wait_multiple(u32 __user *uaddr, unsigned int flags,
>> +			       u32 count, ktime_t *abs_time)
>> +{
>> +	struct futex_wait_block *wb;
>> +	struct restart_block *restart;
>> +	int ret;
>> +
>> +	if (!count)
>> +		return -EINVAL;
>> +
>> +	wb = kcalloc(count, sizeof(struct futex_wait_block), GFP_KERNEL);
>> +	if (!wb)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(wb, uaddr,
>> +			   count * sizeof(struct futex_wait_block))) {
>> +		ret = -EFAULT;
>> +		goto out;
>> +	}
>
> I'm thinking we can do away with this giant copy and do it one at a time
> from the other function, just extend the storage allocated there to
> store whatever values are still required later.

Hey Peter,

Thanks for your very detailed review.  it is deeply appreciated.  My
apologies for the style issues, I blindly trusted checkpatch.pl, when it
said it was ready for submission.

I'm not sure I get the suggestion here.  If I understand the code
correctly, once we do it one at a time, we need to queue_me() each futex
and then drop the hb lock, before going to the next one.  Once we go to
the next one, we need to call get_user_pages (and now copy_from_user),
both of which can sleep, and on return set the task state to
TASK_RUNNING.  This opens a window where we can wake up the task but it
is not in the right sleeping state, which from the comment in
futex_wait_queue_me(), seems problematic.  This is also the reason why I
wanted to split the key memory pin from the actual read in patch 1/2.

Did you consider this problem or is it not a problem for some reason?
What am I missing?

-- 
Gabriel Krisman Bertazi
