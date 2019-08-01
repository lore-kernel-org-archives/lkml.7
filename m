Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148F3C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AB4206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo9yKMEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfHAU0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:26:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33680 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfHAU0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:26:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so70682616ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEhdMDOICpqniTno2IyVeOoEnON+nzC0j1lyfNgpjMU=;
        b=Eo9yKMEb9UjAi++MYVMK5w2JPzXXd2oaugL1PU1Z5AnH6kz3xnmZOs1K9xWNqfqtk3
         VmwJmljVmwT/qXcmKhfh45Uh6ecLdK8ZrVn4nNFyX8yU9hL5eXTDrpSrOBf5oFGZO5nO
         d44al570wf7BvRkIywn6UPcXl1x8ppXpPFhrG+cl+drU2V6jH9eqo4KVsx4kBxqAi4pC
         OQEJLGLLscm10lm5rE5CkfdNXWaH+/dy7OoHKssJERrOJbJC2zFLbkrdsR7iBVQVdyiU
         y12H66yN83drtr16Wi1D9dr9udO/dkJkJ5DU/xAqOcJZEQRUEG+o0EcVwYFipLJcXpg4
         NJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEhdMDOICpqniTno2IyVeOoEnON+nzC0j1lyfNgpjMU=;
        b=Ki98qIWXiZEYUt7jPMM7DTH1bCG8U+9qgtscqEF7KK3AHfYHJKR4FLPx3OUwrADdtp
         dEUhPIYlgCIWSKoXc9nF02blJJFxcmJ/dVa0f3Nd8UAlJ5fZZKXFzlmQckEtuc03eozp
         wOcJkGj1kSsSQooSn/opvv8CEUSPQTxOvUHAyCGfrlQybBQQ2rsn1k0gFK7UdznrUFfG
         GFr7CdgoO4/etNOamycg5e5Rl6UjfUQEsvPDykTsggJCD7tujFtoYcg+NEfOnwCYq/jx
         6XKdSU3dzfvollUL/oHUXEfGigIoeM2fwn7Zrxmbq+7Whf71OHA6TOhhC0+RfeUs0xCr
         nf5Q==
X-Gm-Message-State: APjAAAXpFBndTdrr+gw7WCIx3HTQfXdQ+s8OHlRJI4GdGZq4HQh0Xsf6
        t5WVQA8widLkunhB5W/uE73GQ6qE4FY07cd5uSA=
X-Google-Smtp-Source: APXvYqybvON8/4Kkvp+5xsl2NJ655igJzUEumv3jvN/U3C/xV9NXsj0vjpoF7F6ksvGlWWbQL/gJvl1ZDgTXm+1shRs=
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr52288255lja.220.1564691200817;
 Thu, 01 Aug 2019 13:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd> <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com> <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com> <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
 <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com> <20190801122429.GY31398@hirez.programming.kicks-ass.net>
 <0BCDEED9-0B72-4412-909F-76C20D54983E@zytor.com>
In-Reply-To: <0BCDEED9-0B72-4412-909F-76C20D54983E@zytor.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 1 Aug 2019 22:26:29 +0200
Message-ID: <CANiq72kg+duBe_srpcco-P17=3OC2c1ys=rGMVY8Z9FxZ69sdw@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 10:10 PM <hpa@zytor.com> wrote:
>
> I'm not disagreeing... I think using a macro makes sense.

It is either a macro or waiting for 5+ years (while we keep using the
comment style) :-)

In case it helps to make one's mind about whether to go for it or not,
I summarized the advantages and a few other details in the patch I
sent in October:

  https://github.com/ojeda/linux/commit/668f011a2706ea555987e263f609a5deba9c7fc4

It would be nice, however, to discuss whether we want __fallthrough or
fallthrough. The former is consistent with the rest of compiler
attributes and makes it clear it is not a keyword, the latter is
consistent with "break", "goto" and "return", as Joe's patch explains.

Cheers,
Miguel
