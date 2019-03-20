Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11604C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC09A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDvm2ezT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfCTWX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:23:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40685 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCTWX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:23:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so2795180pgo.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVtqGmXbZxaBYT0i3IO+Bltyf6TuxosWLQJmzgi7yIg=;
        b=VDvm2ezT+bX3RoM7rRcb/w4Le92U1gQT/asbGQ6znt9/fbDRF4sakYG8bN5os7RM5d
         1TSO5UfNZxIYmgsig7Prqbkcu8c4U4tR5vvFVM+vEI7jnUiQ5DzBF9jhQYfPOCGOke+n
         yp00YVJtWSKKLrFEhfIt02bN4J5/7TvZ2+kO1AQ0zKGJp1Vqg1bQOmb3fRNaYJD8VUOs
         Yt4VyJ1HA8sedE2Xu7eRMg+tcNcjhywfqH5nwtKjtaFDrGoM5QU8x9mXIW1/XW5GnHmo
         TWwZId8Ts+UYp2apeyu3ujSjwufQa2fCTZoPFTO4CZ0pzayaO4QAA5cDxVnQHho9M15f
         jgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVtqGmXbZxaBYT0i3IO+Bltyf6TuxosWLQJmzgi7yIg=;
        b=rRuqYc3sKa59WwF6y0Rg9obFZAEF5U4Alo0cXB73XrADaaGdQAut750CE0c+vFb+q8
         y4I4V4hmn+6MLpNIoqFxa/Tnpoaylqmzm42DAv1y+/0sqZlITc/7GioCHRZstnPOkkJt
         vAnq2/dq+hfCrd58Uj1dlf1BGW6v38Ru5dRcd7pYjO5lTNouk07E/pQqG4uqZgBWX0HE
         9oBA54lV/WGoEbKT2SaIR5K+Aop41FpCJhyBfHLjNZJcfQ/zxhMtODtBqhkTAoLu8dL8
         LMIIA81pfOV+QbtuoVStaqdIReyaZIasy01pQ+9muQ7cLkHGU+viZFYJe7N6693IhybO
         B3xQ==
X-Gm-Message-State: APjAAAUInuEhW5Y+Pi1IZ+5yAlcJeW+QibRFw901La4zvUFjsv9GHGiW
        wqPho+ALtK4rkvAyHYciVUTjnc7s7KxCWVfsoFxapg==
X-Google-Smtp-Source: APXvYqyjQw8E4BiIlv65kKJCMmUkqX82agugdnay/x7rJQLspZBe8B0IqGJyzRfX+d1ho7fh1ifDOemIMEq2VI919VU=
X-Received: by 2002:a63:c511:: with SMTP id f17mr335258pgd.202.1553120635943;
 Wed, 20 Mar 2019 15:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190320180340.25795-1-natechancellor@gmail.com>
In-Reply-To: <20190320180340.25795-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Mar 2019 15:23:44 -0700
Message-ID: <CAKwvOdn0fcGSsX7XQD2v9iV=FMM6z5shqN4=Zjkkyyrd+y8rWw@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs-mediatek: Avoid using ret uninitialized in ufs_mtk_setup_clocks
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 11:06 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/scsi/ufs/ufs-mediatek.c:112:7: warning: variable 'ret' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>                 if (on)
>                     ^~
> drivers/scsi/ufs/ufs-mediatek.c:120:9: note: uninitialized use occurs
> here
>         return ret;
>                ^~~
> drivers/scsi/ufs/ufs-mediatek.c:112:3: note: remove the 'if' if its
> condition is always true
>                 if (on)
>                 ^~~~~~~
> drivers/scsi/ufs/ufs-mediatek.c:108:7: warning: variable 'ret' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>                 if (!on)
>                     ^~~
> drivers/scsi/ufs/ufs-mediatek.c:120:9: note: uninitialized use occurs
> here
>         return ret;
>                ^~~
> drivers/scsi/ufs/ufs-mediatek.c:108:3: note: remove the 'if' if its
> condition is always true
>                 if (!on)
>                 ^~~~~~~~
> drivers/scsi/ufs/ufs-mediatek.c:96:9: note: initialize the variable
> 'ret' to silence this warning
>         int ret;
>                ^
>                 = 0
> 2 warnings generated.
>
> Remove the default case and initialize ret to -EINVAL to properly fix
> this warning.
>
> Fixes: ddd90623ce26 ("scsi: ufs-mediatek: Add UFS support for Mediatek SoC chips")
> Link: https://github.com/ClangBuiltLinux/linux/issues/426
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/scsi/ufs/ufs-mediatek.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
> index c3b78fc83d3f..34aecad04468 100644
> --- a/drivers/scsi/ufs/ufs-mediatek.c
> +++ b/drivers/scsi/ufs/ufs-mediatek.c
> @@ -93,7 +93,7 @@ static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
>                                 enum ufs_notify_change_status status)
>  {
>         struct ufs_mtk_host *host = ufshcd_get_variant(hba);
> -       int ret;
> +       int ret = -EINVAL;
>
>         /*
>          * In case ufs_mtk_init() is not yet done, simply ignore.
> @@ -112,9 +112,6 @@ static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
>                 if (on)
>                         ret = phy_power_on(host->mphy);
>                 break;
> -       default:
> -               ret = -EINVAL;
> -               break;
>         }
>
>         return ret;
> --
> 2.21.0
>

The enum being switched on (enum ufs_notify_change_status) only has 2
values; so the default case is impossible.  A switch is probably
overkill, but this change is fine as is.  Thanks for sending it.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
