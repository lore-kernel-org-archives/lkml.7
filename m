Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C40C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7258520663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562075302;
	bh=BwETEfdpwCvcq75u50VMclxvQHxTjre6A1S6kAFqa/4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=NsIcJaIMSU/uaHI5t9VjqmvoPoGHTWpAdJ5CUlhB3885fgKoVS3imAb48BQsORRMm
	 x7xjt/a0dc4BNTGLdcBpVZeyjqVCtXdNUN4AZbNTQ/ttWPgnR/SNXzdWbGckR+cfH3
	 Ya8EmEkoYXVQj8GNqMxFixlG8f2l2PluqpildEL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfGBNsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfGBNsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:48:20 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643762063F;
        Tue,  2 Jul 2019 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562075300;
        bh=BwETEfdpwCvcq75u50VMclxvQHxTjre6A1S6kAFqa/4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YFxLNZG3xN+7oMSmcrVs5aOkEm0yJtLGPmh9COc7bYmhnqXxDOQNsNRekMceVbrDE
         m5TxuTXsNmozmfHnnA9BBTi7KTbugfKOoDWix2BkAYF9EFSbM3jjZZ+oIqVNVESCxu
         HbvIqck07Qd72lHpAl+8zR9F0Et/NiyyPGkDKa3s=
Message-ID: <85689b9674e96c15602f6a1829142273868250df.camel@kernel.org>
Subject: Re: [PATCH] ceph: fix end offset in truncate_inode_pages_range call
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     zhengbin <zhengbin13@huawei.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 02 Jul 2019 09:48:16 -0400
In-Reply-To: <20190701171634.20290-1-lhenriques@suse.com>
References: <20190701171634.20290-1-lhenriques@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-01 at 18:16 +0100, Luis Henriques wrote:
> Commit e450f4d1a5d6 ("ceph: pass inclusive lend parameter to
> filemap_write_and_wait_range()") fixed the end offset parameter used to
> call filemap_write_and_wait_range and invalidate_inode_pages2_range.
> Unfortunately it missed truncate_inode_pages_range, introducing a
> regression that is easily detected by xfstest generic/130.
> 
> The problem is that when doing direct IO it is possible that an extra page
> is truncated from the page cache when the end offset is page aligned.
> This can cause data loss if that page hasn't been sync'ed to the OSDs.
> 
> While there, change code to use PAGE_ALIGN macro instead.
> 
> Fixes: e450f4d1a5d6 ("ceph: pass inclusive lend parameter to filemap_write_and_wait_range()")
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 183c37c0a8fc..7a57db8e2fa9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1007,7 +1007,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
>  			 * may block.
>  			 */
>  			truncate_inode_pages_range(inode->i_mapping, pos,
> -					(pos+len) | (PAGE_SIZE - 1));
> +						   PAGE_ALIGN(pos + len) - 1);
>  
>  			req->r_mtime = mtime;
>  		}

Luis, should this be sent to stable? It seems like a data corruption
problem...

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

