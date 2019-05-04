Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D869C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD82206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EagF2etD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfEDL71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 07:59:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42032 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfEDL70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 07:59:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id y10so832728lji.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BX39v3pu7ldHFdjAOxh6Msu2ZnLD9jNF7ehK/cIJkM=;
        b=EagF2etDmy1Qb4QiyLGp5kmZcDoAiDccs87hKdobjUQFqxAEHSWsrdE9zjQ/1j2byu
         4JMhWitx1FQZMkGaU4947wmJouyju9O05m4yWtknxQWQXpxFzy8+V9ffhGLY1Hg70RTt
         QuMpT0qPWThcFKNEx5GXw/749wn3/5+WAqWnIQpPHTmKzL6kq/ZuG+nSQK1Z8mJIP4oW
         uNVu22mxIVOpwIIWlhRvW8mQk+C0lsyr5uTuniknleB8sMrUcjxKiP1KgTOdzPhrCbU7
         V8TR/nglDjaq/WwlR5d8UvRIkQ/i4R9obleYo3vc/Nwh7fbestsbsXu6IuIWohAyAiIY
         cXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BX39v3pu7ldHFdjAOxh6Msu2ZnLD9jNF7ehK/cIJkM=;
        b=PKOKORTTtMfUbrC+p2C/swZOQ9+JjbMIHK/oVryLMchhjjbZOQan/iQMdWSVQUrg0I
         GtANAorARi7f22c8cyAhnwTa2VUbnxjTbrCe6PG336e4oaS5q5oN7z27wkS0Mdp+6Wqv
         p5y0fZZVDWuoM+bGWoqnMKHhPeBTrlICU04KVDhZeV2eDfKHfxWlP1fb+CZmijYhMT6+
         IsU7imDpwnxjcWxkRV72qbyvoUooUWv0l7XUv2bnSiZ2V+0HjsYMlcmYXZHkDNqEbE1U
         pEBSZapayENdo/ESOzDT/urOYUmMymeC/xQbLmwR3VqhxndlCCq7bhfXRFukS4toy1nJ
         UazA==
X-Gm-Message-State: APjAAAU3IVg1MZ2cPf0q56WRrc1H9bOSL7Tufsmo3PI6FI9Ojmj9ERWC
        kz+EoJXyjtSe24nkugo+GVhXlyUz9S+fPYw6xjB7TYuE2mU=
X-Google-Smtp-Source: APXvYqwBbsY6IMHgupX97VlIU9A0jH3IvIDBH7G1IoxqWmOmQyFNPYt9uxWoihm/pbMWCpEUH68oVO/6dIZZgWpK6jo=
X-Received: by 2002:a2e:834d:: with SMTP id l13mr8308279ljh.97.1556971164572;
 Sat, 04 May 2019 04:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190503131651.GC1236@mwanda>
In-Reply-To: <20190503131651.GC1236@mwanda>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 May 2019 13:59:13 +0200
Message-ID: <CACRpkdajJgP6zAYOw3zRVjtPj-dEoA0ZtrMerPMkxW046aEQ7w@mail.gmail.com>
Subject: Re: [PATCH] soc: ixp4xx: qmgr: Fix an NULL vs IS_ERR() check in probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Krzysztof Halasa <khalasa@piap.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 3:17 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The devm_ioremap_resource() function doesn't retunr NULL, it returns
> error pointers.
>
> Fixes: ecc133c6da60 ("soc: ixp4xx: qmgr: Pass resources")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch! Patch applied.

I will make sure this fix lands in ARM SoC for v5.2.

Yours,
Linus Walleij
