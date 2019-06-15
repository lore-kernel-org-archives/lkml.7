Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901EEC31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 11:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DB02080A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 11:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJBil7g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfFOLnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 07:43:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46761 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfFOLnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 07:43:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so3040057pgr.13;
        Sat, 15 Jun 2019 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUjJvuIJuf9kpTL8AqJ3ET3rgB/iUv5XqduCHnxMBK4=;
        b=TJBil7g3Cq/qP5HRTHRnzke6fpX21SdYGBIjvW3jZt7N9OeRYSKOD9aQiSIW0z0V6L
         5i+aaA/70RCOv39Tkn7HrOsAHPjJtmgBVW8+PTOwnnK4M6EIl3CqADMNauX09DYiLqI7
         eNgLvXrvPGV1qBuIMNjokfdB3FhULQXMpp7Y4lVlJyoAo7kJQOackT8ExNPVAeMzHFHr
         C/nMD57SIsdguhp0E3xrcUxElknWGRZXK9ENMIPIY7iitiQFtFKIkx2DO7kSj7vO9HSj
         1bWGn6ngkUhPFo8KRL0B2EFMwnK1wviqBOM2kYKnDNh9ikQPfmniXvGAxMw0JvY7j710
         dQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUjJvuIJuf9kpTL8AqJ3ET3rgB/iUv5XqduCHnxMBK4=;
        b=jVzO03Kdhl+ynJZ1V1dRJC18eNXeQa+HX7Ekr8w9xGOINr6Y9ZsJNoFMVR/Bu+JSbZ
         kGC3SjKd/6+5YcBXMQGd6nvsh4PNeflSXxTAXGHOHioBAuPHZjZoxLJjoEeKvA+hUP7B
         KzvAOSNHgx1RFpZhtYVxwQZbK4FA5uhXAq/BLDDZ/MpoZigjrukQPZJfvO9Z5Fip33zu
         9+v74K7BZMT1w4b+3Lbj9Yz80jFPWZZDVOZn1UEhDEXCo3uDUZLUwp/iVkGipQap6nc7
         IBAqkQ/cIK6LvoNg4bk/RrMzH21ULH0rEJh5+lLt5Q0FrFiNYKR9GkqD8vMhpf6KmucP
         DgvQ==
X-Gm-Message-State: APjAAAUtcqE+ULMpkV8n/e6ucYMpHpL5BI4uxkwffHiA5aZoNkJGqf0Q
        mrEQcUQgfCSKyzTPsWL8vGh+3+xxdBfpoy7frSc=
X-Google-Smtp-Source: APXvYqyXkeF8EVnt1DSjQYip4cIMAGErcJmolHnwxkL61NvM8AynVb+7NbOm8IeF8DX+FTpt+y9W2fzp7y2hXHw3M4A=
X-Received: by 2002:a62:14c4:: with SMTP id 187mr30101202pfu.241.1560599000827;
 Sat, 15 Jun 2019 04:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190614214748.2389-1-fancer.lancer@gmail.com>
In-Reply-To: <20190614214748.2389-1-fancer.lancer@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 15 Jun 2019 14:43:09 +0300
Message-ID: <CAHp75VcwP8DzhqfOn=cbcRQtd8WrnuoFPT6GCU754drTZePheg@mail.gmail.com>
Subject: Re: [PATCH] i2c: mux-gpio: Use "mux" con_id to find channel GPIOs
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 12:51 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Recent patch - ("i2c: mux/i801: Switch to use descriptor passing")
> altered the i2c-mux-gpio driver to use the GPIO-descriptor
> based interface to find and request the GPIOs then being utilized
> to select and deselect the channels of GPIO-driven i2c-muxes. Even
> though the proposed modification was correct for the platform_data-based
> systems, it was invalid for the OF-based ones and caused the kernel
> to crash at the driver probe procedure. There were two problems with
> that modification. First of all the gpiod_count() and gpiod_get_index()
> were called with NULL con_id.

I always thought that this means "count me all GPIO's for this device
despite their names" and "get me GPIO by index despite it's name".
What's went wrong?


> Due to this the methods couldn't find
> the "mux-gpios" OF-properties and returned the -ENOENT error. Secondly
> the return value of gpiod_count() wasn't checked for being negative,
> which in case of an error caused the driver to crash. This patch
> is intended to fix the described problems.

-- 
With Best Regards,
Andy Shevchenko
