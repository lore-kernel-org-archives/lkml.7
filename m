Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3044CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061C620842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573406264;
	bh=X3GKgxq9GJrz0jSVY66R6tZQ5nwt+7V3Nvk35yu99rM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xF1LqnwG+pk6R8qvNmbAp08CmUT8BzaEY6MHdW78BW9gLk9PT/ooEaQvOoyo3c5eC
	 o/oyNTHGNhhh8En46ZJ8bNRvePAksDt7/Mq6NCi8vJgnUo+3jGWhhvv2AAA7KhmQN6
	 i0KUqSEWpWA4E1i05Jupn+nPIsjICD6Nav0xVS/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfKJRRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 12:17:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38567 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfKJRRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 12:17:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id w8so6673680plq.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 09:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xnLS2eoi1pQL/SWWKJ+ZWGhkul+SYeaNHpkX1daZWRw=;
        b=X9+2Kt+qYQTswByTEVn6L/1xhqVUslGS06tm6iiJbognavsZNQxs//aQwDBdNWbOCs
         /jfmzsRWrc/1zGQ+RUF8J1E+nSpfL52tbIwdQNEMGRl6yAIds78D2UHEz27vT0EeaPln
         j+vf4oypO0yGiixzuSPID5aGYoCyfXxCT49bjWC+PA9khbADleY7fY0qD8wqs15bb5bp
         S++2SahFh0WcsvgWCQM4rR1TJnyRMc1h//RZ8AGIIjLvxvravfa2BfK88H0AOTCsvecw
         eJ+1vFFXHJhO3HpSDS8ytxswX4/LeSchganWi7o2EmRkSRzc581WbzPtFNPonYgcvxzl
         DRJg==
X-Gm-Message-State: APjAAAVQhK3RjJBNUpwdaYNW/C+/PtsiOCGCzG2vdl8vkxhfiHiR/XMq
        HDtUgFkloQ1n2fhUWwphOVbUzg==
X-Google-Smtp-Source: APXvYqy8EqTUkWZZEuuBgvh3TldnuDS/6c35SOqmm0C+QjkVBLp7/IYIjHmh9uJiT8uuKuDnfwxYvQ==
X-Received: by 2002:a17:902:5a41:: with SMTP id f1mr22082396plm.168.1573406261481;
        Sun, 10 Nov 2019 09:17:41 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id h8sm17859893pjp.1.2019.11.10.09.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 09:17:40 -0800 (PST)
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.241007755@linutronix.de>
 <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
 <20191107082541.GF30739@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <54ae3c3a-f49a-f5cc-d174-de6e64afe899@kernel.org>
Date:   Sun, 10 Nov 2019 09:17:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191107082541.GF30739@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 12:25 AM, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Wed, Nov 6, 2019 at 12:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>
>>> Calculate both the position of the first zero bit and the last zero bit to
>>> limit the range which needs to be copied. This does not solve the problem
>>> when the previous tasked had only byte 0 cleared and the next one has only
>>> byte 65535 cleared, but trying to solve that would be too complex and
>>> heavyweight for the context switch path. As the ioperm() usage is very rare
>>> the case which is optimized is the single task/process which uses ioperm().
>>
>> Hmm.
>>
>> I may read this patch wrong, but from what I can tell, if we really
>> have just one process with an io bitmap, we're doing unnecessary
>> copies.
>>
>> If we really have just one process that has an iobitmap, I think we
>> could just keep the bitmap of that process entirely unchanged. Then,
>> when we switch away from it, we set the io_bitmap_base to an invalid
>> base outside the TSS segment, and when we switch back, we set it back
>> to the valid one. No actual bitmap copies at all.
>>
>> So I think that rather than the "begin/end offset" games, we should
>> perhaps have a "what was the last process that used the IO bitmap for
>> this TSS" pointer (and, I think, some sequence counter, so that when
>> the process updates its bitmap, it invalidates that case)?
>>
>>  Of course, you can do *nboth*, but if we really think that the common
>> case is "one special process", then I think the begin/end offset is
>> useless, but a "last bitmap process" would be very useful.
>>
>> Am I missing something?
> 
> In fact on SMP systems this would result in a very nice optimization: 
> pretty quickly *all* TSS's would be populated with that single task's 
> bitmap, and it would persist even across migrations from CPU to CPU.
> 
> I'd love to get rid of the offset caching and bit scanning games as well 
> - it doesn't really help in a number of common scenarios and it 
> complicates this non-trivial piece of code a *LOT* - and we probably 
> don't really have the natural testing density of this code anymore to 
> find any regressions quickly.

I think we should not over-optimize this.  I am all for penalizing
ioperm() and iopl() users as much as is convenient for us.  There is
simply no legitimate use case.  Sorry, DPDK, but "virtio-legacy sucks,
let's optimize the crap out of something that is slow anyway and use
iopl()" is not a good excuse.  Just use the %*!7 syscall to write to
/sys/.../resource0 and suck up the probably negligible performance hit.
And tell your customers to upgrade their hypervisors.  And quite
kvetching about performance of the control place on an old
software-emulated NIC while you're at it.

For the TLB case, it's worth tracking who last used which ASID and
whether it's still up to date, since *everyone* uses the MMU.  For
ioperm, I don't really believe this is worth it.

> 
> So intuitively I'd suggest we gravitate towards the simplest 
> implementation, with a good caching optimization for the single-task 
> case.

I agree with the first bit, but caching on an SMP system is necessarily
subtle.  Some kind of invalidation is needed.

> 
> I.e. the model I'm suggesting is that if a task uses ioperm() or iopl() 
> then it should have a bitmap from that point on until exit(), even if 
> it's all zeroes or all ones. Most applications that are using those 
> primitives really need it all the time and are using just a few ioports, 
> so all the tracking doesn't help much anyway.
> 
> On a related note, another simplification would be that in principle we 
> could also use just a single bitmap and emulate iopl() as an ioperm(all) 
> or ioperm(none) calls. Yeah, it's not fully ABI compatible for mixed 
> ioperm()/iopl() uses, but is that ABI actually being relied on in 
> practice?
> 

Let's please keep the ABI.  Or rather, let's attempt to eventually
remove the ABI, but let's not change it in the mean time please.
