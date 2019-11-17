Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA647C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 16:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A420730
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574008200;
	bh=0FKBl37d+ztFRc1pM/5YobtqLECFRES6hR+xRjIgTvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NR0aKlCMoFNT31dTy6bxO1Tn2vzdoIplLTZj6U06hiTWaWYYhXO2KCl6CEnhwi/Rf
	 O3EazZhNX4Rnj76bie/v0kNt7S2M0o6rECGe99MvVfQGMxa3HZ/yRu3hLd+2NuQftO
	 mWhViUv4CJs8TU0gjk1i2G5C4y0iHX8bE0J1p40g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfKQQ35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 11:29:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46978 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfKQQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 11:29:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id o65so11772024lff.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6XdaxDX3zxMJq2C0spg9gq98if9+VrvSJvlhs8yjaU=;
        b=BwCclg3VKegCnInK12p3LQh3ddJ6Q3NPnDVMnHvUyjW8z6SwQZobDowsZgBfRUsiUU
         Y3GAR3UJMsXYY926Mx7cHJWbvRPCU2WGalRpyhT5KZ97wnevB0cpi8jQr/tdKgNa2FHa
         8Y796nDdPxix3BcGFMnCP6HfsNO5eYKY5wv7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6XdaxDX3zxMJq2C0spg9gq98if9+VrvSJvlhs8yjaU=;
        b=mx/v0aTtk9EowmJMIQJbUk2cp/bQkheZMxxZ0q5cvM26nLgJN8j+rf8dAILlM0E4JB
         b2LROHyC6raLF1rlaGF4cBFkqPujMAJNjpMhG6FXWyYsVUQLq/1z5/NyihfjVmHIUD/6
         sBaDWkVymfhjr/iUV0JGlZ3uCBLXbQoRBrMXitqG4fEyx70ei9fw9IxsSRHUBGfgk+gt
         tPmQq9OEGjxVU52plxSLxoVdIMHk1BdQp3k1CscqrTAQ4exFJkYSbA3JdWNPx1rAM4sV
         FDHh94SzY+48vjhnZIbU7f/qKME/S1X7MJkBJkDvMg+pHjDNewpPBBXI45wiY+MKvuI+
         seTg==
X-Gm-Message-State: APjAAAU0bgKf67NfVcmGWDizxFXzG3mfuZ2YeyZrVrMDfZYyBHNc2Xn4
        m/aWzWNrQ4L/LMTfYYNDlptsyJT7LO4=
X-Google-Smtp-Source: APXvYqyu+yLh1sADk82W/6yvdl+ibxKuh6GoOZOTSnNkbTQtZn8i9MiM53jcRdHH/zej/cAjJjqywQ==
X-Received: by 2002:a05:6512:15b:: with SMTP id m27mr17190968lfo.53.1574008194651;
        Sun, 17 Nov 2019 08:29:54 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a144sm9732266lfd.27.2019.11.17.08.29.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2019 08:29:53 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id v8so16028399ljh.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 08:29:53 -0800 (PST)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr17995745lji.97.1574008193117;
 Sun, 17 Nov 2019 08:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20191116213742.GA7450@gmail.com> <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
 <20191117094549.GB126325@gmail.com> <4e4b0828-abba-e27d-53f6-135df06eba1a@arm.com>
In-Reply-To: <4e4b0828-abba-e27d-53f6-135df06eba1a@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Nov 2019 08:29:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEz7kG8YSbmAAALdP3Vnna_f4+LY4TPM0NQczeh3mviQ@mail.gmail.com>
Message-ID: <CAHk-=wiEz7kG8YSbmAAALdP3Vnna_f4+LY4TPM0NQczeh3mviQ@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler fixes
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 2:20 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> AFAIUI the requirement for the enum type is that it has to be an int type that
> covers all its values, so I could see some funky optimization (e.g. check the
> returned value is < 512 but it's assumed the type for the enum is 8 bits so
> this becomes always true). Then again we don't have any explicit check on
> those returned values, plus they fit in 11 bits, so as you say it's
> mostly likely inconsequential (and I didn't see any compile diff).

Gcc can - and does - narrow enums to smaller integer types with the
'-fshort-enums' flag.

However, in practice nobody uses that, and it can cause interop
problems. So I think for us, enums are always at least 'int' (they can
be bigger).

That said, mixing enums and values that are bigger than the enumerated
ones is just a bad idea

It will, for example, cause us to miss compiler warnings (eg switch
statements with an enum will warn if you don't handle all cases, but
the 'all cases' is based on the actual enum range, not on the
_possible_ invalid values).

                     Linus
