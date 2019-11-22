Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BEAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2369420708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0QZ0PFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKVHpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:45:14 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41243 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfKVHpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 02:45:14 -0500
Received: by mail-vs1-f68.google.com with SMTP id 190so4183083vss.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 23:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Khk7RPCC8dvIurrOXe6a/rIhnCfguLQQ5rTOcR3JbL4=;
        b=l0QZ0PFeZ9C7UPPaeiZ++Vz5YqMWy/zDGZx/L/65JSZ/2ndrObyhIdamdrXom0rWYl
         /uR6lsnV0/3EqqhTFwI/3fchMfkpCDSFva5u+FbBVkxJbFsS2iP0c8ta0rSJPf8P3SCV
         d7ZPfUY+/WvE4CPp8pksg676M2S8ndsQUITw02PXZo65cp4qM+ujm5MDQy8dGjWLfowb
         /POkzqCSn74s/lo4S5IOYLanUiiZNyteZsNJD36neFUISCkKxFgrXjt1ePRmY8OSDaBM
         OKhB1laSwWusabubBScushpwDDYaRG0uBBBL/HZ4fvOCP9gDcjnBapmxaBLb4gGQQTAv
         8sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Khk7RPCC8dvIurrOXe6a/rIhnCfguLQQ5rTOcR3JbL4=;
        b=ee0NF4Zxh8SB7MLbpu7p2Wd+wyyetrWVVlfLVOzKjY1GkGC0J+TSQ8O38Mhlrr2nU3
         yv5+Oy9bsFfT1NgJOwgDEO+DiAGRsQLi1vwRPq5c00u6o3JxlkAezkaAlrju9YgFtHJ3
         7151KMRrbM5X8t7iFLpBJFqGBr9O2F3sbEFEAk7n6dSY7tKNgbRGEXR3L0PKztYRW2Mt
         EzL/dPOv10l6rZ3HUUCE0Q8Fsxua8P3b2WbeIadB+1QU8ud4vIMymg+5DRKu0NkQDeg2
         RUvcEknct5M8nvCcenIeErbXFyOICakLooZ5oQrpVkGrEtZPsMtFz1RUNlflfiotpeGC
         gZ/Q==
X-Gm-Message-State: APjAAAXLAhFPj35EqI6fLzdV/+7CghZJxnxPOI5ksyBOpIBDoUjioxc9
        sy1xJuE0ssYQ4yGBgf+hfaGCKQ9exduP1ZUl8o+2XA==
X-Google-Smtp-Source: APXvYqxn4nqOw0EUK21HEf0TuHRL4qsez4AhPzx6knNfNo/2pYr3N0uOfC4T9fhbR+ZTRgQySFW8Ii4bC3qUwOxpUp8=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr9316374vsa.34.1574408712646;
 Thu, 21 Nov 2019 23:45:12 -0800 (PST)
MIME-Version: 1.0
References: <1574406957-85248-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1574406957-85248-1-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Nov 2019 08:44:36 +0100
Message-ID: <CAPDyKFokY52H4WO7TZHqfUu46U85dOV6FMp1QeY_ivUpfgS2sw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Correct the type of the clk phase properties
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 at 08:16, Manish Narani <manish.narani@xilinx.com> wrote:
>
> The clock phase properties are having two uint32 values. The minItems
> and maxItems are set to 2 for the same. So the property type should be
> 'uint32-array' and not 'uint32'. Modify it to correct the same.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/mmc-controller.yaml | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 305b2016bc17..b130450c3b34 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -334,16 +334,17 @@ patternProperties:
>        - reg
>
>    "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>      minItems: 2
>      maxItems: 2
> -    allOf:
> -      - $ref: /schemas/types.yaml#/definitions/uint32
> -      - minimum: 0
> -        maximum: 359
> -    description:
> -      Set the clock (phase) delays which are to be configured in the
> -      controller while switching to particular speed mode. These values
> -      are in pair of degrees.
> +    items:
> +      minimum: 0
> +      maximum: 359
> +      description:
> +        Set the clock (phase) delays which are to be configured in the
> +        controller while switching to particular speed mode. These values
> +        are in pair of degrees.
>
>  dependencies:
>    cd-debounce-delay-ms: [ cd-gpios ]
> --
> 2.17.1
>
