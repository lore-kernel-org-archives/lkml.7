Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CFAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83078217D4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv18BZch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEAU0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:26:38 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:41071 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAU0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:26:37 -0400
Received: by mail-yw1-f44.google.com with SMTP id s66so9166723ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k8Q2R+703zo9hbi2OL4YyNWbAuxT/Yv0VfU/hdRrJ0U=;
        b=gv18BZchL+RuyY1i/cjK9I06s7Og8MeO1hgWKhzRKSj4iw8D8mq3/Q9LCUMlWPbPnS
         C/vc46VKgN/oa5xXNmgs4KRWwhPJIOxpb5En9PZjT9ZZg3aChZK8V6qEirMSF4tnoPBt
         6ztAvbV9biZOkot7iUQx+/ll1onHq77lJIIDQMJgN5Rps5XqgPYxSQSDAHyoqDv/dxIN
         /9UZmKR5JvStQ/DC8leL5XGN5wwm6vuxC52VQQblB6wILUGM/EFL+JGafGkWK40whJiX
         FJtvI9F/e8Qz+1cYgrVKRwVaCm7bm22QLRXch/JK6nGEiZlCYyR3nXxVmbn5j2svmNTo
         DsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k8Q2R+703zo9hbi2OL4YyNWbAuxT/Yv0VfU/hdRrJ0U=;
        b=SXrUONA1Q5a6IyenJQWKaNT96eRvhbb7zgyihc9IS+eWOZC4SLXrkrSzlMhSMH8y3d
         LLJ7dz8h/qzi8grGJjamOAguFyQM/DNPYNHxmC7kk4RbLtCBv22jWDWWR/nj2ItSKbbG
         ZPneJ7TjuddJTKmRT281Ed630jlOY4xRpmeF907zGSIuKBBi2ygzZ+RZ9JlF/TjfczvG
         PeUgWYuDp8ecjFES1/Leg+hvsaHY2aQ3EHNJtRD3ql8p+Z/tF1r+WCXxtCBxSWo0LQS2
         JnENfxiR/o6/EHTTQcfsKmDc7oyO2M2poyY7r1IoNehKnk4PjABiiPzkYsOcXgr3vQbU
         Wi7g==
X-Gm-Message-State: APjAAAVbY8zLVH1VWRwpgUQQ2WNFdFq/tn1r05dNvS9GQwChoVgrmwax
        /m+LpxYPFvXjdMT4Jw6I3w2dKbyE
X-Google-Smtp-Source: APXvYqyhIdjaj4JsiOk81IFKW/7ghxCbYFtfC+qY4UWVmStXrPMQ3KMLa+vs6vQfQNNfb9fd/ma2kw==
X-Received: by 2002:a25:3609:: with SMTP id d9mr9176740yba.260.1556742396606;
        Wed, 01 May 2019 13:26:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id 12sm12597899yww.88.2019.05.01.13.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:26:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B030F4111F; Wed,  1 May 2019 16:26:34 -0400 (EDT)
Date:   Wed, 1 May 2019 16:26:34 -0400
To:     Thomas Backlund <tmb@mageia.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: perf build broken in 5.1-rc7
Message-ID: <20190501202634.GE21436@kernel.org>
References: <560abacf-da1d-7f55-755c-2086096bdf2c@mageia.org>
 <fff8c124-505c-91b7-ff4b-cabca894b689@mageia.org>
 <CAPhsuW7dS9TXOAW--U2q9-zmsgS4_K+uZYLnbPra+r+2LjJKDQ@mail.gmail.com>
 <b773df70-58e6-69f8-d566-282b0f7ae579@mageia.org>
 <20190501130751.GB21436@kernel.org>
 <932c4e06-c4db-7bb8-769d-75651d092450@mageia.org>
 <20190501173158.GC21436@kernel.org>
 <f9439dd5-009b-8930-f233-6826c7e7c076@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9439dd5-009b-8930-f233-6826c7e7c076@mageia.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 01, 2019 at 11:20:02PM +0300, Thomas Backlund escreveu:
> 
> Den 01-05-2019 kl. 20:31, skrev Arnaldo Carvalho de Melo:
> > Em Wed, May 01, 2019 at 05:09:59PM +0300, Thomas Backlund escreveu:
> > > Den 01-05-2019 kl. 16:07, skrev Arnaldo Carvalho de Melo:
> > > > Em Tue, Apr 30, 2019 at 04:31:14PM +0300, Thomas Backlund escreveu:
> > > > Can you check the output for
> > > > /tmp/build/perf/feature/test-disassembler-four-args.make.output in your
> > > > system? And also check what is the prototype for the disassembler()
> > > > routine on mageia7?
> > > I guess this is what fails the test:
> > > cat /tmp/build/perf/feature/test-disassembler-four-args.make.output
> > > /usr/bin/ld: /usr/lib64/libbfd.a(plugin.o): in function `try_load_plugin':
> > > /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:243:
> > > undefined reference to `dlopen'
> > > /usr/bin/ld:
> > > /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:271:
> > > undefined reference to `dlsym'
> > > /usr/bin/ld:
> > > /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:256:
> > > undefined reference to `dlclose'
> > > /usr/bin/ld:
> > > /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:246:
> > > undefined reference to `dlerror'
> > > as we allow dynamic linking and loading
> > > And we use linker flags:
> > > rpm --eval %ldflags
> > >   -Wl,--as-needed -Wl,--no-undefined -Wl,-z,relro -Wl,-O1 -Wl,--build-id
> > > -Wl,--enable-new-dtags
> > Would this help?
> > 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index fe3f97e342fa..6d65874e16c3 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -227,7 +227,7 @@ FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
> >   EATURE_CHECK_LDFLAGS-libaio = -lrt
> > -FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes
> > +FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
> >   CFLAGS += -fno-omit-frame-pointer
> >   CFLAGS += -ggdb3
> > 
> 
> Yeah, that fixes it
> 
> and /tmp/build/perf/feature/test-disassembler-four-args.make.output is now empty as wanted.
> 
> 
> So I guess:
> 
> Reported-by: Thomas Backlund <tmb@mageia.org>
> 
> Tested-by: Thomas Backlund <tmb@mageia.org>

Great, thanks for testing!

- Arnaldo
 
> 
> 
> Thanks!
> 
> 
> --
> 
> Thomas
> 

-- 

- Arnaldo
