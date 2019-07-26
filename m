Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A933EC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AAA20828
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK5weqvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfGZBC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 21:02:59 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43158 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfGZBC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 21:02:58 -0400
Received: by mail-yw1-f68.google.com with SMTP id n205so19845216ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 18:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXxdgJofBHTfqUont/xN09J93S988kXgtU9AsgYaVqs=;
        b=QK5weqvkNzeEcaSBLhlR27Gq3Pelk7aFxUKr5ZZ5mlWxb7g5ZwhRSWK+XnTKjAniKe
         7nIf/Bjv3xX4qlb4CMBC5+vWMVdehkRTF/iv3X11LeItcfjDNYFquDfx5hFy9XW+tnEX
         A2wSu3AwbOXnPuAMHPP59MOIkrGl8bovU9/btnm76H/ltdNSCr586mV/cwO1ews8Wy9E
         Gmk/t6LbKQraOKkr9xKE7LjFfAqf7KPhWFT8rP3w/MyA4Pf/KkwPnU/Ku3K3V2EPyh7s
         C5j4NwiZtERDNHJl+/armc5+5sJzZEWO3TsDW3ZYj0a8N7ASYIbfEzPueURG//CyOPsC
         bXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXxdgJofBHTfqUont/xN09J93S988kXgtU9AsgYaVqs=;
        b=hVDCN5aG1eEg0th6vynz17OuEnRFPddxszP7XOGFq9Aki2379b5Wy+EM4XezIpPioM
         iS2qj2B5MKY5xvgY6SCBdBD0Dzqf1pfaJhyLR06V/LHHGi4s5J4b3qRxwYYUp6v7tTki
         yXQoVViP9gPLV6gSDIqDO6TqR0rio+tNAOhwNBuU6pyyg43A23vKYldmQxGZOHG8DdQl
         ByOJOuhTuCJGwYulVpO3c/ou7XkK5RYHhHIF7BIgPUKJW46DXOx48X1DvmIxePlUiH07
         cekJjDWoRRysf4ueQzK4YJVdBC5JAzCV/mlgOBXf8OHvXZCO4Z9Pzg5B8oxHgusIzHVs
         Lz+Q==
X-Gm-Message-State: APjAAAV5RvVK1YTluQh9OJ03qZw5EBi6YBXJyd4iHrtavz3l6PTpbt/P
        7mMzeCctYq8Xit2nv3nEn9EZ1AE7
X-Google-Smtp-Source: APXvYqzppjAASqohYDn1EriVY+4XhsxyPiCGyqkzQg1DhVWJqMWEAJpsaXpVDEeBssOmx0Q3iignDQ==
X-Received: by 2002:a81:9152:: with SMTP id i79mr974003ywg.286.1564102976742;
        Thu, 25 Jul 2019 18:02:56 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id a4sm10227503ywe.28.2019.07.25.18.02.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 18:02:55 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id s41so16385857ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 18:02:55 -0700 (PDT)
X-Received: by 2002:a25:5054:: with SMTP id e81mr57568085ybb.390.1564102975137;
 Thu, 25 Jul 2019 18:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190724165803.87470-1-brianvv@google.com> <20190724165803.87470-3-brianvv@google.com>
 <CAPhsuW4HPjXE+zZGmPM9GVPgnVieRr0WOuXfM0W6ec3SB4imDw@mail.gmail.com>
 <CABCgpaXz4hO=iGoswdqYBECWE5eu2AdUgms=hyfKnqz7E+ZgNg@mail.gmail.com>
 <CAPhsuW5NzzeDmNmgqRh0kwHnoQfaD90L44NJ9AbydG_tGJkKiQ@mail.gmail.com>
 <CABCgpaV7mj5DhFqh44rUNVj5XMAyP+n79LrMobW_=DfvEaS4BQ@mail.gmail.com> <20190725235432.lkptx3fafegnm2et@ast-mbp>
In-Reply-To: <20190725235432.lkptx3fafegnm2et@ast-mbp>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 25 Jul 2019 21:02:18 -0400
X-Gmail-Original-Message-ID: <CA+FuTScRHuDDTOLb4pryDNQrKXVxw_my55MkMmQqiURt5UEjeA@mail.gmail.com>
Message-ID: <CA+FuTScRHuDDTOLb4pryDNQrKXVxw_my55MkMmQqiURt5UEjeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: add BPF_MAP_DUMP command to dump more
 than one entry per call
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 7:54 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 25, 2019 at 04:25:53PM -0700, Brian Vazquez wrote:
> > > > > If prev_key is deleted before map_get_next_key(), we get the first key
> > > > > again. This is pretty weird.
> > > >
> > > > Yes, I know. But note that the current scenario happens even for the
> > > > old interface (imagine you are walking a map from userspace and you
> > > > tried get_next_key the prev_key was removed, you will start again from
> > > > the beginning without noticing it).
> > > > I tried to sent a patch in the past but I was missing some context:
> > > > before NULL was used to get the very first_key the interface relied in
> > > > a random (non existent) key to retrieve the first_key in the map, and
> > > > I was told what we still have to support that scenario.
> > >
> > > BPF_MAP_DUMP is slightly different, as you may return the first key
> > > multiple times in the same call. Also, BPF_MAP_DUMP is new, so we
> > > don't have to support legacy scenarios.
> > >
> > > Since BPF_MAP_DUMP keeps a list of elements. It is possible to try
> > > to look up previous keys. Would something down this direction work?
> >
> > I've been thinking about it and I think first we need a way to detect
> > that since key was not present we got the first_key instead:
> >
> > - One solution I had in mind was to explicitly asked for the first key
> > with map_get_next_key(map, NULL, first_key) and while walking the map
> > check that map_get_next_key(map, prev_key, key) doesn't return the
> > same key. This could be done using memcmp.
> > - Discussing with Stan, he mentioned that another option is to support
> > a flag in map_get_next_key to let it know that we want an error
> > instead of the first_key.
> >
> > After detecting the problem we also need to define what we want to do,
> > here some options:
> >
> > a) Return the error to the caller
> > b) Try with previous keys if any (which be limited to the keys that we
> > have traversed so far in this dump call)
> > c) continue with next entries in the map. array is easy just get the
> > next valid key (starting on i+1), but hmap might be difficult since
> > starting on the next bucket could potentially skip some keys that were
> > concurrently added to the same bucket where key used to be, and
> > starting on the same bucket could lead us to return repeated elements.
> >
> > Or maybe we could support those 3 cases via flags and let the caller
> > decide which one to use?
>
> this type of indecision is the reason why I wasn't excited about
> batch dumping in the first place and gave 'soft yes' when Stan
> mentioned it during lsf/mm/bpf uconf.
> We probably shouldn't do it.
> It feels this map_dump makes api more complex and doesn't really
> give much benefit to the user other than large map dump becomes faster.
> I think we gotta solve this problem differently.

Multiple variants with flags indeed makes the API complex. I think the
kernel should expose only the simplest, most obvious behavior that
allows the application to recover. In this case, that sounds like
option (a) and restart.

In practice, the common use case is to allocate enough user memory to
read an entire table in one go, in which case the entire issue is
moot.

The cycle savings of dump are significant for large tables. I'm not
sure how we achieve that differently and even simpler? We originally
looked at shared memory, but that is obviously much more complex.
