Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C0BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532DD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PS97z0V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfFZKrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:47:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38103 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:47:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so1579295wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fSwT7q8BLOXNpzs+danpM3n1/i2uCJHF7PPr1vSLfUI=;
        b=PS97z0V4J4hvrFU+KNWT9KYw44s2DQgCAUU9WUGDvoPpxuLC6OGdIjueLKdBR7rIMD
         /c+6iW62x6//m985XD5u0ll7y/SU0ES0Vq1A4U2sZX/i7DvMz1c+3OEv9MelQbHtVti4
         SkTWJtxzYLtaBybXaTu1kQCt34D96VbpPP+z6mGodaWlxG0MtHvMeBQNn5pf6XWz/8Wq
         +IYgMuaS7yiGRxDq2Et47sBq6d9qZIYAANakOIRBK6b34dbMGWDFL37AcXCQVfEKJJky
         aw1DQLorLWmpge7WBYN+IR+yTIKFowXM2Rk5HYT5R1TDhKhL6um8jO4UGWPXCMU5ZcTL
         rrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fSwT7q8BLOXNpzs+danpM3n1/i2uCJHF7PPr1vSLfUI=;
        b=Wu1GiTJYzTTVpv+/Wav93nthC6GDzrNxVrX7F+oqIMkVVKhu6S2RJPJAm0YgPGMhrB
         l/r3VdVsZOqg+yxnKwIceaHNArIC7oFGi0GF7h2cFJGoUADclsbbrlP+RLy2B3D9X4P6
         wny6k7IjKkT9KakMEJrwPGcwv5L1fjW3SNZUK7xmCgh2N83zmLvEeysVQfRcvuuSxa0F
         j+DQZBjpz/uKq9HhTnzN2OgObRqS6Xqll0CTP1xCU9wBOsg5yfjCP8/c3FrFNRjD6/hl
         HO++Z4DDNtKtAETqVbv7SAlHprfcSQxOwz1bs1gPas8Z0UyBZdIAUTExB3SHjFRZqKfI
         UFzQ==
X-Gm-Message-State: APjAAAXqBK49xU/7oRberddPcWC/phc9SRenxnSOLy2f29FUd4lZempK
        EonxdN9Zvl9L6WrdxPF3RGMWBQ==
X-Google-Smtp-Source: APXvYqwfRtRTDwuQHX1TngULVXOfM5NelQlr57zqJTiIB+fKCFHgOpqMp9+Sp2ktppAqj+A2FYeePw==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr2343827wma.78.1561546027369;
        Wed, 26 Jun 2019 03:47:07 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id d5sm16228435wrc.17.2019.06.26.03.47.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:47:06 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:47:05 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] VFS: Introduce filesystem information query
 syscall [ver #14]
Message-ID: <20190626104704.dwjd4urpsmuheirc@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
 <20190626100525.irdehd24jowz5f75@brauner.io>
 <cf0361c2d1fc09ad0097f0da1e981b97ad39ab07.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf0361c2d1fc09ad0097f0da1e981b97ad39ab07.camel@themaw.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 06:42:51PM +0800, Ian Kent wrote:
> On Wed, 2019-06-26 at 12:05 +0200, Christian Brauner wrote:
> > On Mon, Jun 24, 2019 at 03:08:45PM +0100, David Howells wrote:
> > > Hi Al,
> > > 
> > > Here are a set of patches that adds a syscall, fsinfo(), that allows
> > > attributes of a filesystem/superblock to be queried.  Attribute values are
> > > of four basic types:
> > > 
> > >  (1) Version dependent-length structure (size defined by type).
> > > 
> > >  (2) Variable-length string (up to PAGE_SIZE).
> > > 
> > >  (3) Array of fixed-length structures (up to INT_MAX size).
> > > 
> > >  (4) Opaque blob (up to INT_MAX size).
> > > 
> > > Attributes can have multiple values in up to two dimensions and all the
> > > values of a particular attribute must have the same type.
> > > 
> > > Note that the attribute values *are* allowed to vary between dentries
> > > within a single superblock, depending on the specific dentry that you're
> > > looking at.
> > > 
> > > I've tried to make the interface as light as possible, so integer/enum
> > > attribute selector rather than string and the core does all the allocation
> > > and extensibility support work rather than leaving that to the filesystems.
> > > That means that for the first two attribute types, sb->s_op->fsinfo() may
> > > assume that the provided buffer is always present and always big enough.
> > > 
> > > Further, this removes the possibility of the filesystem gaining access to
> > > the
> > > userspace buffer.
> > > 
> > > 
> > > fsinfo() allows a variety of information to be retrieved about a filesystem
> > > and the mount topology:
> > > 
> > >  (1) General superblock attributes:
> > > 
> > >       - The amount of space/free space in a filesystem (as statfs()).
> > >       - Filesystem identifiers (UUID, volume label, device numbers, ...)
> > >       - The limits on a filesystem's capabilities
> > >       - Information on supported statx fields and attributes and IOC flags.
> > >       - A variety single-bit flags indicating supported capabilities.
> > >       - Timestamp resolution and range.
> > >       - Sources (as per mount(2), but fsconfig() allows multiple sources).
> > >       - In-filesystem filename format information.
> > >       - Filesystem parameters ("mount -o xxx"-type things).
> > >       - LSM parameters (again "mount -o xxx"-type things).
> > > 
> > >  (2) Filesystem-specific superblock attributes:
> > > 
> > >       - Server names and addresses.
> > >       - Cell name.
> > > 
> > >  (3) Filesystem configuration metadata attributes:
> > > 
> > >       - Filesystem parameter type descriptions.
> > >       - Name -> parameter mappings.
> > >       - Simple enumeration name -> value mappings.
> > > 
> > >  (4) Mount topology:
> > > 
> > >       - General information about a mount object.
> > >       - Mount device name(s).
> > >       - Children of a mount object and their relative paths.
> > > 
> > >  (5) Information about what the fsinfo() syscall itself supports, including
> > >      the number of attibutes supported and the number of capability bits
> > >      supported.
> > 
> > Phew, this patchset is a lot. It's good of course but can we please cut
> > some of the more advanced features such as querying by mount id,
> > submounts etc. pp. for now?
> 
> Did you mean the "vfs: Allow fsinfo() to look up a mount object by ID"
> patch?
> 
> We would need to be very careful what was dropped.

Not dropped as in never implement but rather defer it by one merge
window to give us a) more time to review and settle the interface while
b) not stalling the overall patch.

> 
> For example, I've found that the patch above is pretty much essential
> for fsinfo() to be useful from user space.

Yeah, but that interface is not clearly defined yet as can be seen from
the commit message and that's what's bothering me most.
