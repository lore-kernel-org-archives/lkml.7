Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20619C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E269820881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1oRFTFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEOVGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:06:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46157 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEOVGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:06:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so935572wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KN7Op8lE6XgA0shW6xktX/J0QHQnjwUaX3FOZZZptkU=;
        b=W1oRFTFB+24xB+dtaPBmivucI2kyqv7HBmqrRT6TiBIAZepFI8cpCTuHRSujHsiFFw
         kF1ynOa5KxIzHoc+FiWvomXszb3JbiTBHQWj/ASpd7QsZetKDscojrxmGgpLSLu7+SvX
         my4zgYux7+/Q1Jz0SvTVb33f6s7XPup0ZI9KzAb9jrvWtjZsFjH7gVrkHSTj4b6eXpaZ
         DLZAnMbwXMsnfIeKJg5zC3I+0Wo0Vy93w8ujem1zPrXmjrMxSUzmLym3MgpXgBjGEAgX
         bqjstVLBAQ+0iCAaUpB2nsSI8AhEoDAYYQN3NxM5hAJNdwv0jhivgUUqLGfSj8oZjWTv
         0uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KN7Op8lE6XgA0shW6xktX/J0QHQnjwUaX3FOZZZptkU=;
        b=nwAIK48sz9reXFJQ31c/aN4GVEe2FBTgzNDQDWmk60caKNXQfbJCSL9TXNbBNrndbi
         hwghxLLUUK/+Uym2KVzAAu68TfX0LSUYsAM71kGgwqOCfVAjB99XWz/lApgcD473Bzmm
         kFsi0ao7ALdAWLJ+pmvI9AxGBekTK2dmrwm0IvcNTvWZBDK8r0bGyb2beWjFXF/wXgJh
         +6GxHw0mf3uMcIlrnSXPX1RIM+OOP65FtUvkKccmKudsxFW0gnvlriHX+0RhU+gSzBd1
         /KYHmEBj72ALHObr+uKJ79MzRNiueBwek/Lq7PZazT8e2kwjfC+DaQ++VpVT9rvIJ+sv
         J35A==
X-Gm-Message-State: APjAAAWiNaodsXvbS6lXpPU2bJ2HJw3oST8UMFB+8YSEiY8urxqFmqOV
        i25cn+f8BRW/jM4H8ybrsjnuOH1oSKbP8Ss/ugk=
X-Google-Smtp-Source: APXvYqwAMzD0Lt4RMl1/MNnHtLMYf029HK7zHQSyGiKTKart3sXQ5sO9KRXCgQBrjKViszRocXAsqK+ObAN9qtsIUVE=
X-Received: by 2002:adf:eb91:: with SMTP id t17mr9729539wrn.203.1557954373482;
 Wed, 15 May 2019 14:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190506212327.6480-1-bnvandana@gmail.com>
In-Reply-To: <20190506212327.6480-1-bnvandana@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 15 May 2019 23:06:02 +0200
Message-ID: <CAFLxGvzW=Z3Lk==NXS159DF4WUJqzAELS_E++ruKDVio_hfo4A@mail.gmail.com>
Subject: Re: [PATCH] fs: ubifs: Resolve sparse warning for using plain integer
 as NULL pointer
To:     Vandana BN <bnvandana@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 11:24 PM Vandana BN <bnvandana@gmail.com> wrote:
>
> fs/ubifs/xattr.c:615:58: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Vandana BN <bnvandana@gmail.com>
> ---
>  fs/ubifs/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index f5ad1ede7990..066a5666c50f 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -612,7 +612,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
>         int err;
>
>         err = security_inode_init_security(inode, dentry, qstr,
> -                                          &init_xattrs, 0);
> +                                          &init_xattrs, NULL);
>         if (err) {
>                 struct ubifs_info *c = dentry->i_sb->s_fs_info;
>                 ubifs_err(c, "cannot initialize security for inode %lu, error %d",
> --
> 2.17.1

Applied.

-- 
Thanks,
//richard
