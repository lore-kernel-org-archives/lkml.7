Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D01BC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5C220815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="egW17PcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfEPQ6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:58:14 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42071 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEPQ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:58:14 -0400
Received: by mail-vs1-f67.google.com with SMTP id z11so2758502vsq.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GQWLFHbMxy0K35NUOa8JBzz6IPOsbH5VHwjdAfW9zU0=;
        b=egW17PcXO0BjCt7HxJYjB66FokiITWMqtp0008EeL5GbbhpQKonq2gHOFHRGrZ0me5
         TihY4jgy1laPIDXVBzdJoZ0YexQhL6W55jcDyEERvFOMCdfrqTI14wa/uBSkoCgEekSx
         1nR/Oufvd/pGx1D8omffLmUof28M5fDBbkk5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GQWLFHbMxy0K35NUOa8JBzz6IPOsbH5VHwjdAfW9zU0=;
        b=JDoDGrZPd+F2cNnOvuliWGhH/NX9IP+9KGNdF+AJ+IzCp/uW1P7umtDBrHWe6iL/Mm
         6EAq/50b+HrEtj8h6gNFOJPYmjLAs7rCmSDd0SWLwkGkTj+aPs5ec0CFBC0QYI2lHAM2
         nFZnZ+ig1mzuGAfmyoI5i9UCFx325u+i07gQHrENCHd9aFb5I7i1XNCsmebOcblIuAXw
         dMx1RokLIEeRxQFTf6Tg+eIfJE1oWEfB7gaL4ICQFWbvHSY4PTfV4+ylGrnEKLHcqg9J
         coMAHe/KUdIOEReYa94eRgstfQYTwR5+LIy0g+zZZDb4PwBKeZzCsSRd7MrS7bLbRg1a
         ZSnQ==
X-Gm-Message-State: APjAAAXq1S6beFYLv4EmpuqV/Fl5Q69Xm/KppwOtE3JtEN9pIEBlnR0A
        RW6mJqLUuhCTXilTm4Pyovhvdnkjx0w=
X-Google-Smtp-Source: APXvYqxMQ1UGvtFitbDTDR6997k5N6LsUuDIOsK70kSj8SXCDf3KkR4msyhfE4d3lSZZ3YLqSHwIrg==
X-Received: by 2002:a67:cd8e:: with SMTP id r14mr9786088vsl.28.1558025891784;
        Thu, 16 May 2019 09:58:11 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 69sm6498003uas.0.2019.05.16.09.58.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:58:10 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id d128so2759260vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:58:10 -0700 (PDT)
X-Received: by 2002:a67:b348:: with SMTP id b8mr16923750vsm.144.1558025889986;
 Thu, 16 May 2019 09:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190516162942.154823-1-mka@chromium.org> <20190516162942.154823-2-mka@chromium.org>
In-Reply-To: <20190516162942.154823-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 May 2019 09:57:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vqpiq4=pt=KnCW7Zpj9QF0v4STHu5s05PZ9G5AyHbX0w@mail.gmail.com>
Message-ID: <CAD=FV=Vqpiq4=pt=KnCW7Zpj9QF0v4STHu5s05PZ9G5AyHbX0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: rockchip: raise GPU trip point
 temperatures for veyron
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

> The values match thorse used by the downstream Chrome OS 3.14
> kernel, the 'official' kernel for veyron devices. Keep the critical
> trip point for speedy at 90=C2=B0C as in the downstream configuration.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - also raise temperature of critical trip point
> - add entries at position in alphabetical order
> - added entry to keep critical trip point for speedy at 90=C2=B0C
> - updated commit message
> ---
>  arch/arm/boot/dts/rk3288-veyron-speedy.dts | 4 ++++
>  arch/arm/boot/dts/rk3288-veyron.dtsi       | 8 ++++++++
>  2 files changed, 12 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
