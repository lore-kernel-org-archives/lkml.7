Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68093ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 22:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D7521882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571092835;
	bh=F+BvU2ynT3mQL45LYq/lwNf6fNbzXrmBPj+eP1A4W2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d7lbFizRqUTQgLwSr8GkpDkU0v6JsbJXtmShT1ivAEv1ybh/iRUSya8UXTQz0zLIu
	 atfbpiVqrw3KSoB19i0sH4tXibkcaXreVX9K9sBSbnYYCPpF85wpQtRg/1whcPNesf
	 Q8hLjsmjnMZNCTvdC2JHXk+PVTON6GY01llr9siA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfJNWkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 18:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfJNWkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 18:40:32 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A2221835;
        Mon, 14 Oct 2019 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571092830;
        bh=F+BvU2ynT3mQL45LYq/lwNf6fNbzXrmBPj+eP1A4W2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QpY6UwJMG2+5bzwrvASfxt8y8zxJ/F1VKC1nAtFH1wmDywJZUvo9iasZnlNdvdV7w
         S+IZUMEh35OE5VpJTmdOY4TawLghWweKIX/DD/5zwZr9rVhlU3HD9PODVzP+7XMwLn
         MSvAZNxUfOXraehJI6/nK5bwH0S86MqNa2iTvszs=
Date:   Mon, 14 Oct 2019 15:40:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+3370fc9fb190f98c5c72@syzkaller.appspotmail.com>
Cc:     chenjianhong2@huawei.com, jannh@google.com,
        khlebnikov@yandex-team.ru, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        mike.kravetz@oracle.com, richardw.yang@linux.intel.com,
        riel@surriel.com, sfr@canb.auug.org.au, steve.capper@arm.com,
        syzkaller-bugs@googlegroups.com, tiny.windzz@gmail.com,
        vbabka@suse.cz, walken@google.com, willy@infradead.org,
        yang.shi@linux.alibaba.com
Subject: Re: kernel BUG at include/linux/rmap.h:LINE!
Message-Id: <20191014154029.ab909c9bf08c78bbc2404f2d@linux-foundation.org>
In-Reply-To: <000000000000683a810594d634a2@google.com>
References: <000000000000683a810594d634a2@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2019 20:10:06 -0700 syzbot <syzbot+3370fc9fb190f98c5c72@syzk=
aller.appspotmail.com> wrote:

> syzbot found the following crash on:
>=20
> HEAD commit:    442630f6 Add linux-next specific files for 20191008
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11450d93600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daf1bfeef713ee=
fdd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3370fc9fb190f98=
c5c72
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13132d57600=
000
>=20
> The bug was bisected to:
>=20
> commit 480706f51e2c3a450d2f7fc10f5af215c9d249df
> Author: Wei Yang <richardw.yang@linux.intel.com>
> Date:   Mon Oct 7 20:25:37 2019 +0000
>=20
>      mm/rmap.c: reuse mergeable anon_vma as parent when forking

Hopefully the updated version addresses this?



From: Wei Yang <richardw.yang@linux.intel.com>
Subject: mm/rmap.c: reuse mergeable anon_vma as parent when fork

In __anon_vma_prepare(), we will try to find anon_vma if it is possible to
reuse it.  While on fork, the logic is different.

Since commit 5beb49305251 ("mm: change anon_vma linking to fix
multi-process server scalability issue"), function anon_vma_clone() tries
to allocate new anon_vma for child process.  But the logic here will
allocate a new anon_vma for each vma, even in parent this vma is mergeable
and share the same anon_vma with its sibling.  This may do better for
scalability issue, while it is not necessary to do so especially after
interval tree is used.

Commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma hierarchy")
tries to reuse some anon_vma by counting child anon_vma and attached vmas.
While for those mergeable anon_vmas, we can just reuse it and not
necessary to go through the logic.

After this change, kernel build test reduces 20% anon_vma allocation.

Do the same kernel build test, it shows run time in sys reduced 11.6%.

Origin:

real    2m50.467s
user    17m52.002s
sys     1m51.953s

real    2m48.662s
user    17m55.464s
sys     1m50.553s

real    2m51.143s
user    17m59.687s
sys     1m53.600s

Patched:

real	2m39.933s
user	17m1.835s
sys	1m38.802s

real	2m39.321s
user	17m1.634s
sys	1m39.206s

real	2m39.575s
user	17m1.420s
sys	1m38.845s

Link: http://lkml.kernel.org/r/20191011072256.16275-2-richardw.yang@linux.i=
ntel.com
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "J=E9r=F4me Glisse" <jglisse@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/rmap.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/mm/rmap.c~mm-rmapc-reuse-mergeable-anon_vma-as-parent-when-fork
+++ a/mm/rmap.c
@@ -268,6 +268,19 @@ int anon_vma_clone(struct vm_area_struct
 {
 	struct anon_vma_chain *avc, *pavc;
 	struct anon_vma *root =3D NULL;
+	struct vm_area_struct *prev =3D dst->vm_prev, *pprev =3D src->vm_prev;
+
+	/*
+	 * If parent share anon_vma with its vm_prev, keep this sharing in in
+	 * child.
+	 *
+	 * 1. Parent has vm_prev, which implies we have vm_prev.
+	 * 2. Parent and its vm_prev have the same anon_vma.
+	 */
+	if (!dst->anon_vma && src->anon_vma &&
+	    pprev && pprev->anon_vma =3D=3D src->anon_vma)
+		dst->anon_vma =3D prev->anon_vma;
+
=20
 	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma;
_

