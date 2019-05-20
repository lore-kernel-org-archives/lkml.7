Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F0C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6642173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XldTkhej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfETX00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:26:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42383 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfETX0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:26:25 -0400
Received: by mail-vs1-f66.google.com with SMTP id z11so10003524vsq.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v15ImxXPR82zUC1L9RntmNVljNfZ+KHeuqCJcdfthSU=;
        b=XldTkhejOHyY3VTVRV+hQCD0Mji5ZKkA81D54mqtww+D8rxW79ml/7uspfRba3bqbT
         O+/vJy6pNTe+sH5I3xUvVEIqt8GLD7yg6qfiixUrO0gR+1BEv+40KGwQEAOi6aaqEp6k
         fxsJozVSlGGmyVy+f4DJYp0UhgWTsBh/IBwG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v15ImxXPR82zUC1L9RntmNVljNfZ+KHeuqCJcdfthSU=;
        b=rJDf5BKkuvNkfqK67x1EmOtl/CEREUYNwnoTNdtSAXiUlp8J65Plm42QaNIYKHiP8g
         SmKq8WMlBR9OZeQy7D7CZffWwR4Efwdq+8ioDQWx0eK79nBlK23kDdMcrQhxLTjDC128
         v4OFa9shaaKg6KEt81cNZ+1BG3wpt9N/XKR5xQlyixZyS1zpbE2CZ3ZsbagvVcb3LHMN
         UlgFktPVN+1cMyU6cKCzPyNuECiU26tVI5k7Rdw5cA6nzPgZDe1eMu5ceUJwZ2lRA2Gi
         toNY16lJM6CzJb8bIx+ePF+jaVvWcAShKQjcL06u742QY9eoizZZ6AVhYWG+4skxXBTH
         FEZA==
X-Gm-Message-State: APjAAAU6g/HxADDDjC+aivyEwURAIZzUK0XHxrqQBlIPIL4lQf7pROQL
        dJYTtxo5hflx4tUKIvEAbwNYd7qqV5Y=
X-Google-Smtp-Source: APXvYqwp4e5PBd+mQsWrRt4bENTZKDQZtRIr/qeBoXxdmBfDMzb2EX3JWNjv2OtkoCFZaPOmySdwzQ==
X-Received: by 2002:a67:f3c5:: with SMTP id j5mr24416480vsn.232.1558394784504;
        Mon, 20 May 2019 16:26:24 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id t189sm9267501vke.31.2019.05.20.16.26.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:26:24 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id p13so5929056uaa.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:26:23 -0700 (PDT)
X-Received: by 2002:ab0:4a97:: with SMTP id s23mr1167110uae.19.1558394783438;
 Mon, 20 May 2019 16:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220051.54847-1-mka@chromium.org> <20190520220051.54847-2-mka@chromium.org>
In-Reply-To: <20190520220051.54847-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 May 2019 16:26:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UfVwGbraO91Rq2vKA5-H1uZhMPeoE4h+qWH39f0DqnXA@mail.gmail.com>
Message-ID: <CAD=FV=UfVwGbraO91Rq2vKA5-H1uZhMPeoE4h+qWH39f0DqnXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: rockchip: Use the GPU to cool CPU
 thermal zone of veyron mickey
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

On Mon, May 20, 2019 at 3:01 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On rk3288 the CPU and GPU temperatures are correlated. Limit the GPU
> frequency on veyron mickey to 400 MHz for CPU temperatures >=3D 65=C2=B0C
> and to 300 MHz for CPU temperatures >=3D 85=C2=B0C.
>
> This matches the configuration of the downstream Chrome OS 3.14 kernel,
> the 'official' kernel for mickey.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - added 'cpu_warm_limit_gpu' to throttle GPU for T.cpu >=3D 65=C2=B0C
> - removed comment saying that GPU isn't throttled beyond 400 MHz
>   based on CPU temperature
> - updated commit message
>
> Note: this patch depends on "ARM: dts: rockchip: Add #cooling-cells
> entry for rk3288 GPU" (https://lore.kernel.org/patchwork/patch/1075005/)
> ---
>  arch/arm/boot/dts/rk3288-veyron-mickey.dts | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
