Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC3AC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ACF20862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+NSyqIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbfFJTj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:39:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40543 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388843AbfFJTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:39:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so1481660eds.7;
        Mon, 10 Jun 2019 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQPQvjuDv27sTzepAG4hWhvF4AgvvEXXIYtlZua8qVQ=;
        b=h+NSyqIvUV+3LLYL3yPhITD/OHCKfeCqwo8Yu/73jT6TWZfN6Txmzu6Nc4NZFByIjF
         0P+ii2f0WRPdG/Cf8IKWJfqFGtcalr0FEh3hl9uyFWA6xPT2nD5MlbmtWnYSE9FgRRaJ
         C71Kq2gyZuDJDtLS/AKq553ko4BSYjF4oMqFifSGUeOefMQw1j1blTYnhl13BkdPeQGA
         yS3jTGaKdasCCOQyoVkYupCk4y0QgSNxPHX5QpbjoblIZRYZCWspJaCrtirmYJf6o2vP
         Vt9JWQXyD6rgTWJ6QM6TKn4CpthjHMTJk9y1Cg5mFzyTJV6zzWkbXD8jPLtGrsSlWizF
         j6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQPQvjuDv27sTzepAG4hWhvF4AgvvEXXIYtlZua8qVQ=;
        b=CbdzZXQNSqWiXTh8zE651XZZksbZHZq6i+SvLuI/LKtmcaABF+jpBGv5HAMYS+0PxB
         JOuUvY5OuZX6RSgnsyUJ8dWmcMo0F/ex0xK78cV61E/Ov+4/ORpq6Fuko3ilVYVtAU1p
         kmhKb0pR/6wVRVV/piROSIUIx75XmpgIicU+L8qXxh2lonv2l80sNtqCtwU263mhkiuG
         A0/4cYOp3bJif/X7jWX49sLudhNInTuQSOAplFIjKBnXJtfXqg2xuGJZyjRGuqPs1OiU
         1lSMMh715dSSMD1B8ZVEPckXrw7I+PE27/IS5ejRbIAwYgJ1OZZWYCPUiAJDKK1vNVWt
         yYOQ==
X-Gm-Message-State: APjAAAVKR7Zj6COPWlrWoekygAkxBdSqvcFOpxPB4gAPNzRJHSOUOwTR
        4mtAMW4aNTSh5siZzWetsTcffbkNWbqxF+DMhbKE9A26
X-Google-Smtp-Source: APXvYqz1kexxtSxSbC/mQomznP8lJlzG27uSLKICLaSKbIC97I6MgU7HMDNaWIJHB6w1kOBzjMPBX5pxlUqhvF4APOE=
X-Received: by 2002:a17:906:604e:: with SMTP id p14mr16491664ejj.192.1560195565360;
 Mon, 10 Jun 2019 12:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190610172308.21129-1-jorge.ramirez-ortiz@linaro.org>
 <CAF6AEGuAPurGcRh42iRkt3paD=kWLJw-ic_LL1QGY=ws8_00XA@mail.gmail.com> <e656ddd3-f327-818d-3688-f24fddcb52c5@linaro.org>
In-Reply-To: <e656ddd3-f327-818d-3688-f24fddcb52c5@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 10 Jun 2019 12:39:11 -0700
Message-ID: <CAF6AEGt9=xND3TyJy5HDg3RbXB=dxzj6oqBxKX9MaC5O2=JYVQ@mail.gmail.com>
Subject: Re: [PATCH v3] tty: serial: msm_serial: avoid system lockup condition
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, agross@kernel.org,
        David Brown <david.brown@linaro.org>, jslaby@suse.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        khasim.mohammed@linaro.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 12:11 PM Jorge Ramirez
<jorge.ramirez-ortiz@linaro.org> wrote:
>
> On 6/10/19 19:53, Rob Clark wrote:
> > On Mon, Jun 10, 2019 at 10:23 AM Jorge Ramirez-Ortiz
> > <jorge.ramirez-ortiz@linaro.org> wrote:
> >> The function msm_wait_for_xmitr can be taken with interrupts
> >> disabled. In order to avoid a potential system lockup - demonstrated
> >> under stress testing conditions on SoC QCS404/5 - make sure we wait
> >> for a bounded amount of time.
> >>
> >> Tested on SoC QCS404.
> >>
> >> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> >
> > I had observed that heavy UART traffic would lockup the system (on
> > sdm845, but I guess same serial driver)?
> >
> > But a comment from the peanut gallary:  wouldn't this fix lead to TX
> > corruption, ie. writing more into TX fifo before hw is ready?  I
> > haven't looked closely at the driver, but a way to wait without irqs
> > disabled would seem nicer..
> >
> > BR,
> > -R
> >
>
> I think sdm845 uses a different driver (qcom_geni_serial.c) but yes in
> any case we need to determine the sequence leading to the lockup. In our
> internal releases we are adding additional debug information to try to
> capture this info.

ahh, ok.. perhaps qcom_geni_serial has a similar issue.. fwiw where I
tend to hit it is debugging mesa, bugs that can trigger GPU lockups
can tricker a lot of them, and a lot of dmesg spew.  Which in turn
seems to freeze usb (? I think.. I'm using a usb-c ethernet adapter)
making it hard to ctrl-c the thing that  is causing the GPU lockups in
the first place.

> But also I dont think this means that the safety net should not be used

yeah, probably not worse than the current state.. although a proper
solution would be nice

> btw, do you think that perhaps we should add a WARN_ONCE() on timeout?.

not sure if backtrace adds much value here.. but perhaps a (very)
ratelimited warning msg?  You don't want to make the underlying
problem too much worse with too much debug msg but some hint about
what is happening could be useful.

BR,
-R
