Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE38CC17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B73D21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6vmZPzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfKEOh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:37:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32833 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfKEOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:37:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id t5so22140041ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdJE1lbb5fhgh/dT3Cyx1JGxGkZvflUF/h+AJfWcCJI=;
        b=f6vmZPzK6wN/ZTTID0x/cd4SSt8ekXi1ir5sne5MSoH45L0UNr9omwVWP2bDNLs6Xs
         eNZNSf45WDQweLQXXAkVAJxgDAF1UB5DXvpbZ+A7T+RaKNHR0h/apnJRB8rFRwJ8zGeJ
         j8YWui/JXG6rGbUD0RWW3cCMx7J9Mlgmc4dVFf/Rs5mhZrL48chnIX78UTomjkWh3ECT
         z4gvx+XYtIB2jTxCS0wRxWdqJv53t9giSuAnnkaLC0kY3HeCwns7sOLEWZkFC+wcGTJM
         oTI0XxzVWoc4pdX38Fn8vfHJJIjMui/B7yFSxt5jur6v9QVrJvEYN0/LF0VFig22Lnxa
         EGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdJE1lbb5fhgh/dT3Cyx1JGxGkZvflUF/h+AJfWcCJI=;
        b=G/rOt7Mc0bHbBQ8Ra9FegGP1h22l2p1xvt+21LzH/nn5FNw8NSGCJMJZAjlMXOoI48
         xZ5DtbFFM4hMvtOxl8j23SMORbJE8VvcENvNIzgnmnxCTQeHD/v0PuzKyG4Cp6beNh5x
         77ozEuFndcxnzKGyS0pmflojumrDZ3gQF/JOrPb6HfePWNVYz01mNSrCiBxFbjqUg1uZ
         hZb/xvSu/XHg2gLy98pNYXfM3K2C7ylwc4Tl7m3VKLEZxfWRMJWVSr3t/ElF7CHV+hfZ
         URIjzY+pT0SL9ubaJx/IVssvq5s+2He1emvq2S2bPzDu75YCl37WuNY/kCFru3MCzNqe
         VXZA==
X-Gm-Message-State: APjAAAWjfvwnA8FM5jgdFvaNuZMyMrRbdc5fpo23f+ZAb30LeAapV9uX
        tQiGmC4CDXPxNB1SlkDMH3UWK5/7blS0/VBC1Fw=
X-Google-Smtp-Source: APXvYqxgGw17+25AHqiIoU0G2KGdv9w0Er+BSG4nwCY1ZRqHiKsXY7UGoLDPS/tewDU/kOt4Kg31eVCW3fRm6k5GTWI=
X-Received: by 2002:a2e:3a1a:: with SMTP id h26mr23610009lja.25.1572964675138;
 Tue, 05 Nov 2019 06:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20191104090339.20941-1-ilie.halip@gmail.com> <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
In-Reply-To: <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
From:   Ilie Halip <ilie.halip@gmail.com>
Date:   Tue, 5 Nov 2019 16:37:43 +0200
Message-ID: <CAHFW8PQ0UoyM=O4Seccsze_QDKjW21jM7Wh0koGgUXfm62zEUg@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: explicitly place .eh_frame after .rodata
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The wildcard on the end can be left off; we don't need to glob
> different sections with the prefix `.eh_frame`.

Sounds good, it doesn't look like any .eh_frame_hdr sections are
being created so it should be fine to remove that wildcard.

I.H.
