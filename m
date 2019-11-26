Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9511AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660E820727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JNVoCwtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKZWmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:42:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39173 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKZWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:42:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id d124so2538255qke.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3HO6SXo/+LFIGX6UpuuHJPqUR81U5M7JzQUmD7d8F4=;
        b=JNVoCwtUcDqcAeJqQG0H4ONEwOBEfkGfYitKpXdn/mUnfBBRk379qcJGQc3WqoMCid
         mm3lwV8Kv0LCsvmwBNl06bXrsZkWMJlTQyV3eYJiPGGvu+f4yb0q1MjsqX4Llxq/xI85
         0Z+imuBHfhFL0ScLxaor4erbJbIQHO0Vr7QGHO2dYpvDQqGTjJWsN7EVBBJTby42RpXj
         WIt3gRzAJ3B8smrw4M4krpFXD3ARC3mk6ODvCBeCGT1yukOSTC3COI58rAnu0SXVCeIY
         6vokY7ppCr4xCWnnMStvZAkAIzsWg3CIce80LROaaScdLzJTS4ouWO+asL3habZg813m
         w/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3HO6SXo/+LFIGX6UpuuHJPqUR81U5M7JzQUmD7d8F4=;
        b=M5kzzQvfrGRLG2IpcU+Vjzj22YFc/VLAzGa57N+ZnBUYvubYtiuN96hAoEWXqs2Fa0
         IX6OJoxDXs7+mywmW/lE/IY9S/34VXx52Fid3VCVtzUwXLzRZoij5dbbwkZBO2gCPejU
         ONxJgyL7+8bSsnbP9pksebgcupOxkDN+f6T395CNTDUnfn8N7n6N6KzLJPT6F2T25DqR
         CuRpLC/1FHOUZM5qQQrYDAYvb8ZLeAd6UcGGTs7CCWSPP7OPAjv+Q7DT2CBhC1yTrmeO
         fO1FGzkqrwVKxOcTJxnOzAwJ8Wz0hItypi3RS7m/RLWEqMf97MFCvFEK3gIKjGNHrzd7
         MIJw==
X-Gm-Message-State: APjAAAXh9Ey457LK7v+7/3NwG1bdsRBAgHTm1dwH7XSlav/beM8py+JO
        tEtcsQIEXZi8EAiGSzLuRBy57IT8728DMqHr5FdfoA==
X-Google-Smtp-Source: APXvYqwmsBlCX7bYkD89da0RhDH7R/RYRo4OjW7ZOSqhB36GDbrQNMb4zazoXQo0f63bed/21NgM/RdqARvl2K3fxJ8=
X-Received: by 2002:ae9:e201:: with SMTP id c1mr954023qkc.416.1574808131615;
 Tue, 26 Nov 2019 14:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com> <CAJwJo6bu0Hkmneg=DuwN=v_G4pkm1JQnUWKEVcudJD5L0pjLiw@mail.gmail.com>
In-Reply-To: <CAJwJo6bu0Hkmneg=DuwN=v_G4pkm1JQnUWKEVcudJD5L0pjLiw@mail.gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Tue, 26 Nov 2019 14:42:00 -0800
Message-ID: <CA+HUmGhOEPNcUGn1-yc6Zo41wYSCO+Ch4qh6N2TDbFEfRmNvEQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: only free map once in osl.c
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 2:58 PM Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> On Wed, 20 Nov 2019 at 05:50, Francesco Ruggeri <fruggeri@arista.com> wrote:
> >
> > acpi_os_map_cleanup checks map->refcount outside of acpi_ioremap_lock
> > before freeing the map. This creates a race condition the can result
> > in the map being freed more than once.
> > A panic can be caused by running
> >
> > for ((i=0; i<10; i++))
> > do
> >         for ((j=0; j<100000; j++))
> >         do
> >                 cat /sys/firmware/acpi/tables/data/BERT >/dev/null
> >         done &
> > done
> >
> > This patch makes sure that only the process that drops the reference
> > to 0 does the freeing.
> >
> > Fixes: b7c1fadd6c2e ("ACPI: Do not use krefs under a mutex in osl.c")
> > Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
>
> Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Thanks,
>              Dmitry

Any more comments on this?
Can this be applied or is more work needed?

Thanks,
Francesco Ruggeri
