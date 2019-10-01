Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFE6C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ADF21906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY2EB2xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbfJAOlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:41:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47089 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389116AbfJAOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:41:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so9777158pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gfg3/glADJOgDAi9GKUAUAgnTL0tBR3ed6a21oRIueY=;
        b=OY2EB2xnCjPPQUEhzUnjhOLkfFbnEllNpx+veFyXGDd3xWQSyvtuWL0b484lUlLsyo
         37PSF3PG9r/6bOFEwdftuaLqU6yfCdjNQSjK050epo9ag+AkBSRQiHIdi5siXUU7yJII
         kFJJbsLmCDUSkWx6pApvlRUqFrtkbb1rUgefM+ixTtdiT2ujpPz7vcnBnbyxN3BXHZHu
         lA4cQKU3fptvDv1SrBT2ftSXqN/EoBVY2NSoJv+jJK7iZ3mqWY47/ngal4foZt0jTrno
         igt7y/xwxMJN2L9O6vPBcQ/iFcKKYk8QD3vW6xwOKXaxlC1qDBHoorwcTOZDmrHgo4oD
         SsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gfg3/glADJOgDAi9GKUAUAgnTL0tBR3ed6a21oRIueY=;
        b=TFRdf9BMvV4T7R2xPFH1WBtD7CibWd1jkpivni1VlwWIpYjpjZDKFn07SKzMhYleDL
         1IXJGKRBQYmh7vuko8OPcgzKI16Uax+K3fYDAndw/G31KVsYcYuCs0fiAtxotjOx8RgF
         pFZdCMMfGiSThnX8ddersE16qMLpbNWDCGVauvzKhhJKPbLbByY5HDQLirQUWTgeHN1F
         3tZZxt1BhHmiLwE1JMkNSLksX7XcygtT9iKGp/UfQdvgV3wD4q5doFQeHB/N1PYWbVN7
         QlwvxviEThgbfl1qJ1bSqsHsfSj7dqmX8oZDvravuJw2P6Giv6QTlQchnGmmSlEs8oHF
         H0Qg==
X-Gm-Message-State: APjAAAUmKL+MOXF9WM6nlIDLINTlsJ2igrjDnEX016GDNtUt4K3UACdr
        rmMZ1eg2IfHlZpz4wjiPQcOhQ4SteR24aYynImU=
X-Google-Smtp-Source: APXvYqwgW6QEgtfopSLc9mE2KDtuCxAq1uHJl+GpgLea++pZGSX3ljQ73s+sXRcLWVBmYhIq2wz8gBFPnj4GjL/0BvU=
X-Received: by 2002:a17:90a:7f89:: with SMTP id m9mr6000548pjl.30.1569940896461;
 Tue, 01 Oct 2019 07:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190104193009.30907-4-andriy.shevchenko@linux.intel.com> <20191001133055.GA3563296@ulmo>
In-Reply-To: <20191001133055.GA3563296@ulmo>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Oct 2019 17:41:24 +0300
Message-ID: <CAHp75VdQ1LguHMoqdtCXEV0j4y9qWGpi9Qf5cDc151ip5xSNpw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] usb: host: xhci-tegra: Switch to use %ptT
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 4:33 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Fri, Jan 04, 2019 at 09:30:09PM +0200, Andy Shevchenko wrote:
> > Use %ptT instead of open coded variant to print content of
> > time64_t type in human readable format.

> > -     dev_info(dev, "Firmware timestamp: %ld-%02d-%02d %02d:%02d:%02d UTC\n",
> > -              time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
> > -              time.tm_hour, time.tm_min, time.tm_sec);
> > +     dev_info(dev, "Firmware timestamp: %ptT UTC\n", &timestamp);
>
> If I understand correctly, this will now print:
>
>         Firmware timestamp: YYYY-mm-ddTHH:MM:SS UTC
>
> whereas it earlier printed:
>
>         Firmware timestamp: YYYY-mm-dd HH:MM:SS UTC
>
> So the 'T' character is different now.

>  Could we make this something
> along the lines of:
>
>         dev_info(dev, "Firmware timestamp: %ptTd %ptTt UTC\n", &timestamp,
>                  &timestamp);
>
> To keep the output identical?

Yes, we can...

> It's possible that there are some scripts
> that parse the log to find out which firmware was loaded.

...but if you have scripts parsing kernel log, something is odd.
As far as I understand kernel log isn't ABI, no-one should rely on its output.

-- 
With Best Regards,
Andy Shevchenko
