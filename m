Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12900C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9B3205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="J50QEP5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfFZKFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:05:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45230 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZKFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:05:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so1971586wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f7ACw4s8Mi4a2I/fdnBCYeuXebFGdeAxi4+Z9ntqXKU=;
        b=J50QEP5UEr27ielAxFpEtuvfvK1Vu/ClVrLBhLAcga/zuTzZqGQBW/lru19zIMQbZQ
         pE5jXJR2gURgWuen2AK2d7D+S8W6z8h/D6Pr7ZQs+C1CksE0/4N9EufI6zg5YX3MMql0
         pTZ1r7IyYgf9BZIysRZJmSrGFEqHdp8zxOZtTqdXtIwKiiJCFneAlHh5AnAsaqo/c+6V
         TIjHoVrroMXY2chzB+JWmmweQV4WlBiwSssoR2RgMvzqnj4MLnckWg++VOSylD1KPpmR
         6mOUp6W4vi2wNihfYbOb7KqNrtsioZyegDDSQ9ZltbgnGA1GUIqEpaRb3FuLoWtL2Oe6
         baCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7ACw4s8Mi4a2I/fdnBCYeuXebFGdeAxi4+Z9ntqXKU=;
        b=QhZxfup9vMQ1SZ9xydjkTE7/ToXH2hLIfVDCXQQojydZHzCqpL6vF7ZcKbucw+yTm3
         uTm/qBUKnLPE6MzFnTj+RnkxjAhh4Vw8gr06ulk8PolCK2lunHzaAFujqz9pBnDnd7Re
         4m9YQJgXfo6V/WC2BYM0N3FsUSiE72wA/cfHqNV2StOij7WLU77IWHMZ27WjRwcBEm5D
         YvtkuoAf9AwCToinWSTZx5dmHk5mz/lQLceHoeulPwXBHFzZJQrWuQcBlqitEqg9tXRd
         CliwuGmTYSuZLELtvlLiVrZmJ6dDuaoutyeviHz13QAsL8oUfZrH4Q0He3Fj7tORnOqP
         5W8w==
X-Gm-Message-State: APjAAAV9/d8XsZ02jzFy1QqKmEuo71YK+7nCi4EXYUz8OmN6+gyrdmsV
        CL//5uObe05JpU6OHoQKSJIrZw==
X-Google-Smtp-Source: APXvYqwoMHNUNhEqCtJRpuGWh9bxOFjXSjkKAbBuEsHBvkXRMh5MMHAAUAMOHlxbY3gZk3AZc52HjQ==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr2466653wrv.296.1561543528299;
        Wed, 26 Jun 2019 03:05:28 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id s8sm21271216wra.55.2019.06.26.03.05.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:05:27 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:05:26 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] VFS: Introduce filesystem information query
 syscall [ver #14]
Message-ID: <20190626100525.irdehd24jowz5f75@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:08:45PM +0100, David Howells wrote:
> 
> Hi Al,
> 
> Here are a set of patches that adds a syscall, fsinfo(), that allows
> attributes of a filesystem/superblock to be queried.  Attribute values are
> of four basic types:
> 
>  (1) Version dependent-length structure (size defined by type).
> 
>  (2) Variable-length string (up to PAGE_SIZE).
> 
>  (3) Array of fixed-length structures (up to INT_MAX size).
> 
>  (4) Opaque blob (up to INT_MAX size).
> 
> Attributes can have multiple values in up to two dimensions and all the
> values of a particular attribute must have the same type.
> 
> Note that the attribute values *are* allowed to vary between dentries
> within a single superblock, depending on the specific dentry that you're
> looking at.
> 
> I've tried to make the interface as light as possible, so integer/enum
> attribute selector rather than string and the core does all the allocation
> and extensibility support work rather than leaving that to the filesystems.
> That means that for the first two attribute types, sb->s_op->fsinfo() may
> assume that the provided buffer is always present and always big enough.
> 
> Further, this removes the possibility of the filesystem gaining access to the
> userspace buffer.
> 
> 
> fsinfo() allows a variety of information to be retrieved about a filesystem
> and the mount topology:
> 
>  (1) General superblock attributes:
> 
>       - The amount of space/free space in a filesystem (as statfs()).
>       - Filesystem identifiers (UUID, volume label, device numbers, ...)
>       - The limits on a filesystem's capabilities
>       - Information on supported statx fields and attributes and IOC flags.
>       - A variety single-bit flags indicating supported capabilities.
>       - Timestamp resolution and range.
>       - Sources (as per mount(2), but fsconfig() allows multiple sources).
>       - In-filesystem filename format information.
>       - Filesystem parameters ("mount -o xxx"-type things).
>       - LSM parameters (again "mount -o xxx"-type things).
> 
>  (2) Filesystem-specific superblock attributes:
> 
>       - Server names and addresses.
>       - Cell name.
> 
>  (3) Filesystem configuration metadata attributes:
> 
>       - Filesystem parameter type descriptions.
>       - Name -> parameter mappings.
>       - Simple enumeration name -> value mappings.
> 
>  (4) Mount topology:
> 
>       - General information about a mount object.
>       - Mount device name(s).
>       - Children of a mount object and their relative paths.
> 
>  (5) Information about what the fsinfo() syscall itself supports, including
>      the number of attibutes supported and the number of capability bits
>      supported.

Phew, this patchset is a lot. It's good of course but can we please cut
some of the more advanced features such as querying by mount id,
submounts etc. pp. for now?
I feel this would help with review and since your interface is
extensible it's really not a big deal if we defer fancy features to
later cycles after people had more time to review and the interface has
seen some exposure.

The mount api changes over the last months have honestly been so huge
that any chance to make the changes smaller and easier to digest we
should take. (I'm really not complaining. Good that the work is done and
it's entirely ok that it's a lot of code.)

It would also be great if after you have dropped some stuff from this
patchset and gotten an Ack we could stuff it into linux-next for some
time because it hasn't been so far...

Christian
