Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A6AC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2598B223BB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtDTFi9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbfGWI03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:26:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39881 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733276AbfGWI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:26:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id v85so28676125lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsiWTINlQxQR1BEMzpafRnmPuOo+39W0PN0QoI1ovkc=;
        b=UtDTFi9ccOoAkHVESnLfXEbFLemHF9B8RDfypnAA5oaC3NIEZTwutKq3jYEOcljXI4
         w9N9q2yKTlZz1mIelhgYCLyGAqi+Zxbss8IrFSWt75qNmhHMWrgITO6nF18BRt/A7dYZ
         GZ5yBg/87s4VJUvy3E6uKBjToaEpBrF/kho8q49+dXMfX+4H2byW1KLcISCNUz++aMIO
         vPbrArL37nfwhMs2CG9gkRvOI/1+3xfxJCbWfyG1Z9HDEsTg302Ft+LQY5cVK0uojTcf
         2Lzu0E6a2JAuZoa+xqPfucFLvEMbfxuQQFhH/LBTbEu8vA96/6nqDz1eflFUBbDFBNvT
         RIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsiWTINlQxQR1BEMzpafRnmPuOo+39W0PN0QoI1ovkc=;
        b=N9eZp1x36Ht9T6L4YeMCN1K5d5YyhkyGUaLpxFGQ7AEdan9oEG4pJ6YXHKmY6tEhM8
         F++T30C5+Bi6OCOeJiSWeGKm8JukO06H6W3tgUylL0FCaYwSksYmTvrwFzpUeYHbdOno
         ZYf/MwGC1WsqJ6K71CZh52jZVmZfCdtm6xuf2hC4g90ioobe33Xa1nfxh3bwTiwmlSqE
         f0PJSK6945mIXhKiL4ihoY4jbbExA5qNgtlxyF01/yQSdyCW2LokY1uJs1DmEQKuhGqb
         hydPWKN2HoiqVF9pR10ONEOjQSell3iCMcReCW6l5M++E7+nLmB/qgMueXJvYyizRvaj
         MzvQ==
X-Gm-Message-State: APjAAAXglPOfq1vZRh2lwzjb/ff+ElWTVhTq48IflcBZg/zGpADkjNys
        HSWJZ2rq05MQCceRDp/WYrjHcdjsFIIuuoEWuKuLgBpyhvw=
X-Google-Smtp-Source: APXvYqwaAW9VPdzw6w7+LXOEsz/GsbIL85m1zVTzHrf8+5wPBVj8Khzr0ti5BsipSFSvkPpe98hNW3JqnQLoLK+l45c=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr23717207lfp.61.1563870386861;
 Tue, 23 Jul 2019 01:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190722191552.252805-1-arnd@arndb.de> <20190722191552.252805-2-arnd@arndb.de>
In-Reply-To: <20190722191552.252805-2-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Jul 2019 10:26:15 +0200
Message-ID: <CACRpkdbm5MpcNdm8EGTR=U8MpK2VPzEg=Us0-AxZzOZ=vVJSmQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: remove netx serial driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev <netdev@vger.kernel.org>, linux-serial@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Trensch <MTrensch@hilscher.com>,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 9:16 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The netx platform got removed, so this driver is now
> useless.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

We seem so overlap :)
https://marc.info/?l=linux-serial&m=156377843325488&w=2

Anyways, the patches are identical except here:

> -/* Hilscher netx */
> +/* Hilscher netx (removed) */
>  #define PORT_NETX      71

Is there some reason for keeping the magical number around?
When I looked over the file there seemed to be more "holes"
in the list.

Yours,
Linus Walleij
