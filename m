Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E097C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0C520870
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxxwctcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfHULaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:30:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35560 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfHULaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:30:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so1808155lje.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iocEYKLSGWdmyhLV5GfmwPkdD4DTVk93KSQ5LAsjVRM=;
        b=AxxwctcXraRUA+1mPIGQABySnPPa29K6Qmwkmm4KVbIC1k6t2rEfks54lXwdup6BP0
         QihAlbMoqgt12sgjof/KJuP/AaWBSxalFDuFmA+r4O20GxSKr0GOVux9++QoEM5ORK/g
         icK0VCw4mxSIgzCVAJuG/CSnePPeg1XEILHEV2k6l67OlmxJZd8lP5xGt+GTk224/QMu
         M8oIfHUjQvBecP6evqivTjyncDJIitRAWsKj8G627fKM0LmAdWLUUo6YeS+SVgY7Wf5L
         d7lSJ9Jg7qSHEJBRhMnKQ0Tg4bIwdhssvsAfxQdmrX0djfaGP0F9ZCu8y59ex74LvS3Z
         FOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iocEYKLSGWdmyhLV5GfmwPkdD4DTVk93KSQ5LAsjVRM=;
        b=CEVOMt4e09O8902ffVLQyTUWNftll7B5sie8KcE502iEgDgR3D8y4y6bhFZ5wc8RvR
         DX0RseeK6TQg5BKC/7HnNgetCRf/4dnoV4W7kb8zidUC0ptCDabF/ab5b963QRgmXLJe
         qST56s5N5/9UGxNZEU5OGx87uhNCxVxxH2H7nMIhn1y8KFK5vpwHCZEfI0wNjxjoTaJ9
         E4pitDe6rZGa3QUhA61ckwy28aclM05l4SLWUGyrl1gCUXh6mdCMHSGsZGIBqpSHgDsv
         6jrelHXi3iNht7ljNilsxFgShwNay6dSCAv7fq6jpE4ZvmA4YiYa1nQnYJHkUhWy7hAE
         tyfg==
X-Gm-Message-State: APjAAAVVJ3/KUwVTickNeZ/3xI4BG7lMnuoQkhg7nAg5Wuotc+kUMXta
        WJscVS8ppW8hn9uVtjXOEH1hqyCkVR5TOZYN7kTHRg==
X-Google-Smtp-Source: APXvYqzvaYkSz0pQqk7ek+E9qsbRhqFPu4pzzy/NOU1ZSrZVzPZaMPE9XcJj+xWG77oABsOjckbOES9DiVSz9GELCtg=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr13642549ljc.28.1566387017636;
 Wed, 21 Aug 2019 04:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190821160335.09071cb5@canb.auug.org.au> <86zhk3lyw4.wl-marc.zyngier@arm.com>
In-Reply-To: <86zhk3lyw4.wl-marc.zyngier@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Aug 2019 13:30:06 +0200
Message-ID: <CACRpkdbAR5JTcEmatQ1F0=fRWm4=1jUqaehA=vFtc8Y5=5V-VA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio tree with the irqchip tree
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 10:13 AM Marc Zyngier <marc.zyngier@arm.com> wrote:

> Linus: do you want to take this patch (daa19fe5b082) through your tree
> instead in order to avoid the conflict when this hit the other Linus?
> It shouldn't create any havoc...

Is it completely independent from the rest? Then I will pick it
so we get less fuzz.

Yours,
Linus Walleij
