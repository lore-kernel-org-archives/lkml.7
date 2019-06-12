Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73535C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4365721019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="D1PZYPLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408335AbfFLQHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:07:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38216 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406078AbfFLQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:07:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so16960819qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cu3Bb6FZyhJzR54vRUfsJH6eJeevJkiGlOgrBDKMJZY=;
        b=D1PZYPLIOLDvCgCcePFLGP3Tt494J3J+QkMBkvlFMUiFQbQxxN/dXxIYTnB60YMySp
         IJB2SmyDdC/Ir0cfoEFmyA2J3B2DkVd9MUTQUum5oigc6vHgApFEqPWKT+WxzFnZbWdP
         uY1goooHNQAu5B1wnqc8WKNeDa1Z4B1dsa9bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cu3Bb6FZyhJzR54vRUfsJH6eJeevJkiGlOgrBDKMJZY=;
        b=KC9we60f7MIKWPbmgPOHmTrkzgs87Hx3O596rBQ68WMnRWtnwNxjDplMPcFPmSSZCN
         k7+qt2s+SBFit/DDGrYHXnOVZj/1hdY3g6mEzjykOXxMiJJo1n19NiG9GDWVE28wgL3w
         xqHtIJoKhoB4EL2nu5v4DnJr8ZOkwyCdw3mdlCBCV+mFk3m0ra3dOUCI1ZpOB5Wrkm+Q
         77mswx6KUc9ntS9tsyJQrqnHx8/WVWHXih2L/IUoWe1jb4HZuFBx+j+F5D2hDYsgjEPz
         uyXno8E//36qRBrLqdrEzdbFjbdvPXl2VpGF9ZvJmtt0zCVn7iqxncUzjIK9WJT8c2rf
         /Bww==
X-Gm-Message-State: APjAAAV0DETGvkYzFt5jU60qfVRxI5HJGZiPC8OUbzJizkWAn+87pvxB
        ZoCY1254xO0fPwF8HM6bSF/3cw==
X-Google-Smtp-Source: APXvYqxRSkiZtxZjXlKBCTnqbclLJYBUiQ+1RhoCZcqQLHfVO3aMRqt+tS2hnloafUf78lsB80eCJQ==
X-Received: by 2002:ac8:2b01:: with SMTP id 1mr557959qtu.177.1560355627366;
        Wed, 12 Jun 2019 09:07:07 -0700 (PDT)
Received: from sinkpad (modemcable060.224-21-96.mc.videotron.ca. [96.21.224.60])
        by smtp.gmail.com with ESMTPSA id 34sm133332qtq.59.2019.06.12.09.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:07:06 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:06:58 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190612160658.GA26997@sinkpad>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad>
 <4bd9a132-bbdb-ec45-331f-829df07a7376@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd9a132-bbdb-ec45-331f-829df07a7376@linux.intel.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The data on my side looks good with CORESCHED_STALL_FIX = true.

Thank you for testing this fix, I'm glad it works for this use-case as
well.

We will be posting another (simpler) version today, stay tuned :-)

Julien
