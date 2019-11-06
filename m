Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35017C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E804F20659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MN/xACSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfKFL1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:27:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34377 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfKFL1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:27:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id t4so9052449otr.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 03:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JmWHGiCmHik0bRutiL/J60TO0MUrEAsQe6zmpejxyg=;
        b=MN/xACSJDARaLE5hHrxoFqd3pYq6lJdA5QWv/LhRM1rr/Q6ILQZ/YA7E1j1l5Fx9l4
         FezSuKeha5eEVmQovrziT9Wq7YnpLwLaqupGvS+YOjuzKtTy1XqeuWpHbgOYXDKzuYfi
         /ESdesMn2sjoKcqNGrVhKpc3VIt6imrLZslKxyMUYx9w1JFPbhMXlsjYzZYZL/xDXEkI
         zIc4xsnnWQuy8/7Oky81kLcYsQ7fGWBOXRftqX050DIbLfxJuq9lFzds5u+2EwwyLLSj
         2Paol/V2iEEcmqJiNzZSnBaBMtILK0MWMpqEfdWhDAfWtCYtPtvhrf0O23fFn0+wB9zY
         oU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JmWHGiCmHik0bRutiL/J60TO0MUrEAsQe6zmpejxyg=;
        b=uc6dC8EiWsMNeCpgBk4hBZ4CuAX45jijZRT1qzfM07r8d6oaHqIUq+O5yOGK8KVvD+
         JwsBgDUrrgU9EYKNECw/4ES7pUkUO4a7KUNDAD0PQFqA+1Z4HJ0kuMjnYel/0CdM1OQL
         FUhpmDf44B6Ku5eTWvGq9MKgNES22jdXXowL+zt10PvI5tT8K3+8wcTUVpZs5xpvRhJo
         QPJydf6JYZ27wmITF0fn7yZ+6aQCriP/efSHJalLbjJ2weV/3Pt+p4tIUbfvhwD+968p
         dInL9dbEoCKdnQf3nUxIoLDG18iGaoQ2YziYcUeF5MkrhuVugbKahfdtO23hZaz3WKhc
         3eEQ==
X-Gm-Message-State: APjAAAU+Jy201uXExFQqcC1F+GrvbCNxtA/3QeVNveGBrOw9edtU9Uw0
        cFv/c32He9xEWzfTyBTEGBrXUNK0Ak1rNguR/pVXrbcnI1tFPg==
X-Google-Smtp-Source: APXvYqzYb9aiJDV4yeJ6dOls544ljbaKFY7orYq7+GUaPE/GQtzh41/P9lGGJY5hVYIeMQSSgwBbzmVPmOp8NaulgkE=
X-Received: by 2002:a05:6830:2308:: with SMTP id u8mr1424241ote.2.1573039622424;
 Wed, 06 Nov 2019 03:27:02 -0800 (PST)
MIME-Version: 1.0
References: <00000000000016a19d0596980568@google.com> <20191105143923.GA87727@google.com>
 <20191105152528.GD11823@bombadil.infradead.org> <87k18d8kz7.fsf@mail.parknet.co.jp>
In-Reply-To: <87k18d8kz7.fsf@mail.parknet.co.jp>
From:   Marco Elver <elver@google.com>
Date:   Wed, 6 Nov 2019 12:26:51 +0100
Message-ID: <CANpmjNPePTMWTyyx4iQbNGCEqihz4F4R+cpgPOwj=YxzJ05dCA@mail.gmail.com>
Subject: Re: KCSAN: data-race in fat16_ent_put / fat_search_long
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+11010f0000e50c63c2cc@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019 at 09:31, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Matthew Wilcox <willy@infradead.org> writes:
>
> > On Tue, Nov 05, 2019 at 03:39:23PM +0100, Marco Elver wrote:
> >> On Tue, 05 Nov 2019, syzbot wrote:
> >> > ==================================================================
> >> > BUG: KCSAN: data-race in fat16_ent_put / fat_search_long
> >> >
> >> > write to 0xffff8880a209c96a of 2 bytes by task 11985 on cpu 0:
> >> >  fat16_ent_put+0x5b/0x90 fs/fat/fatent.c:181
> >> >  fat_ent_write+0x6d/0xf0 fs/fat/fatent.c:415
> >> >  fat_chain_add+0x34e/0x400 fs/fat/misc.c:130
> >> >  fat_add_cluster+0x92/0xd0 fs/fat/inode.c:112
> >> >  __fat_get_block fs/fat/inode.c:154 [inline]
> >> >  fat_get_block+0x3ae/0x4e0 fs/fat/inode.c:189
> >> >  __block_write_begin_int+0x2ea/0xf20 fs/buffer.c:1968
> >> >  __block_write_begin fs/buffer.c:2018 [inline]
> >> >  block_write_begin+0x77/0x160 fs/buffer.c:2077
> >> >  cont_write_begin+0x3d6/0x670 fs/buffer.c:2426
> >> >  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
> >> >  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
> >> >  cont_expand_zero fs/buffer.c:2353 [inline]
> >> >  cont_write_begin+0x17a/0x670 fs/buffer.c:2416
> >> >  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
> >> >  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
> >> >  generic_cont_expand_simple+0xb0/0x120 fs/buffer.c:2317
> >> >
> >> > read to 0xffff8880a209c96b of 1 bytes by task 11990 on cpu 1:
> >> >  fat_search_long+0x20a/0xc60 fs/fat/dir.c:484
> >> >  vfat_find+0xc1/0xd0 fs/fat/namei_vfat.c:698
> >> >  vfat_lookup+0x75/0x350 fs/fat/namei_vfat.c:712
> >> >  lookup_open fs/namei.c:3203 [inline]
> >> >  do_last fs/namei.c:3314 [inline]
> >> >  path_openat+0x15b6/0x36e0 fs/namei.c:3525
> >> >  do_filp_open+0x11e/0x1b0 fs/namei.c:3555
> >> >  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
> >> >  __do_sys_open fs/open.c:1115 [inline]
> >> >  __se_sys_open fs/open.c:1110 [inline]
> >> >  __x64_sys_open+0x55/0x70 fs/open.c:1110
> >> >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
> >> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> >
> >> > Reported by Kernel Concurrency Sanitizer on:
> >> > CPU: 1 PID: 11990 Comm: syz-executor.2 Not tainted 5.4.0-rc3+ #0
> >> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> > Google 01/01/2011
> >> > ==================================================================
> >>
> >> I was trying to understand what is happening here, but fail to see how
> >> this can happen. So it'd be good if somebody who knows this code can
> >> explain. We are quite positive this is not a false positive, given the
> >> addresses accessed match.
> >
> > Both of these accesses are into a buffer head; ie the data being accessed
> > is stored in the page cache.  Is it possible the page was reused for
> > different data between these two accesses?
>
> No and yes. Reader side is directory buffer, writer side is FAT buffer.
> So FAT buffer never be reused as directory buffer.  But the page cache
> itself can be freed and reused as different index. So if KCSAN can't
> detect the page cache recycle, it would be possible.
>
> Is there anyway to know "why KCSAN thought this as data race"?

KCSAN set up a watchpoint on the plain read, simply stalling that
thread for a few microsec. While stalling, a concurrent plain write
occurred which matches the watchpoint the reader set up. Whenever
KCSAN detects a data race, the 2 operations *must* actually be
happening in parallel at the time.

I will try to reproduce this somehow.

> >> The two bits of code in question here are:
> >>
> >> static void fat16_ent_put(struct fat_entry *fatent, int new)
> >> {
> >>      if (new == FAT_ENT_EOF)
> >>              new = EOF_FAT16;
> >>
> >>      *fatent->u.ent16_p = cpu_to_le16(new);   <<== data race here
> >>      mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
> >> }
>
> This is updating FAT entry (index for data cluster placement) on FAT buffer.
>
> >> int fat_search_long(struct inode *inode, const unsigned char *name,
> >>                  int name_len, struct fat_slot_info *sinfo)
> >> {
> >>      struct super_block *sb = inode->i_sb;
> >>      struct msdos_sb_info *sbi = MSDOS_SB(sb);
> >>      struct buffer_head *bh = NULL;
> >>      struct msdos_dir_entry *de;
> >>      unsigned char nr_slots;
> >>      wchar_t *unicode = NULL;
> >>      unsigned char bufname[FAT_MAX_SHORT_SIZE];
> >>      loff_t cpos = 0;
> >>      int err, len;
> >>
> >>      err = -ENOENT;
> >>      while (1) {
> >>              if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> >>                      goto end_of_dir;
> >> parse_record:
> >>              nr_slots = 0;
> >>              if (de->name[0] == DELETED_FLAG)
> >>                      continue;
> >>              if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))  <<== data race here
>
> Checking attribute on directory buffer.
>
> >>                      continue;
> >>              if (de->attr != ATTR_EXT && IS_FREE(de->name))
> >>                      continue;
> >>              <snip>
> >> }
> >>
> >> Thanks,
> >> -- Marco
>
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
