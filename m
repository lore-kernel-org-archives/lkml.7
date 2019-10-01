Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC4C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160CF2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="F4dDv2k6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfJAVB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 17:01:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42908 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfJAVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:01:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so10537084pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uYKxifQyI8LZAL0b+I59pyXeuVXwNstd2CD5JAIyVRg=;
        b=F4dDv2k6Cs43F0QIi/a/1eyYuvus2CAork56dBSxvs1UNAyVW/7wTsOjQlu3U8jhbK
         X2J2ce53E5QLL2j+inv1Ao2Vd+2fZWtDf5gF52lrddIvneL02g6WxA+0Xl5qHeo3mbir
         rD2lxbGuthFypdlVW10UuLLFJ6cytxxr34Z9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uYKxifQyI8LZAL0b+I59pyXeuVXwNstd2CD5JAIyVRg=;
        b=hZw2TtiUVHjJb6LTv2Pp/SrjlGQtRhmVyYnctuzV9AlOvMUBp0ekcAo3LtpwsOA3Ru
         XF2UVUXTwYtmkPQImM0h66cEQ9nkhNSU6N+x92GeJ8Tlv0yib+4NhuQbAjgJvU5jYAHI
         rCrsBw9cjG98tfEIU2rIg6nGPAj3IMvWaWCjThkXSiWYyIMTXYBuzZAJwZs8YR6wcIc3
         0asfdETVtlyfIHftpIVjXC0Y2E05ctQgTahyXECUbZMi2gK5oNiCRsuCb9VY/gCzb8mC
         CWfYCFHrpwDg5/gsBwT1+Tc+8bdo4QvowsMcrJdjTD6YMw7KQBOO5em+Ter6lteGKLGf
         4V0Q==
X-Gm-Message-State: APjAAAVznkJSDJolL7DTe+R4xtgqjggrPlvoe9T88Ay24wfvErsENmV8
        KMlDDNPSTl/LZFLg1P9ZnL3kVg==
X-Google-Smtp-Source: APXvYqzQF+OqM1NVJyzA7Dp7ll6y6jrAz7paipzr4igoOLdB+fUpwl+DgVsyghwH2mbKfoe7C8/KnQ==
X-Received: by 2002:a65:5883:: with SMTP id d3mr12672916pgu.332.1569963685064;
        Tue, 01 Oct 2019 14:01:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m12sm20075859pff.66.2019.10.01.14.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 14:01:24 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:01:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tools/memory-model/Documentation: Fix typos in
 explanation.txt
Message-ID: <20191001210123.GA41667@google.com>
References: <Pine.LNX.4.44L0.1910011331320.1991-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1910011331320.1991-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 01:39:47PM -0400, Alan Stern wrote:
> This patch fixes a few minor typos and improves word usage in a few
> places in the Linux Kernel Memory Model's explanation.txt file.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
> 
>  tools/memory-model/Documentation/explanation.txt |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Index: usb-devel/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -206,7 +206,7 @@ goes like this:
>  	P0 stores 1 to buf before storing 1 to flag, since it executes
>  	its instructions in order.
>  
> -	Since an instruction (in this case, P1's store to flag) cannot
> +	Since an instruction (in this case, P0's store to flag) cannot
>  	execute before itself, the specified outcome is impossible.
>  
>  However, real computer hardware almost never follows the Sequential
> @@ -419,7 +419,7 @@ example:
>  
>  The object code might call f(5) either before or after g(6); the
>  memory model cannot assume there is a fixed program order relation
> -between them.  (In fact, if the functions are inlined then the
> +between them.  (In fact, if the function calls are inlined then the
>  compiler might even interleave their object code.)
>  
>  
> @@ -499,7 +499,7 @@ different CPUs (external reads-from, or
>  
>  For our purposes, a memory location's initial value is treated as
>  though it had been written there by an imaginary initial store that
> -executes on a separate CPU before the program runs.
> +executes on a separate CPU before the main program runs.
>  
>  Usage of the rf relation implicitly assumes that loads will always
>  read from a single store.  It doesn't apply properly in the presence
> @@ -955,7 +955,7 @@ atomic update.  This is what the LKMM's
>  THE PRESERVED PROGRAM ORDER RELATION: ppo
>  -----------------------------------------
>  
> -There are many situations where a CPU is obligated to execute two
> +There are many situations where a CPU is obliged to execute two
>  instructions in program order.  We amalgamate them into the ppo (for
>  "preserved program order") relation, which links the po-earlier
>  instruction to the po-later instruction and is thus a sub-relation of
> @@ -1572,7 +1572,7 @@ and there are events X, Y and a read-sid
>  
>  	2. X comes "before" Y in some sense (including rfe, co and fr);
>  
> -	2. Y is po-before Z;
> +	3. Y is po-before Z;
>  
>  	4. Z is the rcu_read_unlock() event marking the end of C;
>  
> 
> 
