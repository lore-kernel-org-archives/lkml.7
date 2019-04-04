Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77211C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EF221734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WX/hqQzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfDDIBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:01:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37892 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDDIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:01:35 -0400
Received: by mail-it1-f193.google.com with SMTP id f22so2248209ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdJDlyHvzmVCG4+t5yoJd2yuhryUSl/550UFcR7PiYk=;
        b=WX/hqQzfO+mK+nn/esSN14pxXKWwfDchWjNF0ahntG/CwHvSNFCMxSgl0/SCIg3AW0
         BIxbSfjZy/TrWmNZEIB58kTiYlZpKLJWSb7zoHnes2lFMobyu+qFBEkVIFhZYeNlX+vj
         0S35iTUl4uNXIEV4mBe3kXpGBOLo0Q+lbkDvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdJDlyHvzmVCG4+t5yoJd2yuhryUSl/550UFcR7PiYk=;
        b=lnh9SLiBpLjwR/XYzNs1QuItgMpDT6NW5Df392/8zewjFegIJ46ISXq/r++qf43Ac1
         aCFDQShNyda73JqxJsfqqeL8NsIL5I2di+YMuij7+Rfe0oHVgrBXWrwjlrnIFmyu0dZh
         KPFb38lhuvkM6ygmvVB9RazGh3BbNT+gPDKVDgCgirVzHnpVzKds5MQDQ4RkGQ8OlZI6
         Wm1lIDfB3SvXaSaIwsZYGaTg4sRGbovQdXf5Biu6wcQpuTPvRwmez1KW8fmNoHSRSEns
         OHt0c4eouX04BU1KcB8nFlFHKhRGF6sYaUvmW2nm+S5zxzfqED0I2uT5KmpkZJGd2Hwv
         ZiBg==
X-Gm-Message-State: APjAAAX6acwfMjocEoMJuMcTy9oJBunrRYk9fH7ykZcIT9auZ2pVH26B
        Ihe8shUrgfAUwOzGC/PJ02IbR+YIFNoxkEuPJM5Ibw==
X-Google-Smtp-Source: APXvYqwqsJj7FYNRGkXzdlqhVlX0qlT8IrNnkVRl6yS81yiZB+Lems7LS7CwDCkeNoEN6Z+Y/am5SZlY2ub3FZWTsqY=
X-Received: by 2002:a24:c2c1:: with SMTP id i184mr3600474itg.82.1554364894463;
 Thu, 04 Apr 2019 01:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190403042127.18755-1-tobin@kernel.org> <20190403042127.18755-15-tobin@kernel.org>
 <20190403170811.GR2217@ZenIV.linux.org.uk> <01000169e458534a-3c6a5d6f-3054-4c64-b5f9-7f46c811eeac-000000@email.amazonses.com>
 <20190403182454.GU2217@ZenIV.linux.org.uk> <20190403190520.GW2217@ZenIV.linux.org.uk>
In-Reply-To: <20190403190520.GW2217@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 4 Apr 2019 10:01:23 +0200
Message-ID: <CAJfpegsn8trCjTgah5yoPA=QSH-CDngKMu_+pta9aeGQhxxV=g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/14] dcache: Implement object migration
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christopher Lameter <cl@linux.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "Theodore Ts'o" <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 9:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Apr 03, 2019 at 07:24:54PM +0100, Al Viro wrote:
>
> > If by "how to do it right" you mean "expedit kicking out something with
> > non-zero refcount" - there's no way to do that.  Nothing even remotely
> > sane.
> >
> > If you mean "kick out everything in this page with zero refcount" - that
> > can be done (see further in the thread).
> >
> > Look, dentries and inodes are really, really not relocatable.  If they
> > can be evicted by memory pressure - sure, we can do that for a given
> > set (e.g. "everything in that page").  But that's it - if memory
> > pressure would _not_ get rid of that one, there's nothing to be done.
> > Again, all VM can do is to simulate shrinker hitting hard on given
> > bunch (rather than buggering the entire cache).  If filesystem (or
> > something in VFS) says "it's busy", it bloody well _is_ busy and
> > won't be going away until it ceases to be such.
>
> FWIW, some theory: the only kind of long-term reference that can
> be killed off by memory pressure is that from child to parent.
> Anything else (e.g. an opened file, current directory, mountpoint,
> etc.) is out of limits - it either won't be going away until
> the thing is not pinned anymore (close, chdir, etc.) *or*
> it really shouldn't be ("VM wants this mountpoint dentry freed,
> so just dissolve the mount" is a bloody bad idea for obvious
> reasons).

Well, theoretically we could do two levels of references, where the
long term reference is stable and contains an rcu protected unstable
reference to the real object.   In the likely case when only read-only
access to the object is needed (d_lookup) then the cost is an extra
dereference and the associated additional cache usage.  If read-write
access is needed to object, then extra locking is needed to protect
against concurrent migration.  So there's non-trivial cost in addition
to the added complexity, and I don't see it actually making sense in
practice.   But maybe someone can expand this idea to something
practicable...

Thanks,
Miklos
