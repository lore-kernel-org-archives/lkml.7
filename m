Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EDEC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DEE20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nmkNcSzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfEPQ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:57:31 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40066 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfEPQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:57:30 -0400
Received: by mail-vs1-f68.google.com with SMTP id c24so2768369vsp.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XhVy4fV27jq2t1U3j4yj5LOX3kolPCtSSv2ORXGfHzE=;
        b=nmkNcSzFh5OLOVDoIP1Pa1b3QlFQ9XUYxSji0qAe4uJ8qe8/ySQ0B315ClUKfCMxCI
         QreA9gJduIu2vRUzTpTojdUotl5e6fJq+SceMidLHwj0AeQMK7NwYdEyur30qezJkGB1
         6P6pUygJV9C+M4itjNtSHxbE6pyY55gvxIt8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XhVy4fV27jq2t1U3j4yj5LOX3kolPCtSSv2ORXGfHzE=;
        b=DkmoV8TgNG4vxSNZuLJ+PztNMZSVcI/WILcq7GDdIKr5lm4MP3XYUzMtN2SRkcU0Wg
         Vss/wYsh7oKiVTLIf9UB9lznNrOkC6Y6ANiUFGacQSos0Jg3GpZV/uRjGiquzoHmjzVk
         n7iwwevokxAj1w0vuenPDpdKUa4+a9mrNduNKAHAPLzVpC65XcOEBuUw9jTNXtMINg9G
         y+suLCXpuzXWClzWRvX1fRtcQRsTlTzzl4fnOUde4pUbBd+ynNknjmVnS/TTHKSc9QCe
         7GrMymmo5aUmxNhRg+ojb5noxKcEkPfDmBbxsXgXftj/x4ObQlHV8Zm9XKP4tNpGvPb8
         Ta3A==
X-Gm-Message-State: APjAAAURWs9OL0nMdMMFA+dx8V0UfKUoAwbyc+/dAtyM2paZ1UypOus8
        ja6Yt+Sy609/keV4kImvHq56B/2C4Jw=
X-Google-Smtp-Source: APXvYqypLVMlluB+MkIOn7qptqQAwAWaZ/aGYkvrYHHyS2RuSeblQMbzU1p4bn+WBVlu3EnDQXNhpA==
X-Received: by 2002:a67:8988:: with SMTP id l130mr23340458vsd.137.1558025848255;
        Thu, 16 May 2019 09:57:28 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id x22sm1297033vkx.50.2019.05.16.09.57.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:57:27 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id n7so1542206uap.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:57:26 -0700 (PDT)
X-Received: by 2002:a9f:24a3:: with SMTP id 32mr1792277uar.109.1558025846288;
 Thu, 16 May 2019 09:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190516162942.154823-1-mka@chromium.org>
In-Reply-To: <20190516162942.154823-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 May 2019 09:57:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XtAMJcNCkV=wm1iNcMo3UenmrCDKJkmS6wtxvtpvLrag@mail.gmail.com>
Message-ID: <CAD=FV=XtAMJcNCkV=wm1iNcMo3UenmrCDKJkmS6wtxvtpvLrag@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: raise CPU trip point
 temperature for veyron to 100 degC
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 16, 2019 at 9:29 AM Matthias Kaehlcke <mka@chromium.org> wrote:

> This value matches what is used by the downstream Chrome OS 3.14
> kernel, the 'official' kernel for veyron devices. Keep the temperature
> for 'speedy' at 90=C2=B0C, as in the downstream kernel.
>
> Increase the temperature for a hardware shutdown to 125=C2=B0C, which
> matches the downstream configuration and gives the system a chance
> to shut down orderly at the criticial trip point.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - patch added to the series
> ---
>  arch/arm/boot/dts/rk3288-veyron-speedy.dts | 4 ++++
>  arch/arm/boot/dts/rk3288-veyron.dtsi       | 5 +++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
