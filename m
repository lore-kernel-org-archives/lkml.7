Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93AEECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C06920873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="yyCN8RMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfJNRuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:50:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40187 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731410AbfJNRuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:50:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so17602322wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=bTFNyHkPz+Jwl3rpEjPqkoqV/N+eKEiD7jH9dC0beRs=;
        b=yyCN8RMBnXri8Iwn/EJ96jhkdgP71gRzLQGt+dx31aTdIyQ+J+RfDl1CbxgA3lC68Q
         Za0aR0nB2h8birBcqmOzIngFCeDLYeSccyMTukON1rKfZLLXwhdRuaIW1pTnNVtypYmP
         yViXRjlACykspKef5Uhz93PV724unhEuJDQZSCqGN0BGK9AhyNPCtrkl7TgbP41+X2dN
         HEF2W3PrYdQdhKmtlZjdDfDPJzrZIpkubahClNjo8m58RgrjzepgN3fVtos3V1E8xPJu
         Mu4jCoMMWwd8pvjwpGP1qYj637QB/QYsRFz80tOgztuhRNILeayg2DfvH/Fi02MlFHxV
         PicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=bTFNyHkPz+Jwl3rpEjPqkoqV/N+eKEiD7jH9dC0beRs=;
        b=H+s3Wba5zqilMJkI063FWVXHxEGY+63GgroX0zI45tol7gpHr+S94VPOLKMbTBzyq8
         qe/tL1+nUmR/vmXslcuLWB5pyxknGYSF9mK9RHUwRRFTv9I9082s12aWHM/IT0rZ+Y62
         RtnSTFxqSCa5MHYijSlZVxQ8qUpQfh0djnTI761p9amkpQBZjUJIaQC0bRTNOJ59OPZx
         8oSayVfCvp614jeUq7vntS4yBrUPxVk6AOWfC3iepJcsmeXvM79CsimF2vdIcTr/R2qu
         FKX4yA7FJWJx4PhrsX0K7x130h3k8nTu2zKolMVP0B5QuMDOwjQHCZRYq9tZbGltNX7v
         jtQA==
X-Gm-Message-State: APjAAAUQkCKwcTexEcdwYSiMh0RjklpJQB5HyuyiWrtZyF8z/p6QKcOG
        BigFLxgFX7v0IZWKUFQm3ouSmIptrtl4GQ==
X-Google-Smtp-Source: APXvYqwywCupG0hVRyvCuCldRQPlpjiuUUfck2paqF9D/9JEze8r2+SNBN6tIxjNNB2XFJteceKOzQ==
X-Received: by 2002:a05:600c:2489:: with SMTP id 9mr15954087wms.131.1571075398795;
        Mon, 14 Oct 2019 10:49:58 -0700 (PDT)
Received: from linux.fritz.box (p200300D997049C00EA2FE58343581C38.dip0.t-ipconnect.de. [2003:d9:9704:9c00:ea2f:e583:4358:1c38])
        by smtp.googlemail.com with ESMTPSA id z13sm16906346wrq.51.2019.10.14.10.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 10:49:57 -0700 (PDT)
Subject: Re: [PATCH 6/6] Documentation/memory-barriers.txt: Clarify cmpxchg()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-7-manfred@colorfullife.com>
 <20191014130321.GG2328@hirez.programming.kicks-ass.net>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <ef45c2ca-942a-df83-22cf-690eaf761fb7@colorfullife.com>
Date:   Mon, 14 Oct 2019 19:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014130321.GG2328@hirez.programming.kicks-ass.net>
Content-Type: multipart/mixed;
 boundary="------------F2AD487ABA0A95F91646822E"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F2AD487ABA0A95F91646822E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Peter,

On 10/14/19 3:03 PM, Peter Zijlstra wrote:
> On Sat, Oct 12, 2019 at 07:49:58AM +0200, Manfred Spraul wrote:
>> The documentation in memory-barriers.txt claims that
>> smp_mb__{before,after}_atomic() are for atomic ops that do not return a
>> value.
>>
>> This is misleading and doesn't match the example in atomic_t.txt,
>> and e.g. smp_mb__before_atomic() may and is used together with
>> cmpxchg_relaxed() in the wake_q code.
>>
>> The purpose of e.g. smp_mb__before_atomic() is to "upgrade" a following
>> RMW atomic operation to a full memory barrier.
>> The return code of the atomic operation has no impact, so all of the
>> following examples are valid:
> The value return of atomic ops is relevant in so far that
> (traditionally) all value returning atomic ops already implied full
> barriers. That of course changed when we added
> _release/_acquire/_relaxed variants.
I've updated the Change description accordingly
>> 1)
>> 	smp_mb__before_atomic();
>> 	atomic_add();
>>
>> 2)
>> 	smp_mb__before_atomic();
>> 	atomic_xchg_relaxed();
>>
>> 3)
>> 	smp_mb__before_atomic();
>> 	atomic_fetch_add_relaxed();
>>
>> Invalid would be:
>> 	smp_mb__before_atomic();
>> 	atomic_set();
>>
>> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>> Cc: Waiman Long <longman@redhat.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> ---
>>   Documentation/memory-barriers.txt | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
>> index 1adbb8a371c7..52076b057400 100644
>> --- a/Documentation/memory-barriers.txt
>> +++ b/Documentation/memory-barriers.txt
>> @@ -1873,12 +1873,13 @@ There are some more advanced barrier functions:
>>    (*) smp_mb__before_atomic();
>>    (*) smp_mb__after_atomic();
>>   
>> -     These are for use with atomic (such as add, subtract, increment and
>> -     decrement) functions that don't return a value, especially when used for
>> -     reference counting.  These functions do not imply memory barriers.
>> +     These are for use with atomic RMW functions (such as add, subtract,
>> +     increment, decrement, failed conditional operations, ...) that do
>> +     not imply memory barriers, but where the code needs a memory barrier,
>> +     for example when used for reference counting.
>>   
>> -     These are also used for atomic bitop functions that do not return a
>> -     value (such as set_bit and clear_bit).
>> +     These are also used for atomic RMW bitop functions that do imply a full
> s/do/do not/ ?
Sorry, yes, of course
>> +     memory barrier (such as set_bit and clear_bit).



--------------F2AD487ABA0A95F91646822E
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Update-Documentation-for-_-acquire-release-relaxed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Update-Documentation-for-_-acquire-release-relaxed.patc";
 filename*1="h"

From 61c85a56994e32ea393af9debef4cccd9cd24abd Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Fri, 11 Oct 2019 10:33:26 +0200
Subject: [PATCH] Update Documentation for _{acquire|release|relaxed}()

When adding the _{acquire|release|relaxed}() variants of some atomic
operations, it was forgotten to update Documentation/memory_barrier.txt:

smp_mb__{before,after}_atomic() is now indended for all RMW operations
that do not imply a full memory barrier.

1)
	smp_mb__before_atomic();
	atomic_add();

2)
	smp_mb__before_atomic();
	atomic_xchg_relaxed();

3)
	smp_mb__before_atomic();
	atomic_fetch_add_relaxed();

Invalid would be:
	smp_mb__before_atomic();
	atomic_set();

Fixes: 654672d4ba1a ("locking/atomics: Add _{acquire|release|relaxed}() variants of some atomic operations")

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/memory-barriers.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1adbb8a371c7..08090eea3751 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1873,12 +1873,13 @@ There are some more advanced barrier functions:
  (*) smp_mb__before_atomic();
  (*) smp_mb__after_atomic();
 
-     These are for use with atomic (such as add, subtract, increment and
-     decrement) functions that don't return a value, especially when used for
-     reference counting.  These functions do not imply memory barriers.
+     These are for use with atomic RMW functions (such as add, subtract,
+     increment, decrement, failed conditional operations, ...) that do
+     not imply memory barriers, but where the code needs a memory barrier,
+     for example when used for reference counting.
 
-     These are also used for atomic bitop functions that do not return a
-     value (such as set_bit and clear_bit).
+     These are also used for atomic RMW bitop functions that do not imply a
+     full memory barrier (such as set_bit and clear_bit).
 
      As an example, consider a piece of code that marks an object as being dead
      and then decrements the object's reference count:
-- 
2.21.0


--------------F2AD487ABA0A95F91646822E--
