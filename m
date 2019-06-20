Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AAEC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5CD2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuEUQhjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfFTGTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:19:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35834 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFTGTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:19:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so1065938pfd.2;
        Wed, 19 Jun 2019 23:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pv9PD1ay+GiAxyL2F08rSaEB+qNYRccK6KNGGstNtc0=;
        b=ZuEUQhjrPXu9yBzsxPnZI2DJah4JJ2dovshjMTFXs8eK07Kty+rNA5j9jZg6fmnJ/D
         J7M/HNJMUM067FxwylliGZxnxo2pwsw4noojO1LAc944hObz40/6k+gnJ5YWUvwkW4us
         OE7LbvDP2PdSDRTthcs/NNm9j+mcpfFmBRkBwU8FLBbFHoj1CMfUT3xpff0zQ+/jifbF
         l735VmfMAPoxJ5yuWIonm9BYllInLJSIKFUAfWQhHs0/z908ShLyjsejVRQ8oIL8yiTc
         DEoJF1YbMdfQQRwmWu4TakB8XKUQybBqaLLRCJx9dHUyg7GpMpj4cQ4lyA67DeHFFrHp
         JkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pv9PD1ay+GiAxyL2F08rSaEB+qNYRccK6KNGGstNtc0=;
        b=GkbFhOt3he3U0uKygRXSB92w3QY6IfYhUeXQQ7Bq8UQ5Qzkd+to8VCxGTpASoiM0kP
         i3pl+Ljc4qsaV+BjoC3eT96CTmjp6XrVBB6nOJIhpgc5+Q+4phMcy5drHOnDjXpXmMfs
         mQ2OfcTz/WWnTsYTfVa8XKs1/CbYykA202VSnZXVVnNoyiH6OWTL6ygZ9BJfiJjK3K2o
         thnQi4UesHoexmJo7GQQLSDXzIDfIm8whOir+P0iMWK8nFyaQKf6ppRtLLLXBOEQRWWF
         WKOUahHw8YTcAoXB1OIbiU6XI34rXtzz/STYZUrItAKqZ0HRAUzjkwMrFedAeCvQ1h1V
         HtBA==
X-Gm-Message-State: APjAAAV8uAcs3sLzYncz17xA79mBUfOkaKS+w43Udvl/auFPrry15XDb
        fZ9MnrtiJsyqFMsn4Ah9HcunVwRE3hyB5ZGo+zU=
X-Google-Smtp-Source: APXvYqxy/Y9Gt1wrswVCJbGhyMrRkjteWD25yPuRNEsIYpcjRpFaTTu/TbedCcJKrXdVnM/VwKDpuxxAYGjKU+wkrjM=
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr1391238pjb.132.1561011576503;
 Wed, 19 Jun 2019 23:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190618053227.31678-1-puranjay12@gmail.com> <20190618054158.GA3713@kroah.com>
 <20190618071717.2132a1b7@lwn.net> <20190618133948.GB5416@kroah.com> <8aeb222a-ee44-4125-45fd-ce9a741e7ecc@linuxfoundation.org>
In-Reply-To: <8aeb222a-ee44-4125-45fd-ce9a741e7ecc@linuxfoundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jun 2019 09:19:25 +0300
Message-ID: <CAHp75Vf__EtLVTOf0XvA3w7RPj+bnoQOud3gCXr1Fya0b_o4cw@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: platform: convert
 x86-laptop-drivers.txt to reST
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 6:06 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> On 6/18/19 7:39 AM, Greg KH wrote:
> > On Tue, Jun 18, 2019 at 07:17:17AM -0600, Jonathan Corbet wrote:
> >> On Tue, 18 Jun 2019 07:41:58 +0200
> >> Greg KH <gregkh@linuxfoundation.org> wrote:
> >>> On Tue, Jun 18, 2019 at 11:02:27AM +0530, Puranjay Mohan wrote:

> > I bet it should be deleted, but we should ask the platform driver
> > maintainers first before we do that :)

> Adding Platform driver maintainers Darren Hart and Andy Shevchenko, and
> Compal laptop maintainer Cezary Jackiewicz to the discussion.
>
> + platform-driver-x86@vger.kernel.org
>
> Hi Darren, Andy, and Cezary,
>
> Would it be okay to remove the x86-laptop-drivers.txt or should it be
> converted to .rst and kept around?

Shuan, thanks for heads up.
The list of laptops supported by drivers in PDx86 subsystem is quite
big and growing. The mentioned file contains less than per cent out of
it and I don't think there is sense to make it up to date with
thousands lines. Agree on removal.

-- 
With Best Regards,
Andy Shevchenko
