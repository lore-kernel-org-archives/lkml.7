Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA7FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FA3222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfIZO00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:26:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57110 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfIZO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:26:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDUik-0002M1-Tn; Thu, 26 Sep 2019 14:26:15 +0000
Date:   Thu, 26 Sep 2019 15:26:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     dwmw2@infradead.org, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2: Fix mounting under new mount API
Message-ID: <20190926142614.GU26530@ZenIV.linux.org.uk>
References: <156950767876.30879.17024491763471689960.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156950767876.30879.17024491763471689960.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 03:21:18PM +0100, David Howells wrote:
> The mounting of jffs2 is broken due to the changes from the new mount API
> because it specifies a "source" operation, but then doesn't actually
> process it.  But because it specified it, it doesn't return -ENOPARAM and
> the caller doesn't process it either and the source gets lost.
> 
> Fix this by simply removing the source parameter from jffs2 and letting the
> VFS deal with it in the default manner.
> 
> To test it, enable CONFIG_MTD_MTDRAM and allow the default size and erase
> block size parameters, then try and mount the /dev/mtdblock<N> file that
> that creates as jffs2.  No need to initialise it.
> 
> Fixes: ec10a24f10c8 ("vfs: Convert jffs2 to use the new mount API")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: David Woodhouse <dwmw2@infradead.org>
> cc: Richard Weinberger <richard@nod.at>
> cc: linux-mtd@lists.infradead.org

Applied.
