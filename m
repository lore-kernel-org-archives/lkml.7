Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D538C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABC6218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="HM/IYfCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCOU4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:56:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34525 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfCOU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:56:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so7288449pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AAff4RmUaSYnml/Ko+UEfMQ8m682UchLUHVPeub+JoY=;
        b=HM/IYfCUNaX6xr6koQG7rd2dJ78nKEkPNkkoNQP+wU6BIl0Lunr0MnY5C3vsJ6Au0T
         MSfKIbIj+zskUwzvojddEYN7rzKngJn9Qygt5FdnbKvpskyLqAZlp8GQ0Lu2/Ks62zpg
         GUdX4WQfLgO3QNJWTPv++HBRVkbsgANRQKlachmmszhwEn9zPtTb/Ca81XmLp6V/Hr28
         yR7FTtsGe2wC4lgUj/wnc7zbD02yZmcPD1/NXniex0Gb93qwejRxi2WhizYV3uZaVLI4
         DJat8JdlLj1OIPE5GtgGxTGQNFy5FrDgSXtvXha4a6D6Ihq/TRBG0SNfHY114zLrouN1
         IJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAff4RmUaSYnml/Ko+UEfMQ8m682UchLUHVPeub+JoY=;
        b=UdReYGB7r4FLAKK80koXb8ayTNP6BG426LgAzL9tEQCWKSAwr6NEKrKUY4JFPXq96u
         XVoIUbXcmgEVGfCnmNlG+IMgalAKqw2eCxTXuqfcKtVJBT7L7L00ez2NUg0/zCmOLRKD
         46DBp/MgfsWXznODHIs1aWwR7SgOvG9ewvg6MhzqigFSkd/36hvE22tJEg6K4vguJIIB
         6RaZASW4W6QlX1C3xHzgIk4ZWPhbXqUyY4TqyM+ofSR5s0PUNo3TE3Fw0QbarotzyIzU
         VAybjH+FAG4t2D5osiakOCgsGi3xBR2Plb4F0Z2/A2Ja01z4BzMwMdDnYd+vr6t37g5a
         NY+w==
X-Gm-Message-State: APjAAAVbpQETi8Ceog3ccVdM+G4uz7t5HzNOTud1AXRAJIjm1m1cMH6h
        tb6SzoNycwXE7kwAKKPsulnCldaAoNk=
X-Google-Smtp-Source: APXvYqyvsL2K0RjChi9YcUPHlPxu0EdOiPDO/OPrf/9riTAJCC3qXXKbhR/qYliElcRHsAPUHmLlqw==
X-Received: by 2002:a17:902:29ca:: with SMTP id h68mr6324756plb.297.1552683413985;
        Fri, 15 Mar 2019 13:56:53 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id j71sm6334015pfc.6.2019.03.15.13.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:56:53 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:56:52 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: bpf: modify urandom_read and link it
 non-statically
Message-ID: <20190315205652.GD5481@mini-arch.hsd1.ca.comcast.net>
References: <20190315200414.32346-1-ivecera@redhat.com>
 <20190315200847.GC5481@mini-arch.hsd1.ca.comcast.net>
 <2dcdc11c-4d04-4b0e-ddb7-04d969d04651@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dcdc11c-4d04-4b0e-ddb7-04d969d04651@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15, Ivan Vecera wrote:
> On 15. 03. 19 21:08, Stanislav Fomichev wrote:
> > On 03/15, Ivan Vecera wrote:
> > > After some experiences I found that urandom_read does not need to be
> > > linked statically. When the 'read' syscall call is moved to separate
> > > non-inlined function then bpf_get_stackid() is able to find
> > > the executable in stack trace and extract its build_id from it.
> > But why? Do you have some problems with it being linked statically?
> > 
> Dependency... you don't need to install static glibc to compile the bpf
> samples. Shared libc is available everytime.
Oh, the distros that do -devel _and_ -static packages :-)

So your patch essentially adds a call, that leaves a trace on the stack
with our build-id. I guess that works as well.

> 
> Ivan
