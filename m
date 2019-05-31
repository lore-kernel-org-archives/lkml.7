Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B808DC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CB526830
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfEaLYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 07:24:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:51782 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbfEaLYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:24:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC738ACF5;
        Fri, 31 May 2019 11:24:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 13:24:07 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
In-Reply-To: <20190531095549.GB17637@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095549.GB17637@hirez.programming.kicks-ass.net>
Message-ID: <7187263bcee61b9abbe687f3a7478bd1@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-31 11:55, Peter Zijlstra wrote:
> On Thu, May 16, 2019 at 10:58:03AM +0200, Roman Penyaev wrote:
>> +#define atomic_set_unless_zero(ptr, flags)			\
>> +({								\
>> +	typeof(ptr) _ptr = (ptr);				\
>> +	typeof(flags) _flags = (flags);				\
>> +	typeof(*_ptr) _old, _val = READ_ONCE(*_ptr);		\
>> +								\
>> +	for (;;) {						\
>> +		if (!_val)					\
>> +			break;					\
>> +		_old = cmpxchg(_ptr, _val, _flags);		\
>> +		if (_old == _val)				\
>> +			break;					\
>> +		_val = _old;					\
>> +	}							\
>> +	_val;							\
>> +})
> 
>> +#define atomic_or_with_mask(ptr, flags, mask)			\
>> +({								\
>> +	typeof(ptr) _ptr = (ptr);				\
>> +	typeof(flags) _flags = (flags);				\
>> +	typeof(flags) _mask = (mask);				\
>> +	typeof(*_ptr) _old, _new, _val = READ_ONCE(*_ptr);	\
>> +								\
>> +	for (;;) {						\
>> +		_new = (_val & ~_mask) | _flags;		\
>> +		_old = cmpxchg(_ptr, _val, _new);		\
>> +		if (_old == _val)				\
>> +			break;					\
>> +		_val = _old;					\
>> +	}							\
>> +	_val;							\
>> +})
> 
> Don't call them atomic_*() if they're not part of the atomic_t
> interface.

Can we add those two?  Or keep it local is better?

--
Roman



