Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74757C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2630C21734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxlQrygY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfEQTJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:09:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42649 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfEQTJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:09:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id 188so7201888ljf.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=db6mb74L+PPicDHpwKuPDnVCSGYCzF4jUKKVjxH/fvA=;
        b=HxlQrygYJrKchUDVDSf2nIYdkzxe8tCRKX9+Capc53EO5ZZnImjAQCI6skqbbZ50Kn
         NjM/GIGNZLGPiQ1Z+HIzZwAX9fl1NHE2hY4t5Tg2VDKFYRnpzU9bqnWr64tpSEpboZIM
         Ve5Pgn/4I0W/nvzYntd6nJTsYkflykUC42P8yDRUX8ijxEv3Bgaowy2HnJWwzg6pVmXr
         pAsB4OP43cUDzRPtcZL6FkLW2+YinmbLwh+Fio8RaMLNkvYAwWQOKeUfxKs4gI3OWdIR
         G0swZy3zI1AHkulw0We5g9kZkgCYfWayKlQvMY7j1nTnINZyHpBulc2brn1lzNJ6YCBG
         KTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=db6mb74L+PPicDHpwKuPDnVCSGYCzF4jUKKVjxH/fvA=;
        b=HfzGsTyw+/3uiI6gYszHpDoSoxeipT0NBgFDNhuL86IGLxm/HhcJ2yKx5kuzU1LO+3
         y473IKZvzbgKPJx9lqPL+Tvgf7y8KIab732C168O+1vb/PBsXfE9gi3a2+rVuIiBGo3n
         9FJSnGKE5jZhPJAuUg2D0+ac/3p6WMP2NLFuR4L16Y7Pt5zPSpEReesZpwS4x/pqd4/r
         3I8unGI4rc/NJlD+HJP9XuC9cWI/FaiIDjR2prnhgzkPQaiPcGG+ftZ3zcDh2WEyYZ6M
         Ofwtu6romL6Jv3WeBpNMP4Oe4iraJ+WRA8quPR368K4L9jNTznUdGO94IJb0780VmT6E
         Hrww==
X-Gm-Message-State: APjAAAX16XD3GYDClGSV4j10O+xz1276dX88GZb7nzlxtQb4Z4u9/hO0
        80Mf/tGxOsuI1usbWlTJ7nxKrQD0AHP8hwyYvUE=
X-Google-Smtp-Source: APXvYqzywiUzI5+5xKOFVoME6HGMZ5ebHqKQoEafbsG9ztvNhIrdBxOhHI5TLR5QPW6Hx1IupdOzDbdrWdYRTB/bfu4=
X-Received: by 2002:a2e:84a:: with SMTP id g10mr18381763ljd.98.1558120172354;
 Fri, 17 May 2019 12:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190517092502.GA22779@gmail.com> <CAHk-=wiNkOU-Ng+9_+tj4-AqJ4Q9JQpVbR4QVVAWLY68yQ62Gw@mail.gmail.com>
In-Reply-To: <CAHk-=wiNkOU-Ng+9_+tj4-AqJ4Q9JQpVbR4QVVAWLY68yQ62Gw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 17 May 2019 21:09:21 +0200
Message-ID: <CANiq72=hUULnd_oDoGoD2gjE-QvL2Kw2n7hMxke+gkS2_gzCqw@mail.gmail.com>
Subject: Re: [PATCH] tracing: silence GCC 9 array bounds warning
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 7:59 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, May 17, 2019 at 2:25 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > +       memset((char *)(iter) + offsetof(struct trace_iterator, seq), 0,
> > +              sizeof(struct trace_iterator) -
> > +              offsetof(struct trace_iterator, seq));
>
> Honestly, the above is nasty.
>
> Whenever you have to split an expression or statement over several
> lines, you should ask yourself why it's so complicated.

Will do -- I was trying to keep the code as closely to the original as
possible (I simply replaced the &iter.seq expression :-)

By the way, how do you all feel about moving this as a generic
facility to zero out the suffix/prefix of an structure? In particular,
since we won't have the LAT* stuff according to Steven.

> Also, the while 'offset' is a variable, any compiler will immediately
> see that it's a constant value, so it's not like this will affect the
> generated code at all.

I like C++'s constexpr (for variable defs), maybe one day we will get
it on C; it is useful to cleanly annotate compile-time values like
this.

> Unless you compile with something crazy like
> '-O0', which is not a supported configuration exactly because we
> expect compilers to not be terminally stupid.

Fun fact: it seems clang folds some of these even under -O0. In
godbolt I see it folding the third argument completely. The first one
isn't, but it is computed on the function prologue, leaving the
'offset' variable unused.

Cheers,
Miguel
