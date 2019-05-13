Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27DA208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mmoIZ6UX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfEML2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:28:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33933 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfEML2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:28:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so5178557wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OnH/4nMvaMi3VQRujj8nm/jF+XYCQszeAWgJCcFUmEo=;
        b=mmoIZ6UXobbUMpQw3nzYycuxwp+5y7k0B4ypB2048OSe2AyCHXff2Fb/oa/E+L2SeM
         9RpramwydA0CLAbKsBuZU1ACHffOCCGYPX9+x/uaVU4wEfND7VI4B4dbctm2/euBTN5c
         8eMa42pnmrEomkuL7hzwW4SzBpWC45nYzA1WHWW9HyDRP8bkvm+iwwlig8edb5Sv6Un8
         V2KaUh/c0yxnZZ3Tj3xrRGZg5ERe5U1wQDH7XcKdVGxwd+kZOdioxMUwGb4N6B+uMEx2
         YaO3Lo+HgXhKdIqXWSH52ksm9Y1Iy/qH58TWAZ06aAQJ36S1B3zMwVdLCHfzEhBTrQuw
         qwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OnH/4nMvaMi3VQRujj8nm/jF+XYCQszeAWgJCcFUmEo=;
        b=K2A/XwU9kAivJqHivL0MbymDz7Cvr9BazZ77Aw+rJd3+BhVjirdRO2Ox0vfT50bvjv
         rE19v39gHUBPBeW40bRuBpUHfa0xrY2iizfk0ROumbq+usXjhRY62DXCHt5Nyy5Em/xe
         ezeXFLJAv1lrsZTzl/IZBd1FCezutcBghKmkflNmrrCrHsR/B1dMwFxrA1KnqH2s244D
         W04MqQelIMAScauaxla99cypW4zL3h1HeXzGspbHm4JUzTipfaxXTzFRAbX77PBu7ylD
         Uro5hClxmNQ0KVud4fXgPujdXaopT2pWcV4egYcJ6IBAf17X4BgJgSZwfz/Fv75pM1KU
         PkQg==
X-Gm-Message-State: APjAAAXiA/Sz+1yzUG7tQhWKxeTmZ8H2GSg7MNEdB2D05UjYvYgALUe8
        sD4E+cjIO172+LvlILxeXsAPtw==
X-Google-Smtp-Source: APXvYqxER6ionZR5dWUWPafoltmghKq39SdTXF/QPkvTy92PPli9V9NxGsvjCPySp2bn16BrcE682g==
X-Received: by 2002:a5d:4089:: with SMTP id o9mr13229228wrp.6.1557746925751;
        Mon, 13 May 2019 04:28:45 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z9sm15023246wma.39.2019.05.13.04.28.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 04:28:44 -0700 (PDT)
Message-ID: <10e588ae1e259c2c2bc9cfd0e788aa41735f0f66.camel@baylibre.com>
Subject: Re: [PATCH 0/3] mmc: meson-gx: add ddr-access-quirk support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org,
        khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 May 2019 13:28:43 +0200
In-Reply-To: <24b8cd2eb2879378ca0cac6ddfd9c5cae68699bc.camel@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
         <24b8cd2eb2879378ca0cac6ddfd9c5cae68699bc.camel@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 11:58 +0200, Jerome Brunet wrote:
> > The performance hit hasn't been evaluated, but the fix has been tested
> > using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
> > 55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
> > at 50MHz clock. It gave around 170 Mbits/sec as SDR104 and 200MHz clock.
> 
> These numbers looks to be limited by the MMC bandwidth of the related modes.
> So, if the SRAM quirk introduce a penalty for the controller, it does not appear
> to be a limiting factor, AFAICT.

Got confused. This comment is completely wrong, please ignore

