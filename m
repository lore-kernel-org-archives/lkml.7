Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DA7C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9362F20643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy36fvSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfDVWaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:30:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37916 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfDVWaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:30:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so6377904pfo.5;
        Mon, 22 Apr 2019 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/7tXPshEdsTWJZWUNy/QnDoM4LA8FX5Nad1kbXqt6nU=;
        b=Sy36fvSVj91IfbwCfgy41rBhTxmJmD9VPbvtiF1kLi6v/cH9NBpfNcnSGeJ5gBAfA6
         8fs13Yhqr6zdvZ3MHOcJDA/UU2T4r2JxNeQE6oyxTxEJMhlf/PS+BQ+CwVWwAgCWXEq9
         lUmqIapC+vPnoK96d644Pok15U/WUPjqJqnW3HYW+sqFJqS7Vo3HIU716nGNQtbz53Xc
         23biBb1vgQSAn/KW+opALBwJ0gycuYiqlIEiNiFNnqcPIpbKHoJa+8Q9ozYHtpOknjTg
         gfX0wemZdMJDWH0IEjlNcEd0o28rfyxp455IXqwDoNjb1WJaCbl018vYl0+OjNb/8pEm
         503w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/7tXPshEdsTWJZWUNy/QnDoM4LA8FX5Nad1kbXqt6nU=;
        b=NeZzpRAKSKHFm3xnDl/L6bbITL9fy0igkRNFBjYD865+qEkvZ3qz7LvRkuU2qkleWu
         i6ITs9DR22iay8GvQz75NwS0Qo5ynGp1ZK+UDNZHK4ud+wfx+9euX51CrCdTPSQCMMkT
         zxWPg1Ije/JrvSg5hIBlG5S1JNOkVOfPvwq5LjkHXe/cWsbfQlzYjWOKLrSv25CnA+sI
         tUSQrdkP26XP+5nu4H5mQIFWTg/XxM3VEcy3ExQhinsz8cC9oDJ/IiOmajVKHytFwaWz
         M49fSOKxfd18E77yIgAw4nEj3yJWgRxIr4L6wSVpuR0jA+8l768Z1BMSowHvKTZCWEEa
         uQJQ==
X-Gm-Message-State: APjAAAUrkDjnVAkDIPgmSdhsI0PLSE4YSuSG6VeZiDALQfKsMf8EOI+Z
        nGKefrtWi69ED4kI4nVJGt0=
X-Google-Smtp-Source: APXvYqyw2vT3dwC791s5iYRYsEAZKU8+j18crsgT7ux7em64hQ97vPpEZhB37fyk8+thLMlWwoVq2w==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr21415089pgj.396.1555972212790;
        Mon, 22 Apr 2019 15:30:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm27300226pfa.138.2019.04.22.15.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 15:30:12 -0700 (PDT)
Date:   Mon, 22 Apr 2019 15:30:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH v2 48/79] docs: driver-model: convert docs to ReST and
 rename to *.rst
Message-ID: <20190422223011.GA16816@roeck-us.net>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <dbd6b1ffee1bc31c89d0816588f13a7f91bc9f66.1555938376.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd6b1ffee1bc31c89d0816588f13a7f91bc9f66.1555938376.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:27:37AM -0300, Mauro Carvalho Chehab wrote:
> Convert the various documents at the driver-model, preparing
> them to be part of the driver-api book.
> 
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  Documentation/driver-api/gpio/driver.rst      |   2 +-
>  .../driver-model/{binding.txt => binding.rst} |  20 +-
>  .../driver-model/{bus.txt => bus.rst}         |  69 ++--
>  .../driver-model/{class.txt => class.rst}     |  74 ++--
>  ...esign-patterns.txt => design-patterns.rst} | 106 +++---
>  .../driver-model/{device.txt => device.rst}   |  57 +--
>  .../driver-model/{devres.txt => devres.rst}   |  50 +--
>  .../driver-model/{driver.txt => driver.rst}   | 112 +++---
>  Documentation/driver-model/index.rst          |  26 ++
>  .../{overview.txt => overview.rst}            |  37 +-
>  .../{platform.txt => platform.rst}            |  30 +-
>  .../driver-model/{porting.txt => porting.rst} | 333 +++++++++---------
>  Documentation/eisa.txt                        |   4 +-
>  Documentation/hwmon/submitting-patches.rst    |   2 +-

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>
