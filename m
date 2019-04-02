Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3969C3E8A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2D82064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqHi3KXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfDBQRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:17:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33118 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbfDBQRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:17:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so144005pgh.0;
        Tue, 02 Apr 2019 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JbfDVSihwTx21ysjcpNCAdgycCvIFZGZ/Q4z4v790s0=;
        b=HqHi3KXr+FXHd4AqTz1ou1EFpoK3fZUF2eztfS2BBqq/LlDPQ48vdtCQTwYGN43QiL
         H5zNFG+pjs+3KnACZcR4Mr4/yGKxX5yqlHViGHd7eG6wvy74YS8uVi6RtpRVJjoTS69P
         VmAZI4o/dQAn95e/vqqCZKj6C9qiTQ/Y0xdryj+Ji0lUpM0zfTs+SxmG8jl21kKI6PU3
         e4WPzkQoypjPEA+o34ASEEcziOaQBKM9FcITcDdVdo997nHiPQ8jMjVqxq3rNYzXXvs/
         2vlsPRzXeDy8nXfQhtzfd8f96hpbvL+uR1Gm77WsRLPtjMQFnKd6H1d9+uDkiaWoMj+7
         cWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JbfDVSihwTx21ysjcpNCAdgycCvIFZGZ/Q4z4v790s0=;
        b=GbuuBNEw8bH0zM8DiHQysRljQ6p1YZscsuV+AXX87jN+WAlWUAzDMuHnM9u4rgV6AE
         3SpaKDlxKPqQzLDxgJj3SYNpvZEA4EgwvGpT576nyuRTQFYsc5JPtux4odmHzvV6GS8u
         a145BSR2DaMmzImtdsHA4h1Yj7Mi1yLNtlNroq/4f9s6A/IJ6KGNd4M91FFYjDggyR4D
         tyAo5ZaMc9JPoJg/m4xfyJFZAYpVy56S9ueqWAopfUVejEee5lwU7P96bg7TkEvRJI1Q
         X+aDHpZ0orSfhTf9jLkAHmOp5p8ILv2/mHEF7yDfgWCj/YiWa0NQjhAIW5skuFdj7xdg
         uxfQ==
X-Gm-Message-State: APjAAAU2+BrviAb6u9ydmcm0QWQdLWZ+gFCmCcZvbpHupTi1uZp+g9Dh
        K79eAUtIbh1CaibMKGF7U6E=
X-Google-Smtp-Source: APXvYqzBPmWUn8xkWl5jCa/CxzGFeOEfjylG8P8xS/YVegMfkHlqp/y8C6vW1V1oLe4qgab0OnSsbw==
X-Received: by 2002:a62:5ec2:: with SMTP id s185mr3423780pfb.16.1554221839526;
        Tue, 02 Apr 2019 09:17:19 -0700 (PDT)
Received: from vostro (173-228-88-115.dsl.dynamic.fusionbroadband.com. [173.228.88.115])
        by smtp.gmail.com with ESMTPSA id o67sm16832118pga.55.2019.04.02.09.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:17:18 -0700 (PDT)
Date:   Tue, 2 Apr 2019 09:17:10 -0700
From:   Nikitas Angelinas <nikitas.angelinas@gmail.com>
To:     Mukesh Ojha <mojha@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, LKP <lkp@01.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: b050de0f98 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP"):
 BUG: KASAN: null-ptr-deref in allow_write_access
Message-ID: <20190402161710.GA4152@vostro>
References: <5ca377a6.5zcN4o4WezY4tfcr%lkp@intel.com>
 <86f16af9-961f-5057-6596-c95c0316f7da@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f16af9-961f-5057-6596-c95c0316f7da@codeaurora.org>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:53:42PM +0530, Mukesh Ojha wrote:
> I think, this may fix the problem.
> 
> https://patchwork.kernel.org/patch/10878501/
> 
> 
> Thanks,
> Mukesh
> 
> On 4/2/2019 8:24 PM, kernel test robot wrote:
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > 
> > commit b050de0f986606011986698de504c0dbc12c40dc
> > Author:     Alexey Dobriyan <adobriyan@gmail.com>
> > AuthorDate: Fri Mar 29 10:02:05 2019 +1100
> > Commit:     Stephen Rothwell <sfr@canb.auug.org.au>
> > CommitDate: Sat Mar 30 16:09:51 2019 +1100
> > 
> >      fs/binfmt_elf.c: free PT_INTERP filename ASAP
> >      There is no reason for PT_INTERP filename to linger till the end of
> >      the whole loading process.
> >      Link: http://lkml.kernel.org/r/20190314204953.GD18143@avx2
> >      Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >      Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> >      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >      Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > 
> > 46238614d8  fs/binfmt_elf.c: make scope of "pos" variable smaller
> > b050de0f98  fs/binfmt_elf.c: free PT_INTERP filename ASAP
> > 05d08e2995  Add linux-next specific files for 20190402
<snip>
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/lkp                          Intel Corporation
> 

Hi,

Yes, it should.

Andrew seems to have added the patch to the -mm tree.


P.S. Apologies to individual recipients for the double-posting. I am resending
this as the previous mail was rejected from linux-kernel and linux-fsdevel due
to HTML content.



Cheers,
Nikitas
