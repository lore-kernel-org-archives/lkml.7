Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC88C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FAC21924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srIIQM6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfJAXJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 19:09:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43776 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJAXJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:09:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id h126so13001651qke.10;
        Tue, 01 Oct 2019 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOpFVMgw/qyGlxcI8Ot6QminlgTrtT6okvp/hgnhkDE=;
        b=srIIQM6lmikHi1kLgqPsjGOnQLDuuTZllABnnsS00Nk4bz2NSCo/WFqnCqNJsyt2EU
         VfUFyTWHyqwlf7PBgs2rbjmFORP7rBEsvmYBIuF/NRU5tdWWmqUGw5ViBpRVKe0e3w93
         6yd+oXjNp4Y4sD81hWgCzkAItXNa/nABtGbxUmhrjdQK241NAGnn3D1kU0INq017Y42d
         A5uWz024Pzzwfa9ikhMsxyssgrV4+tsWguJgQHlc7fdY9eI5D8flzJ+YfUniJHkqhUVl
         ZxBqG+gH+6DkGx9mHNLKRTeL/XviIRQO2RyvF77X8tZI2UT5KB6PUhdr9h1knucWj4lT
         /JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOpFVMgw/qyGlxcI8Ot6QminlgTrtT6okvp/hgnhkDE=;
        b=fwzyErtwWU1lDxwJicVNjKzBRPAFnIS4IIUz1F1CIm0n+l99IzXneAzyZhJQSCz/kH
         5Zc7t4Mj6+D1q6twuNkeLqOnfLZiBYZa2XylPrRCrzrAwyt13kt/rxBNpdf0ZJhvXTbp
         ouKNfdcZUuGYJc4E8vZeok/y91My/crUGUVaUEAE9ad96uY+t2h/I9jeA012ZiwAMqQC
         4u6llrg3aq1HpLd7/ddAHgFfCerR9sOgTgkKLhrl7JAFZskammErBMDqYZYllzoy1olk
         cRnAiT8P4URohGKM6mGUe3eIwrRJo/U8E0KSNesY9TNJWD3SfF+Pvf1XJmO60NNreIwG
         K9ng==
X-Gm-Message-State: APjAAAWfDoVk+yEljKMhKZCJ2wj+DcDx0fH5cJn0xzAr3Xv8gbU/MGvV
        KmP+fpblg7PoRthWTlvG9NnHM2mQvJlQmn8uznhdNw==
X-Google-Smtp-Source: APXvYqz9ihuKKqAYfL1D9QzH13QTSw/XJVfGELkzG5iXUUJswEgcgv+2HeEv3vVOnqK+8P+H80QaW3x38cZ1a/OP448=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr703551qkf.203.1569971345545;
 Tue, 01 Oct 2019 16:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190921060031.GB18726@mwanda>
In-Reply-To: <20190921060031.GB18726@mwanda>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 1 Oct 2019 16:08:54 -0700
Message-ID: <CAPhsuW7zfwX2GPEhXV_X5F7zKi-NvT0vmP-bCc9qYjmFwSJwFg@mail.gmail.com>
Subject: Re: [PATCH] md/raid0: Fix an error message in raid0_make_request()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     NeilBrown <neilb@suse.de>, linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:00 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The first argument to WARN() is supposed to be a condition.  The
> original code will just print the mdname() instead of the full warning
> message.
>
> Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/md/raid0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index f61693e59684..3956ea502f97 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -615,7 +615,7 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
>                 tmp_dev = map_sector(mddev, zone, sector, &sector);
>                 break;
>         default:
> -               WARN("md/raid0:%s: Invalid layout\n", mdname(mddev));
> +               WARN(1, "md/raid0:%s: Invalid layout\n", mdname(mddev));
>                 bio_io_error(bio);
>                 return true;

Applied. Thanks for the fix!

Song
