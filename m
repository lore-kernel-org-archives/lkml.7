Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BD1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B436020856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X77JQu2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439573AbfJXMEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:04:47 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38659 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438979AbfJXMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:04:47 -0400
Received: by mail-vs1-f65.google.com with SMTP id b123so16015760vsb.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sK0pWvTCky33QCYiFA2nfCFulsVEzPP8ouWQMoNEYbQ=;
        b=X77JQu2M74j32zRnCvWFx0hX8hm5QE9BLD7tdFlihPqR5QsbcspBUaPz9+ocTDD3Xk
         CaMVHrQioNbYE5wdY85fJgXy51TlkFVvpkjMkS0J2osnWORTeIKW4AHxz1wLR+lqiYbr
         2qWoPxAm9njrO/Se9XRbowj8pJ0UjCx0gmpmyS5rq3pAiyKm66fDpurQV1l8Q/XOq7CE
         gMEsEgIe33ihcHLvqE3a4UCQk0UodbnovvCttQb6FlDk8QzrESZTd3cHxmfMl7ZlhBmm
         ZStu/9Y36ikZ0TlP2kr3enmD087wd1WAokylvvKRtK8acsp/kLwLQ2KUHgTopIhDtv7k
         qI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sK0pWvTCky33QCYiFA2nfCFulsVEzPP8ouWQMoNEYbQ=;
        b=nlue5WLbmkuufoSNGtyTu/S1VoJem3NrEHQ7kGMXB0k0YBnq0iAOcJ2vm4DrTyZA5P
         qRoMazhA16pD4ho3z0WwA3mSi7qmNnbD0d9UxEYunAOHauXdBI8RSwjnuHJXsorwjFON
         48iXO9+iScxlm0BkM6MhIpLek1b8tyaSJgsN3sNaukkg7UtEaG3PmLPRoBHmnVXvRDD+
         JWJ6NjwOIicgUGVeyv963YoPv5FVObzAH303UzR//VFUk5HpPxFVsSn/qORR/QukItbg
         2sZUo+0dh/baTrEaPGcelnwNxtgCbDho4+CKDb7uA+k9bO9kycqr+pBPx956rU05CAgX
         Oczg==
X-Gm-Message-State: APjAAAWZVboHl+E3IEdXgiqPCOJohNVf0SotzPsBreQYOS3B8cao9fNc
        7SGuLILbzVq+8jibEq1dllcwGOc7oDXhIFEKFhmykg==
X-Google-Smtp-Source: APXvYqzfB6++WoSRmQXkMK1uRnAw/CGlvAz3yUOrxP/5OG3nCHbkCQk9VVZg71JFiCROWtuW1HxxnC7HzkTd4MEDx2s=
X-Received: by 2002:a67:fe42:: with SMTP id m2mr8848686vsr.67.1571918684479;
 Thu, 24 Oct 2019 05:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191016141217.21520-1-yuehaibing@huawei.com>
In-Reply-To: <20191016141217.21520-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Oct 2019 14:04:33 +0200
Message-ID: <CACRpkdYhVExyh2L9A7Fm7y7khCV9wrneKhtMsntWL5DFAaGrug@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: mvebu: use devm_platform_ioremap_resource()
 to simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 4:13 PM YueHaibing <yuehaibing@huawei.com> wrote:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

Yours,
Linus Walleij
