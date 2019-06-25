Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D641C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3E22133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfFYH1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:27:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40695 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYH1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:27:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id e8so16226022otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 00:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Qkw0w8lvC08c786EpQGX2PIdXmdvbYBqHXJse34m3o=;
        b=gvVX5CZyFWHbYmXHjH4/MtD5/k+9SoaguBjYui8eWO5/gSr/8S47ewJAeFvy/vXOOy
         /ey4NlVB8dE/AUCG8COBU0T6ZDZ9e1ySPOExWcYgUBi7zsYXGAhlenWIpCcO7CUKBpMm
         5oCo4v7H+eMJvqYUcbpbenYDVCwIU6qLQvJxW77K8xc0ys5q6urslrnUBcJnOuwXJViB
         TkAMhBwWy7J/YLW5DENmAuqPHK0Un5bheXVMJbuItJli8i0jfLDWV+k6vYCrfL06GQDJ
         4jpRmOwpCmsvg5TQGbc3rYdMc0GDqy40aP1d3jKOwheZNX/ogzaRfXebmc3bZfZfj8b4
         o6zA==
X-Gm-Message-State: APjAAAVjDbL87Z5vS+HQTVxqHvoR/GO2BHdJdOsNJ8JxPJ5Ml/gxSiNJ
        r6UOyOY8IZ+DwuR8QLtQ9KehPje+puDxoxmb+kA=
X-Google-Smtp-Source: APXvYqz5kpjmhQHLOOOnAPAkjsha+t1aYf/sUnzuNLLExvWSDtZeQwEE89t+NM6TZLU8/dKbki7oQhlqiOonWEwRSj8=
X-Received: by 2002:a9d:529:: with SMTP id 38mr16990865otw.145.1561447620546;
 Tue, 25 Jun 2019 00:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190614102126.8402-1-hch@lst.de> <CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com>
 <20190625063228.GA29561@lst.de>
In-Reply-To: <20190625063228.GA29561@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jun 2019 09:26:48 +0200
Message-ID: <CAMuHMdUNwERTRg4MbkkD62EtNhsU7kWVy6x4kB89rYh6ann0Pw@mail.gmail.com>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Jun 25, 2019 at 8:33 AM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 17, 2019 at 08:53:55PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Jun 14, 2019 at 12:21 PM Christoph Hellwig <hch@lst.de> wrote:
> > > can you take a look at the (untested) patches below?  They convert m68k
> > > to use the generic remapping DMA allocator, which is also used by
> > > arm64 and csky.
> >
> > Thanks. But what does this buy us?
>
> A common dma mapping code base with everyone, including supporting
> DMA allocations from atomic context, which the documentation and
> API assume are there, but which don't work on m68k.

OK, thanks!

> > bloat-o-meter says:
> >
> > add/remove: 75/0 grow/shrink: 11/6 up/down: 4122/-82 (4040)
>
> What do these values stand for?  The code should grow a little as
> we now need to include the the pool allocator for the above API
> fix.

Last 3 values are "bytes added/removed (net increase)".
So this increases the static kernel size by ca. 4 KiB.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
