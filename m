Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E9C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9213E2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="G7jIupr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbfKFTXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:23:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32806 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732612AbfKFTXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:23:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id w30so4706095wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=DY50EUrE+zr/6pmyQoV/OlDlyIr6dh7fVbpsOXhbzB8=;
        b=G7jIupr+dTUdzgGZqcLx2YK09iqFHgOFUg3zuVjtfd8JLezsR+XcMT4lYxlB+a1NEr
         45vMz6QChH9yep8dDz3U8tPQV4o3K05PkoNyUuEn+TeYC2+TyocG4IxmMEzCAeQ/2/z0
         WAX3hSpuRQW78Uy4D73FI+GTb7/y9YThCpvUCc++oaGXDwBdACz9pIwHVmYWQi+lvlKr
         L1yOY2f1k3uEtObTLpkWq4u6WsaHKUrcmCk97RfUDw+ifl21l8SFdE58RsiAxCrocRfT
         E/UcctTDvQb7V97/ipBLPsrFaOaTnKUBSxSpKYdR1X2EuitEoDct/NGqEHCMd0v96lDW
         3bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=DY50EUrE+zr/6pmyQoV/OlDlyIr6dh7fVbpsOXhbzB8=;
        b=mOQ3qyIbg/pWF9TinaRtiQANpl1kehsrQ9mvpz8U1BoB7jEI16FvDlr1VprZPPrSWC
         Ne5ZUcyYAAx6QA61FG6u0ce4dRaGRnbPpFrYZYsjSUXfCw2LloIDF1dY+Cvj7ryL420n
         C2/fA1ie7uT6vaYy2fKOzsmI8gTOTxjk+s2nmOlGd5JePIMtRsWf7eM/0q69p+r5Bte9
         7Trw6GGNjeRM+wwaXrz94w3Ml+9B3psgTjKR//282u9OXlC6soe9eur2o6hO/1oAkUvv
         i5wrqFG/dBdgpgaAwvRyNe0p2bhEj/YofGExlvQYeziogeZc4HIQKrO15qep8BuZDvUA
         gWZA==
X-Gm-Message-State: APjAAAVfUojn1HkAxmgYOHaFK4QElSb59MP6ka8NMn0gKcPARo1nYQYX
        PxQIRW9CAtymawK9vuDIdcayGg==
X-Google-Smtp-Source: APXvYqzWaEkun2jf8w1KYtk7e2m3ORM0jmn3HX45C5vDQV1f/+LDbLDaXRqrqz3a4MeuReatYT3SkA==
X-Received: by 2002:adf:f447:: with SMTP id f7mr4085308wrp.210.1573068188018;
        Wed, 06 Nov 2019 11:23:08 -0800 (PST)
Received: from linux.fritz.box (p200300D99704F800FD1B6A1FC9C62083.dip0.t-ipconnect.de. [2003:d9:9704:f800:fd1b:6a1f:c9c6:2083])
        by smtp.googlemail.com with ESMTPSA id r3sm48303904wre.29.2019.11.06.11.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 11:23:06 -0800 (PST)
Subject: Re: [PATCH 1/5] smp_mb__{before,after}_atomic(): Update Documentation
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
References: <20191020123305.14715-1-manfred@colorfullife.com>
 <20191020123305.14715-2-manfred@colorfullife.com>
 <20191101164948.GD3603@willie-the-truck>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <65a187c2-80de-2c6f-5f80-48c51f973d08@colorfullife.com>
Date:   Wed, 6 Nov 2019 20:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101164948.GD3603@willie-the-truck>
Content-Type: multipart/mixed;
 boundary="------------C0D35D7ED75CE9EAD8BE1EE7"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C0D35D7ED75CE9EAD8BE1EE7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Will,

On 11/1/19 5:49 PM, Will Deacon wrote:
> Hi Manfred,
>
> On Sun, Oct 20, 2019 at 02:33:01PM +0200, Manfred Spraul wrote:
>> When adding the _{acquire|release|relaxed}() variants of some atomic
>> operations, it was forgotten to update Documentation/memory_barrier.txt:
>>
>> smp_mb__{before,after}_atomic() is now intended for all RMW operations
>> that do not imply a memory barrier.
> [...]
>
> Although I think this is correct, I really think we should instead refer to
> Documentation/atomic_t.txt and get rid of this out of memory-barriers.txt
> entirely. It's just duplication and is out of date.

So you would prefer the attached patch?

For me this would be fine, too.


--

     Manfred


--------------C0D35D7ED75CE9EAD8BE1EE7
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-smp_mb__-before-after-_atomic-Update-Documentation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-smp_mb__-before-after-_atomic-Update-Documentation.patc";
 filename*1="h"

From 8d2b219794221e3ef1a1ec90e0f4fe344af9a55d Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Fri, 11 Oct 2019 10:33:26 +0200
Subject: [PATCH 1/5] smp_mb__{before,after}_atomic(): Update Documentation

When adding the _{acquire|release|relaxed}() variants of some atomic
operations, it was forgotten to update Documentation/memory_barrier.txt:

smp_mb__before_atomic and smp_mb__after_atomic can be combined with
all RMW operations that do not imply memory barriers.

In order to avoid that this happens again:
Remove the paragraph from Documentation/memory_barrier.txt, the functions
are sufficiently documented in Documentation/atomic_{t,bitops}.txt

Fixes: 654672d4ba1a ("locking/atomics: Add _{acquire|release|relaxed}() variants of some atomic operations")

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/memory-barriers.txt | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1adbb8a371c7..16dfb4cde1e1 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1873,25 +1873,7 @@ There are some more advanced barrier functions:
  (*) smp_mb__before_atomic();
  (*) smp_mb__after_atomic();
 
-     These are for use with atomic (such as add, subtract, increment and
-     decrement) functions that don't return a value, especially when used for
-     reference counting.  These functions do not imply memory barriers.
-
-     These are also used for atomic bitop functions that do not return a
-     value (such as set_bit and clear_bit).
-
-     As an example, consider a piece of code that marks an object as being dead
-     and then decrements the object's reference count:
-
-	obj->dead = 1;
-	smp_mb__before_atomic();
-	atomic_dec(&obj->ref_count);
-
-     This makes sure that the death mark on the object is perceived to be set
-     *before* the reference counter is decremented.
-
-     See Documentation/atomic_{t,bitops}.txt for more information.
-
+     See Documentation/atomic_{t,bitops}.txt for information.
 
  (*) dma_wmb();
  (*) dma_rmb();
-- 
2.23.0


--------------C0D35D7ED75CE9EAD8BE1EE7--
