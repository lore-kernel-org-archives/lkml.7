Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3949218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cigG1jTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfDWVa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:30:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34044 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:30:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id h5so12894887lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gj/C1n+4JzJjjhUoe8msJVAVKtyw85XXivazIssjzrg=;
        b=cigG1jTIozfeAIS/XLpR6jV/YEmZREqI1ziiBnf1BbfcpDoj3jhUEXe15oKYKIuGnE
         jBPvCcMGDw2U+nN6GPExSYnVApWcT64Iy7swJUmzNCeKgR7uVrxmYWoz2erEJ3jiVbab
         XF0N53UmdOg8uJOYvVxhhV+od04HlT+3VUatNKjeF5yfRDx5dF0Cu9pZoaasj4dN7h9t
         5IQ01ja27mYBXWbhP1in5Ht5RU+YCYbNdzQ+ND5CL94NqDSGoeqOSIWpOK8uy6z0AUA4
         qN/IUMWHEMPBk0a4iQaVub+N+1TalO9A71MXI0sTN0Zoq/reYsHlOImQHKu7MGe0C4i4
         R65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gj/C1n+4JzJjjhUoe8msJVAVKtyw85XXivazIssjzrg=;
        b=r1hwGYaV9WBsa46F1CL/yl17y3bGkRzTeVo+3LzDhrxs/6+3C9MbKuV5q8rV7gOZAF
         daM4xp3yMAGTzuUf7NJCSCrqPDTSD60IgnrmqTsTyPXzPb0c4YNgzM6dW8xgnGk9buh3
         ERFFnA9wRBlQol67trpXu7k3LfXAdFJNOT5obbdaZSgNG9Bon4WIUBEOZC8WulFooEO6
         fAFN0A1stD9NQUdmVuRE7kyZJQ3hQsRRDBpUP1Qd0g/tJ87/kMKG6Y0YjYNg69Lmciep
         udZMIoMd+x37ZBRZ/bQZQzRd7Ds0ogMriBxgUf6e95Pufeb4M6F4FsDjx6IT691NsUik
         47/A==
X-Gm-Message-State: APjAAAVeQs8lEmpU3TIebhdheD+j+uPG1j6PZafxegC4svRePaw1oIGh
        u9S0rH8i6x/j7g+U7Bh0KTF7iy8nx9ttXD/KxOEwzLAA
X-Google-Smtp-Source: APXvYqw5sqlx6rYco2PwRId3MXLuHuEkR0+CdFN5dPdrXDVjgtRlcAiFlNcLVn70F9u+GsoI/xvF4Hpk9DZI+i3WRqQ=
X-Received: by 2002:ac2:4647:: with SMTP id s7mr14850759lfo.168.1556055055246;
 Tue, 23 Apr 2019 14:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555938375.git.mchehab+samsung@kernel.org> <03cdacc3db76c5ff984c1507ea6434650d36d822.1555938376.git.mchehab+samsung@kernel.org>
In-Reply-To: <03cdacc3db76c5ff984c1507ea6434650d36d822.1555938376.git.mchehab+samsung@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 23:30:43 +0200
Message-ID: <CACRpkdY_OHTU6dN-2BXYhPYyAVW62nSzqfNx66bAB++=epGMbg@mail.gmail.com>
Subject: Re: [PATCH v2 15/79] docs: gpio: convert docs to ReST and rename to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 3:28 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:

> The API described at sysfs.txt is deprecated.
>
> Still, as it is still part of the Kernel (and will likely be
> there for some time, as we don't simply remove APIs). So,
> it makes sense to keep it there.
>
> The conversion of this file is trivial:
>   - add blank lines and identation in order to identify paragraphs;
>   - mark a literal block as such.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Patch applied to the GPIO tree.

Yours,
Linus Walleij
