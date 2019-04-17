Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD99C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A0A20674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555481192;
	bh=KqlpvqnBPd8CgD3q46qsV4B0VXY/h9f+Q+xIqkzUsIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y5Mm4EIF4b3bNE6qZgp+VD+FdznlTz/78mYJ13BD3GE/lH6jALVszbztSTVdpmFDD
	 yIX7IkGLVhyJgaWg4dhySF8jUwYJbMzxOR76MRZFKYWDEtJpPTBcNIU84CldaW82nq
	 AOkuyRjPY4F6wecX2YdoWTH/rYdsbsLd6Yun8m2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfDQGGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:06:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51763 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfDQGGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:06:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so1851476wmf.1;
        Tue, 16 Apr 2019 23:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HX+VtUy9P30sN7q160zYq52Zi1gDPIOMUQgqPZMKC5s=;
        b=HqbUIduM5D/Lo8pgvOYmQK3jWbjch9AcoFiLVb+0W9Z113NEq9Z3wNYTGgbS6+Rdwb
         gsOLVu4JSnS5YK8h6+2MTaePJj91LfC1NyvaHK7Jnw1mflb5KUuBKDBmBOsz9vI7Pird
         3/F9TA3jFKNaLRLOiV0NIbYiVPCCYrp+L+yRm56WStRbOtLstfAeSIJ35xvP2J3r8XEi
         cINvfaWK8wqzh6fmPhL+M6GJaEcutuaTMjCcNysHs6EVnVgluOm/ZfdbLceMQCnpmTfb
         trLOnt9p2/S6N89CofB1eYEm196zh8cQ1vpl2e73oeCAUDf8m9SGx7uYYScgiIFv2Jy8
         VhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HX+VtUy9P30sN7q160zYq52Zi1gDPIOMUQgqPZMKC5s=;
        b=saRObPq5CEtWlxTc7oD3Hu/lF30k4LrxxhR+7fITIy9neTf2fegldV2xiNmLmE4tzr
         GskAKx6AvZTe3jIP/6TDaTP8ScbiY+HDr8uOpXGcqGPnj1e0ZvL/QoYAdT8pqQhLWr1e
         908YJOGAfbgst3L08tF58ulvgsIFjflmJNtx/pmPtOZugmuSlgVp7hgyYpjR0hSUIogu
         egMsY2ty80ii41EiaSWyBueLgJBElzX9+A2N7ttqI3dGHPq7Xa9KeEND0WgvT7bLfBOZ
         J+fw4jD7WxAkNOGt3/wcVBcD/eWrgDp3/uFBL0gdBWWNwc4hPaS3pvttwrx4aNmtQYYY
         SM7g==
X-Gm-Message-State: APjAAAVHDbKNVjjvTBdRIceF9EriNmHIrqu0hkybTdM5P5HfrkTxya65
        PL0X5CIMCX9X57+wypjD2oE=
X-Google-Smtp-Source: APXvYqxntyCG73xR36JTJKs3tC6SelcDx7WNzZEqn7Fjyx+L88l4pyEuZzbK+nNg8/6RLUXtWgS7Vw==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr30053673wmf.73.1555481188858;
        Tue, 16 Apr 2019 23:06:28 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z14sm77427980wrv.78.2019.04.16.23.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 23:06:27 -0700 (PDT)
Date:   Wed, 17 Apr 2019 08:06:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     eranian@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/core] perf/x86/intel: Force resched when TFA sysctl is
 modified
Message-ID: <20190417060625.GB97541@gmail.com>
References: <20190408173252.37932-3-eranian@google.com>
 <tip-f447e4eb3ad1e60d173ca997fcb2ef2a66f12574@git.kernel.org>
 <alpine.DEB.2.21.1904161227001.20764@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904161227001.20764@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vince Weaver <vincent.weaver@maine.edu> wrote:

> On Tue, 16 Apr 2019, tip-bot for Stephane Eranian wrote:
> 
> > Commit-ID:  f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
> > Gitweb:     https://git.kernel.org/tip/f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
> > Author:     Stephane Eranian <eranian@google.com>
> > AuthorDate: Mon, 8 Apr 2019 10:32:52 -0700
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue, 16 Apr 2019 12:19:35 +0200
> > 
> > perf/x86/intel: Force resched when TFA sysctl is modified
> 
> What's TFA?  Tuna-fish-alarm?

Heh, I wish! :-)

> [...] Nowhere in the commit or in the code does it ever say what a TFA 
> is or why we'd want to resched when it is modified.

Yeah, it's the TSX-Force-Abort acronym - Intel has numbed our general 
dislike to random acrynyms ...

Peter and me usually fix such changelog context omissions, but this one 
slipped through. :-/

The commit is too deep down perf/core already to rebase it just for the 
changelog, but if we are going to rebase it for some functional reason 
I'll take care of it next time around.

TFA. (Thanks For your Assistance. :-)

	Ingo
