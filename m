Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2386BC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA25214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569324703;
	bh=EalxW+xtIdRq8QRwiFIJRhi+zViq/HU46QRVA0DWQaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZpEOCkRi65jCerVFy2CdoE29pjLTBQHOZ5wrLSBHhEwvASffcnNwZgQyYqyWrtfTH
	 QtMlMWEXjXO4S720tiqVzTSqtB1w2CXe2avT8123OWbYS/jzU/9JglbajkB85+sMmz
	 4TmpmlxEgQk5+JswpE5b5n/ggY/p5rVLXVr1jbiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504729AbfIXLbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:31:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43741 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388125AbfIXLbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:31:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so1521224wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 04:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSZmsnzEFAsovNS2f1CiTt38LGsZMnX3fR1see5JvSY=;
        b=k05oMIul4Szzwc0mZVRMk5eombg5eM1MHbAqkxxJ9z0rWG949lrQPtg13BCpbokFVx
         DRBSuhYG37hTMpViUFsI6Qihc4FL+YhLhtdQj4ouG6DTVu84ir/rGohBsL9q/7RRA+ZQ
         NsUsmB/vrAEV3FGll9r3WZRZTv52Li7YEINQLzSsEht2ii6d3HRnOX26lxZNGMQzQ+Ld
         rqsnvheRB231pROsgynsD2wHvAasCax//yWnjRC5cqxXIP8M9Q7xZRtmZN8gLlu0h7oM
         6rVr9R2CZRoMECANppDWQt222g+TMLjMu2N+B1LfEqJiGFvIYJyGmBygN4FzPVOreHpx
         cBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSZmsnzEFAsovNS2f1CiTt38LGsZMnX3fR1see5JvSY=;
        b=QEF9ILP4o1n9r74V9mqvUgWtVVRyq2zt0Sd30D5qSh2qQ6kRXEHr2Uf4IS0MjU8Rfx
         eBZiTZSMOBlaj8JEEy3pig2LX736204UEW5BfbV97o09wa9xInlr8oqrxYVX4JpmOO31
         n86nqqK/h6n8PCuRR3REHonwXiN8i+y2a8fsSA/70PcXltGmkrkI+21pCOV/KpE8iix8
         zW/BD22b0bh351TCBjg6fp4YuHRXXLqDbN2DcShHYf3x09xwFlUCQsQIcyKsqPmibXnS
         cz7NUhDdBN0L53T7gFw9HLBQeLMtInWpi2RZBUaXjQpJH52cI3mXwcd9OXPmLJiZrk0f
         dvmQ==
X-Gm-Message-State: APjAAAUoWTzF1RyKFDq/fKMGoDKJhoN5eiSKWgooM+mpyzL1DqwXwHyt
        8+pmUJ6qGK35auRCALYtA5c=
X-Google-Smtp-Source: APXvYqzXLOMDDeqYZZKafy7NtZNF55ernAueMdZNPsYVBJcMougxkGFy4ZLn2pW5HUb6DOO/V7Sn9Q==
X-Received: by 2002:adf:ea47:: with SMTP id j7mr1937928wrn.394.1569324697738;
        Tue, 24 Sep 2019 04:31:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h125sm1800495wmf.31.2019.09.24.04.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 04:31:37 -0700 (PDT)
Date:   Tue, 24 Sep 2019 13:31:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [Tree, v2] De-clutter the top level directory, move ipc/ =>
 kernel/ipc/, samples/ => Documentation/samples/ and sound/ => drivers/sound/
Message-ID: <20190924113135.GA82089@gmail.com>
References: <20190922115247.GA2679387@kroah.com>
 <20190923200818.GA116090@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923200818.GA116090@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Oh, that's a pleasant surprise, I didn't expect _100%_ support! :-)
> 
> So I started working on this today and whipped up three of these 
> movements, in a 100% scripted fashion.
> 
> You can have a sneak preview at the result in this tree:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/toplevel
> 
>    ...
> 
>    2515 files changed, 42476 insertions(+), 42476 deletions(-)

I have pushed out a -v2 version:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/toplevel

   2523 files changed, 41304 insertions(+), 41302 deletions(-)

Changes relative to -v1:

 - Fixed a bunch of bugs that light testing and light review missed: 
   missed rename patterns and some build bugs as well. This tree has 
   passed much wider testing, including cross-platform build testing, a 
   distro kernel package build and it also got some light boot testing, 
   just in case.

 - Split it into finer grained steps (3 instead of 2 patches per 
   movement), for easier review and bisection testing:

     toplevel: Move ipc/ to kernel/ipc/: move the files
     toplevel: Move ipc/ to kernel/ipc/: adjust the build system
     toplevel: Move ipc/ to kernel/ipc/: adjust comments and documentation

     toplevel: Move sound/ to drivers/sound/: move the files
     toplevel: Move sound/ to drivers/sound/: adjust the build system
     toplevel: Move sound/ to drivers/sound/: adjust comments and documentation

     toplevel: Move samples/ to Documentation/samples/: move the files
     toplevel: Move samples/ to Documentation/samples/: adjust the build system
     toplevel: Move samples/ to Documentation/samples/: adjust comments and documentation

 - The changes are now bisection safe if the #1 ('move') and #2 ('build 
   system') patches are squashed. The final #3 'adjust comments and 
   documentation' patch is non-functional in the normal kernel build.
   I still kept the three steps separate, for reviewability: for many of
   the changes the build system changes are lost in the noise of the 
   file movement diff itself. (See patch-splitting notes further below.)

 - Made some of the build system changes less ad-hoc - but it's still all 
   100% scripted and automated. Added a SOB to the changelogs, but the 
   changelogs are still barebones. It's on top of Linus's latestest.

 - The longer term plan outlined in my first mail is still in flux - the 
   'scripts/' movement is probaly a bad idea due to its widespread use.

I'm still torn about whether to do a 3-part or 2-part approach for each 
directory movement:

 - The problem with the 2-part approach that merges the 'pure file move' 
   and 'build system' patches so that the latter gets lost in the first 
   one in an almost unreviewable fashion. Someone would have to re-do the 
   git mv step and generate a diff by hand to see the build system 
   changes in isolation...

 - The problem with the 3-part approach is that it breaks bisection 
   between the first two patches, although 'git bisect next' would always 
   step to a working commit, because the bisection build-breakage window 
   is only one commit wide.

So I'm slightly leaning toward the 3-part approach for the documentation 
and review value - but no strong feelings either way.

Anyway, I know everyone is super busy with the merge window, will keep 
posting new versions every now and then until you or Linus tells me not 
to bother :-)

Thanks,

	Ingo
