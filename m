Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2AFC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 01:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C93D2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565313379;
	bh=scLmnQyYjQdqJKQg3lLERdoWVkYkvWnTENkGxn++vlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bohers5Z+34Q8+xMajn2tWLmI92AtqU0C8aBAiN8q0T/xAoysH20YM3R+I4wZsabR
	 zpX7ODw2tnsOb8l0WXnhPboEfk8W6GlryR+TdjoolU1fDzIfc/FEpce6oPfpzZcNnr
	 mYZ1O4Jpp49lrAtDc27mt7IDh5yh2O+y4L8zg1yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405326AbfHIBQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 21:16:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46311 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404985AbfHIBQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 21:16:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so63970819lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 18:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyYz4kjl/LS+Ci6YYkBH2OKrNgCeFV+hR/bEG0IyHAQ=;
        b=Kn0WlAb/wp3bAUOI96M7Exz3gGG32qjs/NPQYgfbcxV3+0/4J5fCBe/zZt1NF37w6R
         8Payd0Ku2hgCMW1gwbGsvKYkOEqJjaLAW1aillp0bjCdeTin4d8JVCVOd47C4AexqJXG
         /YMyaVNugz2Bkd6DvSp+FnUyqwZ2qKYaukD24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyYz4kjl/LS+Ci6YYkBH2OKrNgCeFV+hR/bEG0IyHAQ=;
        b=meK0b9bvyWuPffAZuQOpiFnacPg3VekPJuwhuCXPwOXXf3U1B0hrvP6x7Afle8Yg7M
         pfiNAB7LqPhw6LzdgHvxsUw3hmqTdr13Luenoz9qnC/GeirIpjvzcQs0XXkA1U9uv5Yx
         c9GsdRrRgb7Ny3R0/vXSn6X48yyeljBsnVkmMxSRPm8owaBzlfPj6GtAxHeRTdnYjGzt
         U6BmkfjtiKHLzuHjFfuwz1nbwVP+C+LhH5hMKMghnTfwK9Y73DMSFO4hzBQlylhjHds9
         MlmQKsr2jA80eGGvfbVqnBh7zxe7VwBWnARRhwg33nMsVmE0sn79FB50fBdzhh88tA+H
         dqNQ==
X-Gm-Message-State: APjAAAWhzStBxHjrBKrcyNxgyFgJtfWuCbYJULUbXrlSbqe9YbtQzrCq
        7hRADICTSuImta7hCrRLCQ9llW8Qje0=
X-Google-Smtp-Source: APXvYqxyCoggK/pSVUbVz0hRcdhBwMjdHO+16aBImZOzJZOPOTKWH1+nsJu27j/kqKjVxmrY1pRdHQ==
X-Received: by 2002:a19:914c:: with SMTP id y12mr10852432lfj.108.1565313375163;
        Thu, 08 Aug 2019 18:16:15 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id x2sm16309764lfg.12.2019.08.08.18.16.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 18:16:14 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id j17so14225798lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 18:16:13 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr10787490lfb.29.1565313373711;
 Thu, 08 Aug 2019 18:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
 <874l2rclmw.fsf@linutronix.de> <CAHk-=wiRN9v7UmhbTZgskh-MLyY2f0-8Zi3fUziy+GpZnj2i3w@mail.gmail.com>
 <20190808194523.6f83e087@gandalf.local.home> <CAHk-=wiRpvRg6dpEWqaB20QUFRq8or0-AGgkjvisygptRE64UA@mail.gmail.com>
 <20190808204841.5afcad46@gandalf.local.home>
In-Reply-To: <20190808204841.5afcad46@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Aug 2019 18:15:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNcrysjJYPDFhKAc4tvd80XGAyh95oZeAY6bmzpv3G-A@mail.gmail.com>
Message-ID: <CAHk-=whNcrysjJYPDFhKAc4tvd80XGAyh95oZeAY6bmzpv3G-A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 5:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I've never tried, but are you saying that even with the "10 second
> hold" the laptop's DRAM may still have old data that is accessible?

The power doesn't go off when you *start* the 10s hold. It goes off
after ten seconds.

So power is off only for the time it then takes you to press the power
button again to turn it on again. So just a second or two if you react
quickly to the "ok, power light finally went off". Longer if you
don't.

But yes, DRAM has retention time in the seconds. See for example

    https://www.pdl.cmu.edu/PDL-FTP/NVM/dram-retention_isca13.pdf

and look at the kinds of times they are looking at - their graphs
aren't in  milliseconds, they are in 1-5 seconds (and the retention is
pretty high for that time).

But I don't know what a power-off-in-laptop scenario really looks like..

            Linus
