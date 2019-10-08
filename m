Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142C5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0343206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfJHJlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:41:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729624AbfJHJlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:41:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA86DB179;
        Tue,  8 Oct 2019 09:41:04 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: 'unable to handle page fault' in pstore
Date:   Tue, 08 Oct 2019 10:41:02 +0100
Message-ID: <87o8yrmv69.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Maybe this is a known issue with pstore, I didn't investigate, but it's
pretty easy to reproduce:

I've efi-pstore loaded, with a bunch of files in /sys/fs/pstore.  If I
unload my backend driver (efi-pstore) and try to remove a file from
/sys/fs/pstore I'll see the following spat:

BUG: unable to handle page fault for address: ffffffffc0bcf090
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 64a60c067 P4D 64a60c067 PUD 64a60e067 PMD 892200067 PTE 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 3154 Comm: mv Tainted: G            E     5.4.0-rc2 #19
Hardware name: Dell Inc. Precision 5510/0N8J4R, BIOS 1.10.0 02/25/2019
RIP: 0010:pstore_unlink+0x1e/0x70
Code: 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 41 54 49 89 fc 55 53 48 8b 46 30 48 8b 80 38 02 00 00 48 8b 58 10 48 8b 3b <48> 83 bf 90 00 00 00 00 74 39 48 83 c7 0c 81 42 00
RSP: 0018:ffffb2eb40587e70 EFLAGS: 00010246
RAX: ffff8920cea3e8a0 RBX: ffff8920cd55b400 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff8920cf76f300 RDI: ffffffffc0bcf000
RBP: ffff8920cf76f300 R08: ffff8920cf76f300 R09: 007a2e636e652e32
R10: 0000000000000007 R11: 7fffffffffffffff R12: ffff8920d4c91d80
R13: ffff8920d4c91d80 R14: ffff8920d80c3480 R15: ffff8920d80c3520
FS:  00007f3afe720640(0000) GS:ffff8920dda00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc0bcf090 CR3: 000000088e260001 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 vfs_unlink+0x10f/0x1f0
 do_unlinkat+0x1af/0x2f0
 do_syscall_64+0x4c/0x170
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f3afe8ef2f7
Code: 73 01 c3 48 8b 0d 89 db 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 64 89 01 48
RSP: 002b:00007ffd60fea168 EFLAGS: 00000202 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00005629c4e3ef70 RCX: 00007f3afe8ef2f7
RDX: 0000000000000000 RSI: 00005629c4e3dd40 RDI: 00000000ffffff9c
RBP: 00005629c4e3dcb0 R08: 0000000000000003 R09: 0000000000000000
R10: fffffffffffff24b R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffd60fea260 R14: 00005629c4e3ef70 R15: 0000000000000002

My understanding is that pstore_unlink() is exploding when running:

	if (!record->psi->erase)

because that address (psi) was on the efi-pstore module.

I'm not sure what's the best way to fix this, probably a

	if (psinfo && record->psi->erase)

would be enough, but ugly (and still racy?).

Cheers,
-- 
Luis
