Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33177214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568769567;
	bh=HkxPCrl7Mh/tnOhaXYwkBScK25ecsOpLFed95TYG8II=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gOt+k/BH9eM3ab5KhzeQptQPy4bXaLodIqW1K5VDgESrfwS19QH/3WoJRBQ7v0OGa
	 J+rl3ZG+0sLGhIWxq0+5eZY1MwG5xbdLoKvT+JB4HrVj5NDt+7GS8L5mWxmR5yP5eh
	 3nrXrqLPO9+vT/VOQNW39DWpO6ZU/920uloqvwOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfIRBT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 21:19:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42826 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfIRBTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:19:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so4335180lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 18:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9sK1ngN/n6Bki2rTXsaIHGzKhpD8qU//AwbTzCHcEM=;
        b=Lv1OlFB+vE/8hyhp6ljiiZQvJidCEy0ZgSymKjsTaYB5I3jEEpIO7SIuzdDDctYw3m
         z3Togu0rcN6U6Ol4q1onK9YPtDhox0+GJJH6YXbIiIlo70XiKJ/4a/pyYOsczsv4fhPu
         nWhCU33cEfqauY+INzFZh1Ld3jQnuh8pymZGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9sK1ngN/n6Bki2rTXsaIHGzKhpD8qU//AwbTzCHcEM=;
        b=Ia0YntqZwNZ2EDUzfWz+YbAMRWPjb1CO2eq3nztTxv2lcl58PieGyOumTciEWWKJBr
         9rM9stVn1nNiTwvKsyyLOREkNm0xMjM8W113hI5EZ6Gqm6dJQWEixkgYJk9/jrqN/Pku
         b0XiM2O4zpG3TFQ+aYA/IfrmRPqp8G020GPg+/veVFrqFSZxofhf0F+Hoq+BC8fA+eDW
         8teg10fr/GHIjVk8UThgkYE4pAMUp0eZPyQ4pLN6+eYm093r260awXAzjFxqu/Q3woG5
         Rz1UNVtatARbgCrPHgOMHHIyOduzSyhFx7pr1/T8ZnU/g/js+jPEUvZCQXg4Z9ZItTkF
         AGZA==
X-Gm-Message-State: APjAAAVsAIMPmMuS1cod+zAIgB3X33nMcPee1vij8XC3jFM/+nMndVl1
        1VG1OTqAf811/HUfOJLUHVovsi8o1C4=
X-Google-Smtp-Source: APXvYqzlVQHr/dm0KQNcK4nCn2JtSUISl+zNWY5T4JA82g6VygUC+RlGxCjDlNXGBp16FWZJ9+Q7Hg==
X-Received: by 2002:a19:6504:: with SMTP id z4mr563960lfb.123.1568769561695;
        Tue, 17 Sep 2019 18:19:21 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id f21sm864397lfm.90.2019.09.17.18.19.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 18:19:21 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id q64so5419104ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 18:19:21 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr632522ljs.156.1568769205183;
 Tue, 17 Sep 2019 18:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190916222133.9119-1-jacek.anaszewski@gmail.com>
In-Reply-To: <20190916222133.9119-1-jacek.anaszewski@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 18:13:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxNj_RBpE0xRYnMQ9W6PtyLx+LS+pZ_BqG31vute1iAg@mail.gmail.com>
Message-ID: <CAHk-=wgxNj_RBpE0xRYnMQ9W6PtyLx+LS+pZ_BqG31vute1iAg@mail.gmail.com>
Subject: Re: [GIT PULL] LED updates for 5.4-rc1
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org, ada@thorsis.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        christophe.jaillet@wanadoo.fr, dmurphy@ti.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>, info@metux.net,
        Joe Perches <joe@perches.com>, kw@linux.com,
        Linus Walleij <linus.walleij@linaro.org>,
        nishkadg.linux@gmail.com, nstoughton@logitech.com, oleg@kaa.org.ua,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Lindgren <tony@atomide.com>, wenwen@cs.uga.edu,
        wsa+renesas@sang-engineering.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 3:21 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> There is one merge of tag with generic_lookup_helpers since
> LED class has been made using class_find_device_by_name() helper:
>
>     Merge tag 'generic_lookup_helpers' into for-next
>     platform: Add platform_find_device_by_driver() helper
>     drivers: Add generic helper to match any device
>     drivers: Introduce device lookup variants by ACPI_COMPANION device
>     drivers: Introduce device lookup variants by device type
>     drivers: Introduce device lookup variants by fwnode
>     drivers: Introduce device lookup variants by of_node
>     drivers: Introduce device lookup variants by name

So this is fine and I've pulled it, but I have to say that I
absolutely detest how this device.h header keeps just growing
endlessly:

  [torvalds@linux]$ wc include/linux/device.h
   1921  8252 66021 include/linux/device.h

that's almost 2k of header file, and it's included a _lot_:

  [torvalds@linux]$ git grep include.*linux/device.h | wc
   2518    5085  144875

and many of those includes are actually from other core header files,
so it's effectively included from even more trees.

Yes, yes, many of those 2k lines are comments. But still... Do we
really want to have that humongous 65kB, 2kloc header file, and keep
growing it forever?

Greg?

                  Linus
