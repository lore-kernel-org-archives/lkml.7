Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBD7C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DB420872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569433732;
	bh=oWlU7mS7LEQJMzlcLP351aYBDUK1RSNZf1OiMFvL+no=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=on6EG2HLG88/j3WmM0aRBcSQTEf2AyeZotwTlA9bRcmibZXPxjmnFD/ycRRr7Kqyz
	 8x9opVKy4AV5ya8/A8cUF8NLnCUvMV4nxNSHOcuuXE3/dgfzGN2/J+WnEQOwIkyyN1
	 UGYGW1TFaNGAfEf8oXZ7hfFNGuCe8ZBtwDubkB1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfIYRsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:48:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38368 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfIYRsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:48:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so4875060lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ubp3hpdHZYFHNsbBzmSC09eT5vsyQ7Zrdz0nsHZMrVo=;
        b=gGKQ4rsBGdlqZUFMO6XNkNge3CFyTMn8oZRzwJk/rovTd8qu09JoOmMh4pWLsauLni
         Au3XxhldtMZLJwfaqs4pnNxXd0RGKaYu+YhlrWEfuThVz+0g8mr0CzD/B99CmJ3YtiNy
         rZkgmAhinraPdfB5emwIyaHr2/x37VdH3uCq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ubp3hpdHZYFHNsbBzmSC09eT5vsyQ7Zrdz0nsHZMrVo=;
        b=QA/M+R9Rvno8Z9BAC5yYltDZrIkMEy0hUPIVIdURK3B+9OZRwQHm14npdp7wCvpA6e
         szUSSMvuUvMK+e6Qc0weiQUzIhGycJjJbzN1cvy/6sD9lK+VJN1Wzn4SLT4KYoU2lO49
         xJ6YKVNjcGvJ84WBDssMRLSdfisAB4ldUQRnwiLj+Y5VgYHBj9CuHbY6tyslCmCmZYhc
         U7YDxnh5wWuyjEKs5Y1RsoGhz+k0FiHt4n278BJnu//33lv2dJaK8zjga/D7cInf4MQV
         Tx3/PyM+z4yL5eVGnNsfAQyx2454pLFrya+udkM+tPdvt/+IZaWi7n0x+dz/8uR817E8
         TdFw==
X-Gm-Message-State: APjAAAUo/tEdmYJKUA3vH1EKhFBMrUV3rrPBvs45f/oCTdKcQHYWWFpW
        0yhieSVBvegC8RqGNRfEa7AHwlfOe94=
X-Google-Smtp-Source: APXvYqwBjoxxtjSW0deZjPPOR+EAnzh786a3ei7qVVq1uxsWbgvFr/BGyxJf3baSZz0HwZmTojhm1g==
X-Received: by 2002:a19:c3d3:: with SMTP id t202mr7116590lff.48.1569433729076;
        Wed, 25 Sep 2019 10:48:49 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w16sm1361515lji.42.2019.09.25.10.48.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 10:48:48 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u28so4875003lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:48:48 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr7038976lfp.61.1569433727828;
 Wed, 25 Sep 2019 10:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190925165915.8135-1-cyphar@cyphar.com> <20190925165915.8135-2-cyphar@cyphar.com>
 <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com> <20190925172049.skm6ohnnxpofdkzv@yavin>
In-Reply-To: <20190925172049.skm6ohnnxpofdkzv@yavin>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Sep 2019 10:48:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
Message-ID: <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:21 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> Just to make sure I understand, the following diff would this solve the
> problem? If so, I'll apply it, and re-send in a few hours.

Actually, looking at it more, it's still buggy.

That final "size smaller than unsigned long" doesn't correctly handle
the case of (say) a single byte in the middle of a 8-byte word.

So you need to do something like this:

    int is_zeroed_user(const void __user *from, size_t size)
  {
        unsigned long val, mask, align;

        if (unlikely(!size))
                return true;

        if (!user_access_begin(from, size))
                return -EFAULT;

        align = (uintptr_t) from % sizeof(unsigned long);
        from -= align;
        size += align;

        mask = ~aligned_byte_mask(align);

        while (size >= sizeof(unsigned long)) {
                unsafe_get_user(val, (unsigned long __user *) from, err_fault);
                val &= mask;
                if (unlikely(val))
                        goto done;
                mask = ~0ul;
                from += sizeof(unsigned long);
                size -= sizeof(unsigned long);
        }

        if (size) {
                /* (@from + @size) is unaligned. */
                unsafe_get_user(val, (unsigned long __user *) from, err_fault);
                mask &= aligned_byte_mask(size);
                val &= mask;
        }

  done:
        user_access_end();
        return (val == 0);
  err_fault:
        user_access_end();
        return -EFAULT;
  }

note how "mask" carries around from the very beginning all the way to
the end, and "align" itself is no longer used after mask has been
calculated.

That's required because of say a 2-byte read at offset 5. You end up
with "align=5, size=7" at the beginning, and mask needs to be
0x00ffff0000000000 (on little-endian) for that final access.

Anyway, I checked, and the above seems to generate ok code quality
too. Sadly "unsafe_get_user()" cannot use "asm goto" because of a gcc
limitation (no asm goto with outputs), so it's not _perfect_, but
that's literally a compiler limitation.

But I didn't actually _test_ the end result. You should probably
verify that it gets the right behavior exactly for those interesting
cases where we mask both the beginning and the end.

            Linus
