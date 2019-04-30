Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5051C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF7D2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JywicDci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfD3QoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:44:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33115 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3QoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:44:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so21891794wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6a++kp7rZSqO56147GgKvyNl/WmQw5p2F4HTj/YvBwo=;
        b=JywicDcin0PEkXHlmOEx44gGwJpwcMFiLKCQpuSba8BdnyTjTAX37whDXyUIhYNhGT
         kj2wkan4ypqehPT7qsZYHXCn0+XciKhB28IqcMs/HskCH+WmFvuXj9yszN5TPu6JnYKL
         KV1EAiv9jORb17I8fAFZGUTxDD7rtPMeqQXyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6a++kp7rZSqO56147GgKvyNl/WmQw5p2F4HTj/YvBwo=;
        b=DxMgQJasgG7cvEwJv/lmYdYAY7ZY51nB08wTBB7HAapUTmPhCm48QKlJGA4pNe0MCG
         u3IR3cX+z1Ea6oxBrCkQNgtbgIiTSE6Bk/oozTceOqnJC6BRi9JcT//DBxMGJ5BhKiwp
         SD6EBbhtK5notv5i+L1eZATTtprl0sSJleyxS4eQuZ3MerLDKGkOQNAhfO+Zt5F+Mofc
         XAIBTXRkJ5IexwLaJttHkkKtaUrobydC9om5DE01eW4eGCMGULnq2uKq5olT8qvAHR6s
         k9e78j2hzpEuyTvHRAnLO39Dm9kzHyNgmIxhaTwCjU+3DE+N43zkO8eRnB0BcaRXPQWV
         CXCg==
X-Gm-Message-State: APjAAAUfu/wXlzDs9PGyez2+7OTMsvvx9HMFzkQTjuju7UGw2RyFKkzE
        gtGAXRjXlrV+CbmNbEb36BhqfA==
X-Google-Smtp-Source: APXvYqzZbd2cX5Tr5rnUMve5xnVuO9DAJcSN7xGBIxQ6aP1xQ+hevgOaENY/AI/qdh9k1nYV3ndV7A==
X-Received: by 2002:a5d:408e:: with SMTP id o14mr12597110wrp.318.1556642652888;
        Tue, 30 Apr 2019 09:44:12 -0700 (PDT)
Received: from andrea ([37.227.24.188])
        by smtp.gmail.com with ESMTPSA id z15sm26391666wrv.80.2019.04.30.09.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:44:11 -0700 (PDT)
Date:   Tue, 30 Apr 2019 18:44:04 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/5] Fix improper uses of smp_mb__{before,after}_atomic()
Message-ID: <20190430164404.GA2874@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190430083409.GD2677@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430083409.GD2677@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 10:34:09AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 29, 2019 at 10:14:56PM +0200, Andrea Parri wrote:
> > Hello!
> > 
> > A relatively common misuse of these barriers is to apply these to
> > operations which are not read-modify-write operations, such as
> > atomic_set() and atomic_read(); examples were discussed in [1].
> > 
> > This series attempts to fix those uses by (conservatively) replacing
> > the smp_mb__{before,after}_atomic() barriers with full memory barriers.
> 
> I don't think blindly doing this replacement makes the code any better;
> much of the code you found is just straight up dodgy to begin with.
> 
> I think the people should mostly just consider this a bug report.

Bug, misuse, patch, and rfc seem all appropriate to me in this context.


> Also, remember a memory barrier without a coherent comment is most
> likely a bug anyway.

Right.  Hopefully, the people in Cc: will want to shed some light about
this: I know what these smp_mb__{before,after}_atomic() can not do, but
I can only guess (I won't!) what they are supposed to accomplish (e.g.,
which mem. accesses are being ordered, what are the matching barriers);
maybe this can also justify the "conservative" approach presented here.

  Andrea
