Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4A2C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829AB2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfGVUMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:12:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40592 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfGVUMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:12:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id w196so9222160oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKpNvjyeav2TkrWNw26KJV5Yk/ocQzfpVIZmY2lx9vA=;
        b=ICuk96JxcIr05Sh2kVG9BqCG5ydjVeTp4it2LqQLzoWBVGmXQ/2l1GdXlwRtBWG8YZ
         deYyqxu+UX86NWUydjk2c9oZHTyHaaFzXv5oEIBYhYpSCsLh8Hrz7EZS15aSt0SzpqnM
         BzavyqU/JoDSbxYptHv/I95xvC8QXO83TmiD3I5hEN3cxu8Km8fibwfdK35KUl7JPMmp
         a74N0qJEARvE6/HmmPksC6hVasxGsJ9XfYMweTsGzuTpZ3E3RjR0txJ7F1hbIC/a6fJd
         LIV40LQbg6IlXwmSeEmARYBMaulkkA8cUMMgU7icx3iIOZjVufK9ssv3Wy9TQKUrhcjm
         Zetg==
X-Gm-Message-State: APjAAAVYcsXhPtb+crpPPMyisju8zKoY0PcA/isECv1c7/qdfU63U/67
        yhq5Ehr8XQ8Y1XcE8/B1nwYhY8i7NTnQ3TIBe38RKA==
X-Google-Smtp-Source: APXvYqyhRxhuqfN9NPb1NOuvkt5AsL/yran3Id9FVtnziQurnms/xJCxtrVqV/RaSFxGA3nruRayA2spZawkzf5B0Mg=
X-Received: by 2002:aca:72d0:: with SMTP id p199mr22915331oic.178.1563826353288;
 Mon, 22 Jul 2019 13:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190722095024.19075-1-hch@lst.de>
In-Reply-To: <20190722095024.19075-1-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 22 Jul 2019 22:12:21 +0200
Message-ID: <CAHc6FU6oAsVGDA_7zMRiU=gR6EDh-P2x8sbjxr7XcKn4epS3UQ@mail.gmail.com>
Subject: Re: lift the xfs writepage code into iomap v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, 22 Jul 2019 at 11:50, Christoph Hellwig <hch@lst.de> wrote:
> this series cleans up the xfs writepage code and then lifts it to
> fs/iomap.c so that it could be use by other file system.  I've been
> wanting to this for a while so that I could eventually convert gfs2
> over to it, but I never got to it.  Now Damien has a new zonefs
> file system for semi-raw access to zoned block devices that would
> like to use the iomap code instead of reinventing it, so I finally
> had to do the work.
>
>
> Changes since v2:
>  - rebased to v5.3-rc1
>  - folded in a few changes from the gfs2 enablement series

thanks for the much appreciated update.

I've added that and the remaining gfs2 iomap patches to this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git iomap

Your final patch on this branch, "gfs2: use iomap for buffered I/O in
ordered and writeback mode", still causes the following four xfstest
failures:

  generic/311 generic/322 generic/393 generic/418

The bug in generic/393 is that in the nobh case, when unstuffing an
inode, we fail to dirty the unstuffed page and so the page is never
written. This should be easy to fix. The other failures have other
causes (still investigating).

> Changes since v1:
>  - rebased to the latest xfs for-next tree
>  - keep the preallocated transactions for size updates
>  - rename list_pop to list_pop_entry and related cleanups
>  - better document the nofs context handling
>  - document that the iomap tracepoints are not a stable API

Thanks,
Andreas
