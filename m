Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA56DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8758420833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="acczSLll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfDITxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:53:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33740 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDITxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:53:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so146931wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7QjH+DHJebgggEI3cQJ0RyRsWLJCrfk+VPqpJ23WfM=;
        b=acczSLlluIJsJZ2R3QQNk/zJICSj8xl2qabwl6Ro56EDvrs4ofbm3Hu9na+gSpA5jL
         PW0LRVaRZlbUwgDpN2clgzL1xpgLru6R53U6pBDNGwxh7GZquM8Dm4DyjsVRGqjZQq0m
         DaKWdogI1dCCIwlNPG4Tc5pn369S9E54Q+W7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7QjH+DHJebgggEI3cQJ0RyRsWLJCrfk+VPqpJ23WfM=;
        b=HFHCaNl0xi19r3M4wlr/i1UCA6bVEQfjicmJhkiPo77GNVe3P8zyugssRJJTIm531p
         qopfPPHrxA7UkRP9y7x0NcdCHK9i7U3FhcZ+eKBBttveUfLleGaJWmr/jmoJI8vB4/u7
         nbWq2Gkqu4Q02grGaWCi04tqoD1d53hxSF5OgHJUzCtVqMfa8MLQAhmdbTvZ60tUMLSN
         tSDSkeGwwdyjwSD3e8XudD02Ec22DqXBBiZ/ZlcH0IIfec+rGNF7BpJBhyB4EZK2Jf9k
         IggYy77IiYgo/AjF9anfokrohEfsnkbGynVp45YDfDgAi96QZMOu1TSPGFOIKcsfRKZt
         Lvjg==
X-Gm-Message-State: APjAAAWzOothzW1v2ihea/3Cf7vwIyuWT8cLYIrrbO7rhNmcfe9Z3OG5
        Jc0hoVjwEJlNUbMGmV49jxTFFnvDniBECQwn+QHrNQ==
X-Google-Smtp-Source: APXvYqzqVljO+72W5ZGGJJ3wRzjIWRI7nNTo97NXF07gGcL3AX9F1+A2xoSVlwMJkctbxL0BGbhRSxxJe4Jf48gz6/Y=
X-Received: by 2002:adf:eb0b:: with SMTP id s11mr4365227wrn.140.1554839626238;
 Tue, 09 Apr 2019 12:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190401205519.34023-2-fletcherw@chromium.org>
 <20190405204257.87095-1-fletcherw@chromium.org> <20190405204257.87095-2-fletcherw@chromium.org>
 <20190408061014.GG2803@sirena.org.uk>
In-Reply-To: <20190408061014.GG2803@sirena.org.uk>
From:   Fletcher Woodruff <fletcherw@chromium.org>
Date:   Tue, 9 Apr 2019 13:53:20 -0600
Message-ID: <CAN-6NYZ49abdE=zkwQpFfeT1u_7DcxHh7AXe2qAibuUYUnkL+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ASoC: rt5677: allow multiple interrupt sources
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@google.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 12:38 AM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 05, 2019 at 02:42:55PM -0600, Fletcher Woodruff wrote:
>
> > This patch allows headphone plug detect and mic present
> > detect to be enabled at the same time. This patch implements
> > an irq_chip with irq_domain directly instead of using
> > regmap_irq, so that interrupt source line polarities can
> > be flipped to support irq sharing.
>
> This changelog still doesn't explain why there is a need to open code
> this rather than having the irq_chip and irq_domain provided by
> regmap-irq support whatever is missing here.  You said it "needs its own
> irq regardless for hotword detection" but provided no information on why
> this is.

Sorry! I misunderstood your earlier response so I didn't clarify that
portion of the commit message. Thanks for your patience.

How does this updated commit message sound? If you think it's
sufficiently clear, I can send a v3 for this patch.

This patch allows headphone plug detect and mic present
detect to be enabled at the same time. This patch implements
an irq_chip with irq_domain directly instead of using
regmap-irq, so that interrupt source line polarities can
be flipped to support irq sharing.

This patch does not add polarity flipping support within regmap-irq
because there is extra work that must be done within the irq handler
to support hotword detection. On the Chromebook Pixel, the firmware will
disconnect GPIO1 from the jack detection irq when a hotword is detected
and trigger the interrupt handler. Inside the handler, we will need to
detect this, report the hotword event, and re-connect GPIO1 to the jack
detection irq.
