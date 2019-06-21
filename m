Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83302C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312882089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cutYK3bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfFUXMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:12:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37960 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfFUXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:12:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so7347874ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z7H6a9bx7122AU0Rz3Jd1mJYrH5GHmxQkIx46qhAJi8=;
        b=cutYK3bz4LqR37UCsAWgVrci6+untrhnnylnM73QR5W5hmgHX6RyqMYhVDD29TVCly
         sX0Z55mTs6Ar1kP7gF5rxfOBxzyWpJMjoTTmaJHgiN5q/KCrz8fpGkQeRiU4RjbIWx66
         Izlz54YQatpYGfjVwfAESk9b6zdhQZPnGvOuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7H6a9bx7122AU0Rz3Jd1mJYrH5GHmxQkIx46qhAJi8=;
        b=ix8Wwwo+azU1IgYS3o5eG5nUsPh6AIPtRY3gw5tXRRy0OdKU11rfBMizj8uO9fcTrY
         WWrtA4UYrB7Ms54KUqr/F2IFhKkoIoAPEfuCxXKIwLfrmzZFq8Jt/dP1iaCZyAbrEe3J
         wye8bDc+1v+4bhHI8Zr9dIL5l8irwPya5G8WL0Gnsv/kDR0Yv0fwIBY+zgnicZwawtxW
         uy67nfudF0WEa5lrU0HfwVi0Uj4F6A74v9Qw1vDl51d061rKjd+wgFe9JIoBlYYZybwr
         pIqvUKHyH53qBKFtQt6jU9mk8F3F3+D55elD/e4/sONeVVV/uiL4ZvJ3Hr7YR89nrtna
         P5FA==
X-Gm-Message-State: APjAAAU+iYTe8O6ihkfSPXI9gQx+iuWmRVU4Y8YAHA+/4ywWjJdNpvCG
        33EMVvVFMMGTHBrCN+rf93t/hA==
X-Google-Smtp-Source: APXvYqyi2cFSju4ncj1izri5C0oMMkaIf3pK1nj+jYikYd0Fh4dqBETKIZZckDh2PwRyArjkBz1TqA==
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr12335414ljj.68.1561158725211;
        Fri, 21 Jun 2019 16:12:05 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id w28sm579398ljd.12.2019.06.21.16.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 16:12:03 -0700 (PDT)
Subject: Re: [PATCH 5/5] lib/list_sort: Optimize number of calls to comparison
 function
To:     George Spelvin <lkml@sdf.org>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, geert@linux-m68k.org, st5pub@yandex.ru
References: <cover.1552097842.git.lkml@sdf.org>
 <b36187f091acc1b3a8fc1fc3e9dbb6eca56231a9.1552097842.git.lkml@sdf.org>
 <dd8924c1-07a9-4317-bfa8-23271b138a62@rasmusvillemoes.dk>
 <201903140158.x2E1wgFQ018649@sdf.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ee4312b3-ed26-2a78-de26-1907c38a5e4b@rasmusvillemoes.dk>
Date:   Sat, 22 Jun 2019 01:12:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201903140158.x2E1wgFQ018649@sdf.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2019 02.58, George Spelvin wrote:
> On Thu, 14 Mar 2019 at 00:28:16 +0100, Rasmus Villemoes wrote:

>> Similarly one could do a SORT_SIMPLE_CMP() for when sorting an array of
>> structs according to a single numeric member. That sort is not stable,
>> so the comparison functions would have to do a full -1,0,1 return, of
>> course, but we'd still avoid indirect calls.
> 
> Actually, while some sorts (notably fat-pivot quicksort) require
> a 3-way return to avoid O(n^2) performance, heapsort is just fine
> with a boolean return value. 

Hi George

So I tried starting to implement this, and the timing results look
promising. However, currently I'm doing

  (*(u32*)ka > *(u32*)kb) - (*(u32*)ka < *(u32*)kb);

in my do_cmp. Both existing invocations of the comparison function in
sort.c compare its return value >= 0, which is always true if I just
return the boolean (*(u32*)ka > *(u32*)kb). So it seems the algorithm
would have to be changed to allow the cmp function to return a bool.
Perhaps it's as simple as changing the two >= to >, but can I get you to
check that that would be ok? (Quick testing seems to suggest so, but
it's possible there are some corner cases where it would break.)

Thanks,
Rasmus
