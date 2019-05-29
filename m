Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7B6C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E2A241C3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MYnV6jPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfE2VA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:00:58 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38701 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfE2VA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:00:57 -0400
Received: by mail-vs1-f67.google.com with SMTP id b10so2968898vsp.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBUjmO48wu/hXLqovuR/vBZEzCJTLpXLZDjTGDnkOW0=;
        b=MYnV6jPu3a4BZPAh5FXxalqN3ma14VPcQRvqY79POudpgHYhgJbyDkql8QqTIWTnNa
         Ha96YuKY1DB0lO7JRbCKXd4dCUgk2VlapjcA+t7crTi3f995C9ZFomGjGZaLctZNMu1k
         F5yQ+2gRo1ViDm7xJoYEYJTlzdj79aYtkhiRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBUjmO48wu/hXLqovuR/vBZEzCJTLpXLZDjTGDnkOW0=;
        b=ivbmjfOGkJ6nIP5rohunjIcHU2B5gA8kDuLL1aG4KmZCozpKcVenRkd0ocPovfFgPe
         de5rtRPlTwDnaociUlnDFVjSsKnx68cRQnu0qsy1q8oNSxjvLe15pebElvrFoPEG+bTl
         5ppUFWr3G5snWDq0XI0afqocbAO4y11kb726uUScqFq7aP2iqV1wnG5TNiqglO2qXy5h
         GjbfDS8mTX1TEXazatR1vR4HL9jBJ41DEQZQ59ZcTdx4+6gSfbmHZLa5XxWmDC4/Fsn6
         u1oN3LVjrK7k/vJX6+5h7gsSEapFLSZ4NWTllvHsT8rVGflEoCIPqk/Zf1qmM09/r/Ch
         8R9g==
X-Gm-Message-State: APjAAAWsW24eL232+QAd9eYzvoMXL9HrkwE5ET5dnPVIfqxDUo/xtQp5
        RN2ukoQV0S0YGYewARyJjJrodcAGnX4=
X-Google-Smtp-Source: APXvYqwm7ET7qy+d/uK9/oBJhS8GGZir8yLsc7oyjEsx1KPrxBoXzfsneUeSoYsfDIsW0OP4xBOaHQ==
X-Received: by 2002:a67:e98e:: with SMTP id b14mr76138461vso.145.1559163656149;
        Wed, 29 May 2019 14:00:56 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id v133sm392277vkv.5.2019.05.29.14.00.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 14:00:53 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id v69so316196vke.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:00:53 -0700 (PDT)
X-Received: by 2002:a1f:3692:: with SMTP id d140mr30303598vka.70.1559163653164;
 Wed, 29 May 2019 14:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <1559163283-2429-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1559163283-2429-1-git-send-email-linux@roeck-us.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 May 2019 14:00:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WaWf51QTzPAv68e8m-WZ287E63M_y2G=dVmowh91p9jg@mail.gmail.com>
Message-ID: <CAD=FV=WaWf51QTzPAv68e8m-WZ287E63M_y2G=dVmowh91p9jg@mail.gmail.com>
Subject: Re: [PATCH] Revert "usb: dwc2: host: Setting qtd to NULL after
 freeing it"
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vardan Mikayelyan <mvardan@synopsys.com>,
        John Youn <johnyoun@synopsys.com>,
        Douglas Anderson <dianders@chromiun.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 29, 2019 at 1:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This reverts commit b0d659022e5c96ee5c4bd62d22d3da2d66de306b.
>
> The reverted commit does nothing but adding two unnecessary lines
> of code.  It sets a local variable to NULL in two functions, but
> that variable is not used anywhere in the rest of those functions.
> This is just confusing, so let's remove it.
>
> Cc: Vardan Mikayelyan <mvardan@synopsys.com>
> Cc: John Youn <johnyoun@synopsys.com>
> Cc: Douglas Anderson <dianders@chromiun.org>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/usb/dwc2/hcd.c | 1 -
>  drivers/usb/dwc2/hcd.h | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
