Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6182FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33569222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKMB2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:28:43 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33735 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbfKMB2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:28:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Thwrhsx_1573608519;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Thwrhsx_1573608519)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 09:28:40 +0800
Subject: Re: ocfs2: xattr problems with 5.4.0-rc7
To:     Thomas Voegtle <tv@lio96.de>, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     linux-kernel@vger.kernel.org
References: <alpine.LSU.2.21.1911121355550.7620@er-systems.de>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <fc2993e9-f0d6-fb7c-5050-8dbb36338140@linux.alibaba.com>
Date:   Wed, 13 Nov 2019 09:28:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1911121355550.7620@er-systems.de>
Content-Type: text/plain; charset=iso-8859-7
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,
Thanks for reporting this issue.
I have some doubts on it, please see my comments below.

On 19/11/12 22:45, Thomas Voegtle wrote:
> 
> Hello,
> 
> with 5.4.0-rc7 and 4.9.200 we see the following errors with mkdir or touch on a ocfs2 mountpoint:
> 
> root@s2:/shared/ClusterShareDisk# mkdir dir
> mkdir: cannot create directory ¡dir¢: Invalid argument
> 
> which produces this output:
> 
> root@s2:/shared/ClusterShareDisk# dmesg
> [ 6918.815770] (mkdir,19461,0):ocfs2_xa_set:2242 ERROR: status = -22
> [ 6918.815772] (mkdir,19461,0):ocfs2_mknod:408 ERROR: status = -22
> [ 6918.816215] (mkdir,19461,0):ocfs2_mknod:486 ERROR: status = -22
> [ 6918.816216] (mkdir,19461,0):ocfs2_mkdir:652 ERROR: status = -22
> 
ocfs2_xa_set
  ocfs2_xa_prepare_entry

Since ocfs2_xa_set() returns -EINVAL, it means loc->xl_entry is NULL.

	if (!loc->xl_entry) {
		rc = -EINVAL;
		goto out;
	}

After reverting
commit 56e94ea132bb "fs: ocfs2: fix possible null-pointer dereferences in ocfs2_xa_prepare_entry()",
it will call ocfs2_xa_add_entry(),

	if (loc->xl_entry) {
		...
	} else
		ocfs2_xa_add_entry(loc, name_hash);

Theoretically it will cause NULL pointer dereference when access attributes of loc->xl_entry.
So could you please check if the issue is caused by NULL loc->xl_entry?

Thanks,
Joseph

> We got some ACLs:
> $ getfacl /shared/ClusterShareDisk/
> getfacl: Removing leading '/' from absolute path names
> # file: shared/ClusterShareDisk/
> # owner: root
> # group: root
> user::rwx
> user:admin:rwx
> group::rwx
> mask::rwx
> other::---
> default:user::rwx
> default:user:admin:rwx
> default:group::rwx
> default:mask::rwx
> default:other::---
> 
> And of course it is mounted with user_xattr and acl option.
> 
> Reverting
> commit 56e94ea132bb5c2c1d0b60a6aeb34dcb7d71a53d
> Author: Jia-Ju Bai <baijiaju1990@gmail.com>
> Date:   Sun Oct 6 17:57:50 2019 -0700
> 
>     fs: ocfs2: fix possible null-pointer dereferences in
> ocfs2_xa_prepare_entry()
> 
> fixes the problem.
> 
> Greetings,
> 
> 
>     Thomas
