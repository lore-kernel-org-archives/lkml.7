Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A159C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 00:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20E72080D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 00:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfL0AGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 19:06:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52360 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfL0AGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 19:06:46 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ikd9G-0002gt-Vv; Fri, 27 Dec 2019 00:06:35 +0000
Date:   Fri, 27 Dec 2019 00:06:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix compile warning in afs_dynroot_lookup()
Message-ID: <20191227000634.GS4203@ZenIV.linux.org.uk>
References: <1576761291-30121-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576761291-30121-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 09:14:51PM +0800, Tiezhu Yang wrote:
> Fix the following compile warning:
> 
>   CC      fs/afs/dynroot.o
> fs/afs/dynroot.c: In function ‘afs_dynroot_lookup’:
> fs/afs/dynroot.c:117:6: warning: ‘len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   ret = lookup_one_len(name, dentry->d_parent, len);
>       ^
> fs/afs/dynroot.c:91:6: note: ‘len’ was declared here
>   int len;
>       ^
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  fs/afs/dynroot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
> index 7503899..303f712 100644
> --- a/fs/afs/dynroot.c
> +++ b/fs/afs/dynroot.c
> @@ -88,7 +88,7 @@ static struct dentry *afs_lookup_atcell(struct dentry *dentry)
>  	struct dentry *ret;
>  	unsigned int seq = 0;
>  	char *name;
> -	int len;
> +	int len = 0;
>  
>  	if (!net->ws_cell)
>  		return ERR_PTR(-ENOENT);

NAK.  This is really, really wrong - passing zero to lookup_one_len() is
always a bug.  It's not any better than undefined value; if we *can*
get to lookup_one_len() call without other assignments to len, we
are fucked.

As it were, it's a false positive - we have
                if (cell) {
                        len = cell->name_len;
                        memcpy(name, cell->name, len + 1);
                }
upstream of
        if (!cell)
                goto out_n;

        ret = lookup_one_len(name, dentry->d_parent, len);
so we can't reach the call of lookup_one_len() without having
hit the assignment to len.

BTW, what guarantees that cell->name won't be "@cell"?  The
things would get rather interesting in that case...  The same
for net->sysnames in afs_lookup_atsys() - what makes sure
we won't see "@sys" among those?  David?

While we are at it,
        d = d_splice_alias(inode, dentry);
        if (!IS_ERR_OR_NULL(d)) {
                d->d_fsdata = dentry->d_fsdata;
                trace_afs_lookup(dvnode, &d->d_name,
                                 inode ? AFS_FS_I(inode) : NULL);
        } else {
                trace_afs_lookup(dvnode, &dentry->d_name,
                                 IS_ERR_OR_NULL(inode) ? NULL
                                 : AFS_FS_I(inode));
        }
is _very_ suspicious-looking - d_splice_alias() consumes
an inode reference, and if it ends up failing on non-ERR_PTR()
inode, the inode will be dropped by the time it returns.
IOW, that AFS_FS_I(inode) in the second branch can bloody
well point to already freed memory.  Tracepoints: Just Say No...
