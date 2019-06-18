Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5A2C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C5820873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfFRWey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbfFRWey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FE433092674;
        Tue, 18 Jun 2019 22:34:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68C6C100996F;
        Tue, 18 Jun 2019 22:34:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegutheVtnmN6BFSjzrmz8p9+DpZxFoKa4CoShoh4MW+5gQ@mail.gmail.com>
References: <CAJfpegutheVtnmN6BFSjzrmz8p9+DpZxFoKa4CoShoh4MW+5gQ@mail.gmail.com> <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk> <155905629702.1662.7233272785972036117.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 04/25] vfs: Implement parameter value retrieval with fsinfo() [ver #13]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24126.1560897289.1@warthog.procyon.org.uk>
Date:   Tue, 18 Jun 2019 23:34:49 +0100
Message-ID: <24127.1560897289@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 18 Jun 2019 22:34:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Again, don't blindly transform s_flags into options, because some of
> them may have been internally manipulated by the filesystem.

In what filesystems do I need to undo this manipulation?

> You could do a helper for filesystems that does the the common ones
> (ro/sync/dirsync) but all of that *should* go through the filesystem.

I don't agree, but since you keep insisting, I've changed the helper function
that renders these so that it now takes s_flags as an argument and is called
from generic_fsinfo() if the filesystem doesn't handle FSINFO_ATTR_PARAMETERS.

Therefore, every filesystem that handles FSINFO_ATTR_PARAMETERS, *must* call
the function itself (or do the noting directly) otherwise these parameters
will not get rendered.

The helper function has been exported, and the calling filesystem can give any
s_flags it likes.  All the filesystems so far just use
path->dentry->d_sb->s_flags.

> Same goes for vfs_parse_sb_flag() btw.   It should be moved into each
> filesystem's ->parse_param() and not be a mandatory thing.

I disagree.  Every filesystem *must* be able to accept these standard flags,
even if it then ignores them.

David
