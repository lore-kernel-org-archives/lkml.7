Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF89C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC93820700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy7P4AjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDEMu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:50:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35349 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfDEMu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:50:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id u21so4340982lfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q30enJ9r4hJQLvpL7crdhRUM7DMqIQDzCsUD5EV14XU=;
        b=gy7P4AjAAE3Uj6i5QXZhwe9nTdcgY9sJM0lYXLBNy1wIlBZ36wyPv7qhToVSV7lOMi
         DDqbSPQ7zIN3amcvztHnB4NALPmyip8WE1RauhnWhmHZyJIXm0HAgN5n9AGvLmGAVAaL
         tmdp3iWbWMNiR1VmJHQdOiI8n6pxCDYFiEMrSykbLDxqpDKvqVu2rB42r4TJd5tsCOri
         cv2WWVGfiyjbrRcXYF0euO41YTnG4Gvl4xhsxMw2KC107ocmJiKVbDEWxLGHUHkgRCmW
         Wt6RtmrkrlkOxjMKNW90v7JfrRWQS0wRbX7NSeYa17tp7oCVUEi+ieqDDzIPV4+6m4WJ
         JiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q30enJ9r4hJQLvpL7crdhRUM7DMqIQDzCsUD5EV14XU=;
        b=moyrkT0epckDaoxqozlPLlt9RX+xPpwikntiDL3JErQkNlvYQ54QoBQZo7svgeqH+r
         BuJqYRZyhG2IYEBuLBwQG0R3m/2hcfN0ycGo7ar6PqSqVum7rSppm69F5x5EF/XQ/ecL
         KRuN4oP434i4oU+sJRaQSkIrQXRZ6MIFgSu2WpRNYC1DDQuUFiBTtVyB9AVMlPcDx8c0
         9eT+Z/Rv9tIpTMt6s4gcDPuJnDU+GAnyEz0IZOozWtCJ8Hdc/kulTi/K3+zYs8OoA92z
         H3Y4LDotO8a7jpCr17HGSgRw8e34z2gnd8qJbv/aJ84sqhNwRjAgiH9Xo0Etk/KFUoVf
         rvuA==
X-Gm-Message-State: APjAAAWPG+gIeFUk9IXC8bu98sfRmYdOjfEdWshNk2w+dXuJuJlO2d8q
        2nchv4FO/mWhNFIM3o0L5tNnEmlsHDylXaKVbKs=
X-Google-Smtp-Source: APXvYqzHXbc6MbD809ZAR4zrh5oBvA+uQDxbdiZIi2xUV+hpgfO8tb9Y848HNjRqC4FQ/NrqugJrhFLVCEaHcEPznTg=
X-Received: by 2002:a19:c51a:: with SMTP id w26mr6497268lfe.59.1554468625958;
 Fri, 05 Apr 2019 05:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
 <20190405115010.28838-3-andradanciu1997@gmail.com> <8e16e9f5-2c0f-a1e6-df0d-67b982db294a@codeaurora.org>
In-Reply-To: <8e16e9f5-2c0f-a1e6-df0d-67b982db294a@codeaurora.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Apr 2019 09:50:17 -0300
Message-ID: <CAOMZO5CZtJq65iUDN2Ao9zt=0_L0iXy-5eRCrHAzQb+3s5rxBA@mail.gmail.com>
Subject: Re: [PATCH 02/20] ASoC: efika-audio-fabric.c: Switch to SPDX identifier
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Andra Danciu <andradanciu1997@gmail.com>, timur@kernel.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 9:47 AM Mukesh Ojha <mojha@codeaurora.org> wrote:

> Don't change entire thing with //. only above line with the license is
> enough.
>
> Please apply this rule every patch of yours.

Not really. This is the style preferred in this subsystem.
