Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A3C2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SKjcRgsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfCNNeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:34:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36733 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfCNNeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:34:01 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so4885112itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xUlh7z/lKkRCT3J0vduxrEEG6Tz3ROEvEex1IpqkdcQ=;
        b=SKjcRgsrYs9xOcrmmdOEKgEctiY//fAALHPUmsYchTZRYoWgvcFDylJ+WRKHcoyEdR
         WehmqM+MIN15r0W4yfN0LtZB4NIkr2COTJlHeKrfCJMwi1CB1a0xrTck7aXwyD42Rfo9
         YxOmavr5lxcOxv5IJBHHbuxLFjpMYVuqMeWPNgNOZzoR9aIofFS2Z97itSeuW/Hj9UsX
         RKL7U7rXdDXYmFZz+YHQczzjHEC4BowkGgP3X/eRi9YO2oLlCSRRTTMIpb466yu08rWA
         Yg2zNtC9O5fcDecOUKkv0M2fBeVd+/bPNh3OPKjB8bV6XdSgmZV4LZgTJDxNYRuN0Met
         0DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xUlh7z/lKkRCT3J0vduxrEEG6Tz3ROEvEex1IpqkdcQ=;
        b=BFkHEOLVlWdDi4h5ZEA1fzzhqv+7EBrfftKjtGFU+AxJ+3g1t7B0WmOr+dWPme+Im6
         BBd7W9NzrTLKeiTR3oq3t/DjY1rPlfHTb2/5vgCrzNeV5Ji37qdzzQ1gXXKIw0B02Xy7
         nhXqhZimFxXGPhmHaHJThCP371T3w/aT1kRVj0lPbFu9y9lurWzHxvT39FJ9EhQZNgGC
         PIFgUgKt9Tudr8h9U34YWWQ0jMNztaHCvw90lFdCSXRzt0nUJPwRc4PWmfcpPP0awDrI
         nBWIK3ZOX2fr85lg2iyU7NVjTJRTeXpa6bLTJe4qeAt8kJOn3s0dJDnYu3tSfO1JSN1U
         OaJA==
X-Gm-Message-State: APjAAAWLFiAkng2lHA8u43j+c8wyCT28xdSBnkQGbpJeoZaL3ievxiLl
        tqGTSWdpFi2F6MTAWy/v43SYXrDPcyiPNZFq68igFA==
X-Google-Smtp-Source: APXvYqz9wnJ/GoPtwVYpSSV0NHbh0k1Hk7JcWClnCk6P7RX/PngAxCo38WNkWnQwULJnSYL0tJ3EIFHOxMAys6UyiXw=
X-Received: by 2002:a02:6012:: with SMTP id i18mr26999023jac.24.1552570440422;
 Thu, 14 Mar 2019 06:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190312133047.16201-1-brgl@bgdev.pl> <56704758-ee74-0e9b-de1c-1dc94deda8d7@cambridgegreys.com>
In-Reply-To: <56704758-ee74-0e9b-de1c-1dc94deda8d7@cambridgegreys.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Mar 2019 14:33:49 +0100
Message-ID: <CAMRc=MdBsovEpMxwyGmHB_AL=pLtPsE3g=+y1ghYeHhXvobYbw@mail.gmail.com>
Subject: Re: [PATCH] um: remove uses of variable length arrays
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 13 mar 2019 o 10:45 Anton Ivanov
<anton.ivanov@cambridgegreys.com> napisa=C5=82(a):
>
> On 12/03/2019 13:30, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > While the affected code is run in user-mode, the build still warns
> > about it. Convert all uses of VLA to dynamic allocations.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   arch/um/os-Linux/umid.c | 36 +++++++++++++++++++++++++++---------
> >   1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
> > index 998fbb445458..e261656fe9d7 100644
> > --- a/arch/um/os-Linux/umid.c
> > +++ b/arch/um/os-Linux/umid.c
> > @@ -135,12 +135,18 @@ static int remove_files_and_dir(char *dir)
> >    */
> >   static inline int is_umdir_used(char *dir)
> >   {
> > -     char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
> > -     char pid[sizeof("nnnnn\0")], *end;
> > +     char pid[sizeof("nnnnn\0")], *end, *file;
> >       int dead, fd, p, n, err;
> > +     size_t filelen;
> >
> > -     n =3D snprintf(file, sizeof(file), "%s/pid", dir);
> > -     if (n >=3D sizeof(file)) {
> > +     err =3D asprintf(&file, "%s/pid", dir);
> > +     if (err < 0)
> > +             return 0;
> > +
> > +     filelen =3D strlen(file);
> > +
> > +     n =3D snprintf(file, filelen, "%s/pid", dir);
> > +     if (n >=3D filelen) {
> >               printk(UM_KERN_ERR "is_umdir_used - pid filename too long=
\n");
> >               err =3D -E2BIG;
> >               goto out;
> > @@ -185,6 +191,7 @@ static inline int is_umdir_used(char *dir)
> >   out_close:
> >       close(fd);
> >   out:
> > +     free(file);
> >       return 0;
> >   }
> >
> > @@ -210,18 +217,21 @@ static int umdir_take_if_dead(char *dir)
> >
> >   static void __init create_pid_file(void)
> >   {
> > -     char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
> > -     char pid[sizeof("nnnnn\0")];
> > +     char pid[sizeof("nnnnn\0")], *file;
> >       int fd, n;
> >
> > -     if (umid_file_name("pid", file, sizeof(file)))
> > +     file =3D malloc(strlen(uml_dir) + UMID_LEN + sizeof("/pid\0"));
> > +     if (!file)
> >               return;
> >
> > +     if (umid_file_name("pid", file, sizeof(file)))
> > +             goto out;
> > +
> >       fd =3D open(file, O_RDWR | O_CREAT | O_EXCL, 0644);
> >       if (fd < 0) {
> >               printk(UM_KERN_ERR "Open of machine pid file \"%s\" faile=
d: "
> >                      "%s\n", file, strerror(errno));
> > -             return;
> > +             goto out;
> >       }
> >
> >       snprintf(pid, sizeof(pid), "%d\n", getpid());
> > @@ -231,6 +241,8 @@ static void __init create_pid_file(void)
> >                      errno);
> >
> >       close(fd);
> > +out:
> > +     free(file);
> >   }
> >
> >   int __init set_umid(char *name)
> > @@ -385,13 +397,19 @@ __uml_setup("uml_dir=3D", set_uml_dir,
> >
> >   static void remove_umid_dir(void)
> >   {
> > -     char dir[strlen(uml_dir) + UMID_LEN + 1], err;
> > +     char *dir, err;
> > +
> > +     dir =3D malloc(strlen(uml_dir) + UMID_LEN + 1);
> > +     if (!dir)
> > +             return;
> >
> >       sprintf(dir, "%s%s", uml_dir, umid);
> >       err =3D remove_files_and_dir(dir);
> >       if (err)
> >               os_warn("%s - remove_files_and_dir failed with err =3D %d=
\n",
> >                       __func__, err);
> > +
> > +     free(dir);
> >   }
> >
> >   __uml_exitcall(remove_umid_dir);
> >
>
> Thanks for bringing it up. It helped me notice that this is actually brok=
en.
>
> PID can be more than 5 digits nowdays.
>
> --

Do you want to take this patch anyway and then apply the fix for the
array on top of that or do you prefer it be fixed before that?

Bart
