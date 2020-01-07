Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A58C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A676207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnJZFP7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgAGKZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:25:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34504 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgAGKZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:25:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so49338572ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izkQdpFTUaZ8mivzHGq4ICUrxmuFazGHcwlx1NAdeSc=;
        b=qnJZFP7xmmTFBd6vI+/32Kl5V8BNirWnSab5gFzZceh0IoY+v2Gns93cnzy4CPzYWg
         doaAdXZ1LTsoTH4XmVA0+6hZJPu4DiGtCoR5/oR+SxfT8Qwi6AthJEEfWDvI2xj17OAr
         oVluVMO1xHctozp33EYg1FTeYjsobbPMuLZlDKOHmjVxycPvRiT+/9NkCstUg0k59Ixg
         u6K8QWf4S6s1VdN7Ns3a3xt/HPVv0f95sKkZTk91U8+4UX7dVVB28FyIvzD3xrrn24Tv
         PfiMS5lmbQ03otYuDdM4yS7Rw37XtrfsHgynTQxS3zpLEtSbe79k+FX/FBa1K7SRI8sN
         JhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izkQdpFTUaZ8mivzHGq4ICUrxmuFazGHcwlx1NAdeSc=;
        b=CgBANBPxZ/XPhEipn+4y2e0z6bi00ur2VBLNGkKVSJLAEDZ7n07KeXd6Q3NdJS3fsX
         QU3WsX1cUK6q3/1tvgNqvAt3IPikco1aedrKbl270ohnKih2Vq5GpVjJWKxX2URz7Hkc
         W7TWEtg1qcwQNFHl2JtVn2vxEpWkQVd2hvwouINWGxGLPsKSyQjmizkoqLaqbcPTyecn
         s+QCqAqWy0DNE7ViHBfO8nqON1WZN/owR8zc4/b9UuNwx55DwTCmwieZH0Z8pa0juksN
         y9XW61XkrxpHD/IY69OKQuIXzVZYM8MqF3PaatRyZwSi+CLxth5RFGn1VtSk1dkMUIdW
         4Pcw==
X-Gm-Message-State: APjAAAXTaQh4Dq3aCvYaphtweozLF333EPXmzMUY9FZJA0Y5yP9tYY+7
        S2wsC+s3jmhWWSEGU3+gukQz0s7juva/Jz2jwiNdag==
X-Google-Smtp-Source: APXvYqxf447vgBZ6Ekf31Ne3QDBNnbDxra2GBTMOfyXxg/zNohD7uD4phbH7VRO5zCLqP2dAWg+gaYiElNCf9+fF5OI=
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr25923166ljm.251.1578392723253;
 Tue, 07 Jan 2020 02:25:23 -0800 (PST)
MIME-Version: 1.0
References: <1577362338-28744-1-git-send-email-srinivas.neeli@xilinx.com> <1577362338-28744-2-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1577362338-28744-2-git-send-email-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:25:12 +0100
Message-ID: <CACRpkdYTz7hFiU-JfopNBVzfpaYBj86DF1w0=6egdBY2fY8Mzg@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: zynq: Fix for bug in zynq_gpio_restore_context API
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 1:12 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:

> From: Swapna Manupati <swapna.manupati@xilinx.com>
>
> This patch writes the inverse value of Interrupt Mask Status
> register into the Interrupt Enable register in
> zynq_gpio_restore_context API to fix the bug.
>
> Fixes: e11de4de28c0 ("gpio: zynq: Add support for suspend resume")
> Signed-off-by: Swapna Manupati <swapna.manupati@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>

Patch applied for fixes.

Yours,
Linus Walleij
