Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3E1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA7F20675
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="btUPGzmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfFUPHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:07:46 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35885 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUPHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:07:46 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7be556a9
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jun 2019 14:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=z3jd6dEgDOIqHzbA1rqPZIxSd+4=; b=btUPGz
        mrikyY9x5g0+xA53kOMC2ibkzx1D8zUjTt9Fj3Puy5KpiZ1h2IVNSFL22gmN6Ktf
        Qw0ZFWy/odIGrR5UhxMxC7A5PN/rk/iPzrNueo//d2WmDk9Ox4K6tLTDXysVeIQH
        r1m1VMin0n+dmyHYJtXc8XDMCJJuAynb4a3Lii1FK5twU8k24V4Si/DkXOo//pyg
        QOLWDXxUSRm2nR+BHLi4w44HthrnUxJjjuntyscMdQwYvYNKaQZdi1zc9r0YIf7S
        KURYRf6X5XXrvdaWdqpLkCvYxK9N5uAa3LRDhf4/zs9C/HDcjC+LTtK94wvu8i9/
        fTCdrmaXSksNmjhQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bd1bfc0b (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jun 2019 14:34:21 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id w196so4868569oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 08:07:45 -0700 (PDT)
X-Gm-Message-State: APjAAAXUA/w2eStAvn4SXDK6wK5rBcNxCWL6uEb6hsPyHDqmaj7j+BBj
        Pfx26HyHmhUh9zF4YyC1c2qoiD9K39QhxywwVSc=
X-Google-Smtp-Source: APXvYqywId2Z2o858XzI+BR3754jSVDH6Wd5YEWSSuwwH6cYqL3kLj6q2WF+P68DHcnztpq1xkOgXqZjDtuQSBvuXH0=
X-Received: by 2002:aca:7293:: with SMTP id p141mr2873228oic.122.1561129664719;
 Fri, 21 Jun 2019 08:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com> <20190620141159.15965-3-Jason@zx2c4.com>
 <CAK8P3a1Dfx0MayHFP46KL0RDta9cZYBy3pVRTaVTbEsbMOy5xg@mail.gmail.com>
 <CAHmME9qDAEzZKBDowLmdaxtc8fJqp-w_cvOWsvubh5Yr=Kgm-g@mail.gmail.com> <CAK8P3a0MWFCvB_pMuYyZbhBQzuA6++i_Y14cJ9n0TozJpqpKPA@mail.gmail.com>
In-Reply-To: <CAK8P3a0MWFCvB_pMuYyZbhBQzuA6++i_Y14cJ9n0TozJpqpKPA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Jun 2019 17:07:32 +0200
X-Gmail-Original-Message-ID: <CAHmME9o0+9EKv=ErSUXQivkGoXamFJY3T_KETjf7=SG-FOB+WQ@mail.gmail.com>
Message-ID: <CAHmME9o0+9EKv=ErSUXQivkGoXamFJY3T_KETjf7=SG-FOB+WQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] timekeeping: add missing _ns functions for coarse accessors
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 4:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
> I care less about these since ktime_get_real_fast_ns() already
> exists. My preference would be leaving alons the _fast_ns()
> functions for now, but making everything else consistent instead.
>
> Thomas created the _fast_ns() accessors with a specific application
> in mind, and I suppose we don't really want them to be used much
> beyond that. I wonder if we should try to come up with a better
> name instead of "fast" that makes the purpose clearer and does
> not suggest that it's faster to read than the "coarse" version.

Oh shoot, I just submitted v3 having not seen this. Does v3's 4/4 look
fine, or shall I undo the _fast switcheroo and resubmit?

Jason
