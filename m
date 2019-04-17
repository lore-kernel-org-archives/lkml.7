Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA097C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3F621773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tW+80htR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfDQOgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:36:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41214 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfDQOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:36:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id w30so27559616qta.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZ2Ly4RP/Dnf5F/ZG3aJK5z5nPfqb3L8ZTetUCkAOuM=;
        b=tW+80htR43jlq2mGkJBGHZOYcRhvYFqbp9/zcCZkvE4V21tPRaAvav7/gh2kdUJCN8
         gz34cy0kDrbsGNKpzndgU4CzrX5TWVQwgy2lKIVh76VaybEFrpni4t5o2TcM+vMhV7y6
         Uklh3bypP0gtJ3gAU2ypVFNm/4e0fY5X7Sv7HMHH4BItCh+7VeWuooIPYqPLi6xjQBKu
         PA0ncU30xH3JLdjVyI7+XGH4a3SZ1a5CeN62R3T5mfVNvAHw63J5YZRv5tMSd4Ly1YhI
         H2A0p2rWmdHB/iGUgdJbtdEgElD5P/M0SUYXBnFhyWQh0K5NBuJ5eOOkEP3ZArdv8Iap
         T7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZ2Ly4RP/Dnf5F/ZG3aJK5z5nPfqb3L8ZTetUCkAOuM=;
        b=Lo5SBzUr3AT9ne8j6dXKvymovxXR5FulZH9808gAuMI7S1mh3kvXdpn+x8fp8iy7vM
         9YhhH68jJa0L6n2MIm7/zhR+DorQp+PIHq52pWdppMDI5vm1dWS53KLg+fzVhquuuhTN
         k3kBSu/gWHyMK2M/3z3TZw0IynO7PzSMV17E3L6LkcA1cH7QMkKTgoT/hiSdiI7kw7b8
         O940qoZUgTShcm2/dVUF/+4WIeLE+X539XLbxyB9mboMne+EEg7G5wgeoprxF7CvKW8T
         VHekdRdnfY9tMdRy4/n2qclB7yz3JuUZst/oA1+2S3RNJQO6cFNOdykEhAQJN3Ihti7c
         cyHw==
X-Gm-Message-State: APjAAAVmWxt32Akz/I5YGzXqOVJn9fo/LJNzEOWy0KCUWUNpdcuLG4B9
        FvTe7Nr5M+sArVXsDDJyFFiQbUvXttGEh+FhPDLO/Q==
X-Google-Smtp-Source: APXvYqzJgYPo2BVx3Jwgau5Jm9ahbAhLpJYTEEi06dzWg2kwJ8VT+NMhrAqRqx8dfXPyDMts46sTX5Hr7S0oLkd273o=
X-Received: by 2002:ac8:2949:: with SMTP id z9mr75131010qtz.302.1555511810391;
 Wed, 17 Apr 2019 07:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190313211844.29416-1-ilina@codeaurora.org> <20190313211844.29416-4-ilina@codeaurora.org>
In-Reply-To: <20190313211844.29416-4-ilina@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 Apr 2019 16:36:36 +0200
Message-ID: <CACRpkdZW8OhqmNdeC8KmiAN6iTDAm7NUzGGmu5+-3utdT+dtCg@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] of/irq: document properties for wakeup interrupt parent
To:     Lina Iyer <ilina@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:19 PM Lina Iyer <ilina@codeaurora.org> wrote:

> +Mapping the interrupt specifiers in the device tree can be done using the
> +"irqdomain-map" property. The property contains interrupt specifier at the
> +current interrupt controller followed by the interrupt specifier at the mapped
> +interrupt controller.
> +
> +   irqdomain-map = <incoming-interrupt-specifier mapped-interrupt-specifier>
> +
> +The optional properties "irqdomain-map-mask" and "irqdomain-map-pass-thru" may
> +be provided to help interpret the valid bits of the incoming and mapped
> +interrupt specifiers respectively.
> +
> +   Example:
> +       irqdomain-map = <22 0 &intc 36 0>, <24 0 &intc 37 0>;
> +       irqdomain-map-mask = <0xff 0>;
> +       irqdomain-map-pass-thru = <0 0xff>;

This is looking a bit familiar to the existing interrupt-map that is
used for PCI interrupts and Swizzling back to a set of PCI
host interrupts.

I tried to document interrupt-map here:
https://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping

interrupt-map is a bit convoluted, so I don't know if it would be subject
to reuse for this. I suspect that interrupt-map, despite the name,
is for PCI only.

Yours,
Linus Walleij
