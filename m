Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F192CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1A820863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vkv0JYag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfEVSOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:14:00 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41398 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfEVSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:13:59 -0400
Received: by mail-ua1-f66.google.com with SMTP id l14so1212002uah.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=als0AafCzNcwDpUysRFXNRE8h4TvypenDMJfaAg3x3M=;
        b=Vkv0JYag5RXjIyQv9tMB50n4hClGqOqpOhB2GGfs8w4zpDNVkiYMS8ZJDnx0wvP5XB
         F92PsIOC6CoRrTLnhridwl8W06XlPQzWSBucGXbUj0XK8y4FlsyM1ZIF6ySGv9hgOIJN
         N3J3A51yuRx/HD8R01BubkDaT1q5W+xw/9QRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=als0AafCzNcwDpUysRFXNRE8h4TvypenDMJfaAg3x3M=;
        b=MKIVqoDCe59Aq1uoccuKkIQzVbkxfYqn4lWtenkUWoZhkmwEHKaBY/lAO1z5rUP3Lr
         IgKnaRPDrVznDmMVZTI4G3/0J3cdrPJXkwP+MrGxGHEbzXqfzCwRpxDJW7Z/gZUhRhxV
         U316o7sWCOLkvJFw0TQPeAMzUsKhIRMd5AbKBArXn2Sl+x3qpfQYoz9TrJod2laEZRjR
         eCXE+IrE7iVoD2YoRd2mXHiVNjA/r6RKUWmebIVEZCiCbIOoBb1DjDVQRPbVEuKXnkFI
         IYnAvgGdefPRE3M8trtUph+YeCiNxR1/8Ay4IrR5RLJ+9XlwEIM7EcLYtAjQm8bBWoYb
         teEA==
X-Gm-Message-State: APjAAAUu7bRZaKcR45rsigo8lx81TVwMXy+mi+oWYzCTUeTXHQyJXtWc
        ydj1I/y4+LM9EsgcumwerWu5HHQSR4A=
X-Google-Smtp-Source: APXvYqxbUvlI6lBseZyhZkRghApC9Txm4EsBKLkZGhNHCkafqiizfVhYbXfQFVMBTY4A0Otu3eJ72g==
X-Received: by 2002:ab0:24d:: with SMTP id 71mr46541260uas.31.1558548838167;
        Wed, 22 May 2019 11:13:58 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id o5sm7902262vki.37.2019.05.22.11.13.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:13:57 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id c24so1974600vsp.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:13:56 -0700 (PDT)
X-Received: by 2002:a67:ebd6:: with SMTP id y22mr28744866vso.87.1558548836544;
 Wed, 22 May 2019 11:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220051.54847-1-mka@chromium.org> <3108277.JP5bvJISVS@phil>
In-Reply-To: <3108277.JP5bvJISVS@phil>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 May 2019 11:13:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ww5pYOdknESUC4S06FvPzZ03Z-tW098r2N+9tbHNx7Vw@mail.gmail.com>
Message-ID: <CAD=FV=Ww5pYOdknESUC4S06FvPzZ03Z-tW098r2N+9tbHNx7Vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: disable GPU 500 MHz OPP for veyron
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 22, 2019 at 2:14 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Dienstag, 21. Mai 2019, 00:00:49 CEST schrieb Matthias Kaehlcke:
> > The NPLL is the only safe way to generate 500 MHz for the GPU. The
> > downstream Chrome OS 3.14 kernel ('official' kernel for veyron
> > devices) re-purposes NPLL to HDMI and hence disables the OPP for
> > the GPU (see https://crrev.com/c/1574579). Disable it here as well
> > to keep in sync and avoid problems in case someone decides to
> > re-purpose NPLL.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>
> I was actually expecting to just drop the 500MHz opp from all
> of rk3288 ;-) .
>
> To not have to respin, I just modified your patch accordingly,
> see [0] and please holler if you disagree :-D .

Seems fine to me, thanks!

-Doug
