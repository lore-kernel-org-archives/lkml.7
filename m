Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A00C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3DB218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EGCp7Q7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfB1X4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:56:10 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39509 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1X4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:56:10 -0500
Received: by mail-oi1-f194.google.com with SMTP id b4so18066176oif.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uERLKdxddlDUmJblszVciWCaFSRB2PW3RWK+BP8ZSsU=;
        b=EGCp7Q7n1qKJ1I8XM59ZgdiZ69fefYWbcALHIz/rmNAz1BI1AtFlaoRcHCO1OuhArI
         UbO5IVqSohO/zBsgYoWyvgKMw3ZD4WLR5D9lnsoRLYkZvj/IQ8+zrwCXpRSR6cqzNNfK
         yr3tm0bDnvjELQyA7bh0juxUwbvGhmYRFUPL89npUioIQld1mxpqk7aaUCbpmmrZyyIy
         b0be3jXU+MUt/oeqB8UziuWx5ZMyp52bUeNpb9ExF1fVXNdaEf/O90hSEwWfFmTbkJSM
         odWuNpcEwU6dIpsOMn8nqqxlSEByu1Si8rd2k4DYlA156WmD0D41zpEsIpeU+5NdluUs
         tLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uERLKdxddlDUmJblszVciWCaFSRB2PW3RWK+BP8ZSsU=;
        b=G3WLG8/XrDJXwSugoo081hv2ZXpdItYRadASF4ga1diXOWXAroVcRZxy3C4mynVmMM
         nv9qVQENLROa2MAIRCqjx5MKWKjOjUHVX4fhLtPmNke162zC+1tABstFtN0PCkW6hzUU
         Hw5kkQ8EsyVGYhx5xwth7SlrJ+Dcs7ktx3pihYBxEo/81p8/EDW7ZGysqisou67CFfwD
         USoChTlAjXVv/dhcHTtqRQ9uaJD8Sh7pVfnZDnaT2J4anEvTbIXHDKnG9/u7HGSAP9X+
         iQFj8kMOBmIWe8iBCRSYf8QBuVJI8f4LM9kWRY8yViWFQwt0/gUCs5FMy5yWrF7h35v+
         HRtg==
X-Gm-Message-State: APjAAAUWMz5Pm5CRMcSax6BqxKQDtfp7R0YHVgSNKWlIBCYK/iVSoz+w
        AfSnr537yqWDvrvyxno654AJlZ5ahFLH4jGw5VSEUw==
X-Google-Smtp-Source: AHgI3IYwCchoLH3Wwe6rNTWF9xU4YpN1DXRKUzvI+0jK+ayx/oEgCTjUfXt4uS7RGHmAP07O3BqHkKJqrIPkyu8JL2M=
X-Received: by 2002:aca:3906:: with SMTP id g6mr1575935oia.149.1551398168978;
 Thu, 28 Feb 2019 15:56:08 -0800 (PST)
MIME-Version: 1.0
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com> <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
 <20190215185151.GG7897@sirena.org.uk> <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com> <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
In-Reply-To: <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 28 Feb 2019 15:55:57 -0800
Message-ID: <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        guillaume.tucker@collabora.com,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 26 Feb 2019 16:04:04 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Tue, Feb 26, 2019 at 4:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 15 Feb 2019 18:51:51 +0000 Mark Brown <broonie@kernel.org> wrote:
> > >
> > > > On Fri, Feb 15, 2019 at 10:43:25AM -0800, Andrew Morton wrote:
> > > > > On Fri, 15 Feb 2019 10:20:10 -0800 (PST) "kernelci.org bot" <bot@kernelci.org> wrote:
> > > >
> > > > > >   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
> > > > > >   Plain log:  https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.txt
> > > > > >   HTML log:   https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.html
> > > >
> > > > > Thanks.
> > > >
> > > > > But what actually went wrong?  Kernel doesn't boot?
> > > >
> > > > The linked logs show the kernel dying early in boot before the console
> > > > comes up so yeah.  There should be kernel output at the bottom of the
> > > > logs.
> > >
> > > I assume Dan is distracted - I'll keep this patchset on hold until we
> > > can get to the bottom of this.
> >
> > Michal had asked if the free space accounting fix up addressed this
> > boot regression? I was awaiting word on that.
>
> hm, does bot@kernelci.org actually read emails?  Let's try info@ as well..

Thanks, yes. The logs don't give much to go on, so I can only iterate
on this as fast as I can drum up feedback.

>
> Is it possible to determine whether this regression is still present in
> current linux-next?
>
> > I assume you're not willing to entertain a "depends
> > NOT_THIS_ARM_BOARD" hack in the meantime?
>
> We'd probably never be able to remove it.  And we don't know whether
> other systems might be affected.

Right, and agree. I was just grasping at straws because I know of
users that want to take advantage of this and was lamenting the
upcoming apology tour saying, "sorry, maybe v5.2". I had always
expected that platforms outside of x86-servers would need to do their
own validation / evaluation before recommending this, and the
regression concern is why it defaulted to disabled... but boot
regressions are boot regressions.
