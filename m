Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB46C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5100B2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUh/0jFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfDZS1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:27:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39595 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:27:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id l18so2001371pgj.6;
        Fri, 26 Apr 2019 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAjwuc39AddYOCTUpAuM9uE4idFBuger2xGgrN2miVE=;
        b=RUh/0jFCU1wSaTlGkPOqd9JdA1mmukszuCuzVJkC3yKTKpX/FKI5j482VscslFYIYP
         EkexQ7pIWzp1E83GR5ehEjLx3pPKqba7sJiRNU7AklOg9KENkctWngHvRLuVk2SY3c5W
         BymIkkjqUyQufNvjUluUg/nHstHXvcY61rCE0tTqeZlbrzS5cHe3dddJXf51tyHXa2G2
         q38FwTamVd/Y/CU6hyUnW8uB2dKiY/co6apEdfxu0M9iaEavdRYwtfxVyDz1LeeZ7LqI
         vV1TPVQGXuTtN8qCxLLTCDpLXKPkZt1SERfM5MfV6OTCSKZuVEoDZV5nBc+2k4BYDemE
         U4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAjwuc39AddYOCTUpAuM9uE4idFBuger2xGgrN2miVE=;
        b=ublt4NhcG8DAoqomnehQCPDHIerJkKQ55MBvz+e106uaVe8AIyGIyZkfJrVdgaoihL
         qjFBKqHimEkqFJRdX7dH7TyIsuyD4tpuzc/3uNrno7ooWJWbLnfnPTr55LdrXfd4Mllm
         xIIb4gwkSOdkBxBckFiSifTQayY1QXgDSN1xx2piN42w1v+cpPqkfPUNvKwbe0wg4xwW
         muNPMKpUqIE03zGnuvvpoXgY/wNvauANe8w8ogCVJXs1EULptIgBXAHWVmtHXgQoSo42
         TEDhXWGdTiYHQpU1i7yGgb61eWUwWMKLH95Dey+GE9JmJEZonWTwE4RPC0RYdoRrZ2Rr
         08aA==
X-Gm-Message-State: APjAAAV8sEb6db1wmssjqdM0TeX7FxxUGYkPSUURx1sb2ZPhGXhF9fOx
        DLahH0Vuc5LUFuhIVc+wmhXpDTetHyQlCtRk5nw=
X-Google-Smtp-Source: APXvYqxF5luGqSNZCj/7rH2W4AWnNqj5mPAi3G2Cx8X+JCPt3U/Lrtzw+SgE/OCJbGZ1NID8nc/N93rx7rfPe1hAj8A=
X-Received: by 2002:a62:2603:: with SMTP id m3mr9679339pfm.232.1556303221827;
 Fri, 26 Apr 2019 11:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com> <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com> <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net> <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
 <20190426173329.GA31161@Mani-XPS-13-9360> <CAHp75VdcS_LaKNhaKsFaWa9ReQw4KRDRpc-81kv0Hb9wbZFCTg@mail.gmail.com>
 <20190426175237.GA31751@Mani-XPS-13-9360>
In-Reply-To: <20190426175237.GA31751@Mani-XPS-13-9360>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Apr 2019 21:26:50 +0300
Message-ID: <CAHp75Vd6CtNRFZ1-7OSe5xzqNXNYQQP4-vck=3rMeq2QVZ7pCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 8:52 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Fri, Apr 26, 2019 at 08:44:36PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 26, 2019 at 8:33 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > On Fri, Apr 26, 2019 at 08:20:19PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > > > > On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
> > > > > > On 26.04.19 15:36, Jan Kiszka wrote:
> >
> > > > The problem here is opaque number. This has to be chip + *relative* pin number/
> > > > See this:
> > > > https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640
> > > >
> > >
> > > But for platform like 96Boards we don't need controller specific lookup, these
> > > are all handled by the platform code [1] so that the users can use the standard
> > > pinout number to access GPIOs.
> >
> > This is a complete mistake.
> >
> > There is *no* global GPIO numbers anymore in Linux. (I don't count
> > very old legacy platforms)
> > Read above, it applies to DT or whatever resource provider.
> >
>
> I think you misunderstood what I said.

I think you misunderstood what I said. :)

>  I referred the standard 96Boards
> pinout and in the MRAA platform code, individual boards just map their
> GPIO chip and line number based on that. I didn't mean the deprecated
> global linux numbering.

It can be easily broken by shuffling DT, kernel cnfiguration and
adding some GPIO expanders. Note, no C-code mangling is involved.

>
> https://github.com/intel-iot-devkit/mraa/blob/master/src/arm/96boards.c#L109
>
> And of couse as Jan mentioned, the chip number will change when some
> other external GPIO controller got probed before but so far we haven't
> got to it!


-- 
With Best Regards,
Andy Shevchenko
