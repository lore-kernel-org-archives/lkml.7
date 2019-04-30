Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED7CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018920854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J6jpwCXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfD3SIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:08:40 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46295 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfD3SIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:08:39 -0400
Received: by mail-yw1-f67.google.com with SMTP id v15so6574198ywe.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xil5v019vbM3B6LNJ5oLx5ybK/sELLOgqiNDryj/WS4=;
        b=J6jpwCXSoU7Eq7a4v/BuGEqdgrF69IaBpqOL12T9GDVAPMr4fSnfDWEJUjRPxcE/aa
         fNigHE4KOEqlZyENgRu+3RjUamg6DPnkPsUqo+KyKPP54eT63vbbvE3+J28zY2d6CAuk
         qfCM428MXxMWIy/qHQJK5PMe+FU2XDaiA2WYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xil5v019vbM3B6LNJ5oLx5ybK/sELLOgqiNDryj/WS4=;
        b=mGoNk/6KEJJZap9QPmCGuv9aW3nCEBAzlqH3PdSiKSrkfdadCSJGfi8tvRw3q9aWAY
         G2TlCNlUP3b038xCuW851ZgnjhBJV/O1e+Rf/sTmaHhhXZqpX9ufmjy5C1WvbaA1NlPs
         2nSN5nZoBVQlcbhs3xFAKXbOcWMETXPeUB9ax4fVqS0GH04Na30cx56ku6OR59t6RR15
         2i92eK1JXWqeIYFqwO+ZeVqmWYzHcySik9kccQnMTOE2rF99BIByYpSylQjTeiNYBk/2
         LQgDaekRmEOySTc5RAzpTEfkf3eUgk8C0sF9bK54PfeYPmor34GzlZqlcb899PloLcjV
         9hAQ==
X-Gm-Message-State: APjAAAWhm8ci6F2DUZM/pUGtwwbg8h+w6LINnHi7jmtG9toF43eVZ2v0
        BUK4gTzHIObCKnrriMVvirwvAIA4ixw=
X-Google-Smtp-Source: APXvYqxU9mcJFyKwOfBosH1NiQkfPb3h+w2S6k3K8xDZHSBd3g/2iG7cDh810tyt7VVjJQCMpFirhQ==
X-Received: by 2002:a25:1f02:: with SMTP id f2mr57714160ybf.111.1556647717956;
        Tue, 30 Apr 2019 11:08:37 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id g187sm9582801ywa.4.2019.04.30.11.08.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:08:37 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id j4so6585712ywk.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:08:36 -0700 (PDT)
X-Received: by 2002:a25:d488:: with SMTP id m130mr15451236ybf.172.1556647716425;
 Tue, 30 Apr 2019 11:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190429222613.13345-1-mcroce@redhat.com> <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
 <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com>
 <20190430160813.GI13796@bombadil.infradead.org> <CAGnkfhxhZ7WELD-w_KA+yKogyyJ=y_=8w+HdpYoiWDbCsQi+zw@mail.gmail.com>
In-Reply-To: <CAGnkfhxhZ7WELD-w_KA+yKogyyJ=y_=8w+HdpYoiWDbCsQi+zw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Apr 2019 11:08:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLvwT4qQSP5GH=MdNoW4XtEQRbeyA_=MrEAHhgBSXfJTQ@mail.gmail.com>
Message-ID: <CAGXu5jLvwT4qQSP5GH=MdNoW4XtEQRbeyA_=MrEAHhgBSXfJTQ@mail.gmail.com>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 9:30 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Tue, Apr 30, 2019 at 6:08 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Apr 30, 2019 at 08:42:42AM -0700, Kees Cook wrote:
> > > On Tue, Apr 30, 2019 at 3:47 AM Matteo Croce <mcroce@redhat.com> wrote:
> > > > On Tue, Apr 30, 2019 at 12:26 AM Matteo Croce <mcroce@redhat.com> wrote:
> > > > >
> > > > > Add a const int array containing the most commonly used values,
> > > > > some macros to refer more easily to the correct array member,
> > > > > and use them instead of creating a local one for every object file.
> > > > >
> > > >
> > > > Ok it seems that this simply can't be done, because there are at least
> > > > two points where extra1,2 are set to a non const struct:
> > > > in ip_vs_control_net_init_sysctl() it's assigned to struct netns_ipvs,
> > > > while in mpls_dev_sysctl_register() it's assigned to a struct mpls_dev
> > > > and a struct net.
> > >
> > > Why can't these be converted to const also? I don't see the pointer
> > > changing anywhere. They're created in one place and never changed.
> >
> > That's not true; I thought the same thing, but you need to see how
> > they're used in the functions they're called.
> >
> > proc_do_defense_mode(struct ctl_table *table, int write,
> >         struct netns_ipvs *ipvs = table->extra2;
> >                         update_defense_level(ipvs);
> > static void update_defense_level(struct netns_ipvs *ipvs)
> >         spin_lock(&ipvs->dropentry_lock);
>
> Indeed. I followed the same code path until I found this:
>
>  167                        ipvs->drop_rate = 0;
>  168                        ipvs->sysctl_drop_packet = 1;
>
> so I think that this can't be done like this.

Ah, dang. Yeah, I missed that too.

> Mind if I send a v5 without the const qualifier? At least to know the
> kbuildbot opinion.

Yeah, I think that's likely best.

-- 
Kees Cook
