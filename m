Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC726C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 07:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FAD20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 07:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUd4sYqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfLYHT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 02:19:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36727 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLYHT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 02:19:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id 19so16092825otz.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 23:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jZ7xOoyBKG3MRemDKdak1qOAx9GWCdCSPmNFPdoypUA=;
        b=FUd4sYqGJsr9wL9opWZuxqwRrff1m4+/rRzR8g3KKeD5OZi2cQAwSzfP1z8GPdjNYf
         j6TINdVgC9Vvx+xqKzsX76bNIOO6Z37RFCt/aG62qLL2U7HAVslziQYLnkMS7rdwIKoD
         O2NvAsMHdTU1VOusBwswqt5h4EKVqXdKjkIoMDFmljNhyHGvhTzf8qR1BASwboAAIdhJ
         s4c4XPQQvbglc+0qvUdfaJtANWbIYwBX5nLxCJxbezTWVQweaMlKbuezYnAEcdWZ/iv+
         vNPL8NBfhHg6NvuKmpVl5x2NQksoGHBWnk8mBhTjxuz8iWG3vRqzcEavGPTG1rVhPOM1
         1bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZ7xOoyBKG3MRemDKdak1qOAx9GWCdCSPmNFPdoypUA=;
        b=FryS8lzrxrwiu0uhDDtPWVsUN/xuk0s/hc+5ehjL1F0Jry6YPWSKp4TNUtxMB4GFx0
         ZfZI8MoulmM6Wi40nEYBxGtp5NPw7JmkuFNESH2+aJ5m51cPyNGFSqh3MbZEQwwI5gMk
         7svdWK29LhOtWyyLijky7fZNxxSPuc7JeGNVvG3+SXQbvulbTUgB1wg4eFrtBBMQibjn
         cPTHfiy89jRwmg0NE8vT/wB3FyYaLZxDryM12XcZ5pRj5BjKBBY6ZS9lHZbjWzsn5NTy
         aOOT8MiSgROHSDd2m2xHOt2it5mAaXYlYRsQeXtTQ+Ia/c1m9yhQqXTPcDMqCMa2vgiz
         2NEw==
X-Gm-Message-State: APjAAAVYR+r80Imu0idiUmZVTqgkDRFbfRkLuXInHAAY7EzajmD2Dgs2
        rFDu+q2FUZcbiWvkePvQZJn1BSWJ
X-Google-Smtp-Source: APXvYqxiUJRAMt9ZeCeCB0/zIbNTcvwZa+M9GdvJUxVsq568zi9IA1fQxV4VQ1+QoSPZmhs1ZT9WCg==
X-Received: by 2002:a05:6830:1487:: with SMTP id s7mr22470333otq.269.1577258395188;
        Tue, 24 Dec 2019 23:19:55 -0800 (PST)
Received: from JosephdeMacBook-Pro.local ([205.204.117.24])
        by smtp.gmail.com with ESMTPSA id c21sm5841878oiy.11.2019.12.24.23.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 23:19:54 -0800 (PST)
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: fix the crash due to call
 ocfs2_get_dlm_debug once less
To:     Gang He <GHe@suse.com>, "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
References: <20191225061501.13587-1-ghe@suse.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <07da3b5a-5884-8a95-6c39-1d84e9b5093b@gmail.com>
Date:   Wed, 25 Dec 2019 15:19:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191225061501.13587-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/25 14:15, Gang He wrote:
> Because ocfs2_get_dlm_debug() function is called once less here,
> ocfs2 file system will trigger the system crash, usually after
> ocfs2 file system is unmounted.
> this system crash is caused by a generic memory corruption, these
> crash backtraces are not always the same, for exapmle,
> 
> [ 4106.597432] ocfs2: Unmounting device (253,16) on (node 172167785)
> [ 4116.230719] general protection fault: 0000 [#1] SMP PTI
> [ 4116.230731] CPU: 3 PID: 14107 Comm: fence_legacy Kdump:
> [ 4116.230737] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> [ 4116.230772] RIP: 0010:__kmalloc+0xa5/0x2a0
> [ 4116.230778] Code: 00 00 4d 8b 07 65 4d 8b
> [ 4116.230785] RSP: 0018:ffffaa1fc094bbe8 EFLAGS: 00010286
> [ 4116.230790] RAX: 0000000000000000 RBX: d310a8800d7a3faf RCX: 0000000000000000
> [ 4116.230794] RDX: 0000000000000000 RSI: 0000000000000dc0 RDI: ffff96e68fc036c0
> [ 4116.230798] RBP: d310a8800d7a3faf R08: ffff96e6ffdb10a0 R09: 00000000752e7079
> [ 4116.230802] R10: 000000000001c513 R11: 0000000004091041 R12: 0000000000000dc0
> [ 4116.230806] R13: 0000000000000039 R14: ffff96e68fc036c0 R15: ffff96e68fc036c0
> [ 4116.230811] FS:  00007f699dfba540(0000) GS:ffff96e6ffd80000(0000) knlGS:00000
> [ 4116.230815] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4116.230819] CR2: 000055f3a9d9b768 CR3: 000000002cd1c000 CR4: 00000000000006e0
> [ 4116.230833] Call Trace:
> [ 4116.230898]  ? ext4_htree_store_dirent+0x35/0x100 [ext4]
> [ 4116.230924]  ext4_htree_store_dirent+0x35/0x100 [ext4]
> [ 4116.230957]  htree_dirblock_to_tree+0xea/0x290 [ext4]
> [ 4116.230989]  ext4_htree_fill_tree+0x1c1/0x2d0 [ext4]
> [ 4116.231027]  ext4_readdir+0x67c/0x9d0 [ext4]
> [ 4116.231040]  iterate_dir+0x8d/0x1a0
> [ 4116.231056]  __x64_sys_getdents+0xab/0x130
> [ 4116.231063]  ? iterate_dir+0x1a0/0x1a0
> [ 4116.231076]  ? do_syscall_64+0x60/0x1f0
> [ 4116.231080]  ? __ia32_sys_getdents+0x130/0x130
> [ 4116.231086]  do_syscall_64+0x60/0x1f0
> [ 4116.231151]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 4116.231168] RIP: 0033:0x7f699d33a9fb
> 
> This regression problem was introduced by commit e581595ea29c ("ocfs:
> no need to check return value of debugfs_create functions").
> 
> Signed-off-by: Gang He <ghe@suse.com>

Thanks, Gang.
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Add missing tags as well.

Fixes: e581595ea29c ("ocfs: no need to check return value of debugfs_create functions")
Cc: <stable@vger.kernel.org> v5.3+

> ---
>  fs/ocfs2/dlmglue.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index 1c4c51f3df60..cda1027d0819 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -3282,6 +3282,7 @@ static void ocfs2_dlm_init_debug(struct ocfs2_super *osb)
>  
>  	debugfs_create_u32("locking_filter", 0600, osb->osb_debug_root,
>  			   &dlm_debug->d_filter_secs);
> +	ocfs2_get_dlm_debug(dlm_debug);
>  }
>  
>  static void ocfs2_dlm_shutdown_debug(struct ocfs2_super *osb)
> 
