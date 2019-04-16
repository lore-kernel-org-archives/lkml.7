Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F42C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0462620868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVzEIQiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfDPLrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40121 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfDPLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id a28so15775687lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uA9S05JzdUOVwKbkXrzWLZB0Zz3QH+JaPiSKuT7ktyw=;
        b=nVzEIQiFCukMBd82XPsRURxgciIjPpU7fssVGvVhLYdcUDnuif1M47NBi8Geml1aYQ
         wLvVsWgxbKH7mPfZMfXJOFQCHJAQlYUj6z+pX2069RLqA4jy30cjeVmHlthX65QPnPNE
         My4l6K/RZOpaNjhLMnPxDMNehIVM4N3gjQ6LBHXAeiltDXSkkMCZSx3IR9KyK+CpdhMC
         2Z8n9Rrd8B0hCmv6BWe98ZgGFfWPHyJxMFYixEc0U1B03Aqo2yJjYqhYS6MgmdEiNFl8
         o4Oyqn/TUOK5l28c+tN9p2aqBwsbG5smQ48ZR/66Kf9bOE7uPnB6taxUMBTk/bnomMRs
         LfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uA9S05JzdUOVwKbkXrzWLZB0Zz3QH+JaPiSKuT7ktyw=;
        b=kzUUUssqQvOgvR1nWC3pMr0KuZoYtOEy3l1NENhUu16VGWZVS/nGxtH8fSMY6VvFmp
         POyvVLYNGeSTKnQvjDJgJLiFd5lWKHRSNPVl6sclXog9Zi51wZEIq6fvY0P4c0qutsMi
         9HxUha5jbJE7TzalHd6AldDRZA+Q9PRBWstcoExVZbVD8g7W3IlO9GOOvV/TzcElDvG+
         mGZBaM9LREkWyWLJsjjvN4jxjb81WJYffHojZzwL5NPWixagbB/tmkgtTA43VoRtxoUz
         Iu3fDoXldwAj9cSPJBjEoEVLfGiWNwZBg9PzoX6omE1JEefXSKbUzNbE2K/nQOybtTba
         MYjg==
X-Gm-Message-State: APjAAAWgjX5nYFyewn24V8HiKHWxPYe2GC9OPS6aG41mQeK58BLhDiEn
        pLY7qhzwEzWQxnXfF4X/+dHATzzbBoEt2hfJDm8aGA==
X-Google-Smtp-Source: APXvYqy34Oaj/O2oIHaHJ2oHC3zziu3P2X7AGAj3nQNEPqcmpzt1ODMEVVSOgRbdAruhhqj6hyedmx9vGZiYOff+f2A=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr9260258lfh.103.1555415235586;
 Tue, 16 Apr 2019 04:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <1555388562-9454-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1555388562-9454-1-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Apr 2019 13:47:03 +0200
Message-ID: <CACRpkdYNu4PGBmsDFVtqYZzJaH7vQbW4FzxFwRiZp55tZxrh5Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add soc/ux500
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 6:28 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> get_maintainer.pl only returns linux-kernel@vger.kernel.org for the
> drivers/soc/ux500/ files - fix it by adding drivers/soc/ux500/ entry
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied to my Ux500 tree. Thanks!

Yours,
Linus Walleij
