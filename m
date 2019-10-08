Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4673CC47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE4021721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVmPJN76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfJHAuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 20:50:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34361 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJHAuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 20:50:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so7695215pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 17:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=axeGqpfr6+WBOJhK9o80hxtWSzlwNphv8qzRJ2eavqQ=;
        b=qVmPJN76V7+IyYv7ojUmBLD30Dm2ha0LRJQd6sJpxtBmoUhbUJR6rhRwoW+qo1SQNW
         HemeuvA6y3d2XEOQV7rqf8Kq3UjftHoWArb7rENjbAkM0JI2Whde7+U/piSSkoJ09i24
         UZMy7sigYFhmCfHkBIAdKEmi4WwtdpfZRx6VygLJQYvD1vdXZJQmvxl+4YhoMJLq8Edp
         WUdYqpDf6KnhjTOEE8IlcG2hc7/5IPmcqI+CLjXE1sT37Oq/H4rVvQ7JC9bVkkz7L9dP
         u711EW+OYDgdsMXAui2gSEKSxs1sjK8amOQv9z2m9rSq5Ww+fKbf5PHhD5brBDWwY6w+
         yCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=axeGqpfr6+WBOJhK9o80hxtWSzlwNphv8qzRJ2eavqQ=;
        b=NTamNpRChMkPPAI6DFxI1w+83LMYOQu85apFmGbyGR/+3qgoep6EuXFJOs6eXIRD9A
         v7AbjjOyJvtHywyZJoGEKn2yFpypZ6RCEHPlRftqG1KC1a0uxsUM5svbdUTQfIO4RxrK
         9uB1fq3zpBOxa2UQ5dGXBC2HHY0ewBDqxMDUVWb9yLAS0wLfbrmUVbKGz5oDzEwDGrBG
         sA66Z/c+13jTE+W9gxeU+1+QNtTmfBlZpjknDSiLjAv9cdCvbcLCQLjXFkIMvCntV2Kl
         P5gbT5P7b35CGx6r8i0RYR09Gz3Augqnr9NfsEXRuCLALWTEVJJO6GHJ40xRP9hmVJHg
         7q7Q==
X-Gm-Message-State: APjAAAVy+dUfAk6Tyw+1sD4/5V2aLfQ962Z6m1KFsY1VCfFxxPJ9kfZo
        Gvj4DdNv4T7selnbv8cH0Ov1FA==
X-Google-Smtp-Source: APXvYqyWK6wIFQTZoeOQY+viUZxjZToqVGdL8HVPYQTIrKN/LxfR5KtyDW1lfIqPOFd+SsAV8GkQAg==
X-Received: by 2002:a17:902:524:: with SMTP id 33mr32812268plf.123.1570495848323;
        Mon, 07 Oct 2019 17:50:48 -0700 (PDT)
Received: from [100.112.81.222] ([104.133.9.110])
        by smtp.gmail.com with ESMTPSA id d76sm16582383pfd.185.2019.10.07.17.50.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 17:50:47 -0700 (PDT)
Date:   Mon, 7 Oct 2019 17:50:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Laura Abbott <labbott@redhat.com>
cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: mount on tmpfs failing to parse context option
In-Reply-To: <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
Message-ID: <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com> <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019, Laura Abbott wrote:
> On 9/30/19 12:07 PM, Laura Abbott wrote:
> > Hi,
> > 
> > Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1757104
> > of a failure to parse options with the context mount option. From the
> > reporter:
> > 
> > 
> > $ unshare -rm mount -t tmpfs tmpfs /tmp -o
> > 'context="system_u:object_r:container_file_t:s0:c475,c690"'
> > mount: /tmp: wrong fs type, bad option, bad superblock on tmpfs, missing
> > codepage or helper program, or other error.
> > 
> > 
> > Sep 30 16:50:42 kernel: tmpfs: Unknown parameter 'c690"'
> > 
> > I haven't asked the reporter to bisect yet but I'm suspecting one of the
> > conversion to the new mount API:
> > 
> > $ git log --oneline v5.3..origin/master mm/shmem.c
> > edf445ad7c8d Merge branch 'hugepage-fallbacks' (hugepatch patches from
> > David Rientjes)
> > 19deb7695e07 Revert "Revert "Revert "mm, thp: consolidate THP gfp handling
> > into alloc_hugepage_direct_gfpmask""
> > 28eb3c808719 shmem: fix obsolete comment in shmem_getpage_gfp()
> > 4101196b19d7 mm: page cache: store only head pages in i_pages
> > d8c6546b1aea mm: introduce compound_nr()
> > f32356261d44 vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the
> > new mount API
> > 626c3920aeb4 shmem_parse_one(): switch to use of fs_parse()
> > e04dc423ae2c shmem_parse_options(): take handling a single option into a
> > helper
> > f6490b7fbb82 shmem_parse_options(): don't bother with mpol in separate
> > variable
> > 0b5071dd323d shmem_parse_options(): use a separate structure to keep the
> > results
> > 7e30d2a5eb0b make shmem_fill_super() static
> > 
> > 
> > I didn't find another report or a fix yet. Is it worth asking the reporter
> > to bisect?
> > 
> > Thanks,
> > Laura
> 
> Ping again, I never heard anything back and I didn't see anything come in
> with -rc2

Sorry for not responding sooner, Laura, I was travelling: and dearly
hoping that David or Al would take it.  I'm afraid this is rather beyond
my capability (can I admit that it's the first time I even heard of the
"context" mount option? and grepping for "context" has not yet shown me
at what level it is handled; and I've no idea of what a valid "context"
is for my own tmpfs mounts, to start playing around with its parsing).

Yes, I think we can assume that this bug comes from f32356261d44 ("vfs:
Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
or one of shmem_parse ones associated with it; but I'm pretty sure that
it's not worth troubling the reporter to bisect.  I expect David and Al
are familiar with "context", and can go straight to where it's handled,
and see what's up.

(tmpfs, very tiresomely, supports a NUMA "mpol" mount option which can
have commas in it e.g "mpol=bind:0,2": which makes all its comma parsing
awkward.  I assume that where the new mount API commits bend over to
accommodate that peculiarity, they end up mishandling the comma in
the context string above.)

And since we're on the subject of new mount API breakage in tmpfs, I'll
take the liberty of repeating this different case, reported earlier and
still broken in rc2: again something that I'd be hard-pressed to fix
myself, without endangering some other filesystem's mount parsing:-

My /etc/fstab has a line in for one of my test mounts:
tmpfs                /tlo                 tmpfs      size=4G               0 0
and that "size=4G" is what causes the problem: because each time
shmem_parse_options(fc, data) is called for a remount, data (that is,
options) points to a string starting with "size=4G,", followed by
what's actually been asked for in the remount options.

So if I try
mount -o remount,size=0 /tlo
that succeeds, setting the filesystem size to 0 meaning unlimited.
So if then as a test I try
mount -o remount,size=1M /tlo
that correctly fails with "Cannot retroactively limit size".
But then when I try
mount -o remount,nr_inodes=0 /tlo
I again get "Cannot retroactively limit size",
when it should have succeeded (again, 0 here meaning unlimited).

That's because the options in shmem_parse_options() are
"size=4G,nr_inodes=0", which indeed looks like an attempt to
retroactively limit size; but the user never asked "size=4G" there.

Hugh
