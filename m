Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5AF2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSrUM1vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbfHVPQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:16:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33525 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732532AbfHVPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:16:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id z17so5958407ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3kdfojoMQKGGntVDybNUbhbyEDv93C/OVGCWtcup6Y=;
        b=zSrUM1vwk/fDaOxllfze3Yd4Et2Atsr5U1tZ4yfsyUJJ6ny8Hm8TCDx4xJGblzxD03
         +RcaDlbV93M01sZgOdLdXVWj9V5ERQz5gdb2mU1DvCQwhqs/VqoKCjXbee4baKafi/UV
         t3cv0FBPYYNVPtgT4TnICq2am/G7v94mr/Enc2K2hIZo2PAQ2yoamtqrBsevDM56Jmrg
         1PCYxt9W/ajf+8VP/V2pIrmpOwQk/l+txLGx9O/QXKYiF6fDXkHU3E2DKkf9BYFdq/sV
         UPWkopB4R7f486KjnxcZ5mYfPUO8Ug7Uk/+5EIycG5wtoGTL32txWvewVXviVvb2jV6Q
         Ea9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3kdfojoMQKGGntVDybNUbhbyEDv93C/OVGCWtcup6Y=;
        b=gPa1izt5cESFw/tcc/8CtmlSDjyCZoal0qW/ihwKer4PyZk3qCZArKLdgY+er+eQy/
         oS7/2p94xIRDl6W2PKJH7mnOYqJ2kPVxTn2iaFLc8nHfshUAI7d1pm9gHwJHbT6AtOMk
         Uk9YHtz/dlAxup/rf/KZZl4YuQwW4Ep5E3SX1wfYeK3ycWJSpWvUw3VtCRBPOw8pGyUF
         yYNTWUIIF4TZeGiNw4TlXW/CATefXzhPG4M3DkiI8XFe3IvKJnQRbcUOVtYyl7fDwhVA
         EPUgxs3BOO7zTzz0ISmuwFOGb4Yy2TVktRLrivtfB3YN7mpWJQDELnV5QmMJIh+iVWFu
         GnLA==
X-Gm-Message-State: APjAAAUnka79IGS/DIGWKM0Kjsu6E7bwNwOe4R/0YipVYLr7mxFA5Wx4
        d+mV+c76oB3v1QMfQgAct2nzlugA/rJXVk2A6P+niw==
X-Google-Smtp-Source: APXvYqw4HrCBoq6lNeKflWZiBRnD04sAimjwJfjhUqtyNwENAWSNoa1DE2K7OwX498fj6Zs3ggfDHjyxQoOAY28ENNE=
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr22639554lja.180.1566487009806;
 Thu, 22 Aug 2019 08:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190822110720.118828-1-stephan@gerhold.net> <20190822110720.118828-2-stephan@gerhold.net>
In-Reply-To: <20190822110720.118828-2-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Aug 2019 17:16:38 +0200
Message-ID: <CACRpkdY49Yz-39gz2V8BwZBJmKQHd975+_Pi5oTrZTRwc+ngQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: ux500: Remove ab8500_ldo_usb regulator from
 device tree
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 1:08 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Support for the USB regulator of AB8500 was removed in
> commit 41a06aa738ad ("regulator: ab8500: Remove USB regulator").
> However, the configuration was never removed from the device tree.
>
> It does no longer have any effect, remove it from the device tree.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Patch applied to the Ux500 tree!

Thanks!
Linus Walleij
