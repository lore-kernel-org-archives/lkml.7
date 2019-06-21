Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C8AC48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D2720679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gYgr6uvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfFUO4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:56:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36217 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:56:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so4642845qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2jSEi8sxGbtd9XqToa9O5z6ODlBTruzPgaOmq/wTns=;
        b=gYgr6uvq3e99g5z1DITZTTDDikIDoeGMeREh38wawLs+nFJeAz5Xqj77bM3E910xFY
         +ZAljwkmUjsGIH1/zKjIY5Kt5vwDNvzTLF+OcYMgBOPGNGMmofaJuh9npl22zdMgU63z
         3VlBAKlSAzMm5bCEcaus7JH8AgTRPo9UiWQCTdh/hVUITLZsbCXOTUiA+KSsvcKnLeyw
         XWPY1KH2xf6Q/jSvqhmfHPlR+HqqngalxnndIi1832DfEBUWObiL0psTtreV3quiOdlH
         ds245fuvJ0nzAOKfIhEQfnP9gyLRKZbx2fRQhzQ61g+3/XorYHntg8sYaq9p6YCu+GZx
         oO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2jSEi8sxGbtd9XqToa9O5z6ODlBTruzPgaOmq/wTns=;
        b=QmHzN8bozqIkuVISpN2tDuyiaCsmix5rbDMTVDlvTiR/2a8ygrIwU3j+xF0YacDiwz
         7NrqPjw+EtrjU/kJ/u7oH+RNK/KeUvR4rP2ns69majW1MrLrPnk/IphS8s0vIyP2SnJv
         GOnt7gIBU2PDKNgm7/Q0TVJvj/4EigD4MX8UiJGLvokQIvwIwYm+TwNGKRfgRyqYQceG
         vT6+lE8Y/ha67MsBonp5/wYeueLCIyuSTNZfA2gfh5glfZihS4H6aucvM+Vmp2hlfkkD
         sQUxcn2SOVRsIzQIm8w08w4A+svJXOAR60VDJZrJcCaKK+7MSCo8w1B6kGaGPAPuDXUn
         lukw==
X-Gm-Message-State: APjAAAXYO8MDjf1tfHdIX57xaiGDdbZvv5L9KMEKYs4VDVmCXwrY4hEd
        HdX3On3ufyQQ0Ucvr39zjKQtRQ==
X-Google-Smtp-Source: APXvYqwdtqGL7/0XnZ/6BRHrf7rNtb/EZiHjW12ga0UDVJnzJXCNm+v/P4zmsKvDmcfrhdhHGLYA1Q==
X-Received: by 2002:a37:680e:: with SMTP id d14mr15417323qkc.287.1561128969542;
        Fri, 21 Jun 2019 07:56:09 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g54sm2143489qtc.61.2019.06.21.07.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 07:56:08 -0700 (PDT)
Message-ID: <1561128967.5154.45.camel@lca.pw>
Subject: Re: [PATCH -next v2] mm/page_alloc: fix a false memory corruption
From:   Qian Cai <cai@lca.pw>
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Jun 2019 10:56:07 -0400
In-Reply-To: <CAG_fn=WGdFZNrUCeMtbx4wbHhxWqM2s7Vq_GvnMC-9WJZ_mioQ@mail.gmail.com>
References: <1561063566-16335-1-git-send-email-cai@lca.pw>
         <201906201801.9CFC9225@keescook>
         <CAG_fn=VRehbrhvNRg0igZ==YvONug_nAYMqyrOXh3kO2+JaszQ@mail.gmail.com>
         <1561119983.5154.33.camel@lca.pw>
         <CAG_fn=WGdFZNrUCeMtbx4wbHhxWqM2s7Vq_GvnMC-9WJZ_mioQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-21 at 16:37 +0200, Alexander Potapenko wrote:
> On Fri, Jun 21, 2019 at 2:26 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > On Fri, 2019-06-21 at 12:39 +0200, Alexander Potapenko wrote:
> > > On Fri, Jun 21, 2019 at 3:01 AM Kees Cook <keescook@chromium.org> wrote:
> > > > 
> > > > On Thu, Jun 20, 2019 at 04:46:06PM -0400, Qian Cai wrote:
> > > > > The linux-next commit "mm: security: introduce init_on_alloc=1 and
> > > > > init_on_free=1 boot options" [1] introduced a false positive when
> > > > > init_on_free=1 and page_poison=on, due to the page_poison expects the
> > > > > pattern 0xaa when allocating pages which were overwritten by
> > > > > init_on_free=1 with 0.
> > > > > 
> > > > > Fix it by switching the order between kernel_init_free_pages() and
> > > > > kernel_poison_pages() in free_pages_prepare().
> > > > 
> > > > Cool; this seems like the right approach. Alexander, what do you think?
> > > 
> > > Can using init_on_free together with page_poison bring any value at all?
> > > Isn't it better to decide at boot time which of the two features we're
> > > going to enable?
> > 
> > I think the typical use case is people are using init_on_free=1, and then
> > decide
> > to debug something by enabling page_poison=on. Definitely, don't want
> > init_on_free=1 to disable page_poison as the later has additional checking
> > in
> > the allocation time to make sure that poison pattern set in the free time is
> > still there.
> 
> In addition to information lifetime reduction the idea of init_on_free
> is to ensure the newly allocated objects have predictable contents.
> Therefore it's handy (although not strictly necessary) to keep them
> zero-initialized regardless of other boot-time flags.
> Right now free_pages_prezeroed() relies on that, though this can be changed.
> 
> On the other hand, since page_poison already initializes freed memory,
> we can probably make want_init_on_free() return false in that case to
> avoid extra initialization.
> 
> Side note: if we make it possible to switch betwen 0x00 and 0xAA in
> init_on_free mode, we can merge it with page_poison, performing the
> initialization depending on a boot-time flag and doing heavyweight
> checks under a separate config.

Yes, that would be great which will reduce code duplication.
