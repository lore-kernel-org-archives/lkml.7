Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA8FC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D532147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajUxc5+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfFRS7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:59:06 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46188 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbfFRS7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:59:05 -0400
Received: by mail-yw1-f66.google.com with SMTP id z197so6799547ywd.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2DDWkzfly8h++f2u7ETcCEDtyV1BipVpATFf3iGFj8=;
        b=ajUxc5+WJTxSIoBZ8SzOIP0EH5Oo4BIYMnTAueKHonh90SwDslBsrBqH/p5BpVV1lE
         bd8TeYNgekt+y1cFqWvfRhaaJktj/9HlmdRNP7O58u1L65J44e2TAoQ8mMwBrd2BehYY
         obhYCp/B5KF22P/dc7ZBTYUlxM50LS5cqX29I4OO2r4135df2kSGUOrYLAFBYkCwCbo6
         cqjc1a96YiF6gxE5t85rWZKUyG+cGcX32J5aHJGR0RYnFzCFaVXB0BKAWWinXwoZqMuA
         SssoPo5k02S7ZyalbCbsr+FvpZ8E+vHGkIcj1lW+J8TKA/Kd79OAsr3tVxdiBndDDKUG
         R+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2DDWkzfly8h++f2u7ETcCEDtyV1BipVpATFf3iGFj8=;
        b=NPwjbR1NWwhEWf/Z+ho4VpMnE7r+9gFXqIvaDzKPBqmXF4EFKZLNDIm0BZrO/Vocdm
         n4a2h7TFp2PY5+Ca6F5/NYHlDWiaWuHpJKz80ep9cNP8SQk8QAfpHuxgpi5gvvuSosqr
         M4XWfx8QyN1uhYBtMJrsbStFQmcH5Mem0l/qV+695DmOrYMPmdFPoO85A+3JjvsfGeHw
         wsjSsdTJi/aO+/iAbBQ+lm6od7mlZuNxlsN1vGIFOeLWmSUmEW0ytAhaVv4iD8jo3291
         ql7rVfEwwjmkyP86HW1gGekcIBrCQcn/+Yif0v3PYx9C2igxbzfrffu0D+xk2R8FfTyQ
         hD6w==
X-Gm-Message-State: APjAAAWpCN6gnolXQBOL7tGoOh8QkTqBUuSQcXJUUFnTmRR0bHg8mh3i
        shC8k5uxqlS7glWXLUaauYpzi/CB
X-Google-Smtp-Source: APXvYqwSaGU924CyotFuOd8eUpGfotrSwHDDjRr7GsUdnVUoDEj6PbvmUvxEoB4sT+7gf8FoziMA6Q==
X-Received: by 2002:a81:7096:: with SMTP id l144mr68848471ywc.294.1560884344071;
        Tue, 18 Jun 2019 11:59:04 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id s8sm4700608ywl.58.2019.06.18.11.59.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:59:03 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id n21so7195113ywh.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:59:02 -0700 (PDT)
X-Received: by 2002:a0d:c0c4:: with SMTP id b187mr41089130ywd.389.1560884342538;
 Tue, 18 Jun 2019 11:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FuTSfBFqRViKfG5crEv8xLMgAkp3cZ+yeuELK5TVv61xT=Yw@mail.gmail.com>
 <20190618161036.GA28190@kroah.com> <CAF=yD-JnTHdDE8K-EaJM2fH9awvjAmOJkoZbtU+Wi58pPnyAxw@mail.gmail.com>
 <20190618.094759.539007481404905339.davem@davemloft.net> <20190618171516.GA17547@kroah.com>
 <CAF=yD-+pNrAo1wByHY6f5AZCq8xT0FDMKM-WzPkfZ36Jxj4mNg@mail.gmail.com> <20190618173906.GB3649@kroah.com>
In-Reply-To: <20190618173906.GB3649@kroah.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 18 Jun 2019 14:58:26 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdrphico4044QTD_-8VbanFFJx0FJuH+vVMfuHqbphkjw@mail.gmail.com>
Message-ID: <CA+FuTSdrphico4044QTD_-8VbanFFJx0FJuH+vVMfuHqbphkjw@mail.gmail.com>
Subject: Re: 4.19: udpgso_bench_tx: setsockopt zerocopy: Unknown error 524
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Fred Klassen <fklassen@appneta.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 1:39 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 18, 2019 at 01:27:14PM -0400, Willem de Bruijn wrote:
> > On Tue, Jun 18, 2019 at 1:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jun 18, 2019 at 09:47:59AM -0700, David Miller wrote:
> > > > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Date: Tue, 18 Jun 2019 12:37:33 -0400
> > > >
> > > > > Specific to the above test, I can add a check command testing
> > > > > setsockopt SO_ZEROCOPY  return value. AFAIK kselftest has no explicit
> > > > > way to denote "skipped", so this would just return "pass". Sounds a
> > > > > bit fragile, passing success when a feature is absent.
> > > >
> > > > Especially since the feature might be absent because the 'config'
> > > > template forgot to include a necessary Kconfig option.
> > >
> > > That is what the "skip" response is for, don't return "pass" if the
> > > feature just isn't present.  That lets people run tests on systems
> > > without the config option enabled as you say, or on systems without the
> > > needed userspace tools present.
> >
> > I was not aware that kselftest had this feature.
> >
> > But it appears that exit code KSFT_SKIP (4) will achieve this. Okay,
> > I'll send a patch and will keep that in mind for future tests.
>
> Wonderful, thanks for doing that!

One complication: an exit code works for a single test, but here
multiple test variants are run from a single shell script.

I see that in similar such cases that use the test harness
(ksft_test_result_skip) the overall test returns success as long as
all individual cases return either success or skip.

I think it's preferable to return KSFT_SKIP if any of the cases did so
(and none returned an error). I'll do that unless anyone objects.
