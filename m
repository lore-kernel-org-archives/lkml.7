Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F092C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8E720815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwhvFeSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfI3Vh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:37:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40311 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3Vh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:37:28 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so42273985iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1/5t0a320gO6rtoSFLmxFmUmcGcayGzHZ6jiBhmFkE=;
        b=OwhvFeSp2ZaGkR6JyWaekRt39DDj8wTJo4hVNfKhMHexTAj8ZIpLOi23kap/omy0bj
         2mZBEp810uUSlzqFeweXDm44lmx43YMg9zpOi1O6bgkVJIsSVEvL2KLfdC8LLSmhF4/S
         mnYH5WrY5R1aTIc0g8bdfMKhdEsRdvq/3uhvkANSv5aaciT4NbLxMmKmCKBJtwwqhg/F
         0LiFLYwNVT6khikXCKIBBSmvCiVJKqJrtoipkTzhrsgB1EvC5UtdhZnPNWxly0G7PCm+
         MWRUdYF+/eT7iOZdfkfXIT/Oy8bJxH3a1q7SDqrWxUc3Nn8YbqFab72A2dsbBQL0XMS8
         sejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1/5t0a320gO6rtoSFLmxFmUmcGcayGzHZ6jiBhmFkE=;
        b=txTcRSQs5uWilww/CA1rmNO+0BPsAxQMk9mwSAufpy1vmiP2BTvSJrZbA1n+dsSydp
         XFsfR9z36kfEZg/qMLb/GrI2vNOoTmwv8QnBQ7sFAu2GnHSxn2D0b2kJziYt2QFZMPR8
         OrHRT8BtaIUwsfawJeBJbNqV9LQ6W/yPgxk/SlKVTTMUlHYJaRqvBMbBp9JJYw4TQvQq
         /H79+5y4LQWUHdmtFUsZrooyIxqVp9+/xJYLE7zFuzi+JTBxta95uDv3KbgF5w8o5Zdm
         yEcSW5tNEUdITWUBIOtFzUPqeckIkI3r7bx33gKZ2bBHLKfvrNsDqY2y5FRXJuzwqn8o
         COiQ==
X-Gm-Message-State: APjAAAWpLNt5FsXmCCtTbDPrEijL/LFMhlgAmOy2+R9UzshF2fL+XZh0
        HDiBlXJz5u6zraDu/LLS0MZlfOAIl9EMwRGDtXU=
X-Google-Smtp-Source: APXvYqzAeDU9zrO6VIz+ugbbAlCgVAXWrJ2UT7vfpF6sK2PXJ/JnuwaCKzk3KgMB7JUVqyiLAZBj1gJb6QYAJQY5fFA=
X-Received: by 2002:a92:8702:: with SMTP id m2mr18251627ild.294.1569879447978;
 Mon, 30 Sep 2019 14:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190925154302.17708-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190925154302.17708-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 30 Sep 2019 16:37:17 -0500
Message-ID: <CAEkB2ETTmCsuOFDsJQ8LbBPHNgckpDFn2XhVePwAQEsCRsJo6g@mail.gmail.com>
Subject: Re: [PATCH] mtd: onenand: prevent memory leak in onenand_scan
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Navid Emamdoost <emamd001@umn.edu>, kjlu@umn.edu,
        Stephen McCamant <smccaman@umn.edu>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would you please take a look at this patch?

On Wed, Sep 25, 2019 at 10:43 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In onenand_scan if scan_bbt fails the allocated buffers should be
> released.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/mtd/nand/onenand/onenand_base.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index 77bd32a683e1..79c01f42925a 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -3977,8 +3977,11 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
>         this->badblockpos = ONENAND_BADBLOCK_POS;
>
>         ret = this->scan_bbt(mtd);
> -       if ((!FLEXONENAND(this)) || ret)
> +       if ((!FLEXONENAND(this)) || ret) {
> +               kfree(this->page_buf);
> +               kfree(this->oob_buf);
>                 return ret;
> +       }
>
>         /* Change Flex-OneNAND boundaries if required */
>         for (i = 0; i < MAX_DIES; i++)
> --
> 2.17.1
>


-- 
Navid.
