Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983E8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA642071C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MmHV5tnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfKTSjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:39:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39990 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfKTSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:39:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id e17so147388pgd.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ejQvp2mMhcLjLkJFrbwtDbRkBaOa3f2P+DfAVSm5cWM=;
        b=MmHV5tnSJvM6Xbp4h4iP3aD+pzQonOilRaITchmPt3mXh5oVeLLFFT3gHqcr5a3Sz7
         DNsJ/BJuc7iVDSt9BJu5x+QFUzD4pB2/BZI3vq7ypwojjWi1ueus8ADVM4QKuBKHjK2w
         xm5ysjceeOsiEe77puq7vierIEQOqIfdVjfn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ejQvp2mMhcLjLkJFrbwtDbRkBaOa3f2P+DfAVSm5cWM=;
        b=Y8xRZmN1CsCbcZWxC6p4BHojuJu5GuTuhkWAPFFIGKJfNvHhRXDs2tc7DcgcdmWNY/
         NvYJJk6TSKxLjjqvRyn+Jgmvc3mQIjRdPS5ht2A9fEzZ96BewREt3AjuBXQzyyF2fw/C
         qsyYWZd8u5TJy1gxH99GHtnokq4vSxavKwJ1rPrZjggdgF4adAdXv52/0r0yo0zTnd04
         AWCD+69y8GugKyBrSOfNNJ/PKsaccfyRVyAE93XYGAxG1a3nfFJMQa8fIkEglDqenCLN
         9pzbCRpWJsHrjQiK6KnThAYcixe9e09p7ok3KVp6yJPFF0Yakr86HjdJ5ZobfnD4rOcx
         jcWw==
X-Gm-Message-State: APjAAAVzlVu7IDxS15N+rBvanT6YMDGpOVERs7auDjSaJoX1tOpFML9C
        lJeHtQuae71hB63dti01WkFJIQ==
X-Google-Smtp-Source: APXvYqwDfSxzXFKk+yeiWvCvoVgPyhysspKSu+YKFuBuBCafawfStM/29GHG+oqBMrlFpxursVWuaA==
X-Received: by 2002:aa7:9589:: with SMTP id z9mr5855499pfj.184.1574275183016;
        Wed, 20 Nov 2019 10:39:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r184sm70789pfc.106.2019.11.20.10.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:39:41 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:39:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Bala S <balas2380@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Suggested Patch is not working for 22851 Bugzilla issue
Message-ID: <201911201032.67566C6BF@keescook>
References: <CAJKzgVtzD7ULwCDVRSLMCmGJNaMqvx+jVO619t3xuv2oiEsPMQ@mail.gmail.com>
 <20191119095708.GB21113@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119095708.GB21113@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 10:57:08AM +0100, Michal Hocko wrote:
> let me add Kees Cook and Linus to the cc list. I didn't have much
> time to study the bug report and cannot really comment on the security
> aspect of it. But let me point out that a big part of
> MAP_FIXED_NOREPLACE usage has been removed from the loader code just
> recently because it has caused some regressions
> http://lkml.kernel.org/r/20191005233227.GB25745@shell.armlinux.org.uk
> b212921b13bd ("elf: don't use MAP_FIXED_NOREPLACE for elf executable mappings").
> So you definitely want to look at the current Linus tree for your future
> experiments.

Hi!

Yes, as Michal mentions, there were legitimate binaries that expected to
overlap mappings, so we had to revert the MAP_FIXED_NOREPLACE logic for
now. At the time I added a TODO item for fixing this up correctly here:
https://github.com/KSPP/linux/issues/17

Speaking to the ldd issue (not the kernel binfmt_elf.c loader, which
is very separate), there isn't a security issue here: ldd can in many
cases _execute_ the binaries it is examining. This is a well known flaw
(as Florian points out in the bug report).

Is there some other piece of this puzzle you're trying to solve? I'm
always open to hearing new ideas in this space.

Thanks!

-Kees

> 
> On Tue 19-11-19 10:37:44, Bala S wrote:
> > Hi Mhocko,
> > 
> > https://sourceware.org/bugzilla/show_bug.cgi?id=22851
> > For the above issue, I have found the patch.
> > 
> > Patch link:
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1561935.html
> > 
> > Only change i noticed is 'MAP_FIXED_NOREPLACE' is used instead of
> > 'MAP_FIXED_SAFE'.
> > 
> > I ran test case on the following targets with this patch:
> > 
> > 1. For X86-64, Still i could see the reported issue( 'libevil.so' just
> > runs ‘cat /etc/passwd')
> > 
> > 2. For MIPS-64, i am not seeing the malicious file content as
> > reported. But ‘ldd’ could not found ‘libevil.so’.
> > 
> > root@qemumips64:~/LIN1019-1806# ldd ./main
> >         linux-vdso.so.1 (0x000000fff1f20000)
> >         libevil.so => not found
> >         libc.so.6 => /lib/libc.so.6 (0x0000005e46f70000)
> >         /lib/ld.so.1 (0x000000fff7888000)
> > 
> > I am not clear why this patch is not working for X86-64? But it is
> > working for MIPS-64 with some issue.
> > Please let me know, if anything is pending on this patch for the reported issue.
> > 
> > Thanks,
> > Bala
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Kees Cook
