Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD9EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9793208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9jAqm4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfFGWSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:18:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46846 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfFGWSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:18:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id m15so2996913ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gldb3yKNAdLFuCuMW3i8lSkcWD9AeAuQqWMCJcjMt1w=;
        b=G9jAqm4GrJw44aseApNTMp1ZjQ/aMJNeUyiv8kQagv/gNhX33BEX/CzFFfoO08fSPB
         FIRt58LdAq424pNBetPm0eg6QkNKMjoFW09a34suTKYEqckDAocINkl4cJNxDodCE96C
         HhxaX0N2dtDsMgQTRenOa3Zz57TDPLOznIac0ahpARr0gBzRph6O+fMw7xfyM5gNCyc4
         ZEwFIOTj8bRtPvpJ/TJwP+iooxqBStOJPX265Lu/PgJ4qiYq+EqEOfo3dHGcStjFlqV7
         i7GxnfE3GpXg8kAr9/410RMqCH8UFTsX34P3RGCzpBMeWL/RtxobGuc1DPYjYqXccE1K
         XzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gldb3yKNAdLFuCuMW3i8lSkcWD9AeAuQqWMCJcjMt1w=;
        b=JUSExYNDcA7ASzh7xsN/2++/oiTL9MSIvghG8T+ja70du0bhE9I/Bo/SeqMvnD64g2
         0GiViVYRY+cE+6kmNzVbleOr5uuL3gn2Te/Y5u19kDZ+V/OXSmWoRVv3A3GhLbNleV8m
         EX+LLFRqQCryBgmkez3N0itVCHANHGRu0iAqRxcVDcjqp++93nKUWWIN2D91uD8vJeO1
         bIAz0alN71L2brsQ52oLV/Sqaxyd0RFEA+INqXUCQcp6rx475iwDBqzrZ87NSfRDNKpo
         ZyWxKr5gwrg+nAILfN6OlFXhQrNsbPfHv4tzVXeLLBLbqKIPJUTTHRdiRxFs7bdPvtrW
         VVpA==
X-Gm-Message-State: APjAAAUTqVi5dUlSyFF9k+mn0RcOq1YZlJBR0lkjMZxQXHVt8MY1dGvB
        x4TuNJIM13R0UAU/X6GjsXfoFxHYoCxpDj1m+T9ybrhq
X-Google-Smtp-Source: APXvYqxOTBAeYX+u/Eh9xZoqx5z1jjeiP4aVzSBSOMzDg0FyT03H0TfU69azZbe7G7oS0gd/G5TcR0QxubMS3IbiYDI=
X-Received: by 2002:a2e:5dc4:: with SMTP id v65mr20370501lje.138.1559945908563;
 Fri, 07 Jun 2019 15:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190604165802.7338-1-daniel.lezcano@linaro.org> <20190604165802.7338-2-daniel.lezcano@linaro.org>
In-Reply-To: <20190604165802.7338-2-daniel.lezcano@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:18:20 +0200
Message-ID: <CACRpkdazSvjt0G58dQOr=cw6mJTptNd3ZmEXduXVh4=01YHNvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Define values for the IPA
 governor for rock960
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 6:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> The intelligent power allocator PID coefficient to be set in sysfs
> are:
>
>     k_d: 0
>     k_po: 79
>     k_i: 10
>     k_pu: 50

With all the other interesting parametrization in the device tree
I kind of wonder why the PID regulator constants defaults are
not set up from device tree?

Any specific reason?

To me it seems like the kind of stuff userpace will invariably just
get wrong or forget about (somebody just runs a different
distribution without the extra magic to set sysfs right) unless
we supply good defaults.

Yours,
Linus Walleij
