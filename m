Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5FFC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D533208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tnz5OKHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfEMWsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:48:36 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37032 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEMWsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:48:35 -0400
Received: by mail-vs1-f68.google.com with SMTP id o5so2822720vsq.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZsjBt83vZW6+pdPdwVwbAfNO1Tv5TbEk4rycrbIYbM=;
        b=Tnz5OKHnLPR6l118hvL+HTgPPNlqas3wlnC3peejx+OqWX4dLD+cDrKseKtykoAH9e
         GLcRZfSqtv9xi3Ko60lAn/PLCJOfMAWSxymkyBglt2shWGuRu6sroABxXS9otN9gsBD4
         7yvl0lsv06bq8HtkrCD8e7D0l3meHeTy2Grn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZsjBt83vZW6+pdPdwVwbAfNO1Tv5TbEk4rycrbIYbM=;
        b=F2LNM3y2ghj7RVfPXejvXccp1ClzJKTAIlNyQ9OV45HOHvxsULVN6HfoXgCVv2kngK
         iDdoAOy2jDK0+orYzg8hLkoD1dmmQWhchskYejl8bv9vFz2qut+NF1sPz8evWq07BoS8
         GCa7QGmrKtu8zh4k+CC3L2oATzhxjdkEoWTfjqu7JRt7yI5LyBFl7Rn72b+ybBl5n5vM
         XezIT1kds0MfQFkzUBgI4t8RDJm0GjVpltKNwUAX3GcsGloq4+CNNmSNBBoAAc/5fiz+
         y4lV/5/hNosf5vxuazklwiEceNTMFy/KhAn9rZKUQgJ69mvCoxHO2Tnv/AbzqbrJE58A
         9jEg==
X-Gm-Message-State: APjAAAUukf/IW6f01spiMrT3tNyea21D/yCx/IqcOoT+rhv5QfGI0Rnf
        91i8O78PU217hLB5cMHFr6qB0UARUFA=
X-Google-Smtp-Source: APXvYqwA8+scIakcI0Lo9JoCApZn93cuasdUfgUxLm4GVsc8qrFw4G/oZtQ23isnM5MHtqudBq6I8g==
X-Received: by 2002:a67:f715:: with SMTP id m21mr4381157vso.219.1557787714756;
        Mon, 13 May 2019 15:48:34 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 143sm6208641vki.20.2019.05.13.15.48.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 15:48:34 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id e2so9083638vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:48:33 -0700 (PDT)
X-Received: by 2002:a67:b348:: with SMTP id b8mr7122321vsm.144.1557787713606;
 Mon, 13 May 2019 15:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190509184415.11592-1-robdclark@gmail.com> <20190509184415.11592-3-robdclark@gmail.com>
In-Reply-To: <20190509184415.11592-3-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 May 2019 15:48:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXW3aApS=c7baxhtfr1Nf-UnBN2s=rEBBkjj4=TCdT+g@mail.gmail.com>
Message-ID: <CAD=FV=WXW3aApS=c7baxhtfr1Nf-UnBN2s=rEBBkjj4=TCdT+g@mail.gmail.com>
Subject: Re: [RFC 2/3] arm64: dts: qcom: sdm845-cheza: Re-add reserved memory
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 9, 2019 at 11:44 AM Rob Clark <robdclark@gmail.com> wrote:

> From: Douglas Anderson <dianders@chromium.org>
>
> Let's fixup the reserved memory to re-add the things we deleted in
> ("CHROMIUM: arm64: dts: qcom: sdm845-cheza: Temporarily delete
> reserved-mem changes") in a way that plays nicely with the new
> upstream definitions.

The message above makes no sense since that commit you reference isn't
in upstream.

...but in any case, why not squash this in with the previous commit?


> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Remove Stephen's Reviewed-by.  In general reviews that happen in the
Chrome OS gerrit shouldn't be carried over when things are posted
upstream.


> +/* Increase the size from 2MB to 8MB */
> +&rmtfs_mem {
> +       reg = <0 0x88f00000 0 0x800000>;
> +};
> +
> +/ {
> +       reserved-memory {
> +               venus_mem: memory@96000000 {
> +                       reg = <0 0x96000000 0 0x500000>;
> +                       no-map;
> +               };
> +       };
> +};

nit: blank line?

-Doug
