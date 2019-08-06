Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAB3C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20272086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZBV4oHn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbfHFQ02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:26:28 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32860 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730265AbfHFQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:26:28 -0400
Received: by mail-vs1-f66.google.com with SMTP id m8so58777388vsj.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1l5ZrHi0Yk9YrLdE/QA8qgrMQVeapVUN6J/JOSvAOYc=;
        b=ZBV4oHn5MVJP82WyuT5P3kIh8PCv/GK73DVyI6Q+Iv7zO1Oco9bjpqilJ0cmyPPxx/
         PZMs4cf0csx7Sl3GioHm6+yiGvHAhZ54V/qtkc1PvY2NmjcsMJpXwSDLN30Ta2x8aDis
         vyln7ihg3bJ76am6PXKXDohQCkHRmyewx7KMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1l5ZrHi0Yk9YrLdE/QA8qgrMQVeapVUN6J/JOSvAOYc=;
        b=eRklOF+2uzCfSc+odUqGwuJmFxtjs7zqG+W4pi/buaJohQKG30pp6ufAWErQLkTo35
         mX0Z6nvXYp2Ujy4/gI5/Tk4mkcwtLMB4LL3A4H8AJyiVMcInShOXoaCHW1wP6kpaf1BW
         mcfSW/6F4tAcshq6BkCIsyM8NOqA+CGQjF7rGLohPw11d9P7mmC2ZDVN7QwInk02B+zD
         SmeMMcc8QslgOtzIgI8Jtqkz4jf1fnL68nJlKGXAVMUBv9a2xQlFYqTwwN4SOcfDyAd8
         N9fdNEBu9yBCkfc2wz5dS9B0bGDeXdqifcRO+lEYuDZciWq55/m2lWA8ldnlvFbCGlZJ
         V0oQ==
X-Gm-Message-State: APjAAAUwCyEbj+rMcC1I8qGFEo0JK0TEZZV7FZ6rgyIycp2xcAB0bRsl
        rvDeryWyFjmrmPOlw4BR63TpD98uoAF6o6DAns8mog==
X-Google-Smtp-Source: APXvYqwcAz9ahI3UjO9cuqIBc0I2yQDE+A8Mr2TXIaxm06KJMfs4AnTSSTTINyr+iiH0P6wDgJEqM8oppH2++ox+PQo=
X-Received: by 2002:a67:ba12:: with SMTP id l18mr3017326vsn.29.1565108787535;
 Tue, 06 Aug 2019 09:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806155044.GC25050@lst.de> <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com>
In-Reply-To: <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 6 Aug 2019 09:26:16 -0700
Message-ID: <CAJs_Fx4dUNKwd_U7wXMaedvTy6mORdmzL4mi-mGp1UnU_SVnzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 9:23 AM Rob Clark <robdclark@chromium.org> wrote:
>
> On Tue, Aug 6, 2019 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> > > Agreed that drm_cflush_* isn't a great API.  In this particular case
> > > (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> > > out to memory later, and so that I don't get a cache hit on
> > > uncached/wc mmap'ing.
> >
> > So what is the use case here?  Allocate pages using the page allocator
> > (or CMA for that matter), and then mmaping them to userspace and never
> > touching them again from the kernel?
>
> Currently, it is pages coming from tmpfs.  Ideally we want pages that
> are swappable when unpinned.

to be more specific, pages come from
shmem_file_setup()/shmem_read_mapping_page()

BR,
-R
