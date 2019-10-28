Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39196CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A70214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TjSZDWhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfJ1S6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:58:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35367 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfJ1S6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:58:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id c8so7527732pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fUjCn4Cs3vWoZSNWz7xz1odhXxITVOufrvXvl689LIk=;
        b=TjSZDWhpawWLvh7U9yF8Z3jUBz830zCPqkTwFPuCzqYXztKH80ZIskPCrsn1pHaNKG
         AhI81kWQyaSPVqrGKZ1kwltiruez+QL5qTqXqBzO5QDgV0kKtx+rqhatn2X++XH8UXVQ
         9Ik+Xwa6jMrh08hhFLROmv2BHy9Zov3o3Ke5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fUjCn4Cs3vWoZSNWz7xz1odhXxITVOufrvXvl689LIk=;
        b=pCKT15jgqM2Ftg+zIimyaVGNAU3BNgpRGTQIuzLb9m+cnnSegJw6v7aTzVXE6dNNZf
         YfP53yx3cuP/y/ynj5SOd2Jx8JUTc6x/uN5Yr/CH/3jB99oyhtGw6i/6GZXVVt7KFPNT
         gIFHieMtO67+3XaNEmQI/Y4PHPf647j9iN9OmtzBj6mQh2N81jMFnCflPfvFyk/LSCMm
         G/fVijNPwgScA3QGan6odypqTChb8vSvrBvfV0ZKYVX0LU6vzwL1uWEzxHBpf/yLbgao
         iixns0/9mbePo4BqTWl+4nh01rkE5CBEzVt6KHT68m8CYkwtwSq9LatqABk8Z9i0Ho05
         bapg==
X-Gm-Message-State: APjAAAVeP1ETup/b5k1O92JOLLq0AgEp6RL8N7CkHCMR5sbLzYD8mL+F
        hcKVaUwVp5Px/xGk//FShPYvsA==
X-Google-Smtp-Source: APXvYqyMepkBzsGxf9eX0q3ivDMIAoXyY+PgaQqUh401V51bq90DTnS94G1EEZn8uzIzt20yGwae6g==
X-Received: by 2002:a17:90a:d58f:: with SMTP id v15mr1010425pju.17.1572289116194;
        Mon, 28 Oct 2019 11:58:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d14sm13531892pfh.36.2019.10.28.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 11:58:35 -0700 (PDT)
Date:   Mon, 28 Oct 2019 11:58:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        zhanglin <zhang.lin16@zte.com.cn>
Subject: Re: [PATCH] kernel: sys.c: Avoid copying possible padding bytes in
 copy_to_user
Message-ID: <201910281153.7B6F79DBD@keescook>
References: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
 <alpine.DEB.2.21.1910270644590.3186@hadrien>
 <92212e57d45f4410be654183f5dcb1e98d636ef2.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92212e57d45f4410be654183f5dcb1e98d636ef2.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 03:47:21PM -0700, Joe Perches wrote:
> I think yes as at least it makes it consistent.
> 
> From the link above, as I understand the __user
> gcc extension here
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c61f13eaa1ee17728c41370100d2d45c254ce76f
> 
> gcc does not clear padding from initialized structs
> marked with __user.

It seems to depend on how complete the initialization is and/or how
large the structure is. AFAICT, based on the tests I wrote[1], if
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF (or ..._ALL) are used, even padding
will get initialized as long as things are in memory. (And the same is
true with Clang under CONFIG_INIT_STACK_ALL.)

> Though that doesn't force the compiler to not
> perform the possible register optimization shown
> in the first document above.

Right. This is the only case where things aren't clear. I haven't been
able to build a test where "store in registers" behavior is tripped.

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/test_stackinit.c

-- 
Kees Cook
