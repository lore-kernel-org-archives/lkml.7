Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CF4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E0D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405520AbfHWPch convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:32:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395561AbfHWPch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:32:37 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00569369DA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 15:32:37 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id z15so10265951qts.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 08:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CzTSQNQPZbM6Os80kdEUxpLn3GKCd61LRBEy94bV1tM=;
        b=b8HvOe5odF9keqbdttIW9I4EgTaWqy6HVOIwB8ZN85lxvvCCAU1DONR2T84nNAEqVW
         n3yqCwDogTaoZJGo9Npd2BE8PNqYfouUdxB8ZyIv11zLPWaLl9ZZF28LWw8/vnW6P0CX
         pRUA/KlBxH2Ejp5SAzYnReyPDvQ6vEtRnp7qwkB4aBMPORyrZD+Iy9vCe59wen5CggjY
         oUGIZy3syaa5+7CMZdDGehV4XR3zUDPndd3ZzOzojjtGJteOOHqsqtfcn59q6CXhRFiI
         RcFxDAsNtfRFAjgQ4/8QStbiqqc2UzaM6EPKqQsCisolZC1cNyHIyhzZWcTxfHWCcJKs
         UIvA==
X-Gm-Message-State: APjAAAXEHTPY55XK5o/agBZ43f2sncgxxFiPYpB3Nen2PGy6dwXbCtk4
        Spjb6IP2S2dQCfzRMrmZCrkMploJYHPCpY6H1BxGXA3j5UiHmJWZnun1o7liSImkrVvyqYeMieV
        oXmDeNowTU/uAgKTiXJpSN24Ne6wGbKn1O6+MjLa+
X-Received: by 2002:ac8:60a:: with SMTP id d10mr5192668qth.31.1566574356272;
        Fri, 23 Aug 2019 08:32:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqJK+0IGboWflSxwP9GvVCqRjZSsVtPfraXZdPGofDZ9SYXqP58SXv8qNU9ASj7ybsQZ0n8lhigHT9PPjRxQk=
X-Received: by 2002:ac8:60a:: with SMTP id d10mr5192654qth.31.1566574356106;
 Fri, 23 Aug 2019 08:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190822201849.28924-1-pedro@pedrovanzella.com>
 <CAO-hwJKQcTpmk8cVf-YmKu2awXv_53=qfpy2yfmy2rgMu_DEug@mail.gmail.com>
 <e6014a01-1094-9ec7-9b37-2abdf70e305f@pedrovanzella.com> <CAO-hwJ+=dAyFnUfiPSmiGpzYTj=9BPDdeKQOY7UoCOvwQ5CH7Q@mail.gmail.com>
 <3c37ccc992d7979358e8472fbf52a583c6e1068f.camel@archlinux.org>
In-Reply-To: <3c37ccc992d7979358e8472fbf52a583c6e1068f.camel@archlinux.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 23 Aug 2019 17:32:24 +0200
Message-ID: <CAO-hwJLQT6Oj2mvDTtQsOHLOTLFeB=_e6ZQZVj2tz92CZUU17A@mail.gmail.com>
Subject: Re: [Resubmit] Read battery voltage from Logitech Gaming mice
To:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc:     Pedro Vanzella <pedro@pedrovanzella.com>,
        Bastien Nocera <hadess@hadess.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 4:48 PM Filipe Laíns <lains@archlinux.org> wrote:
>
> On Fri, 2019-08-23 at 16:32 +0200, Benjamin Tissoires wrote:
> > The problem I have with quirks, and that I explained to Filipe on IRC
> > is that this is kernel ABI. Even if there is a very low chance we have
> > someone using this, re-using the same drv_data bit in the future might
> > break someone's device.
>
> But we can reserve those bits. I don't expect there to be a ton of
> devices that need to be quirked, so using the remaining bits should be
> perfectly fine. Do you agree?

Nope. If the code is not ready for upstream, it should not be included.

Cheers,
Benjamin
