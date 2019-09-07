Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186CDC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23B621848
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZc+/AEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfIGSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:18:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33067 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbfIGSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:18:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id t11so4703801plo.0;
        Sat, 07 Sep 2019 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KpXd8+E0H56p8I4bFGmpPfO+KfUXqH1zeKBuS+WLBA=;
        b=PZc+/AErWKEp8Lf0CLmFpEsSwHYWZh1SVOV1LGkWNAe/8yzB9kF0/jQykiDIgt5Y6U
         5X+N4Yja1Y/y6yUoXbA8ByP1KfYcybE1o48/SZ2tGz3g187M1Z+I8ygv7yvyX2MsJsSx
         8sSL7lAi2PrJxygDeNja7dP39C4lwtJzx97rt1x9solRgyV8pnZqCq3N6wYJDtqHg9B8
         Af3YJy7FBtplXzILhbcloIiy+Qhx46VgjcaeikDt6bKu5LDhOGIE0AQFtsZdg3iP2VMU
         gO9D5A3FbiFWpCbe3l5mM/AzHcwChFz43JtAE3O8bB+7jBwp4/3nEImW54zjdXjAgNqW
         IJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KpXd8+E0H56p8I4bFGmpPfO+KfUXqH1zeKBuS+WLBA=;
        b=m74z8a+4jHVDRt0YbVbIleE/t4EGnU+mAxr8cv14g/YuCgUfBl67okvvDq0dksv+Jp
         TrBbZi54IvSAUpmxSHssdEIcLHIIF3ElOfu324g1Chz7P0FQ+JwUrb/fcEK2nuQC+qeG
         W9T04hb+uHAUFcYW3WdB54CyvUlb53dKdsfq98oRllj6kc/doCqgziDXkDaujxe/aw+m
         3qdRCGNAYkK2ZNA7U4SgHUpzNXfiiM9r43CySNUXS0N212ZKWoDdMuu1uCjbT7fMMIt8
         lmT+lJOwycKIKU0Tp/HWDvaB2aqm9Z4Eq6S1O8ZcOCRvQzm8L5iW+vUW6kT717CiH3eX
         UFJw==
X-Gm-Message-State: APjAAAXFWoxaLHrbjtvpBo+tiump+/oepz36Es+4jKqktZHhum3rAXss
        NA6yXceji+n56lPxfD+QCmzXvcqgs0cYV5f/ilM=
X-Google-Smtp-Source: APXvYqwphaPzifCYArwcPAZCl2cUc6xY8wK8sS2Kvf2ZG7LnsD3XmU/MV5GZ6E5Y5q4JUlNCEWHcHHqy9svvakb0wHU=
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr15522432plp.262.1567880304287;
 Sat, 07 Sep 2019 11:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190905233748.6822-1-srinivas.pandruvada@linux.intel.com>
 <20190905233748.6822-2-srinivas.pandruvada@linux.intel.com>
 <780a3faf-9e44-64f4-a354-bdee39af3af5@redhat.com> <20190906134655.GU2680@smile.fi.intel.com>
 <6b576770a4bbe6c24ea524083dec5a16bf3c9e94.camel@linux.intel.com> <b8c7bd1204f7b4f75a5bccec4d7c41b1225928f7.camel@linux.intel.com>
In-Reply-To: <b8c7bd1204f7b4f75a5bccec4d7c41b1225928f7.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Sep 2019 21:18:13 +0300
Message-ID: <CAHp75Vc9xMPW38Toh2jKv9YYYNV16837aAcXKMP6WaM-L8zcSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power/x86/intel-speed-select: Display core
 count for bucket
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 10:47 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2019-09-06 at 07:50 -0700, Srinivas Pandruvada wrote:
> > On Fri, 2019-09-06 at 16:46 +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 06, 2019 at 05:39:54AM -0400, Prarit Bhargava wrote:
> > > > On 9/5/19 7:37 PM, Srinivas Pandruvada wrote:
> > > > > Read the bucket and core count relationship via MSR and display
> > > > > when displaying turbo ratio limits.
> > > > > +       ret = isst_send_msr_command(cpu, 0x1ae, 0,
> > > > > buckets_info);
> > > >
> > > > ^^^ you can get rid of the magic number 0x1ae by doing (sorry for
> > > > the cut-and-paste)
> > > >
> > > > diff --git a/tools/power/x86/intel-speed-select/Makefile
> > > > b/tools/power/x86/intel
> > > > index 12c6939dca2a..087d802ad844 100644
> > > > --- a/tools/power/x86/intel-speed-select/Makefile
> > > > +++ b/tools/power/x86/intel-speed-select/Makefile
> > > > @@ -15,6 +15,8 @@ endif
> > > >  MAKEFLAGS += -r
> > > >
> > > >  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> > > > +override CFLAGS += -I../../../include
> > > > +override CFLAGS +=
> > > > -DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
> >
> > No, we can't use msr_index.
> This comment was meant for use of /dev/cpu/X/msr not msr_index.
> I didn't want to bring in dependency on msr-index.h for couple of 2
> MSRs and the names in msr-index.h doesn't really reflect the actual
> processing, they are doing. For example MSR_TURBO_RATIO_LIMIT1 for
> 0x1ae. The definition of 0x1AE is different on cpu model 0x55 and
> beyond.
>
> >

It seems not applicable on top of tools patch series I had applied before.

> > >
> > > I guess it can be done in more neat way.
> > >
> > > > As I've been looking at this code I have been wondering why
> > > > didn't
> > > > you just use
> > > > the standard /dev/cpu/X/msr interface that other x86 power
> > > > utilities (turbostat,
> > > > x86_energy_perf_policy) use?  Implementing msr_read() is trivial
> > > > (warning
> > > > untested and uncompiled code)
> >
> > No. We can't. The MSR interface is disabled on several distribution
> > and
> > platforms with secured boot. So some special MSRs are only allowed
> > via
> > this IOCTL interface.
> >
> > Thanks,
> > Srinivas
> >
> >
> > >
> > > Actually good point!
> > >
>


-- 
With Best Regards,
Andy Shevchenko
