Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E74C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A955520645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ISIKS+Ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfFXSZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:25:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34987 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfFXSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:25:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so10509913oii.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsFsqmCeB4cJxbUvEFO6xcZSO/kARHjBGNTe6zm2OGk=;
        b=ISIKS+QlpEyn1hNfgdDi5hMHKw8iit0945EcE3yN7j+0wsgacWlTs5VS/2eHyNPn4P
         zFzHaSyW66Yiy2RhkTwuJ3InCkBlGpTPkGdBxkYOWHXgUlVbX7KrnXrnxhmbl79B80YX
         fCQYLMQ6T4q3GxjWwuuuag5EPhpGhA+skRXUiofVA4jxcOoybEtzKs47HHrVewo4aeOH
         xEgr2mAYq4kDK9twlyulxuXtH8x20UgS6h2b36rjnfm3Zpe3kyRxJhg0wXN2sl5N3Gx9
         a1ANzgYTbnIct0aX4IAsj7uocTALXH4slbfh3ZtWL5Y9qp3yWn0Ovu6E52I1ME72busN
         XZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsFsqmCeB4cJxbUvEFO6xcZSO/kARHjBGNTe6zm2OGk=;
        b=eiKKpBPoiYDvLeDwSAMvQ2ql07xeht0ddUgwwQi9xR6IrWhYVZ0k60kr1xHOwkTD9s
         D0zH166y9DSS/UFmt5Ehgbc87K4B/DcyRlcl2guZsQV/F5U/u/yIQoWcoOlpUt4htlGA
         W4zigFfqoIQPPO/BAxMVh7TzdufSAGcowcG7MzjSt7XZRGgNETHngoV8le07/VH+PiaE
         ftRM/AGIzxllIKBfXgDdx3BLWl/p9sYmRO1TV2yjONshjHaq6DmG62msUw6upEy4/pBy
         j3Jf5H3gEnUvewHW6pOIFLIyRQufjfK72AmBSo2nrDrPUWjY1WWwBgPkLFtHvg32dNrD
         aPXg==
X-Gm-Message-State: APjAAAU+0xM1XHdkdxUeioMj8AUX9hgRX9F01N+WNtbuq681sSK01Hqw
        WgUBYVlrkPL1J06hqJHWCGAfu0MGmuYHLtKVPKXDtA==
X-Google-Smtp-Source: APXvYqxMfIu+2D2MtYcv2E7EXzI2zB57kKNYjO9p4H9g9zR42W2XzhT13YcbI1eS8VOBT1jN50QqXbLB+mAAmyIYdBg=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr11696883oii.0.1561400699583;
 Mon, 24 Jun 2019 11:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz>
In-Reply-To: <20190620191733.GH12083@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 Jun 2019 11:24:48 -0700
Message-ID: <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 12:17 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 13-06-19 11:43:08, Christoph Hellwig wrote:
> > noveau is currently using this through an odd hmm wrapper, and I plan
> > to switch it to the real thing later in this series.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  mm/mempolicy.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 01600d80ae01..f9023b5fba37 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2098,6 +2098,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
> >  out:
> >       return page;
> >  }
> > +EXPORT_SYMBOL_GPL(alloc_pages_vma);
>
> All allocator exported symbols are EXPORT_SYMBOL, what is a reason to
> have this one special?

I asked for this simply because it was not exported historically. In
general I want to establish explicit export-type criteria so the
community can spend less time debating when to use EXPORT_SYMBOL_GPL
[1].

The thought in this instance is that it is not historically exported
to modules and it is safer from a maintenance perspective to start
with GPL-only for new symbols in case we don't want to maintain that
interface long-term for out-of-tree modules.

Yes, we always reserve the right to remove / change interfaces
regardless of the export type, but history has shown that external
pressure to keep an interface stable (contrary to
Documentation/process/stable-api-nonsense.rst) tends to be less for
GPL-only exports.

[1]: https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-September/005688.html
