Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DABC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0524A2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwH2W+E9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfH2QOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:14:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41350 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfH2QOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:14:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id i4so4270568qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdsbyusGiMRkq6kSVVJ1Tni1iJ0D5Lbbif3gwg/K05I=;
        b=rwH2W+E9cpx2iUbbR7UKUGi/jJ6G+nWXtKfJWQvfIh0dWzORi2lxzSjWDUtlwhjDDt
         u0Z+A9YIB1GzPOnTHPPY3i7BDquPMoJs4nu+mpurcn+a10tVRAsAMHCb8KLywlqlEUq8
         o1HgP+Z2B3/laH1886ucMyl55HHZBKdx+nrNEpFCC40oz37OGfIiRkeWfqE5xeEQ/PH1
         /+V3V/fVNEAUTMK0aajSgJffJLVB0iQx2TviNLCuyUoQ5F7+aBqM9iKiKVfGBs9l+z/S
         zqP5ijZOw6SuO5gbwOZfiO3zywp9PewKIkRlQ7eftXdJTauLMWQpmMdJrLXYEh5ghwmV
         VIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdsbyusGiMRkq6kSVVJ1Tni1iJ0D5Lbbif3gwg/K05I=;
        b=BUgdt4pHaaVdKs2jbb642KeNGr9AUP9QA8WcnT+gwWm5kei4mrv3/FVfy1RMVJL0CC
         H4HfptUjuzYBSWvXsxFVOUdLmM8CwJilsPmkB9Kh8vAMjJtDkmVyNaY6FAQPBapbAwH6
         Qne29lqy1kGYp9PPIjRxJWHqqDVxn+p+9bosi31dLzSH1362NMr0OnASJB16WlUR7Pw3
         tWR/chf5W0kQc8AO1czZf9p7rs2ZW3QKOh7HKmPO/FV+s/KXHK83YwUJnSE95AmF1QuI
         MGs4H1PN0yhaBtq/SYYXKHGRxwHWZQPck5zqRGiufZdcuGvVh9055tK76kJAEa1rkiKg
         g7Zg==
X-Gm-Message-State: APjAAAXC0MH5a3aPqQYBRpkAUUYcaexKb3VuoXzAF67q4S3J6jfBlehL
        PhqtnC68vrsq9Z9rqM/+uKZ++OOhJWpfeTatGu5wrA==
X-Google-Smtp-Source: APXvYqzj6FfEUctPCaUrep4Pr2nFnlVE+D9Q0UCJJ9LCNcByKgj2f+9/1JxEaBfdMrP14mUMcPjz6vkLNAQTrT9ghSI=
X-Received: by 2002:ac8:4612:: with SMTP id p18mr10715186qtn.49.1567095255854;
 Thu, 29 Aug 2019 09:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <93fa782bde9c66845993ff883532b3f1f02d99e4.1566907161.git.amit.kucheria@linaro.org>
 <20190829140459.szauzhennltrwvg4@holly.lan> <CAHLCerNuycWTLmCvdffM0=GdG7UZ7zNoj0Jb0CeLTULzVmfSJw@mail.gmail.com>
 <20190829151912.z6cflsaox2qnmqxw@holly.lan>
In-Reply-To: <20190829151912.z6cflsaox2qnmqxw@holly.lan>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 29 Aug 2019 21:44:04 +0530
Message-ID: <CAP245DWqbFnKVW9BYCzUMH=Ub+0j=3ycj-=MiPzRRW1Zv5LUmw@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] drivers: thermal: tsens: Add __func__ identifier
 to debug statements
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 8:49 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Aug 29, 2019 at 07:58:45PM +0530, Amit Kucheria wrote:
> > On Thu, Aug 29, 2019 at 7:35 PM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Tue, Aug 27, 2019 at 05:43:59PM +0530, Amit Kucheria wrote:
> > > > Printing the function name when enabling debugging makes logs easier to
> > > > read.
> > > >
> > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > > Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > >
> > > This should need to be manually added at each call site; it is already
> > > built into the logging system (the f flag for dynamic debug)?
> >
> > I assume you meant "shouldn't".
>
> Quite so. Sorry about that.
>
> > I haven't yet integrated dynamic debug into my daily workflow.
> >
> > Last time I looked at it, it was a bit bothersome to use because I
> > needed to lookup exact line numbers to trigger useful information. And
> > those line numbers constantly keep changing as I work on the driver,
> > so it was a bit painful to script. Not to mention the syntax to frob
> > the correct files in debugfs to enable this functionality.
> >
> > As opposed to this, adding the following to the makefile is so easy. :-)
> >
> > CFLAGS_tsens-common.o          := -DDEBUG
> >
> > Perhaps I am using it all wrong? How would I go about using dynamic
> > debug instead of this patch?
>
> Throwing dyndbg="file <fname>.c +pf" onto the kernel command line is a
> good start (+p enables debug level prints, +f causes messages to include
> the function name).

That's useful to know.

$ git grep __func__ | wc -l
30914

Want to send some patches? :-)

> When the C files map to module names (whether the modules are actually
> built-in or not) then <module>.dyndbg=+pf is a bit cleaner and allows
> you to debug the whole of a driver without how it is decomposed into
> files.

And if changing the kernel cmdline options isn't possible or is inconvenient?

> There are (many) other controls to play with[1] but the above should be
> sufficient to simulate -DDEBUG .

The "hard" bit is explicitly poking the line number in a file to
activate a paricular pr_dbg statement. Even if I scripted it, those
lines numbers keep changing in an actively developed driver.

Somehow, I've always felt dyndbg was more useful to debug a production
system where recompiling the kernel wasn't an option e.g. reporting an
issue back to a distro-kernel vendor.

> Daniel.
>
> [1]
> https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
