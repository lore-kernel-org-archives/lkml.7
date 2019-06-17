Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A734C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B00208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcuH+7Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfFQQEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:04:55 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:37295 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:04:55 -0400
Received: by mail-vs1-f42.google.com with SMTP id v6so6467041vsq.4;
        Mon, 17 Jun 2019 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnnc1YqqDFPd8WzGDfGgqKol4mW6SfIm1hkAQXkloAQ=;
        b=FcuH+7EurKK2QioEYceTZLdpXz6DMaf+I3nLQhr1rnEhvteqQRCEdYh9VookY4398q
         Q5V4dmEg2BL6OgSV1CbZqhFz5NoPB0YmWjp015Yy4iDWwOrZjJ7UFXqHkK4h7XKAOaHv
         TwGSuEruYPrkT6i4edpcLtmPbgFzxPXSo/OsV5olbaxn6TFZOgMsKA0axRi3ip0pNJsW
         iJmRApuDDjW2Uuo73o9qc6Fg3OQ4qbIsYz92XcxxJ2PheSoKi8/t4kJ6g0ukJPhRz85s
         5M7sKwU2IjER2XwDCQF2X4nFFGx916qmgqqAwVnLIMwAm7Zk+WYB//sshYpWNY5duKyn
         iD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnnc1YqqDFPd8WzGDfGgqKol4mW6SfIm1hkAQXkloAQ=;
        b=SSAQA7YUOXLyJ5+tnC1QBTy2x5kvfs1qsF/xbKOfLK/PLxnWcLwK+dVhylodzZ2334
         JfpRi09LFKPRQYm8xNELm8HPnqzlUmjl8fTMo9ILfJSi1sx+EYyXggPJa8jMeprSQqpF
         vr++h7es95eEyp5PMecEIIyYpGFvKHV/w7jOLVkaDlod904hEknN1gAp3DEt7t1gzx+Z
         Q6HrzrEBIPUOyQHNAiopmKGGGV638IaEh76G1PlJkjjj/pTqxqkIYYFqHkBJX021fE+L
         wEIPRTog0mj29qKggQwmLbgNNBqH1viEhipB2Cavx2Dtts57iODAiiXWsoFn4au8EmKb
         z74w==
X-Gm-Message-State: APjAAAUYU2iqrEANIlHy1sX/DigM7FFjyfbFcK31Jen0DuT8+zjYzedE
        DqfhzQISrWojAo2hQE58fqtgEeAgfo0dkTDyMH8=
X-Google-Smtp-Source: APXvYqxauZ6Wqdr1a6x/fpJLFsVERHU34VPVNMXn1iKL+e4p9OfXuz7VWrsJtK4Kn2WxOdyeEuBc+E97plQbyrlmZx0=
X-Received: by 2002:a67:e3da:: with SMTP id k26mr20351031vsm.131.1560787493667;
 Mon, 17 Jun 2019 09:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190617153025.12120-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190617153025.12120-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 17 Jun 2019 13:05:03 -0300
Message-ID: <CAOMZO5CALFFcUQ7mY6L7DqB+iuJHzk_WKhZ1=BePjHqpT6pOYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: Add ZII support for ZII i.MX7 RMU2 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 12:30 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> Add support for ZII's i.MX7 based Remote Modem Unit 2 (RMU2) board.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
