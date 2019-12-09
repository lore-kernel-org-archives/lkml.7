Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AD7C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C1C205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tY1B/g/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLIVwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:52:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41975 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIVwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:52:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so7779055pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=i5+TnwHki7CwB9DGX3Mta0rJCHBm+w/ZGchbVbmsZYk=;
        b=tY1B/g/W6Gp0eDto/4M5qAgnEJFLIsacGgPoR131eRiJk7fUtWl4e5TQIlC1CAiwdY
         b2TBMj1z/kkjZxyKSMYaCnnAel2maeSAGyyUqpShy5+reGnTxRvNPJnUa54b2HshK+sw
         t+J0fkA28IJXOSml4Jbt+zWayFEF8JZiQi3qqIpF4RsKMh+2RK1GijtLBE9c5vl5ZJ2o
         oK2ucjV+VnSS61VxdpB2OPot2SGhvHBBB+vFt9nNelUOZSqQIPhVC1ofDKm0wlM+tnbe
         yYfDf7wS04Ibq9CrYi9EXfDHETyRs5qRNWbuNJ7rOu+M7/dQiZLDtmcjMWT9YUPboBG/
         vJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=i5+TnwHki7CwB9DGX3Mta0rJCHBm+w/ZGchbVbmsZYk=;
        b=cKt2Wlex4pyyxpGsHrnTSUdFpEdL5+4fX9ASjqW28Zv8qXZkVGl0qs2mcLtkckTsea
         Nl8S+3zgho4E/3jk3M+QTNmItLUCVHZHAGIB58JlsKbFLrocZFY4do6mFmDTvghVi0w1
         RPHO1pA1x2wdNfhD/VRHDCgW+2DQxKkrfLXUhVwWPVpQ0a3k/3Km21EGRDWHwKPUkToL
         MWhPu5PSoF7lXvdTZdqTXaPS+9F6rpeoXbM1b04jJA66XQ55u2dXvNsitSfmVE0bLhL2
         za7p/GYsPwUPKQ9UJ0IKPGHYWhLYGehhwvRs3n9WpjR/0Mx8tzHH0mJ5BCVoYsAZpBRr
         HouQ==
X-Gm-Message-State: APjAAAXN83MRqHjTY9zF8hNJxi24z0olcI0/c8fGkw7Sxc2BdXgFYCXt
        eJPtbUbb1OPbxfFk2ji9hYWZAg==
X-Google-Smtp-Source: APXvYqwJ+lQOvhufrrs8iA3BVrUFuPSN7n3NPPeGKXKlHT1K24DHqB1iVmQmDkzXvU5fBntaC/ym1Q==
X-Received: by 2002:a63:1624:: with SMTP id w36mr19463046pgl.404.1575928336235;
        Mon, 09 Dec 2019 13:52:16 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id i127sm465841pfe.54.2019.12.09.13.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 13:52:15 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] arm64: dts: meson: add reset controller for Meson-A1 SoC
In-Reply-To: <1569738255-3941-2-git-send-email-xingyu.chen@amlogic.com>
References: <1569738255-3941-1-git-send-email-xingyu.chen@amlogic.com> <1569738255-3941-2-git-send-email-xingyu.chen@amlogic.com>
Date:   Mon, 09 Dec 2019 13:52:14 -0800
Message-ID: <7hsgltrwtt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiangyu,

Xingyu Chen <xingyu.chen@amlogic.com> writes:

> Add the reset controller device of Meson-A1 SoC family
>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>

I just realized I missed the DT patch for this series.  Sorry about
that.  Generally it helps if you (re)send the DT patches separate from
the driver, and if if it's been a couple weeks and you haven't heard
from me, don't hesitate to ping me.

Queuing this up now, with Neils tag.  Sorry for the delay.

Kevin
