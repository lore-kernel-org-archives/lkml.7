Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF0AC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75CE206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 09:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rgHqjeZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfJLJzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 05:55:10 -0400
Received: from ozlabs.org ([203.11.71.1]:37475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJLJzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 05:55:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46r0YH20tjz9sCJ;
        Sat, 12 Oct 2019 20:54:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1570874106;
        bh=gitl9Ly7IJ3RmG59g8/jT+1C3P6uDftGAFdch/4phfU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rgHqjeZS2hPQsdjtZUHFwEWSsNWY19FVwZPa5wc1BMUi5fTbSJQ58oJFElt3jNER5
         Fza9f20Q3OQ7yDUUEf1gRxG82fOsb/I7R2oujAhvk+UFPKZhSIpQ5rZDxRGOS52Ktq
         HSGCr6zYPFMgXTpFfUkaRh7pZOkqpu7qk3WQF+6fhDanNT/deFaaeWmRO6364N6Ngh
         d0Vq0PMkeVQhty3D2FmeOW5L/39wplH/LFkqctUwDmAFa6tsDzNBg9DN2eBzB8FNjw
         ya/k/qd5hu8R4FBI7HP03oRkFR4KyhxhjnY50DkUg9SOvwN9o4ze7FrePbQMmIFBUL
         ADzA1VhL35nBg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, christian@brauner.io, keescook@chromium.org,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Avoid soft lockups in test_check_nonzero_user()
In-Reply-To: <20191011034810.xkmz3e4l5ezxvq57@yavin.dot.cyphar.com>
References: <20191010114007.o3bygjf4jlfk242e@yavin.dot.cyphar.com> <20191011022447.24249-1-mpe@ellerman.id.au> <20191011034810.xkmz3e4l5ezxvq57@yavin.dot.cyphar.com>
Date:   Sat, 12 Oct 2019 20:54:51 +1100
Message-ID: <87tv8euw44.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> writes:
> On 2019-10-11, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> On a machine with a 64K PAGE_SIZE, the nested for loops in
>> test_check_nonzero_user() can lead to soft lockups, eg:
...
>> diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
>> index 950ee88cd6ac..9fb6bc609d4c 100644
>> --- a/lib/test_user_copy.c
>> +++ b/lib/test_user_copy.c
>> @@ -47,9 +47,26 @@ static bool is_zeroed(void *from, size_t size)
>>  static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
>>  {
>>  	int ret = 0;
>> -	size_t start, end, i;
>> -	size_t zero_start = size / 4;
>> -	size_t zero_end = size - zero_start;
>> +	size_t start, end, i, zero_start, zero_end;
>> +
>> +	if (test(size < 1024, "buffer too small"))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * We want to cross a page boundary to exercise the code more
>> +	 * effectively. We assume the buffer we're passed has a page boundary at
>> +	 * size / 2. We also don't want to make the size we scan too large,
>> +	 * otherwise the test can take a long time and cause soft lockups. So
>> +	 * scan a 1024 byte region across the page boundary.
>> +	 */
>> +	start = size / 2 - 512;
>> +	size = 1024;
>
> I don't think it's necessary to do "size / 2" here -- you can just use
> PAGE_SIZE directly and check above that "size == 2*PAGE_SIZE" (not that
> this check is exceptionally necessary -- since there's only one caller
> of this function and it's in the same file).

OK, like this?

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 950ee88cd6ac..48bc669b2549 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -47,9 +47,25 @@ static bool is_zeroed(void *from, size_t size)
 static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
 {
 	int ret = 0;
-	size_t start, end, i;
-	size_t zero_start = size / 4;
-	size_t zero_end = size - zero_start;
+	size_t start, end, i, zero_start, zero_end;
+
+	if (test(size < 2 * PAGE_SIZE, "buffer too small"))
+		return -EINVAL;
+
+	/*
+	 * We want to cross a page boundary to exercise the code more
+	 * effectively. We also don't want to make the size we scan too large,
+	 * otherwise the test can take a long time and cause soft lockups. So
+	 * scan a 1024 byte region across the page boundary.
+	 */
+	size = 1024;
+	start = PAGE_SIZE - (size / 2);
+
+	kmem += start;
+	umem += start;
+
+	zero_start = size / 4;
+	zero_end = size - zero_start;
 
 	/*
 	 * We conduct a series of check_nonzero_user() tests on a block of memory

cheers
