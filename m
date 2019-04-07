Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D596FC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 20:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDEF20896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 20:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/H0feId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDGUU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 16:20:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46222 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDGUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 16:20:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id r25so7869004lfn.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2TGSbaHXR2pR397fNB4mOvKz5WSV1SP+1BggsWMPrTY=;
        b=Y/H0feId3BT8iySmnsOxh25NXVS0pS3cquqWO6wLTC116fF+xXQqn1wh4iVHz+EDEC
         TsoG6gI50s5mtklNdkN10F7w7uFLPOSfGTn9Jt8+yAk4eDRCIP/SzI7PalYBl9skBv/t
         bkf3HOgb6Nq6hHfvSKIT5Bx08b02JJu+hhuQWoQoYKRMDu54Mk3znQVATj3/ain1FLF3
         OXBZbh8jwJAcifQYUatwC0tx0R4Y0FoSvp/joh/y3dXwO86oB6UUloCRtiQvHhHmH4Id
         UE7sOACCzezBBb510szzN5s8HtnENNVVQS0A8LcDBbLH2IrE512cFlteeBXcifzjMZco
         wClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2TGSbaHXR2pR397fNB4mOvKz5WSV1SP+1BggsWMPrTY=;
        b=sS1+FiL/ML2BzmMmDSy1JK6SqdjVCnEkTESLCu4H6cZ1LEyWUTUtEln1o/P8M5jUJ7
         19lsSy79anXkxJ47i+hvMD/kyyCJxwNa6/+qT9FhyRYJNm1eU0dqH4snRhBfqNbmSuKJ
         VxEAbyzGmQOZZ6KKAuGXS1mpcGIjuxI5bZ0e0k52UVTGHMIqZqcdpa0qG3ZvqDCYNOWT
         nYt/Lq4rI8DrLwengNqjKTfH1OdeniqcTegujzhzNaMjH59YunwXtM/JajmGSby8dGLX
         c1KhmfylxQ57pX1YKZu6qoDgEP+Zlpl8AVw5dCIVv/iLR2rur1d5VPha2C6YpQV93ZVK
         0zEw==
X-Gm-Message-State: APjAAAVxPCWKlSUPg7wVqAC1VT6A2oS96upJ3IvVc6zOl96fLSmudqAI
        VCUFjJnxz+JNFhxyjzDrH00=
X-Google-Smtp-Source: APXvYqxq6S64UgxjstzVlz5gUPRbRdPrEGGr9nF0BkKnAH4v3ZLnTJ9mTAgk2fLAR3Gn59O9OYiVcw==
X-Received: by 2002:ac2:592f:: with SMTP id v15mr13142350lfi.133.1554668457068;
        Sun, 07 Apr 2019 13:20:57 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id q26sm6133025lfd.27.2019.04.07.13.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 13:20:55 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 721644606EB; Sun,  7 Apr 2019 23:20:55 +0300 (MSK)
Date:   Sun, 7 Apr 2019 23:20:55 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perf: perf_fuzzer crashes on Pentium 4 systems
Message-ID: <20190407202055.GX1421@uranus.lan>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
 <20190403191944.GH1421@uranus.lan>
 <20190403203144.GI1421@uranus.lan>
 <alpine.DEB.2.21.1904040922350.3758@macbook-air>
 <20190404133327.GP1421@uranus.lan>
 <alpine.DEB.2.21.1904041234340.5098@macbook-air>
 <20190404164700.GR1421@uranus.lan>
 <alpine.DEB.2.21.1904041454290.5597@macbook-air>
 <20190404202038.GT1421@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404202038.GT1421@uranus.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:20:38PM +0300, Cyrill Gorcunov wrote:
> > the machine still crashes after this, but not right away.
> 
> yes, exactly, if look into disasm code we will see that 0x158
> offset points to hwc from event. Vince, gimme some time, probably
> the weekend so I would dive into the perf code more deeply and
> will try to make some debugging patch for more precise tracking
> of events. The kernel you're running is the latest -tip?

Vince, could you please disable alias events and see if it change
anything, once you have time? Note once we've aliases disabled the
counter for cpu cycles get used for NMI watchdog so PERF_COUNT_HW_CPU_CYCLES
won't be available in "perf" tool itself, but I guess perf_fuzzer uses
direct kernel syscall.
---
 arch/x86/events/intel/p4.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-tip.git/arch/x86/events/intel/p4.c
===================================================================
--- linux-tip.git.orig/arch/x86/events/intel/p4.c
+++ linux-tip.git/arch/x86/events/intel/p4.c
@@ -622,6 +622,8 @@ static u64 p4_get_alias_event(u64 config
 	u64 config_match;
 	int i;
 
+	return 0;
+
 	/*
 	 * Only event with special mark is allowed,
 	 * we're to be sure it didn't come as malformed
