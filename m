Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4A0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2CB217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8N1F/Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfH0Mq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:46:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39960 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0Mq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:46:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so18650709wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5QBDLcjxkLr/nnq6qs0lgCdOCwtscFs7g505ezIG0LQ=;
        b=l8N1F/DzXNM+nJ1ODvblKsaSge7jR1tgnGyWr6gtN2B13qnhtpWlih1mBc7pXZ3vJ3
         NNX0k4gBpFUirBgKuB+UL+QeyFm+RTPOXN3tvgpwfX4uJlAWZ3MrEyJvavAD10wj+VTr
         KPnRPtgpYoIUwvnflZAWBqvvrn+4qd+6VFsXqhuJALrIs5GYbrdlTlkRjYnFcJjj1mI7
         eOrnyEvQ0AQzzAYsJ9qVncvp9D/PVdsTU/pPavB5jM3ft7HosiIU3d+DeZoAaEnPzgTN
         2gBWCtRQd90oxSysFBW4LDkprZ06II/4b8a08oVAi9KYN+OxgYqKtxa0w8KlLdiuF32p
         DAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5QBDLcjxkLr/nnq6qs0lgCdOCwtscFs7g505ezIG0LQ=;
        b=qd7aZsE/BdbsY6xTo9QDxPNS0G1zqV6xkNul56t5lyrBo/J+V8QqxvnUxz1UBF5i3K
         gpStTOYtzXZWEmZujVhPnIcfeEL2oUQlnznfjQmaVFf1GODR8JAo87Mrp2a6gAX8HW/i
         S2XXGxLxO0Z/OwCZ+o97KA3mnWTuxDj6an11gkxlM6JSDex9GwYIriKWK/+xPXmZRPzs
         T2I/ygjgXo8ZrbHiqegyFOr/VVPD94n4dEv5QWgBwQ3dFCAF3o6SPBI3VLy/tRzLJPa2
         GpN3KZegD6KvYGVIlqLCUo1xRjMt70jPpqcVUh1jRg5FUh/UHQlB5CNnFE+VoopeIzwG
         /ePg==
X-Gm-Message-State: APjAAAUglzhUQbp0ypDeS8HnYX2IzKuZOMsp4BBYrbEb5E/TODFepoxk
        KRQ+AmKaCppK2yYM++3vUH2siA==
X-Google-Smtp-Source: APXvYqwkCYWotRKbdpkyQltpLEzjVgv4zLOCd62Wxvwm420LpJOnl5l1wA6kGmw6pCARSyJtSPQJmA==
X-Received: by 2002:a5d:604d:: with SMTP id j13mr28317268wrt.244.1566910015713;
        Tue, 27 Aug 2019 05:46:55 -0700 (PDT)
Received: from dell ([2.27.35.174])
        by smtp.gmail.com with ESMTPSA id u129sm3828248wmb.12.2019.08.27.05.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:46:54 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:46:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v6 08/11] mfd: cros_ec: Add convenience struct to define
 dedicated CrOS EC MCUs
Message-ID: <20190827124652.GC4804@dell>
References: <20190823125331.5070-1-enric.balletbo@collabora.com>
 <20190823125331.5070-9-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823125331.5070-9-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019, Enric Balletbo i Serra wrote:

> With the increasing use of dedicated CrOS EC MCUs, it takes a fair amount
> of boiler plate code to add those devices, add a struct that can be used
> to specify a dedicated CrOS EC MCU so we can just add a new item to it to
> define a new dedicated MCU.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v6:
> - Add a break statement once the MCU type has been determined (Lee Jones)
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mfd/cros_ec_dev.c | 88 ++++++++++++++++++++++-----------------
>  1 file changed, 49 insertions(+), 39 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
