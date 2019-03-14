Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB46C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C112D204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfCNIiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:38:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:50640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbfCNIiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:38:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18B52ADFF;
        Thu, 14 Mar 2019 08:37:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8DE041E3FE8; Thu, 14 Mar 2019 09:37:58 +0100 (CET)
Date:   Thu, 14 Mar 2019 09:37:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro
 'pr_warn_ratelimited'
Message-ID: <20190314083758.GA16658@quack2.suse.cz>
References: <201903140234.4FpTWdW3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903140234.4FpTWdW3%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICS this is the known problem with weird mips definitions of
__kernel_fsid_t which uses long whereas all other architectures use int,
right? Seeing that mips can actually have 8-byte longs, I guess this
bogosity is just wired in the kernel API and we cannot easily fix it in
mips (mips guys, correct me if I'm wrong). So what if we just
unconditionally typed printed values to unsigned int to silence the
warning?

								Honza

On Thu 14-03-19 02:31:52, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5453a3df2a5eb49bc24615d4cf0d66b2aae05e5f
> commit: e9e0c8903009477b630e37a8b6364b26a00720da fanotify: encode file identifier for FAN_REPORT_FID
> date:   5 weeks ago
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e9e0c8903009477b630e37a8b6364b26a00720da
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=mips 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:14:0,
>                     from include/linux/list.h:9,
>                     from include/linux/preempt.h:11,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/fdtable.h:11,
>                     from fs/notify/fanotify/fanotify.c:3:
>    fs/notify/fanotify/fanotify.c: In function 'fanotify_encode_fid':
>    include/linux/kern_levels.h:5:18: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat=]
>     #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                      ^
>    include/linux/printk.h:424:10: note: in definition of macro 'printk_ratelimited'
>       printk(fmt, ##__VA_ARGS__);    \
>              ^~~
>    include/linux/kern_levels.h:12:22: note: in expansion of macro 'KERN_SOH'
>     #define KERN_WARNING KERN_SOH "4" /* warning conditions */
>                          ^~~~~~~~
>    include/linux/printk.h:440:21: note: in expansion of macro 'KERN_WARNING'
>      printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>                         ^~~~~~~~~~~~
> >> fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro 'pr_warn_ratelimited'
>      pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
>      ^~~~~~~~~~~~~~~~~~~
>    fs/notify/fanotify/fanotify.c:198:61: note: format string is defined here
>      pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
>                                                                ~^
>                                                                %lx
>    In file included from include/linux/kernel.h:14:0,
>                     from include/linux/list.h:9,
>                     from include/linux/preempt.h:11,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/fdtable.h:11,
>                     from fs/notify/fanotify/fanotify.c:3:
>    include/linux/kern_levels.h:5:18: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long int' [-Wformat=]
>     #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                      ^
>    include/linux/printk.h:424:10: note: in definition of macro 'printk_ratelimited'
>       printk(fmt, ##__VA_ARGS__);    \
>              ^~~
>    include/linux/kern_levels.h:12:22: note: in expansion of macro 'KERN_SOH'
>     #define KERN_WARNING KERN_SOH "4" /* warning conditions */
>                          ^~~~~~~~
>    include/linux/printk.h:440:21: note: in expansion of macro 'KERN_WARNING'
>      printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>                         ^~~~~~~~~~~~
> >> fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro 'pr_warn_ratelimited'
>      pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
>      ^~~~~~~~~~~~~~~~~~~
>    fs/notify/fanotify/fanotify.c:198:64: note: format string is defined here
>      pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
>                                                                   ~^
>                                                                   %lx
> 
> vim +/pr_warn_ratelimited +198 fs/notify/fanotify/fanotify.c
> 
>    154	
>    155	static int fanotify_encode_fid(struct fanotify_event *event,
>    156				       const struct path *path, gfp_t gfp)
>    157	{
>    158		struct fanotify_fid *fid = &event->fid;
>    159		int dwords, bytes = 0;
>    160		struct kstatfs stat;
>    161		int err, type;
>    162	
>    163		stat.f_fsid.val[0] = stat.f_fsid.val[1] = 0;
>    164		fid->ext_fh = NULL;
>    165		dwords = 0;
>    166		err = -ENOENT;
>    167		type = exportfs_encode_inode_fh(d_inode(path->dentry), NULL, &dwords,
>    168						NULL);
>    169		if (!dwords)
>    170			goto out_err;
>    171	
>    172		err = vfs_statfs(path, &stat);
>    173		if (err)
>    174			goto out_err;
>    175	
>    176		bytes = dwords << 2;
>    177		if (bytes > FANOTIFY_INLINE_FH_LEN) {
>    178			/* Treat failure to allocate fh as failure to allocate event */
>    179			err = -ENOMEM;
>    180			fid->ext_fh = kmalloc(bytes, gfp);
>    181			if (!fid->ext_fh)
>    182				goto out_err;
>    183		}
>    184	
>    185		type = exportfs_encode_inode_fh(d_inode(path->dentry),
>    186						fanotify_fid_fh(fid, bytes), &dwords,
>    187						NULL);
>    188		err = -EINVAL;
>    189		if (!type || type == FILEID_INVALID || bytes != dwords << 2)
>    190			goto out_err;
>    191	
>    192		fid->fsid = stat.f_fsid;
>    193		event->fh_len = bytes;
>    194	
>    195		return type;
>    196	
>    197	out_err:
>  > 198		pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
>    199				    "type=%d, bytes=%d, err=%i)\n",
>    200				    stat.f_fsid.val[0], stat.f_fsid.val[1],
>    201				    type, bytes, err);
>    202		kfree(fid->ext_fh);
>    203		fid->ext_fh = NULL;
>    204		event->fh_len = 0;
>    205	
>    206		return FILEID_INVALID;
>    207	}
>    208	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
