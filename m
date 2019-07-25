Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD2C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC80922C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtqqC+qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391213AbfGYRYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:24:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42778 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391148AbfGYRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:24:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so23080693pff.9;
        Thu, 25 Jul 2019 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQkCw3tqYxNg25HyKYhw0IoWyx88axOMkKNb8Un50tc=;
        b=dtqqC+qeDMpotBFXm5ofjdw8IToSv9qRF1RBf0M8CMZ3sK9KT9AFSltvF0j0mflCX+
         Rf3WWNwqi+Kqwb40rz/Z9Fh/AwX7ZmQ8cylNu7Do05652MK/d/h0ZQ8BQzTBeDwWhhtb
         rrtYEa8v/EEneyR5gVQHEFYmYIpeluOHPDM5jH3NuVdjahlqXBXVMZVR+OuzWsV5ia54
         sRAWLjTKolit+S8ZmPPfu9+XWb/2qWY2je8D9kmkrUlR10tLH95eZLtd9+axD8uRPTGL
         /f859Ji0UERJJcAsWJeMvSbxmf7wIBE6C2AjBQxj8gONXhn7GesJLt/QVfDc2lB/fPPh
         kROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQkCw3tqYxNg25HyKYhw0IoWyx88axOMkKNb8Un50tc=;
        b=Fbo1dv5Qxkdqp1P0jbUQnvabvQPkfzS5sBNZOzYWXF2islHRuPPvMYvA/o/TI11znp
         cixAJJ3HYu7oAfAs4Iugl8gcINaOsRV+DrzWu8og5Qok+0DloCMik9Xi8zUU55eQ9VTD
         uClwjH2KWkTwQAbPXbm9t6XXT7KMnYPrlMGU4ansg4Nos9XHiY2Qa7w8ssYnAoqNYTBI
         lMlPEEPGW0QUDVLgJsarnc2uDrSoHWXcCH+lyhOaLiWzoUaYzzAMYW3TEoBY2jeiW8hg
         U0qeZVDu9bCgc3k9Wufxyn/6ztMPQWuKXtSboAW1XhXCvaSyLHYobfiGAWQ5On3cb/Cb
         Jl8Q==
X-Gm-Message-State: APjAAAWh1xEEX/cw8zNeXQ2n0cwSd0RKi9cw2qIJAKoZtbAQ9v9MOYbc
        ROTFGj8ND1A87mR6KTXzh2KD65SOWHt/4Yll4Ao=
X-Google-Smtp-Source: APXvYqxeocBj7MIhS7/W5mqQJNVfcLfk+fSnj7piRIl53LF4ZfMVc4I1OSx4rephqWmIkm+yiiNFFe540IkDy1F0KGU=
X-Received: by 2002:a62:4e86:: with SMTP id c128mr17725609pfb.64.1564075441091;
 Thu, 25 Jul 2019 10:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190614080940.13640-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VfMdKqpC3_gF-VzcJQqiWM9E0irORr60KLXyu8HuQg9KA@mail.gmail.com> <37653b30-7a76-0896-ecb7-2fbeab4308ec@linux.intel.com>
In-Reply-To: <37653b30-7a76-0896-ecb7-2fbeab4308ec@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 20:23:50 +0300
Message-ID: <CAHp75VdEZ_VMEk3GjYYtgvSCOOOAMhZj-98B-+t__UdB207T8Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Add ICL-NNPI support to PMC Core
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:02 AM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Hi Andy
>
> On 29-Jun-19 6:48 PM, Andy Shevchenko wrote:
> > On Fri, Jun 14, 2019 at 11:14 AM Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@linux.intel.com> wrote:
> >> Ice Lake Neural Network Processor for deep learning inference a.k.a.
> >> ICL-NNPI can re-use Ice Lake Mobile regmap to enable Intel PMC Core
> >> driver on it.
> >>
> > This will be postponed till next cycle since the CPU model will not
> > appear before merge window.
> > So, please, resend than (I guess somewhat in a month).
>
>
> The dependent CPUID Patch is now upstream,
> https://github.com/torvalds/linux/blob/bed38c3e2dca01b358a62b5e73b46e875742fd75/arch/x86/include/asm/intel-family.h#L59
> so can you please apply this one?

Yes, it's in plan for rc2.

-- 
With Best Regards,
Andy Shevchenko
