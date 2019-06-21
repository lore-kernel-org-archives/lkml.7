Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5226FC48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDEA2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rNCL4zhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfFUM00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:26:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34467 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFUM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:26:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so6704073qtu.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJu/XBwrdsSLLRIcidZtwfJoKMutHo2qTycz/kmN2wg=;
        b=rNCL4zhw8eHMFBzdfTNk3LaqHtJy2EdKZJhC4JXKAVokf50roNkhJcamXNbNQyIVbk
         +F17JkX4Da30UUmMIxKB2HEDgT2swpPABPB1JTWNYcIz2BSH6vtRK0RFRpu1WePTy9/F
         MCSwm4S5qGfQkVVEaPJIoSu7nRJqFislMwMYb3/BeYPK7gGaNHd771r4+0lydNcQWGxn
         vAwjd47h9gxP8ZfpLWwLEafFXMG3ZHoyNREYtPldn08LG37GPGOV0vCMUAC7aD6fvL68
         h5FfNck7iuH5lhV5mJ6KI5IRTJMNl8hmI9hIyrop1DU5T5FPvLCGLOc2NSltYwywZ05u
         hsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJu/XBwrdsSLLRIcidZtwfJoKMutHo2qTycz/kmN2wg=;
        b=SOp5HMcmAH4tibXuYACDWxyNTlakO0OgD6YnNu6qjXXehfRbnGrM7gmbvrRrTL7DSk
         VOB8QYkGOmCVGTnGt/pb/1pVnu7yG+Y98g7T8GVjGa9Qm6tbnYBxBdrR8MD7f35DS4p8
         ZU7WxylPWjMeAgW/WCWjieL5Byp54uUvMFrd00BZha2hGT/b2tZik+iezaCnAgTDZ5e1
         EI0QO0HaIMdeGtAogCCUVRR0cgIHIyjZGcCJccssxQVEMq4riaHousORlhPJ8eC/hSQo
         T0HXRs3sTktXL84eZguRFZ4YiDcpfQ+VB+tdi7dRNl/m7OQpbn4A1kUsGRiRmZhforbd
         tvqA==
X-Gm-Message-State: APjAAAWWFDFjUNj8nnQi+WEeiUUhUSjN6VzSO0V+5z3zg6aWvGa1rMDv
        fJxIBxa4ab9TV8wLumFz+Dk1rg==
X-Google-Smtp-Source: APXvYqyGQfBNrLQhGqn1W0umgpDTMCzpvsh9uq4Mq2YLC5VhGLFENF58ZpwrlKTJ4RrZgekglzPwsw==
X-Received: by 2002:aed:39e5:: with SMTP id m92mr34477935qte.135.1561119985333;
        Fri, 21 Jun 2019 05:26:25 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y42sm2003943qtc.66.2019.06.21.05.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 05:26:24 -0700 (PDT)
Message-ID: <1561119983.5154.33.camel@lca.pw>
Subject: Re: [PATCH -next v2] mm/page_alloc: fix a false memory corruption
From:   Qian Cai <cai@lca.pw>
To:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Jun 2019 08:26:23 -0400
In-Reply-To: <CAG_fn=VRehbrhvNRg0igZ==YvONug_nAYMqyrOXh3kO2+JaszQ@mail.gmail.com>
References: <1561063566-16335-1-git-send-email-cai@lca.pw>
         <201906201801.9CFC9225@keescook>
         <CAG_fn=VRehbrhvNRg0igZ==YvONug_nAYMqyrOXh3kO2+JaszQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-21 at 12:39 +0200, Alexander Potapenko wrote:
> On Fri, Jun 21, 2019 at 3:01 AM Kees Cook <keescook@chromium.org> wrote:
> > 
> > On Thu, Jun 20, 2019 at 04:46:06PM -0400, Qian Cai wrote:
> > > The linux-next commit "mm: security: introduce init_on_alloc=1 and
> > > init_on_free=1 boot options" [1] introduced a false positive when
> > > init_on_free=1 and page_poison=on, due to the page_poison expects the
> > > pattern 0xaa when allocating pages which were overwritten by
> > > init_on_free=1 with 0.
> > > 
> > > Fix it by switching the order between kernel_init_free_pages() and
> > > kernel_poison_pages() in free_pages_prepare().
> > 
> > Cool; this seems like the right approach. Alexander, what do you think?
> 
> Can using init_on_free together with page_poison bring any value at all?
> Isn't it better to decide at boot time which of the two features we're
> going to enable?

I think the typical use case is people are using init_on_free=1, and then decide
to debug something by enabling page_poison=on. Definitely, don't want
init_on_free=1 to disable page_poison as the later has additional checking in
the allocation time to make sure that poison pattern set in the free time is
still there.

> 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > -Kees
> > 
> > > 
> > > [1] https://patchwork.kernel.org/patch/10999465/
> > > 
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > > 
> > > v2: After further debugging, the issue after switching order is likely a
> > >     separate issue as clear_page() should not cause issues with future
> > >     accesses.
> > > 
> > >  mm/page_alloc.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 54dacf35d200..32bbd30c5f85 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1172,9 +1172,10 @@ static __always_inline bool
> > > free_pages_prepare(struct page *page,
> > >                                          PAGE_SIZE << order);
> > >       }
> > >       arch_free_page(page, order);
> > > -     kernel_poison_pages(page, 1 << order, 0);
> > >       if (want_init_on_free())
> > >               kernel_init_free_pages(page, 1 << order);
> > > +
> > > +     kernel_poison_pages(page, 1 << order, 0);
> > >       if (debug_pagealloc_enabled())
> > >               kernel_map_pages(page, 1 << order, 0);
> > > 
> > > --
> > > 1.8.3.1
> > > 
> > 
> > --
> > Kees Cook
> 
> 
> 
