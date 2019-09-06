Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C554C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3FF206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391645AbfIFL4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:56:44 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44302 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbfIFL4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:56:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id i78so5281062qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 04:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7F1mUtKY856FJCLvPUe7oWqK5RgOugdtEGZ/H9fzbmY=;
        b=gtC5idCBeP1V5ersFv5vJS7YBIZs5goPq+mcyPa9BN36wE2+SMYQVRR2YtbzbFi1u3
         LvTMt8CXAa1ev3XzU47ymS8VWohHWIqoYYNtBsAxpjj86GweVgy3pPDBZFSvzg/c8Cpe
         uxY3UoH5aYleEdRKZBxYvVQAU3vMnRuZa58geZhNefhcAEXEUaIWrIRvWGWYbIIZfeUi
         SmS0Wpj72rtEdgw5t9MqSXEWHzv1zIpdgIqC2nUw4zLPGGEd4z7gviDflyEouQqC+Nmy
         +MXvolHsPiveLc6JrYa7ONYjO9hD5fxOd/m/ZxFBpkJJ5EBqhOOpH6JF2eGeMZN6cXKE
         borA==
X-Gm-Message-State: APjAAAXmWgjd8AM2++HDZY71lLSh407ds4gCW5o9N/LwvlYCXKuNy7zu
        iWWcyEzxx3D/UNBWltxrEbiUrj7e5tLbhv+jRC0=
X-Google-Smtp-Source: APXvYqzwhelhrJw6v97UlvQ9gFA+EJEgAwG1lBZjHPuhlD2jF5AyUyvgcLeKKXFPoQHWEZjaqubrLx7rtowyRq2juOc=
X-Received: by 2002:ae9:ef8c:: with SMTP id d134mr8236616qkg.286.1567771002514;
 Fri, 06 Sep 2019 04:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190905203527.1478314-1-arnd@arndb.de> <20190906043805.GE2672@vkoul-mobl>
 <CAK8P3a38ywYFaGekbi6_idwrZvaVX8u8giUpK1r26QAbekLp8Q@mail.gmail.com> <20190906104403.GH2672@vkoul-mobl>
In-Reply-To: <20190906104403.GH2672@vkoul-mobl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Sep 2019 13:56:26 +0200
Message-ID: <CAK8P3a35e2MQh0nz-zFmrMbFxy2CdrOE48WVh+UUv-Luwf+eqQ@mail.gmail.com>
Subject: Re: [PATCH] soundwire: add back ACPI dependency
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 12:45 PM Vinod Koul <vkoul@kernel.org> wrote:
> On 06-09-19, 12:02, Arnd Bergmann wrote:
> > On Fri, Sep 6, 2019 at 6:39 AM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 05-09-19, 22:35, Arnd Bergmann wrote:
> > > > Soundwire gained a warning for randconfig builds without
> > > > CONFIG_ACPI during the linux-5.3-rc cycle:
> > > >
> > > > drivers/soundwire/slave.c:16:12: error: unused function 'sdw_slave_add' [-Werror,-Wunused-function]
> > > >
> > > > Add the CONFIG_ACPI dependency at the top level now.
> > >
> > > Did you run this yesterday or today. I have applied Srini's patches to
> > > add DT support for Soundwire couple of days back so we should not see
> > > this warning anymore
> >
> > This is on the latest linux-next, which is dated 20190904. As Stephen is
> > not releasing any more linux-next kernels until later this month, I'm
> > missing anything that came in afterwards.
>
> That is interesting as next-20190904 has the DT changes :) Can you share
> the config you used to get this.
>
> I have two instances of sdw_slave_add() in next-20190904:
>
> drivers/soundwire/slave.c:              sdw_slave_add(bus, &id, acpi_fwnode_handle(adev));
> drivers/soundwire/slave.c:              sdw_slave_add(bus, &id, of_fwnode_handle(node));

Ok, I remember now: the warning I got was actually on mainline.
It's fixed in linux-next, but from all I can tell, 5.3-rc7 is still broken.

      Arnd
