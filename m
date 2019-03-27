Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C2BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA0F2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="HPnG45s6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbfC0A2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:28:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46293 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731159AbfC0A1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:27:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so12431888edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 17:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttGnYcamR0cFlhmYOSzuiu48CUxfLJ6Eyuv45erjiFc=;
        b=HPnG45s6cpc3Z4nLBLBjURLtumOKkpNHAAMHpoA8xQXdFKBfs5vUleyMSQ20MsdPcM
         HyG/07tGdZ9wreMGK8A/hJC1SC4Wn1j2GmscS9SAkEvPHlYH481w+/OpeZQZ/8SlS6BP
         4FuqaQY2fFM7McDZCcE0xqmo2JKU8IIvmtCpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttGnYcamR0cFlhmYOSzuiu48CUxfLJ6Eyuv45erjiFc=;
        b=dtPGadFtNMb3NJ5Y3wIP5HIEbneAE7K2X6LOD7Mich0E4KlA2sq5N1vxkNr/efnv+T
         ztiaVgpCMzJgZjcF2PyGYb0c2Y8udxkdhH0EzmkeMN7UBY/+ijizZg+rACJ7P2oMMZ1x
         rVKO1U5zuZDQrs3UJO4mfx4k+tKZ3VPRaIRVfC0lRS0l9o8jVeI9O904twgby559Lq7p
         YP+9cA77jT+vlQ58hhBo3XyqerW5fp8ftdtMgzU4j7COiolB/UzGCmcyil45GWsEUBgX
         j38lM4E+r2ZRroNeinmwCOW5NUuaL0D8TXJeSwtZjyv03Ex34/A78RToQ5ZUFD5nketV
         tpIw==
X-Gm-Message-State: APjAAAWrx2V9n4KsaEeOZBWGubL5yFTobi9cGaK7zk30O/bKQ4POnawi
        DQ4viRRH0ZCo6s1i2kUFIHdORZP8Qrc6pQuYtMqKsg==
X-Google-Smtp-Source: APXvYqzAEr9iJXTBFYGrIW6FDBoj0GbVDW08jBZzI/gcqNhghVuCIQaZhVeBYixQ1KRnc/rUU6kC/jtnpHYIqPhYZW0=
X-Received: by 2002:a17:906:33c7:: with SMTP id w7mr19363750eja.191.1553646023643;
 Tue, 26 Mar 2019 17:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190325195303.GA20629@hari-Inspiron-1545> <20190325161114.6a54bed0@gandalf.local.home>
In-Reply-To: <20190325161114.6a54bed0@gandalf.local.home>
From:   Roopa Prabhu <roopa@cumulusnetworks.com>
Date:   Tue, 26 Mar 2019 17:20:12 -0700
Message-ID: <CAJieiUhMs6BPue67NJvQ=WAkU078OfDskt29uPSsDQatV51jnw@mail.gmail.com>
Subject: Re: [PATCH] trace: events: fix error directive in argument list
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>, mingo@redhat.com,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 1:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Mar 2019 01:23:03 +0530
> Hariprasad Kelam <hariprasad.kelam@gmail.com> wrote:
>
>
> > ---
> >  include/trace/events/neigh.h | 19 +++++--------------
> >  1 file changed, 5 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
> > index 0bdb085..6e310ea 100644
> > --- a/include/trace/events/neigh.h
> > +++ b/include/trace/events/neigh.h
> > @@ -70,15 +70,11 @@ TRACE_EVENT(neigh_update,
> >               else
> >                       *p32 = 0;
> >
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -             if (n->tbl->family == AF_INET6) {
> > -                     pin6 = (struct in6_addr *)__entry->primary_key6;
> > +             if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> >                       *pin6 = *(struct in6_addr *)n->primary_key;
> > -             } else
> > -#endif
> > -             {
> > +             else
> >                       ipv6_addr_set_v4mapped(*p32, pin6);
> > -             }
> > +
> >               __entry->confirmed = n->confirmed;
> >               __entry->updated = n->updated;
> >               __entry->used = n->used;
>
> Not sure why the added pin6 assignment was there to begin with:
>
> <code-snippet>
>                 pin6 = (struct in6_addr *)__entry->primary_key6;
>                 p32 = (__be32 *)__entry->primary_key4;
>
>                 if (n->tbl->family == AF_INET)
>                         *p32 = *(__be32 *)n->primary_key;
>                 else
>                         *p32 = 0;
>
> #if IS_ENABLED(CONFIG_IPV6)
>                 if (n->tbl->family == AF_INET6) {
>                         pin6 = (struct in6_addr *)__entry->primary_key6;
>                         *pin6 = *(struct in6_addr *)n->primary_key;
>                 } else
> #endif
>                 {
>                         ipv6_addr_set_v4mapped(*p32, pin6);
>                 }
> </code-snippet>
>
> It was already assigned. Looks fine to me, at least from a tracing
> point of view.

yes, agree. I will send a follow up patch to remove the redundant pin6
assignment.
