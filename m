Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B80C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76FA2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XxqLZEba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCMX2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:28:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39580 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCMX2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:28:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so3030361edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 16:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4k6ca2BfjKX4cdU55N5XKX7uRcWT27OEntt1eDMFXwA=;
        b=XxqLZEba2eS2T7PlFU/uIcx+Ju9tR+qaVvPWHgwh92M8T1Ym4SHolBh+b5Bw8hNWn8
         v5Ggp/ELWyjkmgfJ+tbYA6pOYwaZX+jMgi6C2rbeO/CAUPAKyKUKIFrErbindmsbhGMU
         nxH5tTyXe6qZ4RKqdiPyFXIherhIybG3ZdLJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4k6ca2BfjKX4cdU55N5XKX7uRcWT27OEntt1eDMFXwA=;
        b=LE3l9hsbWMZya5yijfDxxlelHJRD32AeO5Y+1rr4kPzrdlDen/AXyyc/hrF5DM+an1
         qGb9lAqte4tTDoDWWoF5kxyNa7pAPCOtIVJat/T+oAxr1kgaVDl1FVICmBK2xJfN/M+9
         PExqbXU9wF4E/qSbLEpErO/8v13yIyQuFvgIJCYUr0tEynUqiNvIl/Q/6H5Fa2z+/dTu
         j28z4NA6OChanmcA6sgWGFFkwoBM/Cyci0ZGt5EmtWhXlqbBv7zxU7NNnie1JNzlj4jl
         aQr6vN4Hkf+bLeh8o09q65bPSToZ7OFpevQMCxgUfy4b9FIFk3d15NKvC7ehh2Ap2en3
         f5og==
X-Gm-Message-State: APjAAAU3SpHN1KFUfNI+FMMLkQPpsaHoQcwaulTx1yi9uX6bR38XjKE0
        jbqv1A1/Cw16ndaSDJ4+4v9YTg==
X-Google-Smtp-Source: APXvYqx03ESCauP2yN0WEbcB5CTLHMTOPLpZBqwMdM4lrYY56OdL/Vg25XVOp2rttjHMRa5QnQX4bw==
X-Received: by 2002:a17:906:3c5:: with SMTP id c5mr30767697eja.24.1552519698668;
        Wed, 13 Mar 2019 16:28:18 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id o8sm735964eju.0.2019.03.13.16.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 16:28:18 -0700 (PDT)
Subject: Re: [PATCH 5/5] lib/list_sort: Optimize number of calls to comparison
 function
To:     George Spelvin <lkml@sdf.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
 <b36187f091acc1b3a8fc1fc3e9dbb6eca56231a9.1552097842.git.lkml@sdf.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <dd8924c1-07a9-4317-bfa8-23271b138a62@rasmusvillemoes.dk>
Date:   Thu, 14 Mar 2019 00:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b36187f091acc1b3a8fc1fc3e9dbb6eca56231a9.1552097842.git.lkml@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2019 06.58, George Spelvin wrote:
> CONFIG_RETPOLINE has severely degraded indirect function call
> performance, so it's worth putting some effort into reducing
> the number of times cmp() is called.
> 
> This patch avoids badly unbalanced merges on unlucky input sizes.
> It slightly increases the code size, but saves an average of 0.2*n
> calls to cmp().
> 
[snip]
> 
> (I confess to being more than a little bit proud of how clean this
> code turned out.  It took a lot of thinking, but the resultant inner
> loop is very simple and efficient.)
> 
> Refs:
>   Bottom-up Mergesort: A Detailed Analysis
>   Wolfgang Panny, Helmut Prodinger
>   Algorithmica 14(4):340--354, October 1995
>   https://doi.org/10.1007/BF01294131
>   https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.6.5260
> 
>   The cost distribution of queue-mergesort, optimal mergesorts, and
>   power-of-two rules
>   Wei-Mei Chen, Hsien-Kuei Hwang, Gen-Huey Chen
>   Journal of Algorithms 30(2); Pages 423--448, February 1999
>   https://doi.org/10.1006/jagm.1998.0986
>   https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.4.5380
> 
>   Queue-Mergesort
>   Mordecai J. Golin, Robert Sedgewick
>   Information Processing Letters, 48(5):253--259, 10 December 1993
>   https://doi.org/10.1016/0020-0190(93)90088-q
>   https://sci-hub.tw/10.1016/0020-0190(93)90088-Q

This is beautiful. So no comments on the patch itself. One thing that
might be nice would be to see the reduction in number of cmp callbacks
explicitly; it should be trivial to use the priv element for that in the
list_sort_test module. But to really see it one would of course have to
extend that test to do a lot more different sizes of lists.

And looking at the actual cmp functions used made me think we might do
something similar to what you did for the swap functions for sort(),
though it will require updating call sites. Suppose we have some

struct foo {
   ...
   struct list_head list;
   ...
   some_integer_type key;
   ...
};

and a trivial cmp function that just compares the ->key members. What if
we do something like

#define LIST_SORT_SIMPLE_CMP(type, list, key) ({ \
  /* encode the size and signedness of type.key along with
   offsetof(type, key) - offsetof(type, list) into the low, say,
   24 bits - a signed 20 bit number should be sufficient for the
   offsetof diff, and we can bail at compile time if too big */
})

then do

int do_cmp(void *priv, list_head *a, list_head *b, cmp_func cmp)
{
   if ((long)cmp & high_bits) /* it's a kernel pointer */
      return cmp(priv, a, b);
   int diff = extract_diff(cmp);
   int type = extract_type(cmp);
   void *keya = (void*)a + diff;
   void *keyb = (void*)b + diff;
   if (type == s32)
      return *(s32*)keya > *(s32*)keyb;
   if (type == u32)
       return *(u32*)keya > *(u32*)keyb;
   ...

in practice, we'd probably only have to support 4- and 8-byte signed and
unsigned versions (and we can check at compile time whether key has a
supported type).

Similarly one could do a SORT_SIMPLE_CMP() for when sorting an array of
structs according to a single numeric member. That sort is not stable,
so the comparison functions would have to do a full -1,0,1 return, of
course, but we'd still avoid indirect calls.

Rasmus
