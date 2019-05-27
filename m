Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0048EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB22020883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PY1QXMvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfE0LxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:53:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34713 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfE0LxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:53:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id v18so11871734lfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkQ2P05r0CbW3f6Nc/yL+6alMJG9tn6Pn2kcFIlii5k=;
        b=PY1QXMvsBTT+5wZ1zSM7J7vMW6SN5avLhjy0/VrAQXYgaBJepG9Ai4IZ/9tWCgloPb
         5xoxs4mx7F5kZPxhU3rUcPkDpijDA9VjFDacr8eNWaOUIU5yI6kgqzOhfVP+ULykludC
         He0tYpJwaEdc4JONkqP5w9LM5tG8VEM3OzMINepLjOyPzHVkiTktZ0Ed0vAlNnSry+2S
         dZKMWNzwPUdZtF1lir4/GU4Y1GAInSuerD9TN6xfBKjuLkEC3P2XI88cOPHMn1zfmIxt
         xqZ3rLR/SQ2mRuEsRVRa5AMAZgJB6SHjXkonmWx0l6JizB3g8egqrBx24T+iwRjey04U
         IwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkQ2P05r0CbW3f6Nc/yL+6alMJG9tn6Pn2kcFIlii5k=;
        b=Cdx76PDWNyCW/x+C3m/W728oSm/2X7fziJey+qjipyS2bWm/A9bKz2N99i0WJe0jSF
         HHEDpUxMktyMcNDBRzbPAbdFt+rsPxSB55NDgu3ZedFYC2XqMsFff/63hO7hO3Pn+OY8
         Vja+MC/qaUMS0IbpeuEaRcVYrqI+CjBats9csi8sC7ezyEMgooRDwHkDhMDoNMGItSM8
         emzDQbCP7nEAM8qnzZw08RC4Tv2/kt40XnPaAGjxHcM/8xDyTUwXJBXEYt7nTOmS+DUP
         D8HqMN6MzV4WuWeJ7+PBQslJ58pgTupYmTTyR6MpShEHqec2VKMxv1HHIFCmQCzXHEoE
         Dfxg==
X-Gm-Message-State: APjAAAX7z9TMFU0Bz17Pl0EqcLvH739JDwkUTHN6arQHX3Rki99rAJJl
        5TaJ9oRtlJRuEKoz+NR8EhdPFQBQqh8K+XaCiQwm/Q==
X-Google-Smtp-Source: APXvYqxDK35ZwKMDb6RKZtyYMyBWL/UKHxLG0Pbv1KKjE1/wwOJP3jgzEapl8KPojM3oi55l5N4mhmwF2CTmPtxOxGE=
X-Received: by 2002:ac2:4209:: with SMTP id y9mr19510582lfh.83.1558957985935;
 Mon, 27 May 2019 04:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <1558611952-13295-1-git-send-email-yash.shah@sifive.com>
 <mvmwoihfi9f.fsf@suse.de> <CAJ2_jOEr5J7_-81MjUE63OSFKL-p9whEZ_FDBihojXP2wvadVg@mail.gmail.com>
 <mvm36l0fhm3.fsf@suse.de>
In-Reply-To: <mvm36l0fhm3.fsf@suse.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 27 May 2019 17:22:27 +0530
Message-ID: <CAJ2_jOH344oH=mvo1n9RJDPjT4ArMNBaogqy0dLCOwCcY7Fwuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: macb: Add support for SiFive FU540-C000
To:     Andreas Schwab <schwab@suse.de>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 1:34 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Mai 24 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > Hi Andreas,
> >
> > On Thu, May 23, 2019 at 6:19 PM Andreas Schwab <schwab@suse.de> wrote:
> >>
> >> On Mai 23 2019, Yash Shah <yash.shah@sifive.com> wrote:
> >>
> >> > On FU540, the management IP block is tightly coupled with the Cadence
> >> > MACB IP block. It manages many of the boundary signals from the MACB IP
> >> > This patchset controls the tx_clk input signal to the MACB IP. It
> >> > switches between the local TX clock (125MHz) and PHY TX clocks. This
> >> > is necessary to toggle between 1Gb and 100/10Mb speeds.
> >>
> >> Doesn't work for me:
> >>
> >> [  365.842801] macb: probe of 10090000.ethernet failed with error -17
> >>
> >
> > Make sure you have applied all the patches needed for testing found at
> > dev/yashs/ethernet branch of:
>
> Nope, try reloading the module.

Yes, I could see the error on reloading the module.
Thanks for the catch. I will fix this in the next version of this patch.

- Yash
