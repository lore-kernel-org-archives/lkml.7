Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B139C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E2320659
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYSzUH86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKUTyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:54:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34033 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUTyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:54:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id z188so2162597pgb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5MEvzzFTv+KiLbevjBv7savooCbJd1WBk2QrzJkKsFY=;
        b=mYSzUH86irHH///s03frIqQ/lO9tpB6U4bVptlF+q3y3uBHsf6sqaxL69ibNhwYpUI
         +ouMzQtmOgXtgD4369UxSRTCU6WzvIV6VJ7+BCtAi7EEus7+/dNTd6uO8S/sgheE78ru
         n0GMzgijsyBvOlpjuGgx/D35jQKFDNb74dS5WPQfkpND2H9sbnO1Qjay+Y9GJ488JP6Q
         74L2zN/2fBwcZQNz290u45SlY+4vi9eenYU0PmSiHPqgqH5nSc6YMNCMVhhBtJ0sHPaT
         n93z7Dgp00EgEHQbVeC1Pre5fz43M3koHgfckHtbnJHeYno7DTaRiWKUVA2hH/NxjaZD
         XqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5MEvzzFTv+KiLbevjBv7savooCbJd1WBk2QrzJkKsFY=;
        b=ohL1wmwzZAN/E538SdkOrd0XCdghyj2GFTvj+4DKJeK3MHXz8cNdKoh+Y2sXTrXo9I
         kE7xYOvRkzCDdmtcyLSK7f3Hx6jgtKo+cvHH2eRlNQdneTYPXF2N6z0tWTxckc4U9MVR
         xlkmQWNtfhrtkHk5GGvywzvyrl2ymvYHGZs6TZbEa0R7HaSxUl2rw5eaITmIKrQnYlOh
         BjrFGfvEkdgWfL15JGVuLKGwC19aXfnmgxXAQ8Hp9+LvOW6ORNXf4krpV0fgMqt7itdl
         MuvfxkTicYBcuiKoA5LKPMCAntmUVh2md5da0i4+KI6un1cCYTajds/exXskHyZhPQAl
         a/AA==
X-Gm-Message-State: APjAAAU4b+f80Xs7+2YN57wcBmF8K/yE4zNePYnaitOzZX+kfSHbvflb
        fAxorIR/4TCx2voQiDXPhH4yZRVkk9U=
X-Google-Smtp-Source: APXvYqxbsCt6urUnxlOQjMABFv9opP+Lbt/LkNauGQNvMzc1hOz7985MY1G0JUjnf/bJj6om6YMgSQ==
X-Received: by 2002:a62:5485:: with SMTP id i127mr5019541pfb.186.1574366042834;
        Thu, 21 Nov 2019 11:54:02 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id 21sm4539592pfa.170.2019.11.21.11.54.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 11:54:02 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:53:49 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "zhengbin (A)" <zhengbin13@huawei.com>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com,
        "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH] tmpfs: use ida to get inode number
In-Reply-To: <d22bcbcb-d507-7c8c-e946-704ffc499fa6@huawei.com>
Message-ID: <alpine.LSU.2.11.1911211125190.1697@eggly.anvils>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com> <20191120154552.GS20752@bombadil.infradead.org> <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com> <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
 <d22bcbcb-d507-7c8c-e946-704ffc499fa6@huawei.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, zhengbin (A) wrote:
> On 2019/11/21 12:52, Hugh Dickins wrote:
> > Just a rushed FYI without looking at your patch or comments.
> >
> > Internally (in Google) we do rely on good tmpfs inode numbers more
> > than on those of other get_next_ino() filesystems, and carry a patch
> > to mm/shmem.c for it to use 64-bit inode numbers (and separate inode
> > number space for each superblock) - essentially,
> >
> > 	ino = sbinfo->next_ino++;
> > 	/* Avoid 0 in the low 32 bits: might appear deleted */
> > 	if (unlikely((unsigned int)ino == 0))
> > 		ino = sbinfo->next_ino++;
> >
> > Which I think would be faster, and need less memory, than IDA.
> > But whether that is of general interest, or of interest to you,
> > depends upon how prevalent 32-bit executables built without
> > __FILE_OFFSET_BITS=64 still are these days.
> 
> So how google think about this? inode number > 32-bit, but 32-bit executables
> cat not handle this?

Google is free to limit what executables are run on its machines,
and how they are built, so little problem here.

A general-purpose 32-bit Linux distribution does not have that freedom,
does not want to limit what the user runs.  But I thought that by now
they (and all serious users of 32-bit systems) were building their own
executables with _FILE_OFFSET_BITS=64 (I was too generous with the
underscores yesterday); and I thought that defined __USE_FILE_OFFSET64,
and that typedef'd ino_t to be __ino64_t.  And the 32-bit kernel would
have __ARCH_WANT_STAT64, which delivers st_ino as unsigned long long.

So I thought that a modern, professional 32-bit executable would be
dealing in 64-bit inode numbers anyway.  But I am not a system builder,
so perhaps I'm being naive.  And of course some users may have to support
some old userspace, or apps that assign inode numbers to "int" or "long"
or whatever.  I have no insight into the extent of that problem.

Hugh
