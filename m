Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA04C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036B1206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563213634;
	bh=IqH4lbm8RDQxVT1NcYM6JBXGNOyAGtB3m7tdJOSg2g8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xv0nhbpr3tRpQAjJLyn6qwAPt7uW65AnrEIgI2Nu4BTVaFkt67YQMrDre4qYvhOKH
	 7LCkYT9CZ3LmHwyMWPnlEiTB6Knucdgxw1ff32/iZGE37nsD/3P0qb+a7dmVHIUlDH
	 /H189ym7WRhufJpj3L6KOejAJoMYwrMcLAXR4V3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfGOSAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:00:32 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:37149 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfGOSAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:00:32 -0400
Received: by mail-lf1-f51.google.com with SMTP id c9so11641316lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nO5O+YvT7yDDwaOrG6FBszo4i//OnQ067kGK33ZDVmM=;
        b=Ljprv0R0eic6HXzVS6gGqcdFzlGrHqGYh6k6OB97GCmdfmdhLVrBCs9Un6FdrcVa0i
         O9IjGbq520L8/BcFC8NSOMIeu5mjyLm2K8K95eccEhBRuXPdvPX2VnOOtry2mMJf084F
         T/TlaTAimYnlETp3HtOetlLmvrSLFF8LPoLEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nO5O+YvT7yDDwaOrG6FBszo4i//OnQ067kGK33ZDVmM=;
        b=i3HoMwmlViL+1Z9+4nB/YcMOxNlUDNm2DuDXJPZ8fJazt1Cg6vnsaarAOlj8FPm104
         CJsVAfPGA7CZcY2iW/I8Gg0eIRCLgfKRxOZdmMWA3htpqq8bVc+FJLdkHMLaAh+YF2/d
         niBEnsj4u/QJ3y7C780pxPjBgjvs6ZZiC4e3Bqk1Lb7kF+8Dx1kJ5tmQegVpJXFRMS9W
         F+V7ABluU1BL9d/zaIjvtlgoPQ2LswDKcWFYdptEWx+R3zLV1cC3dWi5gnQG7ewFY2ec
         9sMBIVpXYIc/SNisdwKL9SgBTR2tAnNtTSquqoL59FH+813VrB9/pbTRwI4z40DanuZT
         PtgQ==
X-Gm-Message-State: APjAAAV3F03qj4gDKera2AucWH4YzXp7XtJRsRaQuSPvCwTIKdF/uj+v
        BkZZrDHuRsypW30ZxaQaFmEThWBVVZg=
X-Google-Smtp-Source: APXvYqygyiNCoz5lmQU8puHZQ+Hvp0UHtKQoGTiHJS9PyYVVOs/yoVYVyp+86yS+2BCd+lbnvlhoqw==
X-Received: by 2002:a19:ed07:: with SMTP id y7mr12747727lfy.56.1563213629980;
        Mon, 15 Jul 2019 11:00:29 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id f16sm2667871lfc.81.2019.07.15.11.00.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 11:00:29 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id t28so17176758lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:00:28 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr14263413lji.84.1563213628470;
 Mon, 15 Jul 2019 11:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com> <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
In-Reply-To: <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 11:00:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
Message-ID: <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
Subject: Re: drm pull for v5.3-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 10:37 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm not pulling this. Why did you merge it into your tree, when
> apparently you were aware of how questionable it is judging by the drm
> pull request.

Looking at some of the fallout, I also see that you then added that
"adjust apply_to_pfn_range interface for dropped token" patch that
seems to be for easier merging of this all.

But you remove the 'token' entirely in one place, and in another you
keep it and just say "whatever, it's unused, pass in NULL". WHAA?

As part of looking at this all, I also note that some of this is also
very non-kernely.

The whole thing with trying to implement a "closure" in C is simply
not how we do things in the kernel (although I've admittedly seen
signs of it in some drivers).

If this should be done at all (and that's questionable), at least do
it in the canonical kernel way: pass in a separate "actor" function
pointer and an argument block, don't try to mix function pointers and
argument data and call it a "closure".

We try to keep data and functions separate. It's not even for security
concerns (although those have caused some splits in the past - avoid
putting function pointers in structures that you then can't mark
read-only!), it's a more generic issue of just keeping arguments as
arguments - even if you then make a structure of them in order to not
make the calling convention very complicated.

(Yes, we do have the pattern of sometimes mixing function pointers
with "describing data", ie the "struct file_operations" structure
isn't _just_ actual function pointers, it also contains the module
owner, for example. But those aren't about mixing function pointers
with their arguments, it's about basically "describing" an object
interface with more than just the operation pointers).

So some of this code is stuff that I would have let go if it was in
some individual driver ("Closures? C doesn't have closures! But
whatever - that driver writer came from some place that taught lamda
calculus before techning C").

But in the core mm code, I want reviews. And I want the code to follow
normal kernel conventions.

                   Linus
