Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96941C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4633E20835
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z/yx1XwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfEFXoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:44:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34953 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEFXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:44:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so7164349plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lf5H4shj95cMGbwI5GeOOvJ41LL247SrQDRLfwxX94k=;
        b=z/yx1XwWFksdPj8nGuPJRGqifxeYvbRRuHNzzITSEsyMPKaCPf2neKw46ja9IqbVhJ
         NQ3XmgAp3P68euubnKEOgGd7P0LokFRIf79dma2U5NJ5NXHNmQifsX1i2yzZ9RE8HHPY
         H0vBzUTa7wtX+Pa3aph0WMfsN8QkQbeBU05s1BcH99yT5R5T1c1P928FwFuiELh8FPHl
         cvYNBVtrjH6mGMVqJm1qC1sA9EYw6E9S7BHlH2jmrdaxUaRCVOKpeNHdzeaxCsg5K9y7
         URVA88/ttt7i2Ejb+nQaO/It5FtZDTinOzHtoRJ6lmpahs5QAQ44h2jxC0WuU2Kn1nbY
         kbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lf5H4shj95cMGbwI5GeOOvJ41LL247SrQDRLfwxX94k=;
        b=H849SSjzH/5UQASaxgw5LsPxI/PvypglQJf2hM6Y13ikQH9gsxYCuGystKtg5EspsX
         Vsa1fjLh0uSxXklJQKtMEFvI3j7c/4+acY9XRdyTR7pRQcDEPjm77pjXeOwr0mW1pUpe
         jkziCSEZHkio8rDm3C+0+wx8RB+ybvbWyr4npBHe8LOnN+bhBjGu4uV5a3i02uLCCDbv
         ORrTWLOrPGirKEQwc/jyfeRgWV117qXL2SkHqa6UNBx9aA3/U44OX3XV2C4l4QhjtsMy
         XK700iGFJ5JH2B69QQ9b/KIfUuD/Uv5iRwTTCOK6M/pyC7d332ZpgILhIurbC6celA7L
         +7jg==
X-Gm-Message-State: APjAAAUOpEC8zdiUCXj4A6EuOEH6k/CQFWeBt65id9KIzC5JvQnF5xzz
        Y6jyMGg4BPGp1NKa2E5UPcSttA==
X-Google-Smtp-Source: APXvYqyzqVtSCvpVcNGboItbSbGRFBLEFuZnBKsL/llWeGZMPyX01mLCmCdAamq9cDUznsqt/wEbKQ==
X-Received: by 2002:a17:902:e512:: with SMTP id ck18mr35142629plb.251.1557186239423;
        Mon, 06 May 2019 16:43:59 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a864:57af:5348:a6ea])
        by smtp.googlemail.com with ESMTPSA id 132sm15433855pfw.87.2019.05.06.16.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 16:43:58 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/2] ARM: dts: meson: two GPU fixes
In-Reply-To: <20190420093258.2012-1-martin.blumenstingl@googlemail.com>
References: <20190420093258.2012-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 06 May 2019 16:43:57 -0700
Message-ID: <7h7eb3kv2a.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> While switching over to the main mesa git repository I was testing
> kmscube again. On my Meson8m2 board I noticed that two interrupts were
> correctly set up. This didn't cause any errors so far because on my
> setup the lima driver is using the "pp_bcast" interrupt instead of
> ppX and ppmmuX.
>
> While fixing the interrupt lines I also noticed that I accidentally
> left the switch-delay property in there. That was needed at some
> point to run the out-of-tree lima kernel driver. It's not required
> anymore and it's not documented so drop it.
>
> Target release: v5.2 (if possible because this is where the lima kernel
> driver will land). No need to send it for v5.1-rcX because there lima
> driver won't be part of v5.1.

Queued as fixes for v5.2.  I'll submit when v5.2-rc1 comes out.

For now, they're in my tree (branch: v5.2/fixes) and included in my
for-next branch for some broader testing.

Thanks,

Kevin
