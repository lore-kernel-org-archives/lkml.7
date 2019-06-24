Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75438C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FA020674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JP5EwECS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfFXW3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:29:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33288 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFXW3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:29:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id h10so14216010ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhT8989fkRjAHTk/5G9Ixl6wUhkKgi/8lCPip9aWCe8=;
        b=JP5EwECSiJKsyIgbUlYGyGzSnzKDDRJaw7iPPJh8JN3htzaytbwISBlH/bIDywgvyT
         H31q5WluB5CpCaYV+fymi2WtyF5c5bFmQCyxFSZQMbi+4pygArMY68GBmntozsHK0NB1
         NUPwuVW5vAeWKu/wnSDUXze5ZQRT6Q+25LpvFzjlkKYlFUQ0PJzvAUlZ93283AfQDWUo
         KtDNPbYgszWEqkUhSV4ALCTMkxQ7KPvzhD2+SuEqsw3dCR37wgl3GCOXInkyU4RvhX+C
         gdHttlihdEodR7ODSWGQk87PdsJNe3f9/jhcqWvq+uBkTQVg58mhJ3J3lWnX03i1aTul
         qmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhT8989fkRjAHTk/5G9Ixl6wUhkKgi/8lCPip9aWCe8=;
        b=LME4uuUZzDixqbS/9Fq9C0922uIX7DHkbGDThtUkNJFKy9dRUhXM1czhXVxVqOqiST
         iPNOUxxYDfs1cWblIG3JRRh9u3xl6h4spNRs8YF5E7tHGUnWPnWRtjFUXqnSdSm49lOx
         Rp0EOiJDvbTXxM2jldNvSGIUETJR8CnxBWO+hKxg991lw1j3KEa97ayEZuFuxOzX1b8k
         E3dfCcJSGlgIIkoYGfWpwH+pphCXioiFyqyO+xe9/xlHvUGQRTPro7MFu8qGTTk8MQ1K
         yzM6HhMerlnEe/1b9kZbyeHjT2Yofx4Kqfz8C1B4MNWvbTLNx98GgY1z50KfdyMftr1K
         ZmLw==
X-Gm-Message-State: APjAAAW1yhkLa7iF0c7061IIEKqzoW+rNFOmlWKbopltx+AZbGt+1kh9
        BsH+kfGrNySOznF3wm1+29nqMw4Hdehb7fBS0eO7zA==
X-Google-Smtp-Source: APXvYqytHsZmK/WOqJrR4b8Kg35M17ODcRpW//N4bLgT7nYWgQiJyvSaeQ6y9QVp/vPH0Fq/aMqZOyaMZctt9Ek41Gc=
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr50219094ljm.69.1561415381933;
 Mon, 24 Jun 2019 15:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190516085018.2207-1-masneyb@onstation.org> <20190520142149.D56DA214AE@mail.kernel.org>
 <CACRpkdZxu1LfK11OHEx5L_4kyjMZ7qERpvDzFj5u3Pk2kD1qRA@mail.gmail.com>
 <20190529101231.GA14540@basecamp> <CACRpkdY-TcF7rizbPz=UcHrFvDgPJD68vbovNdcWP-aBYppp=g@mail.gmail.com>
 <20190623105332.GA25506@onstation.org>
In-Reply-To: <20190623105332.GA25506@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 00:29:29 +0200
Message-ID: <CACRpkdYTaM+sBs-bhaXVtAwFtp6+_PWWJ_k9jobd7qB41HubDg@mail.gmail.com>
Subject: Re: [PATCH RESEND] ARM: dts: qcom: msm8974-hammerhead: add device
 tree bindings for vibrator
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2019 at 12:53 PM Brian Masney <masneyb@onstation.org> wrote:

> 2) Do what Linus suggests above. We can use v1 of this series from last
>    September (see below for link) that adds this to the pwm subsystem.
>    The locking would need to be added so that it won't conflict with the
>    clk subsystem. This can be tied into the input subsystem with the
>    existing pwm-vibra driver.

What I imagined was that the clk driver would double as a pwm driver.
Just register both interfaces.

There are already plenty of combines clk+reset drivers for example.

Otherwise I'm all for this approach (but that's just me).

Yours,
Linus Walleij
