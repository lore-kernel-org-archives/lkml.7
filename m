Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89023CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B75D2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ru11L2IB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbfJ2QJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:09:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46024 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390268AbfJ2QJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:09:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id k2so4270280oij.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/GoSbHE+NLH7W2Mu8zFFQ7lEbuLzZk7XwxfHja+Yzg=;
        b=Ru11L2IBkDIJZsYDjB85uuW3Hg6Ogmc7cMCeDS0TOGdpcjHv6AH0W1gpfdo3vWCyL/
         OjExvMLYmUEHKRBLIVMuGNq/SdG8vAKBGNeKvaDY20WOV/aywssoBIVexPeIloKvk5Ls
         Jj07IgPDrnplLyVcXn2HsuhY9ZVjD1C8Q0dNWikuxqoUeHG5E8n4OVE8gF6fFHXSQxP9
         QAIGKqUxMCg6te++WPC0c4rNq8iRuOLIppaYeuzuavb1RLPTFjZ8GwMMTfbhi8sRSGY+
         FT3RxuiLlo1mIG3sp9xz+zc1DI7rl+bYyUUUFcydf2U9uDwVBF08uQg7PNTX3HFh3xvc
         edQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/GoSbHE+NLH7W2Mu8zFFQ7lEbuLzZk7XwxfHja+Yzg=;
        b=SsQpQIXL00ESC1ZMG7gEAjhTSzCrD9BixPtWcGCreWr1cRLaPwTZx3lOY0zmQxVknc
         FCYavKJSlJPwfFKkA7e3JlPbS/Z47c6J4V3v/szGvcZ9RhESBqNVBA1R4aCKdps44STf
         Z4A1pLpVI9kxCFNLa+5k4TTGgc2h2wOl4T6LcwI1WG5mnxO9LD52eGO+qzAuVKXbrMJy
         cA4xzsdoUYcfZ+YOjgDBl/TiiRRWh4x832r907YEtA9O5jscp34EfHyMDMFYUVy0yDHh
         lKL0Agz9s5uCKtrshbjwGpaLvEyw3Cbp72cuSJ85eg5l64gBrfjhUOpMBTGR/n+3K8Eg
         L60A==
X-Gm-Message-State: APjAAAUT2b6CK1igZd/AmP9cbqAjRHqbQpNqSEga1pTMm4mkmNylEfgq
        h8+gBQYXmJ6PgwXs5uv5obC7ZiJg/VyBV3wpCBameA==
X-Google-Smtp-Source: APXvYqyUdt6hrcGTDjR4iRzpaqwjYQyaEgSSfsTCCUv2cn8n1UmI7xc7BHLfG91xsZCfZGzbryCeEpK0xU9nqnkZcgM=
X-Received: by 2002:aca:c3cf:: with SMTP id t198mr4927418oif.10.1572365343764;
 Tue, 29 Oct 2019 09:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-6-john.stultz@linaro.org> <87k18nj4mj.fsf@gmail.com>
In-Reply-To: <87k18nj4mj.fsf@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 09:08:53 -0700
Message-ID: <CALAqxLXcD8V1o01yMrHpeoqU2MfJ=8d3dbzC8T-+aoovDUd8kA@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] usb: dwc3: Rework clock initialization to be more flexible
To:     Felipe Balbi <balbi@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 2:14 AM Felipe Balbi <balbi@kernel.org> wrote:
> John Stultz <john.stultz@linaro.org> writes:
>
> > The dwc3 core binding specifies three clocks:
> >   ref, bus_early, and suspend
> >
> > which are all controlled in the driver together.
> >
> > However some variants of the hardware my not have all three clks
>                                         ^^
>                                         may
>
> In fact *all* platforms have all three clocks. It's just that in some
> cases clock pins are shorted together (or take input from same clock).
>
...
> another option would be to pass three clocks with the same phandle. That
> would even make sure that clock usage counts are correct, no?

Hey Felipe!

So I actually had done that initially (and it seemed to work), but Rob
suggested this way instead.
I'm fine with either, as long as having multiple references to the
same clk in the enable/disable paths doesn't cause trouble.

Thanks so much for the review here!
-john
