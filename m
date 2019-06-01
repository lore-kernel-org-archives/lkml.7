Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94035C28CC3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 16:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7DC2774F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559406032;
	bh=Oq4KykqH+FHZbNln7dGaSM784b0NrfPtmcIDwIh/rEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rogHCC0FpW+In94EU7nU4qvkmDPVj6ogJbDE3gwXqGCURrqOcqPDn0WCV3bFUZMhu
	 fcdCzqdpgaR39LeucjNZCe8dPTmfSa0wf2agFZ5tgQ+lh+bh6Y8RZEMNt5ft7Qj49V
	 KQ3ZKBSbkkUZqaN2+yjeHJWzxplNrHbpFPehiR0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfFAQUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 12:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfFAQUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 12:20:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC4C2768D;
        Sat,  1 Jun 2019 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559406030;
        bh=Oq4KykqH+FHZbNln7dGaSM784b0NrfPtmcIDwIh/rEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGtEHdBS0dgdz7gPH0yR5BeWGy3ydU7vnlxsuqlPICn4QM+atOaCpYjUQVYF83vNH
         gvFdj+WgTBKpwMu6xOnCgofw0cNVzmT8+KzaczWL5shWKpsWwETTIeo1JTRMvKjaY5
         6rPux7npxJQaXyMm7CxwO4sAjX/Co1iyzQThL9Xw=
Date:   Sat, 1 Jun 2019 09:17:07 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sahara <keun-o.park@darkmatter.ae>
Subject: Re: [PATCH AUTOSEL 4.4 50/56] tty: pty: Fix race condition between
 release_one_tty and pty_write
Message-ID: <20190601161707.GC4200@kroah.com>
References: <20190601132600.27427-1-sashal@kernel.org>
 <20190601132600.27427-50-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601132600.27427-50-sashal@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2019 at 09:25:54AM -0400, Sasha Levin wrote:
> From: Sahara <keun-o.park@darkmatter.ae>
> 
> [ Upstream commit b9ca5f8560af244489b4a1bc1ae88b341f24bc95 ]
> 
> Especially when a linked tty is used such as pty, the linked tty
> port's buf works have not been cancelled while master tty port's
> buf work has been cancelled. Since release_one_tty and flush_to_ldisc
> run in workqueue threads separately, when pty_cleanup happens and
> link tty port is freed, flush_to_ldisc tries to access freed port
> and port->itty, eventually it causes a panic.
> This patch utilizes the magic value with holding the tty_mutex to
> check if the tty->link is valid.
> 
> Fixes: 2b022ab7542d ("pty: cancel pty slave port buf's work in tty_release")
> Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/tty/pty.c    | 7 +++++++
>  drivers/tty/tty_io.c | 3 +++
>  2 files changed, 10 insertions(+)

For some reason I did not apply this to the stable kernels, and this
shouldn't only be for 4.4.y, so please drop this.

thanks,

greg k-h
