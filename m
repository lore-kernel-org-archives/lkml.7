Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64951C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1292133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKUpQ1ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDIIgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:36:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42584 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:36:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id w25so7830509pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+tQhPZ8Si6vkDXfFNhBrEQr3x+Q81KXIuatVEcf0Oo=;
        b=WKUpQ1eaB0jUnX2hKisOp/Y4bo3BnZCZoNJZV4h2neMF+Z0ABOYX713M9pPZtHPiQP
         Xyzs0nsPckSwolq+qNY9R7ad40rJhuFCr15keIOFn4PE5/CAwqDRU/pfrOBZWI88cHPp
         Bz9e2HGClQtvXh6Z3EGbtLuLfnXBkLFGyZgCJwHxvb9/penwpjJo3SAOBjY/lLeZVlZY
         RcTe6uQI+o+oFvaVIhLpCNAR+R+hvSAmWqfxcYw3HY0jobxb6pCggrUYibfcoY6NcvIG
         Cvz6/eQ/yGSEl5ZJ4qYqZKqWU/4//13/bhuVOvUg9WT9wHJ+2oG7uFt8V3SDdp5QEaE5
         P3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+tQhPZ8Si6vkDXfFNhBrEQr3x+Q81KXIuatVEcf0Oo=;
        b=lVOD29bogh9aEMJisvocGtZh+kF+KHUM73L+pdOgPUZAb7EOJtLtXYhr54Qha1w0z2
         bBm6xy8JjShzTebUPva+riYntoyF4cDvK4rFwFkKwkDcQ4E4Vtxev2pS6c3STKWcPi9z
         VfgxtvrnHm5lkbxRNDWVJqy/2BRbCtqp0oBTEx772y7PISxbGIR4GEmlmMde30KO4ick
         s1frn34gTACzmtmAPZlMeV+LXpIlg4cBYDqVKnEss5NXCQj7jDD6i/HG1GuYixRHuX9k
         pNNsOyquLCJIv7XBUp4WA4n5bTihPllB7fuXDZR9VGb7PHcH8BftPbaBGTcbgRAdQm9g
         3vqA==
X-Gm-Message-State: APjAAAWkkvS4/yvErA1aVdhG8Q9dB2oyr1xd/NsaGuXv57UDmFoufJRJ
        ZElDE8GAhjEBVH4rxTllYV2r5Q==
X-Google-Smtp-Source: APXvYqxrt5erBUQvMy4+SmT2C9stUS2tsPp8yvx8qQgpf7A/tE/fyIYj0T2q96iKqMp4QYMd+EWRzg==
X-Received: by 2002:a62:6490:: with SMTP id y138mr35198520pfb.230.1554798973583;
        Tue, 09 Apr 2019 01:36:13 -0700 (PDT)
Received: from google.com ([2401:fa00:fc:1:6924:4b22:cf4b:bbca])
        by smtp.gmail.com with ESMTPSA id v82sm72677074pfa.170.2019.04.09.01.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 01:36:12 -0700 (PDT)
Date:   Tue, 9 Apr 2019 16:36:05 +0800
From:   Randall Huang <huangrandall@google.com>
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid accessing xattr across the
 boundary
Message-ID: <20190409083605.GA178602@google.com>
References: <20190408085016.13042-1-huangrandall@google.com>
 <bc8b164b-4787-cf81-9b47-334e7e0be630@huawei.com>
 <60f10416-4055-edb6-0e84-88eca3ea50bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f10416-4055-edb6-0e84-88eca3ea50bd@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 08:14:43PM +0800, Chao Yu wrote:
> On 2019/4/8 20:03, Chao Yu wrote:
> > Hi Randall,
> > 
> > On 2019/4/8 16:50, Randall Huang wrote:
> >> When we traverse xattr entries via __find_xattr(),
> >> if the raw filesystem content is faked or any hardware failure occurs,
> >> out-of-bound error can be detected by KASAN.
> >> Fix the issue by introducing boundary check.
> >>
> >> [   38.402878] c7   1827 BUG: KASAN: slab-out-of-bounds in f2fs_getxattr+0x518/0x68c
> >> [   38.402891] c7   1827 Read of size 4 at addr ffffffc0b6fb35dc by task
> >> [   38.402935] c7   1827 Call trace:
> >> [   38.402952] c7   1827 [<ffffff900809003c>] dump_backtrace+0x0/0x6bc
> >> [   38.402966] c7   1827 [<ffffff9008090030>] show_stack+0x20/0x2c
> >> [   38.402981] c7   1827 [<ffffff900871ab10>] dump_stack+0xfc/0x140
> >> [   38.402995] c7   1827 [<ffffff9008325c40>] print_address_description+0x80/0x2d8
> >> [   38.403009] c7   1827 [<ffffff900832629c>] kasan_report_error+0x198/0x1fc
> >> [   38.403022] c7   1827 [<ffffff9008326104>] kasan_report_error+0x0/0x1fc
> >> [   38.403037] c7   1827 [<ffffff9008325000>] __asan_load4+0x1b0/0x1b8
> >> [   38.403051] c7   1827 [<ffffff90085fcc44>] f2fs_getxattr+0x518/0x68c
> >> [   38.403066] c7   1827 [<ffffff90085fc508>] f2fs_xattr_generic_get+0xb0/0xd0
> >> [   38.403080] c7   1827 [<ffffff9008395708>] __vfs_getxattr+0x1f4/0x1fc
> >> [   38.403096] c7   1827 [<ffffff9008621bd0>] inode_doinit_with_dentry+0x360/0x938
> >> [   38.403109] c7   1827 [<ffffff900862d6cc>] selinux_d_instantiate+0x2c/0x38
> >> [   38.403123] c7   1827 [<ffffff900861b018>] security_d_instantiate+0x68/0x98
> >> [   38.403136] c7   1827 [<ffffff9008377db8>] d_splice_alias+0x58/0x348
> >> [   38.403149] c7   1827 [<ffffff900858d16c>] f2fs_lookup+0x608/0x774
> >> [   38.403163] c7   1827 [<ffffff900835eacc>] lookup_slow+0x1e0/0x2cc
> >> [   38.403177] c7   1827 [<ffffff9008367fe0>] walk_component+0x160/0x520
> >> [   38.403190] c7   1827 [<ffffff9008369ef4>] path_lookupat+0x110/0x2b4
> >> [   38.403203] c7   1827 [<ffffff900835dd38>] filename_lookup+0x1d8/0x3a8
> >> [   38.403216] c7   1827 [<ffffff900835eeb0>] user_path_at_empty+0x54/0x68
> >> [   38.403229] c7   1827 [<ffffff9008395f44>] SyS_getxattr+0xb4/0x18c
> >> [   38.403241] c7   1827 [<ffffff9008084200>] el0_svc_naked+0x34/0x38
> >>
> >> Bug: 126558260
> >>
> >> Signed-off-by: Randall Huang <huangrandall@google.com>
> >> ---
> >>  fs/f2fs/xattr.c | 22 ++++++++++++++++------
> >>  1 file changed, 16 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> >> index 848a785abe25..0531c1e38275 100644
> >> --- a/fs/f2fs/xattr.c
> >> +++ b/fs/f2fs/xattr.c
> >> @@ -202,12 +202,17 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int index)
> >>  	return handler;
> >>  }
> >>  
> >> -static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
> >> -					size_t len, const char *name)
> >> +static struct f2fs_xattr_entry *__find_xattr(void *base_addr,
> >> +				int base_addr_limit, int index,
> > 
> > unsigned int max_size,
> > 
> >> +				size_t len, const char *name)
> >>  {
> >>  	struct f2fs_xattr_entry *entry;
> >> +	void *max_addr = base_addr + ENTRY_SIZE(XATTR_ENTRY(base_addr)) +
> >> +		base_addr_limit - 1;
> > 
> > If I'm not missing something, shouldn't it be?
> > 
> > void *max_addr = base_addr + max_size;
> > 
Hi Chao,
Let me show the buggy example of xattr entries.

Here is the buggy xattr entries.
The address 0x1201f24 - 0x1201fcb is correct content.
(Each entry occupies 4 + 9 + 10 + 1 bytes, 24 bytes)
Hacker append a faked entry at 0x1201fcc - 0x1201fe5
(entry length = 4 + 9 + 12 + 1 bytes)

01201f00  00 00 00 00 00 00 00 00  00 00 00 00 11 20 f5 f2  |............. ..|
01201f10  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
01201f20  00 00 00 00 01 09 0a 00  61 74 74 72 6e 61 6d 65  |........attrname|
01201f30  31 61 74 74 72 76 61 6c  75 65 31 00 01 09 0a 00  |1attrvalue1.....|
01201f40  61 74 74 72 6e 61 6d 65  32 61 74 74 72 76 61 6c  |attrname2attrval|
01201f50  75 65 31 00 01 09 0a 00  61 74 74 72 6e 61 6d 65  |ue1.....attrname|
01201f60  33 61 74 74 72 76 61 6c  75 65 31 00 01 09 0a 00  |3attrvalue1.....|
01201f70  61 74 74 72 6e 61 6d 65  34 61 74 74 72 76 61 6c  |attrname4attrval|
01201f80  75 65 31 00 01 09 0a 00  61 74 74 72 6e 61 6d 65  |ue1.....attrname|
01201f90  35 61 74 74 72 76 61 6c  75 65 31 00 01 09 0a 00  |5attrvalue1.....|
01201fa0  61 74 74 72 6e 61 6d 65  36 61 74 74 72 76 61 6c  |attrname6attrval|
01201fb0  75 65 31 00 01 09 0a 00  61 74 74 72 6e 61 6d 65  |ue1.....attrname|
01201fc0  37 61 74 74 72 76 61 6c  75 65 31 00 01 09 0c 00  |7attrvalue1.....|
01201fd0  61 74 74 72 6e 61 6d 65  38 61 74 74 72 76 61 6c  |attrname8attrval|
01201fe0  75 65 31 31 31 00 00 00  07 00 00 00 07 00 00 00  |ue111...........|

After lookup_all_xattrs() traveses all inline+xnid entries, the
base_addr becomes the starting pointer of the last xattr entry.

	if (last_addr)
		cur_addr = XATTR_HDR(last_addr) - 1;
	else
		cur_addr = txattr_addr;

For example,
before OOB error occurs, the lookup_all_xattrs() calls __find_xattr()
with base_addr = ffffffc05fe98228, max_size = 4 (= XATTR_PADDING_SIZE).

The entry size is 24 bytes = 0x18.
The expected design, the next entry of base_addr (ffffffc05fe98228 + 0x18),
ffffffc05fe98240, should be 4 bytes of zeros.

Because there are faked contents, the stop condition will not be
triggered and an OOB error happenes.

My aim is to block the lookup process by introducing boundary
check.

In this case, we should not access ffffffc05fe98244.
That's why I set the last address to ffffffc05fe98243.

> >>  
> >>  	list_for_each_xattr(entry, base_addr) {
> >> +		if ((void *)entry + sizeof(__u32) > max_addr)
> >> +			return NULL;
> >>  		if (entry->e_name_index != index)
> >>  			continue;
> >>  		if (entry->e_name_len != len)
> >> @@ -337,9 +342,9 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
> >>  	else
> >>  		cur_addr = txattr_addr;
> >>  
> >> -	*xe = __find_xattr(cur_addr, index, len, name);
> >> +	*xe = __find_xattr(cur_addr, XATTR_PADDING_SIZE, index, len, name);
> > 
> > max_size = *base_size - (txattr_addr - cur_addr);
> 
> max_size = *base_size - (cur_addr - txattr_addr);
> 
> > *xe = __find_xattr(cur_addr, max_size, index, len, name);
> > 
> >>  check:
> >> -	if (IS_XATTR_LAST_ENTRY(*xe)) {
> >> +	if (!*xe || IS_XATTR_LAST_ENTRY(*xe)) {
> > 
> > If xattr entry across boundary of max xattr space size, maybe we'd better return -EFAULT
> > which can be distinguished from a real -ENODATA error, latter, we can set SBI_NEED_FSCK
> > to give a repairing hint to fsck. :)
> > 
I will send v2 patch for review.
> >>  		err = -ENODATA;
> >>  		goto out;
> >>  	}
> >> @@ -606,9 +611,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
> >>  		return error;
> >>  
> >>  	/* find entry with wanted name. */
> >> -	here = __find_xattr(base_addr, index, len, name);
> >> +	here = __find_xattr(base_addr, inline_xattr_size(inode) +
> >> +			VALID_XATTR_BLOCK_SIZE + XATTR_PADDING_SIZE,
> >> +			index, len, name);
> > 
> > unsigned int size = F2FS_I(inode)->i_xattr_nid ? VALID_XATTR_BLOCK_SIZE : 0;
> > unsigned int max_size = inline_xattr_size(inode) + size + XATTR_PADDING_SIZE;
> > 
> > here = __find_xattr(..., max_size, ...);
> > 
> > if (!here)
> > 	return -EFAULT;
> > 
> > Thanks,
> > 
> >>  
> >> -	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
> >> +	if (!here)
> >> +		found = 0;
> >> +	else
> >> +		found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
> >>  
> >>  	if (found) {
> >>  		if ((flags & XATTR_CREATE)) {
> >>
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> > 
