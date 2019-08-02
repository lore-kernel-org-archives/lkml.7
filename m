Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AB0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F21216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564763562;
	bh=1dY9dkZC8/0rNIVNPhWlmJIGw2Fn+nke+Cx8Y2WqslE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=1/HAaLLfN4s6gGDpQvVaGPnvJPgqSW4U92csb3qww+MLZF1gvssWqRIUrid9UTpmw
	 WCfwXufU5Vcin1BzvqTzVnLPlGMvQqMvIxZRuBJm2iy1CbhTeEZQOioGIde82ukgig
	 fYpH3UwC5H/5fw5l4S6uttQLfDCBewfMabgfm5vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391276AbfHBQck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391044AbfHBQck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:32:40 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B4A2087E;
        Fri,  2 Aug 2019 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564763559;
        bh=1dY9dkZC8/0rNIVNPhWlmJIGw2Fn+nke+Cx8Y2WqslE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=w9lC7d/J2b2evJ3hdfblytM+pyTOBE5/6j/xetCh1lnfVbAKbgleAivNvwuv+cK+I
         juOFzY+Rq5aV9tnRvib3kGBa/z6jlMrK1IN4ONnBBuq1OVB8IUcUL3WnQd2pcxMRna
         m5sZdGkNIZrGL3/J2MK86MjLYi2o6z5PRXqYVpww=
Message-ID: <89f2fdcbd007dcf6bb2b01772a17eb63459cac9d.camel@kernel.org>
Subject: Re: [PATCH] fs/ceph: don't return a value from void function
From:   Jeff Layton <jlayton@kernel.org>
To:     john.hubbard@gmail.com
Cc:     Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Date:   Fri, 02 Aug 2019 12:32:37 -0400
In-Reply-To: <20190802010658.18150-1-jhubbard@nvidia.com>
References: <20190802010658.18150-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 18:06 -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> This fixes a build warning to that effect.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi,
> 
> I ran into this while working on unrelated changes, to
> convert ceph over to put_user_page().
> 
> This patch is against the latest linux.git.
> 
> thanks,
> John Hubbard
> NVIDIA
> 
> 
>  fs/ceph/debugfs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 2eb88ed22993..facb387c2735 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -294,7 +294,6 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>  
>  void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>  {
> -	return 0;
>  }
>  
>  void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)

Thanks. Merged into ceph-client/testing branch, we'll see about getting
this to Linus before v5.3 ships.
-- 
Jeff Layton <jlayton@kernel.org>

