Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE74C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB352238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLv0cVd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfGXBkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 21:40:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38896 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGXBkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 21:40:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so21292340plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 18:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=QhOFU/fISU1StcR5rsBvctRcjsODwkc42KNRg+/GgVY=;
        b=ZLv0cVd01euJIkkYBcyojTVWvrTWSL+0wg72aMHxNHN9HfkAK6IDIJSF8+H6VfhRLN
         7gV9go9KgkozhVY4z6hbrBZ0jNbZB3U5VBq0Ui0KB3uHuJnKOIBQM65X1wTvO7O6OHID
         NuXSE7X5luRWT1nC+w8x1Jf3mosRDAiLG1K0uuU9M/WvL2PtEAr5TgG09tvCvXMSgulC
         zmaqlub7Dl6p16UAIxDFaSbyA2PPis27+oQ5bEwU99A25TVAX9PqgVjT4mol7f11tsvS
         d+Y01RfKkDLoFgxRApFikjuddYdkvvvb8h3KW/cJ87uNjkDGYZpBTM8251S+mnmxUrIK
         93dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=QhOFU/fISU1StcR5rsBvctRcjsODwkc42KNRg+/GgVY=;
        b=RR+8BGGvP1ptB0/0njNXEmyxZ2YBYavex96cPMmSb15WoBkP+7EKqKvWoKyfeYyTZg
         UcKyFIFFau97023KUiEYKRC98oZAZScDM2lPUZZjMB+TdApgiaiOuci7gBnc4YlcteLI
         Mz7phlF17c5RoN7v9OOUSkJ0XwZ30wGacglLvIHdzzjV6krRwkPf1QSBiCUyhjx/OdEh
         xULgfctHUdu8CgBJr1kXKaZUPjC1nQYCBl1CeZhYwepn0RaVXc6vPx5YHVcGM2nvJ6lt
         gHNgIY8442qveRIkf2+JSykeDPwEIkyyrQmNIs/DbcK9NJcVdm4wjn+buLzFm0dLq1Lu
         umLA==
X-Gm-Message-State: APjAAAWUROcwlbaidTP2FBYE7PYmZNOzZgb61yqG17sw9zcpfGOodk70
        3DZ4+EuLKpkuYWnQD/TbWtHQoR6X
X-Google-Smtp-Source: APXvYqz+ZWSGTYqOSMnqGmgi8VpqVWhnfcZ+cp3rcSMfkYCjnap01qGpQzv14FIKiY0/97wm62IKqQ==
X-Received: by 2002:a17:902:1e2:: with SMTP id b89mr85307851plb.7.1563932415149;
        Tue, 23 Jul 2019 18:40:15 -0700 (PDT)
Received: from localhost ([220.240.251.33])
        by smtp.gmail.com with ESMTPSA id n98sm44777325pjc.26.2019.07.23.18.40.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 18:40:14 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:40:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kbuild: clean compressed initramfs image
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>
Cc:     linux-kernel@vger.kernel.org
References: <20190722063251.55541-1-gthelen@google.com>
In-Reply-To: <20190722063251.55541-1-gthelen@google.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563932322.lqg59sj895.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Thelen's on July 22, 2019 4:32 pm:
> Since commit 9e3596b0c653 ("kbuild: initramfs cleanup, set target from
> Kconfig") "make clean" leaves behind compressed initramfs images.
> Example:
>   $ make defconfig
>   $ sed -i 's|CONFIG_INITRAMFS_SOURCE=3D""|CONFIG_INITRAMFS_SOURCE=3D"/tm=
p/ir.cpio"|' .config
>   $ make olddefconfig
>   $ make -s
>   $ make -s clean
>   $ git clean -ndxf | grep initramfs
>   Would remove usr/initramfs_data.cpio.gz
>=20
> clean rules do not have CONFIG_* context so they do not know which
> compression format was used.  Thus they don't know which files to
> delete.
>=20
> Tell clean to delete all possible compression formats.
>=20
> Once patched usr/initramfs_data.cpio.gz and friends are deleted by
> "make clean".
>=20
> Fixes: 9e3596b0c653 ("kbuild: initramfs cleanup, set target from Kconfig"=
)
> Signed-off-by: Greg Thelen <gthelen@google.com>

Thanks for that, looks good to me.

Thanks,
Nick
=
