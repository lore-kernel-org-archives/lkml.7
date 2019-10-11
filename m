Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DDDC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A56721A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="VE+8lVxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfJKI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:57:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43553 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJKI5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:57:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so10939128wrq.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=mxoi4denfFjBanodar5aeA8F5xRb+IVFF07ncuSoD20=;
        b=VE+8lVxRG2UATnor1rRNd7CkNsFD9vL27RGS9hzkLHrOLbpFXwkDl8hE4gUSxore43
         Qxyj/RLsTMnL2m5lkVxX+c+J8iSMfB3JDlgRW4Q/pFsi/W8bUs7tpCvFJH9y2S/hH4Ee
         SCfHv7HrehUBgKtRXPav7HUGswrmcSmA403TiBc2BgoewYF6K4hUNdAULyAsb/3SnW7g
         u81T2/lKzGQNZR/B25dY+CHpnhESHv4xPf+vt26LSFKOinrAOiYqTY8qsZt8gbz9F4J9
         8APpDPid1vRKNGAptVO/uPhPVQpkhCo6ZzIFTxcMWrzhJ4yS5nhooBQ1Te/oVQpOzsWg
         8rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=mxoi4denfFjBanodar5aeA8F5xRb+IVFF07ncuSoD20=;
        b=X8uOTShJbIM2SEsVsxFzWsTg8XlMfSIXpB2HJolMEmflBuzjF0LHdEoWVvXDsU7wx8
         zosmFD2bH4kghjgEjbAJXfIACcw14N3Mo1qXmZxPFcxvI54PQmx9hAidyTYNwhyyxgT7
         lheV6R5sqc1+XBMd5Hi/hiqPhTgrc15oUOrVnwsMfOEGw3NTniZhoX/3bhdHg4Vr5aJY
         SvyfMIz4YqTaflLJ+5hWKX0vXQheNXIF2uRuJbPUUQ7xeDkHvJkiEveT/v6dVLOW3K8o
         M25HeG5Lj1/0ICOCUXmRBZjPI1sglvO3DhAp0OPes8NpgwtTeUWXaqZFXNEqE7HkMPTt
         mdPw==
X-Gm-Message-State: APjAAAX+lPwJ3czDoXId4rUbRt7GjWTsDHAjhMm88rAwVnW1TAG2hisX
        MTUW8+kBcNf9fPkvHXdbJE2xNxnrKk4g0A==
X-Google-Smtp-Source: APXvYqyvUs1tjKzNTJDb+4QHaGuwWmmRABn4WjvTnAw4P7LRmy3nQF3Qdf5OkGt9YFgdlMLuVebpNA==
X-Received: by 2002:a5d:6745:: with SMTP id l5mr8677850wrw.51.1570784258135;
        Fri, 11 Oct 2019 01:57:38 -0700 (PDT)
Received: from linux.fritz.box (p200300D99705BE00E22045ECB41D901D.dip0.t-ipconnect.de. [2003:d9:9705:be00:e220:45ec:b41d:901d])
        by smtp.googlemail.com with ESMTPSA id r140sm11036455wme.47.2019.10.11.01.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 01:57:36 -0700 (PDT)
Subject: Re: wake_q memory ordering
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        1vier1@web.de, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <990690aa-8281-41da-4a46-99bb8f9fec31@colorfullife.com>
 <20191010114244.GS2311@hirez.programming.kicks-ass.net>
 <7af22b09-2ab9-78c9-3027-8281f020e2e8@colorfullife.com>
 <20191010123219.GO2328@hirez.programming.kicks-ass.net>
 <20191010192508.3yvpc5r6oqjq5tbr@linux-p48b>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <0312fc72-74f1-ea3e-8301-f94bba742735@colorfullife.com>
Date:   Fri, 11 Oct 2019 10:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010192508.3yvpc5r6oqjq5tbr@linux-p48b>
Content-Type: multipart/mixed;
 boundary="------------62DA3BF5D4ACDC7006B98085"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------62DA3BF5D4ACDC7006B98085
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davidlohr,

On 10/10/19 9:25 PM, Davidlohr Bueso wrote:
> On Thu, 10 Oct 2019, Peter Zijlstra wrote:
>
>> On Thu, Oct 10, 2019 at 02:13:47PM +0200, Manfred Spraul wrote:
>>
>>> Therefore smp_mb__{before,after}_atomic() may be combined with
>>> cmpxchg_relaxed, to form a full memory barrier, on all archs.
>>
>> Just so.
>
> We might want something like this?
>
> ----8<---------------------------------------------------------
>
> From: Davidlohr Bueso <dave@stgolabs.net>
> Subject: [PATCH] Documentation/memory-barriers.txt: Mention 
> smp_mb__{before,after}_atomic() and CAS
>
> Explicitly mention possible usages to guarantee serialization even upon
> failed cmpxchg (or similar) calls along with 
> smp_mb__{before,after}_atomic().
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> Documentation/memory-barriers.txt | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/memory-barriers.txt 
> b/Documentation/memory-barriers.txt
> index 1adbb8a371c7..5d2873d4b442 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1890,6 +1890,18 @@ There are some more advanced barrier functions:
>      This makes sure that the death mark on the object is perceived to 
> be set
>      *before* the reference counter is decremented.
>
> +     Similarly, these barriers can be used to guarantee serialization 
> for atomic
> +     RMW calls on architectures which may not imply memory barriers 
> upon failure.
> +
> +    obj->next = NULL;
> +    smp_mb__before_atomic()
> +    if (cmpxchg(&obj->ptr, NULL, val))
> +        return;
> +
> +     This makes sure that the store to the next pointer always has 
> smp_store_mb()
> +     semantics. As such, smp_mb__{before,after}_atomic() calls allow 
> optimizing
> +     the barrier usage by finer grained serialization.
> +
>      See Documentation/atomic_{t,bitops}.txt for more information.
>
>
I don't know. The new documentation would not have answered my question 
(is it ok to combine smp_mb__before_atomic() with atomic_relaxed()?). 
And it copies content already present in atomic_t.txt.

Thus: I would prefer if the first sentence of the paragraph is replaced: 
The list of operations should end with "...", and it should match what 
is in atomic_t.txt

Ok?

--

     Manfred



--------------62DA3BF5D4ACDC7006B98085
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-Documentation-memory-barriers.txt-Clarify-cmpxchg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-Documentation-memory-barriers.txt-Clarify-cmpxchg.patch"

From 8df60211228042672ba0cd89c3566c5145e8b203 Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Fri, 11 Oct 2019 10:33:26 +0200
Subject: [PATCH 4/4] Documentation/memory-barriers.txt:  Clarify cmpxchg()

The documentation in memory-barriers.txt claims that
smp_mb__{before,after}_atomic() are for atomic ops that do not return a
value.

This is misleading and doesn't match the example in atomic_t.txt,
and e.g. smp_mb__before_atomic() may and is used together with
cmpxchg_relaxed() in the wake_q code.

The purpose of e.g. smp_mb__before_atomic() is to "upgrade" a following
RMW atomic operation to a full memory barrier.
The return code of the atomic operation has no impact, so all of the
following examples are valid:

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

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 Documentation/memory-barriers.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1adbb8a371c7..52076b057400 100644
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
+     These are also used for atomic RMW bitop functions that do imply a full
+     memory barrier (such as set_bit and clear_bit).
 
      As an example, consider a piece of code that marks an object as being dead
      and then decrements the object's reference count:
-- 
2.21.0


--------------62DA3BF5D4ACDC7006B98085--
