Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C55720656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qd5Ty0W0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfDZRwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:52:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33939 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDZRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:52:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so985659pgt.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hEUQp+1ZymVlnVBjfzba+RHICVcVhzbLb/urM/0DUgk=;
        b=Qd5Ty0W0eeX+PlOxbOktqwbzBIkdqo2ELzziqu9BTbN8zag36pRGoX5wUhG7LZmhNq
         JKjNoQZ4EuUi2BJFAI9ZdoWbrpmifMuXAyy/DINlU0Baeua6nMTtWg5eUIL5cp0tD/ty
         UI7d/moVOlj6gFYTd+xzVpLvBf5FACV8DdfdZGAfkcOrALOP0XpqAEDvaJ5+/Be0JW5A
         OCM/NyACkto+qliG04t4J5ztI+4zFx+4n2REeOxK5+qTYMxT/LN4MTkN3omKud1xeK4Z
         k2rNhsHn6ORNk4mD9LOMMMM2so+NUHF+QmfG3x+h7V9ABBYg80rCpk+Q12p2KyBjk8Qo
         VjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hEUQp+1ZymVlnVBjfzba+RHICVcVhzbLb/urM/0DUgk=;
        b=jwaqSF3tnJBmLrRKo8t0AhcCymjm+TZXYKdcbSpw6CAaElOuESIZUNIfGS7q2+AekI
         EGvgngle967ov5JJqbN0wUSnxlA+sCrA1/4ihglL/LQedMf9LVcfYvLqmyYK8+pDG/RX
         K1sFtSqDnqos5u9r1ly4w5PC99OhwTY9wAferA9qQ//gQ9PvKafxLsS7kAdxiZ1iUzWC
         9/6UvBKJRDZJEZvm08osfROFDW9KSbxvY/whxVCwAQ4qsxycA8SC6GPjvAGquRQ7wcOH
         REAwH9+HsSZkrRJkVzJXtHShFa27+UAMnqbzJ6dx/9b9h2GPh9SOD3vBCdpzm/IQIK3X
         /oDg==
X-Gm-Message-State: APjAAAUFHWCRsJ3DiZceR7TRJTqN3Z2lEfttURt6OaGI5281HMyz3hIg
        cQ2Zzncv0hIrocD5UOKysSiQ
X-Google-Smtp-Source: APXvYqyKclPadwcwtTATuTb+5qmx/jjHWLvhX3rKjfaMVWEf9J88jQnPCp2RNvfCvvLd0fNFFu44dA==
X-Received: by 2002:a63:1048:: with SMTP id 8mr44523944pgq.70.1556301168515;
        Fri, 26 Apr 2019 10:52:48 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:72c4:4b94:e0ad:83b0:3987:aa05])
        by smtp.gmail.com with ESMTPSA id c22sm36313593pfn.136.2019.04.26.10.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 10:52:47 -0700 (PDT)
Date:   Fri, 26 Apr 2019 23:22:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Message-ID: <20190426175237.GA31751@Mani-XPS-13-9360>
References: <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
 <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
 <20190426173329.GA31161@Mani-XPS-13-9360>
 <CAHp75VdcS_LaKNhaKsFaWa9ReQw4KRDRpc-81kv0Hb9wbZFCTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdcS_LaKNhaKsFaWa9ReQw4KRDRpc-81kv0Hb9wbZFCTg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 08:44:36PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 26, 2019 at 8:33 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Fri, Apr 26, 2019 at 08:20:19PM +0300, Andy Shevchenko wrote:
> > > On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > > > On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
> > > > > On 26.04.19 15:36, Jan Kiszka wrote:
> 
> > > The problem here is opaque number. This has to be chip + *relative* pin number/
> > > See this:
> > > https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640
> > >
> >
> > But for platform like 96Boards we don't need controller specific lookup, these
> > are all handled by the platform code [1] so that the users can use the standard
> > pinout number to access GPIOs.
> 
> This is a complete mistake.
> 
> There is *no* global GPIO numbers anymore in Linux. (I don't count
> very old legacy platforms)
> Read above, it applies to DT or whatever resource provider.
> 

I think you misunderstood what I said. I referred the standard 96Boards
pinout and in the MRAA platform code, individual boards just map their
GPIO chip and line number based on that. I didn't mean the deprecated
global linux numbering.

https://github.com/intel-iot-devkit/mraa/blob/master/src/arm/96boards.c#L109

And of couse as Jan mentioned, the chip number will change when some
other external GPIO controller got probed before but so far we haven't
got to it!

Regards,
Mani

> > For instance, pin 23 on the Low Speed expansion
> > header is the GPIO for all 96Boards platform, so the user can access that pin
> > using 23 itself in the application and it will run across all supported
> > 96Boards.
> >
> > That's one of the reason why we prefer MRAA.
> 
> > [1] https://github.com/intel-iot-devkit/mraa/blob/master/src/arm/96boards.c#L75
> 
> -- 
> With Best Regards,
> Andy Shevchenko
