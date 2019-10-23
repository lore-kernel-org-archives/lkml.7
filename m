Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ABDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FDA207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU8fr+TL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbfJWDEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 23:04:20 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45736 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfJWDEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:04:20 -0400
Received: by mail-wr1-f41.google.com with SMTP id q13so15262522wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q4CfRog0MybHpd33xvvsOmzsmJVfK1f+7lcEQ24uzZ8=;
        b=WU8fr+TLm9yuHpH6N+gV6LAmDgoqbijos72FRqSzaClY71OoLb3pPqj6memgmLOJSb
         QJZZryC5qs+4BDAcOHTWhSn9Z+k/kb4lXRCvnq4DnJcsj5OCteYlkJHXWZ+y4yvIp/Rb
         SgpeqIgadcLRwXg/QQteIJOpD6KztWM3NXpSHVrMVXnVnsNBH/wA0U5jVv4Fr8Ix3WWq
         EPVl4v85vofgFKUqYWopCHrbJET8Qs14dSD20CjRp0z7jcrpkXntFox+v90toZJLPOTX
         ldaGpf6N5+DWQUKWA5edRRPVTVl1wQeVJds63Ur+ZGgXHvugye7V/jl46nRc1i+IUaJ6
         yunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q4CfRog0MybHpd33xvvsOmzsmJVfK1f+7lcEQ24uzZ8=;
        b=rmA7mfbTzN3BIBGBQOHq3dSUBxYKf9quwxEu3G43gb7OXesCdBYehJ39T3vZy4sQHg
         uuhqc7V7OOfAiALJiix50gXbvV2IC4hxtwGY5Qu0xg9tVKoDDoSBj+QaYJsZEAgejY4p
         sV1P3hFmkRKzX6MfI+XKRaZFJlOzPtARM3oFBQfW6pgfkrCO7dKVOh0Ud6ndoNr26WO3
         BoZPBIt+Tgx29G+JcbMJs2SqC2SBQbnD6/R5nMdOjsjSBfwcp7VUi2XvM5Xv9WtgyKCf
         jP6x/1DuJZIEiLo44yAtKBiMZvb9aqyPhRTcjvY7sZg9HZhrw6R9DdNpJ9x8O5q8RsYZ
         PANA==
X-Gm-Message-State: APjAAAXvwjXlwBNJ1SzsQDzAVZT0ja+/wX//KOvYH4EZGPpIDY8pHmHw
        N4AUXbwmbQhXSjQDXNAm4ZSHtA0VZIUhj/iu59zZSDsd
X-Google-Smtp-Source: APXvYqztAvjAtqydQh3qVE5+OdKOpukVweHLvEfzrx6Z0C3R+qE8o2TVdrePm6jp42LqGgjHfbaOPHO8gcAgHlFfS1A=
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr6345858wrw.206.1571799858345;
 Tue, 22 Oct 2019 20:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <24b5f681-df58-7663-af7c-9fa9b9158be9@linux.ee> <61646cbe-c4a9-cef1-d586-f3ac794b998a@daenzer.net>
In-Reply-To: <61646cbe-c4a9-cef1-d586-f3ac794b998a@daenzer.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Oct 2019 23:04:06 -0400
Message-ID: <CADnq5_OEP8Rwcjok8LbedZ00B=3voEu97ngeOMiGLde=ZjXrHg@mail.gmail.com>
Subject: Re: radeon Disabling GPU acceleration (WB disabled?)
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Meelis Roos <mroos@linux.ee>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:09 PM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
>
> On 2019-10-20 11:21 p.m., Meelis Roos wrote:
> > I tried 5.2, 5.3 and 5.4-rc4 on my old Fujitsu RX220 with integrated
> > Radeon RV100. Dmesg tells that GPU acceleration is disabled. I do not
> > know if it has been enabled in the past - no old kernels handy at the
> > moment.
> >
> > From dmesg it looks like something with MTRR maybe: WB disabled.
>
> That's harmless.
>
>
> > [    8.535975] [drm] Driver supports precise vblank timestamp query.
> > [    8.535981] radeon 0000:00:05.0: Disabling GPU acceleration
>
> This looks like drm_irq_install returns an error in radeon_irq_kms_init.
>

Check to see that the sbios assigns an irq to the device.  There may
be an option in the sbios configuration settings.  IIRC, some old
platforms didn't always assign interrupts to vga devices.

Alex
