Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA98C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3791D257C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbrEx/lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfE3H6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:58:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34381 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfE3H6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:58:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so4271076lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 00:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bPRq+E2M4k4dnnJqaH6HZOTnuL1bcV5ql1EtUHn1F7c=;
        b=GbrEx/lj/tDGSeKBw7jDjiLis2BVHIGcW6qr1MHD62CyU0PWV+NYSxqfD4VoPaIO0q
         a66gvf/i7IzTVZlCJjXio7STBZ1YyAqLM0WoBtO+TwcWxiS3VSKThlcKnVgNGoqBiukN
         RiJvQ7jJ+yFLZ8l57FQWW+kFP4Nw1lFyoMAq8Bizf8/AMy2bF2h8ZdY5d1GCfxmEYXrN
         sY2sU4QRQbWshpSXRFZfK4zBWrh3+6Aws2nE4JRvSJDJHooStJ1nUJdOOMAncs07Pt/q
         2IlDYChz8p7KROUlM5m2PnG5mS/QQA9w5f9ZMifk8l76Xl6TGOjyptTaT9vusb1Cu9XL
         sjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bPRq+E2M4k4dnnJqaH6HZOTnuL1bcV5ql1EtUHn1F7c=;
        b=qfzxBWr98IqpwSsSdfrv1ENKwaNqtdfqJZsGm/4iUTPfLVbHf7SME3kHkuDQTOMXci
         UEgjxY/AdUpvMDzi3JC+Hu0rfzGSiTrXnLkFvahf8ZqR8HC1EEI7FhvsC/nW+8s6njkV
         RZYcvEt2ycDdQS0eeLm7OKNAkY4h9Bgizs1KO1ksXlKMhTB08DoPXExUGAtsSW2WAwCG
         28iXLTrAO4UF+RypdUdvpO+H2cDJ5+WtTyvAcAueo26HbK9/annhq27t9E9ZMC4cVyEB
         iDzKaskNCtEqGZCqCv3ahKhhBzmyY0ga+N3cfPSGeKamg5gbdfmPtKPoKnOFlKNPQU06
         S67g==
X-Gm-Message-State: APjAAAWQY+HRs8jZd0esgEPJjlIT+CicWacWLtucNb2hcWCXsYZS5Hev
        VmPeI1Y2foks5hycb12gB9E=
X-Google-Smtp-Source: APXvYqyc9i3ZYnrQp2KnqOu0K+AzfZb4LKFfGO1IQXISkfsMxRFTr8AaNX3JTxmvX9YXkBJJgNyYbA==
X-Received: by 2002:a19:fc1d:: with SMTP id a29mr1395727lfi.35.1559203083598;
        Thu, 30 May 2019 00:58:03 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id r2sm349338lfi.51.2019.05.30.00.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 00:58:02 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 0A7324606B3; Thu, 30 May 2019 10:58:02 +0300 (MSK)
Date:   Thu, 30 May 2019 10:58:02 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/sys.c: fix possible spectre-v1 in do_prlimit()
Message-ID: <20190530075801.GV11013@uranus>
References: <CAFbcbMATqCCpCR596FTaSdUV50nQSxDgXMd1ASgXu1CE+DJqTw@mail.gmail.com>
 <20190528071053.GL11013@uranus>
 <CAFbcbMAi_QhoT=JyU6NjNiJJwFbXF4Z1eV8TtfLv9UWJT-K_CQ@mail.gmail.com>
 <20190529121831.GU11013@uranus>
 <CAFbcbMCLwoBB8syLCSU8i0Hc7OMnHT4A+AzWdmF5g9BzbY7CXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFbcbMCLwoBB8syLCSU8i0Hc7OMnHT4A+AzWdmF5g9BzbY7CXQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 01:45:16PM +0800, Dianzhang Chen wrote:
>
> Though syscall `getrlimit` , it seems not works after check_prlimit_permission.
> 
> And the speculation windows are large, as said[1]:
> >> Can the speculation proceed past the task_lock()?  Or is the policy to
> >> ignore such happy happenstances even if they are available?
> >
> > Locks are not in the way of speculation. Speculation has almost no limits
> > except serializing instructions. At least they respect the magic AND
> > limitation in array_index_nospec().
> 
> [1] https://do-db2.lkml.org/lkml/2018/5/15/1056

Please, stop top-posting, it trashes conversation context. You miss the point:
before bpu hits misprediction we've a number of branches, second in case of
misprediction the kernel's stack value is cached, so I'm not convinced at all
that teaching bpu and read the cache is easy here (or possible at all). Thus,
the final solution is up to maintainers. Another reason why I complaining about
the patch -- it is not the patch body, as I said I'm fine with it, but the patch
title: it implies the fix should go in stable kernels, that's what I dont agree
with. But again, I'm not a maintainer and might be wrong.

> 
> On Wed, May 29, 2019 at 8:18 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> >
> > On Wed, May 29, 2019 at 10:39:52AM +0800, Dianzhang Chen wrote:
> > > Hi,
> > >
> > > Although when detect it is misprediction and drop the execution, but
> > > it can not drop all the effects of speculative execution, like the
> > > cache state. During the speculative execution, the:
> > >
> > >
> > > rlim = tsk->signal->rlim + resource;    // use resource as index
> > >
> > > ...
> > >
> > >             *old_rlim = *rlim;
> > >
> > >
> > > may read some secret data into cache.
> > >
> > > and then the attacker can use side-channel attack to find out what the
> > > secret data is.
> >
> > This code works after check_prlimit_permission call, which means you already
> > should have a permission granted. And you implies that misprediction gonna
> > be that deep which involves a number of calls/read/writes/jumps/locks-rb-wb-flushes
> > and a bunch or other instructions, moreover all conditions are "mispredicted".
> > This is very bold and actually unproved claim!
> >
> > Note that I pointed the patch is fine in cleanup context but seriously I
> > don't see how this all can be exploitable in sense of spectre.
> 

	Cyrill
