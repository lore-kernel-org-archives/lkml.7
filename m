Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77837C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4729020645
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDOCVZxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfGIKT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:19:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47002 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:19:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so18997959ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muIdAU71jrjl/Pbj5rlS7Ut9DTSuJ148dsi3/DfWkKQ=;
        b=oDOCVZxssqeo9nXwEhgJ/hHoUgG/L+2yB2JcenOs9IzBzDnTPuHlfR2wkN+S0Q7pkd
         BdOgZuTkmDt1rX+nR7SClLI2HmhrZqj/y1e+IMvZ+28haMDsWwy3izxclUQoillQCosH
         lE24TgIcpWDSQ5VCm9ob1R3eSGBu6YxYf9SQi4CmJQQFAPDG1gNz4rLUUqMIufCUhy4l
         iZ4EAd86ivTJkLbverkF+UxWd8oP7cpWbS6LD0gK2D3Nnkv+sicXtHEf06d4JGPhahcX
         91mQUwfOEPHAt9ENPjx3CuGGRpLpYv0eIXh2Pdv7RQ3zQU9ltm9VDwlY/d8/NU2rlzCc
         RKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muIdAU71jrjl/Pbj5rlS7Ut9DTSuJ148dsi3/DfWkKQ=;
        b=ZftFogze3mmkrsXiBcrY1grs6KRy0crXfkCzLgfUK7cquljqE7UfGKdhdlfnH8opng
         x6S6k5ex9Q3OHhL93NpOwsiey+1q09RRgqiXCkk/jdPuW7+6X5iBIHtLo/EJkwtLuwyR
         ce72UZ1aNd9mI7L0wJKvl1bauc1zoOZHoGDf5YrDw8ma27VcQEVIatAJUkyrRON089VR
         HSBTtUGt+VLNmo1mY15cglJbZH9wKR5z3RE9eMtjIHPv05TPDj6GUmUPDHe65yfH8S3M
         ZKw9o3rIEQDzd5p4F632yLzaqkxON+sw8xEiArTEej9UTLkPnphb+bTrRnkI4NRYyBKv
         YWbg==
X-Gm-Message-State: APjAAAWrsuSDy7Fi2TK8dcz5HY5wMFIDx26Xd9WPsPsXEov9RMjmQGXn
        QsaMYAY7yn7FOUXnANkUFHcXG872YW2y3m7Mg06o0w==
X-Google-Smtp-Source: APXvYqyUCrfTShwIFgPyKO5flqJsDKbiudHcHpVhR8kWvjkty0NfjAMw3UixBalcBHXjhm/ZFLtQzWYdFc2Blb30C9c=
X-Received: by 2002:a05:651c:92:: with SMTP id 18mr3723010ljq.35.1562667566489;
 Tue, 09 Jul 2019 03:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190708141136.GA3239@localhost.localdomain> <a19faa89-d318-fe21-9952-b0f842240ba5@arm.com>
In-Reply-To: <a19faa89-d318-fe21-9952-b0f842240ba5@arm.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 9 Jul 2019 12:19:15 +0200
Message-ID: <CADYN=9LBQ4NYFe8BPguJmxJFMiAJ405AZNU7W6gHXLSrZOSgTA@mail.gmail.com>
Subject: Re: kprobes sanity test fails on next-20190708
To:     James Morse <james.morse@arm.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 at 17:56, James Morse <james.morse@arm.com> wrote:
>
> Hi,
>
> On 08/07/2019 15:11, Anders Roxell wrote:
> > argh... resending, with plaintext... Sorry =/
> >
> > I tried to build a next-201908 defconfig + CONFIG_KPROBES=y and
> > CONFIG_KPROBES_SANITY_TEST=y
> >
> > I get the following Call trace, any ideas?
> > I've tried tags back to next-20190525 and they also failes... I haven't
> > found a commit that works yet.
> >
> > [    0.098694] Kprobe smoke test: started
> > [    0.102001] audit: type=2000 audit(0.088:1): state=initialized
> > audit_enabled=0 res=1
> > [    0.104753] Internal error: aarch64 BRK: f2000004 [#1] PREEMPT SMP
>
> This sounds like the issue Mark reported:
> https://lore.kernel.org/r/20190702165008.GC34718@lakrids.cambridge.arm.com
>
> It doesn't look like Steve's patch has percolated into next yet:
> https://lore.kernel.org/lkml/20190703103715.32579c25@gandalf.local.home/
>
> Could you give that a try to see if this is a new issue?

The patch didn't apply cleanly.
However, when I resolved the issue it works.
I'm a bit embarrassed since I now remembered that I reported it a while back.
https://lore.kernel.org/lkml/20190625191545.245259106@goodmis.org/

Both patches resolved the issue.
I've tested both.

Cheers,
Anders
