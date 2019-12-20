Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA21C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B1F206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxfCWkPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLTTA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:00:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35345 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:00:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id i23so288412pfo.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qumAg5ZZqnmgCZCuhulClxZDmH0MbZ40eJLFhdo2hpU=;
        b=lxfCWkPK7mnoOd1RwFHaRDonZ5VxLArlKVp7F57t2lHc4rWbno7lCzzxcUz7wk8iXf
         1AQvsI1ccmmZ1eoVsGZfk2H0lQvvu+7/xqS2yxYrhdtyR4mIFYuT8PMXUbpdfjXnZzhy
         lFWtgVXjeQXtPzDjw+nltjgFM0NcxTy2AFdSo4DYIvEAF/o7guRj3ifCD45msYpdHEiJ
         1uYuQvvh+Vh5Oqqj0ArYhPTrauYfKWCTLea5D2FScKck/1JcivwDgDhe5E6mowmZrIWp
         hjQh8RKKz3LmuOuamPi43XAxiirgjYq3Dw6VNhVzU2JCuT7Ocnyc5hqYDQz660RDR1y7
         0bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qumAg5ZZqnmgCZCuhulClxZDmH0MbZ40eJLFhdo2hpU=;
        b=hDU5z1L94uxJCNRiz2jgW8GYWoDoUM9pNmbaaK3eErjb/wgVTddISkwM3n2XCIlFei
         m2Jm1U3azyJFLuRbSJ/3/H3b0myRHI0iAWE2cavhtoQ7E8F8Ym4iCKKsJBb5o+MP3iZw
         FpCySXHbluujgO03aY9OWwp6w0msp2YkxaC1GqspLvpk7GrNvsAaXJ9BqirxWjGMNEhb
         YU9H2/+KghLgzDof6qoq+JWVjGX/yfpGzWVKWmXGNaWpvpEIkC8Hjew2+KJ3Lhf1sVze
         j73tpBXn6rwBws26NeTvUTWblkkzHMCsOriGinbQ9cE8n1pkAvBMLYqn9GTDgFymH2TF
         ExGA==
X-Gm-Message-State: APjAAAXBPhdPVBYoJkPjlC5321fv4X68eYCCHJX5hWHyVzsagwhH1ljv
        TRb/raQ2fhj2e7ivx1hFIbJHK+iVmNQ=
X-Google-Smtp-Source: APXvYqxWsFbzD0XdxpwBzRbsDI5smchKZAtjtiaH3vTy0YlcE6npaLjwitypANGqcq8AWJZq0rnAzA==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr17989319pfg.51.1576868457602;
        Fri, 20 Dec 2019 11:00:57 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b98sm11212497pjc.16.2019.12.20.11.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 11:00:56 -0800 (PST)
Date:   Fri, 20 Dec 2019 11:00:56 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Daniel Axtens <dja@axtens.net>
cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ajd@linux.ibm.com, mpe@ellerman.id.au,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] relay: handle alloc_percpu returning NULL in
 relay_open
In-Reply-To: <20191219121256.26480-1-dja@axtens.net>
Message-ID: <alpine.DEB.2.21.1912201100400.68407@chino.kir.corp.google.com>
References: <20191219121256.26480-1-dja@axtens.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019, Daniel Axtens wrote:

> alloc_percpu() may return NULL, which means chan->buf may be set to
> NULL. In that case, when we do *per_cpu_ptr(chan->buf, ...), we
> dereference an invalid pointer:
> 
> BUG: Unable to handle kernel data access at 0x7dae0000
> Faulting instruction address: 0xc0000000003f3fec
> ...
> NIP [c0000000003f3fec] relay_open+0x29c/0x600
> LR [c0000000003f3fc0] relay_open+0x270/0x600
> Call Trace:
> [c000000054353a70] [c0000000003f3fb4] relay_open+0x264/0x600 (unreliable)
> [c000000054353b00] [c000000000451764] __blk_trace_setup+0x254/0x600
> [c000000054353bb0] [c000000000451b78] blk_trace_setup+0x68/0xa0
> [c000000054353c10] [c0000000010da77c] sg_ioctl+0x7bc/0x2e80
> [c000000054353cd0] [c000000000758cbc] do_vfs_ioctl+0x13c/0x1300
> [c000000054353d90] [c000000000759f14] ksys_ioctl+0x94/0x130
> [c000000054353de0] [c000000000759ff8] sys_ioctl+0x48/0xb0
> [c000000054353e20] [c00000000000bcd0] system_call+0x5c/0x68
> 
> Check if alloc_percpu returns NULL.
> 
> This was found by syzkaller both on x86 and powerpc, and the reproducer
> it found on powerpc is capable of hitting the issue as an unprivileged
> user.
> 
> Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
> Reported-by: syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com
> Reported-by: syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com
> Reported-by: syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com
> Reported-by: syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
> Cc: Akash Goel <akash.goel@intel.com>
> Cc: Andrew Donnellan <ajd@linux.ibm.com> # syzkaller-ppc64
> Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> Cc: stable@vger.kernel.org # v4.10+
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: David Rientjes <rientjes@google.com>
