Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B46C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CD820881
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+abuiCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfEQL4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:56:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37241 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfEQL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:56:14 -0400
Received: by mail-io1-f68.google.com with SMTP id u2so5250311ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CA1QgtL8vOu+blk28g43ESoyKQjrdUgm0/mMdKslbwI=;
        b=m+abuiCUQOIh/qk/pVf/2UgQvs4lGmH9qCd1ZGSbqAU43C5rMnpZZysuLCIvNqjLQA
         87UWsCglPydE4JDOUkakqnPU5kEvIdYTqG3iL0GsDlcuRtiOuy7Ar8NMVoQHztL3W+Bt
         0n1WIlfK0eKU7TwxOBwd3gLz/LCwrn/7yiRj8gr1+dqsZnmhMrOqmPkeNBJpo94ijifG
         emoszrtzIKzFdAmFP488Z0uClSgQf6Eu1EoyUUVVLG0Mst5A8+FNLjx8GwHW0+KT8viB
         T77kKAR08xTPlRd8I9Q7fUdmexzP29xTCorVjCuFTDy2mDU/EvQmsV2WbW0IuDPWklYC
         C43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CA1QgtL8vOu+blk28g43ESoyKQjrdUgm0/mMdKslbwI=;
        b=C24DIIJbvRjhZ3Mwq4jwj+IHUgPv/fpqwYmrsIxBafr6MoIHTsowetUrH3sJoDipry
         IjZIJdQozCDjl3wyUa5Eedf7XZubyg3VKgAI0V1S4cFOlIGsotG8rS21k9Rf/Cz+w+FE
         zX6zIvnvdZ2lXVrQCc9MRqm4ANH+UPDozt8NA17K4bDUSz3sqgkbfdrd/jZ0wDacGINs
         tPHSj3J3kTfikJT4z73Gnv5tL3M4KjxD5MGz9puATwurQflcRO8Vlp8wdDVmrEaE7clY
         aeF5fHpTm9d0yqjPIdkEbnnDQZIwDX2TdeLD8/V84tC6wNxOp9VYd0coGhdtrSSQFC4c
         +ukg==
X-Gm-Message-State: APjAAAVnitDpb7L0U64FIR3uirAEApwUZV6pvSmw8tFYmFT9NFLqEn2l
        OISIDUo9M1STTabt2VEPqN3+2AYemX1bIbMn2xdpAQ==
X-Google-Smtp-Source: APXvYqzbxd/LhE2W1VznV5HXbB0SgsNd3x8iv/pmdPHmijU0/muzRSAM0zIjA7vRy7qKVFuYiijaQdNgZJpAJyC1r6s=
X-Received: by 2002:a6b:3b88:: with SMTP id i130mr16477327ioa.21.1558094174033;
 Fri, 17 May 2019 04:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com>
 <1558024913-26502-2-git-send-email-kdasu.kdev@gmail.com> <CAFLxGvyZCpKthJevFHjjBQXo=j5f-FUip0MAsLy0HaoJzLZ2rA@mail.gmail.com>
In-Reply-To: <CAFLxGvyZCpKthJevFHjjBQXo=j5f-FUip0MAsLy0HaoJzLZ2rA@mail.gmail.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri, 17 May 2019 07:56:01 -0400
Message-ID: <CAC=U0a2UxMG2SuVCjv=TLzMs7Dg3yqJdxW6ft2tSQgEKj0C6ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: nand: raw: brcmnand: When oops in progress
 use pio and interrupt polling
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 4:12 AM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Thu, May 16, 2019 at 6:42 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> >
> > If mtd_oops is in progress, switch to polling during NAND command
> > completion instead of relying on DMA/interrupts so that the mtd_oops
> > buffer can be completely written in the assigned NAND partition.
>
> With the new flag the semantics change, as soon a panic write happened,
> the flag will stay and *all* future operates will take the polling/pio path.
>

Yes that is true.

> IMHO this is fine since the kernel cannot recover from an oops.
> But just to make sure we all get this. :-)
> An alternative would be to block all further non-panic writes.

Capturing the panic writes into an mtd device reliably is what the low
level driver is trying to do.If there are non panic writes they will
use pio and interrupt  polling  as well in this case.

> --
> Thanks,
> //richard

Thanks
Kamal
