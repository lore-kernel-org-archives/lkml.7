Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07495C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95582082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566753568;
	bh=/JqH3f92PliH9jk3gtuufnh+J5q5SoxvBPV6BD1cy/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fvvTTdJwhX/TXx3AAR9z726c0ujUDPk/0RwCbrKOiYTVwCvuo/1XHjmQGSK0n1Twt
	 okGckIRQh5y7iEiSW6P1HqJ4m6ko9kjvvqYsQKPMkJwmQ/FtiW28zCmWJKKhvitVDS
	 sw4F8t4fCBWb/McpGtIfSsiCsT32uZZtFhQR+9rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfHYRSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 13:18:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45447 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHYRSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:18:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id l1so12976992lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 10:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxGrty9J0mjsyf5s9Uj4uLZalQZtgJQRnVwqWIB0Pmc=;
        b=Z1IzHuCLIrJkJ8QqxN7FI+o9E3YcAFpDadDcsjE941z+FuKFSC6E5XgjBi72uQbQn0
         l07zY8QCuoV83x4uBL1W3nNqPuT8ORzCHnDytjzA289uciIHu6yBpwyx1qhfmZL3t5ON
         Do9mnO6aPwVtPg47xeJ8uXv+E0oJyS7shGrwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxGrty9J0mjsyf5s9Uj4uLZalQZtgJQRnVwqWIB0Pmc=;
        b=G05v9jTEmBbcmYR0Fj+wjSq6uyOHNReZkogabJ5vGW5WnWnAymxrh83XvV32sNm7Om
         IizbAyvR5leU5ssXswnSAjpqVFHhctpMsrARse56lHEIt2/eGgcN1te8E1XzbtVn2ckO
         v94c8H9LOKSI2jinArmZz53U4LW01XtRZfYZREaOy/M28quZgbS+DnWLG5HOjq9ok+Bu
         +SA1/RxNDl3NDVX6dFSW8tSWq93JnIfVa6Ochuo3DefLpEr6W3S5Ci1O7gj/kzYzFSCk
         iyFVM3eAHFXaZ+UBNsHBfBFWtcXZWCUmKXL8aYp7dQTz3f5vr3bgtbfC4W+E+gr3GdfR
         PfSA==
X-Gm-Message-State: APjAAAUXyC4eqlHUnnurLyWPKYB8nRRmiVNRmEor9EMWe5SgZbPsk6hl
        a7N2P78ENm6ZWGNf2S2qLPu1IcOXozs=
X-Google-Smtp-Source: APXvYqz/5F+Dq1zjK29PBorV4YEAkpIf/iCR8XGW2tvbqAJGseMlCMz3TkGsnQaH60dGKmHJkVThpw==
X-Received: by 2002:a2e:9417:: with SMTP id i23mr8382533ljh.12.1566753499451;
        Sun, 25 Aug 2019 10:18:19 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id t10sm1662898lfc.85.2019.08.25.10.18.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 10:18:18 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x3so10536530lfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 10:18:18 -0700 (PDT)
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr8635961lfq.134.1566753498224;
 Sun, 25 Aug 2019 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
In-Reply-To: <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Aug 2019 10:18:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
Message-ID: <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 2:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>   - Clear the RDRAND CPUID bit on AMD family 15h and 16h CPUs which are
>     affected by broken firmware which does not initialize RDRAND correctly
>     after resume. Add a command line parameter to override this for machine
>     which either do not use suspend/resume or have a fixed
>     BIOS. Unfortunately there is no way to detect this on boot, so the only
>     safe decision is to turn it off by default.

Not doing the Zen 2 boot-time case? Everybody assumes that all
firmware has been fixed?

That one should be easy to verify since it happens at boot: just do
"rdrand" twice, and if it returns all-ones both times, it's broken.

              Linus
