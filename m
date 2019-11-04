Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF62CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3566821744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJ9xHGZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfKDIEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:04:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45172 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfKDIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:04:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id x21so22579710qto.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 00:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qKWjuhmV5CtLiqPYXiJUq4pSZLtNys52jfI+2hBZhpg=;
        b=iJ9xHGZRyLojdolvvPMDtZ7nT2ozqaDicYSz+CaTAZwnMSGzYQjqif5j6lLcRRSGU9
         jy5fQv8elgNqlxv3Q3y+Uvf6CMOEUY+noJ3fkFOaHrAUb7jiYo3maJ5TEjLEnVVuzfiN
         Meoo4lsnxadxGSHSdsOmJvNjxx4CcQWNPw70RRFx6BfiDhVOI1vK0CfmtepHzrYG3ASY
         cl817+4gpnPk143BuFlSx59IwJHGUazG0/JMwLaGhT6Z02RZJLFzss9+nbUzrUSAlQX9
         R71TxdV4o1HPfMJ/Jbnf8MoqP3bxbO3GBWybbRjipnA2aNJ+ZudJR+R1pG8ornriaWhh
         U4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qKWjuhmV5CtLiqPYXiJUq4pSZLtNys52jfI+2hBZhpg=;
        b=WUMh0EfXbRR+CYY4dpxVpNzE7xm4auP+L0dPStiKBE9m2k+xJFA8qguAd2/UpqwbvE
         erXiH+nCZiar59RpKekRKA2Gg6058/erWMcBjdC6+6Hr+yPBcSzZn9PN/eq5U5Ibt106
         LqK7EnneJJeJ804I07AwQ+pyHF5Zysfql8JIvBmRErNTOGvQ0H9j8kPjoe82DhJhekZ1
         hdsRULDeOrC+F1Sr40wDwtJ/JcVCSa5SD1Wh7GRjBAWSjkMtPkvO+wsnR3emUdv3J5I7
         af8DxWwQZakDkfib3ngNxwF3eIDE/0G0tlhaNa/qZLJ9B7SI+dgZXxD5nCvoFLNXiRtg
         JHew==
X-Gm-Message-State: APjAAAU7DAnI/CkZ5oek+OpWnaAxGKSr4Za5CTDNj5P766BEIniWmOXG
        RIQBMmtOV3KH/y9DyN6jBgkgiGGk+uJWovP9DGytbg==
X-Google-Smtp-Source: APXvYqwH3wo+b8A/mhRZNU4MIDlhZEJUamFASAQsNEDcIodIPVEIXMjFfn4/WOT76LwkW9oUY+RM6BpwdquGWbp/l+s=
X-Received: by 2002:ac8:5514:: with SMTP id j20mr10856006qtq.257.1572854657224;
 Mon, 04 Nov 2019 00:04:17 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c50fd70595fdd5b2@google.com> <20191028201444.GA27425@cmpxchg.org>
 <70FEE01E-654E-4C4A-BF5C-B0A06A073A5C@fb.com>
In-Reply-To: <70FEE01E-654E-4C4A-BF5C-B0A06A073A5C@fb.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Nov 2019 09:04:05 +0100
Message-ID: <CACT4Y+Za=DuxCYEqG=AMsrcZ5v=B1dqsCD4bMGq03F9LKGdS0g@mail.gmail.com>
Subject: Re: INFO: task hung in mpage_prepare_extent_to_map
To:     Song Liu <songliubraving@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        syzbot <syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "hughd@google.com" <hughd@google.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:16 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Oct 28, 2019, at 1:14 PM, Johannes Weiner <hannes@cmpxchg.org> wrote=
:
> >
> > On Mon, Oct 28, 2019 at 12:52:09PM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    12d61c69 Add linux-next specific files for 20191024
> >> git tree:       linux-next
> >> console output: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_syzkaller.appspot.com_x_log.txt-3Fx-3D15a0fa97600000&d=3DDwIBAg&c=3D5VD0RT=
tNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaOe5=
RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3D6-TXLGQxJcK1GdwMwa51423Y221rRncNi=
C_T09O0OLc&e=3D
> >> kernel config:  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_syzkaller.appspot.com_x_.config-3Fx-3Dafb75fd8c9fd5ed8&d=3DDwIBAg&c=3D5VD0=
RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaO=
e5RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DGuFgLJZOb7jtjZ5mDbkVT_zqtiVW4Py=
13e6Oq5CFxgY&e=3D
> >> dashboard link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_syzkaller.appspot.com_bug-3Fextid-3Defb9e48b9fbdc49bb34a&d=3DDwIBAg&c=3D5V=
D0RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYE=
aOe5RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DpF1hv-zGR8F378weGq9zxCE5ibI2_=
73qweMB_KuaZLM&e=3D
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >> syz repro:      https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_syzkaller.appspot.com_x_repro.syz-3Fx-3D13a63dc4e00000&d=3DDwIBAg&c=3D5VD0=
RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaO=
e5RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DmI7ZOgrDWeG-p6vn2d_kj65a5g8J7ex=
XJ2MIUUF84-w&e=3D
> >>
> >> The bug was bisected to:
> >>
> >> commit 9c61acffe2b8833152041f7b6a02d1d0a17fd378
> >> Author: Song Liu <songliubraving@fb.com>
> >> Date:   Wed Oct 23 00:24:28 2019 +0000
> >>
> >>    mm,thp: recheck each page before collapsing file THP
> >>
> >> bisection log:  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_syzkaller.appspot.com_x_bisect.txt-3Fx-3D13eb6ec0e00000&d=3DDwIBAg&c=3D5VD=
0RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEa=
Oe5RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DYtSUy5Dtjo6tek7CvwzMTPL40BJwOC=
6rEom-AkVx0SM&e=3D
> >> final crash:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_syzkaller.appspot.com_x_report.txt-3Fx-3D101b6ec0e00000&d=3DDwIBAg&c=3D5VD=
0RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEa=
Oe5RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DBvPJx3QSPHgsN12jSZci_MqW_VxYp-=
MZpQtogZjlJOo&e=3D
> >> console output: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_syzkaller.appspot.com_x_log.txt-3Fx-3D17eb6ec0e00000&d=3DDwIBAg&c=3D5VD0RT=
tNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaOe5=
RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DYPvxWpQDpk9MI9W6QCtxME64wmxL2CZ5Z=
tEkCn0nI0c&e=3D
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the com=
mit:
> >> Reported-by: syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com
> >> Fixes: 9c61acffe2b8 ("mm,thp: recheck each page before collapsing file=
 THP")
> >>
> >> INFO: task khugepaged:1084 blocked for more than 143 seconds.
> >>      Not tainted 5.4.0-rc4-next-20191024 #0
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messa=
ge.
> >> khugepaged      D27568  1084      2 0x80004000
> >> Call Trace:
> >> context_switch kernel/sched/core.c:3384 [inline]
> >> __schedule+0x94a/0x1e70 kernel/sched/core.c:4069
> >> schedule+0xd9/0x260 kernel/sched/core.c:4136
> >> io_schedule+0x1c/0x70 kernel/sched/core.c:5780
> >> wait_on_page_bit_common mm/filemap.c:1175 [inline]
> >> __lock_page+0x422/0xab0 mm/filemap.c:1383
> >> lock_page include/linux/pagemap.h:480 [inline]
> >> mpage_prepare_extent_to_map+0xb3f/0xf90 fs/ext4/inode.c:2668
> >> ext4_writepages+0xb6a/0x2e70 fs/ext4/inode.c:2866
> >> ? 0xffffffff81000000
> >> do_writepages+0xfa/0x2a0 mm/page-writeback.c:2344
> >> __filemap_fdatawrite_range+0x2bc/0x3b0 mm/filemap.c:421
> >> __filemap_fdatawrite mm/filemap.c:429 [inline]
> >> filemap_flush+0x24/0x30 mm/filemap.c:456
> >
> > This is a double locking deadlock. The page lock is already held when
> > we call into filemap_flush() here, and does another lock_page() in
> > write_cache_pages().
> >
> > To fix it, we have to either initiate flushing before acquiring the
> > page lock, or simply skip over dirty pages.
> >
> > Maybe doing vfs_fsync_range() from the madvise(HUGEPAGE) call isn't a
> > bad idea after all? (I had discussed this with Song off-list before.)
>
> Thanks syzbot and Johannes!
>
> I just sent a quick fix, that just removes filemap_flush().
>
> I will work on a better mechanism to flush the file.

Is this expected to reach linux-next soon?
It's still not there and in the past days this crash happened 17K+
times and effectively stalled linux-next testing:
https://syzkaller.appspot.com/bug?id=3D4a3b0ba28ec7d0277338be02e1331068504d=
c228
