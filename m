Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0337FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2EF20862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KXEg/r5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfEWPrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:47:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34349 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfEWPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:47:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id h2so289907pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jv+ZMbc1I98Kfuw0Mvc1m1vrwyGUlcd3bpE/jqp7bS0=;
        b=KXEg/r5cqRllmZVEG6qwVqCZ9yxdY79ciDsmC/wq73qmEkq0HJzU0pbMFvT8pyOOMC
         M1UTsQ+2P8noymytOkYDBQQKI0XdRCSx2LeIifJkiOu6m8N21sILr6+Ps4pbjTJvL1VL
         HssSLUOOnz4YrbEenbqPmEsu6qZ4d/ZUReNHcY7wNTI9OVGWBPOirHS74rSSwsXE5W0m
         9pM6F9+0iwNHMZEVpKMAAYuVcbsh3JiTHLDVoZ4iwRW5ZlJaIkDyf1TwujS67RlCWQ7E
         k2qqzXQHZGoTX2qUbg+yNFo/egvQnf4HxtcKgOUbVPMO7u2BWjGzPzkhcTGTF7Yta08K
         OFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jv+ZMbc1I98Kfuw0Mvc1m1vrwyGUlcd3bpE/jqp7bS0=;
        b=aUysFh79PEulAWNHxkbnl+hRgArpn8x7gMZb1cd5dueo3MQLQEQInMpxZxMqAGy6/z
         8rhKVm4KfUbSKMU38LGIUt75iOGqUw6Nf4/v4Ou11zuRURhDfmKTjSn0an0pKvOMOc+P
         qZ0qI2q3H7aHq98JZsc+As0PGAtsdsSFffNRlSSNzw9okqmevOIKgczvSlYQOtStsOkO
         zfDPW11wLbdMPeshlnumefKUFfTAXXYI4oTvcg7sfPBieIAIzSgT2IRt2oxJYnXeE56r
         vz15cOUp7e0TIE97Ps7MJ8TVuHpTkHldDC9ESuhEoNd5AM7yDl+GwOTyMEsezN3oRHbJ
         bIyA==
X-Gm-Message-State: APjAAAX32oObvCG1Hw2H0OleRWt0OKR+hm864DWGURrTNxJNT2Qky8wF
        R9BHWnREFI94gd2jlV6MFGX1EQ==
X-Google-Smtp-Source: APXvYqzydErEWSZnvbFfkefvdicgMunWwZk7nzF43XkELRH/ke8RkJbMW+oZH025cjCAYMNFEwVIbw==
X-Received: by 2002:a17:90a:e0f:: with SMTP id v15mr2093710pje.140.1558626450657;
        Thu, 23 May 2019 08:47:30 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id u6sm40276897pfa.1.2019.05.23.08.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:47:30 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] mmc: meson-gx: fix irq ack
In-Reply-To: <20190523145950.7030-1-jbrunet@baylibre.com>
References: <20190523145950.7030-1-jbrunet@baylibre.com>
Date:   Thu, 23 May 2019 08:47:29 -0700
Message-ID: <7ho93t41gu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> While cleaning the ISR of the meson-gx and acking only raised irqs,
> the ack of the irq was moved at the very last stage of the function.
>
> This was stable during the initial tests but it triggered issues with
> hs200, under specific loads (like booting android). Acking the irqs
> after calling the mmc_request_done() causes the problem.
>
> Moving the ack back to the original place solves the issue. Since the
> irq is edge triggered, it does not hurt to ack irq even earlier, so
> let's do it early in the ISR.
>
> Fixes: 9c5fdb07a28d ("mmc: meson-gx: ack only raised irq")
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

And to be clear, this fix should go into v5.2-rc.

My Tested-by is already above, but just for the benefit of the
archives... tested this on mainline, and also on a v4.19 backport with
Android and it fixes issues see there.

Kevin
