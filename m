Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F4CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAC12053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STLGVkk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfEFOu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:50:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38756 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEFOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:50:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id a59so6492682pla.5;
        Mon, 06 May 2019 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yft7gFfFtwWc/a4cPI5/imyDvpQ6B50i8MJ8FHJY3Qs=;
        b=STLGVkk9q3xG5XzEWIxDxCWzi7LbMYZk/zsgVLMCL4xGBxj0aS+nJAMPhJvVrh8ZZ5
         tyWv/Cdqs+zOFxlkBgEgmvES139xCjiWTbeLWMB3i50jOyxm88aFFEbIjm0HVnFlaXhr
         Bz7CDYehYQXVOmPoOXvPc+bfDchq+uKGmgI70iI3yk2t+/ElBy27YV3T8059gbL8drxm
         phfRyQ8OlvTTKYppdrvKlcl0xpcJHkktMY3ianUgMFAOTO6mKeK1HgkSZOGGvK4yShTf
         WucVDLAwRYwYS9sGY2k9EiifogAt7NurM4daSspYuJxu5lKI6qUrhWMlaF6hiGtgZRF3
         k+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yft7gFfFtwWc/a4cPI5/imyDvpQ6B50i8MJ8FHJY3Qs=;
        b=UTKMdhpF5waoK3jN85LSv3dXPKBnArZNd+uPIRzwS5Rr7YF17MUuZTINPgsS9Kymjy
         f4g0GBh4VrB3sadraIl1yTkH3Mi5KdU9A5ln/4O3zHYmxy1YcvBg+jOBy8DXSyokJ/pe
         mXHtF5iWrbn71QOk2Z57MdlvacYOTo5Rl6a1/l8UN1lSKvtxylUMkSxanH0/gE5GRdGl
         NAdZjR/6CwmCmyPLfpm+/XfThSHh1/ry0Ffo8/T7VbIzYylkpCanqQbmnCBSMFDe+I4H
         ecr9zh8AVP7WHVs0LQ9ZOFznQXoB/7Br11WL4TBd62t8o+ce9pYgNvP81hkJhZ59gE9w
         4HNA==
X-Gm-Message-State: APjAAAUz6ZvDbzxOzlCzDCWOWehtOVM4BsGX2FHgPaRZwVJYUV68gMKW
        XtR0J/hs6wnItLBIFpPGU6AH1cK653NWJbJEugdXw7HKu1lTkw==
X-Google-Smtp-Source: APXvYqy8wpf4YDDJWESxP3aiIHocm0jQsnFWNLQ3cd6ry01eg907GSjDg7den4prkFMH+wV8/3Jw0LpLJV0BD5ifkqY=
X-Received: by 2002:a17:902:758b:: with SMTP id j11mr33334728pll.87.1557154256970;
 Mon, 06 May 2019 07:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190506232200.1acfe572@canb.auug.org.au>
In-Reply-To: <20190506232200.1acfe572@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 17:50:45 +0300
Message-ID: <CAHp75VcbWN+--XSepr3Ea48cnfY3h7=TpmM2sEt0rJLZ_QX2rA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Darren Hart <dvhart@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 4:22 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   cc86bb923508 ("platform/x86: thinkpad_acpi: fix spelling mistake "capabilites" -> "capabilities"")
>
> is missing a Signed-off-by from its committer.

It's fixed now, thanks!

>
> --
> Cheers,
> Stephen Rothwell



-- 
With Best Regards,
Andy Shevchenko
