Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F58C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225E6214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfCLIS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:18:26 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36767 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:18:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id j12so1062002vsd.3;
        Tue, 12 Mar 2019 01:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRHZJI1aTCtyhrUqZj0kM95lPoU3ZxwCSDSbcOIqPEc=;
        b=LU0RHf8KKXnGd9mXFEMiuesG/uGr/g6vBy1tbgObz0RNzh4OUAXBX5FfQN+NDHLmMQ
         lyLxdK6TTil3Ts6YRIopknsceOgbEaBN8vA01gWeFrdZdVvU6Soe7YHIcH8VpRZY+On6
         1pCQN48PPt/xy6R1vuKMakb7VyJSiOSNJCNnTcCzYFnX5PI1sKrk8dwheSg3baMG6T6J
         k989eeWvXyPl4JT2gyJK2htp+bAbcYlAuUUIZLJJRGe/b+S+MSTH2OO6AGFFCKWHjeWj
         vDh6/9J7wKzARBV/rJiLaS8+K6fpBvrjG0OWqlMhPOPru7vI1pgLx+zrz86CabXJazMY
         fUyw==
X-Gm-Message-State: APjAAAWPmRL+7tyfLlczSLoF0qIB+0W80exFCwNSQoayDV4q0/tg8AQ0
        O2B0tl0Bam4DdPexYmZXNvMI/3/9XnIdAUn7N4E=
X-Google-Smtp-Source: APXvYqyFLOn3ZVd2FS1lAml0fCioseyZXaxRGQkc/yt+QrjrW0nfGVUWJf63tb0FTtJMgrF7DwXHX0bmakPpfjGcXus=
X-Received: by 2002:a67:78ce:: with SMTP id t197mr19089130vsc.152.1552378704743;
 Tue, 12 Mar 2019 01:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <902bc3a0-94b5-cf00-6b41-f2724744fbe6@cogentembedded.com> <20190312074319.31161-1-kjlu@umn.edu>
In-Reply-To: <20190312074319.31161-1-kjlu@umn.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 09:18:13 +0100
Message-ID: <CAMuHMdXTbMG+yQhg15f4afHyuFeTuaWY2-XB5yPmLqrWSY1AsA@mail.gmail.com>
Subject: Re: [PATCH v3] net: sh_eth: fix a missing check of of_get_phy_mode
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

On Tue, Mar 12, 2019 at 8:43 AM Kangjie Lu <kjlu@umn.edu> wrote:
> of_get_phy_mode may fail and return a negative error code;
> the fix checks the return value of of_get_phy_mode and
> returns NULL of it fails.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
