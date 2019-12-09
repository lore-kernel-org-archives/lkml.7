Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB00C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF509206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N66gVvBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLIVHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:07:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38213 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLIVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:07:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so7509155pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+eNXnjIau7cgWUnA3a2Cqn1U1V3PjkPxI5SSOqsokA=;
        b=N66gVvBqkf/IjPQJvFj30UwukfXdt7TOhv82tZT0Y1uUriBCsQn852PcFt58pbGqRp
         4gI4geMvYZAbnsP3cmY1HBIBfrePAAtWS2G2tDjmxVQrTuAXyr/GKlD+3jAmfHJ+x3mN
         nUbzjuk6TRlU2f/oY17DgyGFu2HHkF3EtxYivNULwN0EdRBe/tWmUNxjY+sABJZClkXu
         swMlYnD9n+MlEt5Z1j016kwLNcmGyJ2Kq0vCYcJ8ZgSnrSDEuCuiLHXWhqen6acZN7MY
         eTomNjbMQhZ5O3+bSXk2fvVW1quzeUl8aXog4mBOHVo/c9yhU3uKAenXTgNeqKN6+EI+
         yOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+eNXnjIau7cgWUnA3a2Cqn1U1V3PjkPxI5SSOqsokA=;
        b=UThvi9Zi9cGmysaXuodbTN37JPjd76nqmJ2wo2t3eau87u/AepaxKwoALAa2Jr2XeU
         Nv/EKQRV+PjP/BUR82WtyKYd0GmVj+xg5UZbXV9h581QRdh4tNq+zWmZgjhHbj27s9oj
         uVM1co0aBFnaUdZW3FObfPQqyPeyAjzDckKlQpqwAtGOB/V1sjuSMuIoLzfltlRrQeB6
         6SLowcMjRqU8eONu8w7xJcymJ7Ejx2VTxGxiFAVq/uFqjGfZwQ5XzzELBILLfT3rgXVn
         OOfjOK2tFuynpZ/yeSlxSY81+y2q5eXpSvx5o8MLlMR5ho0TrBWuxRNECYR6IxX2l7gZ
         aNGQ==
X-Gm-Message-State: APjAAAXjXJHnotLfyE/AxYktJZ3zozMe3ugzWO9kui5mqmRVo/urlXhl
        jjD+3c+8gBChpCpXDKsykYhBVIZ0J8aft4W+SztLcA==
X-Google-Smtp-Source: APXvYqxUFVcNRk0/nAhQuNe2/SnfwtMmBoobRu1zKuYgYL2LWWtIcBKJdlZgzI3AQuAYyh7coP7wm3PK/UOBY/C2Cag=
X-Received: by 2002:a65:590f:: with SMTP id f15mr20478238pgu.381.1575925672294;
 Mon, 09 Dec 2019 13:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20191209201444.33243-1-natechancellor@gmail.com>
In-Reply-To: <20191209201444.33243-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Dec 2019 13:07:41 -0800
Message-ID: <CAKwvOdmrGGn6f+XBOO3GCm-jVftLsFTUXdbhS9_iJVY03XqCjA@mail.gmail.com>
Subject: Re: [PATCH] xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 12:14 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/block/xen-blkfront.c:1117:4: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>                 nr_parts = PARTS_PER_DISK;
>                 ^
> ../drivers/block/xen-blkfront.c:1115:3: note: previous statement is here
>                 if (err)
>                 ^
>
> This is because there is a space at the beginning of this line; remove
> it so that the indentation is consistent according to the Linux kernel
> coding style and clang no longer warns.
>
> While we are here, the previous line has some trailing whitespace; clean
> that up as well.
>
> Fixes: c80a420995e7 ("xen-blkfront: handle Xen major numbers other than XENVBD")
> Link: https://github.com/ClangBuiltLinux/linux/issues/791
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/block/xen-blkfront.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index a74d03913822..c02be06c5299 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -1113,8 +1113,8 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,

While you're here, would you please also removing the single space
before the labels in this function?

In vim:

/^ [a-zA-Z]

turns up 5 labels with this.

>         if (!VDEV_IS_EXTENDED(info->vdevice)) {
>                 err = xen_translate_vdev(info->vdevice, &minor, &offset);
>                 if (err)
> -                       return err;
> -               nr_parts = PARTS_PER_DISK;
> +                       return err;
> +               nr_parts = PARTS_PER_DISK;
>         } else {
>                 minor = BLKIF_MINOR_EXT(info->vdevice);
>                 nr_parts = PARTS_PER_EXT_DISK;
> --
> 2.24.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191209201444.33243-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
