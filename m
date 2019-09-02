Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4F7C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A92215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcV4yk+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfIBJGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:06:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36372 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbfIBJGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:06:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id p13so13775869wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vk932Vys+CLH+PYMQTmQanJUcuUkUcICT2MwDqcBiS0=;
        b=bcV4yk+rItw9l/wFE0TxyB6pGn6AtTSM3Im/W7tDmwgW4iSgB900K3KyOPutdgN6zN
         7/WGFxLcArKGSKqo91waD5u2mSNV4DuJdI56yZy9qdlqsM90vtC+NKu4NXQv3zTFzBI7
         1H+blzZV7GnO/UVjFLteAdOH6YuoUm52fUY/aLX+ALMjEI5fjOWPQCtQSpesesY3dcFj
         P0xoYOhOj//gzXFkR+oCaoWBchYxqbCYHIgA7AmkwxqgXvHHgN9S66VtdJayU2kYWLTE
         X+vVmWuQfZl+6I5Smhm/BWG3++sYBZwFCXkChZP24bpfxB3mCwdEOST5raA9ICdtlg+e
         BBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vk932Vys+CLH+PYMQTmQanJUcuUkUcICT2MwDqcBiS0=;
        b=QtDHOTUu6gTp0wzvqFKUjk/pRBQYpFaQjYnxNQQKh7bmehDp8VShrpPFUbHeoOq6Eo
         wbDtWJ5yY560p7yKfrmd6NhvqnDejQo8QeuTQBbq6qM5HAcoJ35aYLaFxFHKjMtLB9uW
         5aXzmjOEUDqwJ080bj2+cNzio4krugf6gKsrilqL++ZXvGHYo7U+G+qsCFrkGlfX0GBr
         Gk877+AcaJD2+MPjNQKW88YKzaZYWkCnwtru71OEvBXXyhCAEwFDnqM2+HjYo6sp6fW4
         3QYUIW5HgKGxcn4xo0kcevYJPHVzf5OFjITT0HlL81IbXeZV6JBlNgHiFvA7dn5tK2Fr
         H18g==
X-Gm-Message-State: APjAAAWyPkMTBBghAq/rKaAj2sqzH1IVLvWw02V3dfMrVd6SWkZBb2Ay
        z1BYJpk67TTB8HTLQDb5DBc1FxI+bEPhJA==
X-Google-Smtp-Source: APXvYqx8mEwUka9hFdAHZ+mM1+uEWXF2IMYesgnoygQVOr1y5o+xLgB2s8OyHyPVf/1hH0+E4zsA1Q==
X-Received: by 2002:a1c:80ca:: with SMTP id b193mr563102wmd.171.1567415189114;
        Mon, 02 Sep 2019 02:06:29 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id e3sm9942559wrh.12.2019.09.02.02.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:06:28 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:06:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: htc-i2cpld: drop check because
 i2c_unregister_device() is NULL safe
Message-ID: <20190902090627.GD32232@dell>
References: <20190820153443.7812-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820153443.7812-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019, Wolfram Sang wrote:

> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Build tested only, buildbot is happy, too.
> 
> Please apply to your tree.
> 
>  drivers/mfd/htc-i2cpld.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
