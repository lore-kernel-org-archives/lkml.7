Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0800EC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB0C20665
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 16:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAxJBw+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfF2QDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 12:03:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34639 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF2QDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 12:03:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so3962443pgn.1;
        Sat, 29 Jun 2019 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mj6lLd3HbTUYn9486O6rCQ2CRQYR6mH4Csh8zTZf/iE=;
        b=NAxJBw+GPJ89GAiLqt7tefebjE2vl497CvTA9eTrw0ju+e1xAxCPh+YfMu0tZ/FQZ2
         xfallAY41jj/rGG913KI1emmqu6KVmr/Wblg08YQLZ0LqfikuLfMYnhHAOxhrQLCcwfi
         o+6jib2tK8uUihsefni9tLQ2KPSWjjGRjW3FN8wQORJxXR8Mr6+4zhnfVkV5H4yYXGeX
         rBi4uzwFuIPgBBbuLL+lbt8mSSFRcZTG+UQynxe7gEPOb/QLirR5UDo+0YyEFuDmHfWP
         n2ZBhrxTA18ofqX9ns7sPVVyiBtezg/6sujczsgU+GuBIcWV4ElhlXOtlFWB9Cek9W25
         e7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mj6lLd3HbTUYn9486O6rCQ2CRQYR6mH4Csh8zTZf/iE=;
        b=DLoUM62AYoy4ZSC98cRJv+sKPygp0xwmhp+R4MycGtY0fVF40Iys6kJFfFoRBczCrp
         /NIa4sgr3+MlyiN0fn5BHYm/1sgk1liSnX0wGMIMJ7Z9anAqCcLKPztqM7B/PpXsbNj/
         wiOMT1du0PFtcu8h+saFaOYH8/pUbBKjqX28JynwjQn4GoPNENuE2ERn2GoQSwjMXiW/
         otsl1EE1rqVDAxX2v2sgi8b2Yrzp7Ualy2KKambsYn7gnJ1cCaH3e2nOmeeLZYQtH8z4
         sYMdqwbSbWnElRJfMICL5ek8Pffj0TVoEp2iWfaesC/g/HKgQtzWQGqqKnSnlNDPIZkE
         +ldg==
X-Gm-Message-State: APjAAAWAswlrFtEcsHgF+S47pZ4aabn2RMlcMZwjJ15iWojIkmMZm3VF
        cL9xcAVPj5Ra/e41lawEdXv6OHH5oZZyCCe9IWE=
X-Google-Smtp-Source: APXvYqzP56qr3bwmYr9BiWj9eeabXtSVwEP/BWnrFi9ZHy72ma17v5rmlQizU5Q4o2afeX2pLDekWDTOuveWm8TSn3o=
X-Received: by 2002:a63:f346:: with SMTP id t6mr15761391pgj.203.1561824231122;
 Sat, 29 Jun 2019 09:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
 <20190626223851.19138-11-srinivas.pandruvada@linux.intel.com>
 <CAHp75VfMDpKyYnZkZw51dwcEt5neQwGuZUaB7yEFQW6fjRYCqg@mail.gmail.com> <1c4238f7d18d316df82d3ba1618fecdcf014f98a.camel@linux.intel.com>
In-Reply-To: <1c4238f7d18d316df82d3ba1618fecdcf014f98a.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 19:03:40 +0300
Message-ID: <CAHp75VduxgJ6k4J2bB83Xbif0D0AGkxyDAdwvN64ybxdxXHXcw@mail.gmail.com>
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

> > I need an Ack from tools/power maintainer(s) for this.
> > Also see below.
> MAINTAINER file doesn't call for any special name in this folder.

And this tells me perhaps this driver needs a MAINTAINER record?

> $./scripts/get_maintainer.pl 0010-tools-power-x86-A-tool-to-validate-
> Intel-Speed-Selec.patch
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:31/31=100%,added_
> lines:231/231=100%,added_lines:1607/1607=100%,added_lines:721/721=100%,
> added_lines:479/479=100%)
> linux-kernel@vger.kernel.org (open list)
>
> Len and Rafael can you ACK this tool patch?

-- 
With Best Regards,
Andy Shevchenko
