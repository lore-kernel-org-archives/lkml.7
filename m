Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2812C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51BD20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nRR+/O1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfFEIt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:49:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42232 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfFEItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:49:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so530695wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=47X4zT30GaadHJDaOJJAh/DnRfU8HKGu6t7RX9pL/1E=;
        b=nRR+/O1w2hpos8U3WuMiH/3+BN6lTgWYnsbBoN6gkVLrZ1RHMizsu+4ZO9EuzH4TaB
         JaodAlZK3Kx2Q2WmB+EnEIN4wEJCqbyWdIq3GrjNrF/eMlNvvhbGv1T3/iQg83ufteRt
         Ty7tf9D0F1yh4O5vWOF1XlO7xgunN2POXJD12fUH+Orf9E4jk0Jg5oSY9sKLt7hLAeMU
         8vwQ3faYAIOoLM5uZ1OAR9oHHJzWu0gZIUKOZNV4CWV3ujufMGwZx8Gei7yNZu6lnFos
         xpv7J1856IHDdO5sl9kIutepdd1VmglvBLZeIjZyX1J4L0DgbnVEE6f9z8GHgItLDDJu
         Krrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=47X4zT30GaadHJDaOJJAh/DnRfU8HKGu6t7RX9pL/1E=;
        b=X2EkVhH4g6+7kRswIgvPsThNqVyKZRTCeA32dParbP2fYGsU+UbHZifB7wzFh9HyOF
         3manaAfYt8e8xT64INj5cQuxq5pVMqngLt+lv/KagNsmcbHYT7Z+g5uh7vt1x42s3S96
         c1BeDCFIyQ50xAVSuJFHte01WFhyWvGTy+S1XEV+Rh3DSDfErs5hHx1cG3dsqLRWXoKZ
         cVP8+N8VnHvOUAx9HJYjFB4xnBdCf4aUI2AwLXvQYV625dk305jdSZkQsIQBoNQJNBFS
         ZvG5K5pGajLa3HA0Za3yYhgSVXMyOa0b7ZxokBpPNp7d/BtniTGmsf4LN/hmOBw7vbII
         3YkQ==
X-Gm-Message-State: APjAAAULGP4nn/bo2HIEcjcseVdiVSinEUM9Q90G8Wn6mFhGx18ne9YU
        ffH7GGqp9ixtrF9rI01+hHi1HA==
X-Google-Smtp-Source: APXvYqxKnUroo208CFyjzxg0auBl2QoUOj9T6CN3+LaoIlDzgTwijaRuwxToGpm9u7DR/bSrMEMWdA==
X-Received: by 2002:adf:ab11:: with SMTP id q17mr10398482wrc.182.1559724563960;
        Wed, 05 Jun 2019 01:49:23 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id y2sm32449365wra.58.2019.06.05.01.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 01:49:23 -0700 (PDT)
Date:   Wed, 5 Jun 2019 09:49:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, balbi@kernel.org,
        wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        alokc@codeaurora.org, kramasub@codeaurora.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Message-ID: <20190605084921.GQ4797@dell>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-2-lee.jones@linaro.org>
 <20190605062020.GL22737@tuxbook-pro>
 <20190605071625.GK4797@dell>
 <20190605075656.GC29637@localhost>
 <20190605082047.GM4797@dell>
 <20190605083353.GD29637@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605083353.GD29637@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019, Johan Hovold wrote:

> On Wed, Jun 05, 2019 at 09:20:47AM +0100, Lee Jones wrote:
> > On Wed, 05 Jun 2019, Johan Hovold wrote:
> 
> > > No, we don't add noise like this to the logs just because it may be
> > > useful while debugging. Even one-liners add up.
> > 
> > One line per device is should not cause an issue.
> > 
> > Problems occur when developers try to print all kinds of device
> > specifics to the boot log.  A simple, single line for such an
> > important device/controller has more benefits than drawbacks.
> 
> What about the thousands of probe functions which do not currently spam
> the logs? If you want to see all successful probes reliably, you tell
> driver core to print it.
> 
> > > There are plenty of options for debugging already ranging from adding a
> > > temporary dev_info() to the probe function in question to using dynamic
> > > debugging to have driver core log every successful probe.
> > 
> > This is what I ended up doing.  It was time consuming to parse though
> > a log of that size when you have no paging or keyboard.
> 
> With the right command-line option to enable dynamic debugging you get
> one line per successful probe, just like you wanted. Or are you now
> saying that one-line per device is too much after all? ;)

Which command line option are you pertaining to?

> > > And in this case you say the driver was in fact already bound; that can
> > > easily be verified through sysfs too in case things aren't behaving the
> > > way you expect.
> > 
> > Not in a non-booting system with no keyboard you can't. ;)
> 
> Fair enough, but the above would still work.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
