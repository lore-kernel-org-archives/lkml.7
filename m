Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA370C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23D4214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="UTNQ4lDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfFSSdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:33:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37167 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:33:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so209534qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qmdp2hLc7f7LXlGpZWzREus9GL3q2Z2GGo4gIgm/xrg=;
        b=UTNQ4lDMM4HOUZwz/VfVoBWVf9YyGjTc27oNXdkMUoFx+YvLAYq/PahbGAidF4op0x
         6ADkzk5HjWEqAlcrNdPOCZFkMjM2Gegh3w6x3/7qSMw+z+lY20Gn93gLzGc68/TIxYpH
         8KVLZH1Lg0cImTyKxEP04zb5/hheamoBeD7jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qmdp2hLc7f7LXlGpZWzREus9GL3q2Z2GGo4gIgm/xrg=;
        b=WlNgYfpiOICc9MYn0DqqTYJ06r1tQYF8rpW31sI1pETEqjYr4yt9jEVI98c4WDo3BJ
         NsAoxV/rTdgfyfNQmwXWPwthsX5pP724KS82zN0oYxGPJgb9XmSMaRKZXW/YT37YiW/m
         QNCk3zhYmKnJh9xtKnoESSUxMFpAZ9t/WY+CedOxvbTeUFrUADs4J4o7FloTWG6SIC8z
         drVtolxkDHbKSH8o/7+0QsR5xd/s1PygJ8XOr3yvC7kAT3Q3nYffmVc4jskIMwi6+B5q
         1ECmvOaBBHcK1eJpBnoTz+YxkJg4y+7g3NwaMvfZY8TLT9gvwi6Kc9fAL/t0//+2/KUr
         GBvg==
X-Gm-Message-State: APjAAAV3F5fL33+/x/cWn0xTIGs2giHTuEndy9xBCgdlonTUMudn3bJ+
        dWKprawpeIUjFbTYD1Rial4Z4w==
X-Google-Smtp-Source: APXvYqxPjcl2hWZP3R+bxalVB3SIb1aKDnmCr+tkSn8M7rbe2IFhnZU1zIJliIIbYegdX1zWks4CSQ==
X-Received: by 2002:ac8:25ac:: with SMTP id e41mr21132667qte.101.1560969192340;
        Wed, 19 Jun 2019 11:33:12 -0700 (PDT)
Received: from sinkpad (mtlxpqak-1176247880.sdsl.bell.ca. [70.28.30.72])
        by smtp.gmail.com with ESMTPSA id d123sm11973097qkb.94.2019.06.19.11.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 11:33:11 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:33:02 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190619183302.GA6775@sinkpad>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-Jun-2019 10:51:27 AM, Aubrey Li wrote:
> The result looks still unfair, and particularly, the variance is too high,

I just want to confirm that I am also seeing the same issue with a
similar setup. I also tried with the priority boost fix we previously
posted, the results are slightly better, but we are still seeing a very
high variance.

On average, the results I get for 10 30-seconds runs are still much
better than nosmt (both sysbench pinned on the same sibling) for the
memory benchmark, and pretty similar for the CPU benchmark, but the high
variance between runs is indeed concerning.

Still digging :-)

Thanks,

Julien
