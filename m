Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3688C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86A2206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="m9mHgQGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfH0Cnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 22:43:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42303 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfH0Cnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:43:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so15825322qkm.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 19:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyWVDk7bFBlJ/NL+rydCcVoJAqq5cfsq7OYmzr+x3iQ=;
        b=m9mHgQGpaNW+maa12v8RwzA/5XG6LlQ0VVl6UlyZz4RG61exO6Erx/vSUKtTy0Dttn
         6Vbr9AVwx5+QtvHekx96s7VgF5kyhWDaRnWRuJt4Sg4R+nnxkTp7R7wWkqxI3K3sFJ1Z
         c5rEedG5fOxGFsQtFif0MZzJKu1L2wH28dq47rvB+8tvAdKpWICZHTXBiY+7IFoZ50bN
         SZAmB3kASHWSPFJ50I71fjNISlR9EVU6p5xs/n46Z8jdHpyRohHewDxWSNrK4op4s/so
         f66TeRB3QNjMS/fr0WxXt8zicX+P9Q9x6Kdxs+/KBN17P4fBM0YsGME8XHfqVOGIjl+T
         LrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyWVDk7bFBlJ/NL+rydCcVoJAqq5cfsq7OYmzr+x3iQ=;
        b=sW8DMSL/dDLNfjP2ya8r++xGTWifylOUOj5J4/iAKLVrJYP6+mBqfNyAW1rQyj+jo9
         lDw9Ein7Y5WhAjyphFBFFx6rrluKyrT4XWVtECU68HK5o+pZcwC594PDuZbtgEPlgHDZ
         21ww1w65648ywpL3+G2iVPxiVBC66PSnID0rLzhE09t75DvEffQAJQCbKwaG/WwnsP6X
         Sa3jZT4udH4zVhmmgz9zbK00nXYdkKGXFSvXwgNH03qywTveS7fzt5NWv3FHzVvvAdmC
         RIYxzc3FxZCs1JWj7CUkKB+jUzwm7y//6glr569gChnjgIUCjRLhoF6LlIRsjRbDGOGk
         XwsA==
X-Gm-Message-State: APjAAAWKSVp5VzZcz9r1mLc4S7z9mtmipKZMF4N4ZPP3KQxg18e14pAS
        e3scRKYHfBZsUMSSl/xwdG5AENXT4f/dIaCIcBgB1w==
X-Google-Smtp-Source: APXvYqyPwg0XQDxbbABhyaEAR2ykYQIPflmmWURv2tGLureTrKZCN2gKDtgubaZOm7797x6dUFdLUak1raAhC0SSmhA=
X-Received: by 2002:a37:4ed3:: with SMTP id c202mr19634969qkb.457.1566873829431;
 Mon, 26 Aug 2019 19:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190826153900.25969-1-katsuhiro@katsuster.net> <20190826153900.25969-2-katsuhiro@katsuster.net>
In-Reply-To: <20190826153900.25969-2-katsuhiro@katsuster.net>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 27 Aug 2019 10:43:38 +0800
Message-ID: <CAD8Lp45zqUsTJKV4QCF59AkDX4qh3HZ7=Ympxm2HD7VV0WCLrA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: es8316: fix inverted L/R of headphone mixer volume
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 11:39 PM Katsuhiro Suzuki
<katsuhiro@katsuster.net> wrote:
>
> This patch fixes inverted Left-Right channel of headphone mixer
> volume by wrong shift_left, shift_right values.
>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

Agrees with the spec

Reviewed-by: Daniel Drake <drake@endlessm.com>
