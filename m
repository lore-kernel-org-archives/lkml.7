Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AC7C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE82F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pcr8JEhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfEUMnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:43:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37878 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfEUMnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:43:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id d10so10942417qko.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=feT6//+XEuoB81grk9RMilnSIDBKvcNXipMC0Uit4Oc=;
        b=Pcr8JEhVUyLjBBa/8pdVhfH69n3H4/8MH7ZG9kwaFyHZ8ViEkFJ0qxCiaJTPGC0VVN
         uURwoq4N16YJQUGvv2pNUXHhp8ffX+Y32clwrnI1tWqg/jOouzsMNRJbAUs1uEaKl8c6
         RBiE91gYcMFDuX0tT/BBUYEj+/agq+d/z5F28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=feT6//+XEuoB81grk9RMilnSIDBKvcNXipMC0Uit4Oc=;
        b=P3VU/MRoBrf3TWjuOlsQHOddz1C4WEUdEw6TAoki04Lzcel18/eE9VD9voZQlsIM1c
         M2sIY3lk87c8zBH4ydmsXXSpsOMcVqwklI1iM/rpRKqJVYK0aZ26g4lmXrQSAVG+pK5D
         n72a9DAyy8Ge+sR/2otW8MRGFuT6XLIeuREO4DYCfHhKx10kMSNgcGI39OrPPuuH2spJ
         giEDl9sfM+L79zeY7qQ1/vi6FxkNjcwHfydyxfJ89V2Una7HBWfIEfU0JQls1QRkbdmP
         FLUFPD7XTYwBmjK3YQEGoIlICk52P4z6uVkXsDOx8NjCOVOSWrGGMa3TXO/O7eM7/jtj
         tCAw==
X-Gm-Message-State: APjAAAWVULsmAdme+/exXaRPoGQ7eTeQ1VdQ7DsQ7n0XT2ScpJ/aMsz8
        Al2N5c6QL/LSoOHKHFPodSfc0N2puZgJjMhyjNCuhA==
X-Google-Smtp-Source: APXvYqwFv8X/gQwwT4Tct/RtQIGHWplsikpEopZ62eeUHiNR4qehuc2Y2K+8mZ4EneoeA4ZirWIpTQBrL10MFqTo/k8=
X-Received: by 2002:a05:620a:1493:: with SMTP id w19mr63010827qkj.214.1558442579573;
 Tue, 21 May 2019 05:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190519160446.320-1-hsinyi@chromium.org> <20190519160446.320-2-hsinyi@chromium.org>
 <CANMq1KB7sh=UXaM4sMm_THjZ_wV3Thgr6_ona-TJFqA2QQHALA@mail.gmail.com> <CAJMQK-iZRHO6HBkycPt0yz_vndmmmqFL0duHOcQ8EFSdhhFZcQ@mail.gmail.com>
In-Reply-To: <CAJMQK-iZRHO6HBkycPt0yz_vndmmmqFL0duHOcQ8EFSdhhFZcQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 21 May 2019 20:42:48 +0800
Message-ID: <CANMq1KA1YF6B=nFizS8nT4KREASaJuaztdBnh_t0V8i0Fb-e6A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] fdt: add support for rng-seed
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:10 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Mon, May 20, 2019 at 7:54 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> > Alphabetical order.
> Original headers are not sorted, should I sort them here?
> >
>
> >
> > I'm a little bit concerned about this, as we really want the rng-seed
> > value to be wiped, and not kept in memory (even if it's hard to
> > access).
> >
> > IIUC, fdt_delprop splices the device tree, so it'll override
> > "rng-seed" property with whatever device tree entries follow it.
> > However, if rng-seed is the last property (or if the entries that
> > follow are smaller than rng-seed), the seed will stay in memory (or
> > part of it).
> >
> > fdt_nop_property in v2 would erase it for sure. I don't know if there
> > is a way to make sure that rng-seed is removed for good while still
> > deleting the property (maybe modify fdt_splice_ to do a memset(.., 0)
> > of the moved chunk?).
> >
> So maybe we can use fdt_nop_property() back?

Yes I prefer fdt_nop_property, if we don't want to modify delprop or
splice. But it'd be good if others can chime in.
