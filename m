Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598D8C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296B320873
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfELUG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 16:06:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfELUG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 16:06:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0E0230821C0;
        Sun, 12 May 2019 20:06:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C646A19C65;
        Sun, 12 May 2019 20:06:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5CD8697B.6010004@bfs.de>
References: <5CD8697B.6010004@bfs.de> <5CD844B0.5060206@bfs.de> <155764714099.24080.1233326575922058381.stgit@warthog.procyon.org.uk> <155764714872.24080.15171754166782593095.stgit@warthog.procyon.org.uk> <31808.1557684645@warthog.procyon.org.uk>
To:     wharms@bfs.de
Cc:     dhowells@redhat.com, colin.king@canonical.com, joe@perches.com,
        jaltman@auristor.com, linux-afs@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] afs: Fix afs_xattr_get_yfs() to not try freeing an error value
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6818.1557691584.1@warthog.procyon.org.uk>
Date:   Sun, 12 May 2019 21:06:24 +0100
Message-ID: <6819.1557691584@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 12 May 2019 20:06:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walter harms <wharms@bfs.de> wrote:

> Sorry, you misunderstood me, my fault, i did not see that size is unsigned.
> NTL i do not think size=0 is useful.

Allow me to quote from the getxattr manpage:

       If size is specified as zero, these calls return the  current  size  of
       the  named extended attribute (and leave value unchanged).  This can be
       used to determine the size of the buffer that should be supplied  in  a
       subsequent  call.   [...]

> while you are there:
>   flags |= YFS_ACL_WANT_ACL is always flags = YFS_ACL_WANT_ACL;
> since flags is 0 at this point.
> IMHO that sould be moved to the strcmp() section.

Why?  It makes the strcmp() section more complicated and means I now either
have to cache flags in a variable or do the allocation of yacl first.

David
