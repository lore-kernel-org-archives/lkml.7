Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBE2C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9131020CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2mtH6pX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfL0JKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 04:10:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53214 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726169AbfL0JKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 04:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577437820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ASFV5pJzvuuWxY4tU7Iy4ntnhG1vqYANWCT9adP97F8=;
        b=V2mtH6pXW0deD9faxJf3TRQaQEXk7TMXt6Pm1u93dz3Vs75qOBd5rYFnx9NBDkIdKXMOK+
        EUxzKd+8mme6P94CQHY15heXEmcrdUoTj5MP9R/nDTx48yyNjSZbAZztiv2moW9yDGMDlZ
        xZKmCd8Rof6d+ro9w1JBrO5VKPqzWRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-t5Hx4NQGNWSKpHAOIKDE5A-1; Fri, 27 Dec 2019 04:10:17 -0500
X-MC-Unique: t5Hx4NQGNWSKpHAOIKDE5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35352185432C;
        Fri, 27 Dec 2019 09:10:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89DFE271A8;
        Fri, 27 Dec 2019 09:10:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191227000634.GS4203@ZenIV.linux.org.uk>
References: <20191227000634.GS4203@ZenIV.linux.org.uk> <1576761291-30121-1-git-send-email-yangtiezhu@loongson.cn>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix compile warning in afs_dynroot_lookup()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12482.1577437812.1@warthog.procyon.org.uk>
Date:   Fri, 27 Dec 2019 09:10:12 +0000
Message-ID: <12483.1577437812@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> > -	int len;
> > +	int len = 0;
> >  
> >  	if (!net->ws_cell)
> >  		return ERR_PTR(-ENOENT);
> 
> NAK.  This is really, really wrong - passing zero to lookup_one_len() is
> always a bug.

You can't create a cell with a name of "" as afs_alloc_cell() will object with
EINVAL, so if net->ws_cell points to an afs_cell struct, that should never
have a zero-length name.

> BTW, what guarantees that cell->name won't be "@cell"?

afs_alloc_cell() won't allow that a cell with that that name either.

> The same for net->sysnames in afs_lookup_atsys() - what makes sure we won't
> see "@sys" among those?

afs_proc_sysname_write() checks for it.  Note that @sys substitutions are set
locally and are not obtained remotely.

> While we are at it,
>         d = d_splice_alias(inode, dentry);
>         if (!IS_ERR_OR_NULL(d)) {
>                 d->d_fsdata = dentry->d_fsdata;
>                 trace_afs_lookup(dvnode, &d->d_name,
>                                  inode ? AFS_FS_I(inode) : NULL);
>         } else {
>                 trace_afs_lookup(dvnode, &dentry->d_name,
>                                  IS_ERR_OR_NULL(inode) ? NULL
>                                  : AFS_FS_I(inode));
>         }
> is _very_ suspicious-looking - d_splice_alias() consumes
> an inode reference, and if it ends up failing on non-ERR_PTR()
> inode, the inode will be dropped by the time it returns.
> IOW, that AFS_FS_I(inode) in the second branch can bloody
> well point to already freed memory.

Yeah, fair point.  I need to save the fid before calling d_splice_alias().

> Tracepoints: Just Say No...

You can go and argue that one with David Miller if you like.

David

