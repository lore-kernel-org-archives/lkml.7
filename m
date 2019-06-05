Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2280C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69972075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559723640;
	bh=HvQFg4HJTN4Ylda4tRQWDH51JMjx16CgCWYroFqQzh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a53rBWSr12XyaN66viXxBI/sKTeN2KdpYXzNIuOho4UItjNOh80KvGcB9PuysTy7x
	 4vAj8hxntZESzH+Jn15g9IAsDbnhi25MiJHnbafU+BSiEj9k6x18ItzfYNoTSHrC63
	 7JL0/Y1dXoXV0YyM2fMKgG65ulTqK9ZWG8AqLR9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfFEId7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:33:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40313 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfFEId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:33:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id a9so17032314lff.7;
        Wed, 05 Jun 2019 01:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q9tx+jcvIT26cZO2scmHbp4TeAN9yH+3bSlg5LwUoqc=;
        b=Q7FHA0F54OspHgN46otwSHRChXi36o7PeVumKeArDwAc5UZtxmw6Ws//lQkwgkYU/j
         Y33o/E2G+1NDDfiafBMW9zMr/FhjL99zNxoPnuUqNa09r3tv3Wie7hkvrDzzZj5S2x6a
         4Y+4V/teH0Kg4ZT10290Z3dsQctqst4l9T47tCkwYbMeIA9H6NhnDeDQAEE+FU2Ioom2
         xUvbgwOmCsr0kpU6lCNK//mge56iCWMCj2BDXiIJKSmw8b9goZVyr3EF7P+qmvEbvKjl
         xPzjtNtD2Y0IyZez8N+9qCi1fPySB81012vlrXTWHLs+jCz4GDW1xMOkCG/uIlfn2E+d
         MLZg==
X-Gm-Message-State: APjAAAVsjBWohIXA7xd4LKXV+9L3tuVdXrV7YYsx2v409TfiutAs0cbl
        a1/qtXXmHFe7YdDzx1kbo2wP51OThvo=
X-Google-Smtp-Source: APXvYqwtR8QAunhSjQP25Svspbkpa9nCnvW6tu0Kw7GQYZ2RLBSBlFAZRWmfA/bitG0hHGnEsRD1Tw==
X-Received: by 2002:a19:f806:: with SMTP id a6mr15693187lff.102.1559723636153;
        Wed, 05 Jun 2019 01:33:56 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q2sm1856972lfj.25.2019.06.05.01.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 01:33:55 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hYRMn-0006Ie-H7; Wed, 05 Jun 2019 10:33:53 +0200
Date:   Wed, 5 Jun 2019 10:33:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, balbi@kernel.org,
        wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        alokc@codeaurora.org, kramasub@codeaurora.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Message-ID: <20190605083353.GD29637@localhost>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-2-lee.jones@linaro.org>
 <20190605062020.GL22737@tuxbook-pro>
 <20190605071625.GK4797@dell>
 <20190605075656.GC29637@localhost>
 <20190605082047.GM4797@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605082047.GM4797@dell>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 09:20:47AM +0100, Lee Jones wrote:
> On Wed, 05 Jun 2019, Johan Hovold wrote:

> > No, we don't add noise like this to the logs just because it may be
> > useful while debugging. Even one-liners add up.
> 
> One line per device is should not cause an issue.
> 
> Problems occur when developers try to print all kinds of device
> specifics to the boot log.  A simple, single line for such an
> important device/controller has more benefits than drawbacks.

What about the thousands of probe functions which do not currently spam
the logs? If you want to see all successful probes reliably, you tell
driver core to print it.

> > There are plenty of options for debugging already ranging from adding a
> > temporary dev_info() to the probe function in question to using dynamic
> > debugging to have driver core log every successful probe.
> 
> This is what I ended up doing.  It was time consuming to parse though
> a log of that size when you have no paging or keyboard.

With the right command-line option to enable dynamic debugging you get
one line per successful probe, just like you wanted. Or are you now
saying that one-line per device is too much after all? ;)

> > And in this case you say the driver was in fact already bound; that can
> > easily be verified through sysfs too in case things aren't behaving the
> > way you expect.
> 
> Not in a non-booting system with no keyboard you can't. ;)

Fair enough, but the above would still work.

Johan
