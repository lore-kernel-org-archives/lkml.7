Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3B7ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634CD20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXdC8S3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfJOIEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:04:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45608 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfJOIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:04:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so11927045pfb.12;
        Tue, 15 Oct 2019 01:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnhzaSlkHgUlv9y36Jmkw3rGD1aw6OTZtA+BqJpe57s=;
        b=MXdC8S3VHlc4hL+vsYbtQ9R+19+oUKz5pmQAIdh8jRNqzqeng0L0K3pVDV5rb9TIbN
         LB9w+rsJEsncudR165UF1hMthivxbEO8i/kOEeSzvTuHUUjy5jZ6lx6gEvj+cRsQqaS7
         tijfUuYpLREMO68IcmZ4rpWhnPRiStxYxlFzrzzGfxLcacX8VCSHkIjIR7J7DTic5RGN
         iNM7pBYFOEoLa4J1pDKUqOHJriAqNkBtzYcXNIo+oxo3S2v3iVqBAdTCZcu0Jp+JOCaX
         9yWxKNA/YB8GWWdC5s54L3iK2I9OpDqiUWzqgQLxGXUYynhrcRpA9QFPLsvMonFC5pZl
         wpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnhzaSlkHgUlv9y36Jmkw3rGD1aw6OTZtA+BqJpe57s=;
        b=GMsnEW/P3PU8o0/8iEKZ6Uwg00AF4wTmw5GkUfw/uU985nvpYCWMONurzD+Q5lFqZB
         hYcYJuuKmhYJJ9PeKyUYcoodSldQxuh+a+TFEE3v7s8f3E9xUYubUdu1VRnbgtFQtMwd
         gB9SMgreTDRjWOFUHypl/Q0RUgqGWh+Fir5j//jhqHtdSNnXwGg97/SNOgEQdw5JngEu
         FeAdbmi0hB7QEuihKjO72Jv+2JXAxzwmo2Btp1XIuJTigHKtRYRCrzCynwQT3zQWzLMi
         zuH/CIGRrkfxjr48U9+xiYl37Bwuv/rxs7uI+edoXJUQrfkaPDocYa/h3sczFJTWR9XI
         xfyg==
X-Gm-Message-State: APjAAAXzJKtZQOUSnbD+/2wEOByYu6jM8ya8r8oHMHRxA52pwieyxsBp
        GSX02vnuSZLTpSKxegZYTg7WX3Uec+IRV27WKdi/j9TYZRs=
X-Google-Smtp-Source: APXvYqxnWwgMhWk0YKCsehOQtmWn+QFvIyf7VwT/tw3uDk7TAxYFWdT2pKbS7kwZuBIAxcA8fJbzEzFxhMivXQ059KM=
X-Received: by 2002:a63:1e04:: with SMTP id e4mr16669575pge.4.1571126680179;
 Tue, 15 Oct 2019 01:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191015130006.39f58992@canb.auug.org.au>
In-Reply-To: <20191015130006.39f58992@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Oct 2019 11:04:29 +0300
Message-ID: <CAHp75Vfv7hzqO=U3AwDs8OuKL_rs9+Sx0DknnAi6WN342iSpHQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drivers-x86 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Darren Hart <dvhart@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 5:00 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the drivers-x86 tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/platform/x86/huawei-wmi.c: In function 'huawei_wmi_exit':
> drivers/platform/x86/huawei-wmi.c:890:41: error: 'struct huawei_wmi' has no member named 'pdev'; did you mean 'idev'?
>   890 |  platform_device_unregister(huawei_wmi->pdev);
>       |                                         ^~~~
>       |                                         idev
>
> Caused by commit
>
>   eda34f06b2e0 ("platform/x86: huawei-wmi: No need to keep pointer to platform device")
>
> interacting with commit
>
>   7532afb35012 ("platform/x86: huawei-wmi: Move to platform driver")

Oops, thank you for pointing out, should be fixed.

-- 
With Best Regards,
Andy Shevchenko
