Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F67C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB7620850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9/pFtSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDKUVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:21:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35823 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfDKUVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:21:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so3993983pfh.2;
        Thu, 11 Apr 2019 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xp9AgRoZndC7bkDV//vOOG9+Mf8ePglt50CAM+1RJMI=;
        b=W9/pFtSSQ6NWmfFVCpZVS5nKewRIFCLJ9VgQ7IZ/urSc8yRQqsfmU6ezvX8SS8hfY6
         Cj1trB06YklVEmLtdaCw5Mz1eWLAYp5tWB9vXmhZ45+oLn+E+MtIVW0ohQ9n28GKMjWF
         Q2/A1P0uRjbZkvlLxsYWXIY5DpIXKSi0A+IRrBACED5X3St0UnIBspxPX6bZlT1as1qj
         33tERJDrBEwIoIT2lWlarBqNEI/EebBUPE+bN+w/Yd5Pyy+KTqrzJMct8KdcVQJfcsxk
         t4OEyZpp5Ny1eqE1DhVbHg70j3KdaXfMTulUbwOatmADjpsiC5yOPCGBHCsbJQPGD/8U
         xiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xp9AgRoZndC7bkDV//vOOG9+Mf8ePglt50CAM+1RJMI=;
        b=hVwcYTjhq4jxcyI938si7yM2j71HIKQPoI3nSBhGlTE1U1+BShw+DpBiXg5V2Bif4Z
         NHpWbJQCw+mdlQSYi8sz3JbnUYiQ1kayDmpD4x1Ayvs3ivd1KrFujNM+9bOPkn7BouYe
         8s1fHXaSGtZ0d3fsSey3VVkklXHBhLXPvaDCeOBmro7x0DTRaowpoFqHTHd9ja8Bi6ku
         +M5BBdchF9HjBnb8rzaDrj30RcCzu3nxe0/sKNRgKFz0EXGUwsJH6yIT3Z199Znd1uyj
         xYGSjGUAfT2MaGUEToduxxIGIfrsfmpJyAJYBJqaEU3Zpw429RyL5EICHqQFTGKi96ol
         LlGw==
X-Gm-Message-State: APjAAAUqJ38GF9rx84xj2MeSQUvCCXyFdAHMAGkY26tE4Ggn61z034L9
        x/Hd4NzoEJUsmEkmOemsiCw=
X-Google-Smtp-Source: APXvYqy4LjSsy9ejijyKGtdcWG/rQY1lFzAVMVk1df/xdr5tnsQ2cfx2YR6A/D8qgX4oi0eesa3RFg==
X-Received: by 2002:a65:4802:: with SMTP id h2mr45613207pgs.98.1555014081510;
        Thu, 11 Apr 2019 13:21:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 19sm44641413pga.88.2019.04.11.13.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 13:21:20 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:21:18 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 4/4] ASoC: fsl_audmix: cache pdev->dev pointer
Message-ID: <20190411202117.GC13170@Asurada-Nvidia.nvidia.com>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
 <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:06:39AM +0000, Viorel Suman wrote:
> There should be no trouble to understand dev = pdev->dev.
> This can save some space to have more print info or save
> some wrapped lines.

Change looks fine. Ack.

> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>

I think usually Suggested-by comes above Signed-off-by.

This was originally in your change already, so you can replace:
-Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
-Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Just a chance for it to get resent without being a noise :)
