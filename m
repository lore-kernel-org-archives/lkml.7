Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F46EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB622075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihd2aO2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfECDls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 23:41:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36458 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfECDls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 23:41:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so2047641pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 20:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O622YIhyxrmf2r9JTZlsen0SoxQsmKCxpBoUMTPKsKo=;
        b=Ihd2aO2JJgnMbncKxuJMRhZ1ZCDwmjp0EM5wZO5qzawVYJUNL0OkfI/G8VzvM87v5n
         0lfdBae25fqMlpvTBR2iVtGW60vB9dikdysFqwRKbqWrnC7/LhtyTa+VeTqq2VUqurGw
         Mmi4fqFRSoLXvHG7JQWOxW2a976o4C5tnkTOBegI/Q2SJ1fN8fbe76//91G69mNewv8p
         6dtz5wb0A3BIcUU51v+n0r3M0YwYbCN9vecxd/uE4OTs+7I7DOfjCRIeRHKGxrgEHE4c
         hhpJ8dTXfmLkSw2qZhrokmm0Dg3gxnGX02ldpV1TrC/Ad0qngibj5fgwe87/+hwendZ3
         PwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O622YIhyxrmf2r9JTZlsen0SoxQsmKCxpBoUMTPKsKo=;
        b=SAJY9AbJL5qxnozK1FpSOfmNHYMsuzDod+NArBCvBk9jU4uCpR6Helrc4KiXQwLm8T
         uSlIoaY0+ZQPEmNcKX7gUK8zSkbcEQwXe5fOUX1Cn9wtHq+mxJKzi/bu78CXEu8nXnqI
         z+MejNaVyViyauH9nr88WEF9TeZwVagf/ZRcbrNac8wfIvVQuFPGYTzXGqfbSurCLra2
         dzaykji0zDCvcm+98MK9qFqL8STG4R0he7Ino8/YohhN5relf/EWr1PdVCSdMkUJFcLw
         XDx+wHy9S9MDJH8ZLs1cWXlqPiG7YJyrGAi2EkCCprF2xXxPOY6pJ6qlv2DlaSk3fQUx
         2F4A==
X-Gm-Message-State: APjAAAVgogk4W0N6auZbeVpor+calunQACIjJ56JVVR4+c1rxlmNqSB+
        5QdTGX0J/nIvSD5xStaSE6/ZasRkARiaLI/JTjo=
X-Google-Smtp-Source: APXvYqzjgnX+D9rLrQlfRkw/onVis/I8/ZL4xiaVaWMGXPNMN7QErsZfqJZACA+5aMAx0Ma2t0cnhYBi87ggcwlWtQM=
X-Received: by 2002:a65:5289:: with SMTP id y9mr7787613pgp.52.1556854907327;
 Thu, 02 May 2019 20:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <1556787561-5113-3-git-send-email-akinobu.mita@gmail.com> <f0f772e5e33519dac93672be26fa7995f8109721.camel@sipsolutions.net>
In-Reply-To: <f0f772e5e33519dac93672be26fa7995f8109721.camel@sipsolutions.net>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 3 May 2019 12:41:36 +0900
Message-ID: <CAC5umyhyVNA63OUQsw=SSP_poPOwQ+Y7sPRRpGLaJXb7T-C3Ug@mail.gmail.com>
Subject: Re: [PATCH 2/4] devcoredump: allow to create several coredump files
 in one device
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=882=E6=97=A5(=E6=9C=A8) 21:47 Johannes Berg <johannes@=
sipsolutions.net>:
>
> On Thu, 2019-05-02 at 17:59 +0900, Akinobu Mita wrote:
> >
> >  static void devcd_del(struct work_struct *wk)
> >  {
> >       struct devcd_entry *devcd;
> > +     int i;
> >
> >       devcd =3D container_of(wk, struct devcd_entry, del_wk.work);
> >
> > +     for (i =3D 0; i < devcd->num_files; i++) {
> > +             device_remove_bin_file(&devcd->devcd_dev,
> > +                                    &devcd->files[i].bin_attr);
> > +     }
>
> Not much value in the braces?

OK.  I tend to use braces where a single statement but multiple lines.

> > +static struct devcd_entry *devcd_alloc(struct dev_coredumpm_bulk_data =
*files,
> > +                                    int num_files, gfp_t gfp)
> > +{
> > +     struct devcd_entry *devcd;
> > +     int i;
> > +
> > +     devcd =3D kzalloc(sizeof(*devcd), gfp);
> > +     if (!devcd)
> > +             return NULL;
> > +
> > +     devcd->files =3D kcalloc(num_files, sizeof(devcd->files[0]), gfp)=
;
> > +     if (!devcd->files) {
> > +             kfree(devcd);
> > +             return NULL;
> > +     }
> > +     devcd->num_files =3D num_files;
>
> IMHO it would be nicer to allocate all of this in one struct, i.e. have
>
> struct devcd_entry {
>         ...
>         struct devcd_file files[];
> }
>
> (and then use struct_size())

Sounds good.

> > @@ -309,7 +339,41 @@ void dev_coredumpm(struct device *dev, struct modu=
le *owner,
> >   put_module:
> >       module_put(owner);
> >   free:
> > -     free(data);
> > +     for (i =3D 0; i < num_files; i++)
> > +             files[i].free(files[i].data);
> > +}
>
> and then you don't need to do all this kind of thing to free
>
> Otherwise looks fine. I'd worry a bit that existing userspace will only
> capture the 'data' file, rather than a tarball of all files, but I guess
> that's something you'd have to work out then when actually desiring to
> use multiple files.

Your worrying is correct.  I'm going to create a empty 'data' file for nvme
coredump.  Assuming that devcd* always contains the 'data' file at least,
we can simply write to 'data' when the device coredump is no longer needed,
and prepare for the newer coredump.
