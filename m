Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D56C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D34C206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIfUwUlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLIVW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:22:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:32795 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLIVW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:22:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so6433793pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYKN4XMxSrLNdiW1K9zMIVb1AY7QEckrYyQGFO3gO7U=;
        b=tIfUwUlu/aebwlAJY5I4wiUV+hL2zrAKrAhhFztgRjVtv2G7CznBy3/+nHdkAd9mFg
         eUi6wvK36wARtJVvf95GdIo4aA7revKeWc0izcsqcLvXLgfJW+injVOYMpEEVQBnr1kr
         Hq2nD5kyOsjq7ysmRBMqsg9lC5uPzecPpKZaV0IykkwR7l7ulnya8cXpm/niOgqUoNl9
         9ZnW3wcUeRkuaL398+LUn72CTffQClXItu4v7VGcUKLAiNAr8KUWgn0TxA1PAQL9k/AI
         JDzi6aMZwe5u/p+9jdrOj/2XWEMtv+xc4rYuovd51SEiB2zhTyY4QOIozi4MXy+t7t28
         D+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYKN4XMxSrLNdiW1K9zMIVb1AY7QEckrYyQGFO3gO7U=;
        b=Kdk6DvP09/akS7Mmww98Tcc2XAnFxdCLdXcnFaLaaCHGX78EmNghqGyCNxpSDXwkA7
         ONk2skEQZQGgexCzUjJAZgYzeVqgiAUTd1I1kNnpaLHnvDCUzxReMW5pWx16HzpvMzwv
         LnqXxnLWmbM8V0Je67BkoHIA9+megHnAbRo6SReVOAaGAgCtF2elEEP8vbvS0i79f5O5
         hIfdx7mVRZoItYF/agXVB8LlyEXj52diuWAzWr2h2PrmDt7TzuvVsoFVYpX+zIcAWffW
         15MEzgXse0JT5xD/VimL64SpRd6GdmbwUKFe/BxTkxZG4F5VDJ6Qp9iqtqDJuBf0C4ie
         SSbg==
X-Gm-Message-State: APjAAAUWFJ4i80WDRjj8wQAaVDKU5zfAPAZB5/AYZpnTi60iOne9JjC4
        gKmSHcMU6sBwUkaWpH+3oq0HaKTb8bNBpO0gxvr0RQ==
X-Google-Smtp-Source: APXvYqxLyJ84N4sB7y2gm9HTU5F0NX0yt0sS6W9FapviadhzzQ2uydjnauwEeo2bWU2j0dESyGplK2ODB74G0M/HMSI=
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6mr18228675plb.223.1575926577921;
 Mon, 09 Dec 2019 13:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20191209211623.44166-1-natechancellor@gmail.com>
In-Reply-To: <20191209211623.44166-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Dec 2019 13:22:46 -0800
Message-ID: <CAKwvOd=UgY8+w9MVjJa-xpZ-08K9zrn79226otp2=TOCFT6MnQ@mail.gmail.com>
Subject: Re: [PATCH] net: tulip: Adjust indentation in {dmfe,uli526x}_init_module
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 1:16 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/net/ethernet/dec/tulip/uli526x.c:1812:3: warning: misleading
> indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>         switch (mode) {
>         ^
> ../drivers/net/ethernet/dec/tulip/uli526x.c:1809:2: note: previous
> statement is here
>         if (cr6set)
>         ^
> 1 warning generated.
>
> ../drivers/net/ethernet/dec/tulip/dmfe.c:2217:3: warning: misleading
> indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>         switch(mode) {
>         ^
> ../drivers/net/ethernet/dec/tulip/dmfe.c:2214:2: note: previous
> statement is here
>         if (cr6set)
>         ^
> 1 warning generated.
>
> This warning occurs because there is a space before the tab on these
> lines. Remove them so that the indentation is consistent with the Linux
> kernel coding style and clang no longer warns.
>
> While we are here, adjust the default block in dmfe_init_module to have
> a proper break between the label and assignment and add a space between
> the switch and opening parentheses to avoid a checkpatch warning.
>
> Fixes: e1c3e5014040 ("[PATCH] initialisation cleanup for ULI526x-net-driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/795
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

/^ \t
in vim turns up a few more cases that I think should be fixed (in both files)

> ---
>  drivers/net/ethernet/dec/tulip/dmfe.c    | 7 ++++---
>  drivers/net/ethernet/dec/tulip/uli526x.c | 4 ++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/dec/tulip/dmfe.c b/drivers/net/ethernet/dec/tulip/dmfe.c
> index 0efdbd1a4a6f..32d470d4122a 100644
> --- a/drivers/net/ethernet/dec/tulip/dmfe.c
> +++ b/drivers/net/ethernet/dec/tulip/dmfe.c
> @@ -2214,15 +2214,16 @@ static int __init dmfe_init_module(void)
>         if (cr6set)
>                 dmfe_cr6_user_set = cr6set;
>
> -       switch(mode) {
> -       case DMFE_10MHF:
> +       switch (mode) {
> +       case DMFE_10MHF:
>         case DMFE_100MHF:
>         case DMFE_10MFD:
>         case DMFE_100MFD:
>         case DMFE_1M_HPNA:
>                 dmfe_media_mode = mode;
>                 break;
> -       default:dmfe_media_mode = DMFE_AUTO;
> +       default:
> +               dmfe_media_mode = DMFE_AUTO;
>                 break;
>         }
>
> diff --git a/drivers/net/ethernet/dec/tulip/uli526x.c b/drivers/net/ethernet/dec/tulip/uli526x.c
> index b1f30b194300..117ffe08800d 100644
> --- a/drivers/net/ethernet/dec/tulip/uli526x.c
> +++ b/drivers/net/ethernet/dec/tulip/uli526x.c
> @@ -1809,8 +1809,8 @@ static int __init uli526x_init_module(void)
>         if (cr6set)
>                 uli526x_cr6_user_set = cr6set;
>
> -       switch (mode) {
> -       case ULI526X_10MHF:
> +       switch (mode) {
> +       case ULI526X_10MHF:
>         case ULI526X_100MHF:
>         case ULI526X_10MFD:
>         case ULI526X_100MFD:
> --
> 2.24.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191209211623.44166-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
