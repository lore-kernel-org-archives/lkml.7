Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68830C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306FB20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="joMy3Udn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfEQC4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 22:56:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfEQC4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4HJiSDZ6NVpZlfpbAIE9JY9i5H7mtH87panNL0CH9Zw=; b=joMy3UdnsiCdt1hoeX13+Vv6h
        LAb/YlelQoJg7XbXDsVeak+AK5oiHXrplz9aGnkr5ikxMvftHA1d864zkhZUa7INRGljf3cop5faP
        6eLUOQWenVHaZqNYk0FpGvaRzfthCKI//0n63yuNpBVSwQwrM04ognUMtqpwrowWlHP+EzWZwHDQt
        VYLFo+QzkJp2hyaqrNyEOSkbuF0RdzAkrqLZgtTOJ4MZDZ6aoUA2pHNk19c5b4bJGIndt+0aPROMw
        uUW5VNR1jtv2m7Vn1ceu8dz9MH/ntT9SeaaiPZaWC+wuizEVbbi/1JlJe5AbV4fOkY5Uv5mVOejYj
        O/LWOHXmw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRT2q-000080-Sj; Fri, 17 May 2019 02:56:28 +0000
Date:   Thu, 16 May 2019 19:56:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     sunqiuyang <sunqiuyang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com,
        miaoxie@huawei.com, fangwei1@huawei.com, stummala@codeaurora.org
Subject: Re: [PATCH v2 1/1] f2fs: ioctl for removing a range from F2FS
Message-ID: <20190517025628.GF31704@bombadil.infradead.org>
References: <20190517021647.43083-1-sunqiuyang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517021647.43083-1-sunqiuyang@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:16:47AM +0800, sunqiuyang wrote:
> +++ b/fs/f2fs/f2fs.h
> @@ -423,6 +423,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
>  #define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
>  #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
> +#define F2FS_IOC_SHRINK_RESIZE		_IOW(F2FS_IOCTL_MAGIC, 16,	\
> +						struct f2fs_resize_param)

Why not match ext4?

fs/ext4/ext4.h:#define EXT4_IOC_RESIZE_FS               _IOW('f', 16, __u64)

