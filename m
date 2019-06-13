Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C752C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1582082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbfFMP0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:26:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43276 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbfFMLuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:50:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so8894651qtj.10;
        Thu, 13 Jun 2019 04:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6eReS1tzSjL5Z2a0z+5t8DdvrnPFO8rpSM4WEkGBlk=;
        b=lZNkmxxLo4PkFFyCa9VMvzoH6FtYBO0hkJUrBqOJh+A3HtAQgrE9bzBL9ScvlvEm5D
         sTrbe0CAd317VaD+lGWTCyDhW5jlHP/EjJDldASekK8AOef7rR8S2uiBFjjrUhp4sjUC
         A6z5D7rpSsLq+oJTV/Fu0hRn2GK0Xq2NqKstqoSWk2syo31RHRugS6CX8Fmb2DK8TO2K
         7q6HQ33w9m/5tNs7gwJc1iKFfEdZceLAO+9WCbeARXLAJdZCkdSJel8TWXqi1zQ7tow/
         bvIvwya158Cc3WTcuT+MiFWNwugulwEuxGf45HOZ299/ETxJVcNfhe0sGh2npKW4/rmd
         7InQ==
X-Gm-Message-State: APjAAAWeiSzcplhI1gHPxmaoza3gN+t4sSRGZf82lVtGynoTuH+k/Xxg
        nalBlTc2uFccTvyEIYhnk+tYHRYVEvy3LzxFGXE=
X-Google-Smtp-Source: APXvYqwH48n1uy34j2P77tvT1tzglrEnNCLZoANqaBrKML2Z8FzldrXot4yLtYvQya5u4E0YiIHiaQJGI6TRVaEbsLI=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr3141733qve.45.1560426599161;
 Thu, 13 Jun 2019 04:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190610133245.306812-1-tmaimon77@gmail.com> <20190610133245.306812-3-tmaimon77@gmail.com>
 <CAK8P3a0s1fdt2yHVjOXffeKPKkwUyJ7DKCZHHMKjx+3j300ZAQ@mail.gmail.com> <CAP6Zq1jZEUzbB-ZidF2SD24k8iC_uBkXZ9WbtPpOYNCRjRTz3g@mail.gmail.com>
In-Reply-To: <CAP6Zq1jZEUzbB-ZidF2SD24k8iC_uBkXZ9WbtPpOYNCRjRTz3g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jun 2019 13:49:42 +0200
Message-ID: <CAK8P3a1YvBoehevVuRHMD71pkA1iDJLrfhvdhup2p+f-33HtzA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] soc: nuvoton: add NPCM LPC BPC driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Patrick Venture <venture@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Olof Johansson <olof@lixom.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:18 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
>
> Probably the only vendors that will use the snoop will be Nuvoton and Aspeed.
> is it worth to create new snoop common user interface for it,
> if we will develop a new snoop user interface who will be the maintainer?

One or more of you will have to volunteer to maintain the new subsystem.

There are lots of ways this can be structured, and once you have
a maintainer (team), they can decide how to do it, but I'm available
to come up with ideas here.

Generally speaking, you don't need a ton of abstraction. The
drivers/watchdog subsystem could serve as a template there.
This has both models, the old way in which each HW specific
driver uses its own chardev, and the new model in which the
common code sits in a library module, and individual drivers
register to it.

I think the amount of code for two drivers is roughly the same
in either model, but the shared user interface implementation
makes it easier to ensure that the interfaces are in fact
compatible.

The other thing your own framework can do is to provide some
consistency between BMC specific drivers for different
functionality.

>> Maybe we can introduce a drivers/bmc/ (or even drivers/openbmc)
>>
>> that collects all those user interfaces with a thin abstraction layer
>> and one or two hardware specific back-ends?
>
> Sounds good, Maybe we can move the KCS BMC from driver/char/ipmi to the drivers/bmc/?

Good idea. Yes, please.

       Arnd
