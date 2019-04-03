Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEBDC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80042133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ECT6lpn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDCR43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:56:29 -0400
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:48858 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbfDCR43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554314187;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=Wyd/86VQr4yB+T3sAKBmvWlFZRyqyhljETAB3MKNVBw=;
        b=ECT6lpn36hcc5RiE9hxy2iLqLJPNP+ceZdI1xVdCLGsleGlkdonBVCwBaMVznKj4
        9CTvSAAFdKBjZ5hY26du2Zk6Bwpjfzk1DQnCiRgMlrd7d6F9fC1XJwzxF8Lb0VLl5iT
        ZVRQU9YU3p/X/L7Wsb55owNa6j6s7KblS1qdWtJ0=
Date:   Wed, 3 Apr 2019 17:56:27 +0000
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
In-Reply-To: <20190403170811.GR2217@ZenIV.linux.org.uk>
Message-ID: <01000169e458534a-3c6a5d6f-3054-4c64-b5f9-7f46c811eeac-000000@email.amazonses.com>
References: <20190403042127.18755-1-tobin@kernel.org> <20190403042127.18755-15-tobin@kernel.org> <20190403170811.GR2217@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.03-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, Al Viro wrote:

> Let's do d_invalidate() on random dentries and hope they go away.
> With convoluted and brittle logics for deciding which ones to
> spare, which is actually wrong.  This will pick mountpoints
> and tear them out, to start with.
>
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
>
> And this is a NAK for the entire approach; if it has a positive refcount,
> LEAVE IT ALONE.  Period.  Don't play this kind of games, they are wrong.
> d_invalidate() is not something that can be done to an arbitrary dentry.

Well could you help us figure out how to do it the right way? We (the MM
guys) are having a hard time not being familiar with the filesystem stuff.

This is an RFC and we want to know how to do this right.

