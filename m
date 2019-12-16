Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC9C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FCE2465E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8lbUXIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLPVHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:07:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37024 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLPVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:07:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id h19so358218oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xf+PaVfK+fxzSPWZXkO3BuD6UEDzGPf8/U5sJKPnSqc=;
        b=j8lbUXIylU6AeuPYIm+5uxBq5U6RJpNmZZMLo5ctDECJri01nRMDpJ5qRfxwwPLKRh
         oumhJo/nkLVN3J+uYBGhFb7psH4p92UqoS8mv3UClvK2Rj8Hfce7HwlbKt3mkFhRdAkP
         TnIu+WS+NFDon5qVreiiJZ9yN5AOPtE73Nw0iuHl+i9MUoZYD5COw6VuUSjQ31RCI8BC
         FrP54MUwtkLp1q8MMg6IunDKh79oT6fC7Af9xdCCICHERafZPC+KyUgtaj6kxewFTu4n
         /mDrkysePXG5mRQudXLKdRO6CdfBN6Fb/JcCBLQ58167AzGCHTZf2a5HXnOT/ZA3qYSe
         7LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xf+PaVfK+fxzSPWZXkO3BuD6UEDzGPf8/U5sJKPnSqc=;
        b=b0LC3zVkEJCP1Paakyn7RcDVkhOX+mame5v1Z0UYtnujPTJgBnnuWaUhr79jyHJ+TR
         JUS+h5K+NOxTEosj/s3oi+8iFZTJ+iff491bDYLMfrA/BzmOI6wKHaqcGieczuF215Da
         6vtnq8vyYaOVNbBMfmAM8TeKCDg01+XoP8KGWB1kdw5nQigyfdDLC1rxK3gYyAW4puZO
         7nFpeC5XHw9LWU5rWNaKh6F8zX/Qv0YWoie6ktV+WodZH9YZVQ6jrRSHYcfoJOgMkcFJ
         2Y+vb3BbmZ3HDR93vbk2paEWNuC5ZFSXPTsFfn4IMFzEffCbnGEUk6SM14+zs2gsqjIa
         1gsQ==
X-Gm-Message-State: APjAAAXsfxwJv42tHZMGYmYWS8GP5vbFqOe9h0rTVh/gDIxub4fvsk2s
        wg7T2OBh1URegqjy/cUEp4i6tjHvUXwCtmiACjP+/Q==
X-Google-Smtp-Source: APXvYqzWzDWclkNVDspqgaIn1PCLoKAhYWLJAEqeDwyrdeQGyKLOwB+UvmXjFNWeRKfvZFp0VvkubgYEQrTULqVw92E=
X-Received: by 2002:aca:c551:: with SMTP id v78mr600481oif.161.1576530457340;
 Mon, 16 Dec 2019 13:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20191216161059.269492-1-colin.king@canonical.com>
In-Reply-To: <20191216161059.269492-1-colin.king@canonical.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 16 Dec 2019 13:07:26 -0800
Message-ID: <CALAqxLVsFr6LLKvz9a5CRdddqhmMXUwKmfwqf3LRBbhksk5gHg@mail.gmail.com>
Subject: Re: [PATCH][next] dma-buf: fix resource leak on -ENOTTY error return path
To:     Colin King <colin.king@canonical.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Sandeep Patil <sspatil@android.com>,
        linux-media@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 8:11 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The -ENOTTY error return path does not free the allocated
> kdata as it returns directly. Fix this by returning via the
> error handling label err.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: c02a81fba74f ("dma-buf: Add dma-buf heaps framework")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: John Stultz <john.stultz@linaro.org>

Thanks so much for submitting this!

Sumit, do you mind queueing this up for drm-misc-next?

thanks
-john
