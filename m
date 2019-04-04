Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F7AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C590D206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6nL1ZQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfDDQup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:50:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41437 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfDDQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:50:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so2697381lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o10Sk2tktHmS4tpuqlk6YJF06nxzTJAdjjrZAuXQlUM=;
        b=A6nL1ZQQJmlWyp/Yash6sBV6U2FvPggcyy5fTmt7Iukhk1Z3AezJtWCpvtCz0767ei
         7ASlw1LlOf9gwOkKF5ILuKw33n9n6o2z/hb29dLCVRU5GByz1VFZjX7UI4NtNr+XKPtu
         jCgR2CfloGOvJIvID3wVS742WPV7ortRQFjCN2Dxrc3354W3GBDiRSs8NairoLuVSUl7
         P+9c6ok6gA/gFuTjYri+EGutf7TAZf5TEniGqhMntc33Mya1XQMPbQ3BqumE4Wfph1vj
         M38kn+mIX+P2+dETcb4nB+hTOzQTmYhPqHuofMJrCz2OcqOOTirjJJqTQHLQeORO1Htl
         zt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o10Sk2tktHmS4tpuqlk6YJF06nxzTJAdjjrZAuXQlUM=;
        b=kDZQlxA2EJvNdBDvxtlOujn8QLnrYmdF0et7NQMys+cVUOX51WtOXRzv/YQQoFPSvo
         AaQpbrXnjrs8ROLRjX/KsG9OpmNLvtVD8oBGR1qAR5TuiU4SlLhdm5I82AdHAC8yD2mw
         tvghCKbI+AE5fOj80Mno9Db3mKLTJYI7jY5yVHvBiP/vlRToudol+Nx+R3peNijqZ0/T
         DotoUgykY9M42jwB0R7oLCRszgTr23QmKcCIAnoajKKGmIwmF1cuTzWgVJQ2ie9caCjC
         rIST516uLTeI6k1Y9x57szPlsq8J5XBnfGjdx6Kys+tkGeDiYtnjGIFX6XCVnLN/vyXG
         pGVw==
X-Gm-Message-State: APjAAAXyszmav44Ovo0rEL58+zP3N/ui9fYNae7I7jRZOOg1WnlUJSKF
        1u5i9Ux19xd79wZg0Oaw52WNREGr2bt3DPL5PutgPQ==
X-Google-Smtp-Source: APXvYqz88BsGrP6DXSDEu+uMpxFBmSInxOw7o5NhMoo9R15tir6y3ZIzazcfy0ZC8AxqopQoGXHI6Ozeeu5948dHEGA=
X-Received: by 2002:a2e:9a46:: with SMTP id k6mr4019248ljj.119.1554396643180;
 Thu, 04 Apr 2019 09:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190401090942.12408-1-jank@cadence.com>
In-Reply-To: <20190401090942.12408-1-jank@cadence.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 23:50:31 +0700
Message-ID: <CACRpkdbB16Rq2zok70QDUsNst-iZYFFrRy=cv+38fhz2+Vjbpw@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpio: mmio: Fix bgpio_get_set & bgpio_get_set_multiple
To:     Jan Kotas <jank@cadence.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 4:10 PM Jan Kotas <jank@cadence.com> wrote:

> During my regression testing I noticed the cadence GPIO driver
> fails on the latest gpio for-next tree.
>
> I think the reason is this patch:
> commit 96cd559817f2 ("Merge branch 'devel' into for-next")
>
> Here is a part of the test log:
>
> Loopback 8 -> 24
> TESTING: gpio: 488: output direction PASSED
> TESTING: gpio: 504: input direction PASSED
> TESTING: gpio: 488: 0 PASSED
> TESTING: gpio: 488 -> 504: 0 PASSED
> TESTING: gpio: 488: 1 FAILED
> TESTING: gpio: 488 -> 504: 1 FAILED
> TESTING: gpio: 488: 0 PASSED
> TESTING: gpio: 488 -> 504: 0 PASSED
>
> It looks like the issue is that gc->bgpio_dir has changed its meaning.
> It used to be set to the register value (so it was being inverted).
>
> Now it's always set to 1 for output and 0 for input.
> However the bgpio_get_set functions were not updated.
> So they invert the bit again, which means a wrong register
> is being accessed.
>
> This patch fixes that by removing the unnecessary inversion.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>

Patch applied!

Yours,
Linus Walleij
