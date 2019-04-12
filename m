Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EA5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BF820850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHixQhHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDLSHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:07:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46284 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDLSHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:07:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so12215763qts.13;
        Fri, 12 Apr 2019 11:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pp9ClMaBMXR/SmhwrxlZqs/SXnIO6aLteUAuDWQUrl4=;
        b=eHixQhHw8Ps0tY3JzGNX4Oox6mL596mtYp6fPgksOLoa6Gke74ltjf3kso3o004VRF
         R7j/TOg6DhnGSocSqBxADitmtOrj6LfhtUOJeBSl8XQ9InXd/Qar146t9jbhVwCLNhQH
         Aqs88wrUCMkJ/ikvDprJawyJxeTZKHdM4al4YdilpGS1zoEMSks4QEE+aW+mdvmlKaPy
         Ca7xgqYfhT9hXkd2gH46yXTqVzdVlwghiiDesUBd9Eq4nF/cEosrPOtGEhJU9F0EFWAx
         QHxwAm33Dgr3CfMh5AtsPhzGTWf53s3dSf0NqkWrbl1FYsVpY//Qt9oeUDIGqljmswn1
         ThfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pp9ClMaBMXR/SmhwrxlZqs/SXnIO6aLteUAuDWQUrl4=;
        b=ZkIt2TZQEbysCGiFQ0xL2NnBEHIQOYL/8JFFO4NBIFt+CgSsHkXGnP8AAcWr22WW/j
         RknKXetcfcLqrA9WATVZlLVJZt86ta7/zQo0OgskZH9oLpV+J7HBto66M47ChXSPh+OB
         OAZ+8x39Esmv6J9DquYZiyLZumO+IkGMOOtA2n/4imdzBXJjU0lzTx7RywVcxFHQGW+6
         uYMT/g0l7B5vIszpqzg3ZOnOoS1gJc+gyeY8bIP7f5ONxbJBmoB0bE6H1k3DvtFkHTmi
         l9+z0a54akGU+tv6wHgqpRIxlAmFZwocxG2DC9NasQZ8O7MRxx8vG4eQ2vkhF2TvZ2au
         at+A==
X-Gm-Message-State: APjAAAUP/U2fwRyE/RxfNb7MvQkhnSljvhLlX08QphUvMClEmMT1ds0+
        OPt6IdHvPur3yQpZm+WUh16Komra9p6s7E25+tM=
X-Google-Smtp-Source: APXvYqyLIc/gxmMRQTSd4sGD4kXCpk5Pldzd4ZbWzLsHnOlXuzQl5W29CZ2JF4UTdr+9amiFuMEOpV19PDibIWsvQxI=
X-Received: by 2002:ac8:1876:: with SMTP id n51mr48097546qtk.234.1555092465264;
 Fri, 12 Apr 2019 11:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190412124050.32120-1-alban@kinvolk.io> <8fb1d2e0-f8c0-4e01-ddf8-158c9e80558c@netronome.com>
In-Reply-To: <8fb1d2e0-f8c0-4e01-ddf8-158c9e80558c@netronome.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 12 Apr 2019 11:07:34 -0700
Message-ID: <CAPhsuW4KENxuuafRFx9ak5rS4mf_i9yO2tN9WqGcB0nM01KiuA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] tools: bpftool: fix infinite loop in map create
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, alban@kinvolk.io,
        iago@kinvolk.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 6:21 AM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> 2019-04-12 14:40 UTC+0200 ~ Alban Crequy <alban.crequy@gmail.com>
> > From: Alban Crequy <alban@kinvolk.io>
> >
> > "bpftool map create" has an infinite loop on "while (argc)". The error
> > case is missing.
> >
> > Symptoms: when forgetting to type the keyword 'type' in front of 'hash':
> > $ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
> > (infinite loop, taking all the CPU)
> > ^C
> >
> > After the patch:
> > $ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
> > Error: unknown arg hash
> >
> > Fixes: 0b592b5a01be ("tools: bpftool: add map create command")
> > Signed-off-by: Alban Crequy <alban@kinvolk.io>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for the fix!

> >
> > ---
> >
> > Changes in v2:
> > - Explain the cause of the bug in commitmsg
> > - Add the "fixes" line in the commitmsg (Jakub's review)
> > - Rebase on the bpf tree
> >
> > v1 was initially based on bpf-next and submitted on
> > https://marc.info/?l=linux-kernel&m=155310327709613&w=2
> > ---
> >  tools/bpf/bpftool/map.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > index 05b029b934a6..1ccc38718458 100644
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -1151,6 +1151,9 @@ static int do_create(int argc, char **argv)
> >                               return -1;
> >                       }
> >                       NEXT_ARG();
> > +             } else {
> > +                     p_err("unknown arg %s", *argv);
> > +                     return -1;
> >               }
> >       }
> >
> >
>
> Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
>
> Thanks Alban!
