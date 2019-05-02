Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B4E2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NL31EuKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfEBEBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 00:01:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40348 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfEBEBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 00:01:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id o16so793755lfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 21:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFt7883PSp3sr8375jT8hC/v5fI/cu96gfKmIMdklMc=;
        b=NL31EuKphJharQ7ownjb9GhREqWgylPR8oRdfySKPZMDjNrY2iEQE+rRHxT4ngNhdt
         S3dsJVBIj5WOjo2zeN5xhW4Q0JGirUI/rk/HumUBXGZPyY6c/J1IBbu6PR9T1NV5Y0wo
         oq3rJA7JQDfBlz0eBBDCFI0gPZ23MuCxEtssLK3CzJPda4c/lvmt5xJUeEVYEz/6IAfQ
         OOx1LWqEaZ/C69l5OxSAB7ViB3GfHPgoJiLsWv49NTYer+IitWd4Skkxi65dDWAJtav6
         B/w2l2m0I9Wxe+wHEDFd2VXNqAkEstJoKby3kTKWhlMthCaJHtP8Y62rrHurhz+U9nD4
         F9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFt7883PSp3sr8375jT8hC/v5fI/cu96gfKmIMdklMc=;
        b=MpQCNxqlXfY9upuwtLBX0xc1o6OUKHvB/Q0DsK+U0cmlChJRtJWiciko80+EyMuF+n
         Trq7p6Y/U/fCo3soKac/wcv5QeygBaWKw+N/+TCFvSoV27afrS3m4bPOWsm1GocYhRKj
         XZMYZrfsQWjlC3iKKu7COXKdI/dm/t0fUYhw6TIQw+nwPjgyvDEvjIH76V2avvLpgV/s
         9X8hOMBdVTCWqpUiSySysYnyt8S0ffVYn62IZYADektraTtlW1KHnZceu200HUfWhj1R
         +xJQV1a8lW8Dlbpa/QYB+KLpeQ8sOphzMr8vpHqStZDc8YO9Lyr44uSEYt39MXG9wkh2
         u68A==
X-Gm-Message-State: APjAAAUyM/jGHyKjoiA1S9mf8AFzkzvlEDXFgWhYWwTnroVeI3ZFcV9H
        lFlxoOz1AsAHThkowCU6fAS7wbV9CV1Zrm/VogxzRw==
X-Google-Smtp-Source: APXvYqxzdvzK/rjINuA4zAT9PeOdoZuUwGQBTyS9ONY/hM54JNu3Te4R4w/vTFUvuR1Nv624R8L3skIAT6evE9QmbPY=
X-Received: by 2002:a19:81d4:: with SMTP id c203mr672545lfd.160.1556769713184;
 Wed, 01 May 2019 21:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
 <mvmbm1zueya.fsf@suse.de> <mvmpnqcsn6u.fsf@suse.de>
In-Reply-To: <mvmpnqcsn6u.fsf@suse.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 2 May 2019 09:31:16 +0530
Message-ID: <CAJ2_jOFu-yCZV_A4B48_fLq7h7UA6LUWhgpxr0uuh7vhW9Q8pA@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
To:     Andreas Schwab <schwab@suse.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Wed, Mar 27, 2019 at 2:34 PM Andreas Schwab <schwab@suse.de> wrote:
>
> I have now found out that the ledtrig modules don't load automatically.
> I would have expected that the linux,default-trigger entries would cause
> the load of the corresponding ledtrig modules.
>
> But there is another problem, that the leds are on by default.
> Shouldn't they be off by default?

The PWM default output state is high (When duty cycle is 0), So I
guess leds will remain on by default.

Are you able to test the PWM driver at your end? or you still facing
some issues?

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
