Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB7BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DF021473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a62uOnV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbfFMPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:21:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44486 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732095AbfFMPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:20:58 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so17749540iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TErb3CYHjqgMEM+qQuKdZ7BSMjcTmOtVmFNFo81SDk=;
        b=a62uOnV1z+blRGCTaI2EKn0Hx0F2gnrv/5aQImnAPlBOPHV2SiuF9FursKNDDBTr3/
         nJcZDrusUGjAIzGIj2fO6uA11hZkfN3Gcqlua8GpYafI/C9tI34BuiOaNuJIYU5tihTe
         hW8CgHNrdUHnaeU7V4ONwP3YN1rzmP29eF8Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TErb3CYHjqgMEM+qQuKdZ7BSMjcTmOtVmFNFo81SDk=;
        b=SatyJONR5zF07pZoJIVsx31qUzw39Ive01bncgjLyhx36ks8mNJJDClRPn8VzDz2QV
         D6MN77+uwhDPbMvr3h+Mi3qGSoKrAL7YgWGFWaaGW7m8319rCb1WURNOcEdu8VMyoTh6
         /eB6TEtMrk1rVhbXiGtB1mYq7lOpuhIRlIYixJd4Tez4fwyDdQkeLlFf0xTROCYqrece
         YItb5b9iIjFPUaL4Gg2umx0rVuiB0Cwxb54BBbv9048SVYyoX79jRhINZauvKFRXk18x
         AMUavgu4953Yec5JUnFf5ePZcKHoulUlL74mFa9UqW6f128/ZlaxAc/58AYKmEXSckCF
         bjvw==
X-Gm-Message-State: APjAAAVQ3fFU5AVZPFVyhiqOyff77EbhxAF4o1lcJASMCCLkap6kO9Xg
        IRiaBfxE1m+JbzCMs/mp/kVkCu9K3X4=
X-Google-Smtp-Source: APXvYqwQxWcF94nPCAxW8ENqglZCMc/b4+rOaPKHwzH9GEKbhieE4AX2+dFpBsDdeWhBIJMxNau6DA==
X-Received: by 2002:a02:394c:: with SMTP id w12mr11124980jae.126.1560439257104;
        Thu, 13 Jun 2019 08:20:57 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id l11sm363030ioj.32.2019.06.13.08.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 08:20:54 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id k20so17736808ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:20:54 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr1990359iop.58.1560439253994;
 Thu, 13 Jun 2019 08:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190610220118.5530-1-dianders@chromium.org> <20190612191618.GC3378@linux.intel.com>
 <20190613135858.GB12791@linux.intel.com>
In-Reply-To: <20190613135858.GB12791@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Jun 2019 08:20:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UoSV9LKOTMuXKRfgFir+7_qPkuhSLN6XJEKPiRPuJJwg@mail.gmail.com>
Message-ID: <CAD=FV=UoSV9LKOTMuXKRfgFir+7_qPkuhSLN6XJEKPiRPuJJwg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Guenter Roeck <groeck@chromium.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        apronin@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Luigi Semenzato <semenzato@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 13, 2019 at 6:59 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Jun 12, 2019 at 10:16:18PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jun 10, 2019 at 03:01:18PM -0700, Douglas Anderson wrote:
> > > From: Vadim Sukhomlinov <sukhomlinov@google.com>
> > >
> > > TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
> > > future TPM operations. TPM 1.2 behavior was different, future TPM
> > > operations weren't disabled, causing rare issues. This patch ensures
> > > that future TPM operations are disabled.
> > >
> > > Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
> > > [dianders: resolved merge conflicts with mainline]
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Nice catch. Thank you.
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Applied to my master branch. I also added a fixes tag.
>
> Can you check that it looks legit to you?

Found the patch in your tree at
<http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/41f15a4f02092d531fb34b42a06e9a1603a7df27>.
I'm decidedly a non-expert here, mostly just wrangling a patch that
someone else came up with.  :-)  ...but let's see...

I think you're asking if the "Fixes" looks sane.  I guess it depends
on what you're trying to accomplish.  Certainly what you've tagged in
"Fixes" marks the point where it would be easiest to backport this fix
to.  ...but I think the problem is much older than that patch.

As I understand it, this problem has existed for much longer.  I
believe that ${SUBJECT} patch evolved from an investigation that Luigi
Semenzato did back in 2013 when we got back some Chromebooks whose
TPMs claimed that they had been "attacked".  Said another way, I
believe it is an evolution of the patch <https://crrev.com/c/57988>
("CHROMIUM: workaround for Infineon TPM broken defensive timeout").

...so technically someone ought to want this on all old kernels.
Maybe keep the "Cc: stable" but remove the "Fixes"?


-Doug
