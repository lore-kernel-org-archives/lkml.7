Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544F5218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553118694;
	bh=VunNxwyG/PhJmnc4NOsGLzI86dcxS9go0EUh8pgk/Rs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oSN6GlVVvIu7pNB30tsLg/OU81thx9W4LjaLfDpCHGysjhHfhwA0BbqWlY4qyjeSo
	 iLSkXZsIbrxQtvRX9Z0M9A7RQm94tzw228tJNJK8PTed3fa97l+z3CC9Irhx4Hw3Ju
	 /WNiIZdaulk/PG7z5pG83f3fErGc4QHdciRLMmeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfCTVvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:51:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40323 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfCTVvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:51:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id u68so3076411lff.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFrXG5qc1aUtScwVWNQp/5mCoDnizoN1TRnTd6X2ckw=;
        b=I2S5l4EG3lG/fb/hD3y7ZF7E5weaw12ztaizoHY26ZGDtCX+45F/XVqPykxjHQMS+3
         GPCUhUw8AU/neg9T2oc+HWDyw/EFAL2iBxhpZUzdMeR7Umb78k/5q5I+7agHe8PW6Yeo
         mZiKxKboRm2UCN10QzNvj9+LXHCx9gTtKO1eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFrXG5qc1aUtScwVWNQp/5mCoDnizoN1TRnTd6X2ckw=;
        b=O1NXfMnAodqqLSiCrjuYhIYlT7DooLnlA3ByIOWSXOEynjtuoClI1Uz9ARoHyHjx+J
         RETgBa6GTheOXAbxf37Vl2CDASdpzw2F6+sXd0ZP4thvn0KFQSOwrt5yA0eHbldVuUtm
         nAr50fo54js8V8wSjx1S3Y3uIyUVIQySpVBwqurrMd5nyds7aysoYSndJmcd9FG1BOu+
         /wCI5LJr1dgbp4QdVIs+au6KjhXJRLQcrGHXcBYmwTZYSaDs/vXmb2jW+Knug07hgGhc
         vtl1EJ5Bg7YViMl0lrg2NzA7h7eeqeEUgatpparmjixsaze0m5bg6GwipOTHXRYLfHkB
         5hew==
X-Gm-Message-State: APjAAAVbsHX0OtfBVeQd9eJKoUT0EEj8yVahyxLEjbmO3Xt5DZp61g8M
        n/Hgwo//9H9W2zLoUv9LXr+vT2+32ag=
X-Google-Smtp-Source: APXvYqzEQWPRCLPAf/LYda9UhtRV5LvsQtCqTWi/4v3gkQqezjsE3C4IdNYcPjkprw1/kDl1F2Rpiw==
X-Received: by 2002:ac2:4203:: with SMTP id y3mr50640lfh.11.1553118689648;
        Wed, 20 Mar 2019 14:51:29 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 13sm582231lfy.2.2019.03.20.14.51.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 14:51:28 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id g7so3077137lfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:51:28 -0700 (PDT)
X-Received: by 2002:ac2:4424:: with SMTP id w4mr41645lfl.148.1553118287299;
 Wed, 20 Mar 2019 14:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190222194808.15962-1-mr.nuke.me@gmail.com> <20190320205233.GE251185@google.com>
In-Reply-To: <20190320205233.GE251185@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Mar 2019 14:44:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDY1C+E0gUHmb6O3THwoTNpm=-qthDRcW+sG2RB430Mw@mail.gmail.com>
Message-ID: <CAHk-=wjDY1C+E0gUHmb6O3THwoTNpm=-qthDRcW+sG2RB430Mw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/MSI: Don't touch MSI bits when the PCI device is disconnected
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>, austin_bolen@dell.com,
        Alex Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Shyam_Iyer@dell.com,
        Lukas Wunner <lukas@wunner.de>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 1:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> AFAICT, the consensus there was that it would be better to find some
> sort of platform solution instead of dealing with it in individual
> drivers.  The PCI core isn't really a driver, but I think the same
> argument applies to it: if we had a better way to recover from readl()
> errors, that way would work equally well in nvme-pci and the PCI core.

I think that patches with the pattern "if (disconnected) don't do IO"
are fundamentally broken and we should look for alternatives in all
cases.

They are fundamentally broken because they are racy: if it's an actual
sudden disconnect in the middle of IO, there's no guarantee that we'll
even be notified in time.

They are fundamentally broken because they add new magic special cases
that very few people will ever test, and the people who do test them
tend to do so with old irrelevant kernels.

Finally, they are fundamentally broken because they always end up
being just special cases. One or two special case accesses in a
driver, or perhaps all accesses of a particular type in just _one_
special driver.

Yes, yes, I realize that people want error reporting, and that
hot-removal can cause various error conditions (perhaps just parity
errors for the IO, but also perhaps other random errors caused by
firmware perhaps doing special HW setup).

But the "you get a fatal interrupt, so avoid the IO" kind of model is
completely broken, and needs to just be fixed differently. See above
why it's so completely broken.

So if the hw is set up to send some kinf of synchronous interrupt or
machine check that cannot sanely be handled (perhaps because it will
just repeat forever), we should try to just disable said thing.

PCIe allows for just polling for errors on the bridges, afaik. It's
been years since I looked at it, and maybe I'm wrong. And I bet there
are various "platform-specific value add" registers etc that may need
tweaking outside of any standard spec for PCIe error reporting. But
let's do that in a platform driver, to set up the platform to not do
the silly "I'm just going to die if I see an error" thing.

It's way better to have a model where you poll each bridge once a
minute (or one an hour) and let people know "guys, your hardware
reports errors", than make random crappy changes to random drivers
because the hardware was set up to die on said errors.

And if some MIS person wants the "hardware will die" setting, then
they can damn well have that, and then it's not out problem, but it
also means that we don't start changing random drivers for that insane
setting. It's dead, Jim, and it was the users choice.

Notice how in neither case does it make sense to try to do some "if
(disconnected) dont_do_io()" model for the drivers.

                  Linus
