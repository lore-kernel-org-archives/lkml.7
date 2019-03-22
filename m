Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C38C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0508E20835
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p8v++S0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfCVXFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:05:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37966 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVXFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:05:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so2489945pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ck8I9xVSPa49Ljs8ENnCytz2yv8MJ2DGkzCivr0kymM=;
        b=p8v++S0facyjzOMMYrhN+i7AsNdy+xhNS1rs/mq1LEkHB3+avX9IPpuFko+IvPb9lW
         TUvY9OVkFf3yAOdxpSCfzwHo2DuY0QUPov6jBySE090nB2mTOrBpjp/+qU1rEVR43DVO
         61Fmeu024fwyVOL1ATaE/DPFQE7InUxnU5za0DSYwN6MrdnWIFtRCfLT6JmUqWh0TlxV
         3OgGegVInD4ayS9bT0wRgxsq1jwtLi6dfVY+776PgtIequQIiFPNM03z8cjuwEvyStJX
         UL4BulipK21Df99QHrQLBT4LmAOgvsXHG3GHJ2PxGasZaKn7ZCW+rJy8trT9rvhkpa7t
         XB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ck8I9xVSPa49Ljs8ENnCytz2yv8MJ2DGkzCivr0kymM=;
        b=hZFD7tpOpsFn3Pp0AFgt8zw47UkBlkbwB9DdJ6NrxatSNhNFSupPbhCCCs2QOiIsJz
         Q6O4CDm8KcL3bov5T2egcNUkesNqBXN0OlsJGR70bi33dbQbmVd4gtzb9CyNxy6Pf02s
         oJMazSNp77TH+V4O2kNblBTS9ZNnglMvSKURJDiGQU4Z2BlTEdQzEM5OWRVE7fg4qik4
         zK6LRqy2AKzh7XLBX1IBDmalSCbdR4uzP5ULPwYGpftdVDoMgvTn1rY7+Ks8+3XpYFyX
         pV4vdsmmmzfkW6t7yZD1kpsSDWHlEYSLwlBCBypWjdSJvyjPrhs4qMYoXXmcvGhwhzm9
         Yfaw==
X-Gm-Message-State: APjAAAVvwMBonqKgLmHlHSsbLHjzdTnBv8jd79LSWCSnF9+Um7RMcaHb
        5IlE4tWCtuXwUTXvMod0VM2heaSOAb0=
X-Google-Smtp-Source: APXvYqxHBCrCVL4sZ2gjlPVXp8X9STJSVQ+0qugDdUjM68vAdY3tTWs+e12Lkl1UvlFlIyFxY1blRQ==
X-Received: by 2002:a65:6685:: with SMTP id b5mr11248328pgw.70.1553295914656;
        Fri, 22 Mar 2019 16:05:14 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:6963:3508:5454:eecd])
        by smtp.googlemail.com with ESMTPSA id f65sm13514857pff.21.2019.03.22.16.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 16:05:13 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] arm64: dts: g12a: Add peripherals
In-Reply-To: <20190318095851.4062-1-narmstrong@baylibre.com>
References: <20190318095851.4062-1-narmstrong@baylibre.com>
Date:   Fri, 22 Mar 2019 16:05:13 -0700
Message-ID: <7h5zsa33yu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add following peripherals :
> - AO Clock + Reset Controller
> - Pinctrl
> - UARTs
> - SAR-ADC
> - USB
> - Mali GPU
>
> USB depends on the PCIE clock and missing Reset bindings.

I left this one out for now.

> SARADC bindings is merged.

And this one, as it depends on new clock IDs.  I need a stable tag for
those.

> USB bindings has been reviewed, but not merged yet.

Also depends on a reset patch for the IDs used.  This was just merged by
Phillip, but I need a stable tag before I can merg this.

> Mali GPU bindings are still in review.

I've left the Mali nodes out for now also.

IOW, I queued patches 1-5/8 (branch: v5.2/dt64), and will wait on the
others until their dependencies are cleared up and/or I have stable tags
to use.

In the future, please note all the out-of-tree dependencies for the
series.

Thanks,

Kevin
