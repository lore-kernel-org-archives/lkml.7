Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5472FC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2821920880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Q4E3j8UI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbfHBFZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:25:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46254 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHBFZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:25:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id r4so53810550qkm.13;
        Thu, 01 Aug 2019 22:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z32U+47NlX9GSdYxrOMIJkrmirJtRbWII8nnxF0TuFc=;
        b=Q4E3j8UI4qdvR1yVPLhpbG1bb2LoSf+oJmdOKYrZ3l9Nzeyu1LLSDKLj9UFAKvfJaI
         800cjW7JoCr+RIUKPQLGO6ejfXvXGY6mKepHIVWH5rn5JdR2KUX8ztVmw3dnJRU4YSec
         29wmTpZyk9irZGeI4aKHHK4rPfezHs2y0YY5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z32U+47NlX9GSdYxrOMIJkrmirJtRbWII8nnxF0TuFc=;
        b=F1XDG4vJSh3YpnxQLIj9PxVNxaXkQTIwQjdtu/VMkOIb1MbN8bOQ+YjSx68oMboB2Y
         Oe3idESpuNOOIek9mj2DlbRw4rYGLtCwfghthVVbW3/SPZmisSTK1299W81/kTOH/m8I
         DOuCFkdJ7M6YMBtxb3U5AG7ynFZTrTaumqJi2DbD/AvnEDl5PJszrvIqNLFcEA6YEDv3
         Y4OLDXn0OsuKIexUfq5ALberSSJExToNEvBLUEptGezlf8gTnw2bbKkKuC9fRto5J1TH
         qx4QpFrhzx4NCXtPGhC1NV1xQqq6PwbF6qWL1CiNGQbf8Bd+ozN4DWP/K/Fh7CzO/pFQ
         PbNA==
X-Gm-Message-State: APjAAAUpM/qc4SZrzpKMfMkFxCy+3CLmnwymT4N+mheoXsjaxpxUSOq5
        XDQSCCy7VlD/8YivYQbcNkbkGtLpP8DKLfmT5Fs=
X-Google-Smtp-Source: APXvYqzKiJhQDXPLqDJ46c7VaRVieOmVC318o/1JxlUNJBBaxdRAWAOc7PQX4AhfQELWZtZ71FDimyPfqFOf5XX5BVw=
X-Received: by 2002:a05:620a:16d6:: with SMTP id a22mr89485291qkn.414.1564723555381;
 Thu, 01 Aug 2019 22:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190802041010.1234178-1-taoren@fb.com> <CACPK8XcuwNE3aBrsgn-paTZt-EtF6pc6WwYBQef5xc7157bk2g@mail.gmail.com>
 <606273F4-E021-4AAF-9F59-F363E4FFF92A@fb.com>
In-Reply-To: <606273F4-E021-4AAF-9F59-F363E4FFF92A@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 2 Aug 2019 05:25:43 +0000
Message-ID: <CACPK8Xc-vjJJ_kbe_KGss+RDMdhRVw-YDj9Cdux8iERSvE0_GQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Add Facebook Wedge100 BMC
To:     Tao Ren <taoren@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 at 05:20, Tao Ren <taoren@fb.com> wrote:
>
> On 8/1/19, 9:21 PM, "Joel Stanley" <joel@jms.id.au> wrote:
>
> >  On Fri, 2 Aug 2019 at 04:10, Tao Ren <taoren@fb.com> wrote:
> >>
> >> Add initial version of device tree for Facebook Wedge100 AST2400 BMC
> >> platform.
> >>
> >> Signed-off-by: Tao Ren <taoren@fb.com>
> >> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> >> ---
> >>  Changes in v2:
> >>  - remove "debug" from bootargs.
> >
> > Thanks. I applied wedge40 and then this one fails to apply due to
> > conflicts in the Makefile. Next time you have two patches, send them
> > as a series they apply one atop the other.
>
> I thought about asking you if I should send them as a series although they are logically independent patches..
> Sorry about that and I will do so for future patches.
>
> >  The naming of these two files suggests they come from a family. I
> >  noticed there's very minor differences, a pca9548 switch and the use
> >  of a watchdog.
> >
> >  Are these device trees complete? If yes, do you think it's worthwhile
> >  to have a common wedge description in eg.
> >  aspeed-bmc-facebook-wedge.dtsi, and put the unique description in
> >  respective dts board files?
> >
> >  The upside of this is reduced duplication.
> >
> >  If you have a reason not to, then that is okay and we can leave it as
> >  you submitted them.
>
> Thank you for the suggestion. I'm also considering moving common stuff into "dtsi" file, but let me take care of it in a separate patch, mainly because:
>   1) I have one more BMC platform (galaxy100) which is also similar to wedge.
>       I haven't started the platform, but once I have galaxy100 device tree ready, it would be easier for me to extract common part.
>   2) the device tree is not complete yet.
>       For example, all the i2c devices are still created from userspace.
>       I'm trying to move the logic from userspace to device tree but I haven't decided what to do with those cpld/fpga devices.

Okay, thanks.

I've applied both of these to the aspeed tree for 5.4.

Cheers,

Joel
