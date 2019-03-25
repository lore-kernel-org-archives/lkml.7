Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F99C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710522087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yoa2l5HT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfCYJoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:44:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53949 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbfCYJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:44:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so8107786wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sjUvDw4gOuiKbCS9+L4oee/43lzsOILkxD3UaEvPcUw=;
        b=yoa2l5HTCJDO4Qd6U5rUO2b4WmP82IkULUq78oxV7j/Ax1s1hLAsn8c1aJ570M4LLC
         N05lcoIrTthH4x6l9yXaX3y8KcXf/H5LGSmkAppOeqM6d0RxPt/axfNLiGF7Vsa/TgIC
         5/bKzMF+gYcPKSITZqN4iauYfCWOvsEadumgTNxXuh8cCWpPB3TOufiia3tnHEZ8S0PP
         6sPftosrlPemduitr4nVbZIR6RTahp4w0I3DE/Z2oQ5C2/77UsmrlsPg2ggjlp0eNPYX
         emd6NH9e0Guu9+ePoTOI2kpmNWrzlv18QalAijZKo9Kamt8v9o8Wqzc7mR3bSXJ+R7OL
         BDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sjUvDw4gOuiKbCS9+L4oee/43lzsOILkxD3UaEvPcUw=;
        b=U6E9s87TYSqgEeN1UZsrM3sF0I2JZbi5SwWIA5Pl3vYB6nW9vjC2cFHZ7wsziDCZHW
         MZFs3Jux4e+e8r+3pdgB6UMx3o8LfupdrsVHMw1YW2KlZhbc/1EuK9CNhGKTUtz13W9b
         2rbB0+qigkYII1s/bhILaqOcWgQM9HEzW5MmgqVKTKyg9UoDw46kGJ6gmOK+tiR8WdU4
         lXKddCWU3OyBNUaCdWkkHVeDbqW24w+It8jW1UX0ePUDx746hicQe/uwt0moMtIOd1YU
         T/GmL+F46V4Pgxco7CAW5RMrLdRXh7VFwFCbZHQl67kG+KvNlXWfrUiR+kQZfyn070qb
         3NZg==
X-Gm-Message-State: APjAAAXZWy16ruXefEppwXihmkvA7nhhDXV2+2Rbz3nSuSIWa0Hm2qaE
        S019coG/bvkVK1ZR5Y9z3zwsRw==
X-Google-Smtp-Source: APXvYqxgrEbmaJqb5t5YUHDJ+RSVQ8fPlX7fZ6D13OQumRAB3s5mmhRsLE0YzZ9FidXQfGQOu7FCeg==
X-Received: by 2002:a1c:480b:: with SMTP id v11mr9792761wma.25.1553507043298;
        Mon, 25 Mar 2019 02:44:03 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id h9sm3591056wmb.5.2019.03.25.02.44.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 02:44:02 -0700 (PDT)
Message-ID: <283b286671a65160ac8ae08b1e1889bc029db363.camel@baylibre.com>
Subject: Re: [PATCH 0/2] pinctrl: meson: add g12a drive strength support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Go=C5=82aszewski=2C?= Bartosz 
        <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>
Date:   Mon, 25 Mar 2019 10:44:00 +0100
In-Reply-To: <20190314163725.7918-1-jbrunet@baylibre.com>
References: <20190314163725.7918-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-14 at 17:37 +0100, Jerome Brunet wrote:
> The purpose of this patchset is to add drive-strength support in meson pinconf
> driver. This is a new feature that was added on the g12a. It is critical for us
> to support this since many functions are failing with default pad drive-strength.
> 
> Now the slightly annoying part :(
> The value achievable by the SoC are 0.5mA, 2.5mA, 3mA and 4mA and the DT property
> 'drive-strength' is expressed in mA.
> 
> 1) Rounding down the value, we could be requesting a 0mA drive strength.
>    That would look weird.
> 2) Rounding up, we can't distinguish between 2.5mA and 3mA
> 
> To solve this issue in this in this v1, we chose to document that, on Amlogic,
> drive-strength is expressed in uA instead of mA.
> It works well and there is no impact on the other platforms but I'm not sure this
> is really OK with the DT rules ?
> 
> Linus, if this is not OK with you, here are 2 other options we are
> considering. We would be very interested to get your opinion on the matter:
> 
> 1) instead the generic 'drive-strength' property, we could add an amlogic
> specific property, 'amlogic,drive-strength'. It would be expressed in uA
> and parsed in amlogic specific code.
> I think this option is kind of overkill. Expressing drive strength in uA is
> not really amlogic specific so it does not make much sense, but it would
> work ...
> 
> 2) Add another generic property "drive-strength-uA". The change to do so
> would be minimal and could be benefit to other platforms later on.

Hi Linus,

I know it has only been 10 days and you must be busy but I was wondering if we
could get your view on the issue above ?

Since the vast majority of SoC functions need a drive strength setting, DT
patches are somehow blocked until we decide which binding to use for it.

Sorry for this early ping.
Jerome


> 
> Cheers
> Jerome
> 
> Guillaume La Roque (2):
>   dt-bindings: pinctrl: meson: Add drive-strength property
>   pinctrl: meson: add support of drive-strength
> 
>  .../bindings/pinctrl/meson,pinctrl.txt        |   3 +
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  36 ++--
>  drivers/pinctrl/meson/pinctrl-meson.c         | 166 +++++++++++++-----
>  drivers/pinctrl/meson/pinctrl-meson.h         |  20 ++-
>  4 files changed, 165 insertions(+), 60 deletions(-)
> 


