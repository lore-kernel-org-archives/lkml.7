Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87FC20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1r2fqNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfDARuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:50:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51986 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732839AbfDAR2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:47 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so398434itk.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oHdWIku2tclNcnAhH24FunEqUZ0tJdj8ojutztjoVos=;
        b=h1r2fqNFjtQTUv3BLeWZy6f/x4WLCFv6JRUhw7kcovAVfAwisYIrDa2bt7p6HN4P50
         AsbJlEqfpKWt1Dgmv7L222M7WmyNRR7oT6Fd/QOOPuAI/V/F/wrheO0GbAXYENGdo44O
         4dsh8dkNBr2CSqff7p8TCNLjmEX69XZjuh0kkTiZpZ3vaHh25VoSJO2M+ZCI9nlMRAwe
         qimKFHoD2f33783IWmMhuoDzx3A+syCwABbKZW8WZ6E34Z1KDd5zudqsZ6/16JgMbjcc
         4ZZ72UzldRlks+WFLKmpvagTIj+iAlmxa3z38EW9VqdiqyelYH2rasZ5a8/UqcVNxNdZ
         54UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oHdWIku2tclNcnAhH24FunEqUZ0tJdj8ojutztjoVos=;
        b=jGujlo/BgN1M3DVh2pu2iQR4vQSeUg3FfMjUpmDxWnZCTD3XrKQwo5PRwWryoqLkny
         cTRowm70Bys1V31EsavbBi6Daziy7a5W99Y4z08zACthBHjkSJwf2tPW9V1IxFfts/Rh
         293KU+VPFRVpAgYAzXJmX3cTpPj7MtD+Zc10PRBxZhA/Rq5lIjL62+dtHig+VKByCiWb
         V5rbdPK10veCvMINCo2A5FI4LkZ8sxxcsxDw/UwzgLguyx4pncQMY5JBhmiNZ7cJk3Sq
         91jXPAVXc09Bzv21joDPMNvliMOASOFKm8SCMeFu7s25QUJLdoD7287ASycHH0nnxTLt
         lCBw==
X-Gm-Message-State: APjAAAWDTpEkih0sIOBgAn9OOPbjMxZ3zChMo/OZMMyyy7TqL3Q1kGSu
        /ystXFtvikGjxBtPqU4uUDnZS6nfcFTXkhdmkR0Ajg==
X-Google-Smtp-Source: APXvYqxq/7KCmG9iyhLJt6BWeJhzEXuLB3S0qV19XPm/NgXhH8pCZu/VETEEf4+QzVrIBneE6x/wxLg0A2NTw1aAlZA=
X-Received: by 2002:a24:2f49:: with SMTP id j70mr506040itj.122.1554139725726;
 Mon, 01 Apr 2019 10:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190401090113.22946-1-jthumshirn@suse.de> <d117fb1a-45e4-a553-082e-36112dfbbf8a@suse.com>
In-Reply-To: <d117fb1a-45e4-a553-082e-36112dfbbf8a@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 1 Apr 2019 19:28:33 +0200
Message-ID: <CACT4Y+Yh-bbrn1x139gxo8B0MqR9NbMoZJeN6iJMTgAnDKp9EA@mail.gmail.com>
Subject: Re: [PATCH] fs/open: Fix most outstanding security bugs
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 4:14 PM Nikolay Borisov <nborisov@suse.com> wrote:
> On 1.04.19 =D0=B3. 12:01 =D1=87., Johannes Thumshirn wrote:
> > Over the last 20 years, the Linux kernel has accumulated hundreds if no=
t
> > thousands of security vulnerabilities.
> >
> > One common pattern in most of these security related reports is process=
es
> > called "syzkaller", "trinity" or "syz-executor" opening files and then
> > abuse kernel interfaces causing kernel crashes or even worse threats us=
ing
> > memory overwrites or by exploiting race conditions.
> >
> > Hunting down these bugs has become time consuming and very expensive, s=
o
> > I've decided to put an end to it.
> >
> > If one of the above mentioned processes tries opening a file, return -E=
PERM
> > indicating this process does not have the permission to open files on L=
inux
> > anymore.
> >
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>
> Ack-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Cc: stable@vger.kernel.org # v1.0+

Do we want to extend this to other subsystems?
Should it be a default secomp filter?

> > ---
> >  fs/open.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/fs/open.c b/fs/open.c
> > index f1c2f855fd43..3a3b460beccd 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1056,6 +1056,20 @@ long do_sys_open(int dfd, const char __user *fil=
ename, int flags, umode_t mode)
> >       struct open_flags op;
> >       int fd =3D build_open_flags(flags, mode, &op);
> >       struct filename *tmp;
> > +     char comm[TASK_COMM_LEN];
> > +     int i;
> > +     static const char * const list[] =3D {
> > +             "syzkaller",
> > +             "syz-executor,"
> > +             "trinity",
> > +             NULL
> > +     };
> > +
> > +     get_task_comm(comm, current);
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(list); i++)
> > +             if (!strncmp(comm, list[i], strlen(list[i])))
> > +                     return -EPERM;
> >
> >       if (fd)
> >               return fd;
> >
