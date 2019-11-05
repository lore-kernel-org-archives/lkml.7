Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331F3C17475
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00ADA21D7C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ksXzQrj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbfKENXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:23:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:38771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388753AbfKENXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572960208;
        bh=EwZKdZFSw2rwIEYAHwRIzG3orTOanqEY+4cVZf2N3bI=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=ksXzQrj/0Y7mksbpRp0+OjyEDUfPKyLCXnK5CuDEXZEuMRnUM8Y5QrSIl+bcnhCk2
         eu+l5jbXUPw77Dp6s6SsnRzqLauN2zSf97gBhiIom0CnAf4vUTY97AMBuaJKHLfwsi
         LMTfCvW94YhSNAkjrLttEIrHqHJq36U0eHS5u8VI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1i95vp0yz7-00qCsf; Tue, 05
 Nov 2019 14:23:28 +0100
Message-ID: <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Tue, 05 Nov 2019 14:23:25 +0100
In-Reply-To: <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
References: <20191025092143.GE658@dhcp22.suse.cz>
         <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
         <20191025114633.GE17610@dhcp22.suse.cz>
         <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
         <20191025120505.GG17610@dhcp22.suse.cz>
         <20191025121104.GH17610@dhcp22.suse.cz>
         <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
         <20191025132700.GJ17610@dhcp22.suse.cz>
         <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
         <20191025135749.GK17610@dhcp22.suse.cz>
         <20191025140029.GL17610@dhcp22.suse.cz>
         <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qw9oJg/pfwNRhkyyxOwWOWcW0JCHKYja1exTdXo7q5cq+aB8Je/
 ZbiuRtFBL+QnnQcvLSpvciVUe9I06Rwntc+u6Y5Pg3UbfOyu7J65/2fE8nNQtYVOk3C/BlY
 Uf43jIKVtksdlECCrH8edAzySIO3K65buzteFYoXgXbxcqMzwwNUEorFJs4etHmedKaKkI7
 NufHyvDBRmNMdA7q3TfLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HXG+rtE+Jfk=:p/4fObcRhW4etwgqE9qcGH
 YKYONVvlerr7MOWi+k7S5Poc1KJD3/U40paeo20TtlQ9oV6U1TuXeDGV1kUqmb4Res3/YFMXn
 qmQVbvtF/qF5E9y+k2ZZRKURir+Z8RYL6XV7QP3ON+YQKrtcPFtNltUaVDBx4RrM1DODKqCoF
 QgiI4gIgehDfvcDRpajO3ep7yM9PRvC1jtRSSpXwbz94+kZA55Fgyr/sCsyw9gbHBe+/0+WkW
 a48TgZ414sFk96Lb6IoJ+LtPVuK6TpXakZBzUmCURLt/r0pKyvFafluFqgSvMNsXTTeZhlXMK
 ffhURCcxcdTnRP86o9cM1oOg+y8rF6PeY+gxCERvItocSoPn6oY/UWAcq0Pbva7mEgVyaXHTg
 +5PU+PDIlqJlWK9SDXnXuOWdgiGarSO7RlEb6oqBxQQJ9d/u6pqWRpQV0zOfd4Q8IB3RFZM2I
 H6LhQR9xsPC+S/40ngAnrYkl6vDaoQvtqDKKbxEJichD7M2IN/3FpKKQNuG1J66UQn2ZlT+eW
 6vcI/DDkx8is8NLS26CEhbFQcTLdjh0tAUBhLuPrPxLH3YBX2cT1RDoCTnzcM7cCTVdPxJliq
 4gyJ09yuGYCfdSEY72g25vybs62MUci0E/s/AzYNrZ+U3z0h/2zhKxD3pGILZs9/6CBo7XJVp
 AYVaTnh0S9t0N3tofOvjDkgpfbtB3HAfKuwd7Cq8ffl3ERTFfe85Ni/HcrtRGfRLvi0VGKNCs
 6jfBBumWeKHnSajgIu3ZSLFAJVX3ThgzoLArKUNVaC1H/Lj77WTFkQXtUTf/pxygjfHwimFPI
 mklKvQq4iDoOTAnQyavXa1vCgKGE0T+/1E5dsawmTKuI5S9nC4c/9HzLhr821r4KvbkMDNhjZ
 50Of/AXN2nF2ULWuehGfGLotTdTdgYxuY1R910UxEVUzyOVl9o7GtTAFXTmqh1uQfcuRIY2eG
 OFe9k5KiHyeYrgZQ4EjSnpKa2PszYDn8FgX8gJARj6fJWu2bMtCtK+YLqojcQHRv6Dwmuwj4m
 u8+mEmdhyw4CSWYon/PEQmVxDaHuljS9cD13iF2SDYKbX2gYx3HAwrbYai5covQQPTNq+b4Cr
 h+YPQhoxhCNMM2dWfc9HoiQmcl/OZd7H2y5UmJbajsy5pYK53Cbvjnv3ueI3tzjpeE9rytl32
 tvPUhC6/oTYjL9YrDclIO1bMiEGLB9ipzVgXVK9UhK2qHy3wMq4OwGJpbE0TvZsQMXnzXJUVa
 37XpQQnW8Lo+xSvPCxllgyquxapXpZsO6aAND6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"git bisect" led to a result.

The offending merge commit is f91f2ee54a21404fbc633550e99d69d14c2478f2
"Merge branch 'akpm' (rest of patches from Andrew)".

The first bad commit in the merged series of commits is
https://github.com/torvalds/linux/commit/6b4c9f4469819a0c1a38a0a4541337e0f=
9bf6c11
. a75d4c33377277b6034dd1e2663bce444f952c14, the commit before 6b4c9f44,
is good.

I've also verified 5.1.21 and 5.3.8 (from
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/)
without 6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11 and both builds are
good.
(The 5.1.21 and 5.3.7 builds from Ubuntu were bad, so I haven't cross-
checked "vanilla" 5.1.21 and 5.3.8 kernel builds.)



Recap symptoms:
- `mlockall(MCL_CURRENT)` hangs
- shutdown/reboot hangs when it reaches "shutdown->reboot"
- `cat /proc/$(pidof test)/smaps` shows "Locked" w/ odd values, which
are equal to "Pss"

Affected:
- `cryptsetup luksOpen` hangs (when it tries to lock memory)
- Apache Cassandra hangs during startup (when it performs an
`mlockall(MCL_CURRENT)`)



git checkout v5.1.21
# revert the "comment-only" commit (no need to test this one)
# "filemap: add a comment about FAULT_FLAG_RETRY_NOWAIT behavior"
git revert 8b0f9fa2e02dc95216577c3387b0707c5f60fbaf
# "filemap: drop the mmap_sem for all blocking operations"
git revert 6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11
=2D-> GOOD

git checkout v5.3.8
# revert the "comment-only" commit (no need to test this one)
# "filemap: add a comment about FAULT_FLAG_RETRY_NOWAIT behavior"
git revert 8b0f9fa2e02dc95216577c3387b0707c5f60fbaf
# "filemap: drop the mmap_sem for all blocking operations"
git revert 6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11
=2D-> GOOD



Bisect log:
git bisect start
# bad: [9e98c678c2d6ae3a17cb2de55d17f69dddaa231b] Linux 5.1-rc1
git bisect bad 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
# good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
git bisect good 1c163f4c7b3f621efff9b28a47abb36f7378d783
# good: [e266ca36da7de45b64b05698e98e04b578a88888] Merge tag 'staging-
5.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good e266ca36da7de45b64b05698e98e04b578a88888
# good: [36011ddc78395b59a8a418c37f20bcc18828f1ef] Merge tag 'gfs2-
5.1.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-
gfs2
git bisect good 36011ddc78395b59a8a418c37f20bcc18828f1ef
# good: [6bc3fe8e7e172d5584e529a04cf9eec946428768] tools: mark
'test_vmalloc.sh' executable
git bisect good 6bc3fe8e7e172d5584e529a04cf9eec946428768
# good: [dc2535be1fd547fbd56aff091370280007b0a1af] Merge tag 'clk-for-
linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good dc2535be1fd547fbd56aff091370280007b0a1af
# bad: [2b9c272cf5cd81708e51b4ce3e432ce9566cfa47] Merge tag 'fbdev-
v5.1' of git://github.com/bzolnier/linux
git bisect bad 2b9c272cf5cd81708e51b4ce3e432ce9566cfa47
# good: [9bc446100334dbbc14eb3757274ef08746c3f9bd] Merge tag
'microblaze-v5.1-rc1' of git://git.monstr.eu/linux-2.6-microblaze
git bisect good 9bc446100334dbbc14eb3757274ef08746c3f9bd
# bad: [5160bcce5c3c80de7d8722511c144d3041409657] Merge tag 'f2fs-for-
5.1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
git bisect bad 5160bcce5c3c80de7d8722511c144d3041409657
# good: [240a59156d9bcfabceddb66be449e7b32fb5dc4a] f2fs: fix to add
refcount once page is tagged PG_private
git bisect good 240a59156d9bcfabceddb66be449e7b32fb5dc4a
# good: [9352ca585b2ac7b67d2119b9386573b2a4c0ef4b] Merge tag 'pm-5.1-
rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 9352ca585b2ac7b67d2119b9386573b2a4c0ef4b
# good: [f261c4e529dac5608a604d3dd3ae1cd2adf23c89] Merge branch 'akpm'
(patches from Andrew)
git bisect good f261c4e529dac5608a604d3dd3ae1cd2adf23c89
# good: [aadcef64b22f668c1a107b86d3521d9cac915c24] f2fs: fix to avoid
deadlock in f2fs_read_inline_dir()
git bisect good aadcef64b22f668c1a107b86d3521d9cac915c24
# bad: [8b0f9fa2e02dc95216577c3387b0707c5f60fbaf] filemap: add a
comment about FAULT_FLAG_RETRY_NOWAIT behavior
git bisect bad 8b0f9fa2e02dc95216577c3387b0707c5f60fbaf
# bad: [6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11] filemap: drop the
mmap_sem for all blocking operations
git bisect bad 6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11
# bad: [a75d4c33377277b6034dd1e2663bce444f952c14] filemap: kill
page_cache_read usage in filemap_fault
git bisect good a75d4c33377277b6034dd1e2663bce444f952c14


All kernels built with
make oldconfig # accept the defaults
make bindeb-pkg



On Fri, 2019-10-25 at 17:58 +0200, Robert Stupp wrote:
> On Fri, 2019-10-25 at 16:00 +0200, Michal Hocko wrote:
> > And one more thing. Considering that you are able to reproduce and
> > you
> > have a working kernel, could you try to bisect this?
>
> Yikes - running self-built kernels brings back a lot of memories ;)
>
> Anyway, going this route (using the `config` from Ubuntu 5.1.x as a
> base and accepting the defaults for `make oldconfig`):
>
> git checkout v5.1-rc1
> git bisect start
> git bisect bad
> git bisect good v5.0
>
> ... first try @ e266ca36da7de45b64b05698e98e04b578a88888 is a `git
> bisect good`
>
> Will report back, when I've got a result...
>

