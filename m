Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C4BC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC06821738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="CVrjjQ79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfDWSpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:45:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35499 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDWSpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:45:43 -0400
Received: by mail-io1-f67.google.com with SMTP id r18so12659446ioh.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=PpIY/pcnE8PBkyei4ABYv/OQrwv3IcaKyfbDF2jVX5Y=;
        b=CVrjjQ79twfN3qUGnu9RF9vLUZRZgnnyGEY9+HC4F/AFQ6h7/TWGxXKvY9e2McBiv1
         1tpqkCl5PTZtO/dqZSEfXrqjW6xrVYCOr8kXHv3uYKS4JzKGlFdDnr6sGpeGCxF0WBoN
         R4FcruV/ul0RmcXQvWtueX6jaZibLjqR1uM4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=PpIY/pcnE8PBkyei4ABYv/OQrwv3IcaKyfbDF2jVX5Y=;
        b=EYSx6fIN+SELXS+81Rd9DlhvEKlLuEqQAOxvmk89HaFAx16SI73ziUOe1ctHKTNZtN
         cj5JDmbizBpoDkl/4auO78eT8Fpd8jGl1GwA4f0LHKntXAEuiNCCmZMPKxTkk6K2wwtP
         450HpFUh86gvDXV6dS1GIIYUV7Z7DXTfuDI3DDiAVc22oDyRJCPcYQwGYupKec44+FFo
         7Ii7ePNYosQNo2E6bINmrLY9ZmkGm48B2PiEQFyb5+G6esfOuKLWhTYFs7xMJ7sPFb0l
         EvvZsMZUBlhgjK0cTxpGHqOVTrxN+aP/Tu1Ty5toQxBdvAC8JWhfyHyN1iEQVs5N5Alx
         +giA==
X-Gm-Message-State: APjAAAWa7kkwfs/+4z69VSHlroONU1j8hszpHK9q2DGYjspfHLaDyKZV
        p8hX60ji3fE/E+kDd8s6yYIpaA==
X-Google-Smtp-Source: APXvYqxiNo3NI2pEyiLFV4zIgDZnYuZDR3NysCSKEZjvMGjMjqkJEFoI5uh5jSmSwW22RGDJ6Av7fg==
X-Received: by 2002:a6b:6909:: with SMTP id e9mr11910764ioc.208.1556045142479;
        Tue, 23 Apr 2019 11:45:42 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id n199sm8075806itn.34.2019.04.23.11.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 11:45:41 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Date:   Tue, 23 Apr 2019 18:45:27 +0000
Message-Id: <20190423184527.6230-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423180238.GG22260@pauld.bos.csb>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> - Processes with different tags can still share the core

> I may have missed something... Could you explain this statement?

> This, to me, is the whole point of the patch series. If it's not
> doing this then ... what?

What I meant was, the patch needs some more work to be accurate.
There are some race conditions where the core violation can still
happen. In our testing, we saw around 1 to 5% of the time being
shared with incompatible processes. One example of this happening
is as follows(let cpu 0 and 1 be siblings):
- cpu 0 selects a process with a cookie
- cpu 1 selects a higher priority process without cookie
- Selection process restarts for cpu 0 and it might select a
  process with cookie but with lesser priority.
- Since it is lesser priority, the logic in pick_next_task
  doesn't compare again for the cookie(trusts pick_task) and
  proceeds.

This is one of the scenarios that we saw from traces, but there
might be other race conditions as well. Fix seems a little
involved and We are working on that.

Thanks
