Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE09C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8240420675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551879572;
	bh=RZVjRder/5EZYovaqiWdThINkoZDSPcukDSyvz7UueY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rJAl0JTK6BluPxCb119dRmR7zcmmQDGFZluAPsngHxxI2JeqoPl62bayHT9puqis4
	 ggSp67sSqP3SKD25tvMiYd+ZI+JXR/Y8sZWpc2fE9dehwHzLVxEHcDUo87J+GZKmxb
	 4fJxgzAfatXcuWW0Tx8cnKdFe035WIdwDpVLbnDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfCFNjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:39:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfCFNja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:39:30 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB5B208E4;
        Wed,  6 Mar 2019 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551879569;
        bh=RZVjRder/5EZYovaqiWdThINkoZDSPcukDSyvz7UueY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pyDhtWf3VomeFuoODOPJwzvo0gD/vrvpcOihJjJpWIYNU/PKa0lxtpGQtYeL2wnfK
         56RkqFln093zBQbjbcBviyKTm7LjPsNcAR3pR6ZRFLEmnazVoCFOGW8ybmQ/2k3f9K
         6TMFRXS8wqLNsLlitUlppN5U+/DEOScV+nM6qkow=
Received: by mail-qk1-f178.google.com with SMTP id f196so6762109qke.10;
        Wed, 06 Mar 2019 05:39:28 -0800 (PST)
X-Gm-Message-State: APjAAAWk+Jsa+yv4rMcKGKAG6rQnRjSX1oZvWrFqfN8+w2FyIsGbU27I
        zhDcWBPZFaXACoHK4r9+uIbt3u21eX9zIGV2eQ==
X-Google-Smtp-Source: APXvYqyksOZr446gGXqxVX90+lV2/bBqVQ63Hywl/8JHs31waHhHSdL152klc2GCHnoMFeeC2uIODSOdqDJM3NAtv6o=
X-Received: by 2002:a05:620a:123b:: with SMTP id v27mr5357078qkj.29.1551879568048;
 Wed, 06 Mar 2019 05:39:28 -0800 (PST)
MIME-Version: 1.0
References: <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr> <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx> <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx> <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
 <617e0d57-342d-4162-bd21-ece18e481d87@free.fr> <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
 <20190213085028.6199594b@canb.auug.org.au> <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
 <20190306021248.GA17298@roeck-us.net>
In-Reply-To: <20190306021248.GA17298@roeck-us.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 6 Mar 2019 07:39:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKhhZuPi8vWXZLTip_=kLVvknvQxzVXMaKD3BB0YHOA7A@mail.gmail.com>
Message-ID: <CAL_JsqKhhZuPi8vWXZLTip_=kLVvknvQxzVXMaKD3BB0YHOA7A@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 8:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Feb 12, 2019 at 04:12:24PM -0600, Rob Herring wrote:
> > On Tue, Feb 12, 2019 at 3:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > On Tue, 12 Feb 2019 10:03:09 -0600 Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Mon, Feb 11, 2019 at 10:47 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> > > > >
> > > > > On 04/02/2019 15:37, Marc Gonzalez wrote:
> > > > >
> > > > > > Cc: stable@vger.kernel.org # 3.15+
> > > > > > Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
> > > > > > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > > Acked-by: Prateek Patel <prpatel@nvidia.com>
> > > > > > Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > > > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > > > ---
> > > > > > Resend with DT CCed to reach robh's patch queue
> > > > > > I added CC: stable, Fixes, and Prateek's ack
> > > > > > Trim recipients list to minimize inconvenience
> > > > >
> > > > > I'm confused over commit 3532b3b554a216f30edb841d29eef48521bdc592 in linux-next
> > > > > "memblock: drop __memblock_alloc_base()"
> > > > >
> > > > > It's definitely going to conflict with the proposed patch
> > > > > over drivers/of/of_reserved_mem.c
> > > > >
> > > > > Rob, what's the next step then?
> > > >
> > > > Rebase it on top of what's in linux-next and apply it to the tree
> > > > which has the above dependency. I'm guessing that is Andrew Morton's
> > > > tree.
> > >
> > > Yeah, that is in Andrew's "post linux-next" patch series, so if you
> > > rebase it on top of linux-next and then send it to Andrew with some
> > > explanation.
> > >
> > > ...
> > >
> > > Actually, if it is intended for the stable trees, then presumably it is
> > > intended to go to Linus for the current release?  In which case, the
> > > patch in Andrew's tree will have to be changed to cope after your patch
> > > appears in Linus' tree (and therefore, linux-next).
> >
> > At this point in the cycle, I wasn't planning to send this for 5.0.
> > It's not fixing something introduced in 5.0 and it is a debug feature.
> >
> Hi Rob,
>
> this may be a debug feature, but we do test our kernels with it enabled,
> and the problem does affect our 4.19 branch (chromeos-4.19). Are you
> suggesting that we should backport the fix into our branch and not send
> the backport to -stable ?

No, not at all. Just that I wasn't going to add it to the probable
last 5.0-rc and would wait.

However, it's complicated by other memblock changes in 5.1 and not a
trivial backport. One of the versions on the list should be easier to
backport than what's in mainline (or going to be).

Rob
