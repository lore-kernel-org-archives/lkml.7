Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E62C606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6142171F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562606178;
	bh=o1EzjiG2Ss2e/ZZxah1TPImcTccs8sGSRE8rXZthfxk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=Oq7LeH+eRbtuEa0caaP6NtQFOiT7ggbkIMsWiuQmZ1Y3Fdrdvaxz79ayh2ZZC8kzJ
	 lQ6RRbnhxsWOx0YdApX/2/m9KbCKV4B7Gb/f9FyjHSHKIleJjfV3Fs71fJ8ueQDcPA
	 yyjQf1w9GLjmz9LFaNhUEp2ET0FsqavgEeknf9mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbfGHRQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387560AbfGHRQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:16:17 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE7C216FD;
        Mon,  8 Jul 2019 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562606177;
        bh=o1EzjiG2Ss2e/ZZxah1TPImcTccs8sGSRE8rXZthfxk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RSfNULse0O64hAnv/VvVw49jsZ08Aisju9dioP+dPpQ73CvqnIQ+ZJaPolzT/Rs8z
         1LhYHZca8RCOu/Dk3hcArxsSZplpRXkric6uWmBPtwV7JyF+0c3UsPcOeCa5yn3ATW
         6y7czlpVDHROLjrIziUj9OmCbjcrlF003kBUKXJ4=
Message-ID: <e2d1659f8fec54d9bfcbec1822afc76753b44667.camel@kernel.org>
Subject: Re: [PATCH] ceph: fix uninitialized return code
From:   Jeff Layton <jlayton@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Henriques <lhenriques@suse.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Mon, 08 Jul 2019 13:16:14 -0400
In-Reply-To: <20190708134821.587398-1-arnd@arndb.de>
References: <20190708134821.587398-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-08 at 15:48 +0200, Arnd Bergmann wrote:
> clang points out a -Wsometimed-uninitized bug in the modified
> ceph_real_mount() function:
> 
> fs/ceph/super.c:850:6: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         if (!fsc->sb->s_root) {
>             ^~~~~~~~~~~~~~~~
> fs/ceph/super.c:885:9: note: uninitialized use occurs here
>         return err;
>                ^~~
> fs/ceph/super.c:850:2: note: remove the 'if' if its condition is always true
>         if (!fsc->sb->s_root) {
>         ^~~~~~~~~~~~~~~~~~~~~~
> fs/ceph/super.c:843:9: note: initialize the variable 'err' to silence this warning
>         int err;
>                ^
>                 = 0
> 
> Set it to zero if the condition is false.
> 
> Fixes: 108f95bfaa56 ("vfs: Convert ceph to use the new mount API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/ceph/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 0d23903ddfa5..d663aa1286f6 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -876,6 +876,8 @@ static int ceph_real_mount(struct fs_context *fc, struct ceph_fs_client *fsc)
>  			goto out;
>  		}
>  		fsc->sb->s_root = root;
> +	} else {
> +		err = 0;
>  	}
>  
>  	fc->root = dget(fsc->sb->s_root);

I see 108f95bfaa56 linux-next, but this hasn't been merged into the ceph
kclient tree yet. It'd be ideal if Al just squashed this in before
sending the PR to Linus.

In any case, patch looks fine:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

