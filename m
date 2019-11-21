Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8085C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 04:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863FA208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 04:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEnETyFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKUEw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 23:52:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46423 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUEw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 23:52:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id 193so995104pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 20:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DPhrRDQXf9hFB+HztG+mgBespKdUm4LVhTNTzLmxV28=;
        b=GEnETyFfr1rgjrGzUYrjjtSDWT5jmD2cFe8tXi2kjolDmAWtWUV7Nb6h8shOeLMKWb
         pnJb/OxkmgTKL0yWW04sBMboawKmgpFpz6G+s1lwqhkE4rnOLxeq4EGiL+o64BG0aiSQ
         FjtPVYjlNr5iT/de4O7zyhz62jIkjJ0OFJQYqQVmCGq9FG6fd9xDUe+4yY56aHF5Nlz1
         dEasueqVlDx7JuVtSajZ/pOkryZSUuhqXTFaKJHXZonc/5JVJqeN9ze5NZUIRmVyHwCF
         XY3cBIk9NyWyZ4h1S2X4o2OqCVs5dPg+5jjnv6KLZv+kD+PumAbhxb4HOzeVsb4DmMGH
         4YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DPhrRDQXf9hFB+HztG+mgBespKdUm4LVhTNTzLmxV28=;
        b=GTnAqsMOuLeeftrzMJ4DIIJ3J8cKvaEtGAMXNMeF6FI8YNAF9AB8Z7mIpVc/whXLS4
         z0V+f4tJzkiGAEtRwymnub/ncwWhsS8OAfkH2SMte1iDHqPZftXoPg6odddfgPW2sRRp
         dJY4TVe6ohye+xppkje9zIgrCX9jDGkwCROeY3YuKbpedBiWD42qs7MKZJbEhLTRRPD3
         pgqOZIfgRuX1HKdpRIqCN14am6HOtYqonWE16SbQL2+/2LzNJ2ceAawbxfhAZUI8GqUu
         t+Pu4vuzi0fxaEbj/d+XosZjL8q0uqIuN483EwKlICdR+u3T21tpGXjI9A0uMf7zHSn9
         YobA==
X-Gm-Message-State: APjAAAW5u7JLDOf2MTaFf1kMYO9U3Qy/YFoZjTKEL1hl9kbBj6vhHkA4
        YgbR10KSZ5QmOWz7bL+Nibecobi4U5I=
X-Google-Smtp-Source: APXvYqyjrD9/Y8ex4VJ8V4aGF9dbDUZ2Mv5u3F3CwaJoUFQOlgICUTBA7wVfoR74Pzf1+d1UKwiwWQ==
X-Received: by 2002:a63:540f:: with SMTP id i15mr6827168pgb.405.1574311976872;
        Wed, 20 Nov 2019 20:52:56 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id k103sm938720pje.16.2019.11.20.20.52.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 20:52:56 -0800 (PST)
Date:   Wed, 20 Nov 2019 20:52:36 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "zhengbin (A)" <zhengbin13@huawei.com>
cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com,
        "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH] tmpfs: use ida to get inode number
In-Reply-To: <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com>
Message-ID: <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com> <20191120154552.GS20752@bombadil.infradead.org> <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1026342302-1574311976=:1825"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1026342302-1574311976=:1825
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Nov 2019, zhengbin (A) wrote:
> On 2019/11/20 23:45, Matthew Wilcox wrote:
> > On Wed, Nov 20, 2019 at 10:23:18PM +0800, zhengbin wrote:
> >> I have tried to change last_ino type to unsigned long, while this was
> >> rejected, see details on https://patchwork.kernel.org/patch/11023915.
> > Did you end up trying sbitmap?
>=20
> Maybe sbitmap is not a good solution, max_inodes of tmpfs are controlled =
by mount options--nrinodes,
>=20
> which can be modified by remountfs(bigger or smaller), as the comment of =
function sbitmap_resize says:
>=20
> =C2=A0* Doesn't reallocate anything. It's up to the caller to ensure that=
 the new
> =C2=A0* depth doesn't exceed the depth that the sb was initialized with.
>=20
> We can modify this to meet the growing requirements, there will still be =
questions as follows:
>=20
> 1. tmpfs is a ram filesystem, we need to allocate sbitmap memory for sbin=
fo->max_inodes(while this maybe huge)
>=20
> 2.If remountfs changes=C2=A0 max_inode, we have to deal with it, while th=
is may take a long time
>=20
> (bigger: we need to free the old sbitmap memory, allocate new memory, cop=
y the old sbitmap to new sbitmap
>=20
> smaller: How do we deal with it?ie: we use sb->map[inode number/8] to fin=
d the sbitmap, we need to change the exist
>=20
> inode numbers?while this maybe used by userspace application.)
>=20
> >
> > What I think is fundamentally wrong with this patch is that you've foun=
d a
> > problem in get_next_ino() and decided to use a different scheme for thi=
s
> > one filesystem, leaving every other filesystem which uses get_next_ino(=
)
> > facing the same problem.
> >
> > That could be acceptable if you explained why tmpfs is fundamentally
> > different from all the other filesystems that use get_next_ino(), but
> > you haven't (and I don't think there is such a difference.  eg pipes,
> > autofs and ipc mqueue could all have the same problem.
>=20
> tmpfs is same with all the other filesystems that use get_next_ino(), but=
 we need to solve this problem one by one.
>=20
> If tmpfs is ok, we can modify the other filesystems too. Besides, I do no=
t=C2=A0 recommend all file systems share the same
>=20
> global variable, for performance impact consideration.
>=20
> >
> > There are some other problems I noticed, but they're not worth bringing
> > up until this fundamental design choice is justified.
> Agree, thanks.

Just a rushed FYI without looking at your patch or comments.

Internally (in Google) we do rely on good tmpfs inode numbers more
than on those of other get_next_ino() filesystems, and carry a patch
to mm/shmem.c for it to use 64-bit inode numbers (and separate inode
number space for each superblock) - essentially,

=09ino =3D sbinfo->next_ino++;
=09/* Avoid 0 in the low 32 bits: might appear deleted */
=09if (unlikely((unsigned int)ino =3D=3D 0))
=09=09ino =3D sbinfo->next_ino++;

Which I think would be faster, and need less memory, than IDA.
But whether that is of general interest, or of interest to you,
depends upon how prevalent 32-bit executables built without
__FILE_OFFSET_BITS=3D64 still are these days.

Hugh
--0-1026342302-1574311976=:1825--
