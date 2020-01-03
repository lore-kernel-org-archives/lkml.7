Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C409C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1E222522
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="uUTSYWl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgACSSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:18:34 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33144 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgACSSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:18:34 -0500
Received: by mail-oi1-f195.google.com with SMTP id v140so14771605oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 10:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jfW1W8ZPOpcKWgvKCt6rdwp9cvHKeFm7M8ZtVMfoqE=;
        b=uUTSYWl8nz82vjdvvs/xw9mCFGyNA1/jWIoEbWuoMKlH3HcUmcrmAqAMT/hIMBHdeM
         Fuby+QAs66gLq4zerv1qQgWzxoVD8/r0SSdFiVPRB1KIlrgk+Ia/w09w2yIVb5UjPUKe
         aPbAUa8sDKqS+Z4oOye+qJxT2xWQdMreVtrK0E0UvXvfqOeelWZW8PJqgrqw9dRkK6uk
         n02sLzh2qbjLYtP6eE1hXlSk3R0Qtd222mErsWQ1QRt3DyYfq3l8wWs0f8OFXi4RxUqR
         Miqm3MNSWzoZ2hZI/iAGOnFy0qTR/HSd977eHvvgAqYPyJXhnZLiJOZszpwfj8/ebisx
         Q1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jfW1W8ZPOpcKWgvKCt6rdwp9cvHKeFm7M8ZtVMfoqE=;
        b=my+qkLc8NisyXLNdtfVVSgdyJ/cuEGUK5/qrBB6D5RvIHNaHVp9I57scgcxcHyJDof
         PQmIrWrIpmMQDSKyrbymKWLJzJum+iATIYHhZKrywBfqDqbQI9Hi8kgadk8ln6ZoCBzj
         cx/VAA516YV7uIUoNtFfMzGGk1kJxRriRwF4ofX9L87fyJFi0DJW7GTf9ieC1xqMSeGW
         xQKHgfb86elrBzZ4OO0+YMSb0LsCR+m+MhiLdBF8pR4an7oG8mS/j+PZfxRDJxWQvElc
         X11o/fWXgp8vo9T7Vt9eTDMhqML9/VvptDH1APrEdFpgtnjyKW6VKr8Ze3jVS9e/RB5G
         QaJg==
X-Gm-Message-State: APjAAAXU1+OH5bNqQ7ZGDXIDxmCwl+kkra8RqR/XAEzy8R/odIDtYa0P
        CAzoD7nUZtkJf1HujDXBSLe6yuFZM7fBqDQ1o8BPpQ==
X-Google-Smtp-Source: APXvYqy2IVKMiHQ+wQTZ+ASoUXECP3V0RjbOEIgTCxr3TvAGQIi/fJSFNpOGIKISyhHaPla/bwRt9Ai9ZKS192hUFSE=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr4590187oij.149.1578075513071;
 Fri, 03 Jan 2020 10:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org> <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com> <20200103141235.GA13350@redhat.com> <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
In-Reply-To: <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Jan 2020 10:18:22 -0800
Message-ID: <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 10:12 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jan 3, 2020 at 6:12 AM Vivek Goyal <vgoyal@redhat.com> wrote:
[..]
> > Hi Dan,
> >
> > Ping for this patch. I see christoph and Jan acked it. Can we take it. Not
> > sure how to get ack from ext4 developers.
>
> Jan counts for ext4, I just missed this. Now merged.

Oh, this now collides with:

   30fa529e3b2e xfs: add a xfs_inode_buftarg helper

Care to rebase? I'll also circle back to your question about
partitions on patch1.
