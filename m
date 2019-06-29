Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76209C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CD520656
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 16:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UELpZdFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfF2QBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 12:01:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42521 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF2QBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 12:01:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so4437859pff.9;
        Sat, 29 Jun 2019 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idR9v5tQce42+52EX6Bs+N339gM2s4yw6+BqLcikr5s=;
        b=UELpZdFnfLpDWcA25Vj74xvg9NlYcZfaeH2hHjAfxAfo9Me7oBkXYXhfCRcndmjrk9
         3C9On7eAJllObpSJDu1+tySeaRQz+brF0gP9deLKYAp68pfqekGiMKvv3JQSw7xS5UqX
         to4a+sNygZfw55b+rPBmGrFbGWbic2zFao4MkYt69UobwCQO1HMwMkKzglfZjwc4Owr3
         HBy2O0NlobOvPyjBbU5l8X6JrcNcr1NCwuJsO/HD3x3DFu8FBr8L3E326XuUMhAGQ8uP
         6bxkssHWAmYm/SLdXikEPm865oCoH+P4RXuY8k6dsyB4rqeVsqmxBVwVV3m23toQEkL+
         2dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idR9v5tQce42+52EX6Bs+N339gM2s4yw6+BqLcikr5s=;
        b=SrZk+gcKgD2mCleOWnwCEoBS5hsstU4Q3ac6mskdDwJpFuFSmNNLiJDQCusZEVVN2Y
         YyRdvqyDh+xcAZNjIzbLxUDvB4JwY9XpBS8lAIWqXPmXx1hPT4T5KfZ0u63vS5gHvcRN
         5HrrqFY/dP6ZSISt1L3Puds1vnDP/YgPpG44GTWZsdAJXmwNy7arNMm/EWYBRLUGZVAR
         CY9Ix0zAeIIPW+FoNBNyI2g3NQOIvJ9fTelOohve8RFJFgag13RQhv/scE+dikqHdgo0
         HhZG/PmIf7zarLYaMyPdpMCyOMVdHMkbahsbfLpyF+KelkFmGtATwWEZA1bYZOfWY5um
         cdsQ==
X-Gm-Message-State: APjAAAU4w9Kbufx+sLF/KCCjVHhFlt390HZTSjsTJctCRqmGgxAa0EHz
        CszTb4R2bbNACysAiS1GGDrL+K1CHyGzpX9QorU=
X-Google-Smtp-Source: APXvYqwzOuR8YKjC4KQNgiPvXJ4FHEmYoQu3ifa02OEDUpGEiJejAB7eZwDkTQ4zYFJmonxGPiDtN91uOeLVqah1G1M=
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr20502355pjb.132.1561824060733;
 Sat, 29 Jun 2019 09:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
 <20190626223851.19138-11-srinivas.pandruvada@linux.intel.com>
 <CAHp75VfMDpKyYnZkZw51dwcEt5neQwGuZUaB7yEFQW6fjRYCqg@mail.gmail.com> <1c4238f7d18d316df82d3ba1618fecdcf014f98a.camel@linux.intel.com>
In-Reply-To: <1c4238f7d18d316df82d3ba1618fecdcf014f98a.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 19:00:49 +0300
Message-ID: <CAHp75VfZLjtAKwFWYp32YgPc_Nq6nCGpNwrXYCp-=m38+2r-Mg@mail.gmail.com>
Subject: Re: [PATCH 10/10] tools/power/x86: A tool to validate Intel Speed
 Select commands
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Cox <alan@linux.intel.com>, Len Brown <lenb@kernel.org>,
        prarit@redhat.com, darcari@redhat.com,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 5:53 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Sat, 2019-06-29 at 17:31 +0300, Andy Shevchenko wrote:
> > On Thu, Jun 27, 2019 at 1:39 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:

> > > +++ b/tools/power/x86/intel_speed_select/Makefile
> >
> > My experience with some tools are not good in order of their build
> > process.
> > Can this one use tools build infrastructure from the day 1?
> Can you give some pointers?

Sure.

At least simple ones are under tools/gpio, tools/iio, etc.

You may compare them to see what's different and what's common and
base Makefile here on that.

I dunno if there is any tool under tools/power to use that, it might
give an example of `descend` feature in Makefile.

> > > @@ -0,0 +1,31 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +CC             = $(CROSS_COMPILE)gcc
> > > +BUILD_OUTPUT   := $(CURDIR)
> > > +PREFIX         ?= /usr
> > > +DESTDIR                ?=
> > > +
> > > +override CFLAGS += -D__EXPORTED_HEADERS__ -Wall -D_GNU_SOURCE
> > > +override CFLAGS += -I$(CURDIR)/../../../../include/uapi/
> > > +override CFLAGS += -I$(CURDIR)/../../../../include/
> > > +
> > > +%: %.c
> > > +       @mkdir -p $(BUILD_OUTPUT)
> > > +       $(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
> > > +
> > > +DEPS = isst.h
> > > +OBJ = isst_config.o isst_core.o isst_display.o
> > > +
> > > +%.o: %.c $(DEPS)
> > > +       $(CC) -c -o $(BUILD_OUTPUT)/$@ $< $(CFLAGS)
> > > +
> > > +intel-speed-select: $(OBJ)
> > > +       $(CC) -o $(BUILD_OUTPUT)/$@ $^ $(CFLAGS)
> > > +
> > > +.PHONY : clean
> > > +clean :
> > > +       @rm -f $(BUILD_OUTPUT)/intel-speed-select
> > > +       @rm -f $(BUILD_OUTPUT)/*.o
> > > +
> > > +install : intel-speed-select
> > > +       install -d $(DESTDIR)$(PREFIX)/sbin
> > > +       install $(BUILD_OUTPUT)/intel-speed-select
> > > $(DESTDIR)$(PREFIX)/sbin/intel-speed-select

-- 
With Best Regards,
Andy Shevchenko
