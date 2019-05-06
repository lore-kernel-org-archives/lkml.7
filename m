Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C0CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B092620830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKQMEJ8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfEFHJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:09:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33191 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfEFHJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:09:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so10142598ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRT2BpDptSkxB+ApVYaSpu4TH0+tPZF2HuarptiGZHE=;
        b=oKQMEJ8hH/CtsoFlFjBJEHKYnOh4w/g2pDH66nAnJWQ20Bk5RpeuVDK4fYGsd80t9p
         byiDPusCcIFnWgH5BXvaRXanBTBFCJXeidbHDr5G45NiIafotdeIuOz2VZykaC5H5Mp7
         Nt9PVf7G+4Swhgyxg4QvbTm2YBJcbUPRdTbUp1SwOlewc1CYb/GLrGuOb6cmQc0yb4a/
         BrP3pyrvcYHSqZNzskcaDH54+p+5J+0CzC6yNY0DcmV45l1J+6m8LmA4v53vZvbhzZ7B
         lbTe0TnINsOdajsQO3lUCoKbIXFXHwOa3cxXBTBTMW4Y8TZWgRbWv/7E2GDTiCcMxUBR
         ar8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRT2BpDptSkxB+ApVYaSpu4TH0+tPZF2HuarptiGZHE=;
        b=LbpTK7M4h32lo8LLtbuGOGZPexxnm270XBa5K0ZPi7kKG2tWE1J0wPvP4FOvy9672a
         RvzmYj2KkXwRMLGrEa0Rq5waavcQcvTves/GVx/dgGY2/ZjcZfT5eQQdxzSa2Mt/zo0Z
         yktgn4ybffIn4Q736RScEvordeqHF+xU2k9L7JlbduFugBGPeomn+VVheeLdNYoUDPcU
         Lc1CNu8LWiYSCQkBfRhRvkCdzHyP+I0WBeQl1mjVwE0z6MgiyiSiJEq2y8M4aU9pWk/X
         PrKPEICup6Rh8bc2ZUR6sb4QpFXeJVSjzBNkA9lK/hQYlgsEnThRJQCMJ1HduZ1/P1tS
         SQUw==
X-Gm-Message-State: APjAAAWMKiDSkxdbCOFuh4CHca6kRMfnWoOPQMdk0KqZiTwRtVdspnWM
        yTeJU1/M2uJeYKTO4WeZZFSVahoSFQlr+Uo/rB5dIMXK
X-Google-Smtp-Source: APXvYqzoDokcVuvzHXFld3YjPVy3p1eBu2FljGmJcbGtSdNiGf7iikESKDnQSx54yh3i2/GC34Hlw9JUZsHZhhRerZE=
X-Received: by 2002:a2e:8e93:: with SMTP id z19mr9439736ljk.159.1557126573442;
 Mon, 06 May 2019 00:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190505130413.32253-1-masneyb@onstation.org> <20190505130413.32253-7-masneyb@onstation.org>
In-Reply-To: <20190505130413.32253-7-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 May 2019 09:09:21 +0200
Message-ID: <CACRpkdZeMcn-kJqtaZUmfXeibh3SmyKDMUMZt-gLSzEDhGcdCA@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] ARM: dts: qcom: msm8974-hammerhead: add support
 for display
To:     Brian Masney <masneyb@onstation.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 5, 2019 at 3:04 PM Brian Masney <masneyb@onstation.org> wrote:

> Add initial support for the display found on the LG Nexus 5 (hammerhead)
> phone.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
