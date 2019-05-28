Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89609C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DD6208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfE1QMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:12:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfE1QMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:12:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30A6F3D95D;
        Tue, 28 May 2019 16:12:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 270FF2F28D;
        Tue, 28 May 2019 16:11:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAB9dFdtT0p+Sg5=qt=Te9FEkASXcH=ZQZRHyN1UQ3nYkDLHMpQ@mail.gmail.com>
References: <CAB9dFdtT0p+Sg5=qt=Te9FEkASXcH=ZQZRHyN1UQ3nYkDLHMpQ@mail.gmail.com> <20190527165413.GA26714@embeddedor>
To:     Marc Dionne <marc.c.dionne@gmail.com>
Cc:     dhowells@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] afs: Fix logically dead code in afs_update_cell
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8580.1559059917.1@warthog.procyon.org.uk>
Date:   Tue, 28 May 2019 17:11:57 +0100
Message-ID: <8581.1559059917@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 28 May 2019 16:12:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Dionne <marc.c.dionne@gmail.com> wrote:

> > diff --git a/fs/afs/cell.c b/fs/afs/cell.c
> > index 9c3b07ba2222..980de60bf060 100644
> > --- a/fs/afs/cell.c
> > +++ b/fs/afs/cell.c
> > @@ -387,7 +387,6 @@ static int afs_update_cell(struct afs_cell *cell)
> >                 if (ret == -ENOMEM)
> >                         goto out_wake;
> >
> > -               ret = -ENOMEM;
> >                 vllist = afs_alloc_vlserver_list(0);
> >                 if (!vllist)
> >                         goto out_wake;
> 
> Looks like the intention here was to return -ENOMEM when
> afs_alloc_vlserver_list fails, which would mean that the fix should
> move the assignment within if (!vllist), rather than just removing it.
> Although it might be fine to just return the error that came from
> afs_dns_query instead, as you do in this patch.

I think I'd rather return the original error as this patch effects.  I'm
having a ponder on it.

David
