Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26032C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D966220843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWWOqMdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfEOTzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:55:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39837 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOTzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:55:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id w8so808587wrl.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faSObUUDhzWCbTecxagBTtZE6cIWm5DcuCOMti7xnXk=;
        b=VWWOqMdpNmF+ZoF8YVE9C0qKG2dKyZbC3SSkb6TrM8bqqTDvvgo2EZajTjyG54Oinq
         ThywjMpAfFVB+8wdu9gR9QktsHSL8UoRq/5Tt7ZzE4J3CXIX+kP5rM8Ayd5Sed4s8oue
         ZNxO4KIx+D3/YQtcZtN8oPJBj13yl4Fnvm1MHoJA50+tyZxGEuv3qGkNB054dyOR1Qhp
         FQIxuzehK+epcXEQOwnW4aJxrdZQUZbNzDiaxLvQ8krx3WHeXI6HJ1cE0cRircw2llF/
         Y7e1FnK7ticBSgU71MxduKPIQpKrP9eLKnaHwDDeTOLbk/626p1quCnQ+dI2uXyrKMYT
         nHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faSObUUDhzWCbTecxagBTtZE6cIWm5DcuCOMti7xnXk=;
        b=ZmLWaUsKcwHqpyn/3DQ5jsJLZvTgli8VEIUT6bABmUIFbStfO6MCJfBFwxwYjr0rZX
         5I5U4y9hjAdMj9mon56JXeKO2XW+MeR12Kzo8UMIkGET6/w4x+xUHtsCtMfcrCNNoEO2
         xeYbnS1dad/R6l2d4GAifbSiYgY6bz6ylLuQbX6iU9ElfbfZF+ZmkcSBWjDYjgKOsdIG
         skUABZJVbFXyA93gqiS3lWCJZ3IJcItcIpoUd9xgcNDnf1WQhvBU5UZIbUiHBjIRTpG0
         GSLEiNr1spfGc8TktbqVz6XzxgAMZKWnpalvQ7lPjZaxPCvxElZ/rjZmPfVrVql1b2iw
         NJFw==
X-Gm-Message-State: APjAAAXgGQckw4wHkGR+bKiK6v9w+FFm4jpuxNN0amjkaokVCKG6YXsY
        r7kWKJA3wjzXFMWTTtuua01qsM5u1l3v4X7CIH8=
X-Google-Smtp-Source: APXvYqywK2MKVrTXU7jzIoWkVf5WOTwoiC3FOjhBWPLHCphBNN+LAp2NOQcjlLwDN2AmNe8h/E0RGJipLur6+qgJVaI=
X-Received: by 2002:adf:cf05:: with SMTP id o5mr11796362wrj.262.1557950103165;
 Wed, 15 May 2019 12:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190514191050.13181-1-richard@nod.at>
In-Reply-To: <20190514191050.13181-1-richard@nod.at>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 15 May 2019 21:54:51 +0200
Message-ID: <CAFLxGvz1OAbqj=Hf4dyJ2SuUJjYCj2KMFhj-9nVE3mQzNoKH2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ubifs: Use correct config name for encryption
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 9:11 PM Richard Weinberger <richard@nod.at> wrote:
>
> CONFIG_UBIFS_FS_ENCRYPTION is gone, fscrypt is now
> controlled via CONFIG_FS_ENCRYPTION.
> This problem slipped into the tree because of a mis-merge on
> my side.
>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: eea2c05d927b ("ubifs: Remove #ifdef around CONFIG_FS_ENCRYPTION")
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/ubifs/sb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
> index 2afc8b1d4c3b..3ca41965db6e 100644
> --- a/fs/ubifs/sb.c
> +++ b/fs/ubifs/sb.c
> @@ -748,7 +748,7 @@ int ubifs_read_superblock(struct ubifs_info *c)
>                 goto out;
>         }
>
> -       if (!IS_ENABLED(CONFIG_UBIFS_FS_ENCRYPTION) && c->encrypted) {
> +       if (!IS_ENABLED(CONFIG_FS_ENCRYPTION) && c->encrypted) {
>                 ubifs_err(c, "file system contains encrypted files but UBIFS"
>                              " was built without crypto support.");
>                 err = -EINVAL;
> @@ -941,7 +941,7 @@ int ubifs_enable_encryption(struct ubifs_info *c)
>         int err;
>         struct ubifs_sb_node *sup = c->sup_node;
>
> -       if (!IS_ENABLED(CONFIG_UBIFS_FS_ENCRYPTION))
> +       if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
>                 return -EOPNOTSUPP;
>
>         if (c->encrypted)
> --
> 2.16.4

Applied both.

-- 
Thanks,
//richard
