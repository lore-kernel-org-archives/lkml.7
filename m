Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE034C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0BE20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Yy5jMJ2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfEGPpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:45:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42766 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:45:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so23047852wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2V0KRw1X58VA1zYEdAPk5xBLtGjEZfqDlI4myBarUq4=;
        b=Yy5jMJ2ZIGJeG404RpP9WoYgNRTgrT7VYEhcrexMSkT2UlStHDAKro9YhHqIU9PMMQ
         Gj0SWTbwWOp4k85nkWe7AQCbG958G/t1/tkf7FGVNOnmc6lx6fmKUSQ725yVo6vlNQQr
         JUc02nMsvq2nbCmnvR0IpehTOl51duBRK4067ahnaSB7cu524DKutjAnFW6aOK0m1+2P
         joCLhf5ig8b2ig9oPswIWq/l35IWziGT4chI8F6xifOvS6ZmGwrZoxGQdqufYa+sluUY
         UbG4F25wQqcAbHbdKrTjr1aXfJYhXqcdlRPdNUnV3/MqAC+xOw5aW1Te1jyHXl/tNDh7
         CpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2V0KRw1X58VA1zYEdAPk5xBLtGjEZfqDlI4myBarUq4=;
        b=PyMW0692esUmRU8E5ZY+GToebNDF7gjWb46ztiOv9U8qI16dt4szU2n1lH/2kWIWWo
         LHc/KVY7GHe2xrGbNAQmIdr/tIJteFE61bouf6L7Tx2mAC56cPB3cStK7pw98dNf2GrQ
         nVjBwwYN/1WYO6paJHw4nziPbbQvOOiVA3XM+YTy+/dmV9Ta9K6rfBUY2XJDPS504VFS
         0BJ9Ffl1z/QK4wjBIknstM69dTkUvGMvFMS+O8ROJL4jqFkICSgxk3X6U5KFpEEGJYWz
         0Pf7HA9LA0JRVbO+un9Zp5WolU9hiuikAwv8onTw9pnueNb8m3IsrG3q6oIcQsbpWNhS
         U1Zg==
X-Gm-Message-State: APjAAAUcSw9Pb43LwfI5kihfJ8GthDN++bi9De50YOWuJ7dVLzHCGf9k
        GkYeO+1oUmDGozJOn2JkZFhDsTdmLrY=
X-Google-Smtp-Source: APXvYqx1ZgBnmf0Vh3kreTWGa5/FxgkWxJQ/j0gdArM5OEkyd7Azus61oAFXyJvB3HAhrbHjJgvz7Q==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr18766060wrv.79.1557243902842;
        Tue, 07 May 2019 08:45:02 -0700 (PDT)
Received: from boomer.baylibre.com (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id j71sm14285280wmj.44.2019.05.07.08.45.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 08:45:02 -0700 (PDT)
Message-ID: <8c4776976c1803d4cd944d88dd73e2b414fe1201.camel@baylibre.com>
Subject: Re: [PATCH v3 0/6]  Add drive-strength in Meson pinctrl driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 May 2019 17:45:00 +0200
In-Reply-To: <20190507115726.23714-1-glaroque@baylibre.com>
References: <20190507115726.23714-1-glaroque@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-07 at 13:57 +0200, Guillaume La Roque wrote:
> The purpose of this patchset is to add drive-strength support in meson pinconf
> driver. This is a new feature that was added on the g12a. It is critical for us
> to support this since many functions are failing with default pad drive-strength.
> 
> The value achievable by the SoC are 0.5mA, 2.5mA, 3mA and 4mA and the DT property
> 'drive-strength' is expressed in mA.
> So this patch add another generic property "drive-strength-uA". The change to do so
> would be minimal and could be benefit to other platforms later on.
> 
> Cheers
> Guillaume
> 
> Changes since v2:
> - update driver-strength-uA property to be compliant with DT documentation
> - rework patch series for better understanding
> - rework set_bias function
> 
> Changes since v1:
> - fix missing break
> - implement new pinctrl generic property "drive-strength-uA"
> 
> [1] https://lkml.kernel.org/r/20190314163725.7918-1-jbrunet@baylibre.com
> 
> 
> Guillaume La Roque (6):
>   dt-bindings: pinctrl: add a 'drive-strength-microamp' property
>   pinctrl: generic: add new 'drive-strength-microamp' property support
>   dt-bindings: pinctrl: meson: Add drive-strength-microamp property
>   pinctrl: meson: Rework enable/disable bias part
>   pinctrl: meson: add support of drive-strength-microamp
>   pinctrl: meson: g12a: add DS bank value
> 
>  .../bindings/pinctrl/meson,pinctrl.txt        |   4 +
>  .../bindings/pinctrl/pinctrl-bindings.txt     |   3 +
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  36 ++--
>  drivers/pinctrl/meson/pinctrl-meson.c         | 177 +++++++++++++++---
>  drivers/pinctrl/meson/pinctrl-meson.h         |  18 +-
>  drivers/pinctrl/pinconf-generic.c             |   2 +
>  include/linux/pinctrl/pinconf-generic.h       |   3 +
>  7 files changed, 195 insertions(+), 48 deletions(-)
> 

Tested-by: Jerome Brunet <jbrunet@baylibre.com>

