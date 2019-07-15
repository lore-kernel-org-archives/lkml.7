Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D3AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3E62067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeEF3bD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfGOTHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:07:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46090 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGOTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:07:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so17395210ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBAMan59214L8DDiod4rlTrGDDyfBwlvbOMs/TY66n8=;
        b=NeEF3bD8BG5kFPsjgZXesEI57E1k1h7thRsrKPDmO5vUF2zHfBOj8m9IxkMPW41qlQ
         TyxIRhFFLSuWXkK+Y7DC0w6o49Uu8/2FgJGUfi/NUatEGNUleg5H5aInWT5HYBL0vcpe
         nxtgQ7QjHSX8f5NIqvEZTkXqUTcQRk1I4M0JWNCKT4afaDPt9q0EY9RkdXPNsq03NvCO
         zUpCCDW0+I1ycwTakFW6s6UcyY8Y0x0QW+SjJpBezQza61lusL1MBKMw311mxLteMzEb
         kAseYX+0IAGJ4YNSy0mb2T5BdO69BHUemBNlpNG7bJoTjS9kO0+cnOjW1T48HVPWnPN9
         JF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBAMan59214L8DDiod4rlTrGDDyfBwlvbOMs/TY66n8=;
        b=EwtKKcc8o3mgY3xCHr9o0LPOUxxgYDkgS5mL7KQIZlcEznS3jtXb+m/GMzOu6a5/UR
         U0bs9zUMqHt50LCYK1HesLYbaKvskRtgFjJvjyp8yIMBP0oWCWtPFy1uux0gcMHmzLUA
         OZoNEzFpl/btDPz0qckr4D+WQZ5JOX2FISBzaDVcxVuDgFnAAi4/X3rSjTuqVbDf3GlO
         ZSL+EEmcktMhCM119f2u5siWL3XsPZhZl8EvFQguX7aCxfWKiArwRv0IIRml5+1JEJ87
         BCG+SUAv3rKslgG/W8VaZ3LqXZkPXK5mJp0Z7osH6qID6/f2EWvTlnFUlNtwlqHniHjv
         b9TQ==
X-Gm-Message-State: APjAAAX9esPQIcGzBpdCZD0/jKB1gWx2Ehv+0FkZnArV6PKutfy1RLGE
        IIHHPpL6PHfobR2f6z1I3H52Likv3OdGyZwWSQI=
X-Google-Smtp-Source: APXvYqy3CDW03EM/RCHOc9BjFKyYKM6GZ+jrLPwYgDUJzx1zvSJb3RVZkrMtFlqP1DkuIICN6aEXe5AGDr5sGUcY3xs=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr14182194lji.115.1563217622646;
 Mon, 15 Jul 2019 12:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 15 Jul 2019 16:06:57 -0300
Message-ID: <CAOMZO5B00XRb5GqtYhyg==sVek_uWhLRDQeSStN1AzfKRnV+Dw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] VAG power control improvement for sgtl5000 codec
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

Your series looks good, thanks.

I only have one suggestion.

On Fri, Jul 12, 2019 at 11:56 AM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
>
> VAG power control is improved to fit the manual [1]. This patchset fixes as
> minimum one bug: if customer muxes Headphone to Line-In right after boot,
> the VAG power remains off that leads to poor sound quality from line-in.
>
> I.e. after boot:
> - Connect sound source to Line-In jack;
> - Connect headphone to HP jack;
> - Run following commands:
> $ amixer set 'Headphone' 80%
> $ amixer set 'Headphone Mux' LINE_IN

Could you please make the bug fix patch to appear as the first one in
the series with a Fixes tag and Cc stable?

This way the bug fix can be applied to the linux stable tree.
