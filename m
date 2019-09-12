Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A964C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D9520830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K05sx5cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfILHfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 03:35:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38570 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfILHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 03:35:04 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so26972839iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yy/eB93u3i9oFcrYya+qHvoEWOjOqMkA6Rb+MDstxQ=;
        b=K05sx5cBxhYiaLy2Alt2mn8Mrq+JJD8WgnnBD5NOn12SAe96tzwo5Znel55J8i+iXI
         qiTaXW3iH1cACv8m9V2QYoHIzAG+piVKMYQ1R0IpmwBM6/DfomHsYEmLe3u/cFh7QJNA
         wlnzdFAGWW99YORzPMbLex+anPI5d6C2iZqj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yy/eB93u3i9oFcrYya+qHvoEWOjOqMkA6Rb+MDstxQ=;
        b=JK5pjIQ+AUYc2/o9v8tT/unrcnxqbDV6vB1nO9SeT1lfUuYoaD2v+bND2IxWG1dR4R
         jQ4FaSOzXHOhLCWIQNLBg/BmJSws378IIfYW3xkUbXtLJMlnucZjSNhc9bia0tyHKVw2
         2eJkiDgRtEUTTPBrkBKPbm6G7PyZqxrToz7MhmG2HF62bEjxyAC0yZWga1Zp5nwLQ/BD
         dmjb1ot7Ta3UerESFDYBMch2UQMbTLZ0to7QD8mAgVXFuW17FqHwAu0daJt0oHq1R33w
         7xOaYfX1ETkBS2RtQPJd7uyMCdSoi0xWevVW8AH6yBODgwVA/es+tE2ynyBYsSKoIRI/
         Gs0A==
X-Gm-Message-State: APjAAAVwqHdOsTBZqH0NcdYw3ZyNpoXmCQgh9di1lPmDfYnIDOGEpfbJ
        OmEE79Wk/H0Lc6Mh1JmnMJFCCluoaBfiGE4mF6qY6Q==
X-Google-Smtp-Source: APXvYqwDgZMkrPkxnR7Kpp3wOz1MBiRabFbv3J14u1Gj0YLn1LeCU7PJj52biEq7IGB5upsfDYmTD5hxdyd3zlFT4qQ=
X-Received: by 2002:a05:6638:405:: with SMTP id q5mr40270933jap.78.1568273702977;
 Thu, 12 Sep 2019 00:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151206.4671-1-mszeredi@redhat.com> <20190911145247.GA7271@redhat.com>
In-Reply-To: <20190911145247.GA7271@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 12 Sep 2019 09:34:52 +0200
Message-ID: <CAJfpegtmvi7pkiJe+1cHMbkx2rJEi7LOAaBMEyC0DaNm7uW3bQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 4:53 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Sep 10, 2019 at 05:12:02PM +0200, Miklos Szeredi wrote:
> > Git tree for this version is available here:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v5
> >
> > Only post patches that actually add virtiofs (virtiofs-v5-base..virtiofs-v5).
> >
> > I've folded the series from Vivek and fixed a couple of TODO comments
> > myself.  AFAICS two issues remain that need to be resolved in the short
> > term, one way or the other: freeze/restore and full virtqueue.
>
> Hi Miklos,
>
> We are already handling full virtqueue by waiting a bit and retrying.
> I think TODO in virtio_fs_enqueue_req() is stale. Caller already
> handles virtqueue full situation by retrying.

Ah.

>
> Havind said that, this could be improved by using some sort of wait
> queue or completion privimitve.

Yeah, the request queuing can be cleaned up in several ways.  But I
think that we might postpone that till after merging with mainline.

Thanks,
Miklos
