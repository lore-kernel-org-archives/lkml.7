Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1566C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831AA204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UEgMBfHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfEGLCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:02:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43521 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfEGLCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:02:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id z5so8801619lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 04:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EUu6Mnu44He2lWLLhgCEFkjsFkbhrlsReIpHL53zlc=;
        b=UEgMBfHkaLJK9vCowpe3BLuKl5J2UKHObPCuuSv/qaGx2Da93VxAe5Dj1SGZrQfwbY
         8TUgGK1QUznMXwBPdOy7ZThVhp3ERP6K6FnYHQvH3l+U64+pZV9p/xQtv4cvvl3J9222
         CGI0Zs2B8BIs1XC+fYBlOeUj+9PI/FMftXubnu8RBIpZC9vYg3MwCqZkTFD2a8ZhCxVY
         5JSRcOl36cZbnq2eMBMkuXpZDNNGMudPyH8uSnA9H18fl3cKfhaeiM4zAbYbyMKCIDMv
         XhDysh1BugLRHZwI8MHUhR+AQ7akp/rr4mrpuc/MA6KvB160hkprdSRo/Ew9qRUyqouU
         VV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EUu6Mnu44He2lWLLhgCEFkjsFkbhrlsReIpHL53zlc=;
        b=tvXACv3I84adux2Jc04Vbj53aqSCbWKCmPdKaMIf58w6+LGg4wYOq5wWikX0Sc6TxF
         0wtoQKXwcaN8QiFMNpVklP9oFBN7IUqmq8nUQ1EBganeD2k+Pbyw7vvTHNyCaWTa6tdD
         4o751fjVQKAG874/jMsT6x1ZLZaUKgYl2nO6BSGT0TXGjKQxRD85V3kFgBbq+YcsDya2
         SxLbR2y1IASG7kAP7rZzCvhSRcoBnfFtPH4Auxsp288m6cvn3ffdhpGv+WzGMTySsl6h
         RsLD4wcrWTiR3EVHUwKxbdPN3CiAhm9uwxMuH9u3CZrD+gQ4R5M2XFnfP3+iM+P3b8WV
         BbYg==
X-Gm-Message-State: APjAAAWgembn9Wru6wiFsCqx1Kuf005HiuorSlosLn1PIKE7Qf9CIc8N
        z39J+6eFju+NNIfrquTfFEsny5NK+05r8QUULP3YPbM0htFPaBJkDpYdHf4bQ2L52gRm+AAADV2
        GoZ1s48zZ1QSSjVX2h6VD7L3LY0LVQZxcVA==
X-Google-Smtp-Source: APXvYqx68N5jhHa7laODn/CQo4UzVADN8Md1na029xCAPAlTBaRQwWHs89c0lpBgg+yKBskHLkfyka0YUBiDmNZdooE=
X-Received: by 2002:a2e:9d0a:: with SMTP id t10mr1967057lji.95.1557226955058;
 Tue, 07 May 2019 04:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
 <mvmbm1zueya.fsf@suse.de> <mvmpnqcsn6u.fsf@suse.de> <CAJ2_jOFu-yCZV_A4B48_fLq7h7UA6LUWhgpxr0uuh7vhW9Q8pA@mail.gmail.com>
 <mvmlfzisiwc.fsf@suse.de>
In-Reply-To: <mvmlfzisiwc.fsf@suse.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 7 May 2019 16:31:58 +0530
Message-ID: <CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=UaSbGCMMF_g@mail.gmail.com>
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
On Tue, May 7, 2019 at 3:09 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Mai 02 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > The PWM default output state is high (When duty cycle is 0), So I
> > guess leds will remain on by default.
>
> So that's the bug that needs to be fixed.

Sorry I didn't probably get you before. I now understood the scenario.

Leds on HiFive Unleashed are wired to supply instead of ground.
And as per ./Documentation/devicetree/bindings/leds/leds-pwm.txt, you
need to provide additional property "active-low" in such case.

- active-low : (optional) For PWMs where the LED is wired to supply
rather than ground.

The leds will remain off by default when you add the "active-low"
property under the pwm-leds subnode in your DT file. So, this isn't a
bug in the driver code.
For DT file change, you may refer
https://github.com/yashshah7/riscv-linux/commit/dd55057a26150e50525643a423b20e07b72617b5

Can you test this at your end and confirm?

- Yash
>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
