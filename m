Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0CEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43FA206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+TVd74L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfDDUUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:20:43 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38259 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbfDDUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:20:42 -0400
Received: by mail-lj1-f171.google.com with SMTP id p14so3255016ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8QJbnXOUvADE0Qah4ZClcKXsmDrF7a+jpH3MNG+arH4=;
        b=W+TVd74LOWUVETDKZHJj8pCZZyreygeolXGDNFyNsYmn8DHfQcJvEWKeD0/maduOSq
         2i+6rmq3VEHHcjxuoQoIC/uHTRhgCEjK7LAhvqsdsVqIk+NVXdjxv4MGRTuRol7RynG+
         h7vB5FyTVxH8+0h7/EBJWj9CFS5Ort1BNY289oT/YKTE4YoMsmCU6e/c3++EB0OijoRj
         1kNwCnYTf9KhBXS8nad4OUCr02fjtiP82cXThtEADy5Ltg5TnbkWxqSAqeKqIJ74oKdY
         ftIYrUWS+Q+u36pOKf39+t7YoYgqtyA+nnl0cQ00jNNGPceH9wopyeg9eJMa1kkhNVz0
         1BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8QJbnXOUvADE0Qah4ZClcKXsmDrF7a+jpH3MNG+arH4=;
        b=csUSmoFTRr2efdagVPEyhMZMjaAjlBqW6Xmu+ZSmpOiU0wSCCoCeWpMG3MKjOBiptV
         Nctms2JhzU2X9sB0BrhRwIZQvBd7IfAWjj26VNz0mmqT6ZOBtvLYoCWQlvpJRtp86tuc
         jn/vrtpg/I1ZUm9DKf4bTSR2fSt66SQ77MripCXL2x0yQrF9j0eHD1nMuG8Xp/fkCHeJ
         Tkzo2Er/omw9dbusM3e++6RtWNTLsw4WNyyZ5At/s6Gyy2lYS7tt29tAxuJU7AUrWoc5
         wiMg9+MOamcsM+0P+CN09/xYtUSqkKdlbG5l5yL2/lxXZSD7RBUen2Vap/O3eD98htkL
         KkrA==
X-Gm-Message-State: APjAAAUDNNAao+RG/PHFS0iZt/Kf6oaVmndoTRKectCKSdkU3d+p3lGp
        ZBUPu2SthG8e0gb2E9F9dWs=
X-Google-Smtp-Source: APXvYqwZGPZ3dQk8mwC2c3bqWEoqW4yrFzTmhxhN2KWly2e9RVbUYUQOAlttQjvCnmyG/2yUUequpA==
X-Received: by 2002:a2e:9753:: with SMTP id f19mr4587405ljj.54.1554409240435;
        Thu, 04 Apr 2019 13:20:40 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id x2sm3835319lfg.59.2019.04.04.13.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 13:20:38 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 7BD8B460472; Thu,  4 Apr 2019 23:20:38 +0300 (MSK)
Date:   Thu, 4 Apr 2019 23:20:38 +0300
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
Message-ID: <20190404202038.GT1421@uranus.lan>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
 <20190403191944.GH1421@uranus.lan>
 <20190403203144.GI1421@uranus.lan>
 <alpine.DEB.2.21.1904040922350.3758@macbook-air>
 <20190404133327.GP1421@uranus.lan>
 <alpine.DEB.2.21.1904041234340.5098@macbook-air>
 <20190404164700.GR1421@uranus.lan>
 <alpine.DEB.2.21.1904041454290.5597@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904041454290.5597@macbook-air>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 03:01:14PM -0400, Vince Weaver wrote:
> 
> I do have a lot of this automated already from tracking down past bugs, 
> but it turns out that most of the fuzzer-found bugs aren't deterministic 
> so it doesn't always work.
> 
> For example this bug, while I can easily repeat it, doesn't happen at 
> the same time each time.  I suspect something corrupts things, but the
> crash doesn't trigger until a context switch happens.

I fear so, I've readin code around to figure out where it might came
from but without much luck yet.

> For what it's worth I've put code in p4_pmu_enable_all() to see what's 
> going on when the NULL dereference happens, and sure enough the printk is 
> triggered where I'd expect.
> 
> [  138.132889] VMW: p4_pmu_enable_all: idx 4 is NULL
...
> 
> the machine still crashes after this, but not right away.

yes, exactly, if look into disasm code we will see that 0x158
offset points to hwc from event. Vince, gimme some time, probably
the weekend so I would dive into the perf code more deeply and
will try to make some debugging patch for more precise tracking
of events. The kernel you're running is the latest -tip?
