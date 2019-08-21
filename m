Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FFC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2147F22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qOorDm6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfHUC6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:58:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44447 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfHUC6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:58:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id k22so485240oiw.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TZ3h9XIXM46J9xL8jGJCgzDeloZeTOimF9MDrrQtC4=;
        b=qOorDm6PpWOQgpgNZ9zmOr4vJFD6fWmIZseaX2KpEDDmSUDSr1IXX+4fS6N4xb9YQ6
         JeafUS1hPydswBv2jT2nbmW5e3KtNqzCllW3DoP9Ivp9l7s1LyVGLvbQpCXmIdvbjGi/
         Vw7guluARa0Ip4m0K0RZ3094LcmC/4LVARQvNA1uJ509zGMVyPz87TGgjfE8Arwtj20D
         x+VHqobf5iooIqnblgEZSS3mBUK6ZgTXxWpTdtvQMussWhRgurBPgRBEAahbNXCcW47j
         WaLrZ5A2ALTQZeRCdgfEiHjxsTb1DXQJSIq0HNM1AdW9RXdtY9uDZbgW32ANNApRRZOC
         7F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TZ3h9XIXM46J9xL8jGJCgzDeloZeTOimF9MDrrQtC4=;
        b=HN9egxa7C6kjT2/Ti2N34Ngv0YpCbB5Xf1xk4CyW2G+Ie1kTnhxqcs0YyCrZoZ7ggR
         0GZV6zRaxt1fKwX7EQU+llK3XSEXMfW1HUBt6wo9wVK+D8hCLZ/3u9X3/HY5f9TQ2s3N
         fwJPuI09whK6+hnctO7JctrrT57uM5BLxPpM1al4i6sIRp5emIU3ypCGuTBTWgvBqLLm
         bH7ekwDOYvOrJrKiws7g0qJAlYA99xTwPSE4LWqMbS5vL8Kx+/nCvHnzFHnXcuaLJ+Sb
         7tcFoEC2EqkADU4MLJPm0mzl0DMIXzP58G1y4/8bOb/+NlLHcUScFEK43ZJGGQqoOyVR
         XwTw==
X-Gm-Message-State: APjAAAUIyT9stG+e0XY08IeLPy/sGPIF0FjnoqQYkC+E1LWdeo7C/cAO
        KdRmkKZTsObMx4OtRB0IvkEZJQY+s/aJG60rNOmfgg==
X-Google-Smtp-Source: APXvYqzy0DftYJ4NNlH1NIMiV5YB0m8M/Dz1VUcVz6X5YJE31Eh5n7ME2g8Oz2MtJxGZ8nCBds6RncjxWyjh/YYH8Xg=
X-Received: by 2002:a05:6808:914:: with SMTP id w20mr2162912oih.73.1566356313559;
 Tue, 20 Aug 2019 19:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de> <20190818090557.17853-3-hch@lst.de>
 <CAPcyv4iYytOoX3QMRmvNLbroxD0szrVLauXFjnQMvtQOH3as_w@mail.gmail.com> <20190820132649.GD29225@mellanox.com>
In-Reply-To: <20190820132649.GD29225@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Aug 2019 19:58:22 -0700
Message-ID: <CAPcyv4hfowyD4L0W3eTJrrPK5rfrmU6G29_vBVV+ea54eoJenA@mail.gmail.com>
Subject: Re: [PATCH 2/4] memremap: remove the dev field in struct dev_pagemap
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 6:27 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Aug 19, 2019 at 06:44:02PM -0700, Dan Williams wrote:
> > On Sun, Aug 18, 2019 at 2:12 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > The dev field in struct dev_pagemap is only used to print dev_name in
> > > two places, which are at best nice to have.  Just remove the field
> > > and thus the name in those two messages.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >
> > Needs the below as well.
> >
> > /me goes to check if he ever merged the fix to make the unit test
> > stuff get built by default with COMPILE_TEST [1]. Argh! Nope, didn't
> > submit it for 5.3-rc1, sorry for the thrash.
> >
> > You can otherwise add:
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >
> > [1]: https://lore.kernel.org/lkml/156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> Can you get this merged? Do you want it to go with this series?

Yeah, makes some sense to let you merge it so that you can get
kbuild-robot reports about any follow-on memremap_pages() work that
may trip up the build. Otherwise let me know and I'll get it queued
with the other v5.4 libnvdimm pending bits.
