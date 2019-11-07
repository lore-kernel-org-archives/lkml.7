Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1677C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC2E21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573111874;
	bh=8cQBIwNA3zhWQ9iS8VO6DebmqrZUhptIxgSmHMfDlTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b4TEjIrJdjt2LHzFhL+6Wr3yhIm9arD9WQhVxsE1FIJvqsLDvFi+o+sd+LGtHb/Q3
	 j8bMKetVS/bYK4DqKEjQWhZX8YCKed9TdvClVrPHutYmAU4Nr8qdPzdMdXjk2vv1uL
	 y/esEmOc8tLqK2MvQZxPGnEu+OogNppVM9Dmlxas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKGHbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:31:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38488 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfKGHbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:31:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so1192875wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yo6Xq8M8DuyhNK9VANJe3xtr6IPG2RacFSM7QGUt7BA=;
        b=aEVG5AcJWrfVEU1eku32nAzFeEd6FF5MmhE9axBqp7s7fN2QWuoG1TJDOUsarngERP
         vvBQ2o07Nqodm7pTECbIhbSClBaTXav2lLaz5aJFKddKvINiM68VLO/9OGXX+ki4XS7R
         h+e5rgkfzQvqYOhAbi/u0QBbUl2dYd/qGmmZTaYmRYcvDO4U/Jice9+vQKjbfmj+qpWQ
         XEwdCj/wSkI+Zdh50o18DVxvWpnC7hdZU/wwoe5HUjH5Wmj/vmIidjXVzsZmZxoTiUDx
         JHgfhrRHaCVS/FB2QOAjdsoIEQq50yoIP47FCLFMs6TC3WfqeBN6Pmwuy6NmyTy00sRm
         Fptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yo6Xq8M8DuyhNK9VANJe3xtr6IPG2RacFSM7QGUt7BA=;
        b=WxXLAluw8sNbCQIYOZxQC8ZSPNYmhqq5TqRP1PSZEs3g5ZlI8mmaPmvfhh1q23SDZU
         bRzVoE4jYkjwVvsTKeeCMrIH7/weL/6UzgyS2vosRuNC0vqGxrJywKOT+GQZh8CPm/es
         CFLbfbO1kBXezHGvKJ72I0Vg9Yc1uey4HavvMOkNe/gvJUABMlXxdHDr7JArqwc12Srx
         dIcflxBC9AFKAC3vf9g0SNUy0OjM7hoe2V31721hRu5qzze4YWaDe3xkPiFuU1CPjxO3
         CBenDSIfOp+3JRi438pbizR0cdfWupXCWvYAPtSkDiQBhn8k1A8SAzQW+xARgofh/Oco
         t7vQ==
X-Gm-Message-State: APjAAAWZCmIolHvBR2mMdFIbHhQxa/rBaoqiAK/8u/baVZ4lS0Twu5ZA
        jLIPINBtkjQa0D/ZsCxtD8w=
X-Google-Smtp-Source: APXvYqyG+zMnyvvQhxkPIcK2Od4qCWTRqCEcvpbTXoqW3nJ4gzEoAFj8yE4O0v+LQ6Jw7Ek1bBLDgA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr1400063wmj.140.1573111871348;
        Wed, 06 Nov 2019 23:31:11 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n13sm1029564wmi.25.2019.11.06.23.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 23:31:10 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:31:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 1/9] x86/ptrace: Prevent truncation of bitmap size
Message-ID: <20191107073108.GC30739@gmail.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202805.856479311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106202805.856479311@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The active() callback of the IO bitmap regset divides the IO bitmap size by
> the word size (32/64 bit). As the I/O bitmap size is in bytes the active
> check fails for bitmap sizes of 1-3 bytes on 32bit and 1-7 bytes on 64bit.
> 
> Use DIV_ROUND_UP() instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/ptrace.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -697,7 +697,7 @@ static int ptrace_set_debugreg(struct ta
>  static int ioperm_active(struct task_struct *target,
>  			 const struct user_regset *regset)
>  {
> -	return target->thread.io_bitmap_max / regset->size;
> +	return DIV_ROUND_UP(target->thread.io_bitmap_max, regset->size);
>  }
>  
>  static int ioperm_get(struct task_struct *target,

Reviewed-by: Ingo Molnar <mingo@kernel.org>


But the ioperm core dumping logic in ptrace.c looks a bit weird. For 
example why do we alias REGSET_IOPERM64 to REGSET_XFP:

enum x86_regset {
        REGSET_GENERAL,
        REGSET_FP,
        REGSET_XFP,
        REGSET_IOPERM64 = REGSET_XFP,
        REGSET_XSTATE,
        REGSET_TLS,
        REGSET_IOPERM32,
};

This has been so since the original regset commit (325af5fb1418).

Unless I'm misreading the code this makes either REGSET_XFP or 
REGSET_IOPERM64 misbehave? What am I missing?

Thanks,

	Ingo
