Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A57CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4006721744
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279421;
	bh=iybT3LCfgSzls632zjweeql0Z/uGWCb9BW6V1OoxqZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ngmWZkk3xa1KycppqmM0Z5jXOf4gwDXfqD232AGRjKwtpN7HIpaupWVPK3d/EuuwB
	 /nFtPhzHDhVST765FS6kCyZSbJGD+ovFEj3Nw7GgX6aBdXbjaN4A35txRIVo4QGMrr
	 0/dbabiZAMbtNH9us8jRVyL67LEB9evLY3I3QzDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404789AbfFKS5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404245AbfFKS5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:57:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F48D21773;
        Tue, 11 Jun 2019 18:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279419;
        bh=iybT3LCfgSzls632zjweeql0Z/uGWCb9BW6V1OoxqZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+dxChncaYC7o3iHiiRSZSmJjtKh2BTm02rR+manItY9Lqfz9ytixvVzNa6grwxch
         pm8qFmPfd5jKcPubfc8WV3krAjFjEfSBd2y/btjkv4n0ExUmW8JWu9msjEdx/G2OSl
         MWIkVIvTmapQbOMIF4Y/nEt22xXT7ECbvnkEnpso=
Date:   Tue, 11 Jun 2019 20:56:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: no need to check return value of debugfs_create
 functions
Message-ID: <20190611185656.GB4659@kroah.com>
References: <20190611183213.GA31645@kroah.com>
 <201906111144.3E05EAA80@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906111144.3E05EAA80@keescook>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:44:53AM -0700, Kees Cook wrote:
> On Tue, Jun 11, 2019 at 08:32:13PM +0200, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> What is the user-visible feedback when, say, debugfs_create_file()
> fails?

All of the memory in your system is now gone and it would have long
locked up a while before this call ever happened :)

And no user functionality should ever change if a debugfs call fails, or
succeeds, this is debugging only.

> And what happens when debugfs_create_file() passes in a NULL root?

The file ends up in the root of debugfs.  But as this can only happen if
the system is dead, I wouldn't worry about it.

thanks,

greg k-h
