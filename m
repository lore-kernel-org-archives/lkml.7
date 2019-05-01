Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A69C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8159B20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIZw2cJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfEARcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:32:02 -0400
Received: from mail-yw1-f53.google.com ([209.85.161.53]:33522 "EHLO
        mail-yw1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:32:02 -0400
Received: by mail-yw1-f53.google.com with SMTP id q11so8836967ywb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=y8s0ijs5pK7GyD3aubmLvTQxqI7m/6fliYiTiXFg8ns=;
        b=WIZw2cJaQ2aQ0+C0kHMcDmC5dYQIg43PN9XuFrxHcyh8RlI3+7jsE6jwvmX73MUu4U
         JSA3hB2C9torLjbjvbp89EGZFy6liURIdw6uIutl4YJeaRj7iMi55Txp7ejFylZLVW8K
         vclkl5LQNebvpvHWB8ceDUKbt7hwDKea5VT9JJD4K0wpjWt7SwUiezox/Vzb9QkBcuPv
         0CmRb8JPPt5Ixt4KepD082ngjJdeafhPAxohWtqR6Y3LcIrOP35onJ+J49RwlxnF9QEd
         5ybR/gfkrBLiDFlzX+djjXxgSvFA2Mld9kgvKAyQfbXmTY+Y4hFg9huKaKcUUsVme/dC
         c3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y8s0ijs5pK7GyD3aubmLvTQxqI7m/6fliYiTiXFg8ns=;
        b=FYsLGFw/4+7WnxjW9KuM6sTynkQNS1JEKOEef5ulUmzvxHWAzWd/4g/j2/n3OtB9og
         qOyKOyKnnx1xsbiDmSo8XpkZ8XZOi0WhYKSVbCW/O8CzQ/aA1cPT1ooK56h38m9lBRZt
         3FLFxyeZRaSnmAh6aGdXMCvgj+gRYXLJL023yMtkCcEizFX2kW0PdbiFOVHXF0U6ognp
         wimMqAnVyHvfpdMiB9x/g1lWHXDNLFXDilhRVI7Q9RuUDx/vQiN7tXQgvxbRHgJC5dC9
         Pyxp8Wsuc+JXPuRyRocNIb/YE+/hEmicDnPE3t93DDbPribt6DEHaytVJb0GVDcXEsZo
         i+nw==
X-Gm-Message-State: APjAAAVbf/rxMw1td8ilGtBTJLhbpF/eiVszD69SVu8ByrLDmq7gO1BI
        455PIjUtX8du/oo5yASLz+tRpIet
X-Google-Smtp-Source: APXvYqzW+A7RggX5v0o2m4cwEo61mPhoJq4vEPnDXZJW4gyzVSQqf6tQu1YNeYkwm0rB5RS3zzdM8Q==
X-Received: by 2002:a25:3758:: with SMTP id e85mr40210396yba.35.1556731920922;
        Wed, 01 May 2019 10:32:00 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id i13sm6780578ywl.22.2019.05.01.10.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 10:31:59 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C1B3A4111F; Wed,  1 May 2019 13:31:58 -0400 (EDT)
Date:   Wed, 1 May 2019 13:31:58 -0400
To:     Thomas Backlund <tmb@mageia.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: perf build broken in 5.1-rc7
Message-ID: <20190501173158.GC21436@kernel.org>
References: <560abacf-da1d-7f55-755c-2086096bdf2c@mageia.org>
 <fff8c124-505c-91b7-ff4b-cabca894b689@mageia.org>
 <CAPhsuW7dS9TXOAW--U2q9-zmsgS4_K+uZYLnbPra+r+2LjJKDQ@mail.gmail.com>
 <b773df70-58e6-69f8-d566-282b0f7ae579@mageia.org>
 <20190501130751.GB21436@kernel.org>
 <932c4e06-c4db-7bb8-769d-75651d092450@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <932c4e06-c4db-7bb8-769d-75651d092450@mageia.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 01, 2019 at 05:09:59PM +0300, Thomas Backlund escreveu:
> 
> Den 01-05-2019 kl. 16:07, skrev Arnaldo Carvalho de Melo:
> > Em Tue, Apr 30, 2019 at 04:31:14PM +0300, Thomas Backlund escreveu:
> > Can you check the output for
> > /tmp/build/perf/feature/test-disassembler-four-args.make.output in your
> > system? And also check what is the prototype for the disassembler()
> > routine on mageia7?
> 
> I guess this is what fails the test:
 
> cat /tmp/build/perf/feature/test-disassembler-four-args.make.output
> /usr/bin/ld: /usr/lib64/libbfd.a(plugin.o): in function `try_load_plugin':
> /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:243:
> undefined reference to `dlopen'
> /usr/bin/ld:
> /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:271:
> undefined reference to `dlsym'
> /usr/bin/ld:
> /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:256:
> undefined reference to `dlclose'
> /usr/bin/ld:
> /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:246:
> undefined reference to `dlerror'
 
> as we allow dynamic linking and loading
 
> And we use linker flags:
 
> rpm --eval %ldflags
>  -Wl,--as-needed -Wl,--no-undefined -Wl,-z,relro -Wl,-O1 -Wl,--build-id
> -Wl,--enable-new-dtags

Would this help?

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fe3f97e342fa..6d65874e16c3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -227,7 +227,7 @@ FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
 EATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes
+FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
 
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3

