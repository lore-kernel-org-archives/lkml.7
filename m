Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8F8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C1920679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440423AbfJYNnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:43:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56345 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfJYNna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:43:30 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iNzsH-00072g-Pn; Fri, 25 Oct 2019 07:43:29 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iNzsG-0006vL-SW; Fri, 25 Oct 2019 07:43:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191025112917.22518-1-mszeredi@redhat.com>
Date:   Fri, 25 Oct 2019 08:42:24 -0500
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com> (Miklos Szeredi's
        message of "Fri, 25 Oct 2019 13:29:12 +0200")
Message-ID: <87r231rlfj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iNzsG-0006vL-SW;;;mid=<87r231rlfj.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19PFgdLj+d0f0xnbf++PpDtbqlJ7o3tTO0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH 0/5] allow unprivileged overlay mounts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> Hi Eric,
>
> Can you please have a look at this patchset?
>
> The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
> whether I'm correct in stating that this isn't going to introduce any
> holes, or not...

I will take some time and dig through this.

From a robustness standpoint I worry about the stackable filesystem
side.  As that is uniquely an attack vector with overlayfs.

There is definitely demand for this.


> Thanks,
> Miklos
>
> ---
> Miklos Szeredi (5):
>   ovl: document permission model
>   ovl: ignore failure to copy up unknown xattrs
>   vfs: allow unprivileged whiteout creation
>   ovl: user xattr
>   ovl: unprivieged mounts
>
>  Documentation/filesystems/overlayfs.txt | 44 +++++++++++++
>  fs/char_dev.c                           |  3 +
>  fs/namei.c                              | 17 ++---
>  fs/overlayfs/copy_up.c                  | 34 +++++++---
>  fs/overlayfs/dir.c                      |  2 +-
>  fs/overlayfs/export.c                   |  2 +-
>  fs/overlayfs/inode.c                    | 39 ++++++------
>  fs/overlayfs/namei.c                    | 56 +++++++++--------
>  fs/overlayfs/overlayfs.h                | 81 +++++++++++++++---------
>  fs/overlayfs/ovl_entry.h                |  1 +
>  fs/overlayfs/readdir.c                  |  5 +-
>  fs/overlayfs/super.c                    | 53 +++++++++++-----
>  fs/overlayfs/util.c                     | 82 +++++++++++++++++++++----
>  include/linux/device_cgroup.h           |  3 +
>  14 files changed, 298 insertions(+), 124 deletions(-)

Eric
