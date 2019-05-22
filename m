Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8630C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA21320863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfEVUDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:03:08 -0400
Received: from nautica.notk.org ([91.121.71.147]:49794 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbfEVTVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:21:46 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E8FC1C009; Wed, 22 May 2019 21:21:44 +0200 (CEST)
Date:   Wed, 22 May 2019 21:21:29 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p/cache.c: Fix memory leak in
 v9fs_cache_session_get_cookie
Message-ID: <20190522192129.GA30941@nautica>
References: <20190522191655.GA4657@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522191655.GA4657@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath Vedartham wrote on Thu, May 23, 2019:
> v9fs_cache_session_get_cookie assigns a random cachetag to
> v9ses->cachetag, if the cachetag is not assigned previously.
> 
> v9fs_random_cachetag allocates memory to v9ses->cachetag with kmalloc
> and uses scnprintf to fill it up with a cachetag.
> 
> But if scnprintf fails, v9ses->cachetag is not freed in the current code causing a memory leak.
> 
> Fix this by freeing v9ses->cachetag it v9fs_random_cachetag fails.
> 
> This was reported by syzbot, the link to the report is below:
> https://syzkaller.appspot.com/bug?id=f012bdf297a7a4c860c38a88b44fbee43fd9bbf3
> 
> Reported-by: syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  fs/9p/cache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/9p/cache.c b/fs/9p/cache.c
> index 9eb3470..4463b91 100644
> --- a/fs/9p/cache.c
> +++ b/fs/9p/cache.c
> @@ -66,6 +66,7 @@ void v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses)
>  	if (!v9ses->cachetag) {
>  		if (v9fs_random_cachetag(v9ses) < 0) {
>  			v9ses->fscache = NULL;
> +			kfree(v9ses->cachetag);

I would also reset v9ses->cachetag to NULL just in case,
v9fs_cache_session_get_cookie will use v9ses->cachetag as it is if it is
not null and you were leaving an invalid pointer there

I do not see any reason it could be called multiple times but
v9fs_cache_session_get_cookie does not return any error (void function)
so something later on could try to use that cachetag incorrectly later
on

Thanks,
-- 
Dominique
