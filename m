Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D25C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AA020850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555144202;
	bh=p1Hkhv8L+MuNLna73fhtsoPJAqq82wOeN1hMrkMT6S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=psYg4H6ZXKuxBDdttwFQ/2KDUOAu1NMU4kqKCiE8i8XdlOURVegjB9ITcuHLu5lj+
	 q/tDtnS0dLevCT/IT75DoXmNKMng7j88arXmt1UzrrwKoBypk//cZS3xKcAIuy17CU
	 tr93/xT41L8x5jweBLMbGpdeRwUBOEN2NFwYO4Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfDMIaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:30:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53049 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfDMIaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:30:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so14004628wma.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KgAZrV6SspS62xB0xf6VpIe575sRdFUDvLiqOuk6AAA=;
        b=ePNJHtdmcaEBXaKUvTEzOB4q9+jH8fWW/wOPO79QxlcJxn0KN68tIhevtavURma7Ev
         vqFCa0l199zLWhx16Sd8FteyHRryqXRji4z1Z69EaBlksuL5MQ+CNwY7BgrXho9AQ3Qu
         CMICeUAkkVqejABXjvvzAPhRqowVYrs/6HMAjl47XrL+O1hF08Ris92bxy3jMNbqw8GL
         3KqF9ihdqa06JRymPYNQdciR9SiJJ/NV95aPV/fKtQKGR61qPXU7cDhdwmtc6bfFqTUk
         KXS/XpE5UTz/gfAgJCcv+80O9DlsxosHiO7Du7rU3e5nq9pVbdV0/Gub/nSRqGtLT/BB
         skWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KgAZrV6SspS62xB0xf6VpIe575sRdFUDvLiqOuk6AAA=;
        b=NIXnXPsiQ1SqcTDE70Ya6pK25/LpZsp8mXBA56NkMuYJJFhcHpdZNIp2wAZY6/dFJs
         PsbUU7WuuoMt5qLEu+OqEk4mv9GX9bMY/cH8VDWwxHEVFhF1wAGXeWs85uyujqws6mDf
         sSHa7Y8rHNzFzNYpLR4EaeiE9sDyHUq85elwOffaLxt+ZAUt5Q7Ep8MB5O1XM2eM07Zu
         unu+aBAZug/FZPVIVEZlILWiHyzr7vFFFYGprkeujPXnCV2S6jJ7QvEt9D+TWWe6BhW/
         ruQB867KSpcrg/hk0ML42xm6GL+zRmDT3Ga7QqndUfzrfze2JkRc4XFl+HEpZMFfOvLu
         +skg==
X-Gm-Message-State: APjAAAXLwmRfGzL0Y84e2hKxZw8qV01HACjMLDUEY+pMwnP1m/wh0Yrw
        UWVhLetG7DLyc9BerRS8gjpd0S+n
X-Google-Smtp-Source: APXvYqztXYw7Vf+wu0fYetqu0Rn55DgbTLzzxHcOupDB2VAevNL4e856DtVm8YdiGBNvx1e9aavslA==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr14659036wmj.41.1555144198900;
        Sat, 13 Apr 2019 01:29:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s18sm12334973wmc.41.2019.04.13.01.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:29:58 -0700 (PDT)
Date:   Sat, 13 Apr 2019 10:29:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>, shenghui <shhuiw@foxmail.com>
Subject: Re: [PATCH] locking/lockdep: Make lockdep_register_key() ignore
 'debug_locks'
Message-ID: <20190413082955.GA112331@gmail.com>
References: <20190411172612.39180-1-bvanassche@acm.org>
 <20190412054719.GA80743@gmail.com>
 <1555083162.161891.83.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555083162.161891.83.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Bart Van Assche <bvanassche@acm.org> wrote:

> On Fri, 2019-04-12 at 07:47 +0200, Ingo Molnar wrote:
> > So why don't we add a debug_locks test to lockdep_unregister_key() 
> > instead? The general principle to bring lockdep to a screeching halt when 
> > bugs are detected, ASAP.
> 
> Hi Ingo,
> 
> Since this issue was introduced by patch "locking/lockdep: Zap lock classes
> even with lock debugging disabled" and since that patch is in the tip tree
> but not yet upstream: do you prefer that I post a version 3 of that patch or
> do you rather prefer that I post a follow-up patch?

The crash fix is now upstream, mind sending a followup patch for the 
warning fix?

Thanks,

	Ingo
