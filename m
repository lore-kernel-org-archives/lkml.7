Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC722073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="uoPG9cTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfLCQyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:54:10 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41538 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfLCQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:54:10 -0500
Received: by mail-vk1-f193.google.com with SMTP id p191so1259507vkf.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcM7UEIp8ymleTTTyVFIALYBt+4goDjQpS4y6N2B+wI=;
        b=uoPG9cTRt/hqq0DuB5ne0h2K4POk21yL2O8Fa6xz0FrVObCVI0zSRWTUcGvf4krFI/
         asiNumPnrPNLb7J4jVBdwacvkkz384DBFcnw7JLMkl7zvQNAImvxP21kiwvtk4e2XxeN
         9kI7AnlY7SAN8D7iwzo6JmHQGvQHxHq7oeT/P1vwBRWUmuNX/MSDJAk8mJKiOA9QTqhS
         JqeP6vA6UUUt7PMLJCfMTubv/VQLY3QEn8i/RNiwvMVecT/NMo1BCqWJVavnYqYI6Ogv
         4pYiZcgGDJzgVPPp7Mfu4D8R5AFJNSw18GYlBT8lM77MTOqjwLCKpCZ6pJAKjrwCOpq7
         JC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcM7UEIp8ymleTTTyVFIALYBt+4goDjQpS4y6N2B+wI=;
        b=fxm0pBEiC2ZG/s7r/Ogrs+66lbykYWPy3LAI+DIj7efc1u8cjquN6wQwarT1QBtQvN
         Ab+s+eAdW2eZ/N8nDwZjXcza7bDTi4QKXGz2LNnyg342nbWvInW545FYLwThwkb5GMV9
         QgHuLrUrlyiavNt7zWbMAhO+CjuSsMpsUy2pIxl9sbK5nOfunFuVwH4bBDXYGBcKCujO
         rBXz0f51WFFb0g3nZ6tr3RtcDTJEM+xHlXp+p+i4O/8Brp+w0Nd85rGrovFKowXMdEbB
         njvCvTrD1iVONHCnsCjvICeDPTIsjht3fmKc8gvBohdzq0fRu7HuxxTeS709vkSMaLd5
         PoTg==
X-Gm-Message-State: APjAAAXUnXawehI/SsqdU29ovffVmuDf2xZVLN+793HmdDTf8+TzzaTe
        2GNac/AEZB5r+tKSTK4HEyJHcRmgugyLTwXG75OFGw==
X-Google-Smtp-Source: APXvYqwWfxtECH6IzRO2KWDRHz/G7gB6OReuBEbvIF27Ze3wf/2BXsYSC4Slvqkh+Z8aSkU/Vruvxo83JKiIBbSncWs=
X-Received: by 2002:a1f:bdd0:: with SMTP id n199mr4259634vkf.86.1575392048634;
 Tue, 03 Dec 2019 08:54:08 -0800 (PST)
MIME-Version: 1.0
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org> <1568859503-19725-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1568859503-19725-2-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 3 Dec 2019 22:23:57 +0530
Message-ID: <CAHLCerMif4ZyUwO-r04Ds3AZuRQNtw5bfFjWa9nOhTovMxVYOA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: thermal: Introduce monitor-falling
 parameter to thermal trip point binding
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 7:48 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Introduce a new binding parameter to thermal trip point description
> to indicate whether the temperature level specified by the trip point
> is monitored for a rise or fall in temperature.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index ca14ba9..849a2a9 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -90,6 +90,14 @@ Required properties:
>         "critical":     Hardware not reliable.
>    Type: string
>
> +Optional property:
> +- monitor-falling:     Indicate whether the system action is kick

Stray space after :

> +  Type: boolean                started when the temperature falls below or rises

Unnecessary tab after boolean (I'll fix up the rest of the file in the
yaml conversion)

I suggest not making this boolean. Just use the property as a flag by
itself to denote a falling trip point. No need to deal with true/false
values.

Similarly, the sysfs file would show up only in case of a trip that
sets this flag and just contain a 1, for example.

> +                       above the trip temperature level indicated in
> +                       "temperature".If true, the trip point is monitored

Add space after full stop.


> +                       for falling temperature else the trip point is
> +                       monitored for rising temperature.
> +
>  * Cooling device maps
>
>  The cooling device maps node is a node to describe how cooling devices
> --
> 2.1.4
>
