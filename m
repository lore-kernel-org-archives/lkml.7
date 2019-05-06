Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0581C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F7C20578
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l4hD/UXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfEFQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:42:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53356 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfEFQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:42:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so16611104wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J/JGaGs5mPztH9k1eyhEvAFpyBMbgcgLbwEI5MYyQS4=;
        b=l4hD/UXRd1Yd/DGCnJWvFgr4PVwnP528bm7iAT4njVwgn1FwjiqJG1mOOj0pGrGyif
         uV5DJMxeIvg6inIJqWlbh/6fxCYgO/kuM3fhajtInkFd4EXu8zMB1BiyXXtaEI1Voknj
         7EmpSrvuEQjz8cJfgGC60YhHIEJ73fIs+pq5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J/JGaGs5mPztH9k1eyhEvAFpyBMbgcgLbwEI5MYyQS4=;
        b=ttnVlEiA0zCR5g5npl1QYyYo/ML/lUkuaH3hLmpFicLtAM6oQcTBrkkL98ydXEy7xZ
         70pEzvii0KWM/Edib/0qd9G7Qa4UQMOpkiLnAAeZKks1H9+SeK2BPbsgXY75+ILpTd5T
         m6a5hxQbCtdGoY9UyVbw/VgJu/mJCQv2IdL+qlaj4iXmKL5vP+gzJb1zMihUerKr8s4X
         5+qddLfra1eTBRRBzE3g7TcLvX8JJsqJ+wssno11tQZgqgzl8KMWf8gyFthmGI9ehow+
         HFDa0BGz0b4bcdRk8HgEb5Fbv7nokqREWUdJd0lJOZu5aL6OeTaczEs/rm6zHmBhDlZa
         H0uA==
X-Gm-Message-State: APjAAAV0AeolQTYBO/zWDKo2owsmfBltfgLASeKEWxirWMDz6d0ZRIuj
        YEIpWw8dhhi6U0erzDlcJ2Rlng==
X-Google-Smtp-Source: APXvYqzqlu38bbtas2+yfiWJ59pUyyqnxZgDZSpgQgwfPrazOqHKvldT2mjTU1FyNXb0CZq21G9ECg==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr4056959wmf.70.1557160967487;
        Mon, 06 May 2019 09:42:47 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id n6sm9928650wmn.48.2019.05.06.09.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:42:46 -0700 (PDT)
Date:   Mon, 6 May 2019 18:42:38 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation: atomic_t.txt: Explain ordering
 provided by smp_mb__{before,after}_atomic()
Message-ID: <20190506164238.GA4956@andrea>
References: <20190503163411.GH2606@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1905031309300.1437-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1905031309300.1437-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 01:13:44PM -0400, Alan Stern wrote:
> The description of smp_mb__before_atomic() and smp_mb__after_atomic()
> in Documentation/atomic_t.txt is slightly terse and misleading.  It
> does not clearly state which other instructions are ordered by these
> barriers.
> 
> This improves the text to make the actual ordering implications clear,
> and also to explain how these barriers differ from a RELEASE or
> ACQUIRE ordering.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: Peter Zijlstra <peterz@infradead.org>

I understand that this does indeed better describe the intended semantics:

Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Now we would only need to fix the implementations and a few (mis)uses. ;-)

  Andrea


> 
> ---
> 
> v2: Update the explanation: These barriers do provide order for 
> accesses on the far side of the atomic RMW operation.
> 
> 
>  Documentation/atomic_t.txt |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> Index: usb-devel/Documentation/atomic_t.txt
> ===================================================================
> --- usb-devel.orig/Documentation/atomic_t.txt
> +++ usb-devel/Documentation/atomic_t.txt
> @@ -170,8 +170,14 @@ The barriers:
>  
>    smp_mb__{before,after}_atomic()
>  
> -only apply to the RMW ops and can be used to augment/upgrade the ordering
> -inherent to the used atomic op. These barriers provide a full smp_mb().
> +only apply to the RMW atomic ops and can be used to augment/upgrade the
> +ordering inherent to the op. These barriers act almost like a full smp_mb():
> +smp_mb__before_atomic() orders all earlier accesses against the RMW op
> +itself and all accesses following it, and smp_mb__after_atomic() orders all
> +later accesses against the RMW op and all accesses preceding it. However,
> +accesses between the smp_mb__{before,after}_atomic() and the RMW op are not
> +ordered, so it is advisable to place the barrier right next to the RMW atomic
> +op whenever possible.
>  
>  These helper barriers exist because architectures have varying implicit
>  ordering on their SMP atomic primitives. For example our TSO architectures
> @@ -195,7 +201,9 @@ Further, while something like:
>    atomic_dec(&X);
>  
>  is a 'typical' RELEASE pattern, the barrier is strictly stronger than
> -a RELEASE. Similarly for something like:
> +a RELEASE because it orders preceding instructions against both the read
> +and write parts of the atomic_dec(), and against all following instructions
> +as well. Similarly, something like:
>  
>    atomic_inc(&X);
>    smp_mb__after_atomic();
> @@ -227,7 +235,8 @@ strictly stronger than ACQUIRE. As illus
>  
>  This should not happen; but a hypothetical atomic_inc_acquire() --
>  (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
> -since then:
> +because it would not order the W part of the RMW against the following
> +WRITE_ONCE.  Thus:
>  
>    P1			P2
>  
> 
