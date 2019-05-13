Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A4C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0CF20578
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557731649;
	bh=u0FJlBS537HaHJw+5yUJoZ5Nb1A7lrTHIbeNy8X65VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u4k/RMRXj58iwTHDRfvKAIycStA57lpvqf3jV7BM4cUFZ1jg2G8vb9ZnvB3/kemeE
	 k/4eMC+ueyKZfiqbfZttYpWKsuFe3tPurB+89FS4krpx7vnbD4JrkKyzs6LiZFD4zL
	 JnsyH/IVM4IYm596LudjghPAXc0YMdok+HzOJnYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfEMHOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfEMHOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:14:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259EC20578;
        Mon, 13 May 2019 07:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557731647;
        bh=u0FJlBS537HaHJw+5yUJoZ5Nb1A7lrTHIbeNy8X65VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/4vKkRQDVcgIpYrWEF7EXcG2x7CttfLYu4G55iSSZHUOy2F0Ihc27KfO9Xc9KOqb
         yAySn/OXtNG9O4vj8wHogZYBawVcLTQOJvabbTYMpjECsCec8HjIadxTBV3Ayn4X71
         KPQe9NGkr5e0Yna8ZFsKJgekUlzBQPZUTK3aajDs=
Date:   Mon, 13 May 2019 09:14:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: Fix error path kobject memory leak
Message-ID: <20190513071405.GF2868@kroah.com>
References: <20190513033213.2468-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513033213.2468-1-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 01:32:13PM +1000, Tobin C. Harding wrote:
> If a call to kobject_init_and_add() fails we must call kobject_put()
> otherwise we leak memory.
> 
> Function always calls kobject_init_and_add() which always calls
> kobject_init().
> 
> It is safe to leave object destruction up to the kobject release
> function and never free it manually.
> 
> Remove call to kfree() and always call kobject_put() in the error path.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> Is it ok to send patches during the merge window?
> 
> Applies on top of Linus' mainline tag: v5.1
> 
> Happy to rebase if there are conflicts.
> 
> thanks,
> Tobin.
> 
>  fs/gfs2/sys.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index 1787d295834e..98586b139386 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -661,8 +661,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
>  	if (error)
>  		goto fail_reg;
>  
> -	sysfs_frees_sdp = 1; /* Freeing sdp is now done by sysfs calling
> -				function gfs2_sbd_release. */

You should also delete this variable at the top of the function, as it
is now only set once there and never used.

With that:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
