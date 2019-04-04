Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FD4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AD3206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="iqYJBAQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfDDQhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:37:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37735 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfDDQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:37:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id z16so4011811qtn.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2GPhs65IN3rKza1N9gqevUI9+mfx9z2j/qZ98tDTGR4=;
        b=iqYJBAQwL6e7qZi6pCEuST7cn0xAIslcwT+FQKf+CGHomxQCFjeQlnIc3ffhzSYcqj
         LgOb+Ul5z3BBmWgW4ClZXqohxRHljKA+smF/bPMWIrjkUDveVyo6tQBfW4bgpd/6j2b4
         FV03DnuUHY/Vu7wQykUfl+AEmrGrvt2qeKCSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2GPhs65IN3rKza1N9gqevUI9+mfx9z2j/qZ98tDTGR4=;
        b=UfQNTvkf/v1G94iRrl8uK2z2Dvuj5EQKe6EP+JBdKvnrj04FJMu2gWfqjxV9BRK0hs
         /QZ8O8VXtYJlke+aPGLUX9bxcwQ+//qcPp51gCJ1mH8b1CAnb5eUn3qLvabD7R9D2jZz
         39lGC+kz+pPvfW5XLoJXtYDPoZgWdapV2FsWiYPFTXuFAJZo6tYTfSpXrPwXVsA8JLMp
         Akr4r79Ez2gjqTV1mgJ89KVA1e1i3Vk09Z78M9hi2Q0NO7mkpGW+MW6NW31meSoZ7iv7
         DUzEWgM/zVyeq4GFHvwtFNY+Gyo+Pe69xCII+7eQksFQ1s3vWEcYpNl48QSwYyX79ua1
         AaWQ==
X-Gm-Message-State: APjAAAU446Mv4e4mDbXBZa7owV902bbFDjOLiDKpzfywJqXN4vLJxMR2
        1cklDnoItOjkpprhHDeZ9mPYSA==
X-Google-Smtp-Source: APXvYqxsHU0bdIOxr9A03Au/YIPYDhJW634Y4WEKvfpErqW42IwlqvIF0k1aooOWXJLM7rsyYyFGqg==
X-Received: by 2002:ac8:380f:: with SMTP id q15mr6402524qtb.163.1554395842996;
        Thu, 04 Apr 2019 09:37:22 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 56sm12359599qto.57.2019.04.04.09.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 09:37:22 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 4 Apr 2019 12:37:18 -0400 (EDT)
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
In-Reply-To: <20190404133327.GP1421@uranus.lan>
Message-ID: <alpine.DEB.2.21.1904041234340.5098@macbook-air>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air> <20190403191944.GH1421@uranus.lan> <20190403203144.GI1421@uranus.lan> <alpine.DEB.2.21.1904040922350.3758@macbook-air> <20190404133327.GP1421@uranus.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019, Cyrill Gorcunov wrote:

> On Thu, Apr 04, 2019 at 09:25:47AM -0400, Vince Weaver wrote:
> > 
> > It looks like there are at least two bugs here, one that's a full 
> > hardlockup with nothing on serial console.  The other is the NULL 
> > dereference.

OK, it turns out the hard-lock and the null pointer dereference might be 
the same, I have a random seed for the fuzzer from a hard-lock crash that 
reproduces and it generated the null pointer crash.  (This is with your 
patch applied).

I can try to see if I can bisect down to a specific event sequence that 
triggers this, but that can be tricky sometimes if things lock up so fast 
that the event log doesn't get written out before the crash.

Vince


