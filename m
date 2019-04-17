Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D63C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29B62173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jczd3cpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfDQQ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:56:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40504 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfDQQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:56:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id a28so19427680lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LTV52Z6BxXAqi3K2r/MRVHJk1VnWNiq5p7fdQW/kY3w=;
        b=Jczd3cpcmjVN17SWHwPXYFIr/r8IgvK4yb/Xo/ti+K7aDRPM4CmgvMlbHZR7errpPM
         +NNb8zpzlCTQdSNaDffzREAnY2jGht9PfkcrBApXEL0VYfUaPcxsB5p2NGzwSJJ+mPvx
         sq0fJiGFqKe9TSQ5OY0SQ3jZFtkCnMTQuV+kzo07Z5wUOqs07LiSNPzcigtQWEOJENQA
         doM9l7mu3O/KAZtT6a22JAv6qpqOyPQPXVg0snHzZDZM90IRkSjCN/qnXtFz3erW8kZx
         jtAztCLOPl7QEqVAsHT7uK/OiqW/dqbsL+dCE01PAtxBCB4SaJeDPmVf6Be3x959PI2D
         Xkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LTV52Z6BxXAqi3K2r/MRVHJk1VnWNiq5p7fdQW/kY3w=;
        b=fhdLsuHjM4UetuD+PEAYSETLvrF1XSknl3wClR7AK4vEKjQP2Ok7xY89dWVkCu/bS8
         yBF/9Clh6Li9lDx7u/CJCa5YkmchwLAnwFFDWFJMFG6e+bSvYZFH+N5+viVP8ao+sKCL
         4UNdjdbibNmZwSOgH4rje8M4Jb8u5Vt0h6e8MgJbbXkY0se2Isj8j7biO6MEMmvXW+lO
         JfVQ9+wvkEUg9lYAApjmWpY6nJY5Lr96rYBAM4WGPpX7f8RHtNEXjlFKbj4OwI1k/O9S
         4/1kfKL4W+pPgXX0e3guov+pE0l5YBv5DHojuAmA4sEc7zGt0SrrFBL+R7vKC1L6f6+M
         DG7w==
X-Gm-Message-State: APjAAAWMvPJAZpglnZe9OS2jYlrIwXBgb3cxOIZ0gUPUgg9RCwh6LqBN
        iYhr4xtaIv/DP3GuB/SbjbM=
X-Google-Smtp-Source: APXvYqw4yTz4rrMBIUJm+TTb5e8GVILyFlbd39oLCvf+NmTttucbZqiSvLVp/QU937Qm43g0H2ImSw==
X-Received: by 2002:ac2:528e:: with SMTP id q14mr7638680lfm.83.1555520193790;
        Wed, 17 Apr 2019 09:56:33 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id v11sm10991007ljk.19.2019.04.17.09.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 09:56:33 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 9CB0C46010A; Wed, 17 Apr 2019 19:56:32 +0300 (MSK)
Date:   Wed, 17 Apr 2019 19:56:32 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     kbuild-all@01.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Andrey Vagin <avagin@openvz.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH] prctl: Don't compile some of prctl functions when CRUI
Message-ID: <20190417165632.GC3040@uranus.lan>
References: <20180420140044.478b4c88d3cf238bd440f2a7@linux-foundation.org>
 <20190417122349.GA15498@blackbody.suse.cz>
 <20190417123841.GA3040@uranus.lan>
 <20190417144454.GG8962@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417144454.GG8962@blackbody.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:44:54PM +0200, Michal Koutný wrote:
> On Wed, Apr 17, 2019 at 03:38:41PM +0300, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> > I've a bit vague memory what we've ended up with, but iirc there was
> > a problem with brk() syscall or similar. Then I think we left everything
> > as is.
> Was this related to the removal of non PR_SET_MM_MAP operations too?
> Do you have any pointers to the topic?

Here some details: suprisingly there are already users of PR_SET_MM_x
operands, so we can't deprecate it (https://lkml.org/lkml/2018/5/6/127).
And then there was an attempt to change locks https://lore.kernel.org/patchwork/patch/
but since we're modifying mm-> entries we should gurd them against
simultaneous sys_brk call. Or I misunderstood you and you meant somthing
different?
