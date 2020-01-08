Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF3C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD152082E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfSBKC9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgAHLYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:24:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36067 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAHLYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:24:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so2317583oic.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 03:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QFQ9MzNR3N8+jCKSFbC/snv1ofUy7bS229pDEsG4jtU=;
        b=BfSBKC9urrCfL+mnO1wDRiAIf3kvrUAK0zCMfKv3A2Nivl2OaQw1dNxFOIBX86ylrP
         rYgOOTUO/HQDnD/zc1XkjpuUASqyWQI9CzirZWviiktrYETdU6r8etl0Y0yxJGsSviuU
         wEv2TR39OsGQRTp/K2XmYVevlUrZnvFmRFVreWJzXgegipHdKA0P+N4yFTPhBxkxC02D
         M8s5WP2PPW04v+VK8lSTJQEU55xtHHLdyNrniaRMQ4K9BbYSHtJXAHHsiCfaJ3cElKzJ
         9i0vt0PDlUiG9abu4hOGc/li01v0s9DqA8NBYZ9ycI3KftuOhCcz/h7nGEj14pX8YSu7
         76EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QFQ9MzNR3N8+jCKSFbC/snv1ofUy7bS229pDEsG4jtU=;
        b=EO4HZJuL3VKD4EVVaBO/vjEdGf70BLNTNyvqcI/6LYHl8PYQgg+DzEgf+izEPR3LvF
         CICNZwnio4epzzfgOgymoZMnDUcIOtauW4+iFlcV1CDfckOqBJTbQtTvxMxDx3wagsaB
         w8e5sRPfsMzSDSLjloitTEbdmTpliu7pM3QaIyt3+kjL2w4I96pZY6syuQjoB0o/NP3s
         AEV2Cxc5+tvgB1DH/YsLLDr1QXd6qwfIybrdMFb8a3ii+utob78a2Re/13kxa+CvEsdE
         ZT5eWbbHAzK3x+t+1jYPN6C80Q4WAJK2xEnnqPZBqIYjWdfiQ1RGxN+8re+LOff2QsbP
         EOXQ==
X-Gm-Message-State: APjAAAVBHj1xh+ph2+lbmagq/Qw9yMOkgvOM9vdER7AM1f0DqysUtXqe
        pmZj7KM7V5Jh1ymxe6BSwWioAA==
X-Google-Smtp-Source: APXvYqzOWV+sbUpUBdYUxYwIk/nJwIoBL6vcjOmXeYbyU08FMkPZ2OYEZkrYkv7PKP8zAf5XscqRDw==
X-Received: by 2002:aca:ab0e:: with SMTP id u14mr2709116oie.1.1578482685125;
        Wed, 08 Jan 2020 03:24:45 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a74sm1002436oii.37.2020.01.08.03.24.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Jan 2020 03:24:44 -0800 (PST)
Date:   Wed, 8 Jan 2020 03:24:42 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Chris Mason <clm@fb.com>
cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
In-Reply-To: <4E9DF932-C46C-4331-B88D-6928D63B8267@fb.com>
Message-ID: <alpine.LSU.2.11.2001080259350.1884@eggly.anvils>
References: <cover.1578225806.git.chris@chrisdown.name> <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name> <20200107001039.GM23195@dread.disaster.area> <20200107001643.GA485121@chrisdown.name> <20200107003944.GN23195@dread.disaster.area>
 <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com> <alpine.LSU.2.11.2001070002040.1496@eggly.anvils> <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com> <20200107210715.GQ23195@dread.disaster.area>
 <4E9DF932-C46C-4331-B88D-6928D63B8267@fb.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020, Chris Mason wrote:
> On 7 Jan 2020, at 16:07, Dave Chinner wrote:
> 
> > IOWs, there are *lots* of 64bit inode numbers out there on XFS
> > filesystems....
> 
> It's less likely in btrfs but +1 to all of Dave's comments.  I'm happy 
> to run a scan on machines in the fleet and see how many have 64 bit 
> inodes (either buttery or x-y), but it's going to be a lot.

Dave, Amir, Chris, many thanks for the info you've filled in -
and absolutely no need to run any scan on your fleet for this,
I think we can be confident that even if fb had some 15-year-old tool
in use on its fleet of 2GB-file filesystems, it would not be the one
to insist on a kernel revert of 64-bit tmpfs inos.

The picture looks clear now: while ChrisD does need to hold on to his
config option and inode32/inode64 mount option patch, it is much better
left out of the kernel until (very unlikely) proved necessary.

Thanks,
Hugh
