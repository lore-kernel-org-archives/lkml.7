Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37DCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92062147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552494833;
	bh=bn/1tJDwIetgrWZrMI9KrTdg30bcs0Isy2elXrxRawY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uFB+JGKemJ0cD3XH7C4rSl7Wgd8gNiWQMw9C7YiucpI8qLjqwvKYPh/TRqD06ZCYL
	 e8s6ZuBBn6+mjRB8Rq5xLEAM9m4skEJZEI+hwJLvHvVtdx4c543hXk8INNIjmdVwT9
	 rG7c9KyMGg0mrnrg7/HDmTirMQgx0//5uFMbZtJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfCMQdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfCMQdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:33:52 -0400
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0F42146E;
        Wed, 13 Mar 2019 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552494831;
        bh=bn/1tJDwIetgrWZrMI9KrTdg30bcs0Isy2elXrxRawY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjQsbkzJIVcEUnMvHuRG548xvsi5Q4mifAx8aMHWHHFOf9+scooeDgFGPL5cmZPYn
         e0wDs3MJFgR/BgL03oBWgCnsLbeKvsnH35fl7DMbl2y/jllR4kjcZnfZuXiQDr/y6s
         7hEfvQCdz2bFzUK2M6zCgI3Hs8MCo2vOj6S1XSJ0=
Date:   Wed, 13 Mar 2019 09:33:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: overlayfs vs. fscrypt
Message-ID: <20190313163348.GD703@sol.localdomain>
References: <4603533.ZIfxmiEf7K@blindfold>
 <1852545.qrIQg0rEWx@blindfold>
 <CAJfpegvrG4LfnuC62JNtdXpCf4vb+aEiDre5YCxe7xUSQP8yjw@mail.gmail.com>
 <1854703.ve7plDhYWt@blindfold>
 <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
 <20190313150126.GA703@sol.localdomain>
 <20190313161147.GS2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313161147.GS2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 04:11:48PM +0000, Al Viro wrote:
> On Wed, Mar 13, 2019 at 08:01:27AM -0700, Eric Biggers wrote:
> 
> > What do you think about this?
> 
> That fscrypt might have some very deep flaws.  I'll need to RTFS and
> review its model, but what I've seen in this thread so far is not
> promising anything good.
> 
> It's not just overlayfs - there are all kinds of interesting trouble
> possible just with fscrypt, unless I'm misparsing what had been said
> so far.

FYI, there *is* a known bug I was very recently made aware of and am planning to
fix.  When ->lookup() finds the plaintext name for a directory and the
ciphertext name is already in the dcache, d_splice_alias() will __d_move() the
existing dentry to the plaintext name.  But it doesn't set
DCACHE_ENCRYPTED_WITH_KEY, so the dentry incorrectly is still marked as a
ciphertext name and will be invalidated on the next lookup.  That's especially
problematic if the lookup that caused the __d_move() came from sys_mount().

I'm thinking the best fix is to have __d_move() propagate
DCACHE_ENCRYPTED_WITH_KEY from 'target' to 'dentry'.

- Eric
