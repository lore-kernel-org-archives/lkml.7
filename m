Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2AFC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A73E20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzgW5F6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDBVby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:31:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43829 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDBVby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:31:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id g7so10094019lfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUprS3Dn4+6Eu2vetK8fmt4p8sOTpcfpWdL/LVMyHOQ=;
        b=ZzgW5F6AFJwLFmuNyImj+8wyHHrMOXftzajbDqS7NS+3Yu9oNTB5vFhsbuEQLV6mz2
         jJMr08XZuk4sfIoR3BbQwhqIrmCJsKDKSbINfrFXfH9k/oaYGlnG1LC5QPjxMuXq9u3o
         XUg2mlZhFTFV2oE+8mS5WKzg7LfUNc49gayGPwXh0uH1JbfRnz1eMgl32fGwoxqVgtOv
         Mg/WVQ8pmYEiorZ3Ahu/kqHvGOFKCq8VrsvdIXvvvXshEZRolwkDuMC9h/mOOSUZJ6Eq
         TVcU0ElizNTOJPKKMCbJ/kKbhAZ9VjS9FpcFzp7Bw/EAFaIwFwLEq0PRp6kZ3hLV7LZV
         DMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUprS3Dn4+6Eu2vetK8fmt4p8sOTpcfpWdL/LVMyHOQ=;
        b=d8ac7636r8BtmVKcdwgbp1DFcXhw4PJedVMdgoM5cunUCtckmLW9Zx7IyAwfwaBI4q
         f0ZIfAzwCmN4UOmoRMXE67a7j3kmoSDNHpiNW/aEgDE2dFCtk3rmLUT1tm2p9poIt5i6
         PWekuCEwNloe4wpzJ7jy0K5A5MwcI13TMWGknspADhoIPnZAThLRI7x+lqqiBxy+bKx8
         5XX6dVrPbVGUrGcpAUbOShA9You25ZTZJ4IwuRGxAtr+1hspBH8iZZCxGjDX/ojYjlwL
         N44VrD3A5/JIMM/RPeTbxrk30p9hF+Ft4e8aPc6hCPR5xLCEYDid3YH0BwmPPf3Xa2YH
         dbaw==
X-Gm-Message-State: APjAAAXDxaGfD4R+0Vh2dd6zFdYoCx5pFbMGXNOsEBAwodta05gHG5Ym
        kbJHpZD3gaue0v2nVE2OOZuIIK+q
X-Google-Smtp-Source: APXvYqz6+knLvUVcYCOQzsBP9+8a/PG6i4UagFEEM72VdE5czLqTjSYSQ7fohj7o9p3i87M+mgNHBA==
X-Received: by 2002:a19:f81a:: with SMTP id a26mr26619207lff.34.1554240712363;
        Tue, 02 Apr 2019 14:31:52 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id z65sm2821918lfa.90.2019.04.02.14.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 14:31:51 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 29FEA4601CA; Wed,  3 Apr 2019 00:31:51 +0300 (MSK)
Date:   Wed, 3 Apr 2019 00:31:51 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vince Weaver <vince@deater.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Message-ID: <20190402213151.GC23501@uranus>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
 <20190402130302.GL12232@hirez.programming.kicks-ass.net>
 <20190402132200.GA23501@uranus>
 <alpine.DEB.2.21.1904021050090.15645@pianoman.cluster.toy>
 <20190402150936.GB23501@uranus>
 <alpine.DEB.2.21.1904021709340.24692@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904021709340.24692@pianoman.cluster.toy>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 05:13:15PM -0400, Vince Weaver wrote:
> 
> > You know, running fuzzer on p4 might worth in anycase. As to potential
> > problems to fix -- i could try find some time slot for, still quite
> > limited too 'cause of many other duties :(
> 
> 
> Well I fired up the Pentium 4
> 	/dev/sda1 has gone 1457 days without being checked

Heh :)

> and eventually got it up to date (running "git pull" in a 5-year old Linux 
> tree plus running "apt-get dist-upgrade" at the same time was maybe a 
> mistake on a system with 1GB of RAM).
> 
> Anyway I have it fuzzing current git and surprisingly while it's hit a few 
> WARNINGs and some NMI dazed+confused messages it hasn't actually crashed 
> yet.  Not sure if I want to let it fuzz overnight if I'm not here though.

Wow, sounds impressive! Ping me if you find something.

> 
> Shame on Intel though for not providing perf JSON files for the 
> Pentium 4 event names.

Mind to point me where json events should lay, I could try to convert
names.
