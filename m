Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9FFC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 04:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDE521BD9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 04:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k2bbZ2b2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfGVEkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 00:40:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41587 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfGVEka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 00:40:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so20710505lfa.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 21:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ncs42SKDIyAXPYsF/YsHVruecC4cl/V7wjDZefhpkw=;
        b=k2bbZ2b2oyVs0xaDgMXk4iGhoEBB5SNlDTYlq+jwwsMrg7WYd24sYe0mDHDlQSvoDX
         vRx/T3SbjcAWD+kP5mFuzsgQ2m5N75YkNxvwp3OBsTs2n/LqG5cH18XvsLuHTHpeChRI
         58rku89FNYqjt0vAT1GR0Om4Y1TenH7EpGIEbx1Rjn+gX6+YnEx8d5l5WmPSWmKkmcc0
         Vy+VW7wLRHdd4wOYN58RXO07SK6yY7S7t8Es8IHlzBB6NdgENlcFfB3Hx77JdfFCB2mU
         KMUBU0zBbQD8GI/T4Y0iRMawLQqjbap4/KZBz40ji+Kc3r6kVLxhakPmoLkXFytcFO/C
         /vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ncs42SKDIyAXPYsF/YsHVruecC4cl/V7wjDZefhpkw=;
        b=tUuEtqK6G6jZs2iB3lba7rq2nRxQw8GfKiRt+IeYUfKKwV5Uwiq8ExQzDihIfdJZI2
         9UZodCxIPJOmniCQyG/0lFIYdYSlder61rY+nlxfgv304HukL1Q4xldxDw9oJxRtEvpC
         +3SDSixUVLkCJ7veXDS4h8gYG8r4m5ePODAgadd8dPHVfp4s/5QXqCTiHbwuk0j9kjfv
         ciIsucjIPwJdW2NCEGh4Gi9FOp5T4qoigTaAmOXfVN+8EnPPhvDhEnWT1jt/rjOqAAlP
         bG2m4heIW/7DjKiIqu5qXWcVk9ICTjVNgbMNiBpFvlekE1eUka2vkMIjnQApgxGHw4q+
         DzoA==
X-Gm-Message-State: APjAAAVZ7UyqMFi89+8+kJowaUiP/3RM4p/yvkxC1Gv7z5pvCwmTeTly
        qKglLCmt2QT2Al+0HFnKuniDtFpeq+IpRwutmAdgxQ==
X-Google-Smtp-Source: APXvYqwvAIdl55t6ZBi0sof5NGjfaHPKrALdFIaGt9ZEylIuJumZ5agEDn2OAQB5ZWTfVUpTC8ov8KSHgsYAMZ1msnk=
X-Received: by 2002:a19:6602:: with SMTP id a2mr29671361lfc.25.1563770428381;
 Sun, 21 Jul 2019 21:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
 <1563534631-15897-2-git-send-email-yash.shah@sifive.com> <4075b955-a187-6fd7-a2e6-deb82b5d4fb6@microchip.com>
In-Reply-To: <4075b955-a187-6fd7-a2e6-deb82b5d4fb6@microchip.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 22 Jul 2019 10:09:52 +0530
Message-ID: <CAJ2_jOEHoh+D76VpAoVq3XnpAZEQxdQtaVX5eiKw5X4r+ypKVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] macb: Update compatibility string for SiFive FU540-C000
To:     Nicolas Ferre <Nicolas.Ferre@microchip.com>
Cc:     David Miller <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 5:36 PM <Nicolas.Ferre@microchip.com> wrote:
>
> On 19/07/2019 at 13:10, Yash Shah wrote:
> > Update the compatibility string for SiFive FU540-C000 as per the new
> > string updated in the binding doc.
> > Reference: https://lkml.org/lkml/2019/7/17/200
>
> Maybe referring to lore.kernel.org is better:
> https://lore.kernel.org/netdev/CAJ2_jOFEVZQat0Yprg4hem4jRrqkB72FKSeQj4p8P5KA-+rgww@mail.gmail.com/

Sure. Will keep that in mind for future reference.

>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks.

- Yash
