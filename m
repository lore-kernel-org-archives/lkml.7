Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0860C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CDF20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axYyYMRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCGOXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:23:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37980 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:23:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id s1so17217937qte.5;
        Thu, 07 Mar 2019 06:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9x0CSZAdaM5hQeCnvldBcLzwze+xlDNVqUNcj5diRI=;
        b=axYyYMRUpJEnK0FbICrHEXlbmnqJfSsK0lnJeF1HhZnPtDxLgsyQ71xByGDJKQq9vF
         QvHVpeYzc5xpTV1qGkyIF7P6Gw905rAv3iJML/xCSHbEcSYnURJ5KUlp5qLMgVKcadrl
         CA9thezqCrZDc23Ry+Evx07FNF0tXDY1/S+pg0Eh6BZk7EXqnNw28eB/v+yhvKlrfU1l
         /gTnbrr9auo4Ig+zQc3lzKWVu0pEp7j/egeVwUHQav6aGkuaDGy9tTWlru7KztHdi+VV
         TQag8WgKDRhb7m3cJNqy8gH2Vg5W0NgQiqAyI+MBjMCjy+tAtjqrhfD7jDhdtz6QemsT
         DMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9x0CSZAdaM5hQeCnvldBcLzwze+xlDNVqUNcj5diRI=;
        b=HoCeMbqYEl6yDSdnsK10au21cKWgCY2//x8ls0h9tkfOzyJUMCQuwzjwQilyvXkFhq
         dU/mAzptlZBmDTz12/wQSoBEtEIL8DUWr9urcUPs+ofaMau2iolc5tXwLttVRso2FgX0
         hw1CGTLJ80NkPOKmsNkl63ZHGeXGUPaP8VAVJkHySjMiM2ngdh0k1Z5ktwWybTe6iXxw
         I9S7FWkMx2zRcTqslb2buJIXNfzkCxAQhFv13l2evmcm4l4ETPffCUmzzRXjWSySh271
         NR3uxrFip1Z0ZxMXEZgpf7BeuqX1PcRo/kicw1w718+t8VmM1yNx0iz8+jEWN6uHwllS
         1Mpw==
X-Gm-Message-State: APjAAAUJGN9FGVcqVVEG+z4cBcYB/65RZ7FTlnzeW0UNd8QvjIE5wjZI
        n5i7n4vskHqL5f0fGmN8wJjoUCwuG3fYs67SLMY=
X-Google-Smtp-Source: APXvYqyQ60oG1CiiyHTupw4eMYX8Z458yMaHc4bkR3g9TrA+vHn9LcoF8u56iw89qKTerpgv5eq68IjNTiQPzQ8QP+M=
X-Received: by 2002:ac8:1b98:: with SMTP id z24mr10132465qtj.204.1551968594447;
 Thu, 07 Mar 2019 06:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20190301175752.17808-1-lhenriques@suse.com> <20190301175752.17808-3-lhenriques@suse.com>
 <CAAM7YAmPSoEaJ6tXUtp+f56SV-Tqr6VKP4RquV0FA+LYkR8Rxg@mail.gmail.com>
 <87va0vamog.fsf@suse.com> <CAAM7YAmapiFwj=sY+vCUyOU1mPZE2sk4_ZYPYAk06iPDd_utzQ@mail.gmail.com>
 <87mum79ccu.fsf@suse.com>
In-Reply-To: <87mum79ccu.fsf@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Thu, 7 Mar 2019 22:23:03 +0800
Message-ID: <CAAM7YA=ry+t3X4ECXZNb51oXtk+5wXSWd6EM46vsZafQ2LL7sg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] ceph: quota: fix quota subdir mounts
To:     Luis Henriques <lhenriques@suse.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Peyerl <hpeyerl@plusline.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 7:02 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> "Yan, Zheng" <ukernel@gmail.com> writes:
>
> > On Thu, Mar 7, 2019 at 2:21 AM Luis Henriques <lhenriques@suse.com> wrote:
> >>
> >> "Yan, Zheng" <ukernel@gmail.com> writes:
> >>
> >> > On Sat, Mar 2, 2019 at 3:13 AM Luis Henriques <lhenriques@suse.com> wrote:
> >> >>
> >> >> The CephFS kernel client doesn't enforce quotas that are set in a
> >> >> directory that isn't visible in the mount point.  For example, given the
> >> >> path '/dir1/dir2', if quotas are set in 'dir1' and the mount is done in with
> >> >>
> >> >>   mount -t ceph <server>:<port>:/dir1/ /mnt
> >> >>
> >> >> then the client can't access the 'dir1' inode from the quota realm dir2
> >> >> belongs to.
> >> >>
> >> >> This patch fixes this by simply doing an MDS LOOKUPINO Op and grabbing a
> >> >> reference to it (so that it doesn't disappear again).  This also requires an
> >> >> extra field in ceph_snap_realm so that we know we have to release that
> >> >> reference when destroying the realm.
> >> >>
> >> >
> >> > This may cause circle reference if somehow an inode owned by snaprealm
> >> > get moved into mount subdir (other clients do rename).  how about
> >> > holding these inodes in mds_client?
> >>
> >> Ok, before proceeded any further I wanted to make sure that what you
> >> were suggesting was something like the patch below.  It simply keeps a
> >> list of inodes in ceph_mds_client until the filesystem is umounted,
> >> iput()ing them at that point.
> >>
> > yes,
> >
> >> I'm sure I'm missing another place where the reference should be
> >> dropped, but I couldn't figure it out yet.  It can't be
> >> ceph_destroy_inode; drop_inode_snap_realm is a possibility, but what if
> >> the inode becomes visible in the meantime?  Well, I'll continue thinking
> >> about it.
> >
> > why do you think we need to clean up the references at other place.
> > what problem you encountered.
>
> I'm not really seeing any issue, at least not at the moment.  I believe
> that we could just be holding refs to inodes that may not exist anymore
> in the cluster.  For example, in client 1:
>
>  mkdir -p /mnt/a/b
>  setfattr -n ceph.quota.max_files -v 5 /mnt/a
>
> In client 2 we mount:
>
>  mount <addr>:/a/b /mnt
>
> This client will access the realm and inode for 'a' (adding that inode
> to the ceph_mds_client list), because it has quotas.  If client 1 then
> deletes 'a', client 2 will continue to have a reference to that inode in
> that list.  That's why I thought we should be able to clean up that refs
> list in some other place, although that's probably a big deal, since we
> won't be able to a lot with this mount anyway.
>

Agree, it's not big deal

> Cheers,
> --
> Luis
