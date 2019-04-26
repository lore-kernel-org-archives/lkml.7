Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A719C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBF5214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="saq2xo4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfDZRqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:46:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35586 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfDZRqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:46:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so2077038pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LG37QFwhXYZEYAua0BnCrURDS41kX/WKOIH1DK3ar6Y=;
        b=saq2xo4yo4tvxIgOaMXVKPJkCrOoDQ4AGWTIkle+IZCN90EVXHkdhqU1B1RQuBZ5aP
         JsBPCpe+QmsE0X+PAWPc6oIhQ16ic3WJsitEljNzLy/g9SgbNEtM2xk4ajkUKwScnGg+
         235COxs9JuHdU1RjloJJsODEE7a+X9Hq5YQQexGVxuOJAxyQomarAugW3MreE6G62MaT
         roYaPpjwZL9b8FPlHElP6DHM/aB/iKN4+Ss8t2n1KhMmEwVoMN3DI1Bo3Y5rjlb5+QKz
         zgdk9+Pd3G+MxLF1VdlDj6Ak5im9zpBFXyJB82sqWN0oqwnumteo6GzUosmE4mOL6JuB
         W+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LG37QFwhXYZEYAua0BnCrURDS41kX/WKOIH1DK3ar6Y=;
        b=beuU/VueXCsAIsIF8X+NsRcuUJO+Zdzy2lzOkZCxYiXgwgXJND76KOzlKi8+iQe3hM
         riWSb65ErsMmcjp4k/EYG8kvdTQpecrjBgqSb7TEylRoQnRGZv5I0vIrL9MCHbY2zHrz
         GKctx/NjBDSv5T+Ljy9pkpo5iHmWK/7YBj9iTxzyGqZYJn8QrmH5KxEln36y9JHaA1M2
         2GnyrZJr69KdGlKAyYXWjqy6t+072B4PVj2pryXc2cE7wanvs51uT4pCcShb3y0mq/0i
         A6f8HxeeF5Gk/QxHPwJISbWPfLGBJxqhIooFICRn3BLR+vZrkdfk6DTaMSMGj4wV48FF
         0j8A==
X-Gm-Message-State: APjAAAXkkPw2Df35ucG0+BMvZIXVLzwhtSO5S0ZekZEn3WhjhtB9NcuT
        qnpfxCphTdQqR2c6zIrw+1co
X-Google-Smtp-Source: APXvYqy2VwuNbYHayVXPmNBL9JpV+tjzXn9WQNZiO8z1mDR+G6lJlYuFwGRrQtyROAR62zFvfIt0vw==
X-Received: by 2002:a63:7e10:: with SMTP id z16mr46092563pgc.40.1556300813859;
        Fri, 26 Apr 2019 10:46:53 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:72c4:4b94:e0ad:83b0:3987:aa05])
        by smtp.gmail.com with ESMTPSA id 9sm14461629pgv.5.2019.04.26.10.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 10:46:53 -0700 (PDT)
Date:   Fri, 26 Apr 2019 23:16:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Message-ID: <20190426174645.GB31161@Mani-XPS-13-9360>
References: <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
 <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
 <20190426173329.GA31161@Mani-XPS-13-9360>
 <534a4812-e6d3-9b16-5142-ab214da3d661@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534a4812-e6d3-9b16-5142-ab214da3d661@siemens.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 07:39:56PM +0200, Jan Kiszka wrote:
> On 26.04.19 19:33, Manivannan Sadhasivam wrote:
> > On Fri, Apr 26, 2019 at 08:20:19PM +0300, Andy Shevchenko wrote:
> > > On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > > > 
> > > > On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
> > > > > On 26.04.19 15:36, Jan Kiszka wrote:
> > > > > 
> > > > > > At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
> > > > > switch> the engine.
> > > > > Which value exactly does that collection of crude wrappers and broken
> > > > > attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
> > > > > provide ?
> > > > 
> > > > Leaving that blunt hack aside:
> > > > 
> > > > import mraa
> > > > 
> > > > pin = mraa.Gpio(13)
> > > > pin.dir(mraa.DIR_OUT)
> > > > pin.write(1)
> > > > 
> > > > And the same goes for nodejs, java and c++.
> > > > 
> > > > Moreover, this allows you to abstract away where "Pin 13" actually came from on
> > > > that board if the kernel changes (BSP -> upstream...) or the extension board or
> > > > ...
> > > 
> > > The problem here is opaque number. This has to be chip + *relative* pin number/
> > > See this:
> > > https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640
> > > 
> > 
> > But for platform like 96Boards we don't need controller specific lookup, these
> > are all handled by the platform code [1] so that the users can use the standard
> > pinout number to access GPIOs. For instance, pin 23 on the Low Speed expansion
> > header is the GPIO for all 96Boards platform, so the user can access that pin
> > using 23 itself in the application and it will run across all supported
> > 96Boards.
> 
> Can you ensure stable numbering when probing order changes, e.g. due to
> adding an extension board?
> 

Good point! For tackling this, I'm planning to introduce an API for accessing
the GPIO by its line name. It will be tricky to implement but once done, it
will serve.

Regards,
Mani

> Jan
> 
> > 
> > That's one of the reason why we prefer MRAA.
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://github.com/intel-iot-devkit/mraa/blob/master/src/arm/96boards.c#L75
> > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> 
> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
