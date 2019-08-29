Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BCCC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72BC2339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MS5MBdUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfH2Jzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:55:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44812 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfH2Jzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:55:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id v16so1984761lfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evvUwMaL41hf6dQA5cbASb1N+VW/0lgS0C0cgu/S/XY=;
        b=MS5MBdUIFrK8j7JVNOIBDd0FVG15855op7IYcP7tlLIytYN6qxJRW0N8GjbTb23lbK
         rzQwQUy5RXgjl9OKpd0TEJGbSIAXrlppU/TkbF3aoQu4IIS1KSgFJsFfpHonZL4AuQ0r
         rQknOTfDjLfaJS/JJ3hYzVhSPudYP6OpPr5jdBlAp8Ln/oLFKkTDLxTrK6FtpSAPuTaB
         bC7yPU4oCUVaxI442RhA2CWrNDSNVDbN7hMRiym/QPz45b4MEA3XIKe518XH1JAE6+mB
         nM/yvP6HU7Wv4hr76APo59aA6DDuCNx6Accapkzd1cJ/BZjMnoNSjvf9stgHxe2BXlWc
         PARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evvUwMaL41hf6dQA5cbASb1N+VW/0lgS0C0cgu/S/XY=;
        b=qV1y6KAigIznMA2iNuDmO+io/HkPI6L5fQoQ2zcMzS+xHMeW/xQQN4u0JNlPf6NLXV
         a7fLUp1iLVz3XmeOjr/jW4y2O2YE/4+19iNi4sDbVSKk3c126FQzs7hLSjzMi81MnXVF
         ff5pZVTNFy0faQCT+j/B+2pbAUgK0wWj2iOin0AgQpoPAl90Tr+7ZYNC1DIISY9+OT5N
         VZmL6kLK34XksyMglraci4+q7HewtIFcrGWdMsIsBzFnFPzvvAeV5ETJGdncNygSH3w9
         3ioWMOc09BFvqHpAEusWXa4fJUz99usb7Lgz7in8/O2jQTaCOruQ5bgCIjyvV/AOezqV
         rD+Q==
X-Gm-Message-State: APjAAAVRXYxWtMMuS4vHVptc/Dm5DmP3PtXj0/WMUQlqEuwjAdSecPdn
        48zVB3YUGOv/oSLEojxMOUi7f8qh3z073F1Vw9jbVA==
X-Google-Smtp-Source: APXvYqwgzlt4Ba0fIdipzn2QNcarMqY0UEZGFrkuppA5LS/NNCU8eU6W17GnvKVQldIpJENYm0vxsdEZmOv6K7MVIh0=
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr5544001lfo.25.1567072535444;
 Thu, 29 Aug 2019 02:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <1566882364-23891-1-git-send-email-yash.shah@sifive.com> <20190828.140644.534529249197568915.davem@davemloft.net>
In-Reply-To: <20190828.140644.534529249197568915.davem@davemloft.net>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 29 Aug 2019 15:24:58 +0530
Message-ID: <CAJ2_jOGiTgGZ0TEZt6hBVB3oFxWkrrKVGQ6n__G4Zf_-ijY10Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Update ethernet compatible string for SiFive FU540
To:     David Miller <davem@davemloft.net>
Cc:     netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 2:36 AM David Miller <davem@davemloft.net> wrote:
>
> From: Yash Shah <yash.shah@sifive.com>
> Date: Tue, 27 Aug 2019 10:36:02 +0530
>
> > This patch series renames the compatible property to a more appropriate
> > string. The patchset is based on Linux-5.3-rc6 and tested on SiFive
> > Unleashed board
>
> You should always base changes off of "net" or "net-next" and be explicitly
> in your Subject lines which of those two trees your changes are for f.e.:
>
>         Subject: [PATCH v2 net-next N/M] ...

I will keep this in mind for future patches.

>
> >
> > Change history:
> > Since v1:
> > - Dropped PATCH3 because it's already merged
> > - Change the reference url in the patch descriptions to point to a
> >   'lore.kernel.org' link instead of 'lkml.org'
>
> Series applied to 'net'.

Thanks!

- Yash
