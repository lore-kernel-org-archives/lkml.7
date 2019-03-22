Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE176C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE6B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0a0Fggv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfCVJ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:58:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36247 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfCVJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:58:52 -0400
Received: by mail-vs1-f68.google.com with SMTP id n4so1032113vsm.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RF480ZSucsg8VWu9juK0FzativIxlsad9BKXrPz9TBg=;
        b=i0a0FggvkTob3+JjTaEt6RCyjpbZPnDHFee+LJSXY5NKtjgP6rmfL5VqusM1i+S+Dd
         rFDK22qUz3XCcx1KkWqb1Bog0zbmNM2nrHGTH2UKtcZLh4Rj91egBezKJZvwN7+BZHu7
         aWBdH8X1MsIUZpX1blutiPW5UfZm951rbrXSDHcVV44KIS8sGv9Ajtqja7ofFqRTXoYI
         o9YQXdCdF1I1ZupX/APZ1obnOVxK9hUYwArHMQGBHEqTZc6XSjsdlnjKpSLGfNirxa6A
         KsyIlXAKlJkgNOziWmMObQFgv/5sDDgwzoRs/R/ANvSy1UGKQqkJHkqi4xIZDDoUHAEJ
         /L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RF480ZSucsg8VWu9juK0FzativIxlsad9BKXrPz9TBg=;
        b=Be9JlRimzAdVgJgEKOKeURE6kaqXzU93Ttwg3TlVZheJ0rzhyMKrKT3rJj8h4BL/s0
         xCj+jDdsx1qFJ8G952ilOGQe6cDvhhTTbC0Nqazl01XyhZK4CduBxPN2aGcrxWtf+HDv
         1uvaTaWNDwmhnTdmC3ODnOTnBdlQsd0tKQghO9LdylY81ko8RmXsy9/foZDI35UNj73U
         /lnretSCkyFY448JExzGWWs/jaaoaDH5SP8D0g7bGdW2h2dptilQQKganGCMrYiGV404
         g3PKJYM4v5Sf7j+QdsSiYswQVKJUPOp9vcfqF86U2+4ZhBACFkj0DxFHpKH8K996bEbJ
         1vWw==
X-Gm-Message-State: APjAAAUGkk+P6UGGdwwWIx/f3aMhPf42aABh01YzTj0ePZ7il0KkSuNh
        twl11P4zd9UQltZNfJWXnM7VMoGlc2lrVzVieYrvvWzg
X-Google-Smtp-Source: APXvYqyt3MQAU3RWI/ysP3FTr1F/X+lmwhd8XHj84RW6BWrqH3YgWC7JxsK1Pv7SsoBHC/HY0jtv8nxB5WYqy3bsm+4=
X-Received: by 2002:a05:6102:157:: with SMTP id a23mr5430997vsr.34.1553248731184;
 Fri, 22 Mar 2019 02:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190313083659.7100-1-ulf.hansson@linaro.org>
In-Reply-To: <20190313083659.7100-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Mar 2019 10:58:14 +0100
Message-ID: <CAPDyKFoRM=2F5SubRL6+_uq_B3hO6eDeverhh5W2NShSn3X0Kg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drivers: firmware: psci: Some cleanup and refactoring
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 at 09:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v2:
>         - Drop two patches from the series.
>         - Added acks and other tags, no other changes.
>
> All of these patches have been sent earlier, but part of a bigger series [1].
> Instead of waiting for that series to get reviewed and accepted, I have split
> it up, such that these trivial independent cleanups can go in as a first step.
>
> The only intentional function change, should be the last patch, where we start
> checking if PSCI OSI mode is supported in the PSCI FW and print a message about
> it, as that is quite useful information for the user/developer.
>
> Rafael, discussions between me and Lorenzo for v1 concluded that these are ready
> to be queued for v5.2 - and if possible, we would like this to go via your
> linux-pm tree. Can you please pick it up?

Rafael, would you mind picking this up?

Kind regards
Uffe

>
> Kind regards
> Ulf Hansson
>
> [1]
> https://lkml.org/lkml/2018/11/29/1801
>
> Ulf Hansson (5):
>   drivers: firmware: psci: Move psci to separate directory
>   MAINTAINERS: Update files for PSCI
>   drivers: firmware: psci: Split psci_dt_cpu_init_idle()
>   drivers: firmware: psci: Simplify error path of psci_dt_init()
>   drivers: firmware: psci: Announce support for OS initiated suspend
>     mode
>
>  MAINTAINERS                                |  2 +-
>  drivers/firmware/Kconfig                   | 15 +---
>  drivers/firmware/Makefile                  |  3 +-
>  drivers/firmware/psci/Kconfig              | 13 ++++
>  drivers/firmware/psci/Makefile             |  4 +
>  drivers/firmware/{ => psci}/psci.c         | 86 +++++++++++++---------
>  drivers/firmware/{ => psci}/psci_checker.c |  0
>  include/uapi/linux/psci.h                  |  5 ++
>  8 files changed, 78 insertions(+), 50 deletions(-)
>  create mode 100644 drivers/firmware/psci/Kconfig
>  create mode 100644 drivers/firmware/psci/Makefile
>  rename drivers/firmware/{ => psci}/psci.c (93%)
>  rename drivers/firmware/{ => psci}/psci_checker.c (100%)
>
> --
> 2.17.1
>
