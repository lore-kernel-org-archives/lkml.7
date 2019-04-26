Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD99C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD325206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnEZBadP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfDZDpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:45:03 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42098 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfDZDpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:45:02 -0400
Received: by mail-yb1-f193.google.com with SMTP id 68so788561ybn.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 20:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcmj6XwKT0AKap6jvhr9fxcynac8P/uVVqGGcEOTpt8=;
        b=gnEZBadPizIT2m2SxRtOCN1vr67WS/PeZlVe0CfeSoB5MSDV2Ghcep89iUMCbRI1gW
         wipDRXVU78MXuHEC4qYcX78We9eMIwULVdgvI4RugTet0qQBlITxneHLPbV5o8ch2LsF
         Q0QkiXu4+1TVUtmRjdxa6fD5VU3Pp79uE8bAg0wMmZJ4T/W3Agf+DtkgIymdgaPNN6N0
         CWHWQ3Lpx13of0lce+HPMnrdnJVcP+Zynv+H1xV7GLq7moap1KGuK2ZNGqEcujdOJASG
         D4tLn38HfFdIF4xVa6q3G9gdUnDs5An44d24HdWv3gnNDK32cCLuqOt+jmeEQsXUoInk
         AmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcmj6XwKT0AKap6jvhr9fxcynac8P/uVVqGGcEOTpt8=;
        b=AavqmUpM0bXv2TdG75i/llUuMIUiuJ/wT09KDZcn+hgNebmWyPMtK6sUJ/JojGvkip
         u6eYfKcuW9oBkpbQscGTykYE5x4F2FWNUzmtngF1wgPLPvcNJd98gb/7YUWz6Tr2rIg5
         pgFOLUepHGsbb0iZKQKmLN38uo7/FTOAW1agPWM+Yohkc2717TQazmTlfLeLwuJ6itVw
         grvV3VdhW9UxvrQ0cQe6Z/Lhs9quo/tXjqZWLmJWJ170UMXWTRQkhjkqmzuglSgbC5O3
         L+qJfVyFLJJQKLIuKI7ND0ytCx5kOpFVFTUnrdbPdXosgARWKMSJGmhSkTFm3ouVSFI6
         0DDA==
X-Gm-Message-State: APjAAAUfA2r4E9v4RwSoddtZZ5V1OjUthnWRbNs27c7T9QEd+jTJk5MW
        PHdpB9Ri7BB2uuPpGgUgbnMVBRVjWDUYn2+qkqc=
X-Google-Smtp-Source: APXvYqwKsDMzgyj8fFD2PAqujDxNKmZ08vuF0efcakezIx54eTaZzYjb9But3MidGSlqonBwX5otTdEuWNA3CnN6lD0=
X-Received: by 2002:a25:504e:: with SMTP id e75mr35378571ybb.68.1556250301844;
 Thu, 25 Apr 2019 20:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190423022018.12214-1-tsu.yubo@gmail.com> <20190424145505.GE14798@kadam>
In-Reply-To: <20190424145505.GE14798@kadam>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Fri, 26 Apr 2019 11:44:50 +0800
Message-ID: <CAKq8=3LQyN=bmXO4p5qmizHQXwq8YhPB8jyLbrhFUjS7Hbhk4Q@mail.gmail.com>
Subject: Re: [PATCH] staging: most: protect potential string overflow
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kroah-Hartman <gregkh@linuxfoundation.org>,
        christian.gromm@microchip.com,
        Colin King <colin.king@canonical.com>, andrey.shvetsov@k2l.de,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:55 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Apr 22, 2019 at 10:20:18PM -0400, Bo YU wrote:
> > There maybe cause potential string overflow issue due to use
> > strcpy without checking the length
> >
> > Detected By CoversityScan CID# 1444760
> >
> > Fixes: 131ac62253dba:(staging: most: core: use device description as name)
>
> It doesn't really fix anything, it just silences a static checker
> warning.
>
> > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> > ---
> >  drivers/staging/most/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
> > index 956daf8c3bd2..0f26cebac91a 100644
> > --- a/drivers/staging/most/core.c
> > +++ b/drivers/staging/most/core.c
> > @@ -1431,7 +1431,7 @@ int most_register_interface(struct most_interface *iface)
> >
> >       INIT_LIST_HEAD(&iface->p->channel_list);
> >       iface->p->dev_id = id;
> > -     strcpy(iface->p->name, iface->description);
> > +     strlcpy(iface->p->name, iface->description, sizeof(iface->p->name));
>
> We prefer strscpy() more than strlcpy() these days.

 Ok,will try it.
 Thanks,

>
> regards,
> dan carpenter
>
