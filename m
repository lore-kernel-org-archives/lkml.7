Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8478FC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F02520870
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="mcQrIs3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDMVsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:48:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42593 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfDMVsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:48:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id cv12so6757669plb.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zWHQFrxQ5ALEL7e28WuS09c9TVADIx4+Uu943gYarPE=;
        b=mcQrIs3MsenKCn846ImL7z1F5wO+h8oXflpilDQP0Ra+4ev2WG/AGd4odQSRuGZJLP
         tw6wdX5l+MY5tAruHcaZ3UG8FabivNUyagOxF9XJ1XkNAv3SjeYZZEDp8fDZwGRdQkEx
         GzioCt82HcKH1JIOH19Ahd4LKLzafpvbv3tuFDafKre8JYCtasLnIodQ/Tydbh4wYPnu
         DNmITr+JmHp6DpeK355pds29xmtOx4f21AS2wmN8MWpnoRCgEPGj8YDvOWhLZq/J2+6n
         9Qc6moLGsQaq6DDofnuRtP8t3JcMHlpEh25PSkC8eunbhqeDJnJUTIexM1+C7M73XYl3
         umiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zWHQFrxQ5ALEL7e28WuS09c9TVADIx4+Uu943gYarPE=;
        b=BQrJH/BNBjY+IKlLQlRKB86I0MMGKBiuL6ZyB4ry25u8Qkpkn8wQa71HX1n+dTguPb
         H1SIetO4CtXxR90GfWHPjD/+U2Ffbp24tIwLY4nP0+WdmUKq4By5bzishIk0t5ms3i6K
         2skR5l5rG5KERzDYcOJ86aY5QX+SWxR0ulMJEu3CW7s7X8XuNOf0KAQromg70i1rk2Tl
         rmLMEevI1tA4IunMt2VW5IVcoD0AffxBLJsd3MhlQQ3E0a4KD+VP70vWQIZ5fPfk45Xs
         MI4Kq/BWWa7EvyPfhY2yv6gG1rICpWYKIAdyoeczFZ7VHNLIBaGXsNaJMKxu5II48SML
         vOXg==
X-Gm-Message-State: APjAAAUebsCf3Yiz5mhnrtXcPyx0MXSyQ1nYshbsNMhlnq02Q2JAAg+c
        niCM3Q08eRyd672X/ew7yL1Gu8Zd+q8=
X-Google-Smtp-Source: APXvYqxJcIC6nBtFc9phwWayjV8Y9NS2lRuIiTE28pcGdlM5rkn+qdwuh8AxN/1BIKyXinwdE2uqBw==
X-Received: by 2002:a17:902:294b:: with SMTP id g69mr16951876plb.57.1555192124506;
        Sat, 13 Apr 2019 14:48:44 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02d:84af:491a:f204:96d6:e161? ([2600:1010:b02d:84af:491a:f204:96d6:e161])
        by smtp.gmail.com with ESMTPSA id e13sm68110611pgb.37.2019.04.13.14.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 14:48:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] new flag COPY_FILE_RANGE_FILESIZE for copy_file_range()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190413204947.9394-1-shawn@git.icu>
Date:   Sat, 13 Apr 2019 14:48:41 -0700
Cc:     linux-api@vger.kernel, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <40254CBE-34B0-4783-8B19-FE7EA0BDA1E3@amacapital.net>
References: <20190413204947.9394-1-shawn@git.icu>
To:     Shawn Landden <shawn@git.icu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 13, 2019, at 1:49 PM, Shawn Landden <shawn@git.icu> wrote:
>=20
> If flags includes COPY_FILE_RANGE_FILESIZE then the length
> copied is the length of the file. off_in and off_out are
> ignored. len must be 0 or the file size.
>=20
> This implementation saves a call to stat() in the common case
> of copying files. It does not fix any race conditions, but that
> is possible in the future with this interface.
>=20
> EAGAIN: If COPY_FILE_RANGE_FILESIZE was passed and len is not 0
> or the file size.

I think you=E2=80=99re asking for trouble here. I assume you have some kind o=
f race prevention in mind here.  The trouble is that passing zero means copy=
 the whole thing, but the size-checking behavior is only available for nonze=
ro sizes. This means that anyone who passes their idea of the size needs to a=
ccount for inconsistent behavior if the size is zero.

Also, what happens if the file size changes mid copy?  I assume the result i=
s more or less arbitrary, but you should document what behavior is allowed. =
 The docs should cover the case where you race against an O_APPEND write.

>=20
> Signed-off-by: Shawn Landden <shawn@git.icu>
> CC: <linux-api@vger.kernel.org>
> ---
> fs/read_write.c           | 14 +++++++++++++-
> include/uapi/linux/stat.h |  4 ++++
> 2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 61b43ad7608e..6d06361f0856 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1557,7 +1557,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, lo=
ff_t pos_in,
>    struct inode *inode_out =3D file_inode(file_out);
>    ssize_t ret;
>=20
> -    if (flags !=3D 0)
> +    if ((flags & ~COPY_FILE_RANGE_FILESIZE) !=3D 0)
>        return -EINVAL;
>=20
>    if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
> @@ -1565,6 +1565,18 @@ ssize_t vfs_copy_file_range(struct file *file_in, l=
off_t pos_in,
>    if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
>        return -EINVAL;
>=20
> +    if (flags & COPY_FILE_RANGE_FILESIZE) {
> +        struct kstat stat;
> +        int error;
> +        error =3D vfs_getattr(&file_in->f_path, &stat,
> +                    STATX_SIZE, 0);
> +        if (error < 0)
> +            return error;
> +        if (!(len =3D=3D 0 || len =3D=3D stat.size))
> +            return -EAGAIN;
> +        len =3D stat.size;
> +    }
> +
>    ret =3D rw_verify_area(READ, file_in, &pos_in, len);
>    if (unlikely(ret))
>        return ret;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7b35e98d3c58..1075aa4666ef 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -170,5 +170,9 @@ struct statx {
>=20
> #define STATX_ATTR_AUTOMOUNT        0x00001000 /* Dir: Automount trigger *=
/
>=20
> +/*
> + * Flags for copy_file_range()
> + */
> +#define COPY_FILE_RANGE_FILESIZE    0x00000001 /* Copy the full length of=
 the input file */
>=20
> #endif /* _UAPI_LINUX_STAT_H */
> --=20
> 2.20.1
>=20
