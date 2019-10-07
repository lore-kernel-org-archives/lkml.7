Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D99ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799BE206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570477088;
	bh=Vb5ysbfySnG05gTtQswSr0L15TWxpqB+n08NNR19Wjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NlTNZrvqADwiUAHX++v5lTkg8LsxY1mdNCsFMvF24zFRCOYAQYfkjyOxSB3ab2beh
	 GL0TMxexBPADnwIUky5I9sRpzNBMS+z7QK97IcHdGyoFsB70n2qoUw+r/r7ZJh5abu
	 FebY52z3GfsboKSVVSHtM4Q8R4/CT3tlXdTWKT9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfJGTiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:38:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35403 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfJGTiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:38:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so10124217lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2i1Jq3dJE/lAwP5Offu74j3OydK/atOoSX/tgmiHVj4=;
        b=hdThZ7WJaP5NZ+W5fWwbMjwhAKsU2IIErvTKIQlco2XJO/gh/WPWgizXSZfMfMvPMR
         Lt5468syXhWT3u+eK1aPLWb2z7cC5aOBEwZjVM4OWNS1QKUpF27EIuBFJW/pJroTQjZn
         vTOduqk65jZlKK9oPQYY5Z9UMMdfYcg2+Lark=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2i1Jq3dJE/lAwP5Offu74j3OydK/atOoSX/tgmiHVj4=;
        b=AE3tcvfBbOea/R6vSPFag3Pljdr5kaEBg+CJm3Cux9ggsOB3gSgMgnSn3Y5Zn4Lh4p
         S5T+sS+aN6I58eirw4Rsl19Zh0ai4Agy85UzAVgGiteryoai1GKnFEiKeimG1KlgC+Ee
         l5Z9hJmlSRyhSL4fwtXBZoZJ2ZVxBoWtu/ojQv2+D9b7GNQbaTVejEE7Aq0fe+HybvUM
         KQC8xZvBao9fuu2Pr4R8HHpF7IPVaxsHcTc4/1B786GCnqJR4m+xAM/7izwVY0TbFHGb
         4CifE7mUNQpN+AJuGFJePA7AF8pFyD/c8vHNnrt9zSjZzJA8VTsXVH4BCNdpfr1Hp0gS
         iIfQ==
X-Gm-Message-State: APjAAAXhFTizrKo9ZvP//DUWL1BWN1Dtksr55vbKasZa7vP5PR/bzMpQ
        P5f79Z2pwxNrkoDFijobu5hB2ZbKUzY=
X-Google-Smtp-Source: APXvYqyidwcj2jdNt4A31IQ0H3a04yJkhW3bDImfvsKRH3d6nKOSOJv9rr6nGvIXbRVOJQDfvbTbeA==
X-Received: by 2002:a19:a408:: with SMTP id q8mr9953143lfc.94.1570477084509;
        Mon, 07 Oct 2019 12:38:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t24sm2862934lfq.13.2019.10.07.12.38.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:38:03 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id y23so14963034lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:38:03 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr20042479ljf.48.1570477083246;
 Mon, 07 Oct 2019 12:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+szGtvxCo9he+pYjvMjVkMqBHLrXh6gNM4AHRYUWXQp_LnOw@mail.gmail.com>
In-Reply-To: <CAO+szGtvxCo9he+pYjvMjVkMqBHLrXh6gNM4AHRYUWXQp_LnOw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 12:37:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiK0Mmo-9qkuoBj4Syx_q9Lbn-ZZLb8BGpvuCf8OHjMgQ@mail.gmail.com>
Message-ID: <CAHk-=wiK0Mmo-9qkuoBj4Syx_q9Lbn-ZZLb8BGpvuCf8OHjMgQ@mail.gmail.com>
Subject: Re: Decoding an oops
To:     Francis M <fmcbra@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 7:58 AM Francis M <fmcbra@gmail.com> wrote:
>
> Attached is a JPEG of what I've been able to capture from the console.
> I'm guessing it's probably not enough to go on, but hoping someone
> might have an 'ahh, that looks familiar' moment.

That is an awkwardly small snippet and not showing any of the real
oops state at all (the code/rip dump is actually the user space state
at the time of the system call that then causes the problem).

Can you make your VM use a bigger terminal so that it shows more of
the oops? Assuming your virtual environment supports the usual VESA
VGA modes, it might be as easy as just booting with "vga=775" to get a
1280x1024 console.

See

     https://en.wikipedia.org/wiki/VESA_BIOS_Extensions#Linux_video_mode_numbers

for more commentary.

That *might* work, and get you more of the dump.

              Linus
