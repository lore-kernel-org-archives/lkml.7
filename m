Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F5C48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6F7208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561579203;
	bh=PqkQacy8e28qP3sUTBhoHayPPBYArIhVloWeM/yincM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Shv+6mLL4TQf2lwR8YpUhJcApaXPfaFhHZ0LVjvxVu6SClGNoIHbhQYHeVBpBfIUD
	 oDBf1GQEJXgRqGwq5N+IlUghyNzR4Qq0Ps+dVkCEp9EwU+I5voir/mFldqIq5EYwIS
	 nExOn4RD/5yy3bYh5siRZndsE1Wk0b0o3pyN+di4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfFZUAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZUAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:00:01 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3DB217D4;
        Wed, 26 Jun 2019 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561579201;
        bh=PqkQacy8e28qP3sUTBhoHayPPBYArIhVloWeM/yincM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0TnV2TM+KzAMvU87BxAxZvIfn2O43BItJkPjOAxnXJJbRL7twuT6s8UmGCGTQQPMf
         y/iRLLHN4+NXEi2N0uza+PD3gq2vWSTIcJU15mINmVGI7UXqIBRGCvBkz+G+FUXiiI
         4isHic/ZCW2TRL6tf7kAb+Ul5hlkYJRHqy23BCOo=
Received: by mail-qt1-f181.google.com with SMTP id w40so3847113qtk.0;
        Wed, 26 Jun 2019 13:00:00 -0700 (PDT)
X-Gm-Message-State: APjAAAUYdI2livavuRGssqdAKph+DmhuBXAGcS9EqmTRmPX4l/LTBJ+k
        hCO4/Bmviyukme9M8EUBZ6WOEG3gEKIJAtgMsg==
X-Google-Smtp-Source: APXvYqzq5VKBQtvH5B3vNDjgzQKna5ozyimyAo13hCtAdjYwyS3AUtxMI+8ovK7r0ch9L898z9KqjFrg6te9ckWuQB4=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr5473062qtc.143.1561579200198;
 Wed, 26 Jun 2019 13:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <1561389236-26464-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1561389236-26464-1-git-send-email-stefan.popa@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jun 2019 13:59:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-Pxef5oNAx5-crGxL9Q0Ph5gx2Z=KejLSq_jdgVUvbQ@mail.gmail.com>
Message-ID: <CAL_JsqL-Pxef5oNAx5-crGxL9Q0Ph5gx2Z=KejLSq_jdgVUvbQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: frequency: adf4371: Add support for output stage mute
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 9:14 AM Stefan Popa <stefan.popa@analog.com> wrote:
>
> Another feature of the ADF4371/ADF4372 is that the supply current to the
> RF8P and RF8N output stage can shut down until the ADF4371 achieves lock
> as measured by the digital lock detect circuitry. The mute to lock
> detect bit (MUTE_LD) in REG25 enables this function.
>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/frequency/adf4371.yaml          |  6 ++++++

If you resend and in the future, please split bindings to separate patch.

>  drivers/iio/frequency/adf4371.c                             | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index a268a9d..6db8742 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -32,6 +32,12 @@ properties:
>      items:
>        - clkin
>
> +  adi,mute-till-lock-en:
> +    description:
> +      If this property is present, then the supply current to RF8P and RF8N
> +      output stage will shut down until the ADF4371/ADF4372 achieves lock as
> +      measured by the digital lock detect circuitry.

You need to define the type:

type: boolean

Maybe Jonathan will fix up.

Rob
