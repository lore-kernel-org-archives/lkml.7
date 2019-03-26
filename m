Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA50C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C47B2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553563863;
	bh=CIiGuw14V9Ne/GstDE3gc6mLNsCWg8WK7qCRAS8vVg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pabeEmoCnteh0KLREj1EHq6CGDVMz+R3anhHkN5tQ8v5M6sbw9rc+Es1rzGnTqMYn
	 d4jR72L/pfS7QVo/vlb/Y6lewegn5ZTGPr6V9ilFDzo7qLjfrNbMQ85FqvC/QXoR5r
	 GmmaY/MJxks/aDSTaNHtiz+EjzeeselHbc4/MyS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfCZBbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfCZBbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:31:00 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08BFC20848;
        Tue, 26 Mar 2019 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553563860;
        bh=CIiGuw14V9Ne/GstDE3gc6mLNsCWg8WK7qCRAS8vVg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xhFH9rlvEeJEZz1bgYEfyQFuQAWXl0dbgKyyoAPYw63pi9NxhUV3eUfizh+2ocOAH
         O9BIQIY1ya9coJM1OJEN3D62AjnBGYY+9ghAS+UPCs0RRuRsP1zlQAjCvEnjoVTIOU
         C6x7UGTQDnQ4mB2K6HuYw2OfAsa9ujjaVSGyLOkg=
Date:   Tue, 26 Mar 2019 10:30:53 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Waiman Long <longman@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 20/25] Hang/soft lockup in d_invalidate with
 simultaneous calls
Message-ID: <20190326013053.GA21198@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-21-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-21-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:11PM +0100, Arnd Bergmann wrote:
> From: Al Viro <viro@ZenIV.linux.org.uk>
> 
> It's not hard to trigger a bunch of d_invalidate() on the same
> dentry in parallel.  They end up fighting each other - any
> dentry picked for removal by one will be skipped by the rest
> and we'll go for the next iteration through the entire
> subtree, even if everything is being skipped.  Morevoer, we
> immediately go back to scanning the subtree.  The only thing
> we really need is to dissolve all mounts in the subtree and
> as soon as we've nothing left to do, we can just unhash the
> dentry and bugger off.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> (cherry picked from commit 81be24d263dbeddaba35827036d6f6787a59c2c3)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/dcache.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Also added to 4.9.y
