Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE2FC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEF621D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYSP9Ere"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfKHJxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:53:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39594 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbfKHJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:53:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id a11so6287662wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 01:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bD5Fn3LbdHLtW6P7NmPGZyBXGmZSnfzZNFhZsK1WN44=;
        b=VYSP9ErePUf1fZPl2fba/NoBG6HT0c/TEOOghm1e708BJfxvweThIA6IXmqIh93ohm
         meQBbRVDnk2HICKb7IgI5de0aghls0v4jihkkFYXPgnz+EdX6Zu2hcM9S98C3b5M16qN
         WOH4ImgF3469jUkRTue49eAg1/gMIN+jJudUklK6xseemTt0QmbArcaQJmwlqvOHleNP
         ScUlj3TM8bHPT0KJkdZWVGTnVufHUVM9xMXeqlod0eIDHxWflMaj/C+XqP2L4xu+NsQE
         t+JPWIw5fWQJ93QkFCByJCDwpI2JIs8uL5vtOBEoMaXaeulNyQ2MaJnJR8REz0cQFtxS
         shTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bD5Fn3LbdHLtW6P7NmPGZyBXGmZSnfzZNFhZsK1WN44=;
        b=ml0+CPrt8MVuUDynetTIzSd1TxmZMV6gKRAzD2ii6gHYyh3V0L6ycn0muOqwTO6Kta
         bzaPbEd6Ibf/YYL8ozxRorbTWmQolJXDJ4CDgnoSobWMmgcNxa0j3f3C0HgM68OOgrPE
         iXtnGHaKV4Z6SlRM6QT5a5Ef7UcSRzFGWEOHutfqTs751wI0CbbREh7zDHBrT/HW7Fp1
         Fvkg0zJNXtV6cIbV6ErSC/xXbWFsjfT82x8BdvDWib35GUyph0Q4ldlLzJKkwRZ48lLI
         9oyRe9gqj7I6Uewz1CvSQrx/iAm4zABqMYswGFHtb/krUjdsNBlMKRHU+DPTehvGv8JY
         mdAA==
X-Gm-Message-State: APjAAAWfm/rsWiKZXtaexFDu1zBxQeyM2if6uf6o+YDB2akqr6enmjGe
        Xlv5C7/+GZWPYllCPRoNiQ0M7b5TS73ean1fZSE=
X-Google-Smtp-Source: APXvYqzr5LGLxlCBHsxSVIvntfRuYo9GZ5mB+/AEGG7H1x9L6yzHCoU0dK9ixojjv9ZHAb5GssOD5bpzctkISDIVwOU=
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr7061916wrj.168.1573206822653;
 Fri, 08 Nov 2019 01:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20191108082244.GA29418@shao2-debian>
In-Reply-To: <20191108082244.GA29418@shao2-debian>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 8 Nov 2019 17:53:31 +0800
Message-ID: <CACVXFVMGR175kksqB6ux+=xRuVokA2bXOLidoT0=-AmCEgbk2Q@mail.gmail.com>
Subject: Re: [block] fa53228721: WARNING:at_block/blk-merge.c:#blk_rq_map_sg
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 4:23 PM kernel test robot <lkp@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: fa53228721876515adabc7bc74368490bd97aa3b ("block: avoid blk_bio_segment_split for small I/O operations")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-5.5/block
>
> in testcase: xfstests
> with following parameters:
>
>         disk: 4HDD
>         fs: xfs
>         test: xfs-group16
>
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +---------------------------------------------+------------+------------+
> |                                             | d2c9be89f8 | fa53228721 |
> +---------------------------------------------+------------+------------+
> | boot_successes                              | 12         | 0          |
> | boot_failures                               | 0          | 16         |
> | WARNING:at_block/blk-merge.c:#blk_rq_map_sg | 0          | 16         |
> | RIP:blk_rq_map_sg                           | 0          | 16         |
> | kernel_BUG_at_drivers/scsi/scsi_lib.c       | 0          | 16         |
> | invalid_opcode:#[##]                        | 0          | 16         |
> | RIP:scsi_init_io                            | 0          | 16         |
> | Kernel_panic-not_syncing:Fatal_exception    | 0          | 16         |
> +---------------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> [  203.892883] WARNING: CPU: 0 PID: 443 at block/blk-merge.c:559 blk_rq_map_sg+0x649/0x700

If the bvec crosses page boundary, and meantime its length is
<=PAGE_SIZE, this issue may be triggered, given
some device has PAGE_SIZE segment boundary limit.

The following patch should fix this issue:

diff --git a/block/blk-merge.c b/block/blk-merge.c
index f22cb6251d06..367d3358de2a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -319,7 +319,8 @@ void __blk_queue_split(struct request_queue *q,
struct bio **bio,
                 */
                if (!q->limits.chunk_sectors &&
                    (*bio)->bi_vcnt == 1 &&
-                   (*bio)->bi_io_vec[0].bv_len <= PAGE_SIZE) {
+                   ((*bio)->bi_io_vec[0].bv_len +
+                    (*bio)->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
                        *nr_segs = 1;
                        break;
                }

However, in case of 64K PAGE_SIZE, I guess this way is still not safe enough.

thanks,
Ming
