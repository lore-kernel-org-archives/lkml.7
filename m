Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442B1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141A2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho4lluAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfDXIYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:24:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35477 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfDXIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:24:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id l17so110606qtp.2;
        Wed, 24 Apr 2019 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N+iTZQSZ69Ij61Cp9RRtOjmDEKD+cralGbazfmiX48M=;
        b=Ho4lluAI+z5jJxffuLrvL1oAejjg0oZ2WRo//e1gjfXV3bzvJ//aMs6SgmW2Vk6JTB
         vp3Ctv0JrWYvac7EmqVBl+qfApEs/DlHlCDKlBy1Uz91SrQbUQuEXVHxglkE3gC/62ND
         6SwzuBASGacTlQl7FA8iZ5YkU9jE8G7xB8mPCyx5+M3vYMyrH/mwnZAbBGMCjgl8leJB
         bCvD0PANcHdCSwQAa3bldB2/f42BvLwr8VM57cH/HcYjQkoxjXFkcItr0QMaA/XRjlYf
         MZfzjPmXp2NsG5Xf8R41S+aVdgLAM5smd/okujHK62J2tEwDLr4tK7ye0BRCt75r7mjH
         eNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N+iTZQSZ69Ij61Cp9RRtOjmDEKD+cralGbazfmiX48M=;
        b=s8fUZ23JdRdstDVgArhf84uGOqQT8JnfG9odm+X6cuS16E/QnTYL59et+QKze7yUXM
         UE8+b8kfgmh2sjR+TzQhLpMAIfHOJhb2BjxwxBmHpULSOSSgUNKhOgZ4AmS1PuBjnYt2
         kbRvdoCvLKD4ZW9wJ7vRnFjhZ79XDm3ELDO3woEECDE6iRNrSZbkLda44d/IoHKZGvMf
         ecDqqEve7DhHl5BOSBHAEJHwhYSoJ05iTT7pbhdOmWXTIy+lYaFfKyjoygDWiYtAMHQ1
         iAlP0fg6kSYHpazUQ7ZWFP+aNnl6VJ329ouaMV6DI/Jjr7/ugUEA8avgtpoziUWSwVxo
         1j2Q==
X-Gm-Message-State: APjAAAXKIz4tUw+xcpaMK5SKQQf55Dy9HIzffpVhaOhPti1ffEoUiAtz
        6QGS/kSAPZQC7NIF3YmMi+RXN/a6ff58Vq6XC/LqjZMy
X-Google-Smtp-Source: APXvYqzsyGnnCQPYCD0n9abgEE9w7iApmA3Pg+9cz5QOVDm3H1GBJAhJSwnRFJ2uGceS6kmN5dDYdKx3iqRzs/kQox8=
X-Received: by 2002:ac8:3042:: with SMTP id g2mr5759911qte.252.1556094245507;
 Wed, 24 Apr 2019 01:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190403152602.10019-1-steven.price@arm.com>
In-Reply-To: <20190403152602.10019-1-steven.price@arm.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 24 Apr 2019 10:23:54 +0200
Message-ID: <CAFqH_512Z-R9O4oVZFq8dM629kfzKcvBuA1RbkEUn-7WH6jvHg@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: return PTR_ERR not NULL in try_then_request_governor()
To:     Steven Price <steven.price@arm.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missatge de Steven Price <steven.price@arm.com> del dia dc., 3 d=E2=80=99ab=
r.
2019 a les 17:26:

>
> The callers of try_then_request_governor() only test for a PTR_ERR using
> IS_ERR(). However in the case that request_module() fails then NULL is
> currently returned which will cause a NULL-pointer dereference in the
> caller.
>
> Instead convert the error we already have to a valid PTR_ERR and return
> it.
>
> Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers=
 are built as modules.")
> Signed-off-by: Steven Price <steven.price@arm.com>

There is already a fix for that. The fix was initially sent in October [2] =
but
unfortunately, it got lost. I resend and now is queued [1]. Hopefully, the =
Fixes
tag will help to pick the fix to the proper kernel releases.

Thanks,
 Enric

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=
=3Dfor-next&id=3Db53b0128052ffd687797d5f4deeb76327e7b5711
[2] https://lkml.org/lkml/2018/10/16/744


> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..d29f66f0e52a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_gove=
rnor(const char *name)
>                 /* Restore previous state before return */
>                 mutex_lock(&devfreq_list_lock);
>                 if (err)
> -                       return NULL;
> +                       return ERR_PTR(err);
>
>                 governor =3D find_devfreq_governor(name);
>         }
> --
> 2.20.1
>
