Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175AAC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B72147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ZWOn1Mc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfDDPqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:46:32 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:55668 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbfDDPqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554392791;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=X/2BCjBLOwDcCBYuqS+EKFW7PX1QL8vk7+x2K01CwMI=;
        b=ZWOn1Mc/6/Z6wYKOt+kb2vZGIZ2iEyJ6G8RhqF5UjGurHdo7LenW790CvTeKwXqp
        ffbQj3A2xpA88fJD8sVpYGoZRwnuJvSLw6hh3FnOb9nIEY9WKY74uZrvxvIzQGkwFu6
        drKobnYvkMnqw2qFeDTht5FgRvoE0Us5o+pBRNvA=
Date:   Thu, 4 Apr 2019 15:46:31 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v2 14/14] dcache: Implement object migration
In-Reply-To: <20190403182454.GU2217@ZenIV.linux.org.uk>
Message-ID: <01000169e907b8a0-2dbaab3f-18ad-4744-a81a-78809e2b7756-000000@email.amazonses.com>
References: <20190403042127.18755-1-tobin@kernel.org> <20190403042127.18755-15-tobin@kernel.org> <20190403170811.GR2217@ZenIV.linux.org.uk> <01000169e458534a-3c6a5d6f-3054-4c64-b5f9-7f46c811eeac-000000@email.amazonses.com>
 <20190403182454.GU2217@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.04-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, Al Viro wrote:

> > This is an RFC and we want to know how to do this right.
>
> If by "how to do it right" you mean "expedit kicking out something with
> non-zero refcount" - there's no way to do that.  Nothing even remotely
> sane.

Sure we know that.

> If you mean "kick out everything in this page with zero refcount" - that
> can be done (see further in the thread).

Ok that would already be progress. If we can use this to liberate some
slab pages with just a few dentry object then it may be worthwhile.

> Look, dentries and inodes are really, really not relocatable.  If they
> can be evicted by memory pressure - sure, we can do that for a given
> set (e.g. "everything in that page").  But that's it - if memory
> pressure would _not_ get rid of that one, there's nothing to be done.
> Again, all VM can do is to simulate shrinker hitting hard on given
> bunch (rather than buggering the entire cache).  If filesystem (or
> something in VFS) says "it's busy", it bloody well _is_ busy and
> won't be going away until it ceases to be such.

Right. Thats why the patch attempted to check for these things to avoid
touching such objects.

