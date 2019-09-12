Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A74FC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F9420684
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VsK63YxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfILOSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:18:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35253 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732565AbfILOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:18:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id t6so12988191otp.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=as20/K/wrQh0VcPp2JWZkYWpNUtTzdFQp/D51GEnJ2A=;
        b=VsK63YxZZ74Soq7i8sbb6fh8HuUwyRP41aJpm+IyEEVxbFiT+L+HI7tHr2Vtr0PsHQ
         fDXFh2WJkHcBM2sQqx1nz4YhINjpIBCvGC9TrFffsfvAIt4gr3yYNVISifAiKggfChWB
         2eA96VKb6o3jBW1xy3BW5dlaSz0jNJM08lR86GYMPhTh3k+K1N87uSTRdNbiDRyiowpt
         ZwXe3nzkYOIn1ZNixxsiuJTCR4BF0L25n4IU8DzNBCsoClLT/Gf5jHWOcunpLH27oWeT
         r5TNuXp8viQJvL/EuRe9CAFlXbBTqM99aMDd+dlIzc3ACil8+YLF6nLcaSfVseT69/36
         Ivxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=as20/K/wrQh0VcPp2JWZkYWpNUtTzdFQp/D51GEnJ2A=;
        b=L2PVdtbTAQnOsCi/LNZlqVIjTus8KkbfqrD2kjugygWTJLuqm5fw7AnMKkTSyhoyGM
         oHCi5IQud2rY/RWoiEiycyTrWjKYXsiQVbC5eH/1zZogG2qGjbYnR7U0XM7p8DNrTmJC
         +vc1Wiw1U5zyI7w95aFHl5IAV9WIqHNRehSxpfti8x+xkg3txODhHSMXtWYhsmPJsyeb
         Io6gIgfDzhfKRvdsBHvF5Lrn+dzD39J8Y2CxS34nZC0fuxgdbf72kce02y7TDujl8G6r
         CBDx83eQOvIA85la2ednppzpBiy258osi4fnxL/+hcOqZIkY4VHbMq+Xo7CHYenwOTZx
         3f1A==
X-Gm-Message-State: APjAAAW3lj8ElV0cNhYq9rCWqdbv/4lhG7S3Wvzkv2WjPsYQm0uODGEu
        XCG4CG3dPRJQmkorT6oOqL+grVyj9DjBTjUpqyixFA==
X-Google-Smtp-Source: APXvYqww7bFfGwyc5qF49rVm8WTD42K5tWa0xz3KchY2iJm2zV03eJqbCs0F8Uc+E8PPkm5kQfSl9zD6BO6JdIqdc4I=
X-Received: by 2002:a9d:6d15:: with SMTP id o21mr10806424otp.363.1568297884741;
 Thu, 12 Sep 2019 07:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
 <CANiq72k2so3ZcqA3iRziGY=Shd_B1=qGoXXROeAF7Y3+pDmqyA@mail.gmail.com>
 <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com> <5eebafcb85a23a59f01681e73c83b387c59f4a4b.camel@perches.com>
In-Reply-To: <5eebafcb85a23a59f01681e73c83b387c59f4a4b.camel@perches.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 12 Sep 2019 07:17:51 -0700
Message-ID: <CAPcyv4iu13D5P+ExdeW8OGMV8g49fMUy52xbYZM+bewwVSwhjg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 4:02 AM Joe Perches <joe@perches.com> wrote:
>
> (cut down the cc-list)
>
> On Thu, 2019-09-12 at 03:18 -0700, Joe Perches wrote:
> > On Thu, 2019-09-12 at 10:24 +0200, Miguel Ojeda wrote:
> > > On Thu, Sep 12, 2019 at 9:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > Now I come to find that CodingStyle has settled on clang-format (in
> > > > the last 15 months) as the new standard which is a much better answer
> > > > to me than a manually specified style open to interpretation. I'll
> > > > take a look at getting libnvdimm converted over.
> > >
> > > Note that clang-format cannot do everything as we want within the
> > > kernel just yet, but it is a close enough approximation -- it is near
> > > the point where we could simply agree to use it and stop worrying
> > > about styling issues. However, that would mean everyone needs to have
> > > a recent clang-format available, which I think is the biggest obstacle
> > > at the moment.
> >
> > I don't think that's close to true yet for clang-format.
> >
> > For instance: clang-format does not do anything with
> > missing braces, or coalescing multi-part strings,
> > or any number of other nominal coding style defects
> > like all the for_each macros, aligning or not aligning
> > columnar contents appropriately, etc...
> >
> > clang-format as yet has no taste.

Ok, good to confirm that we do not yet have an objective standard for
coding style. This means it's not yet something process documentation
can better standardize for contributors and will be subject to ongoing
taste debates. Lets reclaim the time to talk about objective items
that *can* clarified across maintainers.

> >
> > I believe it'll take a lot of work to improve it to a point
> > where its formatting is acceptable and appropriate.
> .
>
> Just fyi:
>
> Here's the difference that clang-format produces from the current
> nvdimm sources to the patch series I posted.
>
> clang-format does some OK, some not OK, some really bad.
> (e.g.: __stringify)
>
> My git branch for my patches is 20190911_nvdimm, and
> using Stephen Rothwell's git tree for -next:
>
> $ git checkout next-20190904
> $ clang-format -i drivers/nvdimm/*.[ch]
> $ git diff --stat -p 20190911_nvdimm -- drivers/nvdimm/ > nvdimm.clang-diff
> ---
[..]
>  25 files changed, 895 insertions(+), 936 deletions(-)

So, I'm lamenting the damage either of these mass conversions is going
to do git blame flows. To be honest I regret broaching Coding Style
standardization because it's taking the air out of the room for the
wider discussion of the maintainer/contributor topics we might be able
to agree.

As for libnvdimm at this point I'd rather start with objective
checkpatch error cleanups and defer the personal taste items.
