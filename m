Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C99C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732042086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTthKozN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbfHOWfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:35:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33059 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfHOWfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:35:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so2068225pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0bj6abrMr4gCECqmCrBbgDjp+biz3GEYW7dznHQhuE=;
        b=YTthKozNU0AfAmGeC18iVc7BIN6HgPzw/Mywcvzg084v19wE7vfkfBXXeFOerumZ36
         0vu4LpID2z5qtebuIEITL8e/ewoSd/9Rln5xJngDRB3ViYMtXHoP7e8HCuWPEbbBc2jt
         1bLiEDndGuFCLigxaDdAPF24z/adjNfwKV1mudg7ON6L12tuK6l02Kqrtfs80JcudB/g
         Nuci2mXBy9uh30+RB2OK1HbjQucQzhCdnaBZYYJ5BiQYbQr7iXjJAfPUZKYwbg5/7Lvk
         KcKGEAuba57IXbU9n1tK/057cfUmSpOqR3pq4NXuSitGgIGkA7lWSrnqjuh11Z9qOo8f
         IOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0bj6abrMr4gCECqmCrBbgDjp+biz3GEYW7dznHQhuE=;
        b=a1O8vShQqcuprVoezcDe4pqVUgV0Pj9qEm+dc4Zw9s9b08XM8oFsEcOz6bCztX0NhP
         D1iwh7saEmHRW8fqfqfboLtB6JJWsIMv1js7PNaPqlxECfakVT4v4M18KPYSnkI8RKlk
         3ARrANCo7TAX4siSDmG4JoFQfphMajjAnkuoLhYXAB+O4NP8A2RQJSG/6jDdxO3Nmvkt
         HxzesiZigE1UyUdbBP7VIZeY+m6hAVLfzJfkFu4w6b/uH5MbpuE+A/6aShIO29cLTU9d
         SbN2BpGG6pfCy18nDO2Naz40OOWVQlMXBrUWM8u0c92OFUTy+6BrVIeAO8aHHYllIMrF
         XL0Q==
X-Gm-Message-State: APjAAAUNPV6Tpwc5HkgxBd/bnXIqqKrn/9fwOU7+2Zx2ytjAKhE7yoD0
        /BNvm12Wx+Jat75/1c97OxjTagB3IhyF47E0huR0sw==
X-Google-Smtp-Source: APXvYqzuKDvt26gREh27cHM5QMkm6TaTTPQEqRgLBYLaqlpTH0mOKwI9PVLAnXNbVTf5AyCzTcLT6Bvcak2m+CkrpXg=
X-Received: by 2002:a63:61cd:: with SMTP id v196mr5282760pgb.263.1565908508797;
 Thu, 15 Aug 2019 15:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
In-Reply-To: <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Aug 2019 15:34:57 -0700
Message-ID: <CAKwvOdmuReaFgFK+=aib6rRfAb_GTGubLyJ3sAH-tnkKYHASqQ@mail.gmail.com>
Subject: Re: [PATCH] afs: Move comments after /* fallthrough */
To:     Joe Perches <joe@perches.com>
Cc:     David Howells <dhowells@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 7:36 PM Joe Perches <joe@perches.com> wrote:
>
> Make the code a bit easier for a script to appropriately convert
> case statement blocks with /* fallthrough */ comments to a macro by
> moving comments describing the next case block to the case statement.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  fs/afs/cmservice.c | 10 +++-------
>  fs/afs/fsclient.c  | 51 +++++++++++++++++----------------------------------
>  fs/afs/vlclient.c  | 50 +++++++++++++++++++++++++-------------------------
>  fs/afs/yfsclient.c | 51 +++++++++++++++++----------------------------------

So these changes are across just fs/afs, how many patches like this
would you need across the whole tree to solve this problem?

>  4 files changed, 62 insertions(+), 100 deletions(-)
>
> diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
> index b86195e4dc6c..2270fe9325da 100644
> --- a/fs/afs/cmservice.c
> +++ b/fs/afs/cmservice.c
> @@ -282,10 +282,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
>         case 0:
>                 afs_extract_to_tmp(call);
>                 call->unmarshall++;
> -
> -               /* extract the FID array and its count in two steps */
>                 /* fall through */
> -       case 1:
> +       case 1:         /* extract the FID array and its count in two steps */

Could these instead be on their own line as the first line within this
case?  (I don't feel particularly strongly about this).

...

> @@ -220,8 +220,8 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
>                 count = min(call->count, 4U);
>                 afs_extract_to_buf(call, count * sizeof(__be32));
>
> -               /* Fall through - and extract entries */

Yikes! Mixing fall through and other comments...yeah that would be
hard to globally find and replace.

> -       case 2:
> +               /* Fall through */
> +       case 2:         /* extract entries */
>                 ret = afs_extract_data(call, call->count > 4);
>                 if (ret < 0)
>                         return ret;


-- 
Thanks,
~Nick Desaulniers
