Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF4C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDE8218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biR3y3fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfCOT0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:26:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41969 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfCOT0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:26:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so6073143qta.8;
        Fri, 15 Mar 2019 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iLYjtnOluzaV9rUgq0XkEQ8i218XaeDuoxceM0bvNEA=;
        b=biR3y3fjP+fIZIxhBAu9RHoKY9pNHNUsHjWF000xVYVzH9Z+Sb08gk5FVhz1fKMd+q
         1ab439y+N2oLPHKNU2lKzp2b6SBbqkqSgaRsi0KAqecKjYTn3K0kNx0QFJC3VGAs0hM2
         8++yOLApKJ9mrX61jApOWnFPubp00uJ8dSF9zser71R9b4NhRUgyrq2qkpdhBPBrdsAM
         oTKjwWBZrz5ctNkqM8qSPCv+ofCnUrXSxMiMPXEqYmTNoc8T/tTAh12E4XyF85AROxKA
         zNDreyNMGG2UoZt2fL9W7enyXQL32xodL9qmmNVq4rroLUoR72Dt4f/b1HlhmqOVB+be
         8FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iLYjtnOluzaV9rUgq0XkEQ8i218XaeDuoxceM0bvNEA=;
        b=LnwoF53IBXJ9RFPG9gVQSZfFNmg5HiH5aSMVYIiE+NivCrFNE6V4xWxKp62AtjuIDj
         KYx5qO5Rn+bvzb5n6SKJmiIAl5iU67gWmZY/1HDJ1p0Lii93pt2YC9wEyEEm4Dllick8
         vY/5WFWItdoZsldG0C8yu0G4iFcNkEOget1Hq9m9bAjbnnPgOFIqW4rT+vTbkAMTxemV
         Itwzhreywo6ZTbgaBNpBUgkcNARC0xBZvyNIUmd1vKYCT2PaEFfT7aFr6PWvSr/MXSwB
         o/GXIg9WmY9+PUv1gvRcspCJMA1e/7BNEVCaquwpH+wjZnwFxHJnLnDXn5HcOjbOkijS
         s48g==
X-Gm-Message-State: APjAAAVnwfIkpNzNOYOCkzMsI0A8VrHIKD9EQj724mwM9x5ijufFQHw4
        29enW6k8xveNs9xs3YeM4EE=
X-Google-Smtp-Source: APXvYqwsCYKbcQ1eU41Loe5HCvClinpHzikkbZHzAXFbXhS1l4JCZax1f22eulLRX0WWClCUyoYo1w==
X-Received: by 2002:ac8:2d1c:: with SMTP id n28mr4145070qta.159.1552677974549;
        Fri, 15 Mar 2019 12:26:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id e2sm1929239qkd.7.2019.03.15.12.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 12:26:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29D624039C; Fri, 15 Mar 2019 16:26:10 -0300 (-03)
Date:   Fri, 15 Mar 2019 16:26:10 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190315192610.GB14938@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-10-songliubraving@fb.com>
 <20190312151405.GG4939@kernel.org>
 <20190312151608.GH4939@kernel.org>
 <61901DA6-47B4-44E0-A0C9-9F2DBD6C34C1@fb.com>
 <20190312170556.GJ4939@kernel.org>
 <97D0A2F1-1F82-4CF0-ACE3-A276784DF7EA@fb.com>
 <20190315190651.GA14938@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315190651.GA14938@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 15, 2019 at 04:06:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> And yes, there are BPF programs with BTF information associated:
 
> [root@quaco perf]# bpftool map dump pids_filtered
> [{
>         "key": 2592,
>         "value": true
>     },{
>         "key": 20511,
>         "value": true
>     }
> ]
> [root@quaco perf]#
 
> I.e. bpftool can find the BTF info and thus is able to show the
> 'pids_filtered' map keys and values pretty printed, not just as hex raw
> data.
 
> I'm trying to find out why 'bpftool map dump' finds the BTF info while
> perf_event__synthesize_one_bpf_prog() doesn't.

Humm, the BTF info above is for BPF _maps_ not for _programs_, I think
you haven't added BTF info for maps in the perf.data header, right?

- Arnaldo
