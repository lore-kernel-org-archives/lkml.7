Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C193C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2D02671F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qBcbQOrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFCWPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:15:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36978 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfFCWPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:15:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so1424122plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=AS+5msGMEX1/8R6Y37Be553kjtYeh4WbTw7nlVDQ3fw=;
        b=qBcbQOrH7/lAUooQqY7B354nOSfo8120KYrAagGRLluXFqf/5E8SAIO8ERKuFud2gE
         DrWecjYJNk/bl/ev7vgVtZOG7sM/RMZmAB+BubapSjxCH878TfewaumtVkfkG0jQbQST
         a772e/QIUaUCP1tbEY/5RdTLGx/POkz5uABZ9GTS22CyHk6+ZpJ20vj62+B6trv4A/Nq
         RDjLugBO9fExWsJmkkk9aGrASUEWNz+TVzULoJxaync77pFmd+mRHhuPFnw77c91y38j
         KZGFBsxGV5BIYnuogEDU6PDawdkkRN9orJTj9zTZgDforVxWoW7hDZm2sUBPctKOnY9z
         WTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AS+5msGMEX1/8R6Y37Be553kjtYeh4WbTw7nlVDQ3fw=;
        b=KPuynnZJiK6KugDAJRi3GG57SxPDEvMO6mfkQDQ0H4dKeq3t+YlHu1AC9xt07hBvAP
         rdydp8wvcWw6naWFerXyWRmFdKQq/xuZgY+/7pLVw6/K6D4RNSGELGjaE0jfF47Y0T9U
         iGAcr0SCJdQZl95tkUxKaIn0uOF7YaCU2w6sbsjgUKFP9apstlaF9SXWaG+wRs3YHjgb
         4fH53w2dOGCaWHLdjh+VQDC9UCBx71enO1vwhvL3PClrUsUirT3/98g93UIe48brR0aZ
         A4RJpy77PB+3P/cDGMFo+EYtRITcnZ/2fGng1nECOahOpRkRMvmtsJJZA26m5hKeNeiZ
         HDDw==
X-Gm-Message-State: APjAAAXVjJzFj7usa0tu91DVGoO7Vc4uFgzXOkCNsvTzDQjQOHbI2JqC
        uaK+fSUFP/PrFGkXLDuesulPJw==
X-Google-Smtp-Source: APXvYqzW4UJMHXhVyffvyuhaOGHNRco6mfxCHAHPih8GypHJkUx+ZG8CTCoQM38gm5YIRTyALBFE5Q==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr4946785plb.331.1559600137824;
        Mon, 03 Jun 2019 15:15:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id d6sm14561224pjo.32.2019.06.03.15.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 15:15:37 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: meson-g12a-x96-max: Add Gigabit Ethernet Support
In-Reply-To: <CAFBinCD67XCpT-zmppJ3SSs5Q5ruse-otGqMLdbeaTnkr3PKiQ@mail.gmail.com>
References: <20190527130043.3384-1-narmstrong@baylibre.com> <CAFBinCD67XCpT-zmppJ3SSs5Q5ruse-otGqMLdbeaTnkr3PKiQ@mail.gmail.com>
Date:   Mon, 03 Jun 2019 15:15:36 -0700
Message-ID: <7hpnnuiad3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Mon, May 27, 2019 at 3:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Enable the network interface of the X96 Mac using an external
>> Realtek RTL8211F gigabit PHY, needing the same broken-eee properties
>> as the previous Amlogic SoC generations.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.3,

Kevin
