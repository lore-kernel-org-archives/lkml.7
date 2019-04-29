Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE87C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D0320449
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTRFAg/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfD2J5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:57:40 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46644 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfD2J5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:57:40 -0400
Received: by mail-vs1-f68.google.com with SMTP id e2so5493638vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iKcYMeHTvYV/ojGAif7LIimREuXBzjZ/IIn9Py+Bbk=;
        b=KTRFAg/QdIUZp9cOyAOJyKToCNwB5jdZZ3iUmC4NlCLEd502dosyUJGt2Em5CTT6BI
         G+PDiK1BmQyJTczToyRZHM3v2L0dPLhRqxnWzB/vXyjnwUAFbECrcIX0OHTgugquVHcq
         MTc+MpBOo0dRtfP/23qPClXOMT7HYlUpZA6WN47uiI3p3jkllys/RXUpXeoxq+JsqfXd
         Gmx3ICMPTi4GuJLhms1sK8bR7rnG7Ps+qdDWKNsvaRtlWvD/yJGwkB3EqJvlLEmLBiqQ
         y/EFQhp8D9oSVk+2IW16s6TKJVI8LmDgYc5fSYxUxmaJWSeRzjJHMpVqJUC436syraRg
         rmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iKcYMeHTvYV/ojGAif7LIimREuXBzjZ/IIn9Py+Bbk=;
        b=OlBtdv0El7VKs+Kq/iSK2rYySqDpqFjR9XgfKhVyR7sT8Z394wTcCW7ygklXXD3nAk
         J7HeSopxVB7DrQIi2wSKJITBAEiHSKlfDCriqF0G4ajrVfXltJ6OqVU0t2BO1x/5fM5c
         xdZQDlH1ethX4jUmCHhXXSCIncFprMKzoJZwbnBGWwW1b/7znPZbvSQCDyCAZx1gTCsw
         yw0L3cnJAu/06WEun1u5A3bf/zMlFWWTH38vnC1VIa7U9igDJrBKV+bIl6hGBfHNdcST
         T5zz/6CZYyVaPmWnykSgVuRKZmCebr9QgaILKwHCTqTXIYaZMXOU8+5sdCv+Ap0GXwpA
         OxGQ==
X-Gm-Message-State: APjAAAVtdTDK6uvLxk2GAS7Lkn97IDw/VxH2odhlZ/xjpwrl8SIN3/Kq
        7IH+f8IL2ao0CyQOSHRiieh6IMTa5qbopdv690St4Q==
X-Google-Smtp-Source: APXvYqw+DVB4A+oWlNfEJ4yNNJr2mpCLIYulP2TaMYSs5AmWe1v0HQOvm7D6Arhq68xHL7FgRmeTGLEYBftg5kM/1P8=
X-Received: by 2002:a67:8155:: with SMTP id c82mr2462997vsd.200.1556531859282;
 Mon, 29 Apr 2019 02:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190416183257.247902-1-rrangel@chromium.org> <CAPDyKFqYNMhDKy94zV8Bk80OUiS9JNFf2EmkbhJ0W_N=5=bZJQ@mail.gmail.com>
 <20190424153115.GA186956@google.com>
In-Reply-To: <20190424153115.GA186956@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 11:57:02 +0200
Message-ID: <CAPDyKFqerMeQey0wJW3Ctohh77CJs6-PxSaR=T6ive_Rx-oMMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add trace events for SD registers.
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Daniel Kurtz <djkurtz@chromium.org>, zwisler@chromium.org,
        Steven Rostedt <rostedt@goodmis.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 at 17:31, Raul Rangel <rrangel@chromium.org> wrote:
>
> On Tue, Apr 23, 2019 at 08:29:15AM +0200, Ulf Hansson wrote:
> > On Tue, 16 Apr 2019 at 20:33, Raul E Rangel <rrangel@chromium.org> wrote:
> > >
> > > I am not able to make a single event class for all these registers. They
> > > all have different struct sizes and different printf formats.
> > >
> > > Thanks for the reviews!
> > >
> > > Changes in v2:
> > > - Made trace_sd_scr print out flags.
> > > - Add BUILD_BUG_ON to make sure tracing stays in sync with structs.
> > > - memcpy using sizeof(__entry->raw)
> > >
> > > Raul E Rangel (4):
> > >   mmc: core: Add trace event for SD SCR response
> > >   mmc: core: Add trace event for SD SSR response
> > >   mmc: core: Add trace event for SD OCR response
> > >   mmc: core: Add trace event for CSD response
> > >
> > >  drivers/mmc/core/mmc.c     |   4 +
> > >  drivers/mmc/core/sd.c      |  10 ++
> > >  drivers/mmc/core/sd_ops.c  |   6 ++
> > >  include/trace/events/mmc.h | 204 +++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 224 insertions(+)
> > >
> > > --
> > > 2.21.0.392.gf8f6787159e-goog
> > >
> >
> > Why do you need this? We already have these card registers reflected
> > though sysfs files, isn't that sufficient?
> >
> I was not actually aware that the registers were exposed via sysfs. I
> was debugging a problem where the host controller was returning all
> zeros when reading from the card. I wasn't aware that it was returning
> all zeros until I added tracing. It made it quite easy to diagnose the
> problem by just diffing the two traces.

This sounds like a quite an unusual problem, and I don't think having
the buffers printed via tracing is worth it.

Moreover, we already have tracing per command/request (but don't print
the buffers), that should cover most of error cases during init, don't
you think?

[...]

Kind regards
Uffe
