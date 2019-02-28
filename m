Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B27C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A97218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551368624;
	bh=J9WrE2VsWzgE6S/GNSlX6y+qTwLDOpn23JemMH9aEuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yexI+slavTyW1yvVg1KNZXOXJwgnoqhRuoJggAqdOsQfm6KwRyAQYkAk91yyPNCz5
	 NN1YMqqgXVUlh1iWzefwP0dlmWHjfdMihVDuA7DpssI4AY3er7dt6PatLEE4HiGmGA
	 GGc+t0+d9DYOKBDKLqtVrTPM97/qoqDsXG9Z3lyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbfB1Pnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:43:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46359 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfB1Pnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:43:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id f2so17339322edy.13;
        Thu, 28 Feb 2019 07:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnnpQR0gxcxZFG4JmKjKJF97aHrwdFBLqkL5gz1v6b4=;
        b=rPd1O6b0IbhqPLxSXfB895v1/t6TD7UOqDbdj6GYpLVQOmwj3Rt5mpeJwUPq6R6ttl
         bXFRcwQasYN0+xJkllA4yAyQYFcSabfdCtGbvndhGdicTG4Lqtitf9pj6mN0LRwO5PyY
         je6Ey7mmewHztICxFzNqhxsghszYXPUZ8UYdA0dFEUvhBTTz8AokIORkGTCb8vocY+R2
         +EOXjKFu/xM/YA7AB1EvIDordXG/R3ecItpQKN4kGLGPkNGvFbY8wct2XV35koo3x8ZZ
         TM8OSQd3rPIwgljFG+Q2TL3qKd6tVE8J5HgTOp+nCW1z125Ej1e/tr/Gw+FV3ovEqTcx
         oH4w==
X-Gm-Message-State: AHQUAuaj9Cnn/aY/vAkNovxQg0XGbcdx5zkMGE3LWSYVjbbAOX0eIAJ4
        okC+WOTVDtCURDPsOjUCK5sVVxSNZdSuPRPPsk8=
X-Google-Smtp-Source: AHgI3IbgWlP8DIKYGnzDmO7EPBRxW4H6GLIc/GpqOVJ+j1FoXTQgzw6tjv9PC/OmJWR5bGcf13BhPlhLBNGpcJtq5RE=
X-Received: by 2002:a17:906:d0cb:: with SMTP id bq11mr5828761ejb.185.1551368621113;
 Thu, 28 Feb 2019 07:43:41 -0800 (PST)
MIME-Version: 1.0
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
 <204e9bf2afff8e6cb7a8a39d86038075f1bb4ab8.1551160674.git.len.brown@intel.com> <cacc41fd-240b-0589-ddd0-5e2dbf6df30d@intel.com>
In-Reply-To: <cacc41fd-240b-0589-ddd0-5e2dbf6df30d@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 28 Feb 2019 10:43:29 -0500
Message-ID: <CAJvTdKn_-DSW557o4k12381eOVX9o57x6k+ohXV76RNN0rEXXg@mail.gmail.com>
Subject: Re: [PATCH 04/14] x86 topology: Add CPUID.1F multi-die/package support
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 2:46 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/25/19 10:20 PM, Len Brown wrote:
> > -/* leaf 0xb sub-leaf types */
> > +/* extended topology sub-leaf types */
> >  #define INVALID_TYPE 0
> >  #define SMT_TYPE     1
> >  #define CORE_TYPE    2
> > +#define DIE_TYPE     5
>
> Looking in the SDM, Vol. 3A "8.9.1 Hierarchical Mapping of Shared
> Resources", there are a _couple_ of new levels: Die, Tile and Module.
> But, this patch only covers Dies.
>
> Was there a reason for that?

We have software visible modules and tiles in past products,
and those were discovered by family/model checks, rather than
enumerated.  I'm content to let that sleeping dog lay.
We don't have software visible modules or die enumerated with this
mechanism in any current or about to be current products.
When (and if) such products do come along, only then will we know
why software *cares* about die and tiles -- and that will be the time
to add that support.  Per below, I think this series cleanly prepares us
for that time.

> I wonder if we'll end up with different (better) infrastructure if we do
> these all at once instead of hacking them in one at a time.

Assuming that "hacking in" is a derogatory term, let me make the case
that this patch series cleanly sets the stage for the future.

old:

thread_siblings:  the threads that are in the same core
core_siblings: the threads that are in the same package

This naming scheme assumed that there would never be a topology level
between a core and a package.  Though we leave "core_siblings" intact
for legacy SW that depends on it, we mark it depreciated.

new:

core_threads: the threads in the same core
die_threads: the threads in the same die
package_threads: the threads in the same package

So in the future we could always add...

dave_threads: the threads in the same dave

So I think we are ready for whatever the future may throw at us,
while remaining compatible, consistent, and no "hacking in" required.

thanks,
Len Brown, Intel Open Source Technology Center
