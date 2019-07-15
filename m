Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D959C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BAE2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qenKTZRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfGOKBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:01:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37836 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfGOKBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:01:47 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so33111724iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r72g4AHaLYsLu+ECpLbOshR1f0RyFtH3KsKDeo19VX4=;
        b=qenKTZRrwpA3m+Rvbzx7aJwKJ3c6QULx3EbIlYCuUP6y9OJLFfkELnN0GQ/XE2odVL
         yIB1XSFQnovfhkxpEqaRycjKX3caAYS2FtuVD0eC3YW+pBSrpR/vg8NFSVCrob/4sDGj
         LPWYOFOa7kC0B21jLpmaGjoKHqFxCK/v2wJUrYC1pqHugJSepfhUAcl//vuILlwm5QPs
         nSJSnlUEJq1TIeDGRQf9NTu9jzN2mWakvrHwjiZEIUN6bKkJX71XJKOgOG9neBPMM0MR
         14W9NSRp6O54zRfMj+LUNzA9jNTKwD4Uh4bEP0ZUzkFyhvTDcW4gooJN0X5JFPvNt5Ht
         PNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r72g4AHaLYsLu+ECpLbOshR1f0RyFtH3KsKDeo19VX4=;
        b=FNJtM0u2NaFx1E8SExst1jsTjrQTv9rQoElDYQ4wCXgpobNuaTUzaYERpXStoEDVo9
         iIjdJpn/FGaNGGPAAmHxxOihXsLvmcbQ/8SpLvLe8OOSffXvbSrjVSuTdPGii0HPwq4S
         h7ZPNGhu8rk0TwmYMaVmYc2SoNNMLjQvz/o1nQ8AwT+tpdZuMdgzP91vqTDfCX9SjHBX
         iyiKnq+7yt4W7rpWi4A8HYmxGHWxniI+DLyLGeAYpgDZe7tnDpEeGwhHIP8nc6uCh8SJ
         davK5T6+mKzo1ASNyIfYg718fXbDSvSxa6IGhH9LOvSMqKvSen+R2PAxCRKseqcUTVZo
         HDGQ==
X-Gm-Message-State: APjAAAUORad3vh6epZqok9Zi1911L4qpekO0BbhsefdkOhbiSTIymD/R
        HdUFoHqh2dPk4tudJ5yAHwOHFsBr4z1cry5msg==
X-Google-Smtp-Source: APXvYqxSCDk+fzKKVONVjrymqYcqpaN4MvCEPmUU7sSzkNI6vIArrmTZCtALv27QP/IiPqc7dmvqWYaI0ShuCCiXrKw=
X-Received: by 2002:a5d:9f07:: with SMTP id q7mr22524327iot.21.1563184907080;
 Mon, 15 Jul 2019 03:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562734889.git.joe@perches.com> <d6a9d49c9837d38816b71d783f5aed7235e8ca94.1562734889.git.joe@perches.com>
In-Reply-To: <d6a9d49c9837d38816b71d783f5aed7235e8ca94.1562734889.git.joe@perches.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 15 Jul 2019 13:00:59 +0300
Message-ID: <CAKKbWA4caPMN=h_6bxQ-s9ga+snwsBsMsT05t4vyHWYpLnSH8w@mail.gmail.com>
Subject: Re: [PATCH 02/12] clocksource/drivers/npcm: Fix misuse of GENMASK macro
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I noticed that this is totaly wrong, so I will fix here.
If you wan I will put a separate patch.

On Wed, Jul 10, 2019 at 8:04 AM Joe Perches <joe@perches.com> wrote:
>
> Arguments are supposed to be ordered high then low.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/clocksource/timer-npcm7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
> index 7a9bb5532d99..8a30da7f083b 100644
> --- a/drivers/clocksource/timer-npcm7xx.c
> +++ b/drivers/clocksource/timer-npcm7xx.c
> @@ -32,7 +32,7 @@
>  #define NPCM7XX_Tx_INTEN               BIT(29)
>  #define NPCM7XX_Tx_COUNTEN             BIT(30)
>  #define NPCM7XX_Tx_ONESHOT             0x0
> -#define NPCM7XX_Tx_OPER                        GENMASK(3, 27)
> +#define NPCM7XX_Tx_OPER                        GENMASK(27, 3)

It should be:
+#define NPCM7XX_Tx_OPER                        GENMASK(28, 27)
but I need to do another change.

>  #define NPCM7XX_Tx_MIN_PRESCALE                0x1
>  #define NPCM7XX_Tx_TDR_MASK_BITS       24
>  #define NPCM7XX_Tx_MAX_CNT             0xFFFFFF
> --
> 2.15.0
>


-- 
Regards,
Avi
