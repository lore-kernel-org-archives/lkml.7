Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29896C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F106221479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZZs8QLgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKRQ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:57:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35576 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfKRQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:57:13 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so15967798oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2QoGBxbqxKaHdAJPvrt4O/5DoqHAWLSusSXIabi09g=;
        b=ZZs8QLgb0DGoI+4Ohq8LM3IGXjtQSC4kxA1QwWcD4Za3EBZf+BE3wP72aWJb9897Re
         l8EwHdLUGZfYNmmFhUr1dT7/l5C75vFfJMR3be0zpoR9seynFhm64osd4ClQ6chd7YGk
         6a8ixbDjDsWRVMiY50w+KObtQpOTxJ/kLYNOgA1Xc/kxL0bihi9PSMWhoKFRAIXkTWhj
         uV7YSXY3fWllNgIyQEy1sJC/Ne2NO2c9Lcddcu2Nx543vj/8d1QqBq+BmppqX2r+QGu0
         ySlU18Hbsf2Zg0yhbJ0WcaIFmHOlEL+cXMYMu/ynuLKdzVpMoIcbRbbr/g++sg5n6/Rp
         IfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2QoGBxbqxKaHdAJPvrt4O/5DoqHAWLSusSXIabi09g=;
        b=dueydZYgHp9fxwIqt/DJO1Rwq+1GL01NX5flag1a4iBb8PO7VfDRnb9pPECMJpvjkE
         oodGRiTpJ8JIVnCuJ6dQz1JHNCMM+3aBAQ4cOMeMUY3NYS/2MAUztb2l41djRTgBczYS
         R9Qp9W/52qwfSK94vyHBDagFw91vDJHWritVcThdSQmyw/aX9HZS45/sYmXXj9zDsxS9
         SfZ6YeGAYvO/Ihnw8Xxx017Jux5mIXPvnSDXq0aSEDvm6iY1FvqpPv4SQD7MAEIh/KsI
         sXefHH7EDa0VNmEKg7sGnTOV4d6gY9z6gTVcJ+wvx7wipsw3IGrYfR85qPwD5cf/x00S
         y+dQ==
X-Gm-Message-State: APjAAAWKSHRzUjIuzsyNR70t8K+QM/bkEjsgDasjxWIaHW4qM/JWnVz0
        kGFAVPdzfTxM3lIS6e+f4JstOeEJULkSfObSx21P3Q==
X-Google-Smtp-Source: APXvYqzxVz2ITPsmL7BIllg6yzJCnkn09mUhU51YguSZB4HFRO8vRYA3KeNXnspk2IZU9U52ryt0kS3aQ71VvEQofWA=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr22494640oib.105.1574096232626;
 Mon, 18 Nov 2019 08:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20191115001134.2489505-1-jhubbard@nvidia.com> <20191115001134.2489505-3-jhubbard@nvidia.com>
 <20191118070826.GB3099@infradead.org>
In-Reply-To: <20191118070826.GB3099@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Nov 2019 08:57:01 -0800
Message-ID: <CAPcyv4ganBBR61ZEwGHOoA+FeAdSY8rWzTCNM=zhnfn27KOafw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: devmap: refactor 1-based refcounting for
 ZONE_DEVICE pages
To:     Christoph Hellwig <hch@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 11:09 PM Christoph Hellwig <hch@infradead.org> wrot=
e:
>
> On Thu, Nov 14, 2019 at 04:11:34PM -0800, John Hubbard wrote:
> > An upcoming patch changes and complicates the refcounting and
> > especially the "put page" aspects of it. In order to keep
> > everything clean, refactor the devmap page release routines:
> >
> > * Rename put_devmap_managed_page() to page_is_devmap_managed(),
> >   and limit the functionality to "read only": return a bool,
> >   with no side effects.
> >
> > * Add a new routine, put_devmap_managed_page(), to handle checking
> >   what kind of page it is, and what kind of refcount handling it
> >   requires.
> >
> > * Rename __put_devmap_managed_page() to free_devmap_managed_page(),
> >   and limit the functionality to unconditionally freeing a devmap
> >   page.
> >
> > This is originally based on a separate patch by Ira Weiny, which
> > applied to an early version of the put_user_page() experiments.
> > Since then, J=C3=A9r=C3=B4me Glisse suggested the refactoring described=
 above.
>
> I can't say I'm a big fan of this as it adds a lot more inlined
> code to put_page, which has a lot of callsites.  Can't we instead
> try to figure out a way to move away from the off by one refcounting?

That might be possible. David and I are discussing a pfn_online()
helper that might be a replacement for keeping ZONE_DEVICE pages out
of the page allocator rather than keeping their reference count
elevated.
