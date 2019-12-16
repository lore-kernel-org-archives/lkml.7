Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BEB20684
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHE/FqAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLPKUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:20:45 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41349 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfLPKUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:20:45 -0500
Received: by mail-ua1-f68.google.com with SMTP id f7so1869828uaa.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkbL1d/SzqUihRGV9EGxMppkoVLFMzfPIRPZl16fK20=;
        b=tHE/FqAndfXj+pF3rpKcyZB3P2mC/ivGu+RuNn7h6U8fH6CwMbbwsVUcsp/rTQHd7w
         SnHZW/qVxTnvRge2orkhtQ9Xsf73XYevjXfqvfdKDkG6TobwnqhLBRLLAqcTfYe0WEYP
         TemamdhsBonUMSlcJPhpPbtBP1PxXnbcO6gUB921WNamWplR0wZicOySkVBqhLyXZ1Yo
         5/Wicv3VUbruyGwEo/ySRP7hgpg/Rx9tzYgwHjF/x5Tt0Rb19SDBDqLbx7dadCPp/2w3
         55sfvzdVwUdtHbd82oEpCim18++9O0mztUBgkt/XgEzxg9/Ghg+3d2LhqjyhP+4MBMHG
         ziSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkbL1d/SzqUihRGV9EGxMppkoVLFMzfPIRPZl16fK20=;
        b=q9DZ4hHUn4jmoCxhobpsRdpoC6+nL2CddBC2SdBGEJQhpIOSi+LutLsQ0fRFfk7fQw
         93pzRf8Rzs6M5j95890AZb9EKrGvX7Ofs6qUwYyuDVxCGC6aRW77sIOqXqLgGa6cuC8u
         3bd4k3mMaRHyeAdySk1bXbjPIK4PbIBiRQ7VVHbArWP12he+w83tRim/lITDSSAvgM2U
         9Lw+B5hCJq+/d6NK6YP0A6fCd2Iw+SQsqb2QROj3MnIsY+05DO/iBJBk/znEyYgogu1l
         BEBWndyGBnZJOW6g/c1bc2ciUmeZKfZ23QpKFgKtvFYCV2HC3tXv/L+ylsgsE+ZfyTqW
         dJww==
X-Gm-Message-State: APjAAAXhYxi7uJ9qCDp6VhP+IDXlAKXsuGwZhhm4GHm+OSZvOHwFtYXw
        ImAUM4DE5DjR6S4R5UoI+EnHo5CPg1ltDco7ZQeY3w==
X-Google-Smtp-Source: APXvYqytRcaEhtLm4UxsiP0XcQ5WA/lllFA43ewjb5KkmW6LveWszgSmmf6NQVq50n36TRexdsgdRA2S2NxjbZ7+23A=
X-Received: by 2002:ab0:7219:: with SMTP id u25mr23212467uao.10.1576491644556;
 Mon, 16 Dec 2019 02:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20191215011045.15453-1-navid.emamdoost@gmail.com>
In-Reply-To: <20191215011045.15453-1-navid.emamdoost@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 11:20:33 +0100
Message-ID: <CACRpkdYZDj+rO0WL3wFtVM0Kosx5LWrKDLkUvmqV4EVXtSeO-w@mail.gmail.com>
Subject: Re: [PATCH] net: gemini: Fix memory leak in gmac_setup_txqs
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        emamd001@umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 2:11 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:

> In the implementation of gmac_setup_txqs() the allocated desc_ring is
> leaked if TX queue base is not aligned. Release it via
> dma_free_coherent.
>
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Looks correct to me,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
