Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587EBC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA61218B8
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560958770;
	bh=WaYHEYR24dBvpFriPb85xlubTWnDsx57kJGx1C0IQfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tybljMksPvxbroIABFdsJ+HhKdmKnn2ULJZ+kPtGyfgHadMQqkCPLiZxxhKzvS/FD
	 +v/UoMEsfKDDVTWbW3fFCMlMXDZk1h1s36l800D4bXfFgi6fU2Rpl7FcCSnG+RCSmJ
	 Z1E0S6XRDQeljUMPw/1rtCB/pFbL+T5WimWGiS2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfFSPj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfFSPj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:39:28 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C7F2189D;
        Wed, 19 Jun 2019 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560958766;
        bh=WaYHEYR24dBvpFriPb85xlubTWnDsx57kJGx1C0IQfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ec2qSgJPEitHCtwxZQj8xBNYbdAsg9rd5kyiYDY/25svddOyHLDUc2iWFnO+wW05Y
         cfMMzD9r0VBTisATyKEYC8cFXi36WbEfBoC8cD6m7OU/Ix6ofv6cn4VSTfLVohnStM
         pGxX7BYCAAHBgVSNQl6qJvQ610ZT/W4xr0/LEOwo=
Received: by mail-qt1-f182.google.com with SMTP id x2so20465822qtr.0;
        Wed, 19 Jun 2019 08:39:26 -0700 (PDT)
X-Gm-Message-State: APjAAAUcyHrh8zWNCy00Xg5z3254PJi94ldtp8RhPl7ArTeyN0l9CJYm
        RMc68YPpmBSHdUJeqOlpLrIW0axRZSrF3FrYsw==
X-Google-Smtp-Source: APXvYqw4DWymb4slhuXRl7SeCy5AlAAvR7Dq0DK3jgNlknl4uwGa87e3I3xFTnQKGHkX2uVKnKOVUA4BCXvFs8EBqXA=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr105351232qtb.224.1560958766037;
 Wed, 19 Jun 2019 08:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARHHXv5Tu4BHN1avKOExS6HmPfd2c0ELZiQaxtmETOsDw@mail.gmail.com>
 <20190619125948.GA27090@kroah.com>
In-Reply-To: <20190619125948.GA27090@kroah.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 19 Jun 2019 09:39:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQ0bkMMpgA_JpGf-mo8ue28XpGf7oMFJ8bScGAmc+_1g@mail.gmail.com>
Message-ID: <CAL_JsqJQ0bkMMpgA_JpGf-mo8ue28XpGf7oMFJ8bScGAmc+_1g@mail.gmail.com>
Subject: Re: SPDX conversion under scripts/dtc/ of Linux Kernel
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        linux-spdx@vger.kernel.org,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 6:59 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 19, 2019 at 07:23:19PM +0900, Masahiro Yamada wrote:
> > Hi.
> >
> > In this development cycle of Linux kernel,
> > lots of files were converted to use SPDX
> > instead of the license boilerplate.
> >
> > However.
> >
> > Some files were imported from a different project,
> > and are periodically synchronized with the upstream.
> > Have we discussed what to do about this case?
> >
> >
> > For example, scripts/dtc/ is the case.
> >
> > The files in scripts/dtc/ are synced with the upstream
> > device tree compiler.
> >
> > Rob Herring periodically runs scripts/dtc/update-dtc-source.sh
> > to import outcome from the upstream.
> >
> >
> > The upstream DTC has not adopted SPDX yet.
> >
> > Some files in Linux (e.g. scripts/dtc/dtc.c)
> > have been converted to SPDX.
> >
> > So, they are out of sync now.
> >
> > The license boilerplate will come back
> > when Rob runs scripts/dtc/update-dtc-source.sh
> > next time.

Already has. It just happened and is in next. The policy is everything
is upstream first and any changes to dtc in the kernel are rejected.

> >
> > What shall we do?
> >
> > [1] Convert upstream DTC to SPDX
> >
> > This will be a happy solution if it is acceptable in DTC.
> > Since we cannot push the decision of the kernel to a different
> > project, this is totally up to David Gibson.
>
> That's fine with me :)

I'll do the work if David is okay with it.

> > [2] Change scripts/dtc/update-dtc-source.sh to
> >     take care of the license block somehow
>
> That would also be good.
>
> > [3] Go back to license boilerplate, and keep the files
> >     synced with the upstream
> >     (and scripts/dtc/ should be excluded from the
> >      SPDX conversion tool.)
>
> nothing is being excluded from the SPDX conversions, sorry.  The goal is
> to do this for every file in the kernel tree.  Otherwise it's pointless.
>
> > Or, what else?
>
> Rob remembers to keep those first lines of the files intact when doing
> the next sync?

Patches to the import script are welcome. The only thing I have to
remember running the script is to add any new files. Otherwise, it's
scripted so I don't have to remember anything.

Rob
