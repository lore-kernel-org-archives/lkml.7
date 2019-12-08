Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9C3C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 20:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735BB20637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 20:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwIHKoYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfLHUZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 15:25:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52480 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfLHUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 15:25:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so13217554wmc.2;
        Sun, 08 Dec 2019 12:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rZuOVSsIOLORgQcyJUkFkX7+NHfebp3ftqDZpnNhVHI=;
        b=kwIHKoYHrbfekVTgSUlg1aLlX9zpLbsy6LZrajc6UkAYDIeNweO0S0s4hsvP1GtsU/
         34453WviStBNhCXxisY8OaAsrKEqKM4f27LS5VW1NryK85Bhp5Ik6P4Z9Aj9eGJveQ6C
         /Fkc9neUMThjUO1JZMhbCw6y3Iy+89Dfst8RXduhjM8a1DcB86KAmu5QbFgHJbjMQPqp
         2mHHH601DHQLZ7Q76zhdnyrk86HgPZT49SWIRwzZYSp3W/4JNTdf3KR1ztOdTLz8rsr+
         SkYBUIw7IRpyEi41n7PaQLm6uVozsLXtB8a1OK+KBpN8uoHy/LJ5eL5ZkZXDymZUiHFM
         SWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rZuOVSsIOLORgQcyJUkFkX7+NHfebp3ftqDZpnNhVHI=;
        b=fbU9vYsUQYX5f6Jx2psnUsLw1LTOTUmP9BeyNhuqpZiKmpG0Qgamu7JTzh7vlt4l0j
         oq8/KJ9Wsb23ZOKusXyPOPg9TYx9KytM9SFSoDaaZpi7IEN0pgG2AEh+FZMmzB8svDD+
         hTQdm8QKJRPuNnBXEOUSgUzZsAOzwMwNeRXn7EEHX90J2hhRx72+LRzUm4WOyFFTFIkP
         E9PpUaQPW65W0g7C0APG+GM7fdgg2be2nVyAfh2/LpSUdgopIETR+05Qb6QNxT61FL8b
         6GPluWgD7HrmNXeg1ffxNu/DYzzF8ogcD9XBg3HZDv8EwYDG4H8hzBVnQ4VgTWEZU9Z+
         CRlA==
X-Gm-Message-State: APjAAAWoIczHQQuAaI4wKIyfUck68uuDE3l082riwUVFrs5Jt/p/auS4
        ZhikDAlv6x3Wy6Vr+PhcITfXrvuOGeIXSYZzD/j25ZEPMTA=
X-Google-Smtp-Source: APXvYqxwE0DDF5AzVPKzIWQIP3EkMtREDeLD3Y5ZUEHq7I+yta13o8/zhbVIu3lpq2QcAAfttUOSqMRUeV81a7wEcmk=
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr22284690wmh.30.1575836722869;
 Sun, 08 Dec 2019 12:25:22 -0800 (PST)
MIME-Version: 1.0
References: <1575554335-27197-1-git-send-email-alencar.fmce@imbel.gov.br> <201912090055.QXDo7ygw%lkp@intel.com>
In-Reply-To: <201912090055.QXDo7ygw%lkp@intel.com>
From:   Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Date:   Sun, 8 Dec 2019 17:25:11 -0300
Message-ID: <CACk9uecHrKDQHdL=fgz0xVF4oKUBOUUyRAt-cMn6m0YCOf9v_g@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: added driver for sharp memory lcd displays
To:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rodrigo Rolim Mendes de <alencar.fmce@imbel.gov.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Em dom., 8 de dez. de 2019 =C3=A0s 13:56, kbuild test robot <lkp@intel.com>=
 escreveu:
>
> Hi Rodrigo,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linux/master]
> [also build test WARNING on robh/for-next linus/master v5.4 next-20191208=
]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>
> url:    https://github.com/0day-ci/linux/commits/Rodrigo-Rolim-Mendes-de-=
Alencar/video-fbdev-added-driver-for-sharp-memory-lcd-displays/20191207-112=
607
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 26bc672134241a080a83b2ab9aa8abede8d30e1c
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-91-g817270f-dirty
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
> >> drivers/video/fbdev/smemlcdfb.c:71:29: sparse: sparse: incorrect type =
in initializer (different address spaces) @@    expected unsigned char [use=
rtype] *vmem @@    got signed char [usertype] *vmem @@
> >> drivers/video/fbdev/smemlcdfb.c:71:29: sparse:    expected unsigned ch=
ar [usertype] *vmem
> >> drivers/video/fbdev/smemlcdfb.c:71:29: sparse:    got char [noderef] <=
asn:2> *screen_base
>
> vim +71 drivers/video/fbdev/smemlcdfb.c
>
>     67
>     68  static void smemlcd_update(struct smemlcd_par *par)
>     69  {
>     70          struct spi_device *spi =3D par->spi;
>   > 71          u8 *vmem =3D par->info->screen_base;

A cast is really necessary here?

>     72          u8 *buf_ptr =3D par->spi_buf;
>     73          int ret;
>     74          u32 i,j;
>     75
>     76          if (par->start + par->height > par->info->var.yres) {
>     77                  par->start =3D 0;
>     78                  par->height =3D 0;
>     79          }
>     80          /* go to start line */
>     81          vmem +=3D par->start * par->vmem_width;
>     82          /* update vcom */
>     83          par->vcom ^=3D SMEMLCD_FRAME_INVERSION;
>     84          /* mode selection */
>     85          *(buf_ptr++) =3D (par->height)? (SMEMLCD_DATA_UPDATE | pa=
r->vcom) : par->vcom;
>     86
>     87          /* not all SPI masters have LSB-first mode, bitrev8 is us=
ed */
>     88          for (i =3D par->start + 1; i < par->start + par->height +=
 1; i++) {
>     89                  /* gate line address */
>     90                  *(buf_ptr++) =3D bitrev8(i);
>     91                  /* data writing */
>     92                  for (j =3D 0; j < par->spi_width; j++)
>     93                          *(buf_ptr++) =3D bitrev8(*(vmem++));
>     94                  /* dummy data */
>     95                  *(buf_ptr++) =3D SMEMLCD_DUMMY_DATA;
>     96                  /* video memory alignment */
>     97                  for (; j < par->vmem_width; j++)
>     98                          vmem++;
>     99          }
>    100          /* dummy data */
>    101          *(buf_ptr++) =3D SMEMLCD_DUMMY_DATA;
>    102
>    103          ret =3D spi_write(spi, &(par->spi_buf[0]), par->height * =
(par->spi_width + 2) + 2);
>    104          if (ret < 0)
>    105                  dev_err(&spi->dev, "Couldn't send SPI command.\n"=
);
>    106
>    107          par->start =3D U32_MAX;
>    108          par->height =3D 0;
>    109  }
>    110
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology C=
enter
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corpor=
ation
