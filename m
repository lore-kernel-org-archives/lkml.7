Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABFAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B2820684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Mun9Onli";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jnEU0MuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfLCW2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:28:40 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54487 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727131AbfLCW2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:28:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5B113899;
        Tue,  3 Dec 2019 17:28:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 03 Dec 2019 17:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/iHjPNbr+QgcG1iIX3iny/wZbOk
        xcbW8NuRkpPnZzxs=; b=Mun9OnlirDAUF7Kv1ogvWb4y4cEzUsBnMXxsFEpjzSd
        yunvJv1VF0kCloyHGQT6Qy4eV6n1bSTuOUw5vQHY06ewdoNJsqvs8hJvNC7MEr4/
        CZhQe9RaD5CpgEhUPPuaXk4CwOkVHlOuIuLFQOxXwsLbjiA7cykotAUytwe6Oyty
        kFX5dsqLvyy6hTr/+Qo1RFrfTN5qcOMCL/q3qDncjrcM+NdOlrkJlP/S+E9/wkVK
        ZRVpue3TthkwtgWnEgXi8rs1P4cEiF1rI5jkCI2v986jItk26jdBjecZxmTfp1/x
        OisJEC3uJ8kZNgZ8MQP/bahSbf+k3Fzoo4ilzla9k8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/iHjPN
        br+QgcG1iIX3iny/wZbOkxcbW8NuRkpPnZzxs=; b=jnEU0MuWn6Jvw4hA4d3vEZ
        Ss/rIw+vFcHnH7JW8V+kIuVboUXRIglwXf8zYqT04m07p8u0cPuocC4qvVV2h3CL
        mHK2IYQv2pLQEju11qfEh39npo/5xTyyxJ+PiIJqp5jP1M8EPd6foFgLviTNFHKe
        3FBHJBZASbeNhhBRLN5VekJXvxNoq7K3aCDtombIsm+hJ1gD3LWhbFaPdUf6TUtk
        yc5lgl6RvZ/XGC6CuV5YJFBSxqnknZfOiJmWYVX6Y+ag2TpB0+fBWF8Z7HOkcNM+
        gqC7wYPnyaZYp+W5drUx2G5B+/rckgauXN4CWtDBriVZpjpFoPiXM7LijbOIuV3g
        ==
X-ME-Sender: <xms:luHmXWqE_nLbSSmFCXEpdFSXzqkTFUe772PRY9cYZUmas7R5R_qj6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:luHmXcGU31AOXvK4EUuOMVb487LS_INiIZ1kRStnzy8rDHRoZTC7dw>
    <xmx:luHmXYnEQQOd7Cf6Uyg6wfKQJ5FwqSVocPwNBxOlMDNULEcX9I0feg>
    <xmx:luHmXflHql4NrPZxr982PRcQgHGmaAQpli7aD9aDFhOWci3b53DYoA>
    <xmx:l-HmXWH93wlJnay39nY3VCEv4bXh1tNpn85zdWivYKbWCSBS9o8n8Q>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4171B3060191;
        Tue,  3 Dec 2019 17:28:38 -0500 (EST)
Date:   Tue, 3 Dec 2019 23:28:33 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     zhengliang6@huawei.com, stable-commits@vger.kernel.org
Subject: Re: Patch "f2fs: fix to data block override node segment by mistake"
 has been added to the 4.14-stable tree
Message-ID: <20191203222833.GB3430290@kroah.com>
References: <20191201151913.A5BFB20675@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201151913.A5BFB20675@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2019 at 10:19:12AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: fix to data block override node segment by mistake
> 
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      f2fs-fix-to-data-block-override-node-segment-by-mist.patch
> and it can be found in the queue-4.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 533b6950b413fd564fb6a3e1f64f53e959c9b999
> Author: zhengliang <zhengliang6@huawei.com>
> Date:   Mon Mar 4 09:32:25 2019 +0800
> 
>     f2fs: fix to data block override node segment by mistake
>     
>     [ Upstream commit a0770e13c8da83bdb64738c0209ab02dd3cfff8b ]
>     
>     v4: Rearrange the previous three versions.
>     
>     The following scenario could lead to data block override by mistake.
>     
>     TASK A            |  TASK kworker                                            |     TASK B                                            |       TASK C
>                       |                                                          |                                                       |
>     open              |                                                          |                                                       |
>     write             |                                                          |                                                       |
>     close             |                                                          |                                                       |
>                       |  f2fs_write_data_pages                                   |                                                       |
>                       |    f2fs_write_cache_pages                                |                                                       |
>                       |      f2fs_outplace_write_data                            |                                                       |
>                       |        f2fs_allocate_data_block (get block in seg S,     |                                                       |
>                       |                                  S is full, and only     |                                                       |
>                       |                                  have this valid data    |                                                       |
>                       |                                  block)                  |                                                       |
>                       |          allocate_segment                                |                                                       |
>                       |          locate_dirty_segment (mark S as PRE)            |                                                       |
>                       |        f2fs_submit_page_write (submit but is not         |                                                       |
>                       |                                written on dev)           |                                                       |
>     unlink            |                                                          |                                                       |
>      iput_final       |                                                          |                                                       |
>       f2fs_drop_inode |                                                          |                                                       |
>         f2fs_truncate |                                                          |                                                       |
>      (not evict)      |                                                          |                                                       |
>                       |                                                          | write_checkpoint                                      |
>                       |                                                          |  flush merged bio but not wait file data writeback    |
>                       |                                                          |  set_prefree_as_free (mark S as FREE)                 |
>                       |                                                          |                                                       | update NODE/DATA
>                       |                                                          |                                                       | allocate_segment (select S)
>                       |     writeback done                                       |                                                       |
>     
>     So we need to guarantee io complete before truncate inode in f2fs_drop_inode.
>     
>     Reviewed-by: Chao Yu <yuchao0@huawei.com>
>     Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
>     Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e4aabfc21bd43..9554338f9c35d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -668,6 +668,10 @@ static int f2fs_drop_inode(struct inode *inode)
>  			sb_start_intwrite(inode->i_sb);
>  			f2fs_i_size_write(inode, 0);
>  
> +			f2fs_submit_merged_write_cond(F2FS_I_SB(inode),
> +					inode, NULL, 0, DATA);
> +			truncate_inode_pages_final(inode->i_mapping);
> +
>  			if (F2FS_HAS_BLOCKS(inode))
>  				f2fs_truncate(inode);
>  

Also dropped from 4.14.y queue as this gives the same warning as on
4.19.y

greg k-h
