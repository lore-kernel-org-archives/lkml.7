Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D106C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF3C21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554457178;
	bh=q8ppD7fONJTYH9tYsRYyZ9fO15YN0ixidcNDOhm5oJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TQshmfFoldrX2/1wLF7Drq5qJqJqNu/g/AbeVzkZ4Gcj4kylpz3GeyuJ8rPHXcdQh
	 CDKdotkZKFu9AwQ/cSW7X3CD+j133on/KXiwn/9k12olV8eLzqOK9npWpth0EnX6h+
	 TMgR21ko4WcT9VdFePjAsQudtyJXyNlZxW2S5gUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfDEJjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:39:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56295 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfDEJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:39:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so5932507wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1LXiJ0QPA05IIiuQ2NKOQ/jZe2/w58stT3y1pV+JVeU=;
        b=umh9E28K1k1LL02ooaoSQ2I3MuMoFUusX61n9b3AC3osShBlCvYdlMgEBa4a9HkVVH
         SpVfiJOt5ydoJQrVe5aLsTGqnygOR5g6QMio+ztza1xZl0NhdyJZ0X44T0SoqQ+KHukm
         38jsyh1gOKhMUsHSNISIrQ10JQQ6yke4uriNNusGdebAZCXhFqrh7f/iCWodLiU5cEIK
         XKgqWuZPV9/WVdg3GX9dK7DCQGvV5ZwvqsogoFvyRfbMggXEdS/Qs9oJe6yOJukqhleN
         2s6zyWkkQGKnjDQ23zHJQTyRb862/9QDX5r2QItzY1lxxInA2QdJh/uRm5qhKddVDQ+H
         0FCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1LXiJ0QPA05IIiuQ2NKOQ/jZe2/w58stT3y1pV+JVeU=;
        b=rH3RQHIxXvCq5NTXpFEFa4G999lzh1WScxvTInNjo7+b/bKYzKy+JuyPuxdptNIYJP
         MWE1WrncwDrUBI1xb8hfyrCr9tZSB8VrwJGE9CxLCPNzEsJE9v/uSQJ1FnripqpHjPGZ
         mg2XTJCudXSE4dV+mjl92VO8nwbSPLvUgu4yXersan5GPviL/O0ZbNTn7ua2jHAelyJe
         X8a5qGDdKYw0YzKYX7+1nXmao5+gn/qgWDYKUtPHR0Q/76oWldyeEKmvx2V+G1AcJWSw
         rG32VYxXt+PTdcnCTD/nNxeOALfCONpTH8DzchPc/O9F136hELvUrzyF25rCZAnaf7O0
         MhqQ==
X-Gm-Message-State: APjAAAUrPZRWnNo0S+44ps+pX7NSRAbm97pNdO2ODhmHdy/1+z50jI6/
        kd3x/gDAdK7J5x7Z6Neh2nECfSZp
X-Google-Smtp-Source: APXvYqzRYHGt3m3IY54Opvw2qmj8Y8K9M0KqfmTjf8wKO1gVpHWRVdwRv64NBl8VByPb/OTOBqurpw==
X-Received: by 2002:a1c:495:: with SMTP id 143mr6728641wme.78.1554457174545;
        Fri, 05 Apr 2019 02:39:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p3sm29314252wrx.71.2019.04.05.02.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 02:39:33 -0700 (PDT)
Date:   Fri, 5 Apr 2019 11:39:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     paulmck@linux.ibm.com, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        jyknight@google.com, x86@kernel.org, mingo@redhat.com,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/asm: fix assembly constraints in bitops
Message-ID: <20190405093931.GA28890@gmail.com>
References: <20190402112813.193378-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402112813.193378-1-glider@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexander Potapenko <glider@google.com> wrote:

> 1. Use memory clobber in bitops that touch arbitrary memory
> 
> Certain bit operations that read/write bits take a base pointer and an
> arbitrarily large offset to address the bit relative to that base.
> Inline assembly constraints aren't expressive enough to tell the
> compiler that the assembly directive is going to touch a specific memory
> location of unknown size, therefore we have to use the "memory" clobber
> to indicate that the assembly is going to access memory locations other
> than those listed in the inputs/outputs.
> To indicate that BTR/BTS instructions don't necessarily touch the first
> sizeof(long) bytes of the argument, we also move the address to assembly
> inputs.
> 
> This particular change leads to size increase of 124 kernel functions in
> a defconfig build. For some of them the diff is in NOP operations, other
> end up re-reading values from memory and may potentially slow down the
> execution. But without these clobbers the compiler is free to cache
> the contents of the bitmaps and use them as if they weren't changed by
> the inline assembly.
> 
> 2. Use byte-sized arguments for operations touching single bytes.
> 
> Passing a long value to ANDB/ORB/XORB instructions makes the compiler
> treat sizeof(long) bytes as being clobbered, which isn't the case. This
> may theoretically lead to worse code in the case of heavy optimization.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: James Y Knight <jyknight@google.com>
> ---
>  v2:
>   -- renamed the patch
>   -- addressed comment by Peter Zijlstra: don't use "+m" for functions
>   returning void
>   -- fixed input types for operations touching single bytes
> ---
>  arch/x86/include/asm/bitops.h | 41 +++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)

I'm wondering what the primary motivation for the patch is:

 - Does it fix an actual miscompilation, or only a theoretical miscompilation?

 - If it fixes an existing miscompilation:

   - Does it fix a miscompilation triggered by current/future versions of GCC?
   - Does it fix a miscompilation triggered by current/future versions of Clang?

 - Also, is the miscompilation triggered by 'usual' kernel configs, or 
   does it require exotics such as weird debug options or GCC plugins, 
   etc?

I.e. a bit more context would be useful.

Thanks,

	Ingo
