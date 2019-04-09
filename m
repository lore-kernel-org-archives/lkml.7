Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43E32084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="JQNFumXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDIQic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:38:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39558 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfDIQic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:38:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so20544284qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TygSzTJ+I/CEp5Mg1tpP59nPmXk+fXHFoMxmiRUysyM=;
        b=JQNFumXCfRo/hz/ku/JRPbbR0nKnmcT+L5xWQemqh7s0rFh8Dd6pkKg6baQ32ZfXTC
         FLWfIfzZeMSpUIQZIMOpd3m2VrdLFO4DcQcafceu8ZAOXHrBMFcyhaiqT1pLEvveBen1
         wBjnhs1QiOPgAwofwc5wEpPH7WBNqAnWgT5nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TygSzTJ+I/CEp5Mg1tpP59nPmXk+fXHFoMxmiRUysyM=;
        b=kBjQ4/0HqdUc81wPRBzp3xZ8Zs847fFdKyOyrJg6TYRVQKaeVOBzBv9uwkxS4tc9Xh
         c//DEtZukV6pWrRQtFhKNi5u/3Nl1L88Spopb1WrgSnlDRFE704aNTlo9pph3woduQLv
         fVtw+5r8JLxx+j31mohuol7sL/YcIAsS/uPYToCn9eBTWWDBv6irZLFWhXtvLxXm3fYz
         zX76zqOLe7hBffo90uLn4IS17yb07CckY7HEE5NCTYW5D7ECbKWzBPP+Tx8Dmtuf2/bl
         6cMVyPMCUMtmjdrDGJ0IzeNuloqAKkZOCnbUNOwadjMAYidR5lNfxVXQUg/eys5Rwhck
         d9oA==
X-Gm-Message-State: APjAAAWnSt2UtdCorfDEpAWs/PHcnWx8bZxxKwDZquH9OqXkm4Qtt0Ei
        4i7n8iL0dxufxixUzMvfiW2pwg==
X-Google-Smtp-Source: APXvYqwngCNFHoLOd0U049twPQUUbYwPaHam/YL2uZ8uWFOwEcyhE8VZf7eSZKkP2fwVrE2duDl2hw==
X-Received: by 2002:aed:23b4:: with SMTP id j49mr30593955qtc.175.1554827911030;
        Tue, 09 Apr 2019 09:38:31 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id c207sm17799868qkg.14.2019.04.09.09.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:38:29 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 9 Apr 2019 12:38:25 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perf: perf_fuzzer crashes on Pentium 4 systems
In-Reply-To: <20190407202055.GX1421@uranus.lan>
Message-ID: <alpine.DEB.2.21.1904091237090.15486@macbook-air>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air> <20190403191944.GH1421@uranus.lan> <20190403203144.GI1421@uranus.lan> <alpine.DEB.2.21.1904040922350.3758@macbook-air> <20190404133327.GP1421@uranus.lan> <alpine.DEB.2.21.1904041234340.5098@macbook-air>
 <20190404164700.GR1421@uranus.lan> <alpine.DEB.2.21.1904041454290.5597@macbook-air> <20190404202038.GT1421@uranus.lan> <20190407202055.GX1421@uranus.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2019, Cyrill Gorcunov wrote:

> Vince, could you please disable alias events and see if it change
> anything, once you have time? Note once we've aliases disabled the
> counter for cpu cycles get used for NMI watchdog so PERF_COUNT_HW_CPU_CYCLES
> won't be available in "perf" tool itself, but I guess perf_fuzzer uses
> direct kernel syscall.
> ---
>  arch/x86/events/intel/p4.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-tip.git/arch/x86/events/intel/p4.c
> ===================================================================
> --- linux-tip.git.orig/arch/x86/events/intel/p4.c
> +++ linux-tip.git/arch/x86/events/intel/p4.c
> @@ -622,6 +622,8 @@ static u64 p4_get_alias_event(u64 config
>  	u64 config_match;
>  	int i;
>  
> +	return 0;
> +
>  	/*
>  	 * Only event with special mark is allowed,
>  	 * we're to be sure it didn't come as malformed
> 

It still crashes at the same place with this patch and my reproducible 
test case.

Vince


