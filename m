Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10689C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C5821835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfJOHWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:22:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfJOHWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:22:20 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9F6AA85273C0512E6435;
        Tue, 15 Oct 2019 15:22:17 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 15 Oct
 2019 15:22:14 +0800
Subject: Re: [PATCH] f2fs: fix to avoid memory leakage in f2fs_listxattr
To:     Randall Huang <huangrandall@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20191009032019.6954-1-huangrandall@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <efddfbc3-bd31-b9fb-48de-decb01d01001@huawei.com>
Date:   Tue, 15 Oct 2019 15:22:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191009032019.6954-1-huangrandall@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randall,

On 2019/10/9 11:20, Randall Huang wrote:
> In f2fs_listxattr, there is no boundary check before
> memcpy e_name to buffer.
> If the e_name_len is corrupted,
> unexpected memory contents may be returned to the buffer.
> 
> Signed-off-by: Randall Huang <huangrandall@google.com>
> ---
>  fs/f2fs/xattr.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index b32c45621679..acc3663970cd 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -538,8 +538,9 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>  ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>  {
>  	struct inode *inode = d_inode(dentry);
> +	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
>  	struct f2fs_xattr_entry *entry;
> -	void *base_addr;
> +	void *base_addr, *last_base_addr;
>  	int error = 0;
>  	size_t rest = buffer_size;
>  
> @@ -549,6 +550,8 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>  	if (error)
>  		return error;
>  
> +	last_base_addr = (void *)base_addr + XATTR_SIZE(xnid, inode);
> +
>  	list_for_each_xattr(entry, base_addr) {
>  		const struct xattr_handler *handler =
>  			f2fs_xattr_handler(entry->e_name_index);
> @@ -559,6 +562,15 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>  		if (!handler || (handler->list && !handler->list(dentry)))
>  			continue;
>  
> +		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
> +			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
> +			f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
> +						inode->i_ino);
> +			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> +			error = -EFSCORRUPTED;
> +			goto cleanup;
> +		}

Could you relocate sanity check to the place before we check handler? As I'm
thinking we should always check validation of current entry before using its
field (entry->index).

Thanks,

> +
>  		prefix = xattr_prefix(handler);
>  		prefix_len = strlen(prefix);
>  		size = prefix_len + entry->e_name_len + 1;
> 
