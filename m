Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67ACC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02F0206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x29srUWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfHPWbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:31:05 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34229 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfHPWbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:31:04 -0400
Received: by mail-lf1-f53.google.com with SMTP id b29so5086678lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOAG1iyO9q8mXH7l98FnBfv0cB9D5+pt1rPlPDDYQ/g=;
        b=x29srUWlOZcwdfQ9uezW6kduYfYb5FEv4zPBFWvTDIvlEb/X6OzuEqQA/UZIElT7RN
         u5v4z9fOajaYrEuSWCsZQW6LZYmH+bmiZEnXaAIdg7Ax3JxbEJyz2VXGjiWOcwU5heSs
         U9Vow1e1lA058BeZuP59CctI9MCF5pSMgfSOyXvz+ey5XCv80Z+DKpOa0M+RaKYxHAHZ
         hN5rYsfzNW1NtTY57nA6fnynIjJNLu8i07poklUuwo3nBXNmrtzZ8vQARJinA8sANdv/
         gXDcYyr0A/jggEP3dgaaMPewyndl6ECzjQQIBYybfqd+28cSFSYsNKsBKD8x7LSJzCvn
         Au7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOAG1iyO9q8mXH7l98FnBfv0cB9D5+pt1rPlPDDYQ/g=;
        b=mZYMjXzuxhr4QvrXtO7Ssy5/JEKCXysAk128Fb0Ux48zoMF0fTkCbLzuJ/6CQbhwr8
         x+p0+xRto6TyTOgkxQRG/fF0mcJnkRLLQySTwdiDH42guZMPfb+qYPHP3lY/npbfPJvz
         vv+J5L1jSP6nhX0BgAxtB+YiTXp7ivpDExondHk3M0DXgFb2h/1VBsUgZ1+Buf166v3R
         LRZCzJQk9psR9biivrxFidgwZKZyxWmAxyt76KBDCbmPWw2DpgxJT9hE/S6j3VbW9cfV
         uiv4a0CBRoeL4H1PxKPkdTE/a3W+aHQowaSrBE/mi1WIFl1ZKh+Ve2TQOa/leQVgsnWm
         8f9g==
X-Gm-Message-State: APjAAAUdbD8g/FaOlwFZ/5hH81v0avvE1e/DxHBI3eMsuiBexH/6xtYr
        InP/xGNbRqqlTNExV9c62U66Oik7WKfEa6DSe+l2EM7fN64=
X-Google-Smtp-Source: APXvYqyYgwWlAMLO7wFD0iWcM2FH/jVFhMIZfxK345mH2kQ1QgmNqa/THpHjquE1A49XorOMdZXEQuYYQ14uztx3Azo=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr6561131lfp.61.1565994661896;
 Fri, 16 Aug 2019 15:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190816165607.3b896463@canb.auug.org.au>
In-Reply-To: <20190816165607.3b896463@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 17 Aug 2019 00:30:50 +0200
Message-ID: <CACRpkdbd=YDpXwozA_AUUmY-ut5yh9+ziiPHLj67fT-bs8Pq_A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the gpio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thierry Reding <treding@nvidia.com>,
        Brian Masney <masneyb@onstation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 8:56 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>
>   include/linux/gpio/driver.h
>
> between commit:
>
>   fdd61a013a24 ("gpio: Add support for hierarchical IRQ domains")
>
> from the gpio tree and commit:
>
>   9091373ab7ea ("gpio: remove less important #ifdef around declarations")
>
> from the gpio-brgl tree.

OK Bartosz can you send me a pull request for your tree so we can
sync them up?

Yours,
Linus Walleij
