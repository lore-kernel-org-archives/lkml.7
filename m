Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC248C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C76A20656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOBMboxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDZR40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:56:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39485 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDZR40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:56:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id l18so1968150pgj.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dqb3cVwL1E8ASH6mjvfSqgo1xbsbrXfv53/fOSKRZNo=;
        b=TOBMboxTJ2Z+6+KumXSb53KjCzky9/PQY0bpHm9ouCc4gk9E++utauvHZ2WHkaE+Z0
         UhmdpvL8Ssp3TfSc9yof4tjz9nIA7aIcxIkMN62yqCEo/Qb4wArBZpYhCzikMZFVq05p
         Q8CJksNU1Nm4LyPVr8np52XjIAZRCxpDxPoUxCdVXgtC+6wQmNrjYXJ8D/izPjrRieDM
         3D56Wl1LF6eoI6iXf59nRYW/FRfjzelRKu3PrG8BTzY+ua4jT4HXbUs+stUQFMGCbQSf
         g7y+9B0H3ZjT8hbRpIGImLa9vIohQBvFST3CgesC/z61rB557/eROWEAXOzHfcrwqvhL
         fzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dqb3cVwL1E8ASH6mjvfSqgo1xbsbrXfv53/fOSKRZNo=;
        b=CiX1mHTUrsyApJ7XtilIb+Ad7B5zphUM4+PlS/Eueqi08Dp4OAiIb4oKfPeiJiDui/
         oXzVLkc+pNgrflKOivvN6/IwiZ7qS9/6DHm0Q+un+o3LVzMTijxIp8VDfHy/ken17awg
         ouxjtxNUKocn2m8HSKoGQf6mPZhIGyMRaA39AdWk4kFWBJPE3PJKhjjNaobn2a3zLGuR
         QKs+rFylcLzz4JrgtJeqlXypoS3M+dP1eYESyXdnTWClkU8yNXS2KF9IjxkcdX7M8Iiz
         y9clpPlV1UFWLTj13JkAH5pl1xdxwWrslrJh5bgwWJ32XpneFiKLweSg8N5/mg8TL8S+
         Fi1A==
X-Gm-Message-State: APjAAAVGwaeRjUyD9cIIbXD3rFaZtBqZHf28XY7r56uMd4euN38yQnib
        nZpKkxUz6EwpcxEycDpQml61
X-Google-Smtp-Source: APXvYqzOGUly3L1L02apqJOyQjPkjX+1aLz1jwNwrdd+WQJoidSRS+HBByagnuYTiKIeopahL0TkUA==
X-Received: by 2002:a63:fd0c:: with SMTP id d12mr21812251pgh.172.1556301385182;
        Fri, 26 Apr 2019 10:56:25 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:72c4:4b94:e0ad:83b0:3987:aa05])
        by smtp.gmail.com with ESMTPSA id f15sm31336073pgf.18.2019.04.26.10.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 10:56:24 -0700 (PDT)
Date:   Fri, 26 Apr 2019 23:26:17 +0530
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
Message-ID: <20190426175617.GA31849@Mani-XPS-13-9360>
References: <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
 <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
 <20190426173329.GA31161@Mani-XPS-13-9360>
 <534a4812-e6d3-9b16-5142-ab214da3d661@siemens.com>
 <20190426174645.GB31161@Mani-XPS-13-9360>
 <0e9b6e72-d7d8-6dea-4efa-4eb7c1a8e0c9@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9b6e72-d7d8-6dea-4efa-4eb7c1a8e0c9@siemens.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 07:52:48PM +0200, Jan Kiszka wrote:
> On 26.04.19 19:46, Manivannan Sadhasivam wrote:
> > On Fri, Apr 26, 2019 at 07:39:56PM +0200, Jan Kiszka wrote:
> > > On 26.04.19 19:33, Manivannan Sadhasivam wrote:
> > > > On Fri, Apr 26, 2019 at 08:20:19PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > > > > > 
> > > > > > On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
> > > > > > > On 26.04.19 15:36, Jan Kiszka wrote:
> > > > > > > 
> > > > > > > > At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
> > > > > > > switch> the engine.
> > > > > > > Which value exactly does that collection of crude wrappers and broken
> > > > > > > attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
> > > > > > > provide ?
> > > > > > 
> > > > > > Leaving that blunt hack aside:
> > > > > > 
> > > > > > import mraa
> > > > > > 
> > > > > > pin = mraa.Gpio(13)
> > > > > > pin.dir(mraa.DIR_OUT)
> > > > > > pin.write(1)
> > > > > > 
> > > > > > And the same goes for nodejs, java and c++.
> > > > > > 
> > > > > > Moreover, this allows you to abstract away where "Pin 13" actually came from on
> > > > > > that board if the kernel changes (BSP -> upstream...) or the extension board or
> > > > > > ...
> > > > > 
> > > > > The problem here is opaque number. This has to be chip + *relative* pin number/
> > > > > See this:
> > > > > https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640
> > > > > 
> > > > 
> > > > But for platform like 96Boards we don't need controller specific lookup, these
> > > > are all handled by the platform code [1] so that the users can use the standard
> > > > pinout number to access GPIOs. For instance, pin 23 on the Low Speed expansion
> > > > header is the GPIO for all 96Boards platform, so the user can access that pin
> > > > using 23 itself in the application and it will run across all supported
> > > > 96Boards.
> > > 
> > > Can you ensure stable numbering when probing order changes, e.g. due to
> > > adding an extension board?
> > > 
> > 
> > Good point! For tackling this, I'm planning to introduce an API for accessing
> > the GPIO by its line name. It will be tricky to implement but once done, it
> > will serve.
> 
> Whatever is stable and handy. As cited in the other thread, I played with
> the device path as well, see [1][2]. Feel free to pick what what is useful,
> I will likely not have time to work on that soon again.
> 

Cool, thanks for sharing :-)

Regards,
Mani

> Jan
> 
> [1] https://github.com/siemens/mraa/commit/034d787eea1a5b201ea77a6549ffc0bdbc3b776d
> [2] https://github.com/siemens/mraa/commit/6fd8a3c27764718c1e62a4938a6dc88819c3f65f
> 
> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
