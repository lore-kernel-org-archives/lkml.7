Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA3BC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4831F206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lw2YNlQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389740AbfFJUkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:40:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41503 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389429AbfFJUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:40:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so5633058pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1bIiiq1tcSBUPb0mAkHhzOcciNt5GC9EVK4d9EOEoME=;
        b=lw2YNlQl9J026XmcbaLozeN5ncERuzyxgk3W2IJmIUEfKS9rgQ3vYBPtyqQFCQ4Scf
         i9jwBI5eZjVn9/APiXXX06/J8TUwr6y+5e92FWMCfExwClayFUOopY7C9sRun53l8kgk
         exQCzEWyXRXRSf9g4uBdFCIxgYBuvJ2hF67No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1bIiiq1tcSBUPb0mAkHhzOcciNt5GC9EVK4d9EOEoME=;
        b=BdH3tFCw1dmEYoXZZ04zrgD6LcTzlJZ3qlT1xM6nSVC9n92z8M2fdPN002CsTJBhKN
         LRE3Qf7QlIfLjQN3U5RnEsh0+WpNeZqvnLNbrp+/bFT2857S0Lc6sFNubcbxLnWLRkRB
         FRzV6ExLADURKTDU69Zkt2l2ot9eaBNw5r3H0Mgg+ovmGSo4pZ7jC7slzN3GS4XgK6jR
         dWyPJXbAYKmwJXS/H0OcjJzijhfod/1Mh6QL+HVlNyCgMdbLcj5GkTNnqmVmFEIvLgXr
         Q0RbeEpWFmYe7MNWSbyHKDIx64Crt86iU1tPUU/PCclyABkMnKSi7Fh3CZx7aZqeFw+L
         8QYg==
X-Gm-Message-State: APjAAAVzS1o4REAcqsQDvNgWkSRufQIsrCB1Dw8j3UT4Ih0zcia6BwKx
        J0SeL6o6l6X6NtKuiNiTUp/3UA==
X-Google-Smtp-Source: APXvYqyDpLSLCPFjQ8zmnGSsAdX6zCWwCbBUcpH9JlOpZMO3AtcTW7iMbM33HkmVPQwrXtDu0u723A==
X-Received: by 2002:a17:90a:5884:: with SMTP id j4mr24062347pji.142.1560199254664;
        Mon, 10 Jun 2019 13:40:54 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j14sm11580888pfe.10.2019.06.10.13.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 13:40:53 -0700 (PDT)
Date:   Mon, 10 Jun 2019 13:40:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/5] x86/vsyscall: Document odd #PF's error code for
 vsyscalls
Message-ID: <201906101340.AE18F49@keescook>
References: <cover.1560198181.git.luto@kernel.org>
 <d28856fff74a385f88c493dafb9d96d2c38d91a2.1560198181.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28856fff74a385f88c493dafb9d96d2c38d91a2.1560198181.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 01:25:29PM -0700, Andy Lutomirski wrote:
>  tools/testing/selftests/x86/test_vsyscall.c | 9 ++++++++-

Did this hunk end up in the wrong patch? (It's not mentioned in the
commit log and the next patch has other selftest changes...)

-- 
Kees Cook
