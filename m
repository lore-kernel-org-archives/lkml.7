Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5101C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7BB2089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F9MUeCgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfGCBDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:03:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42913 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfGCBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:03:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id s184so592941oie.9;
        Tue, 02 Jul 2019 18:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svNvFatzWg+J+IzhDu/8UapYNg/XQoHt/D9xO5S8sAU=;
        b=F9MUeCgD5cE83rQOPzxx5wJd9MM4XsOaW7CIpa4R+sQxmLnclcmJO63t/siBAt1bnG
         dIq1jh2p3nvQRTk0klvt+b+dpokQiEvBU/mW8Tz0/iJhNbNb5VS4lIjToMtRZI/IEpCl
         witmuIYcjSU0uTUAs/gfjuL22B7GZKSiIWHLpET9fUaEvmReFRIc7y+jZUIUkl+KGFez
         VFO1+gJp2ROeOhbIcjhj8mdVRjMS938Wbz4n+9d06KWPmZEzJO02wIgDirjXj7o/yGus
         lD5EYU0K+0/34oYdedokRlbfGcTNxqXAcEJ1UY5wCLwjl9Fy4FWiYGq3r2u+DSd1+3Bw
         D33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svNvFatzWg+J+IzhDu/8UapYNg/XQoHt/D9xO5S8sAU=;
        b=nJGEbbgRTOYW5hLTq2DfCBAHg5LPN+oVHYpevRs+QQbWIS9YI6BV7Oh0FFLG+O82Ct
         S1ny20h/FwevO944VTf+mK2v2BLmfcys+CXHV5DByGoOS+RTELjSp3F3oZ+UwdosOaOD
         4eM6s/KvnbGU0WvbMtVJsIGxaNTtx6FmZSwAx+H0ZWLx5y9sB2smT0fPlMwNDR/lP7Ki
         nuTub8auatGMYzhU8JeAbdUymGCS11ARdmf3lPbSa+RBSmosN0eyEZl59EZGBT7XiqEK
         emwEFj5kUCVLY6QB10bRz0wNdLB0hHClYU8oZuoTqb3i4iflMZ2PbQ+R81P7B1PAuOYp
         2p6A==
X-Gm-Message-State: APjAAAVJiB3CELxs5rPB9F/l9UVKhLTnpkK+kKB4mCb3+/R95+BKmUBL
        mR0/gVNMP5HBOQLMiyshV/sFS8SfnkWjI8kTv+lB2SSp
X-Google-Smtp-Source: APXvYqynGDp6RgAE+20EuhfnSaAl8FY4WjfZlQXJcX2FtOElvoAuFudGEiRTQUO42XE3uT6QyB6b3k1bfYY3Tam0nmc=
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr1458640oic.47.1562109110323;
 Tue, 02 Jul 2019 16:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190701091258.3870-1-narmstrong@baylibre.com> <20190701091258.3870-11-narmstrong@baylibre.com>
In-Reply-To: <20190701091258.3870-11-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 01:11:39 +0200
Message-ID: <CAFBinCAJPQ-gu20UoJEGx+fx6TZ1Eezh4sA+24mppffH5Ft25A@mail.gmail.com>
Subject: Re: [RFC/RFT v3 10/14] arm64: dts: meson-g12-common: add pwm_a on
 GPIOE_2 pinmux
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 11:13 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the ao_pinctrl subnode for the pwm_a function on GPIOE_2.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
