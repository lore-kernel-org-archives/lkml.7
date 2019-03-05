Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B422082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0gY5ORx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfCEMBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:01:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43067 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:01:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id z20so7348896ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 04:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JN98kmc0I9yRl2q4/t1ISwSXXdDiIz5j0cHyQncYtoQ=;
        b=f0gY5ORxB8MQ26ZD++uvy8CFZ0aoHrC+DL0Vn+P3aWVsFTseoejVldrkw+Eq26qaAR
         VVQNbt2PkzFhN3yA927HaO42hV9pnYWsJeVku8dOZOI4whVggYkdOa0BlCtwIS3kQhsf
         6B9bv5KNvVxr7uu46A5qkHajBCro9CcTOwkt/ygZvmqlOGbtQcz2eKzcVbad4yK78OfT
         JoL8hAR7JT+P8+FlaKtZT4QY5kHTTsLQDh+nwcsZdYLEIddlYee7oK8ZMWPWyNYqvdin
         WL2Qa1g91Xzf8jOa8Eh2qCsa6ezvnYn0FSBOscRj3OqbOsebfRCtTYUvTBiZDsXAozI4
         k+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JN98kmc0I9yRl2q4/t1ISwSXXdDiIz5j0cHyQncYtoQ=;
        b=CJMyfYLV0BJN74GQTbvvGWZqlPoKfxWIBcyyMZ4PpzrpV6O4Yse13/0Bp1SwSNlzjr
         Zz08g+c0Hofmv4lITq/EuwV95LEHsjIiGyHGq4QhML9HBzZHW4KD/dfUnPWVMC2JvwIz
         iJA+HN5cqBlKvSMuTfvTcd0jaPxs8A7OOhKq5s+VQP1lwwgLivYvTZ6W3LiaG2wCPGSh
         MWyJSrLGUhaUhCVpOlEf9PSScbzeiHydgw30oyldxVr0fpssC+dd4xfgzsuILnIF/+4R
         uXRLzi9hIYdF1nWXeK9QGP5nY3NrqXRHOmOySJnDy9+ustzHB8T7APJVFUl7dazpsknD
         9G6w==
X-Gm-Message-State: APjAAAU6nFeblKGTkVDpHF7FhlkAC/6ok/fl/v50wVYluykKELZAzvOf
        RjnXBy4hr9Uwjv4WimsoT5knBArbE9s1kF72kzFTSQ==
X-Google-Smtp-Source: APXvYqxkjIhdfk2/TxuA1ABXBYIh4Ob7PoUzkuimBZT+K6frg+LrsacUYGHToeiWentjBY27RBkoeJq0uE7WzBu5uf0=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr13095919ljt.107.1551787298920;
 Tue, 05 Mar 2019 04:01:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543625590.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1903051706060.145@nippy.intranet> <CAMuHMdW60DhofaVqdts-TmJbgpwVD7NOY4Hp9bbXD5K6-gp5GA@mail.gmail.com>
 <alpine.LNX.2.21.1903052027020.147@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1903052027020.147@nippy.intranet>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Mar 2019 13:01:27 +0100
Message-ID: <CACRpkdYTzjCxEkueFWAzgVgqe4uy1H6rby7s7c+MkmRhgoaSbQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] m68k: Drop arch_gettimeoffset and adopt
 clocksource API
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kars de Jong <jongk@linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 10:55 AM Finn Thain <fthain@telegraphics.com.au> wro=
te:

> That leaves bvme6000, hp300, mvme147 and mvme16x. Those have not been
> tested. Here are some options for those platforms:
>
> 1) Apply the patches untested (gaining new clocksources and some API
> modernization for m68k, while fixing old bugs and potentially introducing
> new bugs).

This is what I usually do with ARM machines when I don't get any
tests or reviews after a reasonable time lap, > month for sure is
a reasonable time for users to have all opportunity in the world to
test patches.

If things break, users will report it as is custom and the author will
be expected to work with them to fix them then, we do this all the
time.

Those users who want everything tested before it gets merged should
provide resources or time for testing.

Just my =E2=82=AC0.01
Linus Walleij
