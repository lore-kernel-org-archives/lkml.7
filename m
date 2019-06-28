Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78055C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47384208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="FopxHQva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfF1PPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:15:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37284 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfF1PPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:15:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so11291605eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jaTwaRaq1pQyZRn8h7WxYAhQfyGnsb7JF7WEsqkcdCs=;
        b=FopxHQvajE42NY5N5u5hiOPkAIZqH3PHAbJbocZrfNO1SdSvH7NGm1FR7nNGgXvzeA
         tXd6OxxP0fTK9j83FCHwALQLXDUkN+IS1ouVYikPUUYg2JeNdqxaykyqF70iQJGz9Tcx
         nCByMjjmi06M8IWkhpYzxoXTqqMjeoErcwJRDuyz/jz/s8lS0DsDwfb3zKiDPb5UlXwx
         J1InixDlED6pJOvbfiwYrKgWiXBVIVCkVLLUm3N+UAHr8Ka+qR6gQBkgXGU4fDFD8YD6
         rS/9nE4RpCRHm6QYgulTMkbpvikhNMIB1qSw0vsdvruZGGSbgtGiPIj5P7mPakumcWsL
         IeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jaTwaRaq1pQyZRn8h7WxYAhQfyGnsb7JF7WEsqkcdCs=;
        b=R+A4DgGAp+ZY4igbVLrhW76pe4cb6jTfEcv3D66Nxg3crCyKaSxEdAtPrQ8FcOmGkt
         H7ZL0zccGnVdyz015hGsShPz67w8C6GW6qKHFjPeKnKXtV77pqkq+r2FYRS8exGI3CYs
         /YGdPso7Zvw7+KeKPAKtiZuEkvRyaKfGg7QHdHVzSf/cLIsdngDkh8ZUYSVufnUs9baz
         GQ/2xUolvycRn1YANQEwbRRDjdiVmDgrU2OYWe83j5UIuaL42iULr1ixccP8/wCWC2J+
         /QstkdkOKuXUYoqESkKj5MYAyAPd4/B7WSOk9wLp9Bt5FaNgBTRIQhvTay6l0KTPMrTC
         jfrQ==
X-Gm-Message-State: APjAAAWRXcx9HSVAQwdDQH01Z9deROxx6qK6nxbVI8iUE6nQjk5kCQkX
        ceIkZQOxgF2sQFmqyQac/h7JZg==
X-Google-Smtp-Source: APXvYqz4JBuvSw1LcvfY60hRe9sE1lnwo6cyodIongubhJVDHGMsOF9zbLGaqnanIIQ/dUitr0A9Yg==
X-Received: by 2002:a50:a56a:: with SMTP id z39mr12112533edb.107.1561734911733;
        Fri, 28 Jun 2019 08:15:11 -0700 (PDT)
Received: from localhost ([94.1.151.203])
        by smtp.gmail.com with ESMTPSA id c53sm783442ede.84.2019.06.28.08.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 08:15:10 -0700 (PDT)
Date:   Fri, 28 Jun 2019 16:15:08 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190628151508.GB6909@codeblueprint.co.uk>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
 <20190605180035.GA3402@hirez.programming.kicks-ass.net>
 <20190610212620.GA4772@codeblueprint.co.uk>
 <18994abb-a2a8-47f4-9a35-515165c75942@amd.com>
 <20190618104319.GB4772@codeblueprint.co.uk>
 <20190618123318.GG3419@hirez.programming.kicks-ass.net>
 <20190619213437.GA6909@codeblueprint.co.uk>
 <20190624142420.GC2978@techsingularity.net>
 <989944bc-6c3a-43b5-4f95-0bdfcc6d6c29@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <989944bc-6c3a-43b5-4f95-0bdfcc6d6c29@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun, at 09:18:01PM, Suthikulpanit, Suravee wrote:
> 
> We use 16 to designate 1-hop latency (for different node within the same socket).
> For across-socket access, since the latency is greater, we set the latency to 32
> (twice the latency of 1-hop) not aware of the RECLAIM_DISTANCE at the time.
 
I guess the question is: Is the memory latency of a remote node 1 hop
away 1.6x the local node latency?
