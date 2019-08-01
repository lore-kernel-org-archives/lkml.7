Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F009C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636F2214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564633614;
	bh=x3oQphNi97BHKesFCyayCBd82tnHLFnRd4EkUkIb9LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0gLyXib5zDbpCOaTcS0mLLrh3K408v4m4cb1EL+RF9VpEtMvoqqbpCfT4GOX4ovqL
	 RWXlYhoxpYpdOEZzRQGcZWn4BLfMi5OIzF72yH6zRshMYUffwWbb6SU1bKLn5iUfrh
	 QFOQoN+6SM8InzZRMOW+ieuGcHYHABQ66AEqJJqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfHAE0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 00:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfHAE0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:26:52 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F161206B8;
        Thu,  1 Aug 2019 04:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564633611;
        bh=x3oQphNi97BHKesFCyayCBd82tnHLFnRd4EkUkIb9LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeUYGnHhD5Uw+xaqPnD9h3Ef8nY+q7sUcL6J6hJyLV3MYcLgGWSTfw1nzGTVGjB2J
         cEufzu6izk8I2/CcmjO2ouN7kl1cf139fwicID4od8qakauIExNoVryLGopD611WrN
         GRVOTXQxhtbZb2ZrM0j5DbQR6ZmAUkggqwDMUjms=
Date:   Wed, 31 Jul 2019 21:26:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix livelock in swapfile writes
Message-ID: <20190801042650.GD84433@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190731204353.62056-1-jaegeuk@kernel.org>
 <f500dafa-19f4-78ff-2645-2239fbf43eab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f500dafa-19f4-78ff-2645-2239fbf43eab@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Chao Yu wrote:
> On 2019/8/1 4:43, Jaegeuk Kim wrote:
> > This patch fixes livelock in the below call path when writing swap pages.
> > 
> > [46374.617256] c2    701  __switch_to+0xe4/0x100
> > [46374.617265] c2    701  __schedule+0x80c/0xbc4
> > [46374.617273] c2    701  schedule+0x74/0x98
> > [46374.617281] c2    701  rwsem_down_read_failed+0x190/0x234
> > [46374.617291] c2    701  down_read+0x58/0x5c
> > [46374.617300] c2    701  f2fs_map_blocks+0x138/0x9a8
> > [46374.617310] c2    701  get_data_block_dio_write+0x74/0x104
> > [46374.617320] c2    701  __blockdev_direct_IO+0x1350/0x3930
> > [46374.617331] c2    701  f2fs_direct_IO+0x55c/0x8bc
> > [46374.617341] c2    701  __swap_writepage+0x1d0/0x3e8
> > [46374.617351] c2    701  swap_writepage+0x44/0x54
> > [46374.617360] c2    701  shrink_page_list+0x140/0xe80
> > [46374.617371] c2    701  shrink_inactive_list+0x510/0x918
> > [46374.617381] c2    701  shrink_node_memcg+0x2d4/0x804
> > [46374.617391] c2    701  shrink_node+0x10c/0x2f8
> > [46374.617400] c2    701  do_try_to_free_pages+0x178/0x38c
> > [46374.617410] c2    701  try_to_free_pages+0x348/0x4b8
> > [46374.617419] c2    701  __alloc_pages_nodemask+0x7f8/0x1014
> > [46374.617429] c2    701  pagecache_get_page+0x184/0x2cc
> > [46374.617438] c2    701  f2fs_new_node_page+0x60/0x41c
> > [46374.617449] c2    701  f2fs_new_inode_page+0x50/0x7c
> > [46374.617460] c2    701  f2fs_init_inode_metadata+0x128/0x530
> > [46374.617472] c2    701  f2fs_add_inline_entry+0x138/0xd64
> > [46374.617480] c2    701  f2fs_do_add_link+0xf4/0x178
> > [46374.617488] c2    701  f2fs_create+0x1e4/0x3ac
> > [46374.617497] c2    701  path_openat+0xdc0/0x1308
> > [46374.617507] c2    701  do_filp_open+0x78/0x124
> > [46374.617516] c2    701  do_sys_open+0x134/0x248
> > [46374.617525] c2    701  SyS_openat+0x14/0x20
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index abbf14e9bd72..f49f243fd54f 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1372,7 +1372,7 @@ static int get_data_block_dio_write(struct inode *inode, sector_t iblock,
> >  	return __get_data_block(inode, iblock, bh_result, create,
> >  				F2FS_GET_BLOCK_DIO, NULL,
> >  				f2fs_rw_hint_to_seg_type(inode->i_write_hint),
> > -				true);
> > +				IS_SWAPFILE(inode) ? false : true);
> 
> I suspect that we should use node_change for swapfile rather than just changing
> may_write field to skip lock.

Swap write should not change the node page.

> 
> __do_map_lock()
> if (flag == F2FS_GET_BLOCK_PRE_AIO || IS_SWAPFILE(inode)) {
> 	...
> } else {
> 	...
> }
> 
> Thanks,
> 
> 
> >  }
> >  
> >  static int get_data_block_dio(struct inode *inode, sector_t iblock,
> > 
