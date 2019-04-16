Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7728920872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT0gkDbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfDPRBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:01:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33576 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPRBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:01:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so10647549pgh.0;
        Tue, 16 Apr 2019 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRSl5HqtbCY/bYJjFaOwZj38smJrKw+9HQAyUQ/emuI=;
        b=VT0gkDbn6XmX7qTld7SsAvpONdiTVZ6JBtMsATdQjSeJ+F2RGkwjUtU5Q4bvhzEgc/
         eDi+6ft0wsJg5eVsOcESdy1rWoeevEXynkYPmVlawNaTx6fETsbQzGQsM4wWehUzL7+x
         Vke22eFdhPK1tlBBh7rYwWXQREDTfhIYI+Etm8SuVUNk7y/4swAu8QjCt3ItGdDqpfcS
         sVmPH3N9+WileGplsUrA/9sY3VLihwFQGOH7yw+e2jO+3sgw9z7MoSmYVcrTP/C+a8vj
         qyiv/kf49ecRDUtbil8BAUkH5YrZXEXVHXQJPJJjBjZLwen2VAvDz0TIuIyTz7+Q38uk
         1IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRSl5HqtbCY/bYJjFaOwZj38smJrKw+9HQAyUQ/emuI=;
        b=mBcXEkU6d1np3U9MfQSBi2uk9PSCBaU4JUgm4yU/48rQwwGlaEkC6EEnedfE03g6oO
         xDOlnr4mSMXe3vOYpEJ0Rr0EzYM2NKTAbe7IWqlajI1tITv5aTf4BZ8sX6W819sI3Dny
         4uGCJB0gQKaONvCCn3bI4+0kqU3XFeomyGnatTJdS0+jt7IdW169XWE2g6EItDxB4gsG
         qbJ17171G/NTO7SrdOiodhQF8RU83TXJz7EHQCZVdLhHVaTx6fr7toIPpZPAAz+oBisB
         Ejjf5TosSkoCzTzJmoEmGALO+Tb4OJjbN3y7QLE7NDiKyIvCeISINXmGu5dbJvjaYEdI
         djbw==
X-Gm-Message-State: APjAAAVEG8UT8zkshOF0jHiIya2xYwrnTlmgs45henCR3CuT+Q6O5po6
        sUmE5RILTDPikYiEzlUQGOto2/QjDY+eooE58Bwrh6BJ
X-Google-Smtp-Source: APXvYqyXXSdCVYbApSPoagFGt4LL5f5xI87JDqO13u+c8+bJwGCsM0g9jh6oW09Eg1HUBXeCBkNC88fQrjBnIzi+2Zg=
X-Received: by 2002:a65:5342:: with SMTP id w2mr55612737pgr.220.1555434113822;
 Tue, 16 Apr 2019 10:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com> <20190416090726.GD27892@zn.tnic>
In-Reply-To: <20190416090726.GD27892@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Apr 2019 10:01:41 -0700
Message-ID: <CAM_iQpV4gMkh2xd9e3rBwaXpYuwG_QPDqw+Zj71f5Yf_n54rPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 2:07 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Apr 15, 2019 at 06:20:00PM -0700, Cong Wang wrote:
> > ce_arr.array[] is always within the range [0, ce_arr.n-1].
> > However, the binary search code in __find_elem() uses ce_arr.n
> > as the maximum index, which could lead to an off-by-one
> > out-of-bound access when the element after the last is exactly
> > the one just got deleted, that is, 'min' returned to caller as
> > 'ce_arr.n'.
>
> Sorry, I don't follow.

Sorry for the confusion here. Let me try to make it clear with
the example I wrote down on a paper before submitting this patch.

Imagine we have the ca->array[] with ca->n = 4, the elements inside
are 0, 1, 2, 3. We are trying to find 5 in this array. (This is just to
simplify the following iterations of the while loop.)

So in this specific scenario, without my patch we have the following
inside the while loop:

min = 0, max = 4
tmp = 2
min = 3, max = 4
tmp = 3
min = 4, max = 4
break

It is okay to have min==4 after this loop as we still need to check
if array[4] is whether 5. The problem is array[4] could really be 5
before we delete array[4], so 4 could be returned to caller. And,
after that, 4 could be passed to del_elem() inside cec_add_elem(),
then the if check inside is passed as it is an unsigned operation,
then the memmove() accesses index 5...

To actually crash the kernel, we have to replace 4 with MAX_ELEMS
in the above example, kernel would crash either when reading
array[MAX_ELEMS] or in the memmove().


>
> There's a debugfs interface in /sys/kernel/debug/ras/cec/ with which you
> can input random PFNs and test the thing.
>
> Show me pls how this can happen with an example.
>

Let me try if I can figure out how to add and remove PFN's.

Thanks.
