Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F958C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CB1206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KW7vTBZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfEGNiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:38:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37465 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEGNit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:38:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so12299012wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=95N2sOqjFK2SEDFDpk3AdvSOj/M5lpdzHr7lDlnGVig=;
        b=KW7vTBZFonygPEsPYR1tw6TF8a/+gXvDihNoSLjkrxXD8EgTDd6B/RdpwFdhKeGKjh
         6niiPi11BNQAxL+xjtMG3PPpvoSbSOC+X92Ty7yBwRaLMUDScWXaw06sNMnB05Vtuu/d
         /3bxbZ0wyFRkvqGIjczQh4UZP6lHC8oJa5sZOagRNjiJDcHXQJCj1HPZ6AwfLUZTH6NW
         y23etyfvPFxvuNmszYYvWFb8iPgsedsyRJ3ARs3XG4v+bj5ih3n5O5JQ68Q2JghSn9kT
         XFUjawSumswdkJhhx9MzEMszB1MoI6gcv7yFFfkxcuULqLCzYchbsr9qz5sOZ3YE2PY/
         zxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=95N2sOqjFK2SEDFDpk3AdvSOj/M5lpdzHr7lDlnGVig=;
        b=uJNvsDz2onrmz4YfbplAC6uNwFNHE9FxVFQqQHDAxrV4CfrtuTIlQsEssmswK/KatH
         dKxLoZKHFo/P8UOKJr05K1pM0/g//N1zURZ7a5LkqTNjeZrrixi9daM+JIhviu5T2fJs
         M3XZRgPugfzJ302SnJjc+MEN+dwzI0BmOImzf1yW5Hj+EgngaXNbGKo56sWJ5gfBdloc
         Z3VxpvuTKsVqrwoLXf3nBIOBpqbqKDyz2zxEFSk9lRsqNbhnJh0fLKXEHQlD8EYRcrLM
         LZSHZdZRuHVHp21Y78if21VccAIM93xIECPj9S8Nmaeb0wBIteH3oZXsjYVo0fxziHyA
         qUjA==
X-Gm-Message-State: APjAAAXJ7+4K/2pp9k5Z4Tchn0khrT5cMCTintIzWZUQnmvk28ZTa8yX
        zJXoJAu5sDfaDpensRdd0hn96A==
X-Google-Smtp-Source: APXvYqzrdd7zz5Iz0HMfCihsYkzCM0ADuKXZIalIyV9JbYo1YJoAg+GYQ1uc4j1S1mhLwC9oPzMZig==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr999162wrn.113.1557236327254;
        Tue, 07 May 2019 06:38:47 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id v12sm11606546wrw.23.2019.05.07.06.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 06:38:46 -0700 (PDT)
Date:   Tue, 7 May 2019 14:38:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD
 function
Message-ID: <20190507133844.GA6194@dell>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-3-esben@geanix.com>
 <20190507114905.GB29524@dell>
 <87o94ejwrx.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o94ejwrx.fsf@haabendal.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 May 2019, Esben Haabendal wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > On Fri, 26 Apr 2019, Esben Haabendal wrote:
> >
> >> The serial8250-mfd driver is for adding 8250/16550 UART ports as functions
> >> to an MFD driver.
> >> 
> >> When calling mfd_add_device(), platform_data should be a pointer to a
> >> struct plat_serial8250_port, with proper settings like .flags, .type,
> >> .iotype, .regshift and .uartclk.  Memory (or ioport) and IRQ should be
> >> passed as cell resources.
> >
> > What?  No, please!
> >
> > If you *must* create a whole driver just to be able to use
> > platform_*() helpers (which I don't think you should), then please
> > call it something else.  This doesn't have anything to do with MFD.
> 
> True.
> 
> I really don't think it is a good idea to create a whole driver just to
> be able to use platform_get_*() helpers.  And if I am forced to do this,
> because I am unable to convince Andy to improve the standard serial8250
> driver to support that, it should be called MFD.  The driver would be

I assume you mean "shouldn't"?

> generally usable for all usecases where platform_get_*() works.
> 
> I don't have any idea what to call such a driver.  It really would just
> be a fork of the current serial8250 driver, just allowing use of
> platform_get_*(), supporting exactly the same hardware.
> 
> I am still hoping that we can find a way to improve serial8250 to be
> usable in these cases.

Me too.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
