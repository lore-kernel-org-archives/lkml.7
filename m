Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A47C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EF021744
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6SA3kY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfD3Wbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:31:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37177 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD3Wbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:31:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id z8so7404072pln.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfF5H9sXdYGfRkgjeUEgFTpI/com9Yw+RoJM20k2Mo8=;
        b=a6SA3kY9w7hdAa1fPmp0gfn6vQWFW4190viuCtta0fylIwg7wnbDQLdVWLIpxWfVt5
         I5ReElLYpF9ZiYEyEWT7sAQHE/B0rWttkMZdIH7zo87WO5vLbHrtETl1nkG4/SZKgEEc
         jvPdEv2C1LIXjMkxgKtdMR5wZ+0Hhj7dbDR7yIO3PpH3vHKPkVv86DLAaOx2TG+zn5sa
         Jw4kCEa1PhqW/Iq4vmQHrvaqEwzTId4PaZQc8V5VQ/iyX+lHvrATh8B08myM636TFPtD
         btmQIH5g36ec7za7lqxVsRiq8XNiqxHl1OCA2lyJeWv6lNj8OPbxcW7Itm5PznVYY8AW
         qiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfF5H9sXdYGfRkgjeUEgFTpI/com9Yw+RoJM20k2Mo8=;
        b=hzduh8Wn9ughfOQngYyGtnbdH2yoK/Jm4r6h/zrqGRjEuGryP4eElLI+SH7fedEBoQ
         HkucvZfvHQJS6ZEZdmo4EDjtGsLh4AxIXZ0Yisyt2mQPeZe27Acd217OTsPd37WW6rzz
         kKJo76TtNskTPic6p4VxkHBK4JG2v6+YkTV4z627yeIO1SEFx0ehrQr4b04Ke/6W8Lsk
         ns8i95P/dXmbGRlBaRu/VPuGOZZshpry/sGqam5pa2ga4y7Zsrmp7x9iO53XCRLpG7bU
         xvoWG15FgOtVumOcCHpSn8a2KI2RI+duVfZPHIKCJA1XB8Z4JWzbHP4u2qzZGzaB36O7
         zhpQ==
X-Gm-Message-State: APjAAAUEuDvrKkZW6L3aQV0TfYMy1kCq8xTCxPf+jnnKZvWtI2A1JzTr
        apboJYBez7NTvAJbkpzrgrPbjwTp+wMLW2o6nosViw==
X-Google-Smtp-Source: APXvYqwhJoBXedgaM/wlibXyF1IvVjm7pE3LY5oa/mMkvOuh3boz3I/pIIGAmuhePDCUR2hcUoxR9ol2Cw2SRdBepnk=
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr2195280pld.320.1556663499039;
 Tue, 30 Apr 2019 15:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190430021010.25151-1-natechancellor@gmail.com>
In-Reply-To: <20190430021010.25151-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Apr 2019 15:31:27 -0700
Message-ID: <CAKwvOdkNMnwRC9UO_cJq+e9+x5DHE0Nw0guzThxU_RX5obfSPQ@mail.gmail.com>
Subject: Re: [PATCH] dm dust: Convert an 'else if' into an 'else' in dust_map
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 7:10 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/md/dm-dust.c:216:11: warning: variable 'ret' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>         else if (bio_data_dir(bio) == WRITE)
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/bio.h:69:2: note: expanded from macro 'bio_data_dir'
>         (op_is_write(bio_op(bio)) ? WRITE : READ)
>         ^
> drivers/md/dm-dust.c:219:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> drivers/md/dm-dust.c:216:7: note: remove the 'if' if its condition is
> always true
>         else if (bio_data_dir(bio) == WRITE)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/md/dm-dust.c:209:9: note: initialize the variable 'ret' to
> silence this warning
>         int ret;
>                ^
>                 = 0
> 1 warning generated.
>
> It isn't wrong; however, bio_data_dir will only ever return READ and
> WRITE so the second 'else if' can really become an 'else' to silence
> this warning and not change the final meaning of the code.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/462
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/md/dm-dust.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-dust.c b/drivers/md/dm-dust.c
> index 997830984893..5baeb56679ed 100644
> --- a/drivers/md/dm-dust.c
> +++ b/drivers/md/dm-dust.c
> @@ -213,7 +213,7 @@ static int dust_map(struct dm_target *ti, struct bio *bio)
>
>         if (bio_data_dir(bio) == READ)
>                 ret = dust_map_read(dd, bio->bi_iter.bi_sector, dd->fail_read_on_bb);
> -       else if (bio_data_dir(bio) == WRITE)
> +       else
>                 ret = dust_map_write(dd, bio->bi_iter.bi_sector, dd->fail_read_on_bb);
>
>         return ret;
> --
> 2.21.0
>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
