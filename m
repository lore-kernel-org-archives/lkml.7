Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBDFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F462064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMmKxTeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfF1ChY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:37:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44125 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF1ChX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:37:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so4435931otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROfllzNv1k9NDF/hlSsi9MTdRbiwcSwhYFfnNLljdsA=;
        b=eMmKxTeBkxf4BXVCFIwfX+lNGeR04Lq1XpCjpcH+o/qKSalxUKW9BfMhkLEkZywfiL
         US9yhcrXMpz01dnHrw9CNVD8I7T857D1vSYs4Wv37NbJrzOJCX85SKv9hhXPfV1HtLRD
         8Mlb22+BWpESlHekijJgdUmIso/IdWLbkohKERjj1kboVd09ypBQqvGSczXuZKi40rhY
         TgoqVN3geRzcv3wXLisHXklaKTNYSO/AENX6TjS5eNc1L2bQDl+TG/vgn6iVmhScIqj8
         dejoUq78veURkqAc1iDQgIOSPdWsvASLr+Ty5LfYnsozMkgjlobYlisyffHZqBwCMXNF
         fL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROfllzNv1k9NDF/hlSsi9MTdRbiwcSwhYFfnNLljdsA=;
        b=a6Q+AWZEcT7zjSm5Aqu1qGI5phxjGlKEF6grAshph/k/YuclbQjC+tp2Jd9SAKttQa
         GYwFiQNJL+SpjjrFjlL0wk2u4TlQ1PgYntr8ANYjkyXZXsGLRoOznAgIAEaarNOSPV/6
         h+NrPX2cf07Vf4eSN+wKBTvz/jN8rStSxMsFVcwhn9wZf16KGnnbcR0CbOExwwIO6VVb
         smN97YQiafwaqV99FprRwyCyRd+FbBHJc4/LzpO9PdXdOae6enMzpgYL7JX5WSE1gpv7
         wr07BRwIAVaOBZJewNvKGHSt6j05sYzC9YXcsxzxwO1XUfzrNmikrnZFlDtmuzrReaz+
         9/MA==
X-Gm-Message-State: APjAAAXmG7zJrNXFbkTOY/UtSseNoodqPFE2hQIUhOXF+WFakVw/Ux0w
        OTU7O4y9FM86fN2TzjUAincgLvQFwtVzS8oOCaO63A==
X-Google-Smtp-Source: APXvYqyie0y5w2KOZY+Btvx6QWtUDpapjyXxLTFHGIRTIv6FpF1+JIFZ/2WWuWimM0DC1TIfEqXHny3uVLLJrXYwp4A=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr6507861otr.231.1561689443012;
 Thu, 27 Jun 2019 19:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com> <20190624223707.GH203031@google.com>
 <20190625035313.GA13239@kroah.com> <CAL_JsqJyO9Fpq+Lzrc9NdiFBZ_9M31_mjfRyKM=ENtW-zVa8VA@mail.gmail.com>
In-Reply-To: <CAL_JsqJyO9Fpq+Lzrc9NdiFBZ_9M31_mjfRyKM=ENtW-zVa8VA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 27 Jun 2019 19:36:46 -0700
Message-ID: <CAGETcx-OmbNYJB_1wEX5c=tVC+yPLhgiEXqq3EZnM6JAZxLPdA@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/5] Solve postboot supplier cleanup and
 optimize probe ordering
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandeep Patil <sspatil@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 2:31 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jun 24, 2019 at 9:54 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 24, 2019 at 03:37:07PM -0700, Sandeep Patil wrote:
> > > We are trying to make sure that all (most) drivers in an Aarch64 system can
> > > be kernel modules for Android, like any other desktop system for
> > > example. There are a number of problems we need to fix before that happens
> > > ofcourse.
> >
> > I will argue that this is NOT an android-specific issue.  If the goal of
> > creating an arm64 kernel that will "just work" for a wide range of
> > hardware configurations without rebuilding is going to happen, we need
> > to solve this problem with DT.  This goal was one of the original wishes
> > of the arm64 development effort, let's not loose sight of it as
> > obviously, this is not working properly just yet.
>
> I fail to see how the different Linux behavior between drivers
> built-in and as modules has anything whatsoever to do with DT.

You are right, built-in vs module problem is not a DT issue. But this
is not so much a built-in vs module issue. It's just that built-in has
a hack available that works sometimes. But really, both are broken.

> Fix the
> problems in Linux and use the dependencies that are already expressed
> in DT and *then* we can talk about using DT to provide *hints* for
> solving any remaining problems.

Done. Sent v2 patch series that uses existing bindings.

-Saravana
