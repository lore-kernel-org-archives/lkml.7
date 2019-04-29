Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1F9C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A525D2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="R/Wms0Jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfD2I3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:29:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50943 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfD2I3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:29:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id p21so10996297wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 01:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jw6rquaiXD+oPh3858jmCUg9XPcrdzfEXx4OPrYN3Q8=;
        b=R/Wms0JoD8IoeFcmOJnm9UB09mChGCsPo8NNrKbZfdRBNrC9ik0zxgm6JauyvfUIfK
         rPOOPn+rqs4G7NZuBGQPHTJHqzvMp57hnp8bfXPoSbUtiMPjGoT3pzrrJNgDk0xDovmX
         aLpdNclAhgssdblq1jqppfSjHxV5VDeYH61spcJu5gZSlyDMmt77c4qM3bONO6UTRidl
         vaFy1O/BvjolxQpfAZridh1pcQNeeX+P9UXmUx2sAu2x2rpyCjlKZOvEPU2ZcsaWDDH6
         9x+zalMxtbqIQvBrBHZg8ztLqj5jAQp8oueRXSfgLBWvKxLFVDoxtpsV+jpJzKKSwavI
         cJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jw6rquaiXD+oPh3858jmCUg9XPcrdzfEXx4OPrYN3Q8=;
        b=Gci6snZfj1+vI1bU5X9wHocUf/SYOVW2gV+xJBGR3GZ3mKYdFi0H1XswaRdGBPNVo7
         pQiBKCVRmDcJNDMEoVmQljNAgpCxGCUhLOZ+QlTxbsCDoyBYMJJnpfl4iShhrirGYGfk
         UYT0+8IeRIAmC58aEaavb4BQAU6RGthAHvNEY5tVIBLoCT0Sssht9jxUdNzHBY4u1rsn
         GnEP4NyFhZBCCZ4UaQzKkw2+kt0M8NbXCtFsHwQy4+NzDpdNfN1nbNZeMNuT+FrpH0FZ
         hoyfaf5hOSCcS6fSYGn16OCKwkXDJ3SdxnbP3MxU4VILlmtn8yxxs0repI0jT3y5VJuK
         6+yA==
X-Gm-Message-State: APjAAAW6a7qZOWp47EeH2XDOMhHaaQs+mzorT6sqVU556RHBh4W3UnJb
        D7ydOy5S1XJDHaJaCLwjng1KSg==
X-Google-Smtp-Source: APXvYqya6tb4Yh9pwT2EePu4q5DD2g0/f2f6f30qBcWSB/2NSo2+Uj8ScWvRry4bETRvL+CCwUqYTQ==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr16665108wmq.144.1556526559500;
        Mon, 29 Apr 2019 01:29:19 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 10sm30904939wmd.23.2019.04.29.01.29.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Apr 2019 01:29:18 -0700 (PDT)
Message-ID: <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Apr 2019 10:29:17 +0200
In-Reply-To: <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
         <20190423090235.17244-5-jbrunet@baylibre.com>
         <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-04-27 at 22:02 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> > been unsuccessful or unreliable. Until we can figure out how to enable this
> > mode safely and reliably, let's force it off.
> last year I have seen issues with HS400 on my Khadas VIM2: [0]
> have you tested all other patches from this series and HS400 is still
> not working for you?

Because HS400 was never really stable to begin with.
It was a mistake to enable it on the VIM2

> 
> I'm curious because this patch is early in the series and all the
> tuning fixes and improvements are after this patch.

There are several reasons why this new tuning won't solve the HS400 problem:
- Signal resampling tuning granularity gets worse when rate rises. The resampling 
is done using the input frequency. We can basically resample up to the value of 
internal divider.

In HS200 - Fin is 1GHz, Fout is 200MHz (1/5) so the resample range is [0, 4]
In HS400 - Fin should be fdiv5 (400MHZ) and in such case, no resampling is
           possible (internal div = 1)
           Even if we keep 1GHz, then out is 333MHz max giving a range of [0, 2]
           that's not enough to tune

Going further, tuning the Rx path does not make much sense in HS400 since we
should be using the data strobe signal to account for the round trip delay of
the clock and correctly sample Rx. AFAICT, If there is a tuning to be done for
HS400, it is most likely linked to the data strobe.

> 
> 
> Martin
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-January/006251.html


