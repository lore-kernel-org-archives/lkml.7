Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5E42075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhRMupoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDOKPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:15:39 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41493 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDOKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:15:39 -0400
Received: by mail-ua1-f65.google.com with SMTP id l22so5305832uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iq3yHrE+CJ75XNOtxQuw2nvnkvK1iLli9kQWKWHfgQg=;
        b=XhRMupooM1omcpYFbHy6zwTHZ1yMT9GQjZS4lRHkpY+7pxgQ0B0bcAM1RDYdijpW9Z
         QZJngcakAXC9pbsSZELPuL5lUivGgRC/ivrphR8cbC3tJxGsrx4DyLyoT7e2oE+5N0YX
         RstwWGkXHLfqvGO3GywwC/vdZrHRZmTV4+pmyBDm5o1VxCpI36qGF6hnAhW5yzyBb8+C
         dQU3adVyJJbHF8TWKBpT95TcjN0DfZ82JmA7fOGypZMEZuYwjkx3ZGBM3KdNks6gD/gO
         8wGXFwSfkewCxG3zUUmU7QdVe8c6lfPW5jw+ZS7LbysLtNvLkz4QvEdv8e6GPrqFa4gv
         Fx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iq3yHrE+CJ75XNOtxQuw2nvnkvK1iLli9kQWKWHfgQg=;
        b=Ra52gxQNn5Vqdv2pU4F1DDWlJX5WzvAq/swbgmjfRYoodkyDJZgAmfpbBwNdTcTWAM
         DuaRw8HA1Z5cg8Y/3FYh4yJdJtD6Gonse7k4hM8JKykvS7HRaKfooQaiAw8DhaQbKtbC
         blJM5jiEWjFfW8Y7FqePzK/V26kRy3LbDlGBgToZfluKkIAMm3GXuUyfaXMV2DYDeh6F
         0pTvQeikfJzmkBqcDO7rMvzmxG17Uq/Ok7gMktb039nPpdsbw+UdtVzD6FWugO6KlavE
         86yrFOCVnH3E2rdpp9yxMYnL6Iv5WGof2sVhhfVNVjTZ4SvTgjhpHvDgrPcdPRdIT7ZM
         KCAA==
X-Gm-Message-State: APjAAAWI4UVo+ifFewdDJ86eIRtASHbwsd0QKVU4hkTHokwO61X2acx9
        xOEvy6wCgyKlduYQbGj72lErDlgWKXfVl2yMDnoPKA==
X-Google-Smtp-Source: APXvYqx+anI5UadiGuiDZYgAN95DT/hpPeBo4AHuPgYdGvljuL5V2ABgJVIZlAZdrJMg05dDnEYSXs9+giXULcJjzDM=
X-Received: by 2002:ab0:6947:: with SMTP id c7mr15268061uas.51.1555323338100;
 Mon, 15 Apr 2019 03:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190412100227.15024-1-sudeep.holla@arm.com> <2000694.m04KBuNrDd@kreacher>
 <20190412101522.GB12424@e107155-lin> <CAPDyKFrM8hc36vp=2h1CHBZKapy1q242JD3Y5SfrCg-KWA-twg@mail.gmail.com>
 <20190412134200.GA23351@e107155-lin> <20190412141937.GA8600@red-moon>
In-Reply-To: <20190412141937.GA8600@red-moon>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Apr 2019 12:14:59 +0200
Message-ID: <CAPDyKFpjKAVPhpRmtO=7Boyh7aLv-BUQLY5GTKcQrM6gGP9=tg@mail.gmail.com>
Subject: Re: [PATCH v3] firmware/psci: add support for SYSTEM_RESET2
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 at 16:19, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Apr 12, 2019 at 02:42:22PM +0100, Sudeep Holla wrote:
> > On Fri, Apr 12, 2019 at 02:37:05PM +0200, Ulf Hansson wrote:
> > > Sudeep, Lorenzo, Mark
> > >
> > > On Fri, 12 Apr 2019 at 12:15, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Fri, Apr 12, 2019 at 12:10:45PM +0200, Rafael J. Wysocki wrote:
> > > > > On Friday, April 12, 2019 12:02:27 PM CEST Sudeep Holla wrote:
> > > > > > PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
> > > > > > where the semantics are described by the PSCI specification itself as
> > > > > > well as vendor-specific resets. Currently only system warm reset
> > > > > > semantics is defined as part of architectural resets by the specification.
> > > > > >
> > > > > > This patch implements support for SYSTEM_RESET2 by making using of
> > > > > > reboot_mode passed by the reboot infrastructure in the kernel.
> > > > > >
> > > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > > > ---
> > > > > >  drivers/firmware/psci.c   | 24 +++++++++++++++++++++++-
> > > > > >  include/uapi/linux/psci.h |  2 ++
> > > > > >  2 files changed, 25 insertions(+), 1 deletion(-)
> > > >
> > > > [...]
> > > >
> > > > > > --
> > > > >
> > > > > So I queued up the PSCI series from Ulf which clashes with this patch.
> > > > >
> > > >
> > > > Ah OK, I wasn't aware(just back from holiday) that it's going through
> > > > your tree. No worries, I will rebase and repost soon. I want testing
> > > > by xilinx or Aaro Koskinen before that.
> > > >
> > > > > I can take this one too, but I'd rather avoid becoming a PSCI maintainer as a
> > > > > result. :-)
> > > > >
> > > >
> > > > I can understand, I assure it's one off :)
> > >
> > > Speaking about that. I would gladly help out to host a git tree to
> > > collect patches that you have acked. In this way, we can, for example,
> > > get the patches pre-tested in linux next before we send the
> > > pull-request.
> > >
> > > If you think sounds like a good idea, just tell me so I can prepare a
> > > tree for the next release cycle...
> > >
> >
> > For now, I just have this one patch. So if Rafael has queued all your
> > patches, I can just rebase and post it once I get tested-by from Aaro
> > Koskinen, so that Rafael can queue this too. Or are you planning to
> > send PR to Rafael, sorry if I missed details already discussed on the
> > list.
>
> Mark and I can queue PSCI patches as we usually do, we agreed they would
> go via Rafael's tree (thanks) because of dependencies with the PM tree
> (that did not turn out to be there so we could have sent them to arm-soc
> just as well as we usually do), next cycle if and when there are patches
> to be queued we will queue them up and send them upstream ourselves.

Why I wanted them queued via Rafael's tree, is because of the
following series for PSCI that I will post in a a day or two, that has
dependencies to new changes to genpd.

My proposal with a git tree was mainly because of allowing patches to
be pre-tested in Stephen Rothwell's linux-next tree, before you send
the pull request to arm-soc. Or are you saying you already have a tree
for this, but not listed in MAINTAINERS?

In any case, it was just a suggestion to improve the working flow for
better tests etc. Feel free to ignore it.

Kind regards
Uffe
