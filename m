Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6D1C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A365E20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bv91VW9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfEPMU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:20:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39316 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEPMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:20:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id a10so2892865ljf.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wr0yrITWiDgpTtW7hOhkZTXIfJ4eLHxYShx+ors7rts=;
        b=Bv91VW9mbA/lrzvFPX4j+c3OhgAcDSfRzunT5DviBFTgoDJy1VXoMb6bjYHNgUba0h
         iuTJ56lTMab3DfGAa800XyxOtYrQoW8W+8EZbMNrgx70FPAS9gni/Y2QEkyJ6/9BnwYp
         yNUsXm6uUi0yhdWmLNPugsYACmutqAYkFzD9RfSo5KUe5LUPCq/Vhx+TyrMa7W33rvMk
         rZATdE02XuJ52GYiOqe4BTvCu5RjHyY11uH3t9I9vZF3tdLAosTkiHu/nT2AEvCZ3Ujf
         /F3Aaq8LpWQIPPDQcsweXzRUnoz1dtZBnIB1u6Q76qpmC6twBOf7G42QJ9M/M58eEga2
         q4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wr0yrITWiDgpTtW7hOhkZTXIfJ4eLHxYShx+ors7rts=;
        b=tfMh0/WVYvT/nFoLUypGqQ9WFW+4HexD6weal+4w79olDGKqdOW1VDCtWyr6Iwxkey
         MktxbpMeiBtf0A2oIT6M2H55jX7SZY4Qth6igaMARcTPCf4X+BUUhfXbKKT3UWCRG6ZZ
         o8DyC+d0XK9RbhD859nQmV1B8oLqy0Hify6/WFLFASJYVgufLHyqZTUxUzPwZWY5mBkN
         NDj/pFwbvnwDtBYBIEwt/Tit0AlR/v7oe4ulj19ckvDYUrX9NuzQpHR/WQ+GJ7iqfjwW
         h+NbTbzX4KZDO3hnUQvppGVsOn14K6IN0RtsaTsDm3io4YNaVohM7QEwaNG8kuQY52+Z
         Nn+w==
X-Gm-Message-State: APjAAAVjEYXE53mTnEN4Rj2/Z4Mr434f0VhxObTP1Be1m6raPlsvch6J
        MtFZl8CFHmPZO/UkTPZAlV70Fwa49CSRRsUmqSt7Yg==
X-Google-Smtp-Source: APXvYqz3tKAivV8Dh7JbLsHVm95JkncbNhNajSVq3rYNN6TMvN6O2ZDg675uuDTUoVEOcB135K7WzRtiYKDdXgotPBY=
X-Received: by 2002:a2e:8741:: with SMTP id q1mr2126359ljj.97.1558009226473;
 Thu, 16 May 2019 05:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190424081802.GV2654@lahna.fi.intel.com> <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com> <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com> <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com> <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com> <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com> <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net> <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <ea29ee73-705b-7d13-0084-11274db02394@metux.net>
In-Reply-To: <ea29ee73-705b-7d13-0084-11274db02394@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 14:20:14 +0200
Message-ID: <CACRpkdZJSYFYuJYtubUHyPhSkiHi0eUX_hmbmmXqO2XPg6rJcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

this became an interesting thread and Manivannan made some nice
changes to MRAA as a result.

It appears the Raspberry Pi has become a victim of its own success
and went from hobbyist toy system to a foundation for random industrial
control hacks. I'm a bit scared about that for electronic reasons but when
it comes to the software that is a board that get things right after
we added line-names to everything on its connectors.

What I can add is that when designing the character device I tried to get some
input from inductrial control (PLC) vendors and asked on the mailing list,
and mailed directly to ABB at one point, I am sorry for not finding the right
contact at Siemens (would have helped for sure).

I have tried to talk to Liebherr in related matters but can't seem to find the
right contact.

We really want to do things right with industrial control boards because
these seem to have very long life cycles and stay around forever in the
kernel for that reason.

Yours,
Linus Walleij
