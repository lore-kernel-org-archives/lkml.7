Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A300C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C7A218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vgO9/x05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfCPWJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:09:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38852 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCPWJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:09:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id e80so6292238ote.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o528ymosn+dxRi3OgITbR69+jmWqSJKfAI21OdIVJnc=;
        b=vgO9/x05lFRtnPHRyy2BZdw3GS3NxUCQbEwaiUrytHncfrVc8epJnPIGigvt1Exlze
         axGuALHYzcJOVy4pSAHxmNHjVqrb9QL7nGZP6MOBQIvoE4Zi4xeusv3kU+3shU404ohe
         CWGlIIRJVxGAT+39o99EAc59Vjd+bsRIwpjPjND6+KMXktjJvqSOUVye2wo/lSgdxFJC
         cjiRBxcAjezRAu5SuUQ/i3E0hWs3837EUVif32JRcqBayFZG0SdLYDQQlDV+6fvLrHF4
         rlEPypyzez3oxzPwYzITihAQwaqn7jb4pL4N+se4JMmUuKdQP1PjeD6qie1/89/KEINU
         ch7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o528ymosn+dxRi3OgITbR69+jmWqSJKfAI21OdIVJnc=;
        b=p/+Guyc54jnW0L1uPfZ0Z3zo74q0gmbFXIPxtgSrClZrO/yeUYMMx0MiMRJeC4r+ml
         KkvSyZ29/XFKMgRFjZOB3l7mSbtSxYmDxTF/M3V5B8DUgIfJFCwfYo+mdr2dnbzjmrMA
         NJXQNhbRwgLHbXpaS01z5p3b81H5PEb0t0w5u3sY2YR/eicfyabi/gwHPh9UxN891EiV
         dVCZz5741rfrRZNVrEGM0sthkHptISmk/pVeUl7zVA/alu2CybEdHKph5zWPpHYUaeiA
         lF9+mD3BSFz854M8nE7K/jtoW6Js3sQUhftJfT0Dkz5ozF18h1vqpKylZWp1llEbqjVV
         nbOw==
X-Gm-Message-State: APjAAAXJ/FcAc8zQma0yBYXKTPs86cktYqrEKvsyPZxjgRzxqlqZOAi3
        ee/g66sxfk+tdFExnD+qRwNeN5728KApmQs03QWokkJG
X-Google-Smtp-Source: APXvYqwDbX5sYzypTMpAr4TZJ/pQpHChrM/OyDQGrO1BvCX/JH/ZqEou70Ws8PrexNCKPegl91cgqJDZLpEmJmVWS2Y=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr6455841oth.308.1552774156883;
 Sat, 16 Mar 2019 15:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190307151342.7381-1-narmstrong@baylibre.com>
 <20190307151342.7381-6-narmstrong@baylibre.com> <CAFBinCBt290Qabw98SpiON3xG0ihMEDNzwDDTrBo6QYbA5QjMQ@mail.gmail.com>
 <5C8D08DE.7070203@baylibre.com>
In-Reply-To: <5C8D08DE.7070203@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Mar 2019 23:09:06 +0100
Message-ID: <CAFBinCAZt75BxJD6P=HRF4tqvJd_QmrpqKQu_GbKzv6cLhnLew@mail.gmail.com>
Subject: Re: [PATCH 5/9] arm64: dts: meson: g12a: add reset controller
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Sat, Mar 16, 2019 at 3:32 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> > Do you have any hint how to verify the CBUS offset (0x1004) of the
> > reset controller?
>
> You can find base the address found in the G12A DT for the usb2 phy :
> https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/arch/arm64/boot/dts/amlogic/mesong12a.dtsi#L379
perfect, thank you!

feel free to add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin
