Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D710EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC49C21897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 18:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nDqOUxTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfIASXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:23:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37242 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbfIASXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 14:23:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id t14so10874410lji.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lEyhS2Htsx92SqNLaO9MatDnoJOsZy3L9dUpzG9H1pg=;
        b=nDqOUxTFheiEigYwVggsXll2wUavbnJLdBFUj/qyfJYNOkV9Tqp/nvYAxA8QSSy7gd
         Ps+jLT7/MsQ98P+zG0jsE9Fnn/pIiTNz/GULKJG2u0eheW3sE3gvxyjyeo6UvpkQHzQ9
         8u8Sh/+GdNej96kbAuY1CY0eN+A8afLMqP2AnX92SeDyzo2FpQ/Xu1mlfpUBZaq/PuDR
         HFzCzuA0KeApGV2iyRGaN3VFdIdM6e2qF8vYk9G2EuwlcOLlEJES088xMekuwbCYa4kv
         I0Unh1yLo/+8FuSKaxpC2IlX/JL/5dPgFrj1E8WC26itvgtRDJEPG/oiTlphwbPsXRau
         he1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lEyhS2Htsx92SqNLaO9MatDnoJOsZy3L9dUpzG9H1pg=;
        b=CmH1Ul/1NZFKE4sUh3fr5hfqfErcPrq0K3L2fEcpjpsib9zkMY6y0pFfI12mkye567
         giPqClgR2XcNpXBYm0zWrbm9XNQqClng4Sc85S0AdHGWvqmXNpii0XR1QfN05S5naqUI
         H7Fk+3TWvEGTtzJY0elzp7mSHB+n0RHWeE7D/DWDPgUVYucu3GuKr3weRdotP01pOJb6
         LQcTfrgS1Rs9dw0Ps/lgX6l1sKFSas/swZNNElZlBWS8YnkhBcDOklvDey/plxyPWUXn
         suy1A96UlCQzE7nWe7jO9witgPuwQpBCCX4A/MVH0lJWQ0L738k4pQ/doEx0GUzp4mpD
         SyCA==
X-Gm-Message-State: APjAAAUZz88ivmulumIXLXDpVcOeVt17XOFzciX26KrDzeVBsHtY1CzV
        c9t3PC5S71VUF/BlVxa5VWEESl2twD/AYv9oWgsK
X-Google-Smtp-Source: APXvYqyHz2GNqXe+RT3Nbiu5zT4YHu7ZJO0ITiqzOu0n5Nf4bwCefMXdsaqYWfxqTVuMMD3RYGXXKbJdybBVNZfpsFk=
X-Received: by 2002:a2e:84c5:: with SMTP id q5mr14155528ljh.158.1567362178439;
 Sun, 01 Sep 2019 11:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190901155205.16877-1-colin.king@canonical.com>
 <CAHC9VhSVKEJ-EBAry5fVN3Ux22occGQ5jxbFBecMsR+q7+UT5A@mail.gmail.com> <de0cd774-8fce-d69a-8ea4-3c7b2ee3a918@wanadoo.fr>
In-Reply-To: <de0cd774-8fce-d69a-8ea4-3c7b2ee3a918@wanadoo.fr>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 1 Sep 2019 14:22:47 -0400
Message-ID: <CAHC9VhRbJWO3rhk=090VAJOHsZer89s6VP_mFcMcoPHf-Zg4Kw@mail.gmail.com>
Subject: Re: [PATCH] netlabel: remove redundant assignment to pointer iter
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 1, 2019 at 1:16 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 01/09/2019 =C3=A0 18:04, Paul Moore a =C3=A9crit :
>
> On Sun, Sep 1, 2019 at 11:52 AM Colin King <colin.king@canonical.com> wro=
te:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer iter is being initialized with a value that is never read and
> is being re-assigned a little later on. The assignment is redundant
> and hence can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/netlabel/netlabel_kapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This patch doesn't seem correct to me, at least not in current form.
> At the top of _netlbl_catmap_getnode() is a check to see if iter is
> NULL (as well as a few other checks on iter after that); this patch
> would break that code.
>
> Perhaps we can get rid of the iter/catmap assignment when we define
> iter, but I don't think this patch is the right way to do it.
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 2b0ef55cf89e..409a3ae47ce2 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -607,7 +607,7 @@ static struct netlbl_lsm_catmap *_netlbl_catmap_getno=
de(
>   */
>  int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap, u32 offset)
>  {
> -       struct netlbl_lsm_catmap *iter =3D catmap;
> +       struct netlbl_lsm_catmap *iter;
>         u32 idx;
>         u32 bit;
>         NETLBL_CATMAP_MAPTYPE bitmap;
> --
> 2.20.1
>
> 'iter' is reassigned a value between the declaration and the NULL test, s=
o removing the fist initialisation looks good to me.

This is what I get when I try to review patches quickly while doing
other things on the weekend <sigh> ... yes, you are correct, I was
looking at _netlbl_catmap_getnode() and not netlbl_catmap_walk(); my
apologies.

--=20
paul moore
www.paul-moore.com
