Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A535C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0C6212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAFc1wCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfDZRUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:20:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43397 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:20:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so1917844pgu.10;
        Fri, 26 Apr 2019 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2E3HbEpFJ9TF3Qp8QLs00zx9lZn0VxKpo3ZihlPSxA=;
        b=kAFc1wCqt4MRRp4fcdgHNsFNoKT9ZKXy98BJTJ9vfaYedQs/8C3mf3aHZdBDY60xEj
         WSG30L1xtuGnWYHglOTMpQkpPMjll7Hol6HOHN37YpJEIeAWNlznzHRF/Mp0WHaYb1IB
         mJOeSAmI3lUgxlbgYweG2Cq5TYlDhKTfV0Ps/IS2yFXGRA3PZMa81n8RNz0toHofZ6VQ
         mMJLdQ7KK3BBAAOL396kvbpiMWf011s2+/f+XrV9VLcKgH1cADT7WFcMm7eCI5jKlLO1
         J8Azks95DJUrvW9eqj2sYELacqYgkGNr0OmFwQfvjvWbNT3UwGlq5aABuGYRnyuUgG1f
         FeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2E3HbEpFJ9TF3Qp8QLs00zx9lZn0VxKpo3ZihlPSxA=;
        b=aB6ZQyarK89keV7bqz4RC15QAOWo3Ku9or1mgsWwrkV2h3nE52uSWDeng2zkILDoko
         X0t6f0qbdH3w1+fLJa7vZyOqqn2p1FUPPywzlmStXfq0qStsidSUsV+YSHOhP43ZMILJ
         MF6rIcplR3aKIfrBhBhNVwKpU6sgCKnd0GozQy0V+z3KUBcQtru2HdHqQk78pj6P8R3+
         c2k0oQtlJR7xKx41kJ1fc4EktVUtIr0L+I6nkO4nDfOSgqHTamfWdfigr02N3aDeoC8M
         wqiI/NMiMkJL/BtahLICM0HmPnsISk30DoGoZp9UpNd3fysXeB9v4FkXFpgjU53dH7gk
         shyg==
X-Gm-Message-State: APjAAAWNKuUz7aDEaOVc0m0TRc24eNMQmP7RSlhPk6VdMESFEglcHKFh
        qdxvq+mfWwYMQONMTMRlGL5Acr1ew2uevj9Zv1tzAcTex2Tc6g==
X-Google-Smtp-Source: APXvYqwCPlMtwQWW4arZx6wRa40s1Pgw527AP3BZ6SAmsfVofDx0xIz8v4styeVV09jdFOZmTcOIG28oW1fq/SHPWTA=
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr1479457pge.428.1556299230822;
 Fri, 26 Apr 2019 10:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190424081802.GV2654@lahna.fi.intel.com> <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com> <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com> <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com> <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com> <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com> <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net> <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
In-Reply-To: <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Apr 2019 20:20:19 +0300
Message-ID: <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
> > On 26.04.19 15:36, Jan Kiszka wrote:
> >
> >> At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
> > switch> the engine.
> > Which value exactly does that collection of crude wrappers and broken
> > attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
> > provide ?
>
> Leaving that blunt hack aside:
>
> import mraa
>
> pin = mraa.Gpio(13)
> pin.dir(mraa.DIR_OUT)
> pin.write(1)
>
> And the same goes for nodejs, java and c++.
>
> Moreover, this allows you to abstract away where "Pin 13" actually came from on
> that board if the kernel changes (BSP -> upstream...) or the extension board or
> ...

The problem here is opaque number. This has to be chip + *relative* pin number/
See this:
https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640

-- 
With Best Regards,
Andy Shevchenko
