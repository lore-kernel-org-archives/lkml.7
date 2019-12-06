Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A93C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A3F20706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLFN4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:56:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:42268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbfLFN4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:56:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C886FAB87;
        Fri,  6 Dec 2019 13:56:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23E53DA7AA; Fri,  6 Dec 2019 14:56:05 +0100 (CET)
Date:   Fri, 6 Dec 2019 14:56:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, ebiggers@kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
Message-ID: <20191206135604.GB2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Howells <dhowells@redhat.com>,
        torvalds@linux-foundation.org, ebiggers@kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 10:30:22PM +0000, David Howells wrote:
> David Howells (2):
>       pipe: Remove assertion from pipe_poll()
>       pipe: Fix missing mask update after pipe_wait()

For reference, I've retested current master (b0d4beaa5a4b7d), that
incldes the 2 pipe fixes, the test still hangs.

The stack now points to pipe_wait but otherwise seems to be the same:

[<0>] pipe_wait+0x72/0xc0
[<0>] pipe_write+0x217/0x4b0
[<0>] new_sync_write+0x11e/0x1c0
[<0>] vfs_write+0xc1/0x1d0
[<0>] kernel_write+0x2c/0x40
[<0>] send_cmd+0x78/0xf0 [btrfs]
[<0>] send_extent_data+0x4af/0x52a [btrfs]
[<0>] process_extent+0xe5d/0xeb4 [btrfs]
[<0>] changed_cb+0xcf5/0xd2f [btrfs]
[<0>] send_subvol+0x8af/0xc0d [btrfs]
[<0>] btrfs_ioctl_send+0xe2b/0xef0 [btrfs]
[<0>] _btrfs_ioctl_send+0x80/0x110 [btrfs]
[<0>] btrfs_ioctl+0x14b8/0x3120 [btrfs]
[<0>] do_vfs_ioctl+0xa1/0x750
[<0>] ksys_ioctl+0x70/0x80
[<0>] __x64_sys_ioctl+0x16/0x20
[<0>] do_syscall_64+0x56/0x240
[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe

(gdb) l *(pipe_wait+0x72)
0x622 is in pipe_wait (fs/pipe.c:120).
115              * is considered a noninteractive wait:
116              */
117             prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
118             pipe_unlock(pipe);
119             schedule();
120             finish_wait(&pipe->wait, &wait);
121             pipe_lock(pipe);
122     }
123
124     static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
