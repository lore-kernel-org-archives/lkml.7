Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95390C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648DF2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RhSAK6cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfHZVZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:25:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39984 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfHZVZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:25:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id h8so28402872edv.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjHtRjpt5n1D5PkM7JJuND3OTb3knfbKMR+iXMOhZqY=;
        b=RhSAK6cZxhoShVI3uLD+VbBsuMha0OSSyDgeFjQS7YjArvB/H5SXBtRv02ke17B9oZ
         M075wq3vhHdh69HLgebWxf1GaV3GmaRkolY2AgQeEhE92D/tDsSXGsNpFDp2eqHTvrM+
         RZCqyHDeNWmppYzixwRJd30HVbUoyhgTAciwv8cvceKYFiD49Prv6ne/WSH/zS/d5rue
         qRbHvBxD6EfubSJHrVwSozhSCXTBTHT1H+Yms2IBRaWeAmB7eAftkUU95l457yQkXue1
         Ui5aKs0M2fycBJhZLiWHAXYI7sLy+SG04D/5CgSnE+w/AKIdWRsdjeC7jksyCwg72Uk2
         GcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjHtRjpt5n1D5PkM7JJuND3OTb3knfbKMR+iXMOhZqY=;
        b=Cd7Wag51rYQTfEDPtY25DVFdN6oD85XOsJdgqxVVFjbQsyxMiNH2LdW5eXrqdp4F1z
         TkjQ9O87jgDwLuIGYWB1ZMcjUDl9xzPzyqzRnU3sN0X8StwNQFnvy5SXOS1EwfYTZSwX
         3t+X+QYPPCs25flITwSZxB+DYE4irRk1Xz3TlBW2V2HdVHIXUXgJYNwvX0Xxd4dZmxPk
         mrv1Pl6fnp5kkvsoaTJaHvQU4c3ka2o3dGJrzrJLarDw1myaMrhNRZe192iljJ1sL8ko
         /fD6oxcENz9onHjH7n2FKhHB7kSbNTYPl1F31qGL8XtkS9BGXYyaOwoqKCnM1eSw8fuL
         U1eg==
X-Gm-Message-State: APjAAAWf4DbYWiCaoGfEApfD+CDxabXkA/vJ2KkpWicxY3P7RbxPownE
        M9brUsUNrEMTSu73BhcghM1+BhajfxSJ+QyojFKOkA==
X-Google-Smtp-Source: APXvYqyABUhgPZOjnwHXeRWkAX8BnPYEgYKam/sudCJIYd2ADQ0Mj3+fRruR7J61TZo9OKQ0uMpF34pAIRcVGgRyznI=
X-Received: by 2002:a50:9116:: with SMTP id e22mr20865143eda.161.1566854727449;
 Mon, 26 Aug 2019 14:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190826190056.27854-1-pasha.tatashin@soleen.com> <20190826201313.246208e9@why>
In-Reply-To: <20190826201313.246208e9@why>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 26 Aug 2019 17:25:16 -0400
Message-ID: <CA+CK2bAS-jDwY-qKfZQD8TbvyAhS1+rBvcxGqkR4BHd5NR5BGQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 3:13 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 26 Aug 2019 15:00:50 -0400
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > Marc Zyngier added the support for kexec and GICv3 for EFI based systems.
> > However, it is still not possible todo on systems with device trees.
> >
> > Here is EFI fixes from Marc:
> > https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com
> >
> > For Device Tree variant: lets allow reserve a memory region in interrupt
> > controller node, and use this property to allocate interrupt tables.
>
> There is no such thing as a "device tree variant". As long as your
> bootloader implements EFI, everything will work correctly, whether
> you're using DT, ACPI, or the anything else.
>
> This already works today, without any need to add anything to the
> kernel (I have systems using EDK II and u-boot, both implementing EFI,
> and I'm able to kexec without any issue). If your bootloader doesn't
> support EFI, here's a good opportunity to implement it!

Hi Marc,

Thank you very much for looking at this work.

Running Linux without EFI is common, and there are scenarios which
make it appropriate. As I understand most of embedded linux do not
have EFI enabled, and thus I do not see a reason why we would not
support a first class feature of Linux (kexec) on non-EFI bootloaders.

We (Microsoft) have a small highly secure device with a high uptime
requirement. The device also has PCIe and thus GICv3. The update for
this device relies on kexec. For a number of reasons, it was decided
to use U-Boot and Linux without EFI enabled. One of those reasons is
to improve boot performance, enabling EFI in U-Boot alone reduces the
boot performance by half a second. Our total reboot budget is under a
second which makes that half a second unacceptable. Also, adding EFI
support to kernel increases its size and there are security
implications from enabling more code both in U-Boot and Linux.

> --
> Without deviation from the norm, progress is not possible.

Totally agreed.

Thank you,
Pasha
