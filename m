Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE62C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903BB2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg8Fp8Ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfCTL6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:58:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43401 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCTL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:58:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so1630264pgq.10;
        Wed, 20 Mar 2019 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aQOcMLnOV4EHAGkfiD2kuMOsuoGF5VI2/H+F6nmERDU=;
        b=Xg8Fp8WseloZq8wE1MdkM20jxlxoF41JsxjiEHRkmFDBbyEcCLjA6UQjNyY5QE88yM
         ofYGP7vyuaEggubCvJs7Ymao57VGmIVxBMxfiN/gzwcsRr6v9izuhpix/V/LcdvRAtLW
         dgqSD8/AtQmUQ5FZENW6ar1+IJwhvh/wyu+PLrOoY3YWPcT/kTixtpOV35QoRKnH+AFN
         7o72UBGnSjFS+Deo/c0XTNfVAj4GWyE8B8TVd+jt+Q5R9lNmhxaaL29MQhQy7k+Prw9r
         nQmOWDPWWnSciPKeB6XS1nWSIc0wZwNTN4Maa/Bo/612RfXmZOoU3wFMlh9XQ5jh47cT
         q/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aQOcMLnOV4EHAGkfiD2kuMOsuoGF5VI2/H+F6nmERDU=;
        b=IB2a3kDVBT3aiDGByCA+KZqxWJ5OPZ1zQ53z2wnfaRKz2SfZKnAlLU2NwI0wLaqS4j
         /EhjiHO47//yX/xliVt0UOf5IV4d3QJkp+ItdIqBPJ7EV1PsTYXwlfOczYkQDNGpb6Mv
         5adZSFGFxSkcRKKmRGDa6t4Xxhex1uzQxwVmztFK5xvd2BXO5hIdMDw63xA6iiGpzKil
         Vigt2frcyK1VwyoHhbVa/Ks8RwFIKanH1l8PrMjnQlfdX5FSx/I6jkCSLfxIzzgK9LT6
         Thi5+rS7Nr1JrXt5/x/cnEaEXThUMDknKxAqQ4C2UaNQSOdJY9REIm7pmxSOC5nLKFIj
         nvLA==
X-Gm-Message-State: APjAAAW/zx0nbQmAtsxjH97YAe3Y1MgPv4ASJMioBvqGRlHVACw62VrC
        3UvNP9TCoOKfaR/39Z00LKo=
X-Google-Smtp-Source: APXvYqzeJZDNL2ctvS4Z9h10kjjJODt3BnYguWj9pnYQ0AGCaCkqTb47WBmw5FGTmNxyjETm+0secQ==
X-Received: by 2002:a63:c118:: with SMTP id w24mr6972166pgf.67.1553083113808;
        Wed, 20 Mar 2019 04:58:33 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id e8sm2609593pfn.103.2019.03.20.04.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 04:58:33 -0700 (PDT)
Date:   Wed, 20 Mar 2019 11:58:31 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 01/16] perf: add doc for how to build perf with Asan and
 UBSan
Message-ID: <20190320115830.za3swag662f6ht45@mail.google.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
 <20190316080556.3075-2-changbin.du@gmail.com>
 <20190318100758.GA28556@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318100758.GA28556@krava>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for delay.

On Mon, Mar 18, 2019 at 11:07:58AM +0100, Jiri Olsa wrote:
> On Sat, Mar 16, 2019 at 04:05:41PM +0800, Changbin Du wrote:
> > AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
> > very useful tools to detect program bugs.
> >  o AddressSanitizer (or ASan) is a GCC feature that detects memory
> >    corruption bugs such as buffer overflows or memory leaks.
> >  o UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior
> >    detector supprted by GCC. UBSan detect undefined behavior of programs
> >    at runtime.
> > 
> > This patch adds doc for how to use them on perf. Later patches will fix
> > some of the issues disclosed by them.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/Documentation/Build.txt | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
> > index f6fc6507ba55..cae6e1d9b901 100644
> > --- a/tools/perf/Documentation/Build.txt
> > +++ b/tools/perf/Documentation/Build.txt
> > @@ -47,3 +47,23 @@ Those objects are then used in final linking:
> >  
> >  NOTE this description is omitting other libraries involved, only
> >       focusing on build framework outcomes
> 
> thanks for adding doc, one nit:
> 
> > +
> > +3) buld and install perf
> 
> there's already:
>  2) perf build
>  =============
> 
> please use something like 
> 
>  3) perf build for ASan/UBSan
>  ============================
> 
> > +  $ cd tools/perf
> > +  $ make DESTDIR=/usr
> > +  $ make DESTDIR=/usr install
> > +
> > +4) build with ASan or UBSan
> 
> no need for this label
> 
Thanks, I saw Arnaldo already taked this change with your suggestion.

> > +AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
> > +such as buffer overflows or memory leaks.
> > +  $ cd tools/perf
> > +  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
> > +  $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
> > +ASan outputs all detected issues into log file 'asan.log.<pid>'.
> > +
> > +UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior detector
> > +supprted by GCC. UBSan detect undefined behavior of programs at runtime.
> > +  $ cd tools/perf
> > +  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=undefined'
> > +  $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
> > +If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
> > \ No newline at end of file
> > -- 
> > 2.19.1
> > 

-- 
Cheers,
Changbin Du
