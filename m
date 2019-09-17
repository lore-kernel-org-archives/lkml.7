Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554EFC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B58C21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8DBZDe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfIQLkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:40:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39384 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfIQLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:40:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so2749971wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rx9AKEs9on8tyYzLlreqCPVJ+4zzfyMgS08lHc287dE=;
        b=X8DBZDe8Px1+h0H6RVpyDi5jzbWbwe+4f8Gsxb3EgsBCHps85/an1xxesJJy9F/jvw
         Y6E2IMjMt/HU3hLmUpXgdIfA5fURzFgRzaVJGX1LK9G5At5QCR5zi12CgOfTNCNexS2x
         lV/ZvOf+pEPrLRj+MUpL158CJ7UKtvNSjPkSW06F+zKZFN/51JOJBtE2eVxjcL7j5U0s
         qDK7h+l30DNCPOXVN8dCTfLdMSocMCYn3Sap3G/HnyjqWH6dysHIl5xKLRfHhQGK3kUL
         KraUwobZ8qM2Qlo9SUGBOkdlpBF8cOT3IIQyWtp5PTTG7W/GCwepR2pH2pBE4OJEpjqD
         ndlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rx9AKEs9on8tyYzLlreqCPVJ+4zzfyMgS08lHc287dE=;
        b=kZ0lApOhh1efFbml2vW+yOiNOoGY6iQwkP+Go0Yp/LWd82keo0y8FvFxiwQDw5+MUZ
         GM+ZTAOdTgi3Q+5yU5f4lcxcZCNF3IyoB4qwzwV6fkxCyb+WdMPraOhcNE9ADjbGqe/7
         KUyrIArnP01PhxfK0f5JjItaQZrCimX39PYKgnmSoLFqcvUhs42Jr8WUJvsWFUiwbZ/y
         grU8D/LgFZkac9pHMn7Ho8RcRZTn8itziFfPgxzociEu5FL7Ov+VgtHd2yE5CR1ryFJd
         G+xIwfoPikrJxWsePFTjpgWOwLWZFv8/FBP/6U0WLXfQOSbx1Hucbdn1zKmhznkDqqJT
         PWCQ==
X-Gm-Message-State: APjAAAXAxNymSFVq4l09d5vWowZBnBj42Q1hO9uOZSAWMtQSVZiH3cgy
        wy7kruWGOocf4LeCbB/FYdE=
X-Google-Smtp-Source: APXvYqwTjvC6d3LsmVhiIfxZj8AEZ+1OZIzO5L0jkO4Kcs/kZiMR4pM33BhdWDDQPZ3k4uWS8m9bmA==
X-Received: by 2002:a05:600c:34e:: with SMTP id u14mr2936855wmd.110.1568720407097;
        Tue, 17 Sep 2019 04:40:07 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1010:2dc3:b64e:d9d3:5630])
        by smtp.gmail.com with ESMTPSA id q192sm2157683wme.23.2019.09.17.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 04:40:06 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:39:59 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] tools/memory-model: Fix data race detection for
 unordered store and load
Message-ID: <20190917113959.GA19404@andrea.guest.corp.microsoft.com>
References: <Pine.LNX.4.44L0.1909061649430.1627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1909061649430.1627-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:57:22PM -0400, Alan Stern wrote:
> Currently the Linux Kernel Memory Model gives an incorrect response
> for the following litmus test:
> 
> C plain-WWC
> 
> {}
> 
> P0(int *x)
> {
> 	WRITE_ONCE(*x, 2);
> }
> 
> P1(int *x, int *y)
> {
> 	int r1;
> 	int r2;
> 	int r3;
> 
> 	r1 = READ_ONCE(*x);
> 	if (r1 == 2) {
> 		smp_rmb();
> 		r2 = *x;
> 	}
> 	smp_rmb();
> 	r3 = READ_ONCE(*x);
> 	WRITE_ONCE(*y, r3 - 1);
> }
> 
> P2(int *x, int *y)
> {
> 	int r4;
> 
> 	r4 = READ_ONCE(*y);
> 	if (r4 > 0)
> 		WRITE_ONCE(*x, 1);
> }
> 
> exists (x=2 /\ 1:r2=2 /\ 2:r4=1)
> 
> The memory model says that the plain read of *x in P1 races with the
> WRITE_ONCE(*x) in P2.
> 
> The problem is that we have a write W and a read R related by neither
> fre or rfe, but rather W ->coe W' ->rfe R, where W' is an intermediate
> write (the WRITE_ONCE() in P0).  In this situation there is no
> particular ordering between W and R, so either a wr-vis link from W to
> R or an rw-xbstar link from R to W would prove that the accesses
> aren't concurrent.
> 
> But the LKMM only looks for a wr-vis link, which is equivalent to
> assuming that W must execute before R.  This is not necessarily true
> on non-multicopy-atomic systems, as the WWC pattern demonstrates.
> 
> This patch changes the LKMM to accept either a wr-vis or a reverse
> rw-xbstar link as a proof of non-concurrency.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thanks,
  Andrea


> 
> ---
> 
>  tools/memory-model/linux-kernel.cat |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: usb-devel/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.cat
> +++ usb-devel/tools/memory-model/linux-kernel.cat
> @@ -197,7 +197,7 @@ empty (wr-incoh | rw-incoh | ww-incoh) a
>  (* Actual races *)
>  let ww-nonrace = ww-vis & ((Marked * W) | rw-xbstar) & ((W * Marked) | wr-vis)
>  let ww-race = (pre-race & co) \ ww-nonrace
> -let wr-race = (pre-race & (co? ; rf)) \ wr-vis
> +let wr-race = (pre-race & (co? ; rf)) \ wr-vis \ rw-xbstar^-1
>  let rw-race = (pre-race & fr) \ rw-xbstar
>  
>  flag ~empty (ww-race | wr-race | rw-race) as data-race
> 
